from __future__ import division

__author__ = 'Steve'

try:
    import MySQLdb as mdb
except ImportError:
    import pymysql as mdb
import time
import sys
import hashlib
from datetime import datetime
from pytz import timezone
import os
import re

reload(sys)
sys.setdefaultencoding("utf-8")

TRANSACTION_TABLE = "transaction"
BALANCE_TABLE = "balance"
TRANS_DETAIL_TABLE = "trans_detail"
USER_TABLE = "users"
GROUPS_TABLE = 'groups'
LINE_SEPARATOR = "----"
TRANS_TYPE_BUY = 'buy'
TRANS_TYPE_PAY = 'pay'
TRANS_TYPE_BUY_CANCELLED = 'buy_cancelled'


class Transaction:
    def __init__(self, owner, amount, date, message, who, type1, ):
        self.owner = owner
        self.amount = amount
        self.date = re.escape(date)
        self.message = re.escape(message)
        # if type ==pay, its just a name, if type == buy, its a tuple list
        self.who = who
        self.type = type1
        self.ts = get_timestamp()
        if type1 == TRANS_TYPE_BUY:
            sum1 = 0
            cnt = 0
            str1 = LINE_SEPARATOR + " shared with "
            for u in self.who:
                sum1 += u[1]
                if cnt > 0:
                    str1 += ","
                str1 += u[2]
                if u[1] > 1:
                    str1 += "*" + str(u[1])
                cnt += 1
            self.amount_per_unit = self.amount / sum1
            self.message += str1


def conn():
    if 'SERVER_SOFTWARE' in os.environ:
        # for SAE
        from sae.const import (MYSQL_HOST, MYSQL_HOST_S, MYSQL_PORT, MYSQL_USER, MYSQL_PASS, MYSQL_DB)

        con1 = mdb.connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB, port=int(MYSQL_PORT))
    else:
        # for local
        from local import *

        print "connecting local mysql"

        con1 = mdb.connect(host=LOCAL_HOST, user=LOCAL_USERNAME, passwd=LOCAL_PASSWD, db=LOCAL_DB_NAME, port=LOCAL_PORT)
    return con1


def execute_select_one(con, sql):
    cursor = con.cursor()
    cursor.execute(sql)
    result = cursor.fetchone()
    return result


def execute_select_all(con, sql):
    cursor = con.cursor()
    cursor.execute(sql)
    result = cursor.fetchall()
    return result


def execute_non_query(con, sql):
    cursor = con.cursor()
    cursor.execute(sql)
    con.commit()


def get_timestamp():
    return long(time.time() * 100)


def get_all_transaction(con, group_id=None, username=None):
    if group_id is None:
        sql = "select * from {0} order by id desc".format(TRANSACTION_TABLE)
    elif group_id == 0:
        sql = "select * from {0} where username='{1}' order by id desc".format(TRANSACTION_TABLE, username)
    else:
        sql = "select * from {0} where username in (select username from users where group_id={1}) order by id desc".format(
            TRANSACTION_TABLE, group_id)
    rows = execute_select_all(con, sql)
    dic1 = get_all_normal_user_info(con)
    lists = [list(row) for row in rows]
    # append screen name to the result tuple
    for row in lists:
        row.append(dic1[row[1]])
    return lists


def save_transaction(con, trans, username):
    sql = "insert into transaction values({0} ,  '{1}' , '{2}' , '{3}' ,  {4} , '{5}')".format(trans.ts, username,
                                                                                               trans.type,
                                                                                               trans.message,
                                                                                               trans.amount,
                                                                                               trans.date)
    execute_non_query(con, sql)
    if trans.type == TRANS_TYPE_BUY:
        for u in trans.who:
            debtor = u[0]
            cnt = u[1]
            indi_amount = trans.amount_per_unit * cnt
            add_trans_detail(con, trans.ts, debtor, indi_amount)
            if debtor == username:
                continue
            change_balance(con, debtor, username, indi_amount, trans.ts)
    elif trans.type == TRANS_TYPE_PAY:
        change_balance(con, trans.who, username, trans.amount, trans.ts)
    print "transaction saved"


# money goes to creditor
# 1. debtor active pay
# 2. debtor passive pay (debtor buy sth)
def change_balance(con, creditor, debtor, amount, trans_id):
    current = get_balance(con, creditor, debtor)
    current2 = get_balance(con, debtor, creditor)
    creditor_name = get_screen_name(con, creditor)
    debtor_name = get_screen_name(con, debtor)
    print ""
    print debtor, "paid $", amount, "to", creditor
    if current == 0:
        remain = current2 + amount
        update_balance(con, debtor, creditor, remain)
        msg = "{0} owe {1} from ${2:.2f} to ${3:.2f}".format(creditor_name, debtor_name, current2, remain)
        print creditor, "owe", debtor, "from $", current2, "to $", remain
    elif current >= amount:
        remain = current - amount
        update_balance(con, creditor, debtor, remain)
        msg = "{0} owe {1} from ${2:.2f} to ${3:.2f}".format(debtor_name, creditor_name, current, remain)
        print debtor, "owe", creditor, "from $", current, "to $", remain
    else:
        remain = amount - current
        update_balance(con, creditor, debtor, 0)
        update_balance(con, debtor, creditor, remain)
        msg = "{0} owe {1} from ${2:.2f} to ${3:.2f}".format(creditor_name, debtor_name, -current, remain)
        print creditor, "owe", debtor, "from $", -current, "to $", remain
    append_transaction_message(con, trans_id, msg)


def update_balance(con, creditor, debtor, amount):
    sql = "update balance set amount={0} where creditor='{1}' and debtor='{2}'".format(amount, creditor, debtor)
    execute_non_query(con, sql)
    print "update balance", creditor, debtor, amount


def user_authentication(con, username, password):
    pw_hash = generate_password_hash(password)
    es_username = re.escape(username)
    # underscore will cause problem for username
    sql = "select screen_name,group_id,type from users where username='{0}' and password='{1}' ".format(es_username,
                                                                                                        pw_hash)
    result = execute_select_one(con, sql)
    return result


# only return username
def get_all_normal_users(con, group_id=None):
    if group_id == None:
        sql = "SELECT username from {0} where type='normal'".format(USER_TABLE)
    else:
        sql = "SELECT username from {0} where type='normal' and group_id={1}".format(USER_TABLE, group_id)
    result = execute_select_all(con, sql)
    array = []
    for i in result:
        array.append(i[0])
    return array


def get_all_normal_user_info(con, group_id=None, username=None):
    if group_id == None:
        sql = "SELECT username,screen_name from {0} where type='normal'".format(USER_TABLE)
    elif group_id == 0:
        sql = "SELECT username,screen_name from {0} where username='{1}'".format(USER_TABLE, username)
        print sql
    else:
        sql = "SELECT username,screen_name from {0} where type='normal' and group_id={1}".format(USER_TABLE, group_id)
    result = execute_select_all(con, sql)
    dic1 = {}
    for row in result:
        dic1[row[0]] = row[1]
    return dic1


def get_creditor_debtor_list(con, group_id=None):
    users = get_all_normal_users(con, group_id)
    list1 = []
    dic1 = get_all_normal_user_info(con, group_id)
    for u in users:
        if group_id == None:
            sql = "select creditor,amount from balance where debtor='{0}'".format(u)
        else:
            sql = "select creditor,amount from balance where debtor='{0}' and creditor in (select username from users where group_id={1})".format(
                u, group_id)
        result = execute_select_all(con, sql)
        result2 = [list(row) for row in result]
        for row in result2:
            row.append(dic1[row[0]])
        tuple1 = (u, result2, dic1[u])
        list1.append(tuple1)
    return list1


def get_balance(con, creditor, debtor):
    sql = "select amount from  balance where creditor ='{0}' and debtor='{1}'".format(creditor, debtor)
    result = execute_select_one(con, sql)
    return result[0]


def append_transaction_message(con, trans_id, message):
    message = LINE_SEPARATOR + message
    sql = "update transaction set message=concat(message,'{0}') where id={1}".format(message, trans_id)
    execute_non_query(con, sql)


def is_user_exist(con, user_name):
    sql = "select username from users WHERE username='{0}'".format(user_name)
    result = execute_select_one(con, sql)
    if result is None:
        return False
    else:
        return True


def add_user(con, user_name, password, screen_name):
    pw_hash = generate_password_hash(password)
    sql = "insert into users (username,password,screen_name,type) values ('{0}','{1}','{2}','normal')".format(user_name,
                                                                                                              pw_hash,
                                                                                                              screen_name)
    execute_non_query(con, sql)
    # add_newuser_balance(con, user_name)


def add_newuser_balance(con, group_id, user_name):
    sql = "select username from users WHERE type='normal' and username!='{0}'and group_id={1}".format(user_name,
                                                                                                      group_id)
    result = execute_select_all(con, sql)
    for row in result:
        sql1 = "insert into balance VALUES ('{0}','{1}',0)".format(user_name, row[0])
        sql2 = "insert into balance VALUES ('{0}','{1}',0)".format(row[0], user_name)
        execute_non_query(con, sql1)
        execute_non_query(con, sql2)


def get_screen_name(con, username):
    sql = "select screen_name from {0} where username='{1}'".format(USER_TABLE, username)
    result = execute_select_one(con, sql)
    name = result[0]
    return name


def change_screen_name(con, username, newscreenname):
    es_newscreenname = re.escape(newscreenname)
    sql = "update users set screen_name='{0}' where username='{1}'".format(es_newscreenname, username)
    execute_non_query(con, sql)


def change_password(con, username, newpassword):
    pw_hash = generate_password_hash(newpassword)
    sql = "update users set password='{0}' where username='{1}'".format(pw_hash, username)
    execute_non_query(con, sql)


def generate_password_hash(plaintext):
    salt = "8eF%o_G!v(2X~NrItkJq"
    m = hashlib.md5()
    m.update(salt + plaintext)
    return m.hexdigest()


def create_group(con, group_name, holder):
    es_group_name = re.escape(group_name)
    sql = "insert into {2} (name,holder) values ('{0}','{1}')".format(es_group_name, holder, GROUPS_TABLE)
    execute_non_query(con, sql)
    group_id = get_group_id(con, es_group_name)
    update_user_group(con, holder, group_id)
    return group_id


def get_group_id(con, name):
    es_name = re.escape(name)
    sql = "select id from {1} where name='{0}'".format(es_name, GROUPS_TABLE)
    group_id = execute_select_one(con, sql)
    if group_id:
        return group_id[0]
    return None


def join_group(con, groupname, username):
    group_id = get_group_id(con, groupname)
    update_user_group(con, username, group_id)
    add_newuser_balance(con, group_id, username)


def leave_group(con, username):
    update_user_group(con, username, 0)
    delete_balance(con, username)


def delete_balance(con, username):
    sql = "delete from balance where creditor='{0}' or debtor='{0}'".format(username)
    execute_non_query(con, sql)


def delete_group(con, username, group_id=None, group_name=None):
    if group_id != None:
        sql = "delete from {1} where id={0}".format(group_id, GROUPS_TABLE)
    else:
        sql = "delete from {1} where name='{0}'".format(group_name, GROUPS_TABLE)
    execute_non_query(con, sql)
    update_user_group(con, username, 0)


def get_holder(con, group_id):
    sql = "select holder from {1} where id={0}".format(group_id, GROUPS_TABLE)
    result = execute_select_one(con, sql)
    return result[0]


def get_group_size(con, group_id):
    sql = "select count(*) from users where group_id={0}".format(group_id)
    size = execute_select_one(con, sql)
    return size[0]


def is_groupname_exist(con, group_name):
    es_group_name = re.escape(group_name)
    sql = "select name from {1} WHERE name='{0}'".format(es_group_name, GROUPS_TABLE)
    result = execute_select_one(con, sql)
    if result == None:
        return False
    else:
        return True


def check_balance(con, username):
    sql = "select sum(amount) from balance WHERE debtor='{0}' or creditor='{0}'".format(username)
    result = execute_select_one(con, sql)
    return result[0]


def get_now_time():
    now = datetime.now(timezone('US/Arizona'))
    return now


def update_user_group(con, username, new_groupid):
    sql = "update users set group_id={0} where username='{1}'".format(new_groupid, username)
    execute_non_query(con, sql)


def delete_user(con, username):
    sql = "delete from {0} where username='{1}'".format(USER_TABLE, username)
    execute_non_query(con, sql)


def add_trans_detail(con, ts, debtor, indi_amount):
    sql = "insert into trans_detail ( trans_id,debtor,amount) values({0},'{1}',{2})".format(ts, debtor, indi_amount)
    execute_non_query(con, sql)


def get_trans_owner(con, trans_id):
    sql = "select username from {0} where id={1}".format(TRANSACTION_TABLE, trans_id)
    result = execute_select_one(con, sql)
    return result[0]


def get_trans_detail_list(con, trans_id, owner):
    sql = "select debtor,amount from {0} where trans_id={1} and debtor!='{2}'".format(TRANS_DETAIL_TABLE, trans_id,
                                                                                      owner)
    result = execute_select_all(con, sql)
    lists = [list(row) for row in result]
    return lists


def update_trans_type(con, trans_id, trans_type):
    sql = "update {0} set type='{1}' where id={2}".format(TRANSACTION_TABLE, trans_type, trans_id)
    execute_non_query(con, sql)


def cancel_transaction(con, trans_id):
    owner = get_trans_owner(con, trans_id)
    debtor_list = get_trans_detail_list(con, trans_id, owner)
    for d in debtor_list:
        change_balance(con, owner, d[0], d[1], trans_id)
    update_trans_type(con, trans_id, TRANS_TYPE_BUY_CANCELLED)


def get_all_groups(con):
    sql = "select name from {0}".format(GROUPS_TABLE)
    result = execute_select_all(con, sql)
    list = [row[0] for row in result]
    return list


if __name__ == "__main__":
    # con = conn()
    # cursor = con.cursor()
    print generate_password_hash("sadf3ads2fdsa")
    # sql = "select username,password from users"
    # cursor.execute(sql)
    # result = cursor.fetchall()
    # for e in result:
    # print e, generate_password_hash(e[1])
    # sql = "update users set password='{0}' where username='{1}'".format(generate_password_hash(e[1]), e[0])
    # cursor.execute(sql)
    # con.commit()

__author__ = 'Steve'

import MySQLdb as mdb

TRANSACTION_TABLE = "transaction"
BALANCE_TABLE = "balance"
TRANS_DETAIL_TABLE = "trans_detail"


def conn():
    con = mdb.connect(host="localhost", user="root", passwd="", db="lily")
    return con


def get_all_transaction(con):
    cursor = con.cursor()
    sql = "select * from {0}".format(TRANSACTION_TABLE)
    cursor.execute(sql)
    rows = cursor.fetchall()
    return rows


if __name__ == "__main__":
    con = conn()
    get_all_transaction(con)
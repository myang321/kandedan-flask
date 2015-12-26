from flask import Flask, render_template, redirect, request, session, url_for, g, flash
import database_setup as db

app = Flask(__name__)
app.debug = True
app.secret_key = 'F12Zr47j3yXR~X@H!jmM]Lwf/,?KT'

SESSION_NAME = 'name'
SESSION_SCREEN_NAME = 'screen_name'
SESSION_GROUP_ID = 'group_id'
SESSION_USER_TYPE = 'user_type'
SESSION_GROUP_NAME = 'group_name'

USER_TYPE_SUPER = 'super'
USER_TYPE_NORMAL = 'normal'


@app.before_request
def before_request():
    g.db = db.conn()


@app.teardown_request
def teardown_request(exception):
    if hasattr(g, 'db'):
        g.db.close()


@app.route('/', methods=['GET', 'POST'])
def login():
    if session.get(SESSION_NAME):
        return redirect(url_for('main'))
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        result = db.user_authentication(g.db, username, password)
        if result is not None:
            session[SESSION_NAME] = username
            session[SESSION_SCREEN_NAME] = result[0]
            session[SESSION_GROUP_ID] = result[1]
            session[SESSION_USER_TYPE] = result[2]
            session[SESSION_GROUP_NAME] = db.get_group_name(g.db, username)
            return redirect(url_for('main'))
        else:
            flash("username or password not correct")
            print "login failed"
            return render_template('login.html')
    else:
        return render_template('login.html')


@app.route('/main')
def main():
    if not session.get(SESSION_NAME):
        return redirect(url_for('login'))
    rows1 = db.get_all_transaction(g.db, session.get(SESSION_GROUP_ID), session.get(SESSION_NAME))
    list1 = None
    not_in_group_msg = None
    if session[SESSION_GROUP_ID] != 0:
        list1 = db.get_creditor_debtor_list(g.db, session[SESSION_GROUP_ID])
    else:
        not_in_group_msg = "You are not in any group, please create or join a group in Setting page."
    return render_template('main.html', rows=rows1, list=list1, not_in_group_msg=not_in_group_msg)


# add transaction
@app.route('/add', methods=['GET', 'POST'])
def add():
    now = db.get_now_time()
    now = now.strftime("%Y-%m-%d")
    if not session.get(SESSION_NAME):
        return redirect(url_for('login'))
    if request.method == 'POST':
        amount = float(request.form['amount'])
        date = request.form['date']
        msg = request.form['msg']
        who = request.form.getlist('who')
        who_tuple_list = []
        dic1 = db.get_all_normal_user_info(g.db, session.get(SESSION_GROUP_ID), session.get(SESSION_NAME))
        print "add", dic1
        for u in who:
            cnt = int(request.form['cnt' + u])
            tuple1 = (u, cnt, dic1[u])
            who_tuple_list.append(tuple1)
        trans = db.Transaction(session[SESSION_NAME], amount, date, msg, who_tuple_list, "buy")
        db.save_transaction(g.db, trans, session.get(SESSION_NAME), session.get(SESSION_GROUP_ID))
        return redirect(url_for('main'))
    else:
        dic = db.get_all_normal_user_info(g.db, session.get('group_id'), session.get('name'))
        return render_template('add.html', dic=dic, now=now)


@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))


@app.route('/pay', methods=['GET', 'POST'])
def pay():
    if not session.get(SESSION_NAME):
        return redirect(url_for('login'))
    if request.method == 'POST':
        try:
            pay_value = float(request.form['pay_value'])
        except ValueError:
            return redirect(url_for('main'))
        pay_to = request.form['pay_to']
        now = db.get_now_time().strftime("%Y-%m-%d %H:%M")
        trans = db.Transaction(session[SESSION_NAME], amount=pay_value, date=now, message="", who=pay_to,
                               type1="pay")
        db.save_transaction(g.db, trans, session.get(SESSION_NAME), session.get(SESSION_GROUP_ID))
        return redirect(url_for('main'))
    else:
        pay_to = request.args.get('pay_to')
        amount = db.get_balance(g.db, pay_to, session.get(SESSION_NAME))
        pay_to_name = db.get_screen_name(g.db, pay_to)
        return render_template('pay.html', pay_to=pay_to, amount=amount, pay_to_name=pay_to_name)


@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        screen_name = request.form['screenname']
        if db.is_user_exist(g.db, username):
            flash("this user name has been used")
            return render_template('signUp.html')

        else:
            flash("sign up successfully")
            db.add_user(g.db, username, password, screen_name)
        return redirect(url_for('login'))
    else:
        return render_template('signUp.html')


@app.route('/setting', methods=['GET', 'POST'])
def setting():
    if not session.get(SESSION_NAME):
        return redirect(url_for('login'))
    if request.method == 'POST':
        pass
    else:
        return render_template('setting.html')


@app.route('/setting/change_screenname', methods=['GET', 'POST'])
def setting_change_screenname():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        username = session.get('name')
        newscreenname = request.form['screenname']
        db.change_screen_name(g.db, username, newscreenname)
        session[SESSION_SCREEN_NAME] = newscreenname
        flash("screen name change successfully")
        return render_template("setting_change_screenname.html")
    else:
        return render_template('setting_change_screenname.html')


@app.route('/setting/change_password', methods=['GET', 'POST'])
def setting_change_password():
    if not session.get(SESSION_NAME):
        return redirect(url_for('login'))
    if request.method == 'POST':
        username = session.get(SESSION_NAME)
        old_password = request.form['old_password']
        new_password = request.form['new_password']
        if db.user_authentication(g.db, username, old_password):
            db.change_password(g.db, username, new_password)
            flash("password change successfully")
        else:
            flash("wrong password")
        return render_template("setting_change_password.html")
    else:
        return render_template('setting_change_password.html')


@app.route('/setting/create_group', methods=['GET', 'POST'])
def create_group():
    if not session.get(SESSION_NAME):
        return redirect(url_for('login'))
    if request.method == 'POST':
        holder = session.get(SESSION_NAME)
        group_name = request.form['group_name']
        if not db.is_groupname_exist(g.db, group_name):
            session[SESSION_GROUP_ID] = db.create_group(g.db, group_name, holder)
            session[SESSION_GROUP_NAME] = db.get_group_name(g.db, session.get(SESSION_NAME))
            message = "group create successfully"
        else:
            message = "group name has been used"
        return render_template("create_group.html", message=message)
    else:
        return render_template("create_group.html")


@app.route('/setting/join_group', methods=['GET', 'POST'])
def join_group():
    if not session.get(SESSION_NAME):
        return redirect(url_for('login'))
    if request.method == 'POST':
        username = session.get(SESSION_NAME)
        group_name = request.form['group_name']
        if db.is_groupname_exist(g.db, group_name):
            db.join_group(g.db, group_name, username)
            session[SESSION_GROUP_ID] = db.get_group_id(g.db, group_name)
            session[SESSION_GROUP_NAME] = db.get_group_name(g.db, session.get(SESSION_NAME))
            message = "join group successfully"
        else:
            message = "group name does not exist"
        return render_template("join_group.html", message=message)
    else:
        return render_template("join_group.html")


@app.route('/setting/leave_group', methods=['GET', 'POST'])
def leave_group():
    if not session.get(SESSION_NAME):
        return redirect(url_for('login'))
    if request.method == 'POST':
        username = session.get(SESSION_NAME)
        db.leave_group(g.db, username)
        session[SESSION_GROUP_ID] = 0
        message = "you have leaved this group"
        return render_template("leave_group.html", message=message)
    else:
        message = None
        if session.get(SESSION_GROUP_ID) == 0:
            message = "you don't belong to any group"
        elif session.get(SESSION_NAME) == db.get_holder(g.db, session.get(SESSION_GROUP_ID)):
            message = "you are the holder, you can not leave a group,but you can delete group"
        elif db.check_balance(g.db, session.get(SESSION_NAME)) > 0:
            message = "your balance is not 0, you cannot leave the group now"
        return render_template("leave_group.html", message=message)


@app.route('/setting/delete_group', methods=['GET', 'POST'])
def delete_group():
    if not session.get(SESSION_NAME):
        return redirect(url_for('login'))
    if request.method == 'POST':
        groupid = session.get(SESSION_GROUP_ID)
        username = session.get(SESSION_NAME)
        db.delete_group(g.db, username=username, group_id=groupid)
        session[SESSION_GROUP_ID] = 0
        message = "you have already delete this group"
        return render_template("delete_group.html", message=message)

    else:
        message = None
        if session.get(SESSION_GROUP_ID) == 0:
            message = "you don't belong to any group"
        elif session.get(SESSION_NAME) != db.get_holder(g.db, session.get(SESSION_GROUP_ID)):
            message = "you are not the holder, you can not delete group"
        elif db.get_group_size(g.db, session.get(SESSION_GROUP_ID)) > 1:
            message = "your group has other people, you can not delete"
        return render_template("delete_group.html", message=message)


@app.route('/admin', methods=['GET'])
def admin():
    if not session.get(SESSION_NAME) or session.get(SESSION_USER_TYPE) != USER_TYPE_SUPER:
        return redirect(url_for('login'))
    group_name = request.args.get('group_name')
    if group_name:
        return redirect(url_for('admin_group', group_name=group_name))
    else:
        groups = db.get_all_groups(g.db)
        return render_template('admin.html', groups=groups)


@app.route('/admin/group/<group_name>', methods=['GET'])
def admin_group(group_name):
    if not session.get(SESSION_NAME) or session.get(SESSION_USER_TYPE) != USER_TYPE_SUPER:
        return redirect(url_for('login'))
    group_id = db.get_group_id(g.db, group_name)
    if group_id:
        rows = db.get_all_transaction(g.db, group_id)
        return render_template('admin_group.html', is_admin=True, rows=rows, group_name=group_name)
    else:
        return redirect(url_for('admin'))


@app.route('/cancel_transaction', methods=['POST'])
def cancel_transaction():
    if not session.get(SESSION_NAME):
        return redirect(url_for('login'))
    trans_id = request.form.get('trans_id')
    group_name = request.form.get('group_name')
    db.cancel_transaction(g.db, trans_id)
    return redirect(url_for('admin_group', group_name=group_name))


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404


if __name__ == '__main__':
    app.run()

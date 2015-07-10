from flask import Flask, render_template, redirect, request, session, url_for, g, flash
import database_setup as db

app = Flask(__name__)
app.debug = True
app.secret_key = 'F12Zr47j3yXR~X@H!jmM]Lwf/,?KT'


@app.before_request
def before_request():
    g.db = db.conn()


@app.teardown_request
def teardown_request(exception):
    if hasattr(g, 'db'):
        g.db.close()


@app.route('/', methods=['GET', 'POST'])
def login():
    if session.get('name'):
        return redirect(url_for('main'))
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        result = db.user_authentication(g.db, username, password)
        if result != None:
            session['name'] = username
            session['screen_name'] = result[0]
            session['group_id'] = result[1]
            return redirect(url_for('main'))
        else:
            flash("username or password not correct")
            print "login failed"
            return render_template('login.html')
    else:
        return render_template('login.html')


@app.route('/main/')
def main():
    if not session.get('name'):
        return redirect(url_for('login'))
    rows1 = db.get_all_transaction(g.db, session.get('group_id'), session.get('name'))
    list1 = None
    not_in_group_msg = None
    if session['group_id'] != 0:
        list1 = db.get_creditor_debtor_list(g.db, session['group_id'])
    else:
        not_in_group_msg = "You are not in any group, please create or join a group in Setting page."
    return render_template('main.html', rows=rows1, list=list1, not_in_group_msg=not_in_group_msg)


# add transaction
@app.route('/add/', methods=['GET', 'POST'])
def add():
    now = db.get_now_time()
    now = now.strftime("%Y-%m-%d")
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        amount = float(request.form['amount'])
        date = request.form['date']
        msg = request.form['msg']
        who = request.form.getlist('who')
        who_tuple_list = []
        dic1 = db.get_all_normal_user_info(g.db, session.get('group_id'), session.get('name'))
        print "add", dic1
        for u in who:
            cnt = int(request.form['cnt' + u])
            tuple1 = (u, cnt, dic1[u])
            who_tuple_list.append(tuple1)
        trans = db.Transaction(session['name'], amount, date, msg, who_tuple_list, "buy")
        db.save_transaction(g.db, trans, session.get('name'))
        return redirect(url_for('main'))
    else:
        dic = db.get_all_normal_user_info(g.db, session.get('group_id'), session.get('name'))
        return render_template('add.html', dic=dic, now=now)


@app.route('/logout/')
def logout():
    session.clear()
    return redirect(url_for('login'))


@app.route('/pay/', methods=['GET', 'POST'])
def pay():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        try:
            pay_value = float(request.form['pay_value'])
        except ValueError:
            return redirect(url_for('main'))
        pay_to = request.form['pay_to']
        now = db.get_now_time()
        trans = db.Transaction(session['name'], amount=pay_value, date=str(now), message="", who=pay_to,
                               type1="pay")
        db.save_transaction(g.db, trans, session.get('name'))
        return redirect(url_for('main'))
    else:
        pay_to = request.args.get('pay_to')
        amount = db.get_balance(g.db, pay_to, session.get('name'))
        pay_to_name = db.get_screen_name(g.db, pay_to)
        return render_template('pay.html', pay_to=pay_to, amount=amount, pay_to_name=pay_to_name)


@app.route('/signup/', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        print "in signup post"
        username = request.form['username']
        password = request.form['password']
        screen_name = request.form['screenname']
        if db.is_user_exist(g.db, username) == True:
            flash("this user name has been used")
            return render_template('signUp.html')

        else:
            flash("sign up successfully")
            db.add_user(g.db, username, password, screen_name)
        return redirect(url_for('login'))
    else:
        return render_template('signUp.html')


@app.route('/setting/', methods=['GET', 'POST'])
def setting():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        pass
    else:
        return render_template('setting.html')


@app.route('/setting/change_screenname/', methods=['GET', 'POST'])
def setting_change_screenname():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        username = session.get('name')
        newscreenname = request.form['screenname']
        db.change_screen_name(g.db, username, newscreenname)
        session["screen_name"] = newscreenname
        flash("screen name change successfully")
        return render_template("setting_change_screenname.html")
    else:
        return render_template('setting_change_screenname.html')


@app.route('/setting/change_password/', methods=['GET', 'POST'])
def setting_change_password():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        username = session.get('name')
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


@app.route('/setting/create_group/', methods=['GET', 'POST'])
def create_group():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        holder = session.get('name')
        group_name = request.form['group_name']
        if not db.is_groupname_exist(g.db, group_name):
            session['group_id'] = db.create_group(g.db, group_name, holder)
            message = "group create successfully"
        else:
            message = "group_name has been used"
        return render_template("create_group.html", message=message)
    else:
        return render_template("create_group.html")


@app.route('/setting/join_group/', methods=['GET', 'POST'])
def join_group():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        username = session.get('name')
        group_name = request.form['group_name']
        if db.is_groupname_exist(g.db, group_name) == True:
            db.join_group(g.db, group_name, username)
            session['group_id'] = db.get_group_id(g.db, group_name)
            message = "join group successfully"
        else:
            message = "group_name does not exist"
        return render_template("join_group.html", message=message)
    else:
        return render_template("join_group.html")


@app.route('/setting/leave_group/', methods=['GET', 'POST'])
def leave_group():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        username = session.get('name')
        db.leave_group(g.db, username)
        session['group_id'] = 0
        message = "you have leaved this group"
        return render_template("leave_group.html", message=message)
    else:
        message = None
        if session.get('group_id') == 0:
            message = "you don't belong to any group"
        elif session.get('name') == db.get_holder(g.db, session.get('group_id')):
            message = "you are the holder, you can not leave a group,but you can delete group"
        elif db.check_balance(g.db, session.get('name')) > 0:
            message = "your balance is not 0, you cannot leave the group now"
        return render_template("leave_group.html", message=message)


@app.route('/setting/delete_group/', methods=['GET', 'POST'])
def delete_group():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        groupid = session.get('group_id')
        username = session.get('name')
        db.delete_group(g.db, username, groupid)
        session['group_id'] = 0
        message = "you have already delete this group"
        return render_template("delete_group.html", message=message)

    else:
        message = None
        if session.get('group_id') == 0:
            message = "you don't belong to any group"
        elif session.get('name') != db.get_holder(g.db, session.get('group_id')):
            message = "you are not the holder, you can not delete group"
        elif db.get_group_size(g.db, session.get('group_id')) > 1:
            message = "your group has other people, you can not delete"
        return render_template("delete_group.html", message=message)


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404


if __name__ == '__main__':
    app.run()


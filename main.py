from flask import Flask, render_template, redirect, request, session, url_for, g, flash
import database_setup as db
import datetime

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
    rows1 = db.get_all_transaction(g.db, session['group_id'])
    list1 = db.get_creditor_debtor_list(g.db, session['group_id'])
    return render_template('main.html', rows=rows1, list=list1)


# add transaction
@app.route('/add/', methods=['GET', 'POST'])
def add():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        amount = float(request.form['amount'])
        date = request.form['date']
        msg = request.form['msg']
        who = request.form.getlist('who')
        who_tuple_list = []
        dic1 = db.get_all_normal_user_info(g.db, session['group_id'])
        for u in who:
            cnt = int(request.form['cnt' + u])
            tuple1 = (u, cnt, dic1[u])
            who_tuple_list.append(tuple1)
        trans = db.Transaction(session['name'], amount, date, msg, who_tuple_list, "buy")
        db.save_transaction(g.db, trans, session.get('name'))
        return redirect(url_for('main'))
    else:
        dic = db.get_all_normal_user_info(g.db, session['group_id'])
        return render_template('add.html', dic=dic)


@app.route('/logout/')
def logout():
    session.clear()
    return redirect(url_for('login'))


@app.route('/pay/', methods=['GET', 'POST'])
def pay():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        if not request.form['pay_value'].isnumeric():
            return render_template('main.html')
        pay_value = float(request.form['pay_value'])
        pay_to = request.form['pay_to']
        now = datetime.datetime.now()
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
        if db.is_user_exist(g.db,username)==True:
            flash("this user name has been used")
            return render_template('signUp.html')

        else:
            flash("sign up successfully")
            db.add_user(g.db, username, password, screen_name)
        return redirect(url_for('login'))
    else:
        return render_template('signUp.html')


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404


if __name__ == '__main__':
    app.run()


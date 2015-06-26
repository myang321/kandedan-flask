from flask import Flask, render_template, redirect, request, session, url_for, g
import database_setup as db
import datetime
import sae_setup

app = Flask(__name__)
app.debug = True
app.secret_key = 'F12Zr47j3yXR~X@H!jmM]Lwf/,?KT'


@app.before_request
def before_request():
    SAE = 0
    if SAE == 0:
        # for local
        g.db = db.conn()
    else:
        # for SAE
        g.db = sae_setup.sae_conn()


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
        if db.user_authentication(g.db, username, password) != None:
            session['name'] = username
            return redirect(url_for('main'))
        else:
            return render_template('login.html')
    else:
        return render_template('login.html')


@app.route('/main/')
def main():
    if not session.get('name'):
        return redirect(url_for('login'))
    rows1 = db.get_all_transaction(g.db)
    list1 = db.get_creditor_debtor_list(g.db)
    return render_template('main.html', rows=rows1, list=list1)


@app.route('/add/', methods=['GET', 'POST'])
def add():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        amount = float(request.form['amount'])
        date = request.form['date']
        msg = request.form['msg']
        who = request.form.getlist('who')
        print amount, date, msg, who
        trans = db.Transaction(session['name'], amount, date, msg, who, "buy")
        db.save_transaction(g.db, trans, session.get('name'))
        return redirect(url_for('main'))
    else:
        return render_template('add.html')


@app.route('/logout/')
def logout():
    session.clear()
    return redirect(url_for('login'))


@app.route('/pay/', methods=['GET', 'POST'])
def pay():
    if not session.get('name'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        pay_value = float(request.form['pay_value'])
        pay_to = request.form['pay_to']
        now = datetime.datetime.now()
        trans = db.Transaction(session['name'], amount=pay_value, date=str(now), message="", who=pay_to, type1="pay")
        db.save_transaction(g.db, trans, session.get('name'))
        return redirect(url_for('main'))
    else:
        pay_to = request.args.get('pay_to')
        amount = db.get_balance(g.db, pay_to, session.get('name'))
        return render_template('pay.html', pay_to=pay_to, amount=amount)



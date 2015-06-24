from flask import Flask, render_template, redirect, request
import database_setup as db

app = Flask(__name__)


@app.route('/')
def index():
    con = db.conn()
    rows1 = db.get_all_transaction(con)
    return render_template('index.html', rows=rows1)


@app.route('/add/', methods=['GET', 'POST'])
def add():
    if request.method == 'POST':
        pass
    else:
        return render_template('add.html')


if __name__ == '__main__':
    app.debug = True
    app.run()

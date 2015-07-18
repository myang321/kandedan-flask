__author__ = 'Steve'
import unittest
from main import app
import database_setup as db


class FlaskrTestCase(unittest.TestCase):
    def setUp(self):
        self.con = db.conn()
        self.app = app.test_client()
        self.username = 'testUser2'
        self.password = '123'


    def tearDown(self):
        db.delete_user(self.con, self.username)
        self.con.close()


    def signup(self, username, password):
        return self.app.post('/signup', data=dict(
            username=username,
            password=password,
            screenname=self.username
        ), follow_redirects=True)

    def login(self, username, password):
        return self.app.post('/', data=dict(
            username=username,
            password=password,
        ), follow_redirects=True)

    def test_create_user(self):
        rv = self.signup(self.username, self.password)
        assert 'sign up successfully' in rv.data
        rv = self.login(self.username, 'asdcsdac')
        assert 'username or password not correct' in rv.data
        rv = self.login(self.username, self.password)
        assert 'Welcome' in rv.data



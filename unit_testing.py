__author__ = 'Steve'
import unittest
from main import app
import database_setup as db


class FlaskrTestCase(unittest.TestCase):
    def setUp(self):
        self.con = db.conn()
        self.app = app.test_client()
        self.username = 'testUser1'
        self.password = '123'
        self.username2 = 'testUser2'
        self.group_name = 'testGroupName1'

    def tearDown(self):
        db.delete_group(self.con, username=self.username, group_name=self.group_name)
        db.delete_user(self.con, self.username)
        db.delete_user(self.con, self.username2)
        self.con.close()

    def signup(self, username, password):
        return self.app.post('/signup', data=dict(
            username=username,
            password=password,
            screenname=username
        ), follow_redirects=True)

    def login(self, username, password):
        return self.app.post('/', data=dict(
            username=username,
            password=password,
        ), follow_redirects=True)

    def create_group(self, group_name):
        return self.app.post('/setting/create_group', data=dict(
            group_name=group_name
        ), follow_redirects=True)

    def delete_group(self):
        return self.app.post('/setting/delete_group', data=dict(
        ), follow_redirects=True)

    def join_group(self, group_name):
        return self.app.post('/setting/join_group', data=dict(
            group_name=group_name
        ), follow_redirects=True)

    def leave_group(self):
        return self.app.post('/setting/leave_group', follow_redirects=True)

    def test_create_user(self):
        rv = self.signup(self.username, self.password)
        assert 'sign up successfully' in rv.data
        rv = self.login(self.username, 'asdcsdac')
        assert 'username or password not correct' in rv.data
        rv = self.login(self.username, self.password)
        assert 'Welcome <strong> {0}'.format(self.username) in rv.data

    def test_group(self):
        rv = self.signup(self.username, self.password)
        assert 'sign up successfully' in rv.data
        rv = self.login(self.username, self.password)
        assert 'Welcome <strong> {0}'.format(self.username) in rv.data
        rv = self.app.get('/setting/create_group', follow_redirects=True)
        assert 'please input your group name' in rv.data
        rv = self.create_group(self.group_name)
        assert 'group create successfully' in rv.data
        rv = self.app.get('/setting/join_group', follow_redirects=True)
        assert 'you have already in a group' in rv.data
        rv = self.app.get('/setting/leave_group', follow_redirects=True)
        assert 'you are the holder, you can not leave a group,but you can delete group' in rv.data
        rv = self.app.get('/setting/delete_group', follow_redirects=True)
        assert 'you are sure to delete this group' in rv.data
        rv = self.delete_group()
        assert 'you have already delete this group' in rv.data
        rv = self.app.get('/setting/delete_group', follow_redirects=True)
        assert 'you don&#39;t belong to any group' in rv.data

    def test_group2(self):
        rv = self.signup(self.username, self.password)
        assert 'sign up successfully' in rv.data
        rv = self.signup(self.username2, self.password)
        assert 'sign up successfully' in rv.data
        rv = self.login(self.username, self.password)
        assert 'Welcome <strong> {0}'.format(self.username) in rv.data
        rv = self.app.get('/setting/create_group', follow_redirects=True)
        assert 'please input your group name' in rv.data
        rv = self.create_group(self.group_name)
        assert 'group create successfully' in rv.data
        self.app.get('/logout', follow_redirects=True)
        rv = self.login(self.username2, self.password)
        assert 'Welcome <strong> {0}'.format(self.username2) in rv.data
        assert 'You are not in any group, please create or join a group in Setting page.' in rv.data
        rv = self.app.get('/setting/join_group', follow_redirects=True)
        assert 'please input your group name' in rv.data
        rv = self.join_group('wrong_group_name')
        assert 'group name does not exist' in rv.data
        rv = self.join_group(self.group_name)
        assert 'join group successfully' in rv.data
        rv = self.app.get('/setting/leave_group', follow_redirects=True)
        assert 'you are sure to leave this group' in rv.data
        rv = self.leave_group()
        assert 'you have leaved this group' in rv.data

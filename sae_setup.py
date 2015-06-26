__author__ = 'Steve'

import MySQLdb

try:
    from sae.const import (MYSQL_HOST, MYSQL_HOST_S, MYSQL_PORT, MYSQL_USER, MYSQL_PASS, MYSQL_DB)
except ImportError:
    print "ImportError  No SAE"


def sae_conn():
    con = MySQLdb.connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS,
                          MYSQL_DB, port=int(MYSQL_PORT))
    return con
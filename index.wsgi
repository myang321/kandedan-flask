import os
import sys

root = os.path.dirname(__file__)

sys.path.insert(0, os.path.join(root, 'site-packages'))

import sae
from main import app
from sae.ext.shell import ShellMiddleware

# application = sae.create_wsgi_app(app)
application = sae.create_wsgi_app(ShellMiddleware(app))

#def application(environ, start_response):
#    start_response('200 ok', [('content-type', 'text/plain')])
#    return ['Hello, SAE!']

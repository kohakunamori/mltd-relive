import socket
import sys
from os import path
from socketserver import ThreadingMixIn
from wsgiref.simple_server import WSGIRequestHandler, WSGIServer, make_server

from mltd.servers.config import api_port
from mltd.servers.handler import application
from mltd.servers.logging import logger


# Avoid slow reverse-DNS/FQDN lookup during server startup on Windows.
def bare_getfqdn(name=''):
    return ''
socket.getfqdn = bare_getfqdn


class ThreadingWSGIServer(ThreadingMixIn, WSGIServer):
    daemon_threads = True
    allow_reuse_address = True
    request_queue_size = 64


class SilentWSGIRequestHandler(WSGIRequestHandler):
    protocol_version = 'HTTP/1.1'

    def log_message(self, format, *args):
        pass


def key_path():
    base_path = getattr(sys, '_MEIPASS', path.abspath('..'))
    return path.join(base_path, 'key')


def start(port=api_port, conn=None):
    with make_server('', port, application,
                     server_class=ThreadingWSGIServer,
                     handler_class=SilentWSGIRequestHandler) as httpd:
        logger.info(f'Serving threaded HTTP/1.1 API on port {port}...')
        if conn:
            conn.send(True)
            conn.close()
        httpd.serve_forever()


if __name__ == '__main__':
    start()

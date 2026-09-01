#!/usr/bin/env python3
import http.client
import statistics
import sys
import threading
import time
import types
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

logging_module = types.ModuleType('mltd.servers.logging')


class DummyLogger:
    def debug(self, *args, **kwargs):
        pass

    info = debug
    warning = debug
    error = debug


logging_module.logger = DummyLogger()
sys.modules.setdefault('mltd.servers.logging', logging_module)

from mltd.servers import proxy  # noqa: E402

REQUEST_BODY = b'x' * 512
RESPONSE_BODY = b'y' * 4096
WARMUP = 25
REQUESTS = 300


class FakeLocalAPI(BaseHTTPRequestHandler):
    protocol_version = 'HTTP/1.1'

    def do_POST(self):
        length = int(self.headers.get('Content-Length', '0'))
        self.rfile.read(length)
        self.send_response(200)
        self.send_header('Content-Type', 'application/octet-stream')
        self.send_header('Content-Length', str(len(RESPONSE_BODY)))
        self.end_headers()
        self.wfile.write(RESPONSE_BODY)

    def log_message(self, format, *args):
        pass


def direct_application(environ, start_response):
    environ['wsgi.input'].read(int(environ['CONTENT_LENGTH']))
    start_response('200 OK', [
        ('Content-Type', 'application/octet-stream'),
        ('Content-Length', str(len(RESPONSE_BODY))),
    ])
    return [RESPONSE_BODY]


class FallbackHandler(proxy.ProxyHTTPRequestHandler):
    api_application = None


class DirectHandler(proxy.ProxyHTTPRequestHandler):
    api_application = staticmethod(direct_application)


def start(server):
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    return thread


def run_client(port, count):
    conn = http.client.HTTPConnection('127.0.0.1', port, timeout=10)
    headers = {
        'Host': 'theaterdays-zh.appspot.com',
        'Content-Type': 'application/octet-stream',
    }
    samples = []
    for _ in range(count):
        begin = time.perf_counter_ns()
        conn.request('POST', '/api', body=REQUEST_BODY, headers=headers)
        response = conn.getresponse()
        body = response.read()
        end = time.perf_counter_ns()
        if response.status != 200 or body != RESPONSE_BODY:
            raise RuntimeError('benchmark response mismatch')
        samples.append((end - begin) / 1_000_000)
    conn.close()
    return samples


def summarize(label, samples):
    total_s = sum(samples) / 1000
    rps = len(samples) / total_s
    median = statistics.median(samples)
    p95 = sorted(samples)[int(len(samples) * 0.95) - 1]
    print(
        f'{label}: {rps:.1f} req/s, median={median:.3f} ms, '
        f'p95={p95:.3f} ms'
    )
    return rps


def main():
    upstream = ThreadingHTTPServer(('127.0.0.1', 0), FakeLocalAPI)
    upstream.daemon_threads = True
    upstream_thread = start(upstream)
    old_api_port = proxy.api_port
    proxy.api_port = upstream.server_address[1]

    fallback = proxy.ThreadedProxyServer(('127.0.0.1', 0), FallbackHandler)
    direct = proxy.ThreadedProxyServer(('127.0.0.1', 0), DirectHandler)
    fallback_thread = start(fallback)
    direct_thread = start(direct)

    try:
        run_client(fallback.server_address[1], WARMUP)
        run_client(direct.server_address[1], WARMUP)
        fallback_samples = run_client(fallback.server_address[1], REQUESTS)
        direct_samples = run_client(direct.server_address[1], REQUESTS)
        fallback_rps = summarize('localhost HTTP hop', fallback_samples)
        direct_rps = summarize('direct WSGI', direct_samples)
        print(f'speedup: {direct_rps / fallback_rps:.2f}x')
    finally:
        fallback.shutdown()
        direct.shutdown()
        upstream.shutdown()
        fallback.server_close()
        direct.server_close()
        upstream.server_close()
        fallback_thread.join(timeout=2)
        direct_thread.join(timeout=2)
        upstream_thread.join(timeout=2)
        proxy.api_port = old_api_port


if __name__ == '__main__':
    main()

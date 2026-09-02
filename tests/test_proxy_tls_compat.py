import inspect
import sys
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

from mltd.servers import proxy  # noqa: E402


class ProxyTLSCompatibilityTest(unittest.TestCase):
    def test_listener_wrapped_tls_path_matches_v016_compatibility_model(self):
        # v0.1.8 briefly moved TLS wrapping into process_request_thread().
        # The corrected clients are known-good with the v0.1.6 model, where
        # the listening socket itself is SSL-wrapped before serve_forever().
        self.assertNotIn('process_request_thread', proxy.ThreadedProxyServer.__dict__)
        self.assertNotIn('ssl_context', proxy.ThreadedProxyServer.__dict__)

        source = inspect.getsource(proxy.start)
        self.assertIn(
            'httpd.socket = context.wrap_socket(httpd.socket, server_side=True)',
            source,
        )
        self.assertNotIn('process_request_thread', source)

    def test_api_tls_listener_does_not_load_asset_certificate(self):
        source = inspect.getsource(proxy.start)
        self.assertNotIn('assets.rainbowunicorn7297.com.crt', source)
        self.assertNotIn('assets.rainbowunicorn7297.com.key', source)
        self.assertNotIn('set_servername_callback', source)

    def test_api_post_restores_connection_close_semantics(self):
        post_source = inspect.getsource(proxy.ProxyHTTPRequestHandler.do_POST)
        response_source = inspect.getsource(proxy.ProxyHTTPRequestHandler._send_response)
        self.assertIn('self.close_connection = True', post_source)
        self.assertIn("self.send_header('Connection', 'close')", response_source)

    def test_api_dispatch_is_serialized_for_live_compatibility(self):
        post_source = inspect.getsource(proxy.ProxyHTTPRequestHandler.do_POST)
        self.assertIn('with _API_COMPAT_LOCK:', post_source)

    def test_cache_modes_start_independent_http_asset_listener(self):
        source = inspect.getsource(proxy._start_asset_http_server)
        self.assertIn("if config.asset_mode == 'remote':", source)
        self.assertIn('create_asset_server(', source)
        self.assertIn('fetch_on_miss = config.asset_mode == \'hybrid\'', source)
        self.assertIn("name='mltd-asset-http'", source)


if __name__ == '__main__':
    unittest.main()

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

    def test_api_tls_listener_is_api_only(self):
        module_source = inspect.getsource(proxy)
        start_source = inspect.getsource(proxy.start)
        self.assertNotIn('create_asset_server', module_source)
        self.assertNotIn('_start_asset_server', module_source)
        self.assertNotIn('AssetMirror', module_source)
        self.assertNotIn('AssetStore', module_source)
        self.assertNotIn('set_servername_callback', start_source)

    def test_api_post_restores_connection_close_semantics(self):
        post_source = inspect.getsource(proxy.ProxyHTTPRequestHandler.do_POST)
        response_source = inspect.getsource(proxy.ProxyHTTPRequestHandler._send_response)
        self.assertIn('self.close_connection = True', post_source)
        self.assertIn("self.send_header('Connection', 'close')", response_source)

    def test_api_dispatch_is_serialized_for_live_compatibility(self):
        post_source = inspect.getsource(proxy.ProxyHTTPRequestHandler.do_POST)
        self.assertIn('with _API_COMPAT_LOCK:', post_source)

    def test_start_reports_remote_asset_transport_only(self):
        source = inspect.getsource(proxy.start)
        self.assertIn('Asset transport: remote relay', source)
        self.assertIn('Asset transport: Rainbow remote CDN', source)
        self.assertNotIn('Asset HTTP server', source)
        self.assertNotIn('Asset HTTPS server', source)


if __name__ == '__main__':
    unittest.main()

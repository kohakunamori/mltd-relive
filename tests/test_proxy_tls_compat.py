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
            'httpd.socket = api_context.wrap_socket(httpd.socket, server_side=True)',
            source,
        )
        self.assertNotIn('process_request_thread', source)

    def test_asset_hostname_uses_sni_context_without_rewrapping_socket(self):
        source = inspect.getsource(proxy.start)
        self.assertIn('api_context.set_servername_callback', source)
        self.assertIn('ssl_socket.context = asset_context', source)
        self.assertIn('assets.rainbowunicorn7297.com.crt', source)
        self.assertIn('assets.rainbowunicorn7297.com.key', source)

    def test_api_post_restores_connection_close_semantics(self):
        post_source = inspect.getsource(proxy.ProxyHTTPRequestHandler.do_POST)
        response_source = inspect.getsource(proxy.ProxyHTTPRequestHandler._send_response)
        self.assertIn('self.close_connection = True', post_source)
        self.assertIn("self.send_header('Connection', 'close')", response_source)

    def test_asset_requests_route_by_original_host(self):
        source = inspect.getsource(proxy.ProxyHTTPRequestHandler._asset_path)
        self.assertIn("self.headers.get('Host', '')", source)
        self.assertIn('host == _ASSET_HOST', source)


if __name__ == '__main__':
    unittest.main()

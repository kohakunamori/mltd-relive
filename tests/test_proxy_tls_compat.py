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
        self.assertIn('httpd.socket = context.wrap_socket(', source)
        self.assertNotIn('httpd.ssl_context = context', source)


if __name__ == '__main__':
    unittest.main()

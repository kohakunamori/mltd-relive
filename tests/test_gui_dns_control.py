import ast
import unittest
from pathlib import Path


GUI_PATH = Path(__file__).resolve().parents[1] / 'standalone' / 'gui.pyw'


class OptionalDNSGUIControlTest(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.source = GUI_PATH.read_text(encoding='utf-8')
        cls.tree = ast.parse(cls.source, filename=str(GUI_PATH))

    def _method_source(self, name):
        for node in ast.walk(self.tree):
            if isinstance(node, ast.FunctionDef) and node.name == name:
                return ast.get_source_segment(self.source, node)
        self.fail(f'missing method: {name}')

    def test_gui_source_compiles(self):
        compile(self.source, str(GUI_PATH), 'exec')

    def test_dns_is_explicitly_opt_in(self):
        self.assertIn("text='Start DNS Server'", self.source)
        self.assertIn('command=self.start_dns_server', self.source)
        self.assertIn("self.dns_status = 'Stopped'", self.source)
        self.assertIn('DNS Port: {dns_port} (optional)', self.source)

    def test_main_server_start_does_not_start_dns(self):
        start_server = self._method_source('start_server')
        self.assertIn('CustomProcess(target=proxy.start', start_server)
        self.assertNotIn('CustomProcess(target=dns.start', start_server)
        self.assertNotIn('self.dns_process.start()', start_server)

    def test_main_server_stop_does_not_stop_dns(self):
        stop_server = self._method_source('stop_server')
        self.assertIn("getattr(self, 'proxy_process', None)", stop_server)
        self.assertNotIn("'dns_process'", stop_server)
        self.assertNotIn('stop_dns_server', stop_server)

    def test_dns_has_independent_start_stop_lifecycle(self):
        start_dns = self._method_source('start_dns_server')
        stop_dns = self._method_source('stop_dns_server')
        update_dns = self._method_source('update_dns_status')
        self.assertIn('CustomProcess(target=dns.start', start_dns)
        self.assertIn('self.dns_process.start()', start_dns)
        self.assertIn('process.terminate()', stop_dns)
        self.assertIn("text='Stop DNS Server'", update_dns)
        self.assertIn("text='Start DNS Server'", update_dns)


if __name__ == '__main__':
    unittest.main()

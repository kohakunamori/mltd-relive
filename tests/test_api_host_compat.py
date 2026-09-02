import importlib.util
import sys
import types
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
STANDALONE_ROOT = REPO_ROOT / 'standalone'
sys.path.insert(0, str(STANDALONE_ROOT))


class _DummyLogger:
    def isEnabledFor(self, level):
        return False

    def debug(self, *args, **kwargs):
        pass

    info = debug
    warning = debug
    error = debug


def _load_handler_for_host_tests():
    replacements = {}

    jsonrpc = types.ModuleType('jsonrpc')
    jsonrpc.JSONRPCResponseManager = object
    jsonrpc.dispatcher = object()
    replacements['jsonrpc'] = jsonrpc

    encryption = types.ModuleType('mltd.servers.encryption')
    encryption.decrypt_request = lambda value: value
    encryption.encrypt_response = lambda value: value
    replacements['mltd.servers.encryption'] = encryption

    logging_module = types.ModuleType('mltd.servers.logging')
    logging_module.logger = _DummyLogger()
    replacements['mltd.servers.logging'] = logging_module

    utilities = types.ModuleType('mltd.servers.utilities')
    utilities.format_datetime = str
    replacements['mltd.servers.utilities'] = utilities

    replacements['mltd.services'] = types.ModuleType('mltd.services')

    previous = {name: sys.modules.get(name) for name in replacements}
    try:
        sys.modules.update(replacements)
        spec = importlib.util.spec_from_file_location(
            'mltd_handler_host_test',
            STANDALONE_ROOT / 'mltd' / 'servers' / 'handler.py',
        )
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        return module
    finally:
        for name, old_module in previous.items():
            if old_module is None:
                sys.modules.pop(name, None)
            else:
                sys.modules[name] = old_module


handler = _load_handler_for_host_tests()


class APIHostCompatibilityTest(unittest.TestCase):
    def test_all_dns_intercepted_api_hosts_are_accepted(self):
        for host in (
            'theaterdays-zh.appspot.com',
            'theaterdays-ko.appspot.com',
            'theaterdays.appspot.com',
            '127.0.0.1',
        ):
            with self.subTest(host=host):
                self.assertTrue(handler._is_allowed_api_host(host))
                self.assertTrue(handler._is_allowed_api_host(f'{host}:443'))

    def test_host_matching_is_exact_not_substring_based(self):
        for host in (
            'evil-theaterdays.appspot.com',
            'theaterdays.appspot.com.evil.example',
            'theaterdays-zh.appspot.com.evil.example',
            '',
        ):
            with self.subTest(host=host):
                self.assertFalse(handler._is_allowed_api_host(host))

    def test_host_matching_is_case_insensitive(self):
        self.assertTrue(handler._is_allowed_api_host('THEATERDAYS.APPSpOT.COM:443'))


if __name__ == '__main__':
    unittest.main()

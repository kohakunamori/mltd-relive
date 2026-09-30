"""Contract coverage for lightweight client compatibility RPCs."""
import unittest

from mltd.services.client_compat import post_live_log, read_direct_message


class ClientCompatRuntimeTest(unittest.TestCase):
    def test_read_direct_message_acknowledges_known_contract(self):
        self.assertEqual(read_direct_message({'id': 'offline-message'}), {})
        with self.assertRaises(KeyError):
            read_direct_message({})

    def test_post_live_log_acknowledges_known_contract(self):
        self.assertEqual(
            post_live_log({'id': 'live-test', 'data': '{"result":"ok"}'}),
            {},
        )
        with self.assertRaises(KeyError):
            post_live_log({'id': 'missing-data'})


if __name__ == '__main__':
    unittest.main(verbosity=2)

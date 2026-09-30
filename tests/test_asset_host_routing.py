import sys
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

from mltd.servers.asset_cache import REMOTE_ASSET_ROOT  # noqa: E402
from mltd.servers.config import ASSET_MODES, config  # noqa: E402
from mltd.servers.dns import build_zone_record  # noqa: E402
from mltd.services.asset import get_asset_version  # noqa: E402


class AssetRemoteRoutingTest(unittest.TestCase):
    def setUp(self):
        default = config['default']
        self.saved = {
            'language': default.get('language'),
            'asset_mode': default.get('asset_mode'),
            'asset_remote_url': default.get('asset_remote_url', ''),
            'is_local': default.get('is_local'),
        }
        default['language'] = 'zh'
        default['asset_mode'] = 'remote'
        default['asset_remote_url'] = ''
        default['is_local'] = 'False'

    def tearDown(self):
        default = config['default']
        for key, value in self.saved.items():
            default[key] = value

    def _asset_url(self):
        return get_asset_version({
            'os_name': 'Android',
            'unity_version': '2018v1',
            'environment': 'production',
            'token': '0' * 40,
        })['asset_url']

    def test_only_remote_mode_is_exposed(self):
        self.assertEqual(ASSET_MODES, ('remote',))
        self.assertEqual(config.asset_mode, 'remote')

    def test_remote_defaults_to_public_rainbow_https_cdn(self):
        self.assertEqual(
            self._asset_url(),
            f'{REMOTE_ASSET_ROOT}/zh-android/',
        )

    def test_remote_can_use_trusted_https_relay(self):
        config['default']['asset_remote_url'] = 'https://relay.example.com/mltd/'
        self.assertEqual(
            self._asset_url(),
            'https://relay.example.com/mltd/zh-android/',
        )

    def test_remote_rejects_cleartext_relay_url(self):
        config['default']['asset_remote_url'] = 'http://relay.example.com'
        with self.assertRaises(ValueError):
            self._asset_url()

    def test_dns_intercepts_api_hosts_only(self):
        zone = build_zone_record('192.0.2.10', '2001:db8::10')
        self.assertNotIn('assets.rainbowunicorn7297.com.', zone)
        self.assertNotIn('relay.example.com.', zone)
        self.assertIn(
            'theaterdays-zh.appspot.com. 60 IN A 192.0.2.10',
            zone,
        )
        self.assertIn(
            'theaterdays-zh.appspot.com. 60 IN AAAA 2001:db8::10',
            zone,
        )


if __name__ == '__main__':
    unittest.main()

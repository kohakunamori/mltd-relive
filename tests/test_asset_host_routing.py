import sys
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

from mltd.servers.asset_cache import REMOTE_ASSET_ROOT  # noqa: E402
from mltd.servers.config import config  # noqa: E402
from mltd.servers.dns import build_zone_record  # noqa: E402
from mltd.services.asset import get_asset_version  # noqa: E402


class AssetHttpsRoutingTest(unittest.TestCase):
    def setUp(self):
        default = config['default']
        self.saved = {
            'language': default.get('language'),
            'asset_mode': default.get('asset_mode'),
            'is_local': default.get('is_local'),
            'asset_public_url': default.get('asset_public_url'),
        }
        default['language'] = 'zh'
        default['is_local'] = 'False'
        default['asset_public_url'] = 'https://mltd-assets.example.test:7651'

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

    def test_remote_uses_public_https_cdn(self):
        config['default']['asset_mode'] = 'remote'
        self.assertEqual(
            self._asset_url(),
            f'{REMOTE_ASSET_ROOT}/zh-android/',
        )

    def test_hybrid_desktop_uses_configured_https_asset_endpoint(self):
        config['default']['asset_mode'] = 'hybrid'
        self.assertEqual(
            self._asset_url(),
            'https://mltd-assets.example.test:7651/zh-android/',
        )

    def test_local_desktop_uses_configured_https_asset_endpoint(self):
        config['default']['asset_mode'] = 'local'
        self.assertEqual(
            self._asset_url(),
            'https://mltd-assets.example.test:7651/zh-android/',
        )

    def test_desktop_cache_mode_rejects_missing_public_endpoint(self):
        config['default']['asset_mode'] = 'hybrid'
        config['default']['asset_public_url'] = ''
        with self.assertRaisesRegex(RuntimeError, 'asset_public_url'):
            self._asset_url()

    def test_desktop_cache_mode_rejects_cleartext_public_endpoint(self):
        config['default']['asset_mode'] = 'hybrid'
        config['default']['asset_public_url'] = (
            'http://mltd-assets.example.test:7651'
        )
        with self.assertRaisesRegex(RuntimeError, 'must use HTTPS'):
            self._asset_url()

    def test_same_device_mode_keeps_loopback_http_path(self):
        config['default']['asset_mode'] = 'hybrid'
        config['default']['is_local'] = 'True'
        config['default']['asset_public_url'] = ''
        self.assertEqual(
            self._asset_url(),
            'http://127.0.0.1:7651/zh-android/',
        )

    def test_dns_intercepts_configured_asset_hostname(self):
        zone = build_zone_record(
            '192.0.2.10',
            '2001:db8::10',
            'mltd-assets.example.test',
        )
        self.assertIn(
            'mltd-assets.example.test. 60 IN A 192.0.2.10',
            zone,
        )
        self.assertIn(
            'mltd-assets.example.test. 60 IN AAAA 2001:db8::10',
            zone,
        )
        self.assertIn(
            'theaterdays-zh.appspot.com. 60 IN A 192.0.2.10',
            zone,
        )


if __name__ == '__main__':
    unittest.main()

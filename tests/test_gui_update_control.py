import ast
import io
import json
from pathlib import Path
import unittest
from unittest.mock import patch

from mltd import update_check


class UpdateCheckTests(unittest.TestCase):

    def _release(self, target='b' * 40):
        return {
            'target_commitish': target,
            'html_url': 'https://github.com/kohakunamori/mltd-relive/releases/tag/standalone-latest',
            'body': '- Standalone source version: `v0.1.11`',
            'assets': [
                {
                    'name': 'mltd-relive-standalone-latest-windows.exe',
                    'browser_download_url': 'https://example.invalid/windows.exe',
                },
                {
                    'name': 'mltd-relive-standalone-latest-ubuntu',
                    'browser_download_url': 'https://example.invalid/ubuntu',
                },
                {
                    'name': 'mltd-relive-standalone-latest-macos.zip',
                    'browser_download_url': 'https://example.invalid/macos.zip',
                },
            ],
        }

    def _check(self, release, platform='win32'):
        payload = io.BytesIO(json.dumps(release).encode('utf-8'))
        with patch.object(update_check, 'urlopen', return_value=payload):
            return update_check.check_for_updates(
                '0.1.11', timeout=1, platform=platform)

    def test_packaged_build_detects_newer_rolling_commit(self):
        old = 'a' * 40
        with patch.object(update_check, 'BUILD_COMMIT', old):
            info = self._check(self._release())
        self.assertTrue(info.current_build_known)
        self.assertTrue(info.update_available)
        self.assertEqual(info.latest_version, '0.1.11')
        self.assertEqual(info.download_url, 'https://example.invalid/windows.exe')

    def test_same_commit_is_up_to_date(self):
        target = 'c' * 40
        with patch.object(update_check, 'BUILD_COMMIT', target):
            info = self._check(self._release(target=target), platform='linux')
        self.assertFalse(info.update_available)
        self.assertEqual(info.download_url, 'https://example.invalid/ubuntu')

    def test_source_checkout_is_not_marked_outdated(self):
        with patch.object(update_check, 'BUILD_COMMIT', None):
            info = self._check(self._release(), platform='darwin')
        self.assertFalse(info.current_build_known)
        self.assertFalse(info.update_available)
        self.assertEqual(info.download_url, 'https://example.invalid/macos.zip')

    def test_unknown_platform_falls_back_to_release_page(self):
        with patch.object(update_check, 'BUILD_COMMIT', 'a' * 40):
            info = self._check(self._release(), platform='plan9')
        self.assertEqual(info.download_url, info.release_url)


class GUIUpdatePolicyTests(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.source = Path('gui.pyw').read_text(encoding='utf-8')
        cls.tree = ast.parse(cls.source)

    def test_gui_exposes_manual_check_and_download_states(self):
        self.assertIn("text='Check for Updates'", self.source)
        self.assertIn("text='Download Update'", self.source)
        self.assertIn("text='Open Latest Release'", self.source)

    def test_gui_does_not_check_updates_on_startup(self):
        calls = []
        for node in ast.walk(self.tree):
            if not isinstance(node, ast.Call):
                continue
            func = node.func
            if isinstance(func, ast.Attribute) and func.attr == 'after_idle':
                calls.append(ast.unparse(node))
        self.assertTrue(any('start_server' in call for call in calls))
        self.assertFalse(any('check_for_updates' in call for call in calls))

    def test_update_check_is_not_part_of_server_start(self):
        gui_class = next(
            node for node in self.tree.body
            if isinstance(node, ast.ClassDef) and node.name == 'MLTDReliveGUI'
        )
        start_server = next(
            node for node in gui_class.body
            if isinstance(node, ast.FunctionDef) and node.name == 'start_server'
        )
        self.assertNotIn('check_for_updates', ast.unparse(start_server))


if __name__ == '__main__':
    unittest.main()

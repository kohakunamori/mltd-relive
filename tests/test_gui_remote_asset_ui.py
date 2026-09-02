import unittest
from pathlib import Path


GUI_PATH = Path(__file__).resolve().parents[1] / 'standalone' / 'gui.pyw'


class RemoteAssetGUICompatibilityTest(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.source = GUI_PATH.read_text(encoding='utf-8')

    def test_gui_source_compiles(self):
        compile(self.source, str(GUI_PATH), 'exec')

    def test_legacy_asset_ui_is_removed(self):
        self.assertNotIn('Asset Mode:', self.source)
        self.assertNotIn('Asset Preparation', self.source)
        self.assertNotIn('ASSET_MODES', self.source)
        self.assertNotIn('asset_prepare', self.source)
        self.assertNotIn('update_asset_progress', self.source)

    def test_remote_url_ui_is_present(self):
        self.assertIn('Asset Remote URL:', self.source)
        self.assertIn('config.asset_remote_url', self.source)
        self.assertIn('HTTPS only.', self.source)


if __name__ == '__main__':
    unittest.main()

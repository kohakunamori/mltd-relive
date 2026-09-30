import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
GUI_PATH = ROOT / 'standalone' / 'gui.pyw'
GUI_ACCOUNTS_PATH = ROOT / 'standalone' / 'mltd' / 'gui_accounts.py'


class RemoteAssetGUICompatibilityTest(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.source = GUI_PATH.read_text(encoding='utf-8')
        cls.account_source = GUI_ACCOUNTS_PATH.read_text(encoding='utf-8')

    def test_gui_source_compiles(self):
        compile(self.source, str(GUI_PATH), 'exec')
        compile(self.account_source, str(GUI_ACCOUNTS_PATH), 'exec')

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

    def test_user_management_ui_is_present(self):
        self.assertIn('User Management', self.source)
        self.assertIn('UserManagementWindow', self.source)
        self.assertIn('Add Full-Save User', self.account_source)
        self.assertIn('Enable', self.account_source)
        self.assertIn('Disable', self.account_source)
        self.assertIn('Delete User', self.account_source)
        self.assertIn('full-save clones only', self.account_source)


if __name__ == '__main__':
    unittest.main()

import ast
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
MODULE = ROOT / 'standalone' / 'mltd' / 'services' / 'theater_compat.py'
EXPECTED_STATUS_KEYS = {
    'mst_theater_opening_id',
    'opening_type',
    'resource_id',
    'jump_type',
    'cue_sheet',
    'cue_name',
    'mv_status',
}


class TheaterOpeningCompatTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.source = MODULE.read_text(encoding='utf-8')
        cls.tree = ast.parse(cls.source)

    def test_module_compiles(self):
        compile(self.source, str(MODULE), 'exec')

    def test_reverse_engineered_rpc_is_registered(self):
        self.assertIn("name='TheaterService.FinishTheaterOpening'", self.source)

    def test_reply_matches_theater_opening_status_contract(self):
        functions = {
            node.name: node
            for node in self.tree.body
            if isinstance(node, ast.FunctionDef)
        }
        node = functions['empty_theater_opening_status']
        literal_strings = {
            item.value
            for item in ast.walk(node)
            if isinstance(item, ast.Constant) and isinstance(item.value, str)
        }
        self.assertTrue(EXPECTED_STATUS_KEYS <= literal_strings)
        self.assertIn('mst_song_id', literal_strings)
        self.assertIn('mv_unit_idol_list', literal_strings)


if __name__ == '__main__':
    unittest.main()

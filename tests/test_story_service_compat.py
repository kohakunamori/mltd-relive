import ast
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
STORY = ROOT / 'standalone' / 'mltd' / 'services' / 'story.py'

EXPECTED_RPCS = {
    'StoryService.FinishCostumeAdv': {
        'reply': {'reward_item_status_list'},
    },
    'StoryService.FinishEpisode': {
        'reply': {'reward_item_status_list', 'mission_process', 'mission_list'},
    },
    'StoryService.FinishMainStory': {
        'reply': {
            'reward_item_status_list',
            'reward_mst_song_id',
            'song',
            'release_blog',
            'is_release_next',
            'next_mst_main_story_id',
            'next_chapter',
            'mission_process',
            'mission_list',
        },
    },
    'StoryService.FinishMemorial': {
        'reply': {'reward_item_status_list', 'mission_process', 'mission_list'},
    },
    'StoryService.FinishOfferStory': {
        'reply': {'reward_item_status_list'},
    },
    'StoryService.FinishSpecialStory': {
        'reply': {'reward_item_status_list'},
    },
    'StoryService.PlayStoryMV': {
        'reply': set(),
    },
}


class StoryServiceContractTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.source = STORY.read_text(encoding='utf-8')
        cls.tree = ast.parse(cls.source)

    def _rpc_functions(self):
        result = {}
        for node in self.tree.body:
            if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                continue
            for decorator in node.decorator_list:
                if not isinstance(decorator, ast.Call):
                    continue
                func = decorator.func
                if not (isinstance(func, ast.Attribute)
                        and func.attr == 'add_method'):
                    continue
                for keyword in decorator.keywords:
                    if keyword.arg != 'name':
                        continue
                    if isinstance(keyword.value, ast.Constant):
                        result[keyword.value.value] = node
        return result

    def test_story_module_compiles(self):
        compile(self.source, str(STORY), 'exec')

    def test_reverse_engineered_story_rpcs_are_registered(self):
        registered = self._rpc_functions()
        self.assertTrue(
            EXPECTED_RPCS.keys() <= registered.keys(),
            sorted(EXPECTED_RPCS.keys() - registered.keys()),
        )

    def test_finish_reply_contract_keys_are_present(self):
        functions = self._rpc_functions()
        for rpc_name, contract in EXPECTED_RPCS.items():
            node = functions[rpc_name]
            literal_strings = {
                item.value
                for item in ast.walk(node)
                if isinstance(item, ast.Constant)
                and isinstance(item.value, str)
            }
            with self.subTest(rpc=rpc_name):
                self.assertTrue(
                    contract['reply'] <= literal_strings,
                    sorted(contract['reply'] - literal_strings),
                )

    def test_story_completion_is_idempotent(self):
        self.assertIn('if state.is_read:', self.source)
        self.assertIn('state.is_read = True', self.source)
        self.assertIn('_grant_rewards_once', self.source)

    def test_main_story_completion_unlocks_followup_state(self):
        self.assertIn('_release_next_main_story', self.source)
        self.assertIn('song.is_disable = False', self.source)
        self.assertIn('mission_class_id=20', self.source)


if __name__ == '__main__':
    unittest.main()

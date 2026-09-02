import ast
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
STORY = ROOT / 'standalone' / 'mltd' / 'services' / 'story.py'

MISSION_REPLY_KEYS = {'mission_process', 'mission_list'}
EXPECTED_RPCS = {
    'StoryService.FinishCostumeAdv': {
        'reply': {'reward_item_status_list'},
    },
    'StoryService.FinishEpisode': {
        'reply': {'reward_item_status_list'} | MISSION_REPLY_KEYS,
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
        } | MISSION_REPLY_KEYS,
    },
    'StoryService.FinishMemorial': {
        'reply': {'reward_item_status_list'} | MISSION_REPLY_KEYS,
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

    def _functions(self):
        return {
            node.name: node
            for node in self.tree.body
            if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef))
        }

    def _rpc_functions(self):
        result = {}
        for node in self._functions().values():
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

    @staticmethod
    def _literal_strings(node):
        return {
            item.value
            for item in ast.walk(node)
            if isinstance(item, ast.Constant)
            and isinstance(item.value, str)
        }

    def test_story_module_compiles(self):
        compile(self.source, str(STORY), 'exec')

    def test_reverse_engineered_story_rpcs_are_registered(self):
        registered = self._rpc_functions()
        self.assertTrue(
            EXPECTED_RPCS.keys() <= registered.keys(),
            sorted(EXPECTED_RPCS.keys() - registered.keys()),
        )

    def test_finish_reply_contract_keys_are_present(self):
        functions = self._functions()
        rpc_functions = self._rpc_functions()
        mission_helper_literals = self._literal_strings(functions['_mission_reply'])

        for rpc_name, contract in EXPECTED_RPCS.items():
            node = rpc_functions[rpc_name]
            literal_strings = self._literal_strings(node)
            if '_mission_reply' in {
                item.func.id
                for item in ast.walk(node)
                if isinstance(item, ast.Call)
                and isinstance(item.func, ast.Name)
            }:
                literal_strings |= mission_helper_literals

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

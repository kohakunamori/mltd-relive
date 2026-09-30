"""Regression cases for selective CI; no third-party modules or user database."""

import ast
import importlib.util
from pathlib import Path
import re
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location('ci_scope', ROOT / 'tools/ci_scope.py')
scope = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(scope)


class SelectionTests(unittest.TestCase):
    def assert_plan(self, paths, event='push', regression=False, gui=False, release=False, **kw):
        self.assertEqual(scope.plan(paths, event=event, **kw), {
            'regression': regression, 'ubuntu_gui': gui, 'release': release,
        })

    def test_documentation_never_triggers_automatic_jobs(self):
        paths = ['README.md', 'KNOWN_ISSUES.md', 'RELEASE_NOTES.md',
                 'release/RELEASE_GUIDE.md', 'client/README.md',
                 'standalone/UBUNTU_PACKAGING.md', 'tools/apk-patcher/README.md',
                 'standalone/mltd/models/README.md', 'tests/README.rst',
                 'docs/usage.adoc']
        for event in ('push', 'pull_request'):
            for path in paths:
                with self.subTest(event=event, path=path):
                    self.assertFalse(scope.path_matches(path, scope.VALIDATION_PATHS))
                    self.assert_plan([path], event=event)

    def test_main_runtime_change_validates_and_publishes(self):
        self.assert_plan(['standalone/mltd/services/job.py'], regression=True, release=True)

    def test_pull_request_never_publishes(self):
        self.assert_plan(['standalone/mltd/services/job.py'], event='pull_request', regression=True)

    def test_mixed_documentation_and_code_is_not_skipped(self):
        self.assert_plan(['README.md', 'standalone/mltd/services/job.py'], regression=True, release=True)

    def test_tests_only_do_not_publish(self):
        self.assert_plan(['tests/test_job_compat_runtime.py'], regression=True)

    def test_policy_and_yaml_only_need_lightweight_checks(self):
        for path in ('tools/ci_scope.py', 'tests/test_ci_policy.py',
                     'tests/test_release_guidance.py', '.github/workflows/ci.yml',
                     '.github/workflows/build-and-release.yml', '.gitattributes'):
            with self.subTest(path=path):
                self.assertTrue(scope.path_matches(path, scope.VALIDATION_PATHS))
                self.assert_plan([path])

    def test_renderer_and_maintenance_tools_do_not_publish(self):
        for path in ('tools/render_release_notes.py', 'tools/client-source/extract-il2cpp.sh',
                     'client/contract/rpc-methods-zh-fixed-v1.txt'):
            with self.subTest(path=path):
                self.assert_plan([path])
        self.assert_plan(['tools/cache_assets.py'], regression=True)

    def test_gui_pull_request_runs_packaging(self):
        self.assert_plan(['standalone/gui.pyw'], event='pull_request', regression=True, gui=True)

    def test_ubuntu_spec_pull_request_does_not_need_database_tests(self):
        self.assert_plan(['standalone/gui_ubuntu.spec'], event='pull_request', gui=True)

    def test_non_ubuntu_spec_does_not_build_ubuntu_on_pr(self):
        self.assert_plan(['standalone/gui_windows.spec'], event='pull_request')

    def test_main_release_does_not_duplicate_ubuntu_build(self):
        self.assert_plan(['standalone/gui.pyw', 'standalone/gui_ubuntu.spec'],
                         regression=True, release=True)

    def test_dependency_change_is_validated_on_both_events(self):
        self.assert_plan(['requirements.txt'], regression=True, release=True)
        self.assert_plan(['requirements.txt'], event='pull_request', regression=True, gui=True)

    def test_all_binary_inputs_can_trigger_release(self):
        for path in ('standalone/mltd/models/mst_data/zh/cards.json',
                     'standalone/mltd/locales/zh/LC_MESSAGES/mltd.mo',
                     'standalone/hook-mltd.services.py', 'tools/apk-patcher/apk-patcher.pyw',
                     'tools/apk-patcher/VERSION', 'tools/fonts/Roboto-Medium.ttf',
                     'key/api.crt', 'app_icon.ico', 'LICENSE', 'release/game-client.env'):
            with self.subTest(path=path):
                self.assert_plan([path], regression=True, release=True)

    def test_certificate_helper_and_console_do_not_rebuild_gui(self):
        self.assert_plan(['key/gencert.cmd'])
        self.assert_plan(['standalone/console.py'], regression=True)

    def test_manual_validation_does_not_publish(self):
        self.assert_plan([], event='workflow_dispatch', regression=True)
        self.assert_plan([], event='workflow_dispatch', regression=True, gui=True, ubuntu_gui=True)

    def test_other_branches_and_events_do_not_publish(self):
        self.assert_plan(['standalone/gui.pyw'], ref='refs/heads/topic')
        self.assert_plan(['standalone/gui.pyw'], event='pull_request_target')
        self.assert_plan([])

    def test_double_star_matches_zero_or_many_directories(self):
        self.assertTrue(scope.path_matches('tests/test_api.py', ('tests/**/*.py',)))
        self.assertTrue(scope.path_matches('tests/nested/test_api.py', ('tests/**/*.py',)))
        self.assertFalse(scope.path_matches('tests/nested/test_api.py', ('tests/*.py',)))
        self.assertFalse(scope.path_matches('tools/note.md', scope.VALIDATION_PATHS))


class WorkflowWiringTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.ci = (ROOT / '.github/workflows/ci.yml').read_text(encoding='utf-8')
        cls.release = (ROOT / '.github/workflows/build-and-release.yml').read_text(encoding='utf-8')

    def test_github_path_filters_match_selector_for_push_and_pr(self):
        for event in ('push', 'pull_request'):
            block = re.search(r'^  ' + event + r':\n(.*?)(?=^  \w+:)',
                              self.ci, flags=re.M | re.S).group(1)
            paths = tuple(ast.literal_eval(line.strip()[2:]) for line in block.splitlines()
                          if line.startswith('      - '))
            self.assertEqual(paths, scope.VALIDATION_PATHS)
            self.assertIn('branches: [main]', block)

    def test_release_requires_successful_main_push(self):
        block = self.ci.split('\n  release:\n', 1)[1]
        for required in ("github.event_name == 'push'", "github.ref == 'refs/heads/main'",
                         "needs.changes.outputs.release == 'true'",
                         "needs.regression.result == 'success'", '!cancelled()',
                         'needs: [changes, regression, ubuntu-gui]',
                         'uses: ./.github/workflows/build-and-release.yml'):
            self.assertIn(required, block)
        self.assertEqual(self.ci.count('contents: write'), 1)
        self.assertIn('contents: write', block)
        self.assertNotIn('pull_request_target:', self.ci)

    def test_release_has_no_independent_push_that_duplicates_checks(self):
        self.assertIn('  workflow_call:', self.release)
        self.assertIn('  workflow_dispatch:', self.release)
        self.assertNotIn('  push:', self.release)
        self.assertNotIn('  pull_request:', self.release)

    def test_release_uses_latest_baseline_and_includes_patcher_fonts(self):
        self.assertIn("git tag --list 'standalone-latest'", self.release)
        self.assertIn('-- tools/apk-patcher tools/fonts requirements.txt', self.release)
        self.assertIn('if: matrix.target == \'Ubuntu\'', self.release)
        self.assertIn('CArchiveReader', self.release)
        self.assertIn('bash tools/smoke-test-ubuntu-gui.sh', self.release)

    def test_failed_diff_is_not_silently_treated_as_no_change(self):
        with self.assertRaises(ValueError):
            scope.changed_paths({'before': '--help', 'after': 'a' * 40}, 'push')
        with self.assertRaises(ValueError):
            scope.changed_paths({}, 'unknown')


class GitDiffTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory()
        cls.addClassCleanup(cls.temp.cleanup)
        cls.root = Path(cls.temp.name)
        def git(*args):
            return subprocess.check_output(['git', '-c', 'core.autocrlf=false',
                                            '-c', 'core.hooksPath=' + str(cls.root / 'no-hooks'),
                                            *args], cwd=cls.root, stderr=subprocess.DEVNULL).decode().strip()
        cls.git = staticmethod(git)
        git('init', '--initial-branch=base')
        git('config', 'user.name', 'CI fixture')
        git('config', 'user.email', 'ci@example.invalid')
        (cls.root / 'README.md').write_text('base\n')
        runtime = cls.root / 'standalone/mltd/services/job.py'
        runtime.parent.mkdir(parents=True)
        runtime.write_text('pass\n')
        git('add', '.'); git('commit', '-m', 'fixture base')
        cls.base = git('rev-parse', 'HEAD')
        (cls.root / 'docs').mkdir()
        for index in range(350):
            (cls.root / f'docs/{index}.md').write_text('documentation\n')
        runtime.rename(cls.root / 'docs/old-job.md')
        (runtime.parent / 'new_job.py').write_text('pass\n')
        git('add', '.'); git('commit', '-m', 'fixture feature')
        cls.head = git('rev-parse', 'HEAD')
        git('switch', '-c', 'base-side', cls.base)
        (cls.root / 'base-only.py').write_text('pass\n')
        git('add', '.'); git('commit', '-m', 'fixture base advance')
        cls.base_advanced = git('rev-parse', 'HEAD')

    def test_push_diff_includes_deleted_runtime_after_rename_to_docs(self):
        files = scope.changed_paths({'before': self.base, 'after': self.head}, 'push', str(self.root))
        self.assertIn('standalone/mltd/services/job.py', files)
        self.assertIn('docs/old-job.md', files)
        self.assertTrue(scope.plan(files, event='push')['release'])

    def test_git_diff_reads_all_paths_without_api_pagination_limit(self):
        files = scope.changed_paths({'before': self.base, 'after': self.head}, 'push', str(self.root))
        self.assertGreater(len(files), 350)
        self.assertIn('standalone/mltd/services/new_job.py', files)

    def test_pull_request_uses_merge_base_not_base_branch_only_changes(self):
        event = {'pull_request': {'base': {'sha': self.base_advanced}, 'head': {'sha': self.head}}}
        files = scope.changed_paths(event, 'pull_request', str(self.root))
        self.assertNotIn('base-only.py', files)
        self.assertIn('standalone/mltd/services/new_job.py', files)

    def test_first_push_compares_to_empty_tree(self):
        files = scope.changed_paths({'before': '0' * 40, 'after': self.base}, 'push', str(self.root))
        self.assertIn('README.md', files)
        self.assertIn('standalone/mltd/services/job.py', files)

    def test_manual_validation_needs_no_git_diff(self):
        self.assertEqual(scope.changed_paths({}, 'workflow_dispatch', str(self.root)), [])


if __name__ == '__main__':
    unittest.main()

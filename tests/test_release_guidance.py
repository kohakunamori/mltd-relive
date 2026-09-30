"""Release guide rendering and the repository's manual-only CI policy."""

import ast
import importlib.util
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import unittest
from urllib.parse import unquote, urlsplit


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / 'tools' / 'render_release_notes.py'
SPEC = importlib.util.spec_from_file_location('release_notes_renderer', SCRIPT)
renderer = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(renderer)


class ReleaseGuideTests(unittest.TestCase):
    def render(self, **overrides):
        values = {'version': '0.1.11', 'commit': 'a' * 40}
        values.update(overrides)
        return renderer.render_notes(**values)

    def test_metadata_is_chinese_and_matches_build(self):
        body = self.render()
        self.assertIn('服务器版本：`v0.1.11`', body)
        self.assertIn('构建提交：`' + 'a' * 40 + '`', body)
        self.assertNotIn('Latest main build', body)
        self.assertNotIn('Standalone source version:', body)
        self.assertNotIn('$version', body)
        self.assertNotIn('$download_url', body)

    def test_download_links_cover_only_expected_required_files(self):
        body = self.render()
        names = set(re.findall(r'/releases/download/standalone-latest/([^\s)]+)', body))
        self.assertEqual(names, {
            'mltd-relive-standalone-latest-windows.exe',
            'mltd-relive-standalone-latest-ubuntu',
            'mltd-relive-standalone-latest-macos.zip',
            'mltd-relive-standalone-latest-ubuntu-NOTICES.txt',
            'mltd-relive-game-client-zh-fixed.apk',
            'mltd-relive-game-client-ko-fixed.apk',
            'SHA256SUMS.txt',
        })

    def test_startup_upgrade_and_network_guidance_is_present(self):
        body = self.render()
        for text in ('Start Server', 'Start DNS Server', 'Reset Data',
                     'mltd-relive.db', 'config.ini', 'MLTD0000',
                     'relive2026', '远端下载', '已知问题', '手动按需更新'):
            with self.subTest(text=text):
                self.assertIn(text, body)

    def test_custom_repository_and_tag_are_used_consistently(self):
        body = self.render(repository='example/project', tag='standalone-v0.1.12',
                           version='v0.1.12')
        self.assertIn('https://github.com/example/project/releases/download/standalone-v0.1.12/', body)
        self.assertIn('mltd-relive-standalone-v0.1.12-ubuntu', body)
        self.assertNotIn('kohakunamori/mltd-relive', body)
        self.assertNotIn('standalone-latest', body)

    def test_invalid_metadata_is_rejected(self):
        for changes in ({'commit': 'main'}, {'commit': 'f82e6975'},
                        {'version': 'latest'}, {'repository': '../bad'},
                        {'tag': 'tag with spaces'}):
            with self.subTest(changes=changes):
                with self.assertRaises(ValueError):
                    self.render(**changes)

    def test_unknown_template_placeholder_is_not_silently_published(self):
        with tempfile.TemporaryDirectory() as directory:
            template = Path(directory) / 'template.md'
            template.write_text('$unknown_placeholder', encoding='utf-8')
            with self.assertRaises(KeyError):
                self.render(template_path=template)

    def test_cli_is_independent_of_working_directory(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / 'notes.md'
            result = subprocess.run(
                [sys.executable, str(SCRIPT), '--version', '0.1.11',
                 '--commit', 'a' * 40, '--output', str(output)],
                cwd=directory, capture_output=True, text=True,
                encoding='utf-8', timeout=15,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(output.read_text(encoding='utf-8'), self.render())


class ManualWorkflowPolicyTests(unittest.TestCase):
    def test_only_two_maintained_workflows_remain(self):
        workflows = {p.name for p in (ROOT / '.github/workflows').glob('*.y*ml')}
        self.assertEqual(workflows, {'ci.yml', 'build-and-release.yml'})

    def test_validation_retains_runtime_migration_and_optional_gui_checks(self):
        source = (ROOT / '.github/workflows/ci.yml').read_text(encoding='utf-8')
        for required in ("unittest discover -s ../tests -p 'test_*.py'",
                         'PRAGMA foreign_key_check', 'PRAGMA journal_mode',
                         'DROP TABLE account_credential', 'upgrade_database()',
                         'CArchiveReader', 'original in embedded',
                         'bash tools/smoke-test-ubuntu-gui.sh',
                         'if: inputs.ubuntu_gui', 'needs: regression'):
            with self.subTest(required=required):
                self.assertIn(required, source)
        self.assertRegex(source, r'ubuntu_gui:\n(?: +[^\n]*\n)*?        default: false\n')
        self.assertIn('  contents: read', source)
        self.assertNotIn('contents: write', source)
        self.assertNotIn('gh release', source)
        self.assertNotIn('release-action', source)

    def test_all_workflows_are_manually_triggered(self):
        workflows = sorted((ROOT / '.github' / 'workflows').glob('*.y*ml'))
        self.assertTrue(workflows)
        for path in workflows:
            with self.subTest(workflow=path.name):
                lines = path.read_text(encoding='utf-8').splitlines()
                start = next(i for i, line in enumerate(lines) if line.startswith('on:'))
                end = next((i for i in range(start + 1, len(lines))
                            if lines[i] and not lines[i][0].isspace()
                            and not lines[i].startswith('#')), len(lines))
                inline = lines[start][3:].strip()
                if inline:
                    self.assertEqual(inline, '[workflow_dispatch]')
                else:
                    events = re.findall(r'^  ([a-z_]+):',
                                        '\n'.join(lines[start + 1:end]), re.MULTILINE)
                    self.assertEqual(events, ['workflow_dispatch'])

    def test_publish_uses_shared_renderer_and_guards_main(self):
        source = (ROOT / '.github/workflows/build-and-release.yml').read_text(encoding='utf-8')
        self.assertIn('python tools/render_release_notes.py', source)
        self.assertIn("if: github.ref == 'refs/heads/main'", source)
        self.assertIn('bodyFile: rolling-release-notes.md', source)
        self.assertIn('name: mltd-relive v${{ needs.metadata.outputs.standalone_version }}｜本地服务器与客户端下载', source)

    def test_readme_avoids_internal_policy_slogans(self):
        source = (ROOT / 'README.md').read_text(encoding='utf-8')
        for phrase in ('项目原则是', '伪造', '真实状态语义'):
            with self.subTest(phrase=phrase):
                self.assertNotIn(phrase, source)
        self.assertIn('按需构建与发布', source)
        self.assertIn('Start DNS Server', source)


class RepositoryLayoutTests(unittest.TestCase):
    def test_local_documentation_links_resolve(self):
        documents = sorted(ROOT.glob('*.md')) + [
            ROOT / 'client/README.md', ROOT / 'standalone/UBUNTU_PACKAGING.md',
        ]
        for document in documents:
            text = document.read_text(encoding='utf-8')
            for target in re.findall(r'\[[^\]\n]*\]\(([^\s)]+)\)', text):
                url = urlsplit(target)
                if url.scheme or url.netloc or not url.path:
                    continue
                with self.subTest(document=document.name, target=target):
                    self.assertTrue((document.parent / unquote(url.path)).exists())

    def test_packaging_entrypoints_and_local_resources_exist(self):
        specs = sorted((ROOT / 'standalone').glob('*.spec'))
        specs += sorted((ROOT / 'tools/apk-patcher').glob('*.spec'))
        self.assertTrue(specs)
        for spec in specs:
            tree = ast.parse(spec.read_text(encoding='utf-8'))
            paths = []
            for node in ast.walk(tree):
                if not isinstance(node, ast.Call):
                    continue
                if isinstance(node.func, ast.Name) and node.args:
                    if node.func.id == 'Tree':
                        paths.append(ast.literal_eval(node.args[0]))
                    elif node.func.id == 'Analysis':
                        paths.extend(ast.literal_eval(node.args[0]))
                for keyword in node.keywords:
                    if keyword.arg == 'icon':
                        value = ast.literal_eval(keyword.value)
                        paths.extend(value if isinstance(value, list) else [value])
            for path in paths:
                with self.subTest(spec=spec.name, path=path):
                    self.assertTrue((spec.parent / path).exists())


if __name__ == '__main__':
    unittest.main()

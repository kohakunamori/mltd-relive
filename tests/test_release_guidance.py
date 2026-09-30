"""Release guide rendering and the repository's manual-only CI policy."""

import importlib.util
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import unittest


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


if __name__ == '__main__':
    unittest.main()

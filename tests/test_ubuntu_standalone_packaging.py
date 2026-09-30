"""Packaging regressions; shell fixtures test policy, not a real GUI launch."""
import ast
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest
from types import SimpleNamespace
from unittest.mock import patch


ROOT = Path(__file__).resolve().parents[1]
SPEC = ROOT / 'standalone' / 'gui_ubuntu.spec'
SMOKE = ROOT / 'tools' / 'smoke-test-ubuntu-gui.sh'


def spec_helpers():
    tree = ast.parse(SPEC.read_text(encoding='utf-8'), filename=str(SPEC))
    nodes = [node for node in tree.body
             if isinstance(node, (ast.Import, ast.ImportFrom, ast.FunctionDef))]
    namespace = {}
    exec(compile(ast.Module(body=nodes, type_ignores=[]), str(SPEC), 'exec'), namespace)
    return namespace


class TkPackagingTests(unittest.TestCase):
    def setUp(self):
        self.helpers = spec_helpers()

    def test_library_lookup_requires_exact_soname(self):
        cache = ('2 libs found in cache:\n'
                 ' libtk8.6.so.0 (libc6,x86-64) => /wrong/libtk8.6.so.0\n'
                 ' libtk8.6.so (libc6,x86-64) => /usr/lib/libtk8.6.so\n')
        with patch.object(shutil, 'which', return_value='/sbin/ldconfig'), \
                patch.object(subprocess, 'check_output', return_value=cache) as command:
            self.assertEqual(self.helpers['find_runtime_library']('libtk8.6.so'),
                             '/usr/lib/libtk8.6.so')
            command.assert_called_once_with(['/sbin/ldconfig', '-p'], text=True)

    def test_missing_library_fails_build(self):
        with patch.object(subprocess, 'check_output', return_value='invalid cache line'):
            with self.assertRaisesRegex(RuntimeError, 'libtk8.6.so'):
                self.helpers['find_runtime_library']('libtk8.6.so')

    def test_notices_are_retained_byte_for_byte(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            originals = (b'Tk copyright\r\nFull Tk terms.\n',
                         b'Tcl copyright\nFull Tcl terms.\nAdditional notices.\n')
            for package, original in zip(('libtk8.6', 'libtcl8.6'), originals):
                directory = root / 'doc' / package
                directory.mkdir(parents=True)
                (directory / 'copyright').write_bytes(original)
            destination = root / 'build' / 'notices.txt'
            actual = self.helpers['write_tk_notices'](destination, root / 'doc')
            self.assertEqual(actual, str(destination))
            for original in originals:
                self.assertIn(original, destination.read_bytes())

    def test_missing_notice_fails_without_creating_output(self):
        with tempfile.TemporaryDirectory() as tmp:
            destination = Path(tmp) / 'notices.txt'
            with self.assertRaisesRegex(RuntimeError, 'notice is unavailable'):
                self.helpers['write_tk_notices'](destination, Path(tmp) / 'doc')
            self.assertFalse(destination.exists())

    def test_empty_notice_fails_without_creating_output(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            directory = root / 'libtk8.6'
            directory.mkdir()
            (directory / 'copyright').write_bytes(b' \n')
            destination = root / 'notices.txt'
            with self.assertRaisesRegex(RuntimeError, 'notice is empty'):
                self.helpers['write_tk_notices'](destination, root)
            self.assertFalse(destination.exists())

    def test_spec_embeds_notices_and_keeps_build_metadata(self):
        source = SPEC.read_text(encoding='utf-8')
        compile(source, str(SPEC), 'exec')
        self.assertIn("datas=[(tk_notice, 'licenses')]", source)
        self.assertIn('shutil.copyfile(tk_notice, Path(DISTPATH) / TK_NOTICE_FILENAME)', source)
        self.assertIn("os.environ['GITHUB_SHA']", source)
        self.assertIn("Path('mltd/build_info.py').write_text", source)

    def test_spec_executes_with_pyinstaller_5_namespace(self):
        # Exercise the complete spec with build primitives stubbed, not a real build.
        source = SPEC.read_text(encoding='utf-8')
        cache = ('libtk8.6.so (libc6) => /usr/lib/libtk8.6.so\n'
                 'libtcl8.6.so (libc6) => /usr/lib/libtcl8.6.so\n')
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            dist = root / 'dist'
            dist.mkdir()
            namespace = {
                'workpath': str(root / 'build'),
                'DISTPATH': str(dist),
                'Analysis': lambda *args, **kwargs: SimpleNamespace(
                    pure=[], zipped_data=[], scripts=[], binaries=[], zipfiles=[],
                    datas=kwargs['datas']),
                'Tree': lambda *args, **kwargs: [],
                'PYZ': lambda *args, **kwargs: None,
                'EXE': lambda *args, **kwargs: None,
            }
            with patch.dict(os.environ, {'GITHUB_SHA': ''}), \
                    patch.object(subprocess, 'check_output', return_value=cache), \
                    patch.object(Path, 'read_bytes', return_value=b'Copyright test fixture.\n'):
                exec(compile(source, str(SPEC), 'exec'), namespace)
            filename = namespace['TK_NOTICE_FILENAME']
            generated = root / 'build' / filename
            self.assertEqual(namespace['a'].datas, [(str(generated), 'licenses')])
            self.assertEqual((dist / filename).read_bytes(), generated.read_bytes())

    def test_release_upload_includes_notice_sidecar(self):
        source = (ROOT / '.github/workflows/build-and-release.yml').read_text(encoding='utf-8')
        self.assertIn('cp standalone/dist/mltd-relive-standalone-ubuntu-NOTICES.txt', source)
        self.assertIn('release-output/mltd-relive-${RELEASE_TAG}-ubuntu-NOTICES.txt', source)
        self.assertIn('path: standalone/dist/release-output/*', source)


@unittest.skipUnless(sys.platform.startswith('linux'), 'Bash policy tests run on Linux')
class SmokePolicyTests(unittest.TestCase):
    def run_policy(self, status, output=''):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            # Replace only timeout to exercise exit/log policy without launching a GUI.
            timeout = root / 'timeout'
            timeout.write_text('#!/bin/sh\nprintf "%s\n" "$SMOKE_TEST_OUTPUT"\n'
                               'exit "$SMOKE_TEST_STATUS"\n', encoding='utf-8')
            timeout.chmod(0o755)
            env = dict(os.environ, PATH=str(root) + os.pathsep + os.environ['PATH'],
                       SMOKE_TEST_STATUS=str(status), SMOKE_TEST_OUTPUT=output)
            return subprocess.run(['bash', str(SMOKE), sys.executable], env=env,
                                  capture_output=True, text=True, timeout=15)

    def test_early_successful_exit_is_failure(self):
        result = self.run_policy(0)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('status 0', result.stderr)

    def test_crashed_gui_is_failure(self):
        result = self.run_policy(1)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('status 1', result.stderr)

    def test_only_expected_timeout_passes(self):
        result = self.run_policy(124)
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_startup_error_still_fails_after_timeout(self):
        result = self.run_policy(124, 'ImportError: libtk8.6.so: cannot open shared object file')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('startup error', result.stderr)


if __name__ == '__main__':
    unittest.main()

"""Decide which CI jobs are needed from the actual Git change set.

No network calls or third-party dependencies. Documentation is filtered both by
GitHub's workflow paths and here, before expensive jobs or publishing can run.
"""

import json
import os
from pathlib import Path
import re
import subprocess


VALIDATION_PATHS = (
    'standalone/**', 'tests/**', 'tools/**', 'client/**', 'key/**',
    'requirements.txt', 'app_icon.*', 'LICENSE', 'release/game-client.env',
    '.github/workflows/ci.yml', '.github/workflows/build-and-release.yml',
    '.gitattributes', '!**/*.md', '!**/*.rst', '!**/*.adoc',
)
RELEASE_PATHS = (
    'standalone/gui.pyw', 'standalone/gui_*.spec', 'standalone/hook-*.py',
    'standalone/mltd/**', 'tools/apk-patcher/**', 'tools/fonts/**',
    'requirements.txt', 'app_icon.*', 'key/**', 'LICENSE',
    'release/game-client.env', '!key/*.cmd',
)
REGRESSION_PATHS = (
    'standalone/**/*.py', 'standalone/**/*.pyw',
    'standalone/mltd/models/mst_data/**', 'standalone/mltd/locales/**',
    'tests/**/*.py', 'tools/cache_assets.py', 'requirements.txt',
    '!tests/test_ci_policy.py', '!tests/test_release_guidance.py',
    '!tests/test_ubuntu_standalone_packaging.py',
)
GUI_PATHS = (
    'standalone/gui.pyw', 'standalone/mltd/gui_accounts.py',
    'standalone/gui_ubuntu.spec', 'standalone/hook-*.py', 'requirements.txt',
    'tools/smoke-test-ubuntu-gui.sh', 'tests/test_ubuntu_standalone_packaging.py',
)


def path_matches(path: str, patterns: tuple[str, ...]) -> bool:
    """Match the ordered *, ** and **/ patterns used by this repository."""
    matched = False
    for pattern in patterns:
        exclude = pattern.startswith('!')
        pattern = pattern.removeprefix('!')
        tokens = re.split(r'(\*\*/|\*\*|\*)', pattern)
        expression = ''.join({
            '**/': '(?:.*/)?', '**': '.*', '*': '[^/]*',
        }.get(token, re.escape(token)) for token in tokens)
        if re.fullmatch(expression, path):
            matched = not exclude
    return matched


def plan(paths: list[str], *, event: str, ref: str = 'refs/heads/main',
         ubuntu_gui: bool = False) -> dict[str, bool]:
    result = {'regression': False, 'ubuntu_gui': False, 'release': False}
    if event == 'workflow_dispatch':
        return dict(result, regression=True, ubuntu_gui=ubuntu_gui)
    if event not in {'push', 'pull_request'} or (event == 'push' and ref != 'refs/heads/main'):
        return result
    relevant = [p for p in paths if path_matches(p, VALIDATION_PATHS)]
    result['release'] = event == 'push' and any(path_matches(p, RELEASE_PATHS) for p in relevant)
    result['regression'] = result['release'] or any(path_matches(p, REGRESSION_PATHS) for p in relevant)
    # A main-branch release checks the actual Ubuntu artifact during its build;
    # do not build that same binary a second time in the validation workflow.
    result['ubuntu_gui'] = event == 'pull_request' and any(path_matches(p, GUI_PATHS) for p in relevant)
    return result


def git(*args: str, cwd: str | None = None, data: bytes | None = None) -> bytes:
    return subprocess.run(['git', *args], input=data, cwd=cwd, check=True,
                          stdout=subprocess.PIPE, stderr=subprocess.PIPE).stdout


def changed_paths(event: dict, name: str, cwd: str | None = None) -> list[str]:
    """Read all changed paths, including both sides of renames; fail on errors."""
    if name == 'workflow_dispatch':
        return []
    if name == 'pull_request':
        base = event['pull_request']['base']['sha']
        head = event['pull_request']['head']['sha']
    elif name == 'push':
        base, head = event['before'], event['after']
    else:
        raise ValueError(f'Unsupported CI event: {name}')
    for value in (base, head):
        if not re.fullmatch(r'[0-9a-fA-F]{40}', value):
            raise ValueError('Git comparison requires full commit hashes')
    if name == 'pull_request':
        base = git('merge-base', base, head, cwd=cwd).decode().strip()
    elif base == '0' * 40:
        base = git('hash-object', '-t', 'tree', '--stdin', cwd=cwd, data=b'').decode().strip()
    output = git('diff', '--name-only', '--no-renames', '-z', base, head, '--', cwd=cwd)
    return [p.decode('utf-8', errors='surrogateescape') for p in output.split(b'\0') if p]


def main() -> None:
    event_name = os.environ['GITHUB_EVENT_NAME']
    event = json.loads(Path(os.environ['GITHUB_EVENT_PATH']).read_text(encoding='utf-8'))
    paths = changed_paths(event, event_name)
    result = plan(paths, event=event_name, ref=os.environ.get('GITHUB_REF', ''),
                  ubuntu_gui=os.environ.get('REQUEST_UBUNTU_GUI', '').lower() == 'true')
    print(json.dumps({'changed_files': len(paths), **result}, ensure_ascii=False))
    with open(os.environ['GITHUB_OUTPUT'], 'a', encoding='utf-8') as output:
        for name, enabled in result.items():
            output.write(f'{name}={str(enabled).lower()}\n')


if __name__ == '__main__':
    main()

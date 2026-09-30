"""从同一份中文模板生成 GitHub 发布指南，不访问网络或修改发布附件。"""

import argparse
from pathlib import Path
import re
from string import Template


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_TEMPLATE = ROOT / 'release' / 'RELEASE_GUIDE.md'


def render_notes(*, version: str, commit: str,
                 repository: str = 'kohakunamori/mltd-relive',
                 tag: str = 'standalone-latest',
                 template_path: Path | None = None) -> str:
    """渲染已发布或即将发布的构建信息；构建提交必须来自对应附件。"""
    version = version.removeprefix('v')
    if not re.fullmatch(r'\d+\.\d+\.\d+(?:[-+][0-9A-Za-z.-]+)?', version):
        raise ValueError('版本号格式无效')
    if not re.fullmatch(r'[0-9a-fA-F]{40}', commit):
        raise ValueError('必须提供下载包对应的完整 40 位构建提交')
    if (not re.fullmatch(r'[A-Za-z0-9][A-Za-z0-9-]*/[A-Za-z0-9_.-]+', repository)
            or repository.rsplit('/', 1)[-1] in {'.', '..'}):
        raise ValueError('仓库名称必须使用 owner/repository 格式')
    if not re.fullmatch(r'[A-Za-z0-9_.-]+', tag):
        raise ValueError('发布标签只能包含字母、数字、点、下划线和连字符')

    repository_url = f'https://github.com/{repository}'
    template = Template((template_path or DEFAULT_TEMPLATE).read_text(encoding='utf-8'))
    return template.substitute(
        version=version,
        commit=commit.lower(),
        tag=tag,
        repository_url=repository_url,
        download_url=f'{repository_url}/releases/download/{tag}',
        standalone_prefix=f'mltd-relive-{tag}',
    )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--version', required=True, help='下载包对应的服务器版本')
    parser.add_argument('--commit', required=True, help='下载包对应的完整构建提交')
    parser.add_argument('--repository', default='kohakunamori/mltd-relive')
    parser.add_argument('--tag', default='standalone-latest')
    parser.add_argument('--template', type=Path, default=DEFAULT_TEMPLATE)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    try:
        content = render_notes(
            version=args.version, commit=args.commit,
            repository=args.repository, tag=args.tag,
            template_path=args.template,
        )
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(content, encoding='utf-8', newline='\n')
    except (OSError, ValueError, KeyError) as exc:
        parser.exit(2, f'发布指南生成失败：{exc}\n')


if __name__ == '__main__':
    main()

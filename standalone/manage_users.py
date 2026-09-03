import argparse
import json
import sys

from mltd.accounts import register_account


def main() -> int:
    parser = argparse.ArgumentParser(
        description='Manage mltd-relive external user accounts.'
    )
    subparsers = parser.add_subparsers(dest='command', required=True)

    register = subparsers.add_parser(
        'register', help='register a user and create an independent full save'
    )
    register.add_argument('username', help='exactly 8 ASCII letters/digits')
    register.add_argument('password', help='8 to 64 characters')
    register.add_argument(
        '--display-name',
        default=None,
        help='in-game display name (1 to 10 characters; defaults to username)',
    )

    args = parser.parse_args()
    try:
        if args.command == 'register':
            result = register_account(
                args.username,
                args.password,
                display_name=args.display_name,
            )
            print(json.dumps(result, ensure_ascii=False, indent=2))
            return 0
    except (ValueError, RuntimeError) as exc:
        print(f'error: {exc}', file=sys.stderr)
        return 2
    return 1


if __name__ == '__main__':
    raise SystemExit(main())

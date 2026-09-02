import argparse

from mltd.servers.asset_cache import REMOTE_ASSET_ROOT
from mltd.servers.relay_server import relay_port, start


def parse_args():
    parser = argparse.ArgumentParser(
        description='Run the independent MLTD Asset Relay Server.'
    )
    parser.add_argument('--host', default='', help='Listen address (default: all).')
    parser.add_argument('--port', type=int, default=relay_port)
    parser.add_argument(
        '--root', default='asset-relay-cache',
        help='Persistent relay cache directory.',
    )
    parser.add_argument(
        '--cache-only', action='store_true',
        help='Never contact the upstream; serve cached objects only.',
    )
    parser.add_argument(
        '--upstream', default=REMOTE_ASSET_ROOT,
        help='Upstream Asset root.',
    )
    parser.add_argument(
        '--proxy', default='',
        help='Optional HTTP/SOCKS proxy used for cache-miss upstream requests.',
    )
    parser.add_argument(
        '--timeout', type=float, default=60.0,
        help='Upstream request timeout in seconds.',
    )
    return parser.parse_args()


def main():
    args = parse_args()
    start(
        host=args.host,
        port=args.port,
        root=args.root,
        cache_only=args.cache_only,
        remote_root=args.upstream,
        upstream_proxy=(args.proxy.strip() or None),
        upstream_timeout=max(1.0, args.timeout),
    )


if __name__ == '__main__':
    main()

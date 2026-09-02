import argparse
import os
import signal
import time
from multiprocessing import freeze_support, set_start_method

from mltd.models.setup import cleanup, setup, upgrade_database
from mltd.servers import dns, proxy
from mltd.servers.config import ASSET_MODES, config, version
from mltd.servers.logging import handler, logger
from mltd.servers.process import CustomProcess


POLL_INTERVAL_SECONDS = 0.2


def _configure_from_args(args):
    if args.language:
        config.language = args.language
    if args.asset_mode:
        config.asset_mode = args.asset_mode
    if args.asset_proxy is not None:
        config.asset_upstream_proxy = args.asset_proxy


def _prepare_database(reset=False):
    database_path = 'mltd-relive.db'
    if reset and os.path.isfile(database_path):
        cleanup()
        logger.info('Dropped all tables.')

    if reset or not os.path.isfile(database_path):
        setup()

    upgrade_database()


def _stop_processes(processes):
    for process in processes:
        if process.is_alive():
            process.terminate()
    for process in processes:
        process.join(timeout=5)


def _raise_process_error(processes):
    for process in processes:
        exception = process.exception
        if exception:
            raise RuntimeError(exception)


def _wait_until_ready(processes):
    while True:
        _raise_process_error(processes)
        if all(process.is_ready() for process in processes):
            return
        for process in processes:
            if not process.is_alive() and not process.is_ready():
                raise RuntimeError(
                    f'{process.name} exited before reporting ready.'
                )
        time.sleep(POLL_INTERVAL_SECONDS)


def run_server(reset=False):
    handler.doRollover()
    _prepare_database(reset=reset)

    logger.info('Starting headless standalone server...')
    proxy_process = CustomProcess(target=proxy.start, daemon=True)
    dns_process = CustomProcess(target=dns.start, daemon=True)
    processes = [proxy_process, dns_process]

    for process in processes:
        process.start()

    try:
        _wait_until_ready(processes)
        logger.info(
            f'Server started. TLS/API port: {proxy.proxy_port}; '
            f'DNS port: {dns.dns_port}; asset mode: {config.asset_mode}'
        )

        while True:
            _raise_process_error(processes)
            stopped = [process for process in processes if not process.is_alive()]
            if stopped:
                names = ', '.join(process.name for process in stopped)
                raise RuntimeError(f'Server process exited unexpectedly: {names}')
            time.sleep(POLL_INTERVAL_SECONDS)
    except KeyboardInterrupt:
        logger.info('Stopping server...')
    finally:
        _stop_processes(processes)


def _check_bundle():
    certfile = os.path.join(proxy.key_path(), 'api.crt')
    keyfile = os.path.join(proxy.key_path(), 'api.key')
    missing = [path for path in (certfile, keyfile) if not os.path.isfile(path)]
    if missing:
        raise RuntimeError(
            'Packaged TLS resources are missing: ' + ', '.join(missing)
        )
    print(
        f'mltd-relive headless standalone v{version}: OK '
        f'(TLS/API {proxy.proxy_port}, DNS {dns.dns_port})'
    )


def _build_parser():
    parser = argparse.ArgumentParser(
        description='Headless mltd-relive standalone server.'
    )
    parser.add_argument('--version', action='version', version=version)
    parser.add_argument(
        '-l', '--language', choices=['zh', 'ko'],
        help='game client language',
    )
    parser.add_argument(
        '--asset-mode', choices=ASSET_MODES,
        help='asset source mode',
    )
    parser.add_argument(
        '--asset-proxy',
        help='HTTP proxy used only for outbound asset CDN requests',
    )
    parser.add_argument(
        '-r', '--reset', action='store_true',
        help='reset and recreate the database before starting',
    )
    parser.add_argument(
        '--check', action='store_true',
        help='validate the packaged headless runtime and exit',
    )
    return parser


def main():
    args = _build_parser().parse_args()
    _configure_from_args(args)
    if args.check:
        _check_bundle()
        return

    signal.signal(signal.SIGTERM, lambda *_: (_ for _ in ()).throw(KeyboardInterrupt()))
    run_server(reset=args.reset)


if __name__ == '__main__':
    freeze_support()
    set_start_method('spawn')
    main()

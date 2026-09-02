import argparse
import os
import sys
import time
from logging import StreamHandler
from multiprocessing import freeze_support, set_start_method

from mltd.models.setup import (check_database_version, cleanup, setup,
                               upgrade_database)
from mltd.servers import api_server
from mltd.servers.config import config
from mltd.servers.logging import formatter, handler, logger
from mltd.servers.process import CustomProcess

stream_handler = StreamHandler(sys.stdout)
stream_handler.setFormatter(formatter)
logger.addHandler(stream_handler)


def wait_ready(processes):
    while not all(process.is_ready() for process in processes):
        for process in processes:
            if process.exception:
                raise RuntimeError(process.exception)
        time.sleep(0.2)


def start_server(reset=False):
    if reset or not os.path.isfile('mltd-relive.db'):
        reset_data()
    upgrade_database()

    handler.doRollover()
    logger.info('Starting server...')
    api_process = CustomProcess(target=api_server.start, daemon=True)
    api_process.start()
    wait_ready([api_process])
    if config.asset_remote_url:
        logger.info(f'Asset transport: remote {config.asset_remote_url}')
    else:
        logger.info('Asset transport: default remote CDN')
    logger.info('Server started.')
    api_process.join()


def reset_data():
    if os.path.isfile('mltd-relive.db'):
        check_database_version()
        decision = input('Database already exists. Reset all data? [Y/N] ')
        if decision.upper() != 'Y':
            exit()
        cleanup()
        logger.info('Dropped all tables.')

    handler.doRollover()
    setup()


if __name__ == '__main__':
    freeze_support()
    set_start_method('spawn')

    parser = argparse.ArgumentParser()
    parser.add_argument('-l', '--language', choices=['zh', 'ko'],
                        help='game client language')
    parser.add_argument('-r', '--reset', action='store_true',
                        help='reset data')
    parser.add_argument('-c', '--config-only', action='store_true',
                        help='only update config; do not start server')
    parser.add_argument(
        '--asset-url',
        help=(
            'optional trusted HTTPS Asset root; leave unset to use the '
            'default Rainbow remote endpoint'
        ),
    )
    args = parser.parse_args()

    config.is_local = True
    if args.language:
        config.language = args.language
    if args.asset_url is not None:
        config.asset_remote_url = args.asset_url
    if args.config_only:
        sys.exit()
    start_server(args.reset)

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        pass

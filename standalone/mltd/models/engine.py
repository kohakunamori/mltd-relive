import logging
import time

from sqlalchemy import create_engine, event
from sqlalchemy.engine import Engine

from mltd.servers.logging import logger

engine = create_engine(
    'sqlite+pysqlite:///mltd-relive.db',
    connect_args={'timeout': 5},
)


@event.listens_for(Engine, 'connect')
def set_sqlite_pragma(dbapi_connection, connection_record):
    cursor = dbapi_connection.cursor()
    cursor.execute('PRAGMA foreign_keys=ON')
    cursor.execute('PRAGMA busy_timeout=5000')
    cursor.execute('PRAGMA journal_mode=WAL')
    cursor.execute('PRAGMA synchronous=NORMAL')
    cursor.execute('PRAGMA temp_store=MEMORY')
    cursor.execute('PRAGMA cache_size=-32768')
    cursor.close()


# SQLAlchemy events sit directly on the query hot path. At normal INFO level,
# do not register them at all; this avoids two Python callbacks per statement.
if logger.isEnabledFor(logging.DEBUG):

    @event.listens_for(Engine, 'before_cursor_execute')
    def before_cursor_execute(conn, cursor, statement,
                              parameters, context, executemany):
        conn.info.setdefault('query_start_time', []).append(
            time.perf_counter_ns()
        )
        logger.debug(f'Start query: {statement}')
        logger.debug(f'Parameters: {parameters}')

    @event.listens_for(Engine, 'after_cursor_execute')
    def after_cursor_execute(conn, cursor, statement,
                             parameters, context, executemany):
        starts = conn.info.get('query_start_time')
        if not starts:
            return
        total_ns = time.perf_counter_ns() - starts.pop(-1)
        logger.debug(f'Query complete in {total_ns / 1_000_000:.2f} ms')

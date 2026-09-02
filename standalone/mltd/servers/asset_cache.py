import hashlib
import os
import sqlite3
import threading
import time
from contextlib import contextmanager
from pathlib import Path
from typing import Iterable

from msgpack import unpackb

REMOTE_ASSET_ROOT = 'https://assets.rainbowunicorn7297.com'
MANIFEST_NAMES = {
    'zh': '85822153578df611a4f852d4e02660f6f34401e4.data',
    'ko': '25c292462510f60200eecd8080f4680114b8c576.data',
}
SUPPORTED_LANGUAGES = frozenset(MANIFEST_NAMES)
SUPPORTED_PLATFORMS = frozenset({'android', 'ios'})


def _safe_component(value: str) -> str:
    if not value or value in {'.', '..'} or '/' in value or '\\' in value:
        raise ValueError(f'Unsafe asset path component: {value!r}')
    return value


def scope_name(language: str, platform: str) -> str:
    language = language.lower()
    platform = platform.lower()
    if language not in SUPPORTED_LANGUAGES:
        raise ValueError(f'Unsupported language: {language}')
    if platform not in SUPPORTED_PLATFORMS:
        raise ValueError(f'Unsupported platform: {platform}')
    return f'{language}-{platform}'


def manifest_name(language: str) -> str:
    try:
        return MANIFEST_NAMES[language.lower()]
    except KeyError as exc:
        raise ValueError(f'Unsupported language: {language}') from exc


def parse_manifest_objects(data: bytes) -> list[str]:
    manifest = unpackb(data, raw=False)
    if not isinstance(manifest, (list, tuple)) or not manifest:
        raise ValueError('Invalid MLTD asset manifest: missing root table')
    table = manifest[0]
    if not isinstance(table, dict):
        raise ValueError('Invalid MLTD asset manifest: root table is not a map')

    objects: list[str] = []
    seen: set[str] = set()
    for record in table.values():
        if not isinstance(record, (list, tuple)) or len(record) < 2:
            raise ValueError('Invalid MLTD asset manifest: malformed asset record')
        name = record[1]
        if isinstance(name, bytes):
            name = name.decode('utf-8')
        if not isinstance(name, str):
            raise ValueError('Invalid MLTD asset manifest: object name is not text')
        _safe_component(name)
        if name not in seen:
            objects.append(name)
            seen.add(name)
    return objects


class AssetStore:
    """Persistent on-disk Asset mirror format shared by mirror and server.

    This class intentionally contains no networking. The Asset Mirror tool is
    responsible for populating it; Asset Server only reads from it.
    """

    def __init__(self, root: str | os.PathLike[str] = 'asset-archive'):
        self.root = Path(root)
        self.root.mkdir(parents=True, exist_ok=True)
        self.db_path = self.root / '.asset-index.sqlite3'
        self._scope_dirs: dict[str, Path] = {}
        self._scope_dirs_lock = threading.Lock()
        self._init_db()

    def _connect(self):
        conn = sqlite3.connect(self.db_path, timeout=30)
        conn.execute('PRAGMA busy_timeout=30000')
        conn.execute('PRAGMA synchronous=NORMAL')
        conn.execute('PRAGMA temp_store=MEMORY')
        return conn

    @contextmanager
    def _connection(self):
        conn = self._connect()
        try:
            yield conn
            conn.commit()
        except Exception:
            conn.rollback()
            raise
        finally:
            conn.close()

    def _init_db(self):
        with self._connection() as conn:
            conn.execute('PRAGMA journal_mode=WAL')
            conn.execute('''
                CREATE TABLE IF NOT EXISTS object_metadata (
                    scope TEXT NOT NULL,
                    name TEXT NOT NULL,
                    status INTEGER NOT NULL DEFAULT 200,
                    size INTEGER NOT NULL,
                    sha256 TEXT NOT NULL,
                    content_type TEXT,
                    etag TEXT,
                    last_modified TEXT,
                    cache_control TEXT,
                    content_encoding TEXT,
                    fetched_at REAL NOT NULL,
                    PRIMARY KEY (scope, name)
                )
            ''')

    def scope_dir(self, language: str, platform: str) -> Path:
        scope = scope_name(language, platform)
        directory = self._scope_dirs.get(scope)
        if directory is not None:
            return directory
        with self._scope_dirs_lock:
            directory = self._scope_dirs.get(scope)
            if directory is None:
                directory = self.root / scope
                directory.mkdir(parents=True, exist_ok=True)
                self._scope_dirs[scope] = directory
        return directory

    def object_path(self, language: str, platform: str, name: str) -> Path:
        _safe_component(name)
        return self.scope_dir(language, platform) / name

    def part_path(self, language: str, platform: str, name: str) -> Path:
        return self.object_path(language, platform, name).with_name(name + '.part')

    @staticmethod
    def _metadata_keys():
        return (
            'status', 'size', 'sha256', 'content_type', 'etag',
            'last_modified', 'cache_control', 'content_encoding', 'fetched_at'
        )

    def get_metadata(self, language: str, platform: str, name: str):
        scope = scope_name(language, platform)
        with self._connection() as conn:
            row = conn.execute('''
                SELECT status, size, sha256, content_type, etag,
                       last_modified, cache_control, content_encoding, fetched_at
                  FROM object_metadata
                 WHERE scope = ? AND name = ?
            ''', (scope, name)).fetchone()
        if row is None:
            return None
        return dict(zip(self._metadata_keys(), row))

    @staticmethod
    def _metadata_record(scope: str, name: str, *, status: int, size: int,
                         sha256: str, headers, fetched_at: float | None = None):
        def header(key):
            return headers.get(key) if headers else None

        return (
            scope, name, status, size, sha256,
            header('Content-Type'), header('ETag'), header('Last-Modified'),
            header('Cache-Control'), header('Content-Encoding'),
            time.time() if fetched_at is None else fetched_at,
        )

    def put_metadata(self, language: str, platform: str, name: str,
                     *, status: int, size: int, sha256: str, headers):
        record = self._metadata_record(
            scope_name(language, platform), name,
            status=status, size=size, sha256=sha256, headers=headers,
        )
        self.put_metadata_batch([record])

    def put_metadata_batch(self, records: Iterable[tuple]):
        records = list(records)
        if not records:
            return
        with self._connection() as conn:
            conn.executemany('''
                INSERT INTO object_metadata (
                    scope, name, status, size, sha256, content_type, etag,
                    last_modified, cache_control, content_encoding, fetched_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ON CONFLICT(scope, name) DO UPDATE SET
                    status = excluded.status,
                    size = excluded.size,
                    sha256 = excluded.sha256,
                    content_type = excluded.content_type,
                    etag = excluded.etag,
                    last_modified = excluded.last_modified,
                    cache_control = excluded.cache_control,
                    content_encoding = excluded.content_encoding,
                    fetched_at = excluded.fetched_at
            ''', records)

    def _metadata_snapshot(self, language: str, platform: str):
        scope = scope_name(language, platform)
        with self._connection() as conn:
            rows = conn.execute('''
                SELECT name, size, sha256
                  FROM object_metadata
                 WHERE scope = ?
            ''', (scope,)).fetchall()
        return {name: (size, sha256) for name, size, sha256 in rows}

    def complete_names(self, language: str, platform: str,
                       names: Iterable[str], *, verify: bool = False) -> set[str]:
        names = list(dict.fromkeys(names))
        if not names:
            return set()
        wanted = set(names)
        metadata = self._metadata_snapshot(language, platform)
        if not metadata:
            return set()

        sizes: dict[str, int] = {}
        directory = self.scope_dir(language, platform)
        try:
            with os.scandir(directory) as entries:
                for entry in entries:
                    if entry.name not in wanted or not entry.is_file(follow_symlinks=False):
                        continue
                    try:
                        sizes[entry.name] = entry.stat(follow_symlinks=False).st_size
                    except OSError:
                        continue
        except FileNotFoundError:
            return set()

        candidates = {
            name for name in wanted
            if name in metadata and sizes.get(name) == metadata[name][0]
        }
        if not verify:
            return candidates

        verified: set[str] = set()
        for name in candidates:
            digest = hashlib.sha256()
            try:
                with (directory / name).open('rb') as file:
                    for chunk in iter(lambda: file.read(1024 * 1024), b''):
                        digest.update(chunk)
            except OSError:
                continue
            if digest.hexdigest() == metadata[name][1]:
                verified.add(name)
        return verified

    def is_complete(self, language: str, platform: str, name: str) -> bool:
        path = self.object_path(language, platform, name)
        try:
            size = path.stat().st_size
        except OSError:
            return False
        metadata = self.get_metadata(language, platform, name)
        return metadata is not None and size == metadata['size']

    def verify(self, language: str, platform: str, name: str) -> bool:
        path = self.object_path(language, platform, name)
        metadata = self.get_metadata(language, platform, name)
        if metadata is None:
            return False
        try:
            if path.stat().st_size != metadata['size']:
                return False
        except OSError:
            return False
        digest = hashlib.sha256()
        try:
            with path.open('rb') as file:
                for chunk in iter(lambda: file.read(1024 * 1024), b''):
                    digest.update(chunk)
        except OSError:
            return False
        return digest.hexdigest() == metadata['sha256']

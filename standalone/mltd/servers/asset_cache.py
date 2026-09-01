import hashlib
import os
import sqlite3
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from contextlib import contextmanager
from pathlib import Path
from typing import Iterable, NamedTuple

import requests
from msgpack import unpackb

REMOTE_ASSET_ROOT = 'https://assets.rainbowunicorn7297.com'
MANIFEST_NAMES = {
    'zh': '85822153578df611a4f852d4e02660f6f34401e4.data',
    'ko': '25c292462510f60200eecd8080f4680114b8c576.data',
}
SUPPORTED_LANGUAGES = frozenset(MANIFEST_NAMES)
SUPPORTED_PLATFORMS = frozenset({'android', 'ios'})
_METADATA_BATCH_SIZE = 256


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


class _DownloadOutcome(NamedTuple):
    path: Path
    metadata: tuple
    size: int


class AssetStore:
    def __init__(self, root: str | os.PathLike[str] = 'asset-cache'):
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
        """Return complete objects using one SQLite query and one directory scan."""
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


class AssetMirror:
    def __init__(self, store: AssetStore, remote_root: str = REMOTE_ASSET_ROOT,
                 timeout: float = 60.0, upstream_proxy: str | None = None):
        self.store = store
        self.remote_root = remote_root.rstrip('/')
        self.timeout = timeout
        self.upstream_proxy = upstream_proxy.strip() if upstream_proxy else None
        self._local = threading.local()

    def _session(self) -> requests.Session:
        session = getattr(self._local, 'session', None)
        if session is None:
            session = requests.Session()
            adapter = requests.adapters.HTTPAdapter(
                pool_connections=1,
                pool_maxsize=1,
                max_retries=3,
            )
            session.mount('http://', adapter)
            session.mount('https://', adapter)
            session.headers['User-Agent'] = 'mltd-relive-asset-mirror/1'
            if self.upstream_proxy:
                session.proxies.update({
                    'http': self.upstream_proxy,
                    'https': self.upstream_proxy,
                })
            self._local.session = session
        return session

    def remote_url(self, language: str, platform: str, name: str) -> str:
        _safe_component(name)
        return f'{self.remote_root}/{scope_name(language, platform)}/{name}'

    def _download(self, language: str, platform: str, name: str,
                  *, force: bool = False, skip_existing_check: bool = False,
                  defer_metadata: bool = False,
                  durable_write: bool = True) -> _DownloadOutcome:
        destination = self.store.object_path(language, platform, name)
        if (not force and not skip_existing_check
                and self.store.is_complete(language, platform, name)):
            try:
                size = destination.stat().st_size
            except OSError:
                size = 0
            return _DownloadOutcome(destination, (), size)

        part = self.store.part_path(language, platform, name)
        try:
            resume_at = part.stat().st_size
        except OSError:
            resume_at = 0
        headers = {'Accept-Encoding': 'identity'}
        if resume_at:
            headers['Range'] = f'bytes={resume_at}-'

        response = self._session().get(
            self.remote_url(language, platform, name),
            headers=headers,
            stream=True,
            timeout=self.timeout,
        )
        try:
            if response.status_code == 416 and resume_at:
                part.unlink(missing_ok=True)
                return self._download(
                    language, platform, name, force=True,
                    skip_existing_check=True, defer_metadata=defer_metadata,
                    durable_write=durable_write,
                )
            response.raise_for_status()

            append = resume_at > 0 and response.status_code == 206
            if not append:
                resume_at = 0
            mode = 'ab' if append else 'wb'
            digest = hashlib.sha256()
            if append:
                with part.open('rb') as existing:
                    for chunk in iter(lambda: existing.read(1024 * 1024), b''):
                        digest.update(chunk)

            with part.open(mode) as file:
                for chunk in response.iter_content(chunk_size=1024 * 1024):
                    if not chunk:
                        continue
                    file.write(chunk)
                    digest.update(chunk)
                if durable_write:
                    file.flush()
                    os.fsync(file.fileno())

            size = part.stat().st_size
            expected_total = None
            if response.status_code == 206:
                content_range = response.headers.get('Content-Range', '')
                if '/' in content_range:
                    total = content_range.rsplit('/', 1)[1]
                    if total.isdigit():
                        expected_total = int(total)
            elif response.headers.get('Content-Length', '').isdigit():
                expected_total = int(response.headers['Content-Length'])

            if expected_total is not None and size != expected_total:
                raise IOError(
                    f'Incomplete asset {name}: got {size} bytes, expected {expected_total}'
                )

            os.replace(part, destination)
            record = self.store._metadata_record(
                scope_name(language, platform), name,
                status=200, size=size, sha256=digest.hexdigest(),
                headers=response.headers,
            )
            if not defer_metadata:
                self.store.put_metadata_batch([record])
            return _DownloadOutcome(destination, record, size)
        finally:
            response.close()

    def download(self, language: str, platform: str, name: str,
                 *, force: bool = False) -> Path:
        return self._download(language, platform, name, force=force).path

    def head(self, language: str, platform: str, name: str):
        response = self._session().head(
            self.remote_url(language, platform, name),
            headers={'Accept-Encoding': 'identity'},
            allow_redirects=True,
            timeout=self.timeout,
        )
        response.raise_for_status()
        return response

    def fetch_manifest(self, language: str, platform: str,
                       *, force: bool = False) -> tuple[Path, list[str]]:
        name = manifest_name(language)
        path = self.download(language, platform, name, force=force)
        return path, parse_manifest_objects(path.read_bytes())

    def prefetch(self, language: str, platform: str, *, workers: int = 8,
                 force: bool = False, verify_existing: bool = False,
                 names: Iterable[str] | None = None,
                 progress=None,
                 manifest_objects: Iterable[str] | None = None,
                 metadata_batch_size: int = _METADATA_BATCH_SIZE,
                 durable_writes: bool = False) -> dict:
        if manifest_objects is None:
            manifest_path, source_objects = self.fetch_manifest(
                language, platform, force=force
            )
        else:
            source_objects = list(dict.fromkeys(manifest_objects))
            manifest_path = self.store.object_path(
                language, platform, manifest_name(language)
            )

        requested = source_objects if names is None else list(names)
        requested = list(dict.fromkeys(requested))

        if force:
            complete = set()
        else:
            complete = self.store.complete_names(
                language, platform, requested, verify=verify_existing
            )
        pending = [name for name in requested if name not in complete]

        result = {
            'manifest': str(manifest_path),
            'total_manifest_objects': len(source_objects),
            'requested': len(requested),
            'already_cached': len(requested) - len(pending),
            'downloaded': 0,
            'failed': [],
        }
        if not pending:
            return result

        batch_size = max(1, int(metadata_batch_size))
        metadata_batch: list[tuple] = []
        with ThreadPoolExecutor(
                max_workers=min(max(1, workers), len(pending))) as executor:
            futures = {
                executor.submit(
                    self._download,
                    language,
                    platform,
                    name,
                    force=force,
                    skip_existing_check=True,
                    defer_metadata=True,
                    durable_write=durable_writes,
                ): name
                for name in pending
            }
            completed = 0
            for future in as_completed(futures):
                name = futures[future]
                completed += 1
                try:
                    outcome = future.result()
                except Exception as exc:
                    result['failed'].append((name, str(exc)))
                    ok = False
                    error = exc
                else:
                    metadata_batch.append(outcome.metadata)
                    if len(metadata_batch) >= batch_size:
                        self.store.put_metadata_batch(metadata_batch)
                        metadata_batch.clear()
                    result['downloaded'] += 1
                    ok = True
                    error = None
                if progress:
                    progress(completed, len(pending), name, ok, error)

        if metadata_batch:
            self.store.put_metadata_batch(metadata_batch)
        return result

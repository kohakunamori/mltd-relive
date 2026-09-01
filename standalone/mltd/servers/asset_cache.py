import hashlib
import os
import sqlite3
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Iterable

import requests
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
    def __init__(self, root: str | os.PathLike[str] = 'asset-cache'):
        self.root = Path(root)
        self.root.mkdir(parents=True, exist_ok=True)
        self.db_path = self.root / '.asset-index.sqlite3'
        self._init_db()

    def _connect(self):
        conn = sqlite3.connect(self.db_path, timeout=30)
        conn.execute('PRAGMA journal_mode=WAL')
        conn.execute('PRAGMA synchronous=NORMAL')
        return conn

    def _init_db(self):
        with self._connect() as conn:
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
        directory = self.root / scope_name(language, platform)
        directory.mkdir(parents=True, exist_ok=True)
        return directory

    def object_path(self, language: str, platform: str, name: str) -> Path:
        _safe_component(name)
        return self.scope_dir(language, platform) / name

    def part_path(self, language: str, platform: str, name: str) -> Path:
        return self.object_path(language, platform, name).with_name(name + '.part')

    def get_metadata(self, language: str, platform: str, name: str):
        scope = scope_name(language, platform)
        with self._connect() as conn:
            row = conn.execute('''
                SELECT status, size, sha256, content_type, etag,
                       last_modified, cache_control, content_encoding, fetched_at
                  FROM object_metadata
                 WHERE scope = ? AND name = ?
            ''', (scope, name)).fetchone()
        if row is None:
            return None
        keys = (
            'status', 'size', 'sha256', 'content_type', 'etag',
            'last_modified', 'cache_control', 'content_encoding', 'fetched_at'
        )
        return dict(zip(keys, row))

    def put_metadata(self, language: str, platform: str, name: str,
                     *, status: int, size: int, sha256: str, headers):
        scope = scope_name(language, platform)

        def header(key):
            return headers.get(key) if headers else None

        with self._connect() as conn:
            conn.execute('''
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
            ''', (
                scope, name, status, size, sha256,
                header('Content-Type'), header('ETag'), header('Last-Modified'),
                header('Cache-Control'), header('Content-Encoding'), time.time()
            ))

    def is_complete(self, language: str, platform: str, name: str) -> bool:
        path = self.object_path(language, platform, name)
        if not path.is_file():
            return False
        metadata = self.get_metadata(language, platform, name)
        return metadata is not None and path.stat().st_size == metadata['size']

    def verify(self, language: str, platform: str, name: str) -> bool:
        path = self.object_path(language, platform, name)
        metadata = self.get_metadata(language, platform, name)
        if not path.is_file() or metadata is None:
            return False
        if path.stat().st_size != metadata['size']:
            return False
        digest = hashlib.sha256()
        with path.open('rb') as file:
            for chunk in iter(lambda: file.read(1024 * 1024), b''):
                digest.update(chunk)
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
                pool_connections=4,
                pool_maxsize=4,
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

    def download(self, language: str, platform: str, name: str,
                 *, force: bool = False) -> Path:
        destination = self.store.object_path(language, platform, name)
        if not force and self.store.is_complete(language, platform, name):
            return destination

        part = self.store.part_path(language, platform, name)
        resume_at = part.stat().st_size if part.exists() else 0
        headers = {'Accept-Encoding': 'identity'}
        if resume_at:
            headers['Range'] = f'bytes={resume_at}-'

        response = self._session().get(
            self.remote_url(language, platform, name),
            headers=headers,
            stream=True,
            timeout=self.timeout,
        )
        if response.status_code == 416 and resume_at:
            part.unlink(missing_ok=True)
            return self.download(language, platform, name, force=True)
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
        self.store.put_metadata(
            language, platform, name,
            status=200,
            size=size,
            sha256=digest.hexdigest(),
            headers=response.headers,
        )
        return destination

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
                 progress=None) -> dict:
        manifest_path, manifest_objects = self.fetch_manifest(
            language, platform, force=force
        )
        names = manifest_objects if names is None else list(names)
        names = list(dict.fromkeys(names))

        if verify_existing:
            pending = [
                name for name in names
                if force or not self.store.verify(language, platform, name)
            ]
        else:
            pending = [
                name for name in names
                if force or not self.store.is_complete(language, platform, name)
            ]

        result = {
            'manifest': str(manifest_path),
            'total_manifest_objects': len(manifest_objects),
            'requested': len(names),
            'already_cached': len(names) - len(pending),
            'downloaded': 0,
            'failed': [],
        }
        if not pending:
            return result

        with ThreadPoolExecutor(max_workers=max(1, workers)) as executor:
            futures = {
                executor.submit(self.download, language, platform, name,
                                force=force): name
                for name in pending
            }
            completed = 0
            for future in as_completed(futures):
                name = futures[future]
                completed += 1
                try:
                    future.result()
                    result['downloaded'] += 1
                    ok = True
                    error = None
                except Exception as exc:
                    result['failed'].append((name, str(exc)))
                    ok = False
                    error = exc
                if progress:
                    progress(completed, len(pending), name, ok, error)
        return result

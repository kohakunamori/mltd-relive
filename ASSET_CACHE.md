# MLTD Remote Asset Cache

The standalone game server does **not** proxy or locally serve Asset traffic.
The corrected client receives a normal HTTPS remote Asset URL and downloads
assets directly from that endpoint.

`tools/cache_assets.py` exists only for preservation/disaster recovery: while
the current remote/R2 source is still reachable, it can save the complete
manifest-defined object set to durable local or NAS storage.

## Architecture

```text
Game runtime

client
  -> AssetService.GetAssetVersion
  -> https://assets.rainbowunicorn7297.com/<scope>/
     or configured asset_remote_url

No local Asset HTTP server
No hybrid/local mode
No TLS interception for Asset traffic
```

```text
Preservation

current remote/R2
  -> tools/cache_assets.py sync
  -> local/NAS cache
       <scope>/<manifest>.data
       <scope>/*.unity3d
       .asset-index.sqlite3
       cache-snapshot.json
```

If the current remote source disappears later, the preserved directory can be
uploaded to another HTTPS object-storage/static-hosting endpoint. The game
server then only needs `asset_remote_url` changed to that replacement endpoint.

## Cache Traditional Chinese Android assets

From the repository root:

```bash
python tools/cache_assets.py sync \
  --scope zh-android \
  --root /path/to/durable/mltd-assets \
  --workers 48
```

The default scope is already `zh-android`, so this is also valid:

```bash
python tools/cache_assets.py sync --root /path/to/durable/mltd-assets
```

Multiple scopes can be saved in one cache:

```bash
python tools/cache_assets.py sync \
  --scope zh-android \
  --scope zh-ios \
  --scope ko-android \
  --scope ko-ios \
  --root /path/to/durable/mltd-assets
```

## Optional upstream proxy

The proxy is used only by the cache utility. It does not change the network
path used by the game client.

```bash
python tools/cache_assets.py sync \
  --root /path/to/durable/mltd-assets \
  --proxy http://127.0.0.1:7890
```

Any proxy scheme supported by the installed `requests` environment can be
passed to `--proxy`.

## Resume and repeated sync

Every `sync` refreshes the remote manifest first and then checks the object set.
Already complete objects are skipped using stored size/SHA256 metadata.
Interrupted downloads use `.part` files and resume with HTTP Range when the
remote endpoint supports it.

For a stronger preservation pass, verify existing cached bytes before skipping:

```bash
python tools/cache_assets.py sync \
  --root /path/to/durable/mltd-assets \
  --verify-existing
```

For storage where power-loss durability is more important than write speed:

```bash
python tools/cache_assets.py sync \
  --root /path/to/durable/mltd-assets \
  --durable
```

`--durable` fsyncs each completed object before it is committed to the cache.

## Offline integrity verification

Verification is intentionally independent of the remote source:

```bash
python tools/cache_assets.py verify \
  --scope zh-android \
  --root /path/to/durable/mltd-assets
```

It reads the preserved manifest and verifies every required object against the
stored size and SHA256 metadata. It makes no network requests, so it continues
to work after the original remote/R2 source is unavailable.

## Cache format

Example:

```text
mltd-assets/
  .asset-index.sqlite3
  cache-snapshot.json
  zh-android/
    85822153578df611a4f852d4e02660f6f34401e4.data
    <asset object>.unity3d
    ...
```

`.asset-index.sqlite3` records, per object:

- scope and object name;
- byte size;
- SHA256;
- Content-Type;
- ETag;
- Last-Modified;
- Cache-Control;
- Content-Encoding;
- fetch timestamp.

`cache-snapshot.json` records the source root, selected scopes, manifest hashes,
object counts, and the result of the most recent completed sync.

## Runtime configuration

Default behavior:

```ini
asset_mode = remote
asset_remote_url =
```

An empty `asset_remote_url` means the original Rainbow remote endpoint.
To move to a replacement HTTPS object-storage endpoint later:

```ini
asset_mode = remote
asset_remote_url = https://assets.example.com
```

The client will then receive, for example:

```text
https://assets.example.com/zh-android/
```

The replacement endpoint only needs to expose the cached scope/object layout.

# Local asset mirror and optimized server transport

The asset mirror now has three runtime modes and is integrated with the
standalone server.

## Asset modes

### `remote`

Preserves the original behavior. `AssetService.GetAssetVersion` points at:

```text
https://assets.rainbowunicorn7297.com/<language>-<platform>/
```

### `hybrid`

Uses the local mirror first. A cache miss is fetched from the public asset host,
written atomically to `asset-cache/`, indexed with SHA-256 and the relevant CDN
metadata, then served to the client. Later requests are served locally.

### `local`

Strict offline mode. Before the server reports itself ready, it parses the
current language's Android **and** iOS manifests and ensures every referenced
asset object is present locally. Any failed or incomplete object aborts startup.
Runtime cache misses never access the network and return 404.

This means `local` is not a lazy cache: it is a complete pre-downloaded mirror.

## Prepare a strict local mirror manually

From the repository root:

```bash
python tools/prefetch_assets.py zh all --root asset-cache --workers 8
```

Use `ko all` for the Korean client. `android` and `ios` can still be selected
individually.

To SHA-256 check existing objects before they are accepted:

```bash
python tools/prefetch_assets.py zh all --verify-existing
```

Local mode performs the completeness check automatically at startup. Existing
objects with matching indexed sizes are reused, so a completed cache does not
need to be downloaded again.

## Local path layout

The on-disk and HTTP path follows the public CDN object layout:

```text
asset-cache/
  zh-android/
  zh-ios/
  ko-android/
  ko-ios/
```

Each manifest is kept byte-for-byte unchanged and objects use the exact hashed
name referenced by that manifest.

## Asset HTTP server

The standalone asset server listens on port `7651` by default:

```bash
cd standalone
python -m mltd.servers.asset_server
```

Direct requests use:

```text
http://<server>:7651/zh-android/<object>
```

It supports:

- `GET` and `HEAD`
- byte ranges (`206` / `416`)
- `If-None-Match` / `304`
- `If-Modified-Since`
- replay of `Content-Type`, `ETag`, `Last-Modified`, and `Cache-Control`
- HTTP/1.1 keep-alive

## HTTP forward-proxy support

Port `7651` also accepts standard HTTP proxy absolute-form requests for the
asset host, for example:

```text
GET http://assets.rainbowunicorn7297.com/zh-android/<object> HTTP/1.1
```

The proxy is deliberately allow-listed to
`assets.rainbowunicorn7297.com`; other hosts receive `403`, so the embedded
server cannot become a general-purpose open proxy.

In `hybrid`, `CONNECT assets.rainbowunicorn7297.com:443` is allowed as a
restricted pass-through for ordinary HTTP-proxy clients. In strict `local`,
CONNECT is disabled so the server remains network-independent after prefetch.

## Desktop game routing

Desktop clients continue to use the existing trusted API TLS hostname. Local
assets are exposed through the same TLS listener under:

```text
https://theaterdays-<language>.appspot.com/__mltd_assets/<scope>/<object>
```

This avoids introducing another local certificate or DNS override for the
public asset hostname.

Same-device/Termux mode uses the dedicated HTTP asset server at
`127.0.0.1:7651`.

## Validation

The CI gate checks all four live manifests (`zh/ko x Android/iOS`) against the
public CDN and also replays a real `.unity3d` object from each scope. It compares
body bytes, Range behavior, ETag-related behavior, HEAD, and missing-object
status handling.

For a larger manual comparison:

```bash
python tools/verify_asset_mirror.py zh android --sample 100
```

For every object in a scope:

```bash
python tools/verify_asset_mirror.py zh android --all
```

## API transport optimization

The desktop HTTPS server no longer sends each API request through a second
localhost HTTP server. The TLS handler dispatches directly into the WSGI
application, keeps HTTP/1.1 connections alive, and handles requests with a
threaded server. The redundant desktop localhost API process was removed.

The direct HTTP API used by same-device mode is also threaded and HTTP/1.1.
SQLite runs with WAL, a busy timeout, NORMAL synchronous mode, in-memory temp
storage, and a bounded page cache. SQL query instrumentation is not registered
at all unless DEBUG logging is enabled, avoiding two Python event callbacks per
statement in normal operation.

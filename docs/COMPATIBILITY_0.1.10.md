# Standalone v0.1.10 compatibility fix notes

> Date: 2026-09-02
> Branch: `fix/live-asset-compat`

## Confirmed v0.1.9 Asset regression

The following A/B test uses the same v0.1.9 server build, corrected Traditional Chinese APK, database and TheaterService implementation. The only changed setting is `asset_mode`:

```ini
asset_mode = hybrid
```

Result: login fails with `ErrorCode [-404 / 0]`.

```ini
asset_mode = remote
```

Result: login succeeds.

This isolates the login regression to the Asset download path.

### Directions ruled out as the primary cause

- `AuthService.Login` is not the root cause.
- The Theater API imported from `yuyueryuyu/mltd-relive` is not the root cause under a healthy database. Repeated Theater calls have passed 250 consecutive iterations.
- v0.1.6 -> v0.1.8 database migration is not the root cause. The migrated database also passed 250 consecutive Theater calls.
- Listener-vs-worker TLS handshake timing is not the primary cause of this hybrid-only failure because both remote and hybrid use the same API TLS listener.
- The current 60-second accepted-socket timeout remains a separate compatibility issue to revisit, but cannot explain `remote OK / hybrid FAIL` because both modes traverse it for API traffic.

## Root-cause model

v0.1.9 desktop hybrid returned:

```text
https://theaterdays-zh.appspot.com/__mltd_assets/zh-android/
```

That path shares the local API TLS endpoint and its self-signed `api.crt`.

The corrected client is known to accept the local self-signed certificate for API RPC traffic, while web/Asset traffic uses stricter certificate validation. The actual APK also contains the client-side error string:

```text
[AssetBundle] NotFoundError(-404)
```

The most consistent failure chain is therefore:

```text
AssetBundle downloader
  -> HTTPS local Asset URL on API host
  -> self-signed API certificate
  -> Asset TLS validation rejects the connection
  -> request may never reach AssetHTTPRequestHandler
  -> client maps failure to AssetBundle NotFoundError(-404)
  -> login UI reports [-404 / 0]
```

The Rainbow CDN itself is not missing the Theater resources. The Traditional Chinese Android manifest is about 4.27 MB with 33,676 records. Of 53 Theater resource IDs returned by the yuyu implementation, 52 map directly to the manifest, and 104 identified Theater Asset objects returned HTTP 200 to upstream HEAD checks.

## v0.1.10 Asset transport design

### Safe default

`remote` is restored as the default mode.

New and migrated v0.1.9 default-like configs should not silently remain on the known-broken self-signed desktop hybrid topology.

### Remote

Unchanged:

```text
https://assets.rainbowunicorn7297.com/zh-android/
```

The client talks directly to the public CDN.

### Desktop hybrid/local experiment

Do not route Asset traffic through local HTTPS 443.

Return:

```text
http://theaterdays-zh.appspot.com:7651/zh-android/
```

The existing local DNS already resolves `theaterdays-zh.appspot.com` to the standalone server LAN address. The dedicated Asset server listens on cleartext HTTP port 7651.

This avoids:

- self-signed Asset TLS;
- `/__mltd_assets/` path rewriting;
- sharing API and Asset connection semantics;
- introducing a literal LAN IP into `asset_url`.

The 443 listener is API-only. Asset GET/HEAD remains a separate high-concurrency `ThreadingHTTPServer` on 7651.

If the corrected client rejects desktop cleartext Asset HTTP, the next preferred design is a separately controlled public hostname with a valid public-CA certificate and DNS pointing to the LAN server. APK TLS patching remains a fallback, not the first choice.

## Live performance issue

Remote mode can log in, but Live performance has separately shown incorrect behavior. `standalone/mltd/services/live.py` is byte-for-byte identical to `yuyueryuyu/mltd-relive`, so the current first target is transport compatibility rather than rewriting LiveService.

The branch restores two original API properties while keeping Asset concurrency independent:

```text
API POST
  -> Connection: close
  -> close_connection = True
  -> global compatibility lock / serialized RPC dispatch

Asset GET/HEAD
  -> separate HTTP :7651 listener
  -> ThreadingHTTPServer
  -> cache / Range / hybrid fetch-on-miss
```

This directly tests whether the stateful Live RPC sequence depends on the original standalone server's serialized request ordering and per-request connection closure.

If Live remains broken after client testing, the next A/B step is to restore the localhost `:7650` API HTTP hop while retaining the current TLS listener and Asset server.

## Required device tests before merge

1. `asset_mode = remote`
   - login succeeds;
   - Theater loads;
   - Live start/finish path is tested.

2. `asset_mode = hybrid`
   - `AssetService.GetAssetVersion.asset_url` is `http://theaterdays-zh.appspot.com:7651/...`;
   - login succeeds without `-404/0`;
   - first cache miss reaches local port 7651 and then the Rainbow CDN;
   - second request is served from local cache;
   - Range requests work;
   - Theater contact assets load.

3. Live compatibility
   - song selection;
   - guest selection;
   - `StartSong`;
   - normal completion / `FinishSong`;
   - interrupted song / `BreakSong` if practical;
   - return to song selection without stale PendingSong or connection error.

Do not merge/release the branch solely from unit tests: the decisive Asset HTTP acceptance and Live state-machine tests require the corrected game client.

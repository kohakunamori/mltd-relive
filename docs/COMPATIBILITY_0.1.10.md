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

### Corrected APK cleartext caveat

A direct parse of `mltd-relive-game-client-zh-fixed.apk` shows:

```text
targetSdkVersion = 29
```

The `<application>` element does not explicitly set `android:usesCleartextTraffic="true"` and does not reference an Android `networkSecurityConfig`.

Therefore the desktop HTTP `:7651` transport must be treated as an empirical compatibility experiment rather than assumed to work. Android's framework cleartext policy for a target-SDK-29 application may reject HTTP if the Asset download stack consults `NetworkSecurityPolicy`. Unity/native AssetBundle networking may use a path that does not enforce the same framework policy, so the corrected game client must be tested directly.

If the corrected client rejects desktop cleartext Asset HTTP, the next preferred design is a separately controlled public hostname with a valid public-CA certificate and DNS pointing to the LAN server. That preserves local caching while satisfying the stricter Asset TLS stack. APK cleartext/TLS patching remains a fallback, not the first choice.

## Live performance issue — resolved

The observed remote-mode Live failure is now device-confirmed fixed.

The failing request was:

```text
UnitService.SetUnit
TypeError: 'ChunkedIteratorResult' object is not subscriptable
```

The optimized `SetUnit` implementation passed the SQLAlchemy 2.x Result object directly to `dict()`. The fix materializes the two-column rows first:

```python
card_rows = session.execute(...).all()
card_to_idol = dict(card_rows)
```

Fix commit:

```text
351161e8df288fce8ab478953c34701010106ca0
```

After rebuilding with this fix, the corrected Traditional Chinese client was tested again with `asset_mode = remote` and Live now operates normally. Therefore this observed Live failure was a service-layer SQLAlchemy compatibility bug, not an Asset/TLS failure and not evidence that `LiveService` itself is incompatible.

The branch still contains `Connection: close` and serialized API dispatch compatibility changes. They are no longer considered necessary to explain the observed Live failure and should be A/B-tested independently before final release.

## Remaining device tests before merge

1. `asset_mode = remote`
   - login succeeds: **confirmed**;
   - Theater loads: **confirmed for the current tested flow**;
   - Live operates normally after the SetUnit fix: **confirmed**.

2. `asset_mode = hybrid`
   - `AssetService.GetAssetVersion.asset_url` is `http://theaterdays-zh.appspot.com:7651/...`;
   - login succeeds without `-404/0`;
   - first cache miss reaches local port 7651 and then the Rainbow CDN;
   - second request is served from local cache;
   - Range requests work;
   - Theater contact assets load;
   - if the client fails before any request reaches port 7651, treat Android cleartext policy as the primary next suspect.

3. API transport cleanup
   - once Asset transport is stable, A/B remove the global API serialization lock and/or `Connection: close`;
   - retain only transport compatibility changes proven necessary by device testing.

The active blocker for v0.1.10 is now the Desktop `hybrid/local` Asset path, not Live.

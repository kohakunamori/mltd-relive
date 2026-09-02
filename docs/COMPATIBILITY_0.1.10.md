# Standalone v0.1.10 compatibility fix notes

> Date: 2026-09-02
> Branch: `fix/live-asset-compat`

## Confirmed v0.1.9 Asset regression

The same v0.1.9 server build, corrected Traditional Chinese APK, database and TheaterService behaves differently only when `asset_mode` changes:

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
- The Theater API imported from `yuyueryuyu/mltd-relive` is not the root cause under a healthy database. Repeated Theater calls passed 250 consecutive iterations.
- v0.1.6 -> v0.1.8 database migration is not the root cause. The migrated database also passed 250 consecutive Theater calls.
- Listener-vs-worker TLS handshake timing is not the primary cause of this hybrid-only failure because both remote and hybrid use the same API TLS listener.
- The current 60-second accepted-socket timeout remains a separate compatibility issue, but cannot explain `remote OK / hybrid FAIL` because both modes traverse it for API traffic.

## v0.1.9 self-signed Asset TLS failure

v0.1.9 desktop hybrid returned:

```text
https://theaterdays-zh.appspot.com/__mltd_assets/zh-android/
```

That route shares the local API TLS endpoint and its self-signed `api.crt`.

The corrected client accepts the self-signed certificate for API RPC traffic, while its Asset/Web downloader uses stricter TLS validation. The APK contains:

```text
[AssetBundle] NotFoundError(-404)
```

The most consistent failure chain is:

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

## Desktop cleartext HTTP experiment — rejected by device test

The first v0.1.10 experiment moved Desktop Asset traffic to an independent cleartext listener:

```text
http://theaterdays-zh.appspot.com:7651/zh-android/
```

This removed self-signed Asset TLS and kept API/Asset transports separate.

A direct parse of `mltd-relive-game-client-zh-fixed.apk` shows:

```text
targetSdkVersion = 29
```

The `<application>` element does not explicitly set `android:usesCleartextTraffic="true"` and does not reference a `networkSecurityConfig`.

Device test result on 2026-09-02:

```text
資料下載失敗
ErrorCode -21990
```

Therefore the Desktop cleartext Asset transport is no longer considered a viable default or release path. The exact internal meaning of `-21990` is not publicly documented, but the failure is reproducible only after switching the Asset URL to cleartext and is consistent with the corrected client's Android/Unity download stack rejecting that topology.

## Current v0.1.10 Asset transport design: trusted HTTPS hostname

`remote` remains the safe default:

```text
https://assets.rainbowunicorn7297.com/zh-android/
```

Desktop `hybrid/local` now requires a separately controlled hostname with a publicly trusted TLS certificate. Example:

```ini
asset_mode = hybrid
asset_public_url = https://mltd-assets.example.com:7651
asset_tls_cert = /path/to/fullchain.pem
asset_tls_key = /path/to/privkey.pem
```

The client receives:

```text
https://mltd-assets.example.com:7651/zh-android/
```

The standalone DNS server redirects `mltd-assets.example.com` to the LAN server. TLS still validates normally because the certificate is issued by a public CA for that hostname.

Architecture:

```text
API
https://theaterdays-zh.appspot.com:443
  -> existing API certificate / compatibility transport

Asset
https://<controlled-asset-host>:7651/<scope>/<object>
  -> public-CA certificate
  -> independent ThreadingHTTPServer
  -> Range / cache / hybrid fetch-on-miss
  -> Rainbow CDN only on cache miss
```

Port 7651 is intentionally retained so the Asset listener does not share API port 443. HTTPS certificate validation is hostname-based and remains valid on a non-default port.

Desktop cache mode now fails fast if:

- `asset_public_url` is missing;
- the URL is not HTTPS;
- the configured certificate or key does not exist;
- the Asset URL tries to reuse API port 443.

The old repository certificate `key/assets.rainbowunicorn7297.com.crt` is **self-signed**, despite having a valid date range and matching private key. It cannot provide public trust for the Asset downloader and is not used by the new Desktop Asset topology.

## Live performance issue — resolved

The observed remote-mode Live failure is device-confirmed fixed.

The failing request was:

```text
UnitService.SetUnit
TypeError: 'ChunkedIteratorResult' object is not subscriptable
```

The optimized `SetUnit` implementation passed the SQLAlchemy 2.x Result object directly to `dict()`. The fix materializes the rows first:

```python
card_rows = session.execute(...).all()
card_to_idol = dict(card_rows)
```

Fix commit:

```text
351161e8df288fce8ab478953c34701010106ca0
```

After rebuilding with this fix, the corrected Traditional Chinese client was tested again with `asset_mode = remote` and Live operates normally.

The branch still contains `Connection: close` and serialized API dispatch compatibility changes. They are no longer considered necessary to explain the observed Live failure and should be A/B-tested independently before final release.

## Remaining device tests before merge

1. `asset_mode = remote`
   - login: **confirmed**;
   - Theater: **confirmed for the current tested flow**;
   - Live after SetUnit fix: **confirmed**.

2. Trusted-HTTPS `asset_mode = hybrid`
   - configure a controlled public hostname and valid public-CA certificate;
   - DNS override points that hostname to LAN;
   - login succeeds without `-404/0` or `-21990`;
   - first cache miss reaches local Asset HTTPS listener and then Rainbow CDN;
   - second request is served from local cache;
   - Range requests work;
   - Theater contact assets load.

3. API transport cleanup
   - after Asset transport is stable, A/B remove the global API serialization lock and/or `Connection: close`;
   - retain only transport compatibility changes proven necessary by device testing.

The active blocker for v0.1.10 is now provisioning and device-testing the trusted HTTPS Desktop `hybrid/local` Asset endpoint.

# Live / Asset compatibility fix candidate

> Branch: `fix/live-asset-sni-compat`
>
> Status: code + CI validated; corrected Android client validation pending.

This document records the compatibility changes being tested after two user-visible regressions were isolated on Standalone v0.1.9:

1. `asset_mode = hybrid` fails during login with `ErrorCode [-404 / 0]`, while `remote` logs in successfully.
2. `remote` can log in, but Live (演唱會) behavior is not reliable.

The two failures are treated as separate transport compatibility problems. `standalone/mltd/services/live.py` remains identical to `yuyueryuyu/mltd-relive`, so this branch does not rewrite LiveService business logic.

## 1. API compatibility transport

The yuyu/original standalone proxy used a single-threaded `HTTPServer` and explicitly closed every API connection. Later performance work changed the listener to `ThreadingHTTPServer`, kept HTTP/1.1 connections alive, and dispatched directly to WSGI.

This branch keeps the useful performance work but restores the original API semantics only for POST requests:

```text
API POST
  -> listener-wrapped TLS
  -> global API compatibility lock (serialized)
  -> direct WSGI dispatch
  -> Connection: close

Asset GET / HEAD
  -> listener-wrapped TLS
  -> concurrent ThreadingHTTPServer workers
  -> no API compatibility lock
  -> Range / cache / hybrid fetch-on-miss unchanged
```

This prevents concurrent state-changing RPC sequences such as `StartSong`, `FinishSong`, `BreakSong` and subsequent batch requests from overlapping while preserving Asset throughput.

Regression coverage includes a real concurrent-POST test that verifies WSGI dispatch never exceeds one active API request.

## 2. Hybrid/local Asset routing

The v0.1.9 hybrid design changed the client-visible Asset URL from the original CDN host to an API-host path:

```text
https://theaterdays-zh.appspot.com/__mltd_assets/zh-android/...
```

That behavior is removed for new responses on this branch.

For desktop hybrid/local, `AssetService.GetAssetVersion` again returns the original URL shape:

```text
https://assets.rainbowunicorn7297.com/zh-android/
```

The standalone DNS server intercepts `assets.rainbowunicorn7297.com` only when desktop `asset_mode` is `hybrid` or `local` and points it to the standalone host.

Port 443 then uses TLS SNI + HTTP Host routing:

```text
SNI theaterdays-zh.appspot.com
  -> API SSL context
  -> API POST

SNI assets.rainbowunicorn7297.com
  -> Asset SSL context
  -> /zh-android/<object>
  -> local AssetStore
  -> hybrid cache miss: fetch from public CDN
```

`remote` mode does not intercept the Asset hostname, so the client continues to access the public CDN directly.

The old `/__mltd_assets/...` route remains only as a backward-compatible fallback; new `GetAssetVersion` responses do not generate it.

## 3. Asset TLS certificate

The repository previously contained a Let's Encrypt certificate for `assets.rainbowunicorn7297.com` that expired in 2022.

This branch replaces only the certificate with a new local self-signed server certificate while retaining the existing private key.

Certificate properties:

- CN: `assets.rainbowunicorn7297.com`
- SAN: `DNS:assets.rainbowunicorn7297.com`
- Valid: 2026-09-02 through 2036-08-30
- EKU: TLS Web Server Authentication

CI verifies:

- certificate is not near expiry;
- SAN contains the expected Asset host;
- certificate public key matches the existing private key.

Whether the corrected game client's Asset download path accepts this local self-signed certificate must still be verified on-device. The API path already operates with a local certificate, but Asset certificate validation may use a different Unity code path.

## 4. Why not use plaintext HTTP for desktop Assets

The corrected zh APK binary AndroidManifest was inspected directly:

```text
minSdkVersion    = 19
targetSdkVersion = 29
```

The `<application>` element does not declare `usesCleartextTraffic=true` or a custom `networkSecurityConfig`.

Therefore a desktop design such as:

```text
http://<server>:7651/zh-android/...
```

is not a safe default for Android 10+ and is not used by this branch.

## 5. DNS cleanup included

While implementing Host routing, the existing IPv6 DNS generation bug was fixed:

- IPv6 records now use `AAAA`, not `A`;
- IPv6 records no longer overwrite the IPv4 zone records;
- API hosts remain intercepted in all modes;
- Asset host is intercepted only for desktop hybrid/local.

## 6. Failure diagnostics

The shared 443 handler now logs client-facing transport errors without logging normal Asset traffic.

For HTTP 404/500/502 it records:

```text
status
method
Host
path
Range
```

If the client still reports `-404/0`, the first `Client HTTP error` log entry should identify the exact Asset object or path that failed.

## 7. Validation matrix

### CI already covered

- public CDN manifest/object compatibility in `remote` mode;
- complete API service graph import;
- SQLite WAL/NORMAL/busy-timeout runtime configuration;
- Asset Host/DNS routing rules;
- SNI context selection;
- Asset certificate validity/SAN/key match;
- API `Connection: close` behavior;
- API serialized dispatch under concurrent POSTs;
- local/hybrid cache miss, Range and cache replay tests;
- API and Asset benchmarks.

### Required corrected-client test

Use `mltd-relive-game-client-zh-fixed.apk` and the test binary produced from this branch.

Run this sequence:

1. Select `remote` and confirm login still succeeds.
2. In `remote`, enter song selection, start a normal Live, finish it, and return to Theater.
3. Switch to `hybrid` and restart the server/client.
4. Confirm login succeeds without `-404/0`.
5. Enter Theater and trigger idol contact/resource loading.
6. Enter song selection and complete a normal Live.
7. Repeat an already cached scene/Live and confirm Asset requests are served from cache.
8. If any failure occurs, save `mltd-relive.log`; the new transport error line should contain the failing Host/path.

Do not merge this branch into `main` until the corrected-client hybrid TLS path and Live sequence have both been verified.

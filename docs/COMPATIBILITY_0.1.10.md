# Standalone v0.1.10 compatibility fix notes

> Date: 2026-09-02
> Branch: `fix/live-asset-compat`

## Final Asset architecture

The standalone runtime now exposes only one client-facing Asset mode:

```ini
asset_mode = remote
```

By default the client receives the original HTTPS Asset endpoint:

```text
https://assets.rainbowunicorn7297.com/<scope>/
```

An optional trusted HTTPS replacement can be configured with:

```ini
asset_remote_url = https://assets.example.com
```

The standalone server does not proxy, locally serve, TLS-intercept, or
fetch-on-miss Asset traffic. DNS interception remains API-only.

For source preservation, use the independent cache utility:

```text
tools/cache_assets.py
```

It can save the complete manifest-defined remote/R2 contents to durable local or
NAS storage and verify the preserved copy entirely offline. See
`ASSET_CACHE.md`.

## Why hybrid/local were removed

### v0.1.9 self-signed HTTPS experiment

The same v0.1.9 server build, corrected Traditional Chinese APK, database and
TheaterService behaved differently only when `asset_mode` changed:

```text
hybrid -> login fails with ErrorCode [-404 / 0]
remote -> login succeeds
```

The v0.1.9 Desktop hybrid URL was:

```text
https://theaterdays-zh.appspot.com/__mltd_assets/zh-android/
```

That reused the local API endpoint and its self-signed API certificate. The
corrected client accepts that certificate for API RPC traffic, but its Asset/Web
downloader does not accept the same topology reliably.

### v0.1.10 cleartext HTTP experiment

A later experiment moved Desktop Asset traffic to:

```text
http://theaterdays-zh.appspot.com:7651/zh-android/
```

The corrected APK targets Android SDK 29 and does not explicitly enable
`usesCleartextTraffic` or provide a network-security configuration.

Device result:

```text
資料下載失敗
ErrorCode -21990
```

Therefore cleartext local Asset transport is also rejected as a release path.

### Trusted local HTTPS relay was unnecessary

A separately controlled public-CA HTTPS hostname could technically avoid both
failures, but it adds certificate, DNS and local Asset-server complexity without
benefit when the existing remote endpoint is already normal HTTPS object
storage.

The simpler and more robust model is therefore:

```text
runtime:      client -> remote HTTPS Asset storage
preservation: remote/R2 -> explicit cache tool -> local/NAS archive
```

If the original source becomes unavailable in the future, the preserved cache
can be uploaded to another HTTPS object-storage/static-hosting endpoint and
`asset_remote_url` can be changed to that new location.

## Remote source completeness evidence

The Traditional Chinese Android manifest observed during investigation was
approximately 4.27 MB and contained 33,676 records.

For Theater assets specifically:

- 52 of 53 returned Theater resource IDs mapped directly to the manifest;
- 104 identified Theater Asset objects returned HTTP 200 from the upstream.

This ruled out missing Theater files on the current remote source as the cause
of the v0.1.9 hybrid login failure.

## Live failure — device-confirmed fixed

The remote-mode Live failure was unrelated to Asset transport.

The server traceback was:

```text
UnitService.SetUnit
TypeError: 'ChunkedIteratorResult' object is not subscriptable
```

The optimized `SetUnit` implementation passed a SQLAlchemy 2.x Result object
directly to `dict()`. The fix materializes rows first:

```python
card_rows = session.execute(...).all()
card_to_idol = dict(card_rows)
```

Fix commit:

```text
351161e8df288fce8ab478953c34701010106ca0
```

After rebuilding with that fix, the corrected Traditional Chinese client was
tested with remote Asset mode and Live operates normally.

## Remote-only GUI build — device-confirmed

The final remote-only GUI removes `Asset Mode` and `Asset Preparation` and keeps
only optional `Asset Remote URL`. The test build at commit
`a790bf3cb9b02336a87ec94d53868781040c543f` was device-tested with the corrected
Traditional Chinese client and confirmed working through login and the Live
smoke-test flow.

This confirms the release Asset/UI design itself. No hybrid/local runtime path
is required.

## Final API transport — device-confirmed

The temporary global API serialization lock and forced `Connection: close` were
introduced while the Live failure was still under investigation. The observed
root cause was instead the SQLAlchemy `SetUnit` bug.

The final implementation restores:

- concurrent direct WSGI dispatch;
- HTTP/1.1 keep-alive;
- `wsgi.multithread = True`.

The listener-wrapped TLS behavior remains unchanged from the corrected-client
compatible path.

The A/B binary built from commit:

```text
bf604f62ab217ad5d5f462fb3e49faef77869636
```

passed the corrected Traditional Chinese client smoke test:

```text
login -> Live -> SetUnit -> StartSong -> FinishSong -> return to song selection
```

Therefore the serialization lock and forced connection close are not required
for compatibility and are intentionally not part of the final release design.

## Final compatibility status

Device-confirmed:

- remote login: working;
- remote Asset download: working;
- Theater flow used during testing: working;
- Live after the SetUnit fix: working;
- final remote-only GUI build: working;
- concurrent API dispatch: working;
- HTTP/1.1 keep-alive: working;
- v0.1.9 local self-signed Asset HTTPS: rejected (`-404 / 0`);
- v0.1.10 Desktop cleartext Asset HTTP: rejected (`-21990`).

Final release architecture:

- API HTTPS listener keeps listener-wrapped TLS;
- API dispatch is threaded/concurrent and keeps HTTP/1.1 connections alive;
- Asset traffic is remote HTTPS only;
- `asset_remote_url` can redirect the client to another trusted HTTPS object
  storage endpoint;
- Asset preservation is handled only by `tools/cache_assets.py`.

All targeted compatibility and cache/transport CI suites passed after the final
transport cleanup. The branch is ready to merge into `main` and publish as
v0.1.10.

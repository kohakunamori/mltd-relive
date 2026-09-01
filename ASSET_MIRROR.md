# Local asset mirror (phase 1)

This branch introduces an **opt-in** local mirror for the public MLTD asset
host. It does not change `AssetService.GetAssetVersion` yet, so the existing
game path remains untouched while the mirror is validated.

## Goals

- Mirror the remote path layout exactly: `/<language>-<platform>/<object>`.
- Keep the remote manifest bytes unchanged.
- Store CDN objects by the exact hashed name requested by the game.
- Replay important remote metadata (`Content-Type`, `ETag`, `Last-Modified`,
  `Cache-Control`, `Content-Encoding`) when it was captured during download.
- Support `GET`, `HEAD`, HTTP byte ranges, `If-None-Match`, and
  `If-Modified-Since`.
- Resume interrupted pre-downloads and verify cached bytes with SHA-256.
- Keep all downloaded game data outside Git; `asset-cache/` is ignored.

## Pre-download

From the repository root:

```bash
python tools/prefetch_assets.py zh android --root asset-cache --workers 8
```

Other supported scopes are `zh ios`, `ko android`, and `ko ios`.

The downloader first fetches the original msgpack manifest, extracts the same
hashed object names used by the original prototype, and downloads those objects
without modifying their bytes.

To hash-check existing local objects before skipping them:

```bash
python tools/prefetch_assets.py zh android --verify-existing
```

## Start the mirror for validation

```bash
cd standalone
python -m mltd.servers.asset_server
```

The phase-1 validation server listens on HTTP port `7651` by default. Its URL
shape matches the remote asset host after the authority component, for example:

```text
remote: https://assets.rainbowunicorn7297.com/zh-android/<object>
local:  http://127.0.0.1:7651/zh-android/<object>
```

No production routing is switched in this phase.

## Byte-for-byte validation

After pre-downloading assets, compare the local manifest and a deterministic
sample of objects with the public host:

```bash
python tools/verify_asset_mirror.py zh android --sample 100
```

For a complete comparison:

```bash
python tools/verify_asset_mirror.py zh android --all
```

Only after this validation passes should `AssetService.GetAssetVersion` and the
server routing be changed to point the game at the local mirror.

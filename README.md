# MLTD zh-fixed v1 — complete decompiled client tree

This orphan branch is generated from `mltd-relive-game-client-zh-fixed.apk` in `standalone-v0.1.10`.
It is force-regenerated so the repository does not accumulate hundreds of MiB of historical binary objects for every refresh.

## Baseline

- APK SHA-256: `a423f1b09b6d9022cf255aff9a43716d6beadf32d42641da3c7b92d2e663e918`
- Maintenance source commit: `020f04e4f93fb232e3577642d92824e67c91864a`
- Generated files before branch metadata: `9906`
- Generated tree size before branch metadata: `657.6 MiB`

## Directory map

- `apktool/` — authoritative Android/Dalvik maintenance view: decoded manifest/resources, smali, assets and native payloads.
- `jadx/` — Java-like readability view; useful for shell analysis but not a guaranteed recompilable Gradle project.
- `il2cpp-dump/` — `dump.cs`, `script.json`, `il2cpp.h`, `DummyDll/`, string literals and metadata-derived symbol maps.
- `raw-critical/` — exact binary AndroidManifest/resources copied from the APK for round-trip comparison.
- `report/` — tool versions, hashes, ELF/APK structure, network hits, RPC contract, server coverage and extraction logs.
- `PROVENANCE.json` — machine-readable origin, size and largest-file inventory.
- `FILE_INDEX.tsv` — SHA-256 and size index for every decompiler/generated source file in this branch.

`rebuild-check/unsigned-rebuilt.apk` is deliberately omitted because it is a derived build product, not decompiled source. The report still records whether the Apktool rebuild validation succeeded.

## Source-of-truth hierarchy

1. Android/Dalvik byte-level edits: use `apktool/` and smali.
2. Android shell readability: use `jadx/`.
3. Gameplay/network logic: use `il2cpp-dump/dump.cs` with RVA/offset data plus `apktool/lib/arm64-v8a/libil2cpp.so`.
4. `dump.cs` restores declarations, signatures and addresses; it does not recreate the original C# method bodies.

The complete maintenance guide is `docs/CLIENT_DECOMPILATION_COMPLETE.md` on the `client-source-extraction` branch.

# zh-fixed reconstruction findings

This branch reconstructs the transformation from the verified official Traditional Chinese MLTD `2.1.000` Google Play split bundle to the historical `zh-fixed` client used by this project.

## Status

| Layer | Status | Evidence |
|---|---|---|
| Android manifest / package shell | Reconstructed | Reproducible transform + CI semantic validation |
| Java/smali shell | Reconstructed | 5,428/5,428 normalized smali files match `zh-fixed` after transform |
| Resources | Partially classified | app name confirmed; PNG rebuild/recompression noise is being separated from true pixel changes |
| `global-metadata.dat` | Deprotected target identified | official metadata is protected; `zh-fixed` has valid IL2CPP metadata magic and is dumpable with the fixed native library |
| `libil2cpp.so` | Deprotected target identified | protected official ELF and fixed ELF mapped; deprotection algorithm itself is not yet re-derived |

## Verified input baseline

Official Traditional Chinese client:

- package: `com.bandainamcoent.imas_millionlive_theaterdays_ch`
- versionCode: `21000`
- versionName: `2.1.000`
- XAPK SHA-1: `1b77ddd342a4020ba032ec63ae7ef9288551b6e7`
- base APK SHA-256: `8b8a3976687f606cba2fe3a605d80ae0f7d9cbaa72e6b97ab4bed8c556ba9081`
- arm64 split SHA-256: `9932366bd357dc33701a6e7282d26ed67630db95486f596328aade8523032e46`
- official `libil2cpp.so` SHA-256: `1a774f6ddf828179b94d40294a01b5ea6b9c8bc89769d36719bec7d56c167acf`
- official `global-metadata.dat` SHA-256: `aaf8b0d5a559d49aa5cca5937fc87beed7217c497d96cfc470d5d58abe987d69`

Historical fixed baseline:

- package: `com.bandainamcoent.imas_millionlive_theaterdays_ch.local`
- APK SHA-256: `a423f1b09b6d9022cf255aff9a43716d6beadf32d42641da3c7b92d2e663e918`
- fixed `libil2cpp.so` SHA-256: `52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b`
- fixed `global-metadata.dat` SHA-256: `0b0913387be65fb046a7536e016cd9f8514b0ac23bd79b8b20540c73cb1d8cf0`

## Android reconstruction: complete

The semantic diff reduced the apparent large `classes.dex` difference to a very small set of meaningful changes:

1. Remove the AppGuard Java shell and its manifest wiring.
2. Remove `OverrideEventListener` and its three anonymous listener classes.
3. Replace `OverrideActivity` with the clean non-AppGuard implementation found in `zh-fixed`.
4. Rename the application package to `.local` and rewrite package-bound provider authorities.
5. Remove the old package-specific C2D permission.
6. Convert the Play split metadata to the standalone/fused form used by `zh-fixed`.
7. Change `app_name` from `劇場時光` to `劇場時光L`.

The recovered transform is encoded in:

- `reconstruction-spec.yml`
- `../../tools/client-source/apply-zh-fixed-android-reconstruction.py` (repository path: `tools/client-source/apply-zh-fixed-android-reconstruction.py`)

CI applies that transform to a fresh decode of the official 2.1.000 base APK and compares the result with a fresh decode of `zh-fixed`. Current validation result:

- reconstructed smali files: `5428`
- fixed smali files: `5428`
- reconstructed-only smali: `0`
- fixed-only smali: `0`
- normalized smali differences: `0`
- all manifest/package/AppGuard/provider checks: pass

See `android/APPLY_VALIDATION.json`.

## AppGuard footprint recovered from the official bundle

The official arm64 split contains five native libraries that do not exist in `zh-fixed`:

- `libcompatible.so`
- `libcompatible_x86.so`
- `libengine-hlp.so`
- `libengine.so`
- `libstub.so`

The official base APK also contains AppGuard signing/configuration payloads:

- `assets/appguard/sign.axml`
- `assets/appguard/sign.crt`
- `assets/appguard/sign.mf`

`libstub.so` has a direct ELF `DT_NEEDED` dependency on `libcompatible.so`. `libcompatible.so` contains `/proc/self/maps`, `asm_ptrace`, crypto-related strings and an AppGuard Java-class reference. This is consistent with the INCA AppGuard loader/anti-debug family rather than application business logic.

A useful historical reference is `wjdwndud0114/REinca`, an older reverse-engineering study of INCA AppGuard. It independently documents the same `libcompatible` / `libstub` / `libengine` family and describes `libcompatible` as the anti-debug/loader layer. It is not assumed to be the exact same AppGuard version or decryption algorithm; it is only a strong architectural lead.

## Native/IL2CPP result: protection boundary confirmed

### Metadata

Both metadata files are exactly `21,159,696` bytes, but:

- official metadata does **not** begin with standard IL2CPP magic `AF 1B B1 FA`;
- `zh-fixed` metadata **does** begin with that magic;
- only about `23.15%` of same-position bytes are equal;
- no exact repeating XOR key with period <= 512 explains the transformation.

This rules out a trivial header patch or short repeating-XOR transform.

### `libil2cpp.so`

- official protected size: `105,866,464`
- fixed/deprotected size: `99,150,888`
- extra official tail: `6,715,576` bytes
- same-offset equality over the common range: about `35.16%`

The protection is highly localized by ELF section:

- unchanged or essentially unchanged: build-id/hash/version data, unwind tables, exception tables, init/fini arrays, `.data.rel.ro`, GOT, `.data`, debug-link/string-table metadata;
- heavily transformed: `.text`, custom `il2cpp` section, `.rodata`, `.dynstr`, and significant portions of relocations/dynamic-symbol data.

See `il2cpp/same-offset-analysis.md` and `il2cpp/same-offset-analysis.json`.

### Direct Il2CppDumper experiment

The .NET 6 verification workflow feeds the two exact pairs into the same pinned Il2CppDumper:

- official protected `libil2cpp.so + global-metadata.dat`: **no dump generated**;
- `zh-fixed` `libil2cpp.so + global-metadata.dat`: **dump generated successfully** (the tool later aborts with code 134 after output generation, which the wrapper records separately);
- fixed dump yielded **309 RPC-related methods**.

This confirms that the large native/metadata difference is a real AppGuard deprotection boundary, not APK repacking noise.

See `il2cpp/dotnet6-verification/STATUS.json` and the associated dump summaries/symbol lists.

## What remains to fully re-derive the historical fix

The remaining missing step is the AppGuard native deprotection procedure itself: derive the transformation that turns the protected official `libil2cpp.so` and `global-metadata.dat` into the already-verified fixed target pair.

The next shortest path is to focus on the AppGuard loader boundary rather than diffing the whole Unity binary:

1. trace `libcompatible.so` / `libstub.so` / `libengine*.so` startup and their file/memory mappings;
2. locate where protected metadata becomes a buffer beginning with `AF 1B B1 FA`;
3. locate where the protected `.text` / `il2cpp` / `.rodata` regions become executable/readable runtime images;
4. dump those post-deprotection buffers and compare their hashes/section layout against the known `zh-fixed` targets;
5. once the loader algorithm or recovered keys are understood, encode it as a deterministic offline reconstruction step and add it to `reconstruction-spec.yml`.

Until step 5 is completed, this branch deliberately labels native deprotection as `deprotection_not_yet_rederived` rather than pretending that copying the already-fixed binaries is a reconstruction.

## Scope note

The later resolution/framerate modifications in `tools/apk-patcher` are downstream user-configurable patches against the already deprotected `zh-fixed` baseline. They are intentionally kept separate from this historical AppGuard-removal reconstruction.

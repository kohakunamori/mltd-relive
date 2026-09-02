# zh-fixed reconstruction findings

This branch reconstructs the transformation from the verified official Traditional Chinese MLTD `2.1.000` Google Play split bundle to the historical `zh-fixed` client used by this project.

For continuation instructions, current blocker, exact hashes and next actions, also read `AGENT_HANDOFF.md` in this directory.

## Status

| Layer | Status | Evidence |
|---|---|---|
| Android manifest / package shell | Reconstructed | Reproducible transform + CI semantic validation |
| Java/smali shell | Reconstructed | 5,428/5,428 normalized smali files match `zh-fixed` after transform |
| Resources | Partially classified | app name confirmed; PNG rebuild/recompression noise is being separated from true pixel changes |
| AppGuard Java -> native initialization | Mostly recovered | exact removed smali preserved; real native initializer executes in a minimal JNI model |
| `libcompatible` bootstrap / trampoline | Mostly recovered | DT_INIT RWX setup, mmap trampoline page, PLT, asmFunction table, descriptor logic recovered |
| AppGuard protected code ranges | Offline decryption demonstrated | exact-sample range descriptors + repeating 16-byte XOR keys verified against runtime mutation |
| `libstub` loader entry | Recovered | DT_INIT resolves `SoLibraryStart` and passes `libstub+0x16000` |
| callback installer | Recovered, true branch not yet modeled | `libcompatible+0xc2a30` fills 7 callback cells; fallback path currently selected in harness |
| `libstub` unpacking | In progress | `SoLibraryStart` now reaches real loader operations but correct callback environment is still required |
| `libengine.so` | Protected target classified | exact payload is non-ELF/high-entropy; unpack path not yet completed |
| `global-metadata.dat` | Deprotected target identified | official metadata protected; fixed metadata has valid IL2CPP magic |
| `libil2cpp.so` | Deprotected target identified | protected/fixed ELF mapped; final end-to-end deprotection not yet re-derived |

Approximate strict-goal progress at this checkpoint: **~68%**.

## Verified input baseline

Official Traditional Chinese client:

- package: `com.bandainamcoent.imas_millionlive_theaterdays_ch`
- versionCode: `21000`
- versionName: `2.1.000`
- XAPK SHA-1: `1b77ddd342a4020ba032ec63ae7ef9288551b6e7`
- XAPK SHA-256: `ac4a1d4245be925d9d6310515641b0867b4ab8c87129ef04c64bd4d371bbd164`
- base APK SHA-256: `8b8a3976687f606cba2fe3a605d80ae0f7d9cbaa72e6b97ab4bed8c556ba9081`
- arm64 split SHA-256: `9932366bd357dc33701a6e7282d26ed67630db95486f596328aade8523032e46`
- official publisher cert SHA-256: `336ca2245718a9ca1672bf0bf2d324b29a836d899848ac0e8c08ba79097c03b3`
- official `libil2cpp.so` SHA-256: `1a774f6ddf828179b94d40294a01b5ea6b9c8bc89769d36719bec7d56c167acf`
- official `global-metadata.dat` SHA-256: `aaf8b0d5a559d49aa5cca5937fc87beed7217c497d96cfc470d5d58abe987d69`

Historical fixed baseline:

- package: `com.bandainamcoent.imas_millionlive_theaterdays_ch.local`
- APK SHA-256: `a423f1b09b6d9022cf255aff9a43716d6beadf32d42641da3c7b92d2e663e918`
- fixed `libil2cpp.so` SHA-256: `52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b`
- fixed `global-metadata.dat` SHA-256: `0b0913387be65fb046a7536e016cd9f8514b0ac23bd79b8b20540c73cb1d8cf0`

The exact public XAPK endpoint used by CI is:

`https://d.apkpure.net/b/XAPK/com.bandainamcoent.imas_millionlive_theaterdays_ch?version=latest`

The pipeline hash-verifies the downloaded input. Do not commit/rehost the original APK/XAPK binaries in git.

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
- repository path `tools/client-source/apply-zh-fixed-android-reconstruction.py`

Current validation result:

- reconstructed smali files: `5428`
- fixed smali files: `5428`
- reconstructed-only smali: `0`
- fixed-only smali: `0`
- normalized smali differences: `0`
- all manifest/package/AppGuard/provider checks: pass

See `android/APPLY_VALIDATION.json`.

The later resolution/framerate changes in `tools/apk-patcher` are downstream user-configurable modifications against the already deprotected baseline. They are intentionally separate from historical AppGuard removal.

## AppGuard footprint recovered from the official bundle

The official arm64 split contains five native AppGuard-family payloads absent from `zh-fixed`:

- `libcompatible.so`
- `libcompatible_x86.so`
- `libengine-hlp.so`
- `libengine.so`
- `libstub.so`

The official base APK also contains:

- `assets/appguard/sign.axml`
- `assets/appguard/sign.crt`
- `assets/appguard/sign.mf`

Exact-sample classification:

- `libcompatible.so`: AArch64 ELF; SHA-256 `8880c415e1ab82c31858be68ce12b76b95dc8ff8875b76c1246a8bc0679647bc`
- `libstub.so`: AArch64 ELF; direct `DT_NEEDED` dependency on `libcompatible.so`
- `libengine.so`: protected **non-ELF** high-entropy payload

Public AppGuard research such as REinca is useful architectural context only. Offsets, keys and algorithms in this branch must come from this exact 2.1.000 sample.

## Native/IL2CPP protection boundary confirmed

### Metadata

Both metadata files are exactly `21,159,696` bytes, but:

- official metadata does **not** begin with standard IL2CPP magic `AF 1B B1 FA`;
- `zh-fixed` metadata **does** begin with that magic;
- only about `23.15%` of same-position bytes are equal;
- no exact repeating XOR key with period <= 512 explains the whole-file transformation.

This rules out a trivial header patch or short repeating-XOR transform for the final metadata file.

### `libil2cpp.so`

- official protected size: `105,866,464`
- fixed/deprotected size: `99,150,888`
- extra official tail: `6,715,576` bytes
- same-offset equality over the common range: about `35.16%`

Protection is selective by ELF region: several unwind/data/GOT regions remain substantially intact while `.text`, custom `il2cpp`, `.rodata` and portions of dynamic-symbol/relocation data are heavily transformed.

See `il2cpp/same-offset-analysis.md` and `.json`.

### Direct Il2CppDumper experiment

Using the same pinned Il2CppDumper:

- official protected native + metadata: no dump generated;
- fixed native + metadata: dump generated; wrapper separately records a later abort after output generation;
- fixed dump yielded 309 RPC-related methods.

This confirms a real native/metadata deprotection boundary rather than APK repacking noise.

## `libcompatible` bootstrap reconstruction

The exact sample DT_INIT path has been decoded far enough to establish the loader skeleton.

It:

1. calculates its current ELF load base;
2. reads ELF64 `e_phoff` and `e_phnum`;
3. walks 0x38-byte `Elf64_Phdr` entries;
4. finds `PT_LOAD` span and page-aligns it;
5. calls `mprotect(base, image_span, 7)` — `PROT_READ|PROT_WRITE|PROT_EXEC`;
6. maps an anonymous `0x1000` RWX page using mmap-like arguments;
7. builds runtime trampoline/dispatch state.

The custom dynamic parser recovered **230/230** canonical AArch64 PLT stubs despite damaged section tables.

Known runtime dispatch structure:

- `asmFunction` table: 21 pointer slots around `libcompatible+0x1eceb8`
- all 21 writes are located
- Bionic/Unicorn execution reaches a callback-ready state and installs the loader callback used by subsequent stages

Relevant evidence includes:

- `appguard-analysis/dt-init-region.md`
- `appguard-analysis/loader-slice.md`
- `appguard-analysis/solibrary-cfg.md`
- `appguard-analysis/asmfunction-*`

## Protected code descriptor table and offline XOR decryption

A major result is that significant AppGuard-protected `libcompatible` code ranges can now be reconstructed offline.

Runtime range descriptors behave as 0x20-byte entries of roughly:

`[start RVA][end RVA][size][descriptor/state]`

At least 25 ranges were recovered.

Important examples:

- `0x1b660 -> 0x4d1d0`, size `0x31b70`
- `0x1712a8 -> 0x171878`, size `0x5d0`
- `0x4d1d0 -> 0x521fc`, size `0x502c`

Dynamic byte-level slicing reduced the transform to:

`plain[i] = cipher[i] XOR key[i mod 16]`

for complete 16-byte blocks.

Verified target `0x4d1d0..0x521fc`:

- key source: `libcompatible+0x1712a8`
- key: `a80300b008d18db9c90300d029e12291`
- transform applies to `0x5020` bytes; final 12-byte remainder is untouched
- offline reconstruction matches runtime-mutated memory when this remainder rule is respected

Verified target `0x1b660..0x4d1d0`:

- key source: `libcompatible+0x7080c`
- key: `a80b00d008d18db9c90b00f029e12291`
- checked decrypted prefix has 100% AArch64 decode rate and ~98% ordinary-instruction ratio
- previously faulting helpers `0x1cd4c`, `0x1cd84`, `0x1ce2c` become valid code

This supersedes the earlier idea that those helper failures necessarily required a full SIGILL/lazy-decrypt simulation.

## `libstub` -> `SoLibraryStart` boundary recovered

`libstub.so` deliberately damages normal section-based analysis, but direct `PT_DYNAMIC` parsing recovers its real loader linkage.

Its DT_INIT effectively performs:

```text
x17 = GOT[SoLibraryStart]
x0  = libstub_base + 0x16000
br   x17
```

Therefore the exact first argument to `libcompatible.SoLibraryStart()` is known: a structure at `libstub+0x16000`.

With the known `libcompatible` protected code ranges pre-decrypted, this call advances through hundreds of native instructions and reaches real loader operations including memory protection/mapping, `madvise`, mutex and allocation activity.

## AppGuard Java/native bridge preserved

The exact AppGuard smali removed by `zh-fixed` is preserved under:

`android/original-appguard-smali/`

Important Java order:

1. `AppGuardProxyApplication.onCreate()`
2. `JNISoxProxy.setApplicationContext(...)` — pure Java state setup
3. native `AppGuardProxyApplication.IiIiiIiIiI(Context)`

The current exact-sample native entry used by the harness is:

`libcompatible+0x1338e4`

A narrow JNI model executes this function for over 200k native instructions and reaches real calls such as `FindClass`, `NewGlobalRef`, `NewStringUTF`, method lookup, `ActivityManager`, `getSystemService`, `getRunningServices`, and `java/util/List` methods.

Relevant harness:

`tools/client-source/emulate-appguard-jni-init.py`

## Callback installer: long-standing NULL blocker solved

A previous major blocker was an indirect call through a BSS state slot ultimately at:

`libcompatible+0x1eb858`

That slot remained zero after DT_INIT, long DT_INIT execution, absent DT_INIT_ARRAY handling, and libstub DT_INIT. It is now known to be initialized by a separate function:

`libcompatible+0xc2a30`

Executing that installer in the initialized Unicorn state fills seven callback cells:

```text
+0x1eb838 = 0x7250
+0x1eb840 = 0x3420
+0x1eb848 = 0x2530
+0x1eb850 = 0x1100
+0x1eb858 = 0x4580
+0x1eb860 = 0x7510
+0x1eb868 = 0x7130
```

The writes occur at `0xc2ad0..0xc2ae8` and were observed by actual execution, not manual injection.

Evidence:

- `appguard-analysis/callback-installer/callback-installer.md`
- `appguard-analysis/emulation/callback-installer/callback-installer-emulation.md`
- `tools/client-source/emulate-appguard-callback-installer.py`
- `.github/workflows/emulate-appguard-callback-installer.yml`

## Current blocker: installer fallback branch

The installer contains a branch driven by:

`BL libcompatible+0xcac34`

In the current minimal emulator, the condition selects the fallback path. That path materializes the small constants listed above and stores them in the callback cells.

The real/native initializer then runs for ~219k instructions and eventually attempts to execute one of these values, stopping at:

`Invalid memory fetch; PC = 0x7250`

The installer also has a non-fallback path that obtains callback values through globals/GOT around `0x1e5xxx` / `0x1e6xxx` rather than materializing the small constants.

Therefore the current shortest-path question is:

> What does `libcompatible+0xcac34` test, and what exact Android/linker/runtime state must be modeled so that `+0xc2a30` installs the real executable callbacks instead of the fallback constants?

Do **not** blindly hardcode callback slot values. Recover the condition and the true branch sources.

## Immediate continuation plan

Priority order:

1. Recover `libcompatible+0xcac34` CFG, input provenance and runtime return condition.
2. Dynamically capture registers/globals immediately before/after the call.
3. Resolve every callback source used by the true branch of `+0xc2a30`, including relocation/runtime initialization provenance.
4. Make the minimal harness satisfy the real condition and verify callback values map to executable memory/RWX trampolines.
5. Re-run `AppGuardProxyApplication.IiIiiIiIiI(Context)` with the correct callback table; add JNI stubs only as reached.
6. Re-run `SoLibraryStart(libstub+0x16000)` and track libstub writes/decompression/ELF reconstruction.
7. Cross into the protected non-ELF `libengine.so` payload and recover its loader/decrypt/decompress/relocation behavior.
8. Dump post-deprotection `libil2cpp`/metadata buffers and compare directly with historical fixed targets.
9. Once deterministic, encode the offline native transform into `tools/client-source/` and `reconstruction-spec.yml` and add end-to-end CI.

## Disproved / low-value paths

Do not repeat these without new evidence:

- running DT_INIT longer does not initialize `+0x1eb858`;
- `libcompatible` does not have a useful DT_INIT_ARRAY path for this callback cluster;
- libstub DT_INIT calls `SoLibraryStart` almost immediately and does not pre-initialize the cluster;
- `0x94c` is not directly the final runtime descriptor table;
- protected `0x1cd84` is not simply waiting for later DT_INIT overwrite; the containing code range can be offline XOR-decrypted;
- public AppGuard/REinca offsets are not exact for this sample.

## Strict completion condition

The native work is **not complete** until the transformation from official protected files to deprotected outputs is independently re-derived and automated.

The strongest completion target is byte-exact output:

- `libil2cpp.so` SHA-256 `52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b`
- `global-metadata.dat` SHA-256 `0b0913387be65fb046a7536e016cd9f8514b0ac23bd79b8b20540c73cb1d8cf0`

Until then, do not label native deprotection complete merely because already-fixed payloads can be copied into a rebuilt APK.

## Scope note

“Complete decompilation” in this repository means full smali/resources/JADX plus IL2CPP metadata/signatures/RVAs/DummyDLLs and the original native binary. It does not imply recovery of exact original Unity C# method bodies from IL2CPP AOT.
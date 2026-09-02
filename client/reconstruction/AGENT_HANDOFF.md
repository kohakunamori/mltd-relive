# MLTD zh-fixed reconstruction — Agent handoff

This document is the primary handoff entry point for continuing the reverse-engineering/reconstruction work on the historical Traditional Chinese MLTD `zh-fixed` client.

## Repository / branch / goal

- Repository: `kohakunamori/mltd-relive`
- Work branch: `client-zh-fixed-reconstruction`
- Do **not** merge this branch to `main` yet.
- Do **not** merge the huge orphan branch `client-decompiled-zh-fixed-v1` into `main`.
- Current overall progress estimate: roughly **68%** toward the strict final goal.

Strict final goal:

1. start from the verified official Traditional Chinese MLTD `2.1.000` bundle;
2. deterministically reconstruct the historical `zh-fixed` transformation;
3. independently derive AppGuard removal/deprotection rather than copying already-fixed payloads;
4. produce a deprotected `libil2cpp.so` and `global-metadata.dat` that match the known historical fixed targets, ideally byte-for-byte / SHA-256 exact;
5. integrate the process as a reproducible reconstruction pipeline with CI validation.

Important semantic constraint: IL2CPP AOT means “complete decompilation” does **not** mean exact original C# bodies or the original Unity project. Source truth order is Apktool/smali > JADX readability > IL2CPP metadata/signatures/RVAs > original native binary.

## Verified official input

Official Traditional Chinese client:

- package: `com.bandainamcoent.imas_millionlive_theaterdays_ch`
- versionCode: `21000`
- versionName: `2.1.000`
- public exact XAPK endpoint used by CI:
  `https://d.apkpure.net/b/XAPK/com.bandainamcoent.imas_millionlive_theaterdays_ch?version=latest`
- XAPK size: `106437938`
- XAPK SHA-1: `1b77ddd342a4020ba032ec63ae7ef9288551b6e7`
- XAPK SHA-256: `ac4a1d4245be925d9d6310515641b0867b4ab8c87129ef04c64bd4d371bbd164`
- base APK SHA-256: `8b8a3976687f606cba2fe3a605d80ae0f7d9cbaa72e6b97ab4bed8c556ba9081`
- arm64 split SHA-256: `9932366bd357dc33701a6e7282d26ed67630db95486f596328aade8523032e46`
- official publisher cert SHA-256: `336ca2245718a9ca1672bf0bf2d324b29a836d899848ac0e8c08ba79097c03b3`

Official protected targets:

- `libil2cpp.so`
  - size: `105866464`
  - SHA-256: `1a774f6ddf828179b94d40294a01b5ea6b9c8bc89769d36719bec7d56c167acf`
- `global-metadata.dat`
  - size: `21159696`
  - SHA-256: `aaf8b0d5a559d49aa5cca5937fc87beed7217c497d96cfc470d5d58abe987d69`

Historical fixed baseline:

- package: `com.bandainamcoent.imas_millionlive_theaterdays_ch.local`
- APK SHA-256: `a423f1b09b6d9022cf255aff9a43716d6beadf32d42641da3c7b92d2e663e918`
- fixed `libil2cpp.so`
  - size: `99150888`
  - SHA-256: `52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b`
- fixed `global-metadata.dat`
  - size: `21159696`
  - SHA-256: `0b0913387be65fb046a7536e016cd9f8514b0ac23bd79b8b20540c73cb1d8cf0`

Do not casually commit/rehost the copyrighted original APK/XAPK binaries. CI downloads and hash-verifies them on demand.

## Completed: Android reconstruction

Android reconstruction is effectively complete.

The semantic transform is encoded by:

- `client/reconstruction/reconstruction-spec.yml`
- `tools/client-source/apply-zh-fixed-android-reconstruction.py`
- `.github/workflows/validate-android-reconstruction.yml`

Validation result against the historical fixed APK:

- reconstructed smali files: `5428`
- fixed smali files: `5428`
- reconstructed-only: `0`
- fixed-only: `0`
- normalized changed smali: `0`
- manifest/package/AppGuard/provider checks: pass

The one historical Java behavior change of interest is `OverrideActivity`; AppGuard listeners and shell classes are removed. Later resolution/FPS patches are downstream user-configurable patches and are not part of the historical AppGuard-removal reconstruction.

See:

- `client/reconstruction/android/APPLY_VALIDATION.json`
- `client/reconstruction/FINDINGS.md`

## Fixed IL2CPP baseline already recovered

The historical fixed binary is dumpable as IL2CPP 24.1 / metadata 24.1.

Known fixed registration values:

- CodeRegistration: `0x5b058a0`
- MetadataRegistration: `0x5b05920`

Useful fixed RVAs:

- `Imas.Connection.API.GetAuthURL()` `0x1AAC27C`
- `GetRootURL()` `0x1AAC2EC`
- `GetRpcURL()` `0x1AAC354`
- `SetGameServerUrl(string)` `0x1AAC3C8`
- `GetResponseJson(...)` `0x1AAC434`
- `.cctor()` `0x1AAC8BC`

A complete decompilation/reference tree exists on orphan branch `client-decompiled-zh-fixed-v1`; do not merge that branch into main.

## AppGuard payload classification

Official arm64 split contains the AppGuard family absent from `zh-fixed`:

- `libcompatible.so`
- `libcompatible_x86.so`
- `libengine-hlp.so`
- `libengine.so`
- `libstub.so`

Important exact-sample facts:

- `libcompatible.so`: AArch64 ELF, SHA-256 `8880c415e1ab82c31858be68ce12b76b95dc8ff8875b76c1246a8bc0679647bc`
- `libstub.so`: AArch64 ELF, depends on `libcompatible.so`
- `libengine.so`: protected **non-ELF** payload, high entropy
- AppGuard base assets include `assets/appguard/sign.axml`, `sign.crt`, `sign.mf`

The static/native evidence is under `client/reconstruction/appguard-analysis/`.

## Major native breakthroughs already completed

### 1. `libcompatible` DT_INIT bootstrap semantics

Exact sample-specific disassembly establishes:

- compute current `libcompatible` load base;
- parse ELF64 program headers;
- scan `PT_LOAD` entries;
- calculate page-aligned image span;
- call `mprotect(base, image_span, PROT_READ|PROT_WRITE|PROT_EXEC)`;
- map an anonymous `0x1000` RWX page with mmap-like arguments;
- build runtime trampoline/dispatch structures.

PLT reconstruction recovered `230/230` canonical AArch64 PLT stubs despite intentionally damaged section headers.

### 2. `asmFunction` / trampoline table

A 21-pointer runtime table is located around `libcompatible+0x1eceb8`.

The DT_INIT bootstrap writes all 21 table entries. The `+0x98/+0xa0` callback pair eventually resolves to runtime callback `libcompatible+0xd356c` in the Bionic/Unicorn model.

Relevant scripts include:

- `tools/client-source/analyze-appguard-bootstrap.py`
- `tools/client-source/analyze-appguard-loader-slice.py`
- `tools/client-source/analyze-appguard-solibrary.py`
- `tools/client-source/emulate-appguard-dt-init-bionic.py`
- `tools/client-source/profile-appguard-post-builder.py`
- `tools/client-source/profile-appguard-post-callback.py`

### 3. AppGuard code-range descriptor format

A runtime descriptor table has been recovered. Entries behave as 0x20-byte range descriptors of the rough form:

`[start RVA][end RVA][end-start][per-range descriptor/state]`

At least 25 protected ranges were parsed.

Important observed ranges include:

- `0x1b660 -> 0x4d1d0`, size `0x31b70`
- `0x1712a8 -> 0x171878`, size `0x5d0`
- `0x4d1d0 -> 0x521fc`, size `0x502c`

### 4. Native code decryption reduced to 16-byte repeating XOR

The runtime code transform was dynamically sliced at byte level.

The hot loop is equivalent to:

`plaintext_byte = ciphertext_byte XOR key_byte`

with a fixed 16-byte key repeated across full 16-byte blocks of each protected range.

Verified examples:

For target `0x4d1d0..0x521fc`:

- key source: `libcompatible+0x1712a8`
- key16: `a80300b008d18db9c90300d029e12291`
- only complete 16-byte blocks are transformed; the 12-byte remainder stays untouched
- offline reconstruction SHA-256 matches the runtime-mutated memory result when this rule is respected

For target `0x1b660..0x4d1d0`:

- key source: `libcompatible+0x7080c`
- key16: `a80b00d008d18db9c90b00f029e12291`
- decrypted AArch64 decode rate over the checked prefix is 100%; ordinary-instruction rate was about 98%
- previously faulting `0x1cd84`, `0x1cd4c`, `0x1ce2c` become normal AArch64 code

This means the earlier SIGILL/lazy-decrypt theory is not required for these ranges: they can be pre-decrypted offline.

### 5. `libstub` entry into `SoLibraryStart`

`libstub.so` has intentionally broken section metadata, but parsing `PT_DYNAMIC` directly recovers the real dynamic linkage.

Its DT_INIT effectively performs:

- resolve `GOT[SoLibraryStart]`
- set `x0 = libstub_base + 0x16000`
- branch to `SoLibraryStart`

Therefore the real first argument to `libcompatible.SoLibraryStart()` is known: a structure at `libstub+0x16000`.

Pre-decrypting the two known `libcompatible` code ranges pushed `SoLibraryStart(libstub+0x16000)` from immediate failure to hundreds of executed instructions and real loader operations such as `mprotect`, `mmap`, `madvise`, mutex, malloc.

### 6. The long-standing NULL callback blocker is solved

The earlier blocker was:

- `libcompatible+0xc0d88` performs an indirect call through a pointer ultimately stored at `libcompatible+0x1eb858`;
- in the minimal harness this slot was NULL.

This slot is **not** initialized by DT_INIT, DT_INIT_ARRAY, or libstub DT_INIT.

The real callback installer is now identified as:

`libcompatible+0xc2a30`

Executing this function in the real initialized Unicorn state fills a 7-slot callback cluster:

- `+0x1eb838 = 0x7250`
- `+0x1eb840 = 0x3420`
- `+0x1eb848 = 0x2530`
- `+0x1eb850 = 0x1100`
- `+0x1eb858 = 0x4580`
- `+0x1eb860 = 0x7510`
- `+0x1eb868 = 0x7130`

This was obtained by **actually executing** the installer; the values were not manually injected.

Evidence:

- `client/reconstruction/appguard-analysis/callback-installer/callback-installer.md`
- `client/reconstruction/appguard-analysis/emulation/callback-installer/callback-installer-emulation.md`
- `tools/client-source/emulate-appguard-callback-installer.py`
- `.github/workflows/emulate-appguard-callback-installer.yml`

### 7. AppGuard Java -> JNI initialization chain is now executable

The exact official AppGuard smali removed by `zh-fixed` is preserved under:

`client/reconstruction/android/original-appguard-smali/`

The important Java order is:

- `AppGuardProxyApplication.onCreate()`
- `JNISoxProxy.setApplicationContext(...)` (pure Java state setup)
- native `AppGuardProxyApplication.IiIiiIiIiI(Context)`

The real native initializer entry used by the current harness is:

`libcompatible+0x1338e4`

A minimal JNI model now executes over 200k native instructions and reaches real JNI operations including:

- `NewGlobalRef`
- `FindClass(android/content/Context)`
- `NewStringUTF("activity")`
- `FindClass(java/lang/String)`
- constructor lookup/allocation
- `android/app/ActivityManager`
- `getSystemService`
- `getRunningServices`
- `java/util/List.size/get`

Relevant script:

`tools/client-source/emulate-appguard-jni-init.py`

## Current exact blocker

The callback installer at `+0xc2a30` has two branches selected by the result of:

`BL libcompatible+0xcac34`

In the minimal emulator, `+0xcac34` currently causes the installer to take its fallback path. The fallback path writes small values such as `0x7250`, `0x4580`, `0x7130` into the callback cluster.

After the installer, the JNI initializer eventually performs an indirect call through one of those values and stops with:

`Invalid memory fetch; PC = 0x7250`

This is now the **primary blocker**.

The key next question is:

> What exact condition/environment does `libcompatible+0xcac34` test, and what must be modeled so that the installer takes the real Android branch and installs valid callback pointers rather than the fallback small constants?

Do not solve this by blindly hardcoding `0x1eb858` or by treating the fallback constants as absolute executable addresses unless independent evidence proves that interpretation.

## Recommended next steps, in priority order

1. Fully analyze `libcompatible+0xcac34`.
   - Recover CFG and all direct/indirect dependencies.
   - Identify whether it checks Android API/ABI, linker state, system properties, CPU features, app process state, pointer table readiness, or another environment invariant.
   - Run dynamic probes around the branch and capture all inputs immediately before the call and return value after it.

2. Resolve the *true branch* callback sources in `+0xc2a30`.
   - The true path reads several pointers through globals/GOT around `0x1e5xxx`/`0x1e6xxx` instead of materializing the fallback constants.
   - Trace each source relocation and runtime initialization.
   - Verify resulting values point to mapped/executable code in the emulated image or generated RWX page.

3. Re-run `AppGuardProxyApplication.IiIiiIiIiI(Context)` with the correct callback table.
   - Extend the JNI model only when execution reaches an unmodeled JNI API.
   - Do not over-model Android wholesale.

4. Re-run `SoLibraryStart(libstub+0x16000)` after JNI/callback initialization.
   - Track writes to libstub.
   - Snapshot new ELF magic, decompressed blocks, relocation tables, and executable mappings.

5. Cross into `libengine.so`.
   - `libengine.so` is a protected non-ELF payload.
   - Look for its file reads/mmap, decrypt transform, LZ4/inflate use, reconstructed dynsym/strtab/relocations.

6. Recover `libil2cpp.so` / metadata transformation.
   - Dump post-deprotection native/metadata buffers.
   - Compare section layout and SHA-256 against the fixed targets.
   - Once deterministic, encode an offline transform in `tools/client-source/` and `reconstruction-spec.yml`.

7. Only after native reconstruction is coherent, add final end-to-end CI and consider merging the reconstruction branch.

## Things already tried / disproven

Avoid repeating these unless new evidence warrants it:

- More DT_INIT execution does not fill `+0x1eb858`; even tens of millions of instructions did not.
- `libcompatible.so` has no useful DT_INIT_ARRAY constructor path for this slot.
- libstub DT_INIT does not initialize the callback cluster before calling `SoLibraryStart`.
- Directly reading the early `0x94c` static source as the final runtime descriptor table is wrong; bootstrap transforms/copies state before use.
- The protected helper around `0x1cd84` is not merely waiting for more DT_INIT runtime to overwrite it; the relevant larger code ranges can be offline XOR-decrypted.
- Do not assume public REinca offsets/algorithms match this exact AppGuard version. Use external research only as architectural guidance; sample-specific offsets must come from this binary.

## High-value files

Read these first:

- `client/reconstruction/FINDINGS.md`
- `client/reconstruction/AGENT_HANDOFF.md` (this file)
- `client/reconstruction/reconstruction-spec.yml`
- `client/reconstruction/android/APPLY_VALIDATION.json`
- `client/reconstruction/appguard-analysis/callback-installer/callback-installer.md`
- `client/reconstruction/appguard-analysis/emulation/callback-installer/callback-installer-emulation.md`
- `client/reconstruction/appguard-analysis/dt-init-region.md`
- `client/reconstruction/appguard-analysis/loader-slice.md`
- `client/reconstruction/appguard-analysis/solibrary-cfg.md`
- `client/reconstruction/appguard-analysis/descriptor-table.md` or the current descriptor-analysis outputs if filename differs
- `tools/client-source/emulate-appguard-callback-installer.py`
- `tools/client-source/emulate-appguard-jni-init.py`
- `tools/client-source/emulate-appguard-libstub-predecrypted.py`
- `tools/client-source/emulate-appguard-dt-init-bionic.py`

If a listed evidence filename changed, inspect `client/reconstruction/appguard-analysis/` rather than assuming it vanished.

## Working discipline

- Keep all reconstruction work on `client-zh-fixed-reconstruction`.
- Save each meaningful analysis result, script and CI evidence to the repo so another agent can resume without chat history.
- Prefer exact sample evidence over speculative AppGuard generalizations.
- When static analysis becomes ambiguous, use a narrow Unicorn experiment with explicit hooks rather than broad guessing.
- Distinguish “works functionally” from “matches historical fixed bytes/hash”. The final target is stricter.
- Do not commit original APK/XAPK binaries to git.
- Do not claim original C# source recovery from IL2CPP.

## Current progress estimate

Approximate strict-goal progress: **68%**.

Interpretation:

- Android reconstruction: complete.
- AppGuard outer bootstrap/trampoline/descriptor/code-decrypt mechanism: mostly understood.
- callback/JNI initialization: real path identified and partially executable.
- libstub actual unpacking: not yet complete.
- libengine unpacking: not yet complete.
- exact fixed `libil2cpp.so` and metadata derivation: not yet complete.

The next major milestone is to get past `+0xcac34`, install valid callback pointers, and make `SoLibraryStart(libstub+0x16000)` execute into actual libstub unpack/decompression rather than stopping on a fallback callback.
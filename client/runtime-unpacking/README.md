# MLTD 2.1.000 runtime unpacking experiment

This branch is intentionally separate from `client-zh-fixed-reconstruction`.

- Static reconstruction remains on `client-zh-fixed-reconstruction`.
- Runtime dumping / unpacking experiments live here.
- Target package is the verified official Traditional Chinese client: `com.bandainamcoent.imas_millionlive_theaterdays_ch` (`versionCode=21000`, `versionName=2.1.000`, arm64-v8a).

## Goal

Recover the deprotected runtime IL2CPP payload directly from the official AppGuard-protected client, then compare it against the historical `zh-fixed` baseline.

Success criteria:

1. Obtain a runtime-readable IL2CPP dump (`dump.cs` or equivalent).
2. Dump `libil2cpp.so` from process memory and rebuild a valid ELF.
3. Dump or recover `global-metadata.dat` with IL2CPP magic `AF 1B B1 FA`.
4. Compare against known `zh-fixed` payload hashes:
   - `libil2cpp.so`: `52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b`
   - `global-metadata.dat`: `0b0913387be65fb046a7536e016cd9f8514b0ac23bd79b8b20540c73cb1d8cf0`
5. If hashes differ, perform section/function/metadata semantic comparison rather than assuming failure.

## Candidate routes

### Route A — Zygisk-Il2CppDumper

Primary first attempt. It runs inside the target process and is explicitly designed to dump IL2CPP despite protection/encryption/obfuscation.

Pinned upstream baseline: `Perfare/Zygisk-Il2CppDumper@ede65d18a795882e37a2d988943d77a72d132c5d`.

Expected output: `/data/data/com.bandainamcoent.imas_millionlive_theaterdays_ch/files/dump.cs`.

### Route B — Frida IL2CPP dumper

Use `IIIImmmyyy/frida-il2cppDumper` with `_agent.js` patched for the MLTD package. This route is useful if AppGuard finishes decryption after process startup and Zygisk's dump timing is unsuitable.

### Route C — native process-memory dump

Use an ARM64 root memory dumper (e.g. IL2CPPDumper/TinyDump/PADumper) to dump the mapped `libil2cpp.so`, then repair the ELF with SoFixer-compatible logic. This route is required if `dump.cs` works but we still need the exact deprotected native binary.

## Device assumptions

The actual runtime phase requires a real arm64 Android device with root. CI only builds/prepares the tooling; it cannot reproduce AppGuard runtime decryption without a device process.

Prefer a physical arm64 device over x86 Android emulators. Keep the official protected package unchanged for the first experiment so that observed runtime output belongs to the original AppGuard chain.

## Repository layout

- `toolchain.lock.json` — upstream versions/commits and target package.
- `tools/client-runtime/collect-mltd-runtime-dump.sh` — adb/root collection helper.
- `tools/client-runtime/verify-mltd-runtime-dump.py` — validates ELF/metadata/dump outputs and compares known hashes.
- `.github/workflows/runtime-unpacking-toolchain.yml` — builds/prepares reproducible runtime tooling as CI artifacts.

No third-party tool source or generated binaries are committed to this repository; they are fetched/built as CI artifacts.
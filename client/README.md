# MLTD Traditional Chinese client maintenance baseline

This directory is the small, reviewable source-of-truth layer for maintaining the corrected Traditional Chinese (`zh-fixed`) client together with the relive server.

It deliberately does **not** contain the complete 500+ MB decompilation tree. The full apktool/JADX/IL2CPP views are generated reproducibly by `.github/workflows/extract-zh-fixed-client.yml` and uploaded as Actions artifacts.

## What is authoritative

- `baseline/zh-fixed-v1.json`
  - exact APK, `libil2cpp.so`, and `global-metadata.dat` hashes;
  - package/version/SDK information;
  - extraction tool versions and rebuild status.
- `android/smali/`
  - exact baseline Dalvik/smali for the game-specific Android shell classes we currently patch or need to reason about.
- `il2cpp/patch-points.yml`
  - named native patch points bound to an exact `libil2cpp.so` hash and expected original instruction bytes.

## Generated source views

Run the GitHub Actions workflow `Extract zh-fixed client source` or execute locally:

```bash
chmod +x tools/client-source/extract-zh-fixed.sh
chmod +x tools/client-source/extract-il2cpp.sh

tools/client-source/extract-zh-fixed.sh \
  /path/to/mltd-relive-game-client-zh-fixed.apk \
  client-source-output

tools/client-source/extract-il2cpp.sh client-source-output
```

The generated tree contains:

```text
client-source-output/
  apktool/        # editable/rebuildable Android + smali representation
  jadx/           # Java-like readability view; not an authoritative build source
  il2cpp-dump/    # metadata-derived C# declarations/RVA maps when Il2CppDumper succeeds
  raw-critical/   # original binary manifest/resources payloads
  report/         # hashes, tool logs, structure and network/search reports
  rebuild-check/  # unsigned apktool rebuild
```

## Important limitation

MLTD is a Unity IL2CPP title. JADX can recover the Android wrapper, but most game logic is compiled into `libil2cpp.so`. `dump.cs` from Il2CppDumper is also **not the original C# implementation**: it restores types, method signatures and native address annotations from IL2CPP metadata. Native method bodies remain ARM64 machine code.

That is still sufficient for most maintenance work needed by this project: locating request/asset/service classes, mapping methods to native RVAs, identifying server-related constants, and turning one-off binary edits into verified patches.

## Update policy

When a future client baseline changes:

1. update `release/game-client.env` and its SHA-256;
2. run the extraction workflow;
3. compare the generated reports and relevant smali/IL2CPP symbols;
4. add a new baseline record rather than silently reusing old offsets;
5. require patchers to verify both the baseline file hash and the expected bytes/signature at every native patch point;
6. keep large generated trees in Actions artifacts unless a specific extracted file is important enough to review/version directly.

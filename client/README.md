# MLTD Traditional Chinese client maintenance baseline

This directory is the small, reviewable source-of-truth layer for maintaining the corrected Traditional Chinese (`zh-fixed`) client together with the relive server.

The complete generated decompilation is published separately on the orphan branch:

- [`client-decompiled-zh-fixed-v1`](https://github.com/kohakunamori/mltd-relive/tree/client-decompiled-zh-fixed-v1)
- [Complete decompilation and maintenance guide](../docs/CLIENT_DECOMPILATION_COMPLETE.md)

Keeping the generated tree on a dedicated orphan branch avoids making normal `main` clones carry hundreds of MiB of decompiler/native output while still keeping the complete result directly browsable in this repository.

## What is authoritative

- `baseline/zh-fixed-v1.json`
  - exact APK, `libil2cpp.so`, and `global-metadata.dat` hashes;
  - package/version/SDK information;
  - extraction tool versions and rebuild status.
- `android/smali/`
  - exact baseline Dalvik/smali for the game-specific Android shell classes we currently patch or need to reason about.
- `contract/rpc-methods-zh-fixed-v1.txt`
  - stable sorted snapshot of the 75 services / 309 recovered RPC method constants.
- `il2cpp/patch-points.yml`
  - named native patch points bound to an exact `libil2cpp.so` hash and expected original instruction bytes.

## Complete generated source branch

The generated branch contains:

```text
client-decompiled-zh-fixed-v1/
  README.md
  PROVENANCE.json
  FILE_INDEX.tsv
  apktool/        # editable/rebuildable Android + smali representation
  jadx/           # Java-like readability view
  il2cpp-dump/    # dump.cs, script.json, il2cpp.h, DummyDll, metadata maps
  raw-critical/   # exact binary manifest/resources payloads
  report/         # hashes, tool logs, ELF/APK structure, RPC/server comparison
```

`FILE_INDEX.tsv` records SHA-256 and size for every generated source/decompiler file. `PROVENANCE.json` records the exact APK baseline, maintenance commit, largest files, tool provenance and total generated-tree size.

The branch intentionally omits only `rebuild-check/unsigned-rebuilt.apk`, because that file is a derived validation build rather than decompiled source. The rebuild result itself remains recorded in `report/`.

## Reproduce locally

```bash
chmod +x tools/client-source/extract-zh-fixed.sh
chmod +x tools/client-source/extract-il2cpp.sh

tools/client-source/extract-zh-fixed.sh \
  /path/to/mltd-relive-game-client-zh-fixed.apk \
  client-source-output

tools/client-source/extract-il2cpp.sh client-source-output

python tools/client-source/compare-server-contract.py \
  client-source-output/report/client-rpc-methods.txt \
  standalone/mltd/services \
  client-source-output/report
```

For a repository-hosted regeneration, use:

- `.github/workflows/extract-zh-fixed-client.yml` to generate downloadable artifacts;
- `.github/workflows/publish-zh-fixed-decompiled.yml` to regenerate and force-publish the complete orphan branch.

## Important limitation

MLTD is a Unity IL2CPP title. JADX can recover the Android wrapper, but most game logic is compiled into `libil2cpp.so`. `dump.cs` from Il2CppDumper is also **not the original C# implementation**: it restores types, method signatures and native address annotations from IL2CPP metadata. Native method bodies remain ARM64 machine code.

For concrete gameplay/network method behavior, use the recovered method/RVA from `dump.cs` or `script.json` and analyze the corresponding ARM64 body in `libil2cpp.so` with Ghidra/IDA or another native disassembler/decompiler.

This is nevertheless a complete reproducible reverse-engineering representation of what can be recovered from the shipped APK without access to the original Unity project: Android smali/resources, Java-like DEX decompilation, original native/Unity payloads, IL2CPP metadata declarations and address maps, dummy assemblies, hashes and contract indexes.

## Update policy

When a future client baseline changes:

1. update `release/game-client.env` and its SHA-256;
2. create a new baseline ID rather than silently replacing `zh-fixed-v1`;
3. run the extraction workflow and regenerate the dedicated decompiled branch;
4. compare RPC contracts, smali, metadata and network symbols;
5. relocate native patches from method identity/signatures rather than assuming old RVAs/file offsets remain valid;
6. require patchers to verify both the baseline file hash and expected bytes/signature at every native patch point;
7. write durable reverse-engineering conclusions back into `client/`, `tools/client-source/`, tests or `docs/` instead of manually editing the generated branch.

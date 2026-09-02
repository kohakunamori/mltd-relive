# Runtime unpacking status

This file tracks the isolated runtime-unpacking branch only. The static reconstruction branch `client-zh-fixed-reconstruction` remains static-only and is not modified by this work.

## Toolchain preparation

GitHub Actions run `33629043933` validated all three runtime routes.

| Route | Status | Result |
| --- | --- | --- |
| Zygisk-Il2CppDumper | READY | MLTD original package name embedded; arm64-v8a module built successfully |
| frida-il2cppDumper | READY | `_agent.js` patched for `com.bandainamcoent.imas_millionlive_theaterdays_ch` and packaged |
| TinyDump | READY | native ARM64 Android executable built successfully; integrated SoFixer path available |

### TinyDump verified binary

- upstream: `Mrack/TinyDump@996b81dbae153b4151b9be6d082348f3c77c4ef6`
- target: `aarch64-linux-android`
- Android interpreter: `/system/bin/linker64`
- minimum build API: Android 21
- size: `5,021,440` bytes
- SHA-256: `a4526789e1a73be756ff80979a891ac736961ce2f0a041e926a07fb4d0cacee9`

The previous `kp7742/IL2CPPDumper` candidate is retained only as a historical reference because its implementation uses 32-bit address types (`unsigned int`/`kaddr`) and fails when compiled for arm64-v8a.

## Runtime execution status

**Not executed against a live AppGuard process yet.**

The remaining runtime step requires a rooted physical ARM64 Android device running the verified official Traditional Chinese 2.1.000 package. CI can reproduce the tool builds but cannot reproduce AppGuard's in-process decryption without a device process.

When a device is available, preferred order is:

1. Install the MLTD-specific Zygisk module and launch the official protected client.
2. Pull and validate `dump.cs` if generated.
3. Run TinyDump against the live PID and dump mapped `libil2cpp.so`.
4. If Zygisk timing is defeated by AppGuard, use the patched Frida agent as the alternate active-call route.
5. Recover/dump decrypted `global-metadata.dat` and validate IL2CPP magic `AF 1B B1 FA`.
6. Compare runtime payloads with the historical `zh-fixed` hashes using `tools/client-runtime/verify-mltd-runtime-dump.py`.

## Historical comparison targets

- fixed `libil2cpp.so` SHA-256: `52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b`
- fixed `global-metadata.dat` SHA-256: `0b0913387be65fb046a7536e016cd9f8514b0ac23bd79b8b20540c73cb1d8cf0`

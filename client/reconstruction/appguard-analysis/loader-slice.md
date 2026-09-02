# AppGuard `SoLibraryStart` loader slice

- `SoLibraryStart`: `0xc0d64` (symbol size `52` bytes)
- JMPREL entries: **230**
- canonical AArch64 PLT stubs recovered: **230**
- key import calls reached by bootstrap: **52**
- key loader-string xrefs reached by bootstrap: **0**

## Key strings present in `libcompatible.so`

| VA | File offset | String |
|---:|---:|---|
| `0x75c8f` | `0x75c8f` | `dlopen` |
| `0x75c96` | `0x75c96` | `dlsym` |
| `0x75f86` | `0x75f86` | `inflate` |
| `0x75f8e` | `0x75f8e` | `inflateEnd` |
| `0x75f99` | `0x75f99` | `inflateInit2_` |
| `0x75fd8` | `0x75fd8` | `LZ4_decompress_fast` |
| `0x77707` | `0x77707` | `asm_mmap2` |
| `0x7773e` | `0x7773e` | `asm_mprotect` |
| `0x792e2` | `0x792e2` | `libcompatible.so` |
| `0x175251` | `0x175251` | `/proc/self/maps` |
| `0x1760fe` | `0x1760fe` | `md5WithRSAEncryption` |
| `0x17612a` | `0x17612a` | `sha-1WithRSAEncryption` |
| `0x176159` | `0x176159` | `sha224WithRSAEncryption` |
| `0x17618c` | `0x17618c` | `sha256WithRSAEncryption` |
| `0x1761bf` | `0x1761bf` | `sha384WithRSAEncryption` |
| `0x1761f2` | `0x1761f2` | `sha512WithRSAEncryption` |
| `0x176240` | `0x176240` | `rsaEncryption` |
| `0x177561` | `0x177561` | `CIPHER - Decryption of block requires a full block` |
| `0x17788c` | `0x17788c` | `PEM - Unsupported key encryption algorithm` |
| `0x1778e1` | `0x1778e1` | `PEM - Given private key password does not allow for correct decryption` |
| `0x177928` | `0x177928` | `PEM - Unavailable feature, e.g. hashing/encryption combination` |
| `0x1779ac` | `0x1779ac` | `PK - Type mismatch, eg attempt to encrypt with an ECDSA key` |
| `0x177ad3` | `0x177ad3` | `PK - Given private key password does not allow for correct decryption` |
| `0x177c73` | `0x177c73` | `PKCS12 - Feature not available, e.g. unsupported encryption scheme` |
| `0x177cde` | `0x177cde` | `PKCS12 - Given private key password does not allow for correct decryption` |
| `0x177d6f` | `0x177d6f` | `PKCS5 - Requested encryption or digest alg not available` |
| `0x177da8` | `0x177da8` | `PKCS5 - Given private key password does not allow for correct decryption` |
| `0x177f2c` | `0x177f2c` | `RSA - The output buffer for decryption is not large enough` |
| `0x178b44` | `0x178b44` | `X509 - Unavailable feature, e.g. RSA hashing/encryption combination` |

## Bootstrap references to key strings

No block-local ADR/ADRP+ADD references resolved; pointer tables or runtime string decryption may be used.

## Recovered key imported calls

| Callsite | Owner | Import | Root |
|---:|---|---|---|
| `0x13344c` | `_Z20FCC71FC8E7FB4201E0D3P7_JNIEnvP8_jobjectiii` | `memset` | `_Z20FCC71FC8E7FB4201E0D3P7_JNIEnvP8_jobjectiii` |
| `0x133b80` | `_Z20D600B4A6B3FFB3838D77P7_JNIEnvP8_jobjectS2_` | `memset` | `_Z20D600B4A6B3FFB3838D77P7_JNIEnvP8_jobjectS2_` |
| `0x134028` | `_Z20E270F21E499946b6B8D8P7_JNIEnvP8_jobjectP8_jstringS4_` | `memset` | `_Z20E270F21E499946b6B8D8P7_JNIEnvP8_jobjectP8_jstringS4_` |
| `0x134038` | `_Z20E270F21E499946b6B8D8P7_JNIEnvP8_jobjectP8_jstringS4_` | `memset` | `_Z20E270F21E499946b6B8D8P7_JNIEnvP8_jobjectP8_jstringS4_` |
| `0x7360` | `IiIiiIiIiI` | `calloc` | `DT_INIT` |
| `0x1334cc` | `_Z20FCC71FC8E7FB4201E0D2P7_JNIEnvP8_jobjecti` | `memset` | `_Z20FCC71FC8E7FB4201E0D2P7_JNIEnvP8_jobjecti` |
| `0x1334dc` | `_Z20FCC71FC8E7FB4201E0D2P7_JNIEnvP8_jobjecti` | `memset` | `_Z20FCC71FC8E7FB4201E0D2P7_JNIEnvP8_jobjecti` |
| `0x170a90` | `iIIIIIIiIi` | `memset` | `_Z22EC8A3DFF8EAB09E43C9550P7_JNIEnvP8_jobjectS2_P8_jstringS4_S2_ii` |
| `0x140a70` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_` | `memset` | `_Z22EC8A3DFF8EAB09E43C9550P7_JNIEnvP8_jobjectS2_P8_jstringS4_S2_ii` |
| `0x171238` | `iIIIIIIiIi` | `memset` | `_Z22EC8A3DFF8EAB09E43C9550P7_JNIEnvP8_jobjectS2_P8_jstringS4_S2_ii` |
| `0x761c` | `iiIIIiIIiI` | `mprotect` | `DT_INIT` |
| `0x133b80` | `_Z20D600B4A6B3FFB3838D77P7_JNIEnvP8_jobjectS2_` | `memset` | `_Z20CD898AC19EEF3BD64A91P7_JNIEnvP8_jobjectS2_` |
| `0x170cb4` | `iIIIIIIiIi` | `memset` | `_Z22EC8A3DFF8EAB09E43C9550P7_JNIEnvP8_jobjectS2_P8_jstringS4_S2_ii` |
| `0x170cb4` | `iIIIIIIiIi` | `memset` | `_Z22EC8A3DFF8EAB09E43C9550P7_JNIEnvP8_jobjectS2_P8_jstringS4_S2_ii` |
| `0x761c` | `iiIIIiIIiI` | `mprotect` | `DT_INIT` |
| `0x170db0` | `iIIIIIIiIi` | `memset` | `_Z22EC8A3DFF8EAB09E43C9550P7_JNIEnvP8_jobjectS2_P8_jstringS4_S2_ii` |
| `0x170dc4` | `iIIIIIIiIi` | `memset` | `_Z22EC8A3DFF8EAB09E43C9550P7_JNIEnvP8_jobjectS2_P8_jstringS4_S2_ii` |
| `0x1335dc` | `_Z20FCC71FC8E7FB4201E0D2P7_JNIEnvP8_jobjecti` | `memset` | `_Z20FCC71FC8E7FB4201E0D2P7_JNIEnvP8_jobjecti` |
| `0x6bb8` | `iiiIIIiIIi` | `calloc` | `DT_INIT` |
| `0x171238` | `iIIIIIIiIi` | `memset` | `_Z22EC8A3DFF8EAB09E43C9550P7_JNIEnvP8_jobjectS2_P8_jstringS4_S2_ii` |
| `0x6e78` | `iiiIIIiIIi` | `mprotect` | `DT_INIT` |
| `0x6ed0` | `iiiIIIiIIi` | `calloc` | `DT_INIT` |
| `0x71fc` | `IIiIiiIiIi` | `mprotect` | `DT_INIT` |
| `0x6e78` | `iiiIIIiIIi` | `mprotect` | `DT_INIT` |
| `0x1711b8` | `iIIIIIIiIi` | `memset` | `_Z22EC8A3DFF8EAB09E43C9550P7_JNIEnvP8_jobjectS2_P8_jstringS4_S2_ii` |
| `0x71fc` | `IIiIiiIiIi` | `mprotect` | `DT_INIT` |
| `0x8c1c` | `IIiiiIIIiI` | `memset` | `DT_INIT` |
| `0x172080` | `iIIIIIIiIi` | `memset` | `DT_INIT` |
| `0x8c38` | `IIiiiIIIiI` | `memset` | `DT_INIT` |
| `0x8c48` | `IIiiiIIIiI` | `memset` | `DT_INIT` |
| `0x8c38` | `IIiiiIIIiI` | `memset` | `DT_INIT` |
| `0x8c48` | `IIiiiIIIiI` | `memset` | `DT_INIT` |
| `0x1720cc` | `iIIIIIIiIi` | `memset` | `DT_INIT` |
| `0xa820` | `iiIIIiiIIi` | `memset` | `DT_INIT` |
| `0xa83c` | `iiIIIiiIIi` | `memset` | `DT_INIT` |
| `0xa84c` | `iiIIIiiIIi` | `memset` | `DT_INIT` |
| `0xa83c` | `iiIIIiiIIi` | `memset` | `DT_INIT` |
| `0xa84c` | `iiIIIiiIIi` | `memset` | `DT_INIT` |
| `0x9304` | `iIIiiIIIiI` | `memset` | `DT_INIT` |
| `0x9320` | `iIIiiIIIiI` | `memset` | `DT_INIT` |
| `0x9330` | `iIIiiIIIiI` | `memset` | `DT_INIT` |
| `0xaa10` | `IIiIiIIiii` | `memset` | `DT_INIT` |
| `0x9320` | `iIIiiIIIiI` | `memset` | `DT_INIT` |
| `0x9330` | `iIIiiIIIiI` | `memset` | `DT_INIT` |
| `0xac94` | `IIIiiIIIii` | `memset` | `DT_INIT` |
| `0xa9b0` | `iIIiiIIiII` | `memset` | `DT_INIT` |
| `0xad3c` | `IIIiiIIIii` | `memset` | `DT_INIT` |
| `0xabd0` | `IiIiIiIIIi` | `memset` | `DT_INIT` |
| `0xae30` | `iiIiiiIiIi` | `memset` | `DT_INIT` |
| `0xadc4` | `IIIiiIIIii` | `memset` | `DT_INIT` |
| `0xadd4` | `iiIiiiIiIi` | `memset` | `DT_INIT` |
| `0xad6c` | `IIIiiIIIii` | `memset` | `DT_INIT` |

## Calls associated with `SoLibraryStart` symbol family

| Callsite | Owner | Target | Nearest target | PLT import |
|---:|---|---:|---|---|
| `0x13344c` | `_Z20FCC71FC8E7FB4201E0D3P7_JNIEnvP8_jobjectiii` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x133b80` | `_Z20D600B4A6B3FFB3838D77P7_JNIEnvP8_jobjectS2_` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x134028` | `_Z20E270F21E499946b6B8D8P7_JNIEnvP8_jobjectP8_jstringS4_` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x134038` | `_Z20E270F21E499946b6B8D8P7_JNIEnvP8_jobjectP8_jstringS4_` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x7360` | `IiIiiIiIiI` | `0x16ff00` | `iIIIIIIiIi+0x22974` | `calloc` |
| `0x1334cc` | `_Z20FCC71FC8E7FB4201E0D2P7_JNIEnvP8_jobjecti` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x1334dc` | `_Z20FCC71FC8E7FB4201E0D2P7_JNIEnvP8_jobjecti` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x170a90` | `iIIIIIIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x140a70` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x171238` | `iIIIIIIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x761c` | `iiIIIiIIiI` | `0x1707f0` | `iIIIIIIiIi+0x23264` | `mprotect` |
| `0x133b80` | `_Z20D600B4A6B3FFB3838D77P7_JNIEnvP8_jobjectS2_` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x170cb4` | `iIIIIIIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x170cb4` | `iIIIIIIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x761c` | `iiIIIiIIiI` | `0x1707f0` | `iIIIIIIiIi+0x23264` | `mprotect` |
| `0x170db0` | `iIIIIIIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x170dc4` | `iIIIIIIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x1335dc` | `_Z20FCC71FC8E7FB4201E0D2P7_JNIEnvP8_jobjecti` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x6bb8` | `iiiIIIiIIi` | `0x16ff00` | `iIIIIIIiIi+0x22974` | `calloc` |
| `0x171238` | `iIIIIIIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x6e78` | `iiiIIIiIIi` | `0x1707f0` | `iIIIIIIiIi+0x23264` | `mprotect` |
| `0x6ed0` | `iiiIIIiIIi` | `0x16ff00` | `iIIIIIIiIi+0x22974` | `calloc` |
| `0x71fc` | `IIiIiiIiIi` | `0x1707f0` | `iIIIIIIiIi+0x23264` | `mprotect` |
| `0x6e78` | `iiiIIIiIIi` | `0x1707f0` | `iIIIIIIiIi+0x23264` | `mprotect` |
| `0x8940` | `IiIiiIIIII` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0x1711b8` | `iIIIIIIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x71fc` | `IIiIiiIiIi` | `0x1707f0` | `iIIIIIIiIi+0x23264` | `mprotect` |
| `0x8c1c` | `IIiiiIIIiI` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x8a60` | `IiiIiIIiii` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0x172080` | `iIIIIIIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x8c38` | `IIiiiIIIiI` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x8c48` | `IIiiiIIIiI` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x8af8` | `IIiiiIIIiI` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0x8c38` | `IIiiiIIIiI` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x8c48` | `IIiiiIIIiI` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x89f8` | `IiiIiIIiii` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0xc299c` | `SoLibraryStart` | `0x1708c0` | `iIIIIIIiIi+0x23334` | `__stack_chk_fail` |
| `0xc29a8` | `SoLibraryStart` | `0xc2150` | `SoLibraryStart+0x13ec` | `-` |
| `0xc29b0` | `SoLibraryStart` | `0x1d4b0` | `IIiIIiIiiI+0xef34` | `-` |
| `0x8ae8` | `IIiiiIIIiI` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0x1720cc` | `iIIIIIIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xc29a8` | `SoLibraryStart` | `0xc2150` | `SoLibraryStart+0x13ec` | `-` |
| `0xc29b0` | `SoLibraryStart` | `0x1d4b0` | `IIiIIiIiiI+0xef34` | `-` |
| `0xc2768` | `SoLibraryStart` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0xc2774` | `SoLibraryStart` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0xc2780` | `SoLibraryStart` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0xc278c` | `SoLibraryStart` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0xc280c` | `SoLibraryStart` | `0x1708c0` | `iIIIIIIiIi+0x23334` | `__stack_chk_fail` |
| `0xa820` | `iiIIIiiIIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xa83c` | `iiIIIiiIIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xa84c` | `iiIIIiiIIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xa83c` | `iiIIIiiIIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xa84c` | `iiIIIiiIIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x9304` | `iIIiiIIIiI` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x9320` | `iIIiiIIIiI` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x9330` | `iIIiiIIIiI` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xaa10` | `IIiIiIIiii` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x9320` | `iIIiiIIIiI` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0x9330` | `iIIiiIIIiI` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xac94` | `IIIiiIIIii` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xa9b0` | `iIIiiIIiII` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xad3c` | `IIIiiIIIii` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xabd0` | `IiIiIiIIIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xae30` | `iiIiiiIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xadc4` | `IIIiiIIIii` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xadd4` | `iiIiiiIiIi` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xb864` | `iiiIiiIiii` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0xad6c` | `IIIiiIIIii` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | `memset` |
| `0xb914` | `iiiIiiIiii` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0xb988` | `iIIIIiiiIi` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |
| `0xb978` | `iiiIiiIiii` | `0xc2810` | `SoLibraryStart+0x1aac` | `-` |

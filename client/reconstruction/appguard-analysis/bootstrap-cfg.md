# AppGuard bootstrap CFG

- sample: `8880c415e1ab82c31858be68ce12b76b95dc8ff8875b76c1246a8bc0679647bc`
- `DT_INIT`: `0x6a70`
- ELF entry: `0x8bb00`
- recursively visited blocks: **1616**
- recursively visited instructions: **10598**

## Roots

| Address | Names | Blocks | Calls | Protected-slot refs | UDF |
|---:|---|---:|---:|---:|---:|
| `0x6a70` | `DT_INIT` | 1245 | 173 | 0 | 1 |
| `0x8bb00` | `e_entry` | 9 | 0 | 0 | 0 |
| `0x133014` | `_Z22EC8A3DFF8EAB09E43C9550P7_JNIEnvP8_jobjectS2_P8_jstringS4_S2_ii` | 164 | 160 | 0 | 0 |
| `0x13331c` | `_Z20BC8A2DFF87BFA43A9229P7_JNIEnvP8_jobject` | 1 | 0 | 0 | 0 |
| `0x133324` | `_Z20BC14D76AD6134b7f978FP7_JNIEnvP8_jobject` | 1 | 0 | 0 | 0 |
| `0x13332c` | `_Z20C0FF06C15AA64461A498P7_JNIEnvP8_jobjectP11_jbyteArray` | 1 | 0 | 0 | 0 |
| `0x13340c` | `_Z20FCC71FC8E7FB4201E0D3P7_JNIEnvP8_jobjectiii` | 6 | 3 | 0 | 0 |
| `0x133490` | `_Z20FCC71FC8E7FB4201E0D2P7_JNIEnvP8_jobjecti` | 32 | 21 | 0 | 1 |
| `0x133674` | `_Z20FBC71FC8E7EB4001A0A5P7_JNIEnvP8_jobjecti` | 9 | 35 | 0 | 0 |
| `0x133888` | `_Z20A44BAF7AF07D564F8D42P7_JNIEnvP8_jobjectxx` | 1 | 0 | 0 | 0 |
| `0x1338e4` | `_Z20CD898AC19EEF3BD64A91P7_JNIEnvP8_jobjectS2_` | 8 | 7 | 0 | 0 |
| `0x133b44` | `_Z20D600B4A6B3FFB3838D77P7_JNIEnvP8_jobjectS2_` | 1 | 1 | 0 | 0 |
| `0x133ff0` | `_Z20E270F21E499946b6B8D8P7_JNIEnvP8_jobjectP8_jstringS4_` | 1 | 4 | 0 | 0 |
| `0x1341dc` | `_Z20E2677089956559C316EDP7_JNIEnvP8_jobject` | 97 | 165 | 0 | 0 |
| `0x1353bc` | `_Z20C05D737DE84A0EEB28DFP7_JNIEnvP8_jobjecti` | 14 | 5 | 0 | 0 |
| `0x13638c` | `_Z20A42F768C6DBA3BFE53B7P7_JNIEnvP8_jobject` | 4 | 2 | 0 | 1 |
| `0x1363ac` | `_Z20KM4PI0Z7J8QMILO5G6P6P7_JNIEnvP8_jobject` | 2 | 0 | 0 | 0 |
| `0x1363b0` | `_Z20PM4PU0Z6J8QMILO5G6P6P7_JNIEnvP8_jobject` | 14 | 3 | 0 | 0 |
| `0x1363b8` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_` | 6 | 7 | 0 | 0 |

## Direct calls into encrypted `asm_*` slot region

No direct bootstrap call into the encrypted wrapper slots was recovered; access may be indirect or the slot-decryptor may populate function pointers first.

## Statically resolved reads/writes touching protected wrapper slots

No direct ADRP/ADR-derived protected-slot memory access was resolved. The bootstrap may compute destinations indirectly or via tables.

## First-level calls from each root

### `DT_INIT` @ `0x6a70`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x7360` | `0x16ff00` | `iIIIIIIiIi+0x22974` | 0 |
| `0x761c` | `0x1707f0` | `iIIIIIIiIi+0x23264` | 0 |
| `0x764c` | `0x16ffa0` | `iIIIIIIiIi+0x22a14` | 0 |
| `0x72c4` | `0x170740` | `iIIIIIIiIi+0x231b4` | 0 |
| `0x7688` | `0x171c1c` | `iIIIIIIiIi+0x24690` | 0 |
| `0x76dc` | `0x171c28` | `iIIIIIIiIi+0x2469c` | 0 |
| `0x761c` | `0x1707f0` | `iIIIIIIiIi+0x23264` | 0 |
| `0x764c` | `0x16ffa0` | `iIIIIIIiIi+0x22a14` | 0 |
| `0x6bb8` | `0x16ff00` | `iIIIIIIiIi+0x22974` | 0 |
| `0x6e78` | `0x1707f0` | `iIIIIIIiIi+0x23264` | 0 |
| `0x6ea8` | `0x16ffa0` | `iIIIIIIiIi+0x22a14` | 0 |
| `0x7d74` | `0x173b0c` | `iIIIIIIiIi+0x26580` | 0 |
| `0x6b64` | `0x170740` | `iIIIIIIiIi+0x231b4` | 0 |
| `0x6ebc` | `0x171c1c` | `iIIIIIIiIi+0x24690` | 0 |
| `0x6ed0` | `0x16ff00` | `iIIIIIIiIi+0x22974` | 0 |
| `0x71fc` | `0x1707f0` | `iIIIIIIiIi+0x23264` | 0 |
| `0x722c` | `0x16ffa0` | `iIIIIIIiIi+0x22a14` | 0 |
| `0x6e78` | `0x1707f0` | `iIIIIIIiIi+0x23264` | 0 |
| `0x6ea8` | `0x16ffa0` | `iIIIIIIiIi+0x22a14` | 0 |
| `0x8940` | `0xc2810` | `SoLibraryStart+0x1aac` | 0 |
| `0x6b98` | `0x170740` | `iIIIIIIiIi+0x231b4` | 0 |
| `0x7240` | `0x171c1c` | `iIIIIIIiIi+0x24690` | 0 |
| `0x8b78` | `0x15ab90` | `iIIIIIIiIi+0xd604` | 0 |
| `0x71fc` | `0x1707f0` | `iIIIIIIiIi+0x23264` | 0 |
| `0x722c` | `0x16ffa0` | `iIIIIIIiIi+0x22a14` | 0 |
| `0x173ddc` | `0x173188` | `iIIIIIIiIi+0x25bfc` | 1 |
| `0x15abc4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x15abd0` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x8c1c` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x8a60` | `0xc2810` | `SoLibraryStart+0x1aac` | 0 |
| `0x172080` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 1 |
| `0x173ff8` | `0x173188` | `iIIIIIIiIi+0x25bfc` | 1 |
| `0x173bb4` | `0x172c20` | `iIIIIIIiIi+0x25694` | 1 |
| `0x15ac08` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x15ac20` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x15ac2c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x8c64` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x8c38` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x8c48` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x8af8` | `0xc2810` | `SoLibraryStart+0x1aac` | 0 |
| `0x173ff8` | `0x173188` | `iIIIIIIiIi+0x25bfc` | 1 |
| `0x15ac60` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x15ac78` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x15ac84` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x8c38` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x8c48` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x89f8` | `0xc2810` | `SoLibraryStart+0x1aac` | 0 |
| `0x173ddc` | `0x173188` | `iIIIIIIiIi+0x25bfc` | 1 |
| `0xc299c` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0xc29a8` | `0xc2150` | `SoLibraryStart+0x13ec` | 1 |
| `0xc29b0` | `0x1d4b0` | `IIiIIiIiiI+0xef34` | 1 |
| `0x15acb0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x15acc8` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x15acd4` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x8ae8` | `0xc2810` | `SoLibraryStart+0x1aac` | 0 |
| `0x1720cc` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 1 |
| `0x173bb4` | `0x172c20` | `iIIIIIIiIi+0x25694` | 1 |
| `0xc29a8` | `0xc2150` | `SoLibraryStart+0x13ec` | 1 |
| `0xc29b0` | `0x1d4b0` | `IIiIIiIiiI+0xef34` | 1 |
| `0x15ad00` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x15ad18` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x15ad24` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x8f38` | `0x17124c` | `iIIIIIIiIi+0x23cc0` | 0 |
| `0x15ad50` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x15ad68` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x15ad74` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x15ada0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x15adb4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x15adbc` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x15ade4` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x15adf8` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x15ae00` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x9018` | `0x16fd80` | `iIIIIIIiIi+0x227f4` | 0 |
| `0x15ae28` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x15ae3c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x15ae44` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x9078` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x15ae6c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x15ae80` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x15ae88` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x15aeb0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x90d0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x90d8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x15aedc` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0xa820` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x15af6c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x15af74` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x15af88` | `0x1d208` | `IIiIIiIiiI+0xec8c` | 1 |
| `0x15afac` | `0x1cdf4` | `IIiIIiIiiI+0xe878` | 1 |
| `0x15afbc` | `0x1d23c` | `IIiIIiIiiI+0xecc0` | 1 |
| `0xa868` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0xa83c` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0xa84c` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x15afbc` | `0x1d23c` | `IIiIIiIiiI+0xecc0` | 1 |
| `0xa8bc` | `0x17124c` | `iIIIIIIiIi+0x23cc0` | 0 |
| `0xa83c` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0xa84c` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0xa91c` | `0x16fd80` | `iIIIIIIiIi+0x227f4` | 0 |
| `0xa928` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x9304` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x9358` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x9320` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x9330` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0xaa10` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x93ac` | `0x17124c` | `iIIIIIIiIi+0x23cc0` | 0 |
| `0x9320` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x9330` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0xae9c` | `0x171c1c` | `iIIIIIIiIi+0x24690` | 0 |
| `0x9400` | `0x16fd80` | `iIIIIIIiIi+0x227f4` | 0 |
| `0xac94` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x9468` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xb09c` | `0x171c28` | `iIIIIIIiIi+0x2469c` | 0 |
| `0xa9b0` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0xad3c` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x9608` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x9510` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xabd0` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x9668` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x9578` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x956c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xae30` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0xb7bc` | `0x173b0c` | `iIIIIIIiIi+0x26580` | 0 |
| `0xadc4` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0xadd4` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x9730` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xb864` | `0xc2810` | `SoLibraryStart+0x1aac` | 0 |
| `0xad6c` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x994c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x97d4` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x9730` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xb914` | `0xc2810` | `SoLibraryStart+0x1aac` | 0 |
| `0x9a14` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x99b8` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x982c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x9820` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xb988` | `0xc2810` | `SoLibraryStart+0x1aac` | 0 |
| `0xb978` | `0xc2810` | `SoLibraryStart+0x1aac` | 0 |
| `0x9b08` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x9b70` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x9b78` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x9fd0` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x9c14` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x9b08` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x9d64` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x9cf4` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x9b70` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x9b78` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xa068` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xa180` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x9e08` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xa040` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x9de0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xa308` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xa374` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xa37c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xa420` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0xa308` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xa474` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0xa374` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xa37c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |

### `e_entry` @ `0x8bb00`

No direct BL calls recovered.

### `_Z22EC8A3DFF8EAB09E43C9550P7_JNIEnvP8_jobjectS2_P8_jstringS4_S2_ii` @ `0x133014`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x133060` | `0x149c3c` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0x13884` | 0 |
| `0x133068` | `0x149fd0` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0x13c18` | 0 |
| `0x133078` | `0x145274` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xeebc` | 0 |
| `0x133080` | `0x145c50` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xf898` | 0 |
| `0x133090` | `0x143280` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xcec8` | 0 |
| `0x133098` | `0x144634` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xe27c` | 0 |
| `0x149c60` | `0x1408b8` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa500` | 1 |
| `0x149c84` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x149c8c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x149ca0` | `0x140a10` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa658` | 1 |
| `0x149ca8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a004` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x14a00c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x14a024` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x14a02c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x14a03c` | `0x141240` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xae88` | 1 |
| `0x14a048` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a050` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145298` | `0x1408b8` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa500` | 1 |
| `0x1452bc` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x1452c4` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x1452dc` | `0x140a10` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa658` | 1 |
| `0x1452e4` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145c84` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x145c8c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x145ca4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x145cac` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x145cbc` | `0x141240` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xae88` | 1 |
| `0x145cc8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145cd0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x1432ac` | `0x1408b8` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa500` | 1 |
| `0x1432d0` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x1432d8` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x1432f0` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x1432f8` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x143310` | `0x140a10` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa658` | 1 |
| `0x143318` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x143320` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x149cd4` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x14a080` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x14a08c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145310` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x145d00` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x145d0c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x149cf0` | `0x1408d4` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa51c` | 1 |
| `0x149cf8` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x14a09c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a0a4` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x14a0dc` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x14a0e4` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x14a0fc` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x14a104` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x14a114` | `0x141240` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xae88` | 1 |
| `0x14a120` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a128` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14532c` | `0x1408d4` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa51c` | 1 |
| `0x145334` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x145364` | `0x1408b8` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa500` | 1 |
| `0x145388` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x145390` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x1453a8` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x1453b0` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x1453c8` | `0x140a10` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa658` | 1 |
| `0x1453d0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x1453d8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145d1c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145d24` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x145d5c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x145d64` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x145d7c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x145d84` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x145d94` | `0x141e10` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xba58` | 1 |
| `0x145da0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145da8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a158` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x14a164` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145404` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x145dd8` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x145de4` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a174` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a17c` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x14a1b4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x14a1bc` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x14a1d4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x14a1dc` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x14a1ec` | `0x141240` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xae88` | 1 |
| `0x14a1f8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a200` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145430` | `0x1408d4` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa51c` | 1 |
| `0x145438` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x145480` | `0x1408b8` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa500` | 1 |
| `0x145df4` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145dfc` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x145e30` | `0x1408b8` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa500` | 1 |
| `0x145e54` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x145e5c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x145e74` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x145e7c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x145e88` | `0x1429a0` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xc5e8` | 1 |
| `0x145ea0` | `0x140a10` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa658` | 1 |
| `0x145ea8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145eb0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a230` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x14a23c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145ee0` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x14a24c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a254` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x14a294` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x14a29c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x14a2b4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x14a2bc` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x14a2c8` | `0x1429a0` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xc5e8` | 1 |
| `0x14a2dc` | `0x141240` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xae88` | 1 |
| `0x14a2e8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a2f0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x145f0c` | `0x1408d4` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa51c` | 1 |
| `0x145f14` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x14a324` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x14a340` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a348` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x14a380` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x14a388` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x14a3a0` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x14a3a8` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x14a3b8` | `0x141240` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xae88` | 1 |
| `0x14a3c4` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a3cc` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a3fc` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x14a408` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a418` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a420` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |
| `0x14a448` | `0x1408b8` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa500` | 1 |
| `0x14a46c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 1 |
| `0x14a474` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 1 |
| `0x14a488` | `0x140a10` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa658` | 1 |
| `0x14a490` | `0x171224` | `iIIIIIIiIi+0x23c98` | 1 |
| `0x14a4bc` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 1 |
| `0x14a4d8` | `0x1408d4` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xa51c` | 1 |
| `0x14a4e0` | `0x170680` | `iIIIIIIiIi+0x230f4` | 1 |

### `_Z20BC8A2DFF87BFA43A9229P7_JNIEnvP8_jobject` @ `0x13331c`

No direct BL calls recovered.

### `_Z20BC14D76AD6134b7f978FP7_JNIEnvP8_jobject` @ `0x133324`

No direct BL calls recovered.

### `_Z20C0FF06C15AA64461A498P7_JNIEnvP8_jobjectP11_jbyteArray` @ `0x13332c`

No direct BL calls recovered.

### `_Z20FCC71FC8E7FB4201E0D3P7_JNIEnvP8_jobjectiii` @ `0x13340c`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x13344c` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x133460` | `0x1cdf4` | `IIiIIiIiiI+0xe878` | 0 |
| `0x13348c` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 0 |

### `_Z20FCC71FC8E7FB4201E0D2P7_JNIEnvP8_jobjecti` @ `0x133490`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x1334cc` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x1334dc` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x1334f0` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x1334f8` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x133504` | `0x1d000` | `IIiIIiIiiI+0xea84` | 0 |
| `0x133510` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x133524` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x13352c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x133558` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x133568` | `0x1d01c` | `IIiIIiIiiI+0xeaa0` | 0 |
| `0x133650` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 0 |
| `0x133618` | `0x1d0c4` | `IIiIIiIiiI+0xeb48` | 0 |
| `0x133668` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x133670` | `0x170680` | `iIIIIIIiIi+0x230f4` | 0 |
| `0x1336b0` | `0x1cdf4` | `IIiIIiIiiI+0xe878` | 0 |
| `0x1336c0` | `0x1cdf4` | `IIiIIiIiiI+0xe878` | 0 |
| `0x1336d0` | `0x1cdf4` | `IIiIIiIiiI+0xe878` | 0 |
| `0x1336e4` | `0x1cd84` | `IIiIIiIiiI+0xe808` | 0 |
| `0x133618` | `0x1d0c4` | `IIiIIiIiiI+0xeb48` | 0 |
| `0x1335dc` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x1335ec` | `0x1d01c` | `IIiIIiIiiI+0xeaa0` | 0 |

### `_Z20FBC71FC8E7EB4001A0A5P7_JNIEnvP8_jobjecti` @ `0x133674`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x1336b0` | `0x1cdf4` | `IIiIIiIiiI+0xe878` | 0 |
| `0x1336c0` | `0x1cdf4` | `IIiIIiIiiI+0xe878` | 0 |
| `0x1336d0` | `0x1cdf4` | `IIiIIiIiiI+0xe878` | 0 |
| `0x1336e4` | `0x1cd84` | `IIiIIiIiiI+0xe808` | 0 |
| `0x1337c4` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x1337d4` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x1337dc` | `0x1cd4c` | `IIiIIiIiiI+0xe7d0` | 0 |
| `0x1337e8` | `0x1cd84` | `IIiIIiIiiI+0xe808` | 0 |
| `0x1337f4` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x1337fc` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x133804` | `0x1cd4c` | `IIiIIiIiiI+0xe7d0` | 0 |
| `0x133810` | `0x1cd84` | `IIiIIiIiiI+0xe808` | 0 |
| `0x13381c` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x133824` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x13382c` | `0x1cd4c` | `IIiIIiIiiI+0xe7d0` | 0 |
| `0x133838` | `0x1cd84` | `IIiIIiIiiI+0xe808` | 0 |
| `0x133844` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x13384c` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x133854` | `0x1cd4c` | `IIiIIiIiiI+0xe7d0` | 0 |
| `0x133708` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x133718` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x133720` | `0x1cd4c` | `IIiIIiIiiI+0xe7d0` | 0 |
| `0x13372c` | `0x1cd84` | `IIiIIiIiiI+0xe808` | 0 |
| `0x133738` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x133740` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x133748` | `0x1cd4c` | `IIiIIiIiiI+0xe7d0` | 0 |
| `0x133754` | `0x1cd84` | `IIiIIiIiiI+0xe808` | 0 |
| `0x133760` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x133768` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x133770` | `0x1cd4c` | `IIiIIiIiiI+0xe7d0` | 0 |
| `0x13377c` | `0x1cd84` | `IIiIIiIiiI+0xe808` | 0 |
| `0x133788` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x133790` | `0x1d14c` | `IIiIIiIiiI+0xebd0` | 0 |
| `0x133798` | `0x1cd4c` | `IIiIIiIiiI+0xe7d0` | 0 |
| `0x133884` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 0 |

### `_Z20A44BAF7AF07D564F8D42P7_JNIEnvP8_jobjectxx` @ `0x133888`

No direct BL calls recovered.

### `_Z20CD898AC19EEF3BD64A91P7_JNIEnvP8_jobjectS2_` @ `0x1338e4`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x133af8` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 0 |
| `0x133b04` | `0x16fd00` | `iIIIIIIiIi+0x22774` | 0 |
| `0x133b0c` | `0x170680` | `iIIIIIIiIi+0x230f4` | 0 |
| `0x133b18` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x133b38` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x133b40` | `0x170680` | `iIIIIIIiIi+0x230f4` | 0 |
| `0x133b80` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |

### `_Z20D600B4A6B3FFB3838D77P7_JNIEnvP8_jobjectS2_` @ `0x133b44`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x133b80` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |

### `_Z20E270F21E499946b6B8D8P7_JNIEnvP8_jobjectP8_jstringS4_` @ `0x133ff0`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x134028` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x134038` | `0x1704e0` | `iIIIIIIiIi+0x22f54` | 0 |
| `0x134048` | `0x143280` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xcec8` | 0 |
| `0x134050` | `0x144634` | `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_+0xe27c` | 0 |

### `_Z20E2677089956559C316EDP7_JNIEnvP8_jobject` @ `0x1341dc`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x134230` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x13423c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134258` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134264` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134280` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x13428c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x13429c` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x1342ac` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1342b8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1342c4` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1342dc` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x1342e8` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134304` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134310` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x13432c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134338` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134348` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x134358` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134364` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134370` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x13503c` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 0 |
| `0x135048` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x135058` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134420` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x13442c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134448` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134454` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134470` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x13447c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x13448c` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x13449c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1344a8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1344b4` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1344cc` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x1344d8` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x1344f4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134500` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x13451c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134528` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134538` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x134548` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134554` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134560` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1353b0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1353b8` | `0x170680` | `iIIIIIIiIi+0x230f4` | 0 |
| `0x1345dc` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x1345e8` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134604` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134610` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x13462c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134638` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134648` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x134658` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134664` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134670` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1346b8` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x1346c4` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x1346e0` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x1346ec` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134708` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134714` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134724` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x134734` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134740` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x13474c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134764` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134770` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x13478c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134798` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x1347b4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x1347c0` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x1347d0` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x1347e0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1347ec` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1347f8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134874` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134880` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x13489c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x1348a8` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x1348c4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x1348d0` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x1348e0` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x1348f0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1348fc` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134908` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134920` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x13492c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134948` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134954` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134970` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x13497c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x13498c` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x13499c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1349a8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1349b4` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x1349cc` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x1349d8` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x1349f4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134a00` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134a1c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134a28` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134a38` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x134a48` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134a54` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134a60` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134b10` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134b1c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134b38` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134b44` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134b60` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134b6c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134b7c` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x134b8c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134b98` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134ba4` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134bbc` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134bc8` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134be4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134bf0` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134c0c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134c18` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134c28` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x134c38` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134c44` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134c50` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134c68` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134c74` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134c90` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134c9c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134cb8` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134cc4` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134cd4` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x134ce4` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134cf0` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134cfc` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134d14` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134d20` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134d3c` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134d48` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134d64` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134d70` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134d80` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x134d90` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134d9c` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134da8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134e88` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134e94` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134eb0` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134ebc` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134ed4` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134edc` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134eec` | `0x1df50` | `IIiIIiIiiI+0xf9d4` | 0 |
| `0x134ef8` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134f04` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134f10` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x134f24` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134f2c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134f44` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |
| `0x134f4c` | `0x171244` | `iIIIIIIiIi+0x23cb8` | 0 |
| `0x134f64` | `0x170a40` | `iIIIIIIiIi+0x234b4` | 0 |

### `_Z20C05D737DE84A0EEB28DFP7_JNIEnvP8_jobjecti` @ `0x1353bc`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x1360d0` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 0 |
| `0x136380` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0x136388` | `0x170680` | `iIIIIIIiIi+0x230f4` | 0 |
| `0x136394` | `0x1ce78` | `IIiIIiIiiI+0xe8fc` | 0 |
| `0x13639c` | `0x1ce90` | `IIiIIiIiiI+0xe914` | 0 |

### `_Z20A42F768C6DBA3BFE53B7P7_JNIEnvP8_jobject` @ `0x13638c`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x136394` | `0x1ce78` | `IIiIIiIiiI+0xe8fc` | 0 |
| `0x13639c` | `0x1ce90` | `IIiIIiIiiI+0xe914` | 0 |

### `_Z20KM4PI0Z7J8QMILO5G6P6P7_JNIEnvP8_jobject` @ `0x1363ac`

No direct BL calls recovered.

### `_Z20PM4PU0Z6J8QMILO5G6P6P7_JNIEnvP8_jobject` @ `0x1363b0`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0xa79dc` | `0x1708c0` | `iIIIIIIiIi+0x23334` | 0 |
| `0xa7acc` | `0x171224` | `iIIIIIIiIi+0x23c98` | 0 |
| `0xa7ad4` | `0x170680` | `iIIIIIIiIi+0x230f4` | 0 |

### `_Z20CBA0D5AB921D12FEF3A2P7_JNIEnvP8_jobjectS2_` @ `0x1363b8`

| Callsite | Target | Symbol/nearest | Depth |
|---:|---:|---|---:|
| `0x1363f8` | `0x1cd84` | `IIiIIiIiiI+0xe808` | 0 |
| `0x136428` | `0x1cd4c` | `IIiIIiIiiI+0xe7d0` | 0 |
| `0x136434` | `0x3f3c8` | `IIiIIiIiiI+0x30e4c` | 0 |
| `0x136410` | `0x170800` | `iIIIIIIiIi+0x23274` | 0 |
| `0x136418` | `0x369a4` | `IIiIIiIiiI+0x28428` | 0 |
| `0x136428` | `0x1cd4c` | `IIiIIiIiiI+0xe7d0` | 0 |
| `0x136434` | `0x3f3c8` | `IIiIIiIiiI+0x30e4c` | 0 |


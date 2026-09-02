# AppGuard runtime dispatch-table resolution

- sample: `8880c415e1ab82c31858be68ce12b76b95dc8ff8875b76c1246a8bc0679647bc`
- dynamic relocations recovered: **3105**
- SoLibraryStart global accesses: **16**
- indirect load/call chains: **13**

## Relocation types

| Type | Count |
|---|---:|
| `R_AARCH64_ABS64` | 281 |
| `R_AARCH64_GLOB_DAT` | 119 |
| `R_AARCH64_JUMP_SLOT` | 230 |
| `R_AARCH64_RELATIVE` | 2475 |

## Global slots used by `SoLibraryStart`

| Slot | File off | Raw | Relocation | Resolved |
|---:|---:|---:|---|---|
| `0x1e5658` | `0x1d5658` | `0x1e8378` | R_AARCH64_RELATIVE:- add=0x1e8378 | 0x1e8378 _ZN10__cxxabiv119__terminate_handlerE+0x70 |
| `0x1e56b0` | `0x1d56b0` | `0x1eb7e0` | R_AARCH64_RELATIVE:- add=0x1eb7e0 | 0x1eb7e0 __bss_start__+0x3308 |
| `0x1e56f8` | `0x1d56f8` | `0x1e95f9` | R_AARCH64_RELATIVE:- add=0x1e95f9 | 0x1e95f9 __bss_start__+0x1121 |
| `0x1e57a8` | `0x1d57a8` | `0x1ebac0` | R_AARCH64_RELATIVE:- add=0x1ebac0 | 0x1ebac0 __bss_start__+0x35e8 |
| `0x1e5b28` | `0x1d5b28` | `0x1e9c30` | R_AARCH64_RELATIVE:- add=0x1e9c30 | 0x1e9c30 __bss_start__+0x1758 |
| `0x1e5c68` | `0x1d5c68` | `0x1e9ba8` | R_AARCH64_RELATIVE:- add=0x1e9ba8 | 0x1e9ba8 __bss_start__+0x16d0 |
| `0x1e5cf0` | `0x1d5cf0` | `0x1eb858` | R_AARCH64_RELATIVE:- add=0x1eb858 | 0x1eb858 __bss_start__+0x3380 |
| `0x1e5d38` | `0x1d5d38` | `0x0` | R_AARCH64_GLOB_DAT:asmFunction add=0x0 | 0x1eceb8 asmFunction |
| `0x1e60c0` | `0x1d60c0` | `0x1e9c58` | R_AARCH64_RELATIVE:- add=0x1e9c58 | 0x1e9c58 __bss_start__+0x1780 |

## Indirect chains

| Insn | Global slot | Field | BLR | Static target(s) |
|---:|---:|---:|---|---|
| `0xc0d84` | `0x1e5cf0` | `+0x0` | no | - |
| `0xc0d88` | `0x1e5cf0` | `+0x0` | yes | - |
| `0xc0dd8` | `0x1e60c0` | `+0x0` | no | - |
| `0xc0df4` | `0x1e5c68` | `+0x0` | no | - |
| `0xc0e18` | `0x1e5d38` | `+0xa0` | no | - |
| `0xc0e34` | `0x1e5d38` | `+0xa0` | yes | - |
| `0xc1630` | `0x1e56b0` | `+0x0` | no | - |
| `0xc16f0` | `0x1e60c0` | `+0x0` | no | - |
| `0xc1714` | `0x1e5c68` | `+0x0` | no | - |
| `0xc1738` | `0x1e5d38` | `+0xa0` | no | - |
| `0xc1754` | `0x1e5d38` | `+0xa0` | yes | - |
| `0xc1dbc` | `0x1e57a8` | `+0x0` | no | - |
| `0xc1dc0` | `0x1e57a8` | `+0x158` | no | - |

## Recovered static objects

### global `0x1e5658` -> object `0x1e8378`

| Field | VA | Raw | Relocation | Resolved |
|---:|---:|---:|---|---|
| `+0x80` | `0x1e83f8` | `0x0` | - | - |
| `+0x88` | `0x1e8400` | `0x0` | - | - |
| `+0x90` | `0x1e8408` | `0x0` | - | - |
| `+0x98` | `0x1e8410` | `0x0` | - | - |
| `+0xa0` | `0x1e8418` | `0x0` | - | - |
| `+0xa8` | `0x1e8420` | `0x0` | - | - |
| `+0xb0` | `0x1e8428` | `0x0` | - | - |
| `+0xb8` | `0x1e8430` | `0x0` | - | - |
| `+0xc0` | `0x1e8438` | `0x0` | - | - |


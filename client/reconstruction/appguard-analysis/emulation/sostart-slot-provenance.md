# SoLibraryStart null-slot provenance

- run stop: `instruction limit 30000000`
- instructions: **30000001**
- pointer cell: `+0x1e5cf0`
- target slot: `+0x1eb858`

## ELF relocations near the cells

- `+0x1e5cc0` type=1027 addend=`0x1e4e40` symbol=`` value=`0x0`
- `+0x1e5cc8` type=1027 addend=`0x2881c` symbol=`` value=`0x0`
- `+0x1e5cd8` type=1027 addend=`0x37a08` symbol=`` value=`0x0`
- `+0x1e5ce0` type=1027 addend=`0x1e9b20` symbol=`` value=`0x0`
- `+0x1e5ce8` type=1027 addend=`0x1e4be0` symbol=`` value=`0x0`
- `+0x1e5cf0` type=1027 addend=`0x1eb858` symbol=`` value=`0x0`
- `+0x1e5cf8` type=1027 addend=`0x1e96f9` symbol=`` value=`0x0`
- `+0x1e5d00` type=1027 addend=`0x1e81f8` symbol=`` value=`0x0`
- `+0x1e5d08` type=1027 addend=`0x20d4f8` symbol=`` value=`0x0`
- `+0x1e5d10` type=1027 addend=`0xf143c` symbol=`` value=`0x0`
- `+0x1e5d18` type=1027 addend=`0x1eb838` symbol=`` value=`0x0`
- `+0x1e5d20` type=1027 addend=`0x3f6b8` symbol=`` value=`0x0`
- `+0x1e5cb8` type=1025 addend=`0x0` symbol=`iiIiiIiiIi` value=`0x6a70`
- `+0x1e5cd0` type=1025 addend=`0x0` symbol=`y.44` value=`0x20edbc`
- `+0x1e5d28` type=1025 addend=`0x0` symbol=`_ZNSt15__exception_ptr13exception_ptr18_M_safe_bool_dummyEv` value=`0x111030`

## Runtime slot checkpoints

| checkpoint | instruction | PC | [ptr cell] | [target slot] |
|---|---:|---:|---:|---:|
| `after-relocations` | 0 | `0x-10000000` | `0x101eb858` | `0x0` |
| `insn-2000000` | 2000000 | `0xc66c` | `0x101eb858` | `0x0` |
| `insn-4000000` | 4000000 | `0xf33c` | `0x101eb858` | `0x0` |
| `insn-8000000` | 8000000 | `0xfe14` | `0x101eb858` | `0x0` |
| `insn-12000000` | 12000000 | `0xfb18` | `0x101eb858` | `0x0` |
| `insn-20000000` | 20000000 | `0xfdac` | `0x101eb858` | `0x0` |
| `insn-30000000` | 30000000 | `0x10d20` | `0x101eb858` | `0x0` |
| `final` | 30000001 | `0x10d24` | `0x101eb858` | `0x0` |

## Writes to target slot

- none

## Writes to pointer cell

- none

## Decrypted-code xrefs near the cells

| PC | instruction | resolved address |
|---:|---|---:|
| - | - | - |

## Nearest dynamic symbols

- pointer cell: `{'name': '', 'value': 1989872, 'size': 1027, 'offset': 0, 'type': 0}`
- target slot: `{'name': '__bss_start__', 'value': 2000088, 'size': 0, 'offset': 13184, 'type': 0}`


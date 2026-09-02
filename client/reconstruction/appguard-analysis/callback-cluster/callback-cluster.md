# AppGuard callback BSS cluster

- cluster: `+0x1eb800..+0x1eb900`
- RELATIVE pointer cells into cluster: **12**
- runtime writes observed: **1**

## Pointer cells -> cluster slots

| pointer cell | slot | relocation type |
|---:|---:|---:|
| `+0x1e5700` | `+0x1eb800` | 1027 |
| `+0x1e57e8` | `+0x1eb830` | 1027 |
| `+0x1e5880` | `+0x1eb828` | 1027 |
| `+0x1e5938` | `+0x1eb848` | 1027 |
| `+0x1e5968` | `+0x1eb840` | 1027 |
| `+0x1e5b60` | `+0x1eb870` | 1027 |
| `+0x1e5cf0` | `+0x1eb858` | 1027 |
| `+0x1e5d18` | `+0x1eb838` | 1027 |
| `+0x1e5d60` | `+0x1eb868` | 1027 |
| `+0x1e5fb0` | `+0x1eb860` | 1027 |
| `+0x1e6030` | `+0x1eb820` | 1027 |
| `+0x1e6058` | `+0x1eb850` | 1027 |

## Static xrefs after proven decryption

| PC | instruction | resolved address |
|---:|---|---:|
| `+0x7668` | `ldr x21, [x21, #0x7e8]` | `+0x1e57e8` |
| `+0x1c838` | `ldr x20, [x20, #0x880]` | `+0x1e5880` |
| `+0x1cae8` | `ldr x9, [x9, #0xd18]` | `+0x1e5d18` |
| `+0x283b0` | `ldr x10, [x10, #0x30]` | `+0x1e6030` |
| `+0x2f2b4` | `ldr x8, [x8, #0x30]` | `+0x1e6030` |
| `+0x309ac` | `ldr x8, [x8, #0x30]` | `+0x1e6030` |
| `+0x313cc` | `ldr x8, [x8, #0x30]` | `+0x1e6030` |
| `+0x313f0` | `ldr x9, [x9, #0x700]` | `+0x1e5700` |
| `+0x325d4` | `ldr x8, [x8, #0x30]` | `+0x1e6030` |
| `+0x39ea8` | `ldr x8, [x8, #0x30]` | `+0x1e6030` |
| `+0x3ab74` | `ldr x8, [x8, #0x30]` | `+0x1e6030` |
| `+0x510fc` | `ldr x8, [x8, #0xd60]` | `+0x1e5d60` |
| `+0x90ba0` | `ldr w8, [x8, #0x890]` | `+0x1eb890` |
| `+0x90e14` | `ldr w9, [x9, #0x890]` | `+0x1eb890` |
| `+0x90f7c` | `ldr w12, [x12, #0x890]` | `+0x1eb890` |
| `+0x91020` | `str w0, [x8, #0x890]` | `+0x1eb890` |
| `+0x91054` | `ldr w8, [x8, #0x890]` | `+0x1eb890` |
| `+0x912c0` | `ldr w8, [x8, #0x890]` | `+0x1eb890` |
| `+0xa7c9c` | `str w0, [x10, #0x8b4]` | `+0x1eb8b4` |
| `+0xbc0c4` | `ldr x8, [x8, #0x58]` | `+0x1e6058` |
| `+0xbc0f4` | `ldr x8, [x8, #0x58]` | `+0x1e6058` |
| `+0xbd31c` | `ldr x8, [x8, #0x58]` | `+0x1e6058` |
| `+0xbd34c` | `ldr x8, [x8, #0x58]` | `+0x1e6058` |
| `+0xc0d7c` | `ldr x8, [x8, #0xcf0]` | `+0x1e5cf0` |
| `+0xc2ab4` | `ldr x15, [x15, #0xd18]` | `+0x1e5d18` |
| `+0xc2ab8` | `ldr x16, [x16, #0x968]` | `+0x1e5968` |
| `+0xc2abc` | `ldr x17, [x17, #0x938]` | `+0x1e5938` |
| `+0xc2ac0` | `ldr x18, [x18, #0x58]` | `+0x1e6058` |
| `+0xc2ac4` | `ldr x0, [x0, #0xcf0]` | `+0x1e5cf0` |
| `+0xc2ac8` | `ldr x1, [x1, #0xfb0]` | `+0x1e5fb0` |
| `+0xc2acc` | `ldr x2, [x2, #0xd60]` | `+0x1e5d60` |
| `+0x1323cc` | `ldrb w9, [x8, #0x8b0]` | `+0x1eb8b0` |
| `+0x1323f4` | `strb w9, [x8, #0x8b0]` | `+0x1eb8b0` |
| `+0x13397c` | `ldr x8, [x8, #0xd18]` | `+0x1e5d18` |
| `+0x133b88` | `ldr x8, [x8, #0xd18]` | `+0x1e5d18` |
| `+0x169fbc` | `ldr x5, [x5, #0xb60]` | `+0x1e5b60` |
| `+0x16a334` | `ldr x8, [x8, #0xb60]` | `+0x1e5b60` |
| `+0x16d9e4` | `ldr x8, [x8, #0xb60]` | `+0x1e5b60` |

## Runtime writes

| stage | insn | PC | address | value | size |
|---|---:|---:|---:|---:|---:|
| `bootstrap` | 0 | `+0x7678` | `+0x1eb830` | `0x5100001000` | 8 |

## Snapshot: after-bootstrap

| slot | value |
|---:|---:|
| `+0x1eb830` | `0x5100001000` |

## Snapshot: after-jni-stop

| slot | value |
|---:|---:|
| `+0x1eb830` | `0x5100001000` |

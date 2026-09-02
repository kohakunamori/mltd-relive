# Fallback callback consumption trace

- installer gate result: `0x0`
- JNI stop: `Unicorn error: Invalid memory fetch (UC_ERR_FETCH_UNMAPPED); pc=0x7250`
- small indirect branches observed: **1**

## Callback slots

| slot | value |
|---:|---:|
| `0x1eb838` | `0x7250` |
| `0x1eb840` | `0x3420` |
| `0x1eb848` | `0x2530` |
| `0x1eb850` | `0x1100` |
| `0x1eb858` | `0x4580` |
| `0x1eb860` | `0x7510` |
| `0x1eb868` | `0x7130` |

## Small indirect branches

### #0: `+0x133990` -> `0x7250` via `x8`

```asm
0x133960: 297d43f9 ldr x9, [x9, #0x6f8]
0x133964: 2a696838 ldrb w10, [x9, x8]
0x133968: 08050091 add x8, x8, #1
0x13396c: caffff35 cbnz w10, #0x133964
0x133970: 1f0500f1 cmp x8, #1
0x133974: 01010054 b.ne #0x133994
0x133978: 880500d0 adrp x8, #0x1e5000
0x13397c: 088d46f9 ldr x8, [x8, #0xd18]
0x133980: e2030032 mov w2, #1
0x133984: e00314aa mov x0, x20
0x133988: e10313aa mov x1, x19
0x13398c: 080140f9 ldr x8, [x8]
0x133990: 00013fd6 blr x8  ; <--
0x133994: 210200f0 adrp x1, #0x17a000
0x133998: 21500491 add x1, x1, #0x114
0x13399c: e0c32091 add x0, sp, #0x830
0x1339a0: e2031faa mov x2, xzr
0x1339a4: 27f40094 bl #0x170a40
0x1339a8: e0c32091 add x0, sp, #0x830
0x1339ac: 26f60094 bl #0x171244
```

Registers:
```text
x0=0x5000013870 x1=0x5000013900 x2=0x1 x3=0x7000ff4520 x4=0xaf046eed x5=0xf710afdb x6=0xbcf216a5 x7=0x3414866a x8=0x7250 x9=0x101e95f9 x10=0x0 x11=0x7000ff44f0 x12=0x7000ff4520 x13=0x2e x14=0x0 x15=0x62 x16=0x101e6660 x17=0x60000015a0 x18=0xdccd3c62 x19=0x5000013900 x20=0x5000013870 x21=0x100d37d4 x22=0x100d3660 x23=0x101e9b00 x24=0x5000001634 x25=0x4 x26=0x0 x27=0x51000013fc x28=0x4 x29=0x7000ff9070 x30=0x10133948
```


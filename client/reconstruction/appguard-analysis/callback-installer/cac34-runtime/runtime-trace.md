# Runtime-decrypted `libcompatible+0xcac34` trace

- gate return w0: `0x0`
- gate bit0: **False**
- dynamic call edges: **176**

## Runtime disassembly of top-level predicate

```asm
* 0xcac34: fc0f1df8 str x28, [sp, #-0x30]!
* 0xcac38: f44f01a9 stp x20, x19, [sp, #0x10]
* 0xcac3c: fd7b02a9 stp x29, x30, [sp, #0x20]
* 0xcac40: fd830091 add x29, sp, #0x20
* 0xcac44: ff433dd1 sub sp, sp, #0xf50
* 0xcac48: 48d03bd5 mrs x8, tpidr_el0
* 0xcac4c: 081540f9 ldr x8, [x8, #0x28]
* 0xcac50: e0233991 add x0, sp, #0xe48
* 0xcac54: e2031832 mov w2, #0x100
* 0xcac58: e1031f2a mov w1, wzr
* 0xcac5c: a8831df8 stur x8, [x29, #-0x28]
* 0xcac60: 20960294 bl #0x1704e0
* 0xcac64: e0233591 add x0, sp, #0xd48
* 0xcac68: e2031832 mov w2, #0x100
* 0xcac6c: e1031f2a mov w1, wzr
* 0xcac70: 1c960294 bl #0x1704e0
* 0xcac74: e0233191 add x0, sp, #0xc48
* 0xcac78: e2031832 mov w2, #0x100
* 0xcac7c: e1031f2a mov w1, wzr
* 0xcac80: 18960294 bl #0x1704e0
* 0xcac84: 210600f0 adrp x1, #0x191000
* 0xcac88: 21301991 add x1, x1, #0x64c
* 0xcac8c: e0c32091 add x0, sp, #0x830
* 0xcac90: e2031faa mov x2, xzr
* 0xcac94: 6b970294 bl #0x170a40
* 0xcac98: e0c32091 add x0, sp, #0x830
* 0xcac9c: 6a990294 bl #0x171244
* 0xcaca0: 08004039 ldrb w8, [x0]
* 0xcaca4: e8233539 strb w8, [sp, #0xd48]
* 0xcaca8: e8000034 cbz w8, #0xcacc4
* 0xcacac: e8233591 add x8, sp, #0xd48
* 0xcacb0: 080140b2 orr x8, x8, #1
* 0xcacb4: 09040091 add x9, x0, #1
* 0xcacb8: 2a154038 ldrb w10, [x9], #1
* 0xcacbc: 0a150038 strb w10, [x8], #1
* 0xcacc0: caffff35 cbnz w10, #0xcacb8
* 0xcacc4: e0c32091 add x0, sp, #0x830
* 0xcacc8: 57990294 bl #0x171224
* 0xcaccc: 210600f0 adrp x1, #0x191000
* 0xcacd0: 21701a91 add x1, x1, #0x69c
* 0xcacd4: e0631091 add x0, sp, #0x418
* 0xcacd8: e2031faa mov x2, xzr
* 0xcacdc: 59970294 bl #0x170a40
* 0xcace0: e0631091 add x0, sp, #0x418
* 0xcace4: 58990294 bl #0x171244
* 0xcace8: 08004039 ldrb w8, [x0]
* 0xcacec: e8233939 strb w8, [sp, #0xe48]
* 0xcacf0: e8000034 cbz w8, #0xcad0c
* 0xcacf4: e8233991 add x8, sp, #0xe48
* 0xcacf8: 080140b2 orr x8, x8, #1
* 0xcacfc: 09040091 add x9, x0, #1
* 0xcad00: 2a154038 ldrb w10, [x9], #1
* 0xcad04: 0a150038 strb w10, [x8], #1
* 0xcad08: caffff35 cbnz w10, #0xcad00
* 0xcad0c: e0631091 add x0, sp, #0x418
* 0xcad10: 45990294 bl #0x171224
* 0xcad14: 210600f0 adrp x1, #0x191000
* 0xcad18: 21b01b91 add x1, x1, #0x6ec
* 0xcad1c: e0030091 mov x0, sp
* 0xcad20: e2031faa mov x2, xzr
* 0xcad24: 47970294 bl #0x170a40
* 0xcad28: e0030091 mov x0, sp
* 0xcad2c: 46990294 bl #0x171244
* 0xcad30: 08004039 ldrb w8, [x0]
* 0xcad34: e8233139 strb w8, [sp, #0xc48]
* 0xcad38: e8000034 cbz w8, #0xcad54
* 0xcad3c: e8233191 add x8, sp, #0xc48
* 0xcad40: 080140b2 orr x8, x8, #1
* 0xcad44: 09040091 add x9, x0, #1
* 0xcad48: 2a154038 ldrb w10, [x9], #1
* 0xcad4c: 0a150038 strb w10, [x8], #1
* 0xcad50: caffff35 cbnz w10, #0xcad48
* 0xcad54: e0030091 mov x0, sp
* 0xcad58: 33990294 bl #0x171224
* 0xcad5c: 0a440294 bl #0x15bd84
* 0xcad60: e1233991 add x1, sp, #0xe48
* 0xcad64: e2031f2a mov w2, wzr
* 0xcad68: e3031faa mov x3, xzr
* 0xcad6c: f30300aa mov x19, x0
* 0xcad70: 82460294 bl #0x15c778
* 0xcad74: 60000036 tbz w0, #0, #0xcad80
  0xcad78: f4030032 mov w20, #1
  0xcad7c: 07000014 b #0xcad98
* 0xcad80: e1233591 add x1, sp, #0xd48
* 0xcad84: e00313aa mov x0, x19
* 0xcad88: e2031f2a mov w2, wzr
* 0xcad8c: e3031faa mov x3, xzr
* 0xcad90: 7a460294 bl #0x15c778
* 0xcad94: f403002a mov w20, w0
* 0xcad98: c30800f0 adrp x3, #0x1e5000
* 0xcad9c: 638844f9 ldr x3, [x3, #0x910]
* 0xcada0: e1233191 add x1, sp, #0xc48
* 0xcada4: e00313aa mov x0, x19
* 0xcada8: e2031f2a mov w2, wzr
* 0xcadac: 73460294 bl #0x15c778
* 0xcadb0: a0000036 tbz w0, #0, #0xcadc4
  0xcadb4: e8080090 adrp x8, #0x1e6000
  0xcadb8: 086940f9 ldr x8, [x8, #0xd0]
  0xcadbc: f4030032 mov w20, #1
  0xcadc0: 14010039 strb w20, [x8]
* 0xcadc4: 48d03bd5 mrs x8, tpidr_el0
* 0xcadc8: 081540f9 ldr x8, [x8, #0x28]
* 0xcadcc: a9835df8 ldur x9, [x29, #-0x28]
* 0xcadd0: 1f0109eb cmp x8, x9
* 0xcadd4: e1000054 b.ne #0xcadf0
* 0xcadd8: 80020012 and w0, w20, #1
* 0xcaddc: ff433d91 add sp, sp, #0xf50
* 0xcade0: fd7b42a9 ldp x29, x30, [sp, #0x20]
* 0xcade4: f44f41a9 ldp x20, x19, [sp, #0x10]
* 0xcade8: fc0743f8 ldr x28, [sp], #0x30
* 0xcadec: c0035fd6 ret 
  0xcadf0: b4960294 bl #0x1708c0
  0xcadf4: f30300aa mov x19, x0
  0xcadf8: e0030091 mov x0, sp
  0xcadfc: 06000014 b #0xcae14
  0xcae00: f30300aa mov x19, x0
  0xcae04: e0631091 add x0, sp, #0x418
  0xcae08: 03000014 b #0xcae14
  0xcae0c: f30300aa mov x19, x0
  0xcae10: e0c32091 add x0, sp, #0x830
  0xcae14: 04990294 bl #0x171224
  0xcae18: e00313aa mov x0, x19
  0xcae1c: 19960294 bl #0x170680
  0xcae20: fc57bda9 stp x28, x21, [sp, #-0x30]!
  0xcae24: f44f01a9 stp x20, x19, [sp, #0x10]
  0xcae28: fd7b02a9 stp x29, x30, [sp, #0x20]
  0xcae2c: fd830091 add x29, sp, #0x20
  0xcae30: ff0740d1 sub sp, sp, #1, lsl #12
  0xcae34: ffc305d1 sub sp, sp, #0x170
  0xcae38: 48d03bd5 mrs x8, tpidr_el0
  0xcae3c: 081540f9 ldr x8, [x8, #0x28]
```

## Dynamic calls while predicate active

| caller | target | class | label | count |
|---:|---:|---|---|---:|
| `+0x170cd0` | `0x10171254` | `libcompatible` | `+0x171254` | 1664 |
| `+0x172080` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 1144 |
| `+0x1720cc` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 1144 |
| `+0x173bb4` | `0x10172c20` | `libcompatible` | `+0x172c20` | 416 |
| `+0x172c54` | `0x10172620` | `libcompatible` | `+0x172620` | 416 |
| `+0x113a60` | `0x1016fd10` | `libcompatible` | `+0x16fd10` | 256 |
| `+0xd38bc` | `0x100d37d4` | `libcompatible` | `+0xd37d4` | 202 |
| `+0xd37ec` | `0x100c2108` | `libcompatible` | `+0xc2108` | 202 |
| `+0x113a38` | `0x10170400` | `libcompatible` | `+0x170400` | 128 |
| `+0x170a90` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 104 |
| `+0x170cb4` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 104 |
| `+0x170db0` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 104 |
| `+0x170dc4` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 104 |
| `+0x170dcc` | `0x10171c1c` | `libcompatible` | `+0x171c1c` | 104 |
| `+0x171118` | `0x10171c28` | `libcompatible` | `+0x171c28` | 104 |
| `+0x171130` | `0x10173b0c` | `libcompatible` | `+0x173b0c` | 104 |
| `+0x1711b8` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 104 |
| `+0x1711d4` | `0x10171c24` | `libcompatible` | `+0x171c24` | 104 |
| `+0x171238` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 104 |
| `+0x15e0a8` | `0x10170a40` | `libcompatible` | `+0x170a40` | 100 |
| `+0x15e0b0` | `0x10171244` | `libcompatible` | `+0x171244` | 100 |
| `+0x15e0b8` | `0x1014d8a4` | `libcompatible` | `+0x14d8a4` | 100 |
| `+0x14d934` | `0x1015b860` | `libcompatible` | `+0x15b860` | 100 |
| `+0x15b9fc` | `0x1014db58` | `libcompatible` | `+0x14db58` | 100 |
| `+0x14db94` | `0x100d356c` | `libcompatible` | `+0xd356c` | 100 |
| `+0x15bba0` | `0x1014d968` | `libcompatible` | `+0x14d968` | 100 |
| `+0x14da38` | `0x100d356c` | `libcompatible` | `+0xd356c` | 100 |
| `+0x14da78` | `0x10170740` | `libcompatible` | `+0x170740` | 100 |
| `+0x15e0c4` | `0x10171224` | `libcompatible` | `+0x171224` | 100 |
| `+0xe91e8` | `0x100e9170` | `libcompatible` | `+0xe9170` | 28 |
| `+0x113a90` | `0x10113484` | `libcompatible` | `+0x113484` | 16 |
| `+0x110e60` | `0x100d53e4` | `libcompatible` | `+0xd53e4` | 12 |
| `+0xe8ad8` | `0x101700a0` | `libcompatible` | `+0x1700a0` | 7 |
| `+0x110e60` | `0x10111474` | `libcompatible` | `+0x111474` | 6 |
| `+0x11181c` | `0x1016ff30` | `libcompatible` | `+0x16ff30` | 6 |
| `+0xea800` | `0x101700a0` | `libcompatible` | `+0x1700a0` | 5 |
| `+0x114064` | `0x10114f18` | `libcompatible` | `+0x114f18` | 3 |
| `+0x114f44` | `0x100ea7c8` | `libcompatible` | `+0xea7c8` | 3 |
| `+0x114f50` | `0x100e8cc8` | `libcompatible` | `+0xe8cc8` | 3 |
| `+0x114f58` | `0x100e8d68` | `libcompatible` | `+0xe8d68` | 3 |
| `+0x11406c` | `0x100dbd60` | `libcompatible` | `+0xdbd60` | 3 |
| `+0xdbd78` | `0x100e9170` | `libcompatible` | `+0xe9170` | 3 |
| `+0xdbdb0` | `0x10170370` | `libcompatible` | `+0x170370` | 3 |
| `+0x11407c` | `0x100d9ff4` | `libcompatible` | `+0xd9ff4` | 3 |
| `+0xda00c` | `0x100e9170` | `libcompatible` | `+0xe9170` | 3 |
| `+0xda040` | `0x10170370` | `libcompatible` | `+0x170370` | 3 |
| `+0x114088` | `0x100dbf10` | `libcompatible` | `+0xdbf10` | 3 |
| `+0xdbf28` | `0x100e9170` | `libcompatible` | `+0xe9170` | 3 |
| `+0xdbf60` | `0x10170370` | `libcompatible` | `+0x170370` | 3 |
| `+0x114098` | `0x100dae24` | `libcompatible` | `+0xdae24` | 3 |
| `+0xdae3c` | `0x100e9170` | `libcompatible` | `+0xe9170` | 3 |
| `+0xdae70` | `0x10170370` | `libcompatible` | `+0x170370` | 3 |
| `+0x1140a4` | `0x100dbf7c` | `libcompatible` | `+0xdbf7c` | 3 |
| `+0xdbf94` | `0x100e9170` | `libcompatible` | `+0xe9170` | 3 |
| `+0xdbfcc` | `0x10170370` | `libcompatible` | `+0x170370` | 3 |
| `+0x1140b4` | `0x100dae8c` | `libcompatible` | `+0xdae8c` | 3 |
| `+0xdaea4` | `0x100e9170` | `libcompatible` | `+0xe9170` | 3 |
| `+0xdaed8` | `0x10170370` | `libcompatible` | `+0x170370` | 3 |
| `+0x15c7c4` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 3 |
| `+0xcac60` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 1 |
| `+0xcac70` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 1 |
| `+0xcac80` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 1 |
| `+0xcac94` | `0x10170a40` | `libcompatible` | `+0x170a40` | 1 |
| `+0xcac9c` | `0x10171244` | `libcompatible` | `+0x171244` | 1 |
| `+0xcacc8` | `0x10171224` | `libcompatible` | `+0x171224` | 1 |
| `+0xcacdc` | `0x10170a40` | `libcompatible` | `+0x170a40` | 1 |
| `+0xcace4` | `0x10171244` | `libcompatible` | `+0x171244` | 1 |
| `+0xcad10` | `0x10171224` | `libcompatible` | `+0x171224` | 1 |
| `+0xcad24` | `0x10170a40` | `libcompatible` | `+0x170a40` | 1 |
| `+0xcad2c` | `0x10171244` | `libcompatible` | `+0x171244` | 1 |
| `+0xcad58` | `0x10171224` | `libcompatible` | `+0x171224` | 1 |
| `+0xcad5c` | `0x1015bd84` | `libcompatible` | `+0x15bd84` | 1 |
| `+0x15bd98` | `0x101707c0` | `libcompatible` | `+0x1707c0` | 1 |
| `+0x15bdac` | `0x10170800` | `libcompatible` | `+0x170800` | 1 |
| `+0xd52f0` | `0x1016ff40` | `libcompatible` | `+0x16ff40` | 1 |
| `+0x15bdb4` | `0x1015bdec` | `libcompatible` | `+0x15bdec` | 1 |
| `+0x15be18` | `0x1015e054` | `libcompatible` | `+0x15e054` | 1 |
| `+0x15e0f0` | `0x10170a40` | `libcompatible` | `+0x170a40` | 1 |
| `+0x15e0f8` | `0x10171244` | `libcompatible` | `+0x171244` | 1 |
| `+0x15e120` | `0x10171224` | `libcompatible` | `+0x171224` | 1 |
| `+0x15be30` | `0x1016ff00` | `libcompatible` | `+0x16ff00` | 1 |
| `+0x15be48` | `0x1015e4a0` | `libcompatible` | `+0x15e4a0` | 1 |
| `+0x15e4dc` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 1 |
| `+0x15e4ec` | `0x100cb32c` | `libcompatible` | `+0xcb32c` | 1 |
| `+0xcb368` | `0x1016ff00` | `libcompatible` | `+0x16ff00` | 1 |
| `+0xcb3a8` | `0x100d356c` | `libcompatible` | `+0xd356c` | 1 |
| `+0xcb430` | `0x100d356c` | `libcompatible` | `+0xd356c` | 1 |
| `+0xcb44c` | `0x10107578` | `libcompatible` | `+0x107578` | 1 |
| `+0x107598` | `0x10170120` | `libcompatible` | `+0x170120` | 1 |
| `+0xcb45c` | `0x100eeb7c` | `libcompatible` | `+0xeeb7c` | 1 |
| `+0xeebac` | `0x100d56a0` | `libcompatible` | `+0xd56a0` | 1 |
| `+0xea938` | `0x100e97c0` | `libcompatible` | `+0xe97c0` | 1 |
| `+0xe9850` | `0x100e8b1c` | `libcompatible` | `+0xe8b1c` | 1 |
| `+0xe988c` | `0x10113208` | `libcompatible` | `+0x113208` | 1 |
| `+0x113264` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 1 |
| `+0x113278` | `0x101704e0` | `libcompatible` | `+0x1704e0` | 1 |
| `+0xe98a0` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe98b0` | `0x10112414` | `libcompatible` | `+0x112414` | 1 |
| `+0x11243c` | `0x100e8ab0` | `libcompatible` | `+0xe8ab0` | 1 |
| `+0xe98c4` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9938` | `0x100eb29c` | `libcompatible` | `+0xeb29c` | 1 |
| `+0xe994c` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9980` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe99b4` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe99d8` | `0x100e8ab0` | `libcompatible` | `+0xe8ab0` | 1 |
| `+0xe99f4` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9a98` | `0x100eab68` | `libcompatible` | `+0xeab68` | 1 |
| `+0xe9aac` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9b50` | `0x100ea9dc` | `libcompatible` | `+0xea9dc` | 1 |
| `+0xe9b64` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9b98` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9bcc` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9cc0` | `0x100d959c` | `libcompatible` | `+0xd959c` | 1 |
| `+0xd95c8` | `0x100e8b1c` | `libcompatible` | `+0xe8b1c` | 1 |
| `+0xd95d8` | `0x100f3278` | `libcompatible` | `+0xf3278` | 1 |
| `+0xe9cd4` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9d08` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9d3c` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9d4c` | `0x100d9b3c` | `libcompatible` | `+0xd9b3c` | 1 |
| `+0xd9b64` | `0x100e8ab0` | `libcompatible` | `+0xe8ab0` | 1 |
| `+0xe9d60` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9d70` | `0x10112fb0` | `libcompatible` | `+0x112fb0` | 1 |
| `+0x112fd8` | `0x100e8ab0` | `libcompatible` | `+0xe8ab0` | 1 |
| `+0xe9d84` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9d94` | `0x101124bc` | `libcompatible` | `+0x1124bc` | 1 |
| `+0x1124e4` | `0x100e8ab0` | `libcompatible` | `+0xe8ab0` | 1 |
| `+0xe9da8` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9e1c` | `0x100eb474` | `libcompatible` | `+0xeb474` | 1 |
| `+0xe9e30` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9e64` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9e98` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9ebc` | `0x100e8ab0` | `libcompatible` | `+0xe8ab0` | 1 |
| `+0xe9ed8` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xe9f7c` | `0x100eafc8` | `libcompatible` | `+0xeafc8` | 1 |
| `+0xe9f90` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xea034` | `0x100eae64` | `libcompatible` | `+0xeae64` | 1 |
| `+0xea048` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xea07c` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xea0b0` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xea1a4` | `0x100f606c` | `libcompatible` | `+0xf606c` | 1 |
| `+0xf6098` | `0x100e8b1c` | `libcompatible` | `+0xe8b1c` | 1 |
| `+0xf60a8` | `0x100f3680` | `libcompatible` | `+0xf3680` | 1 |
| `+0xea1b8` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xea1ec` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xea220` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xea230` | `0x100f660c` | `libcompatible` | `+0xf660c` | 1 |
| `+0xf6634` | `0x100e8ab0` | `libcompatible` | `+0xe8ab0` | 1 |
| `+0xea244` | `0x100e91c0` | `libcompatible` | `+0xe91c0` | 1 |
| `+0xea274` | `0x100e9170` | `libcompatible` | `+0xe9170` | 1 |
| `+0xea288` | `0x100e9170` | `libcompatible` | `+0xe9170` | 1 |
| `+0xea29c` | `0x100e9170` | `libcompatible` | `+0xe9170` | 1 |
| `+0xea2b0` | `0x100e9170` | `libcompatible` | `+0xe9170` | 1 |
| `+0xea2c4` | `0x100e9170` | `libcompatible` | `+0xe9170` | 1 |
| `+0xea2d8` | `0x100e9170` | `libcompatible` | `+0xe9170` | 1 |
| `+0xea2ec` | `0x100e9170` | `libcompatible` | `+0xe9170` | 1 |
| `+0xea300` | `0x100e9170` | `libcompatible` | `+0xe9170` | 1 |
| `+0xeebf0` | `0x10114048` | `libcompatible` | `+0x114048` | 1 |
| `+0xeec14` | `0x10114048` | `libcompatible` | `+0x114048` | 1 |
| `+0xeec78` | `0x100ea7c8` | `libcompatible` | `+0xea7c8` | 1 |
| `+0xeec98` | `0x1010743c` | `libcompatible` | `+0x10743c` | 1 |
| `+0xeecbc` | `0x100ecfa4` | `libcompatible` | `+0xecfa4` | 1 |
| `+0xeecc8` | `0x10114048` | `libcompatible` | `+0x114048` | 1 |
| `+0xcb498` | `0x100d6860` | `libcompatible` | `+0xd6860` | 1 |
| `+0xd6894` | `0x10115b60` | `libcompatible` | `+0x115b60` | 1 |
| `+0xd68f4` | `0x10109678` | `libcompatible` | `+0x109678` | 1 |
| `+0xd6b00` | `0x100eb7c8` | `libcompatible` | `+0xeb7c8` | 1 |
| `+0xd68bc` | `0x10113b74` | `libcompatible` | `+0x113b74` | 1 |
| `+0xcb4f0` | `0x1016fec0` | `libcompatible` | `+0x16fec0` | 1 |
| `+0xcb55c` | `0x100e8d68` | `libcompatible` | `+0xe8d68` | 1 |
| `+0xcb578` | `0x100d5a40` | `libcompatible` | `+0xd5a40` | 1 |
| `+0xd5a60` | `0x100d5954` | `libcompatible` | `+0xd5954` | 1 |
| `+0xd5a68` | `0x100d59bc` | `libcompatible` | `+0xd59bc` | 1 |
| `+0x15bdc4` | `0x10170360` | `libcompatible` | `+0x170360` | 1 |
| `+0xcad70` | `0x1015c778` | `libcompatible` | `+0x15c778` | 1 |
| `+0xcad90` | `0x1015c778` | `libcompatible` | `+0x15c778` | 1 |
| `+0xcadac` | `0x1015c778` | `libcompatible` | `+0x15c778` | 1 |

## Executed top-level conditional branches

| RVA | instruction | target | executions | representative x0 | x19 | x22 | x27 | NZCV |
|---:|---|---:|---:|---:|---:|---:|---:|---:|
| `+0xcaca8` | `cbz w8, #0x100cacc4` | `0x100cacc4` | 1 | `0x7000ff8b24` | `0x100d356c` | `0x100d3660` | `0x51000013fc` | `0x60000000` |
| `+0xcacc0` | `cbnz w10, #0x100cacb8` | `0x100cacb8` | 13 | `0x7000ff8b24` | `0x100d356c` | `0x100d3660` | `0x51000013fc` | `0x60000000` |
| `+0xcacf0` | `cbz w8, #0x100cad0c` | `0x100cad0c` | 1 | `0x7000ff870c` | `0x100d356c` | `0x100d3660` | `0x51000013fc` | `0x60000000` |
| `+0xcad08` | `cbnz w10, #0x100cad00` | `0x100cad00` | 13 | `0x7000ff870c` | `0x100d356c` | `0x100d3660` | `0x51000013fc` | `0x60000000` |
| `+0xcad38` | `cbz w8, #0x100cad54` | `0x100cad54` | 1 | `0x7000ff82f4` | `0x100d356c` | `0x100d3660` | `0x51000013fc` | `0x60000000` |
| `+0xcad50` | `cbnz w10, #0x100cad48` | `0x100cad48` | 19 | `0x7000ff82f4` | `0x100d356c` | `0x100d3660` | `0x51000013fc` | `0x60000000` |
| `+0xcad74` | `tbz w0, #0, #0x100cad80` | `0x100cad80` | 1 | `0x0` | `0x5000002390` | `0x100d3660` | `0x51000013fc` | `0x60000000` |
| `+0xcadb0` | `tbz w0, #0, #0x100cadc4` | `0x100cadc4` | 1 | `0x0` | `0x5000002390` | `0x100d3660` | `0x51000013fc` | `0x60000000` |
| `+0xcadd4` | `b.ne #0x100cadf0` | `0x100cadf0` | 1 | `0x0` | `0x5000002390` | `0x100d3660` | `0x51000013fc` | `0x60000000` |

## Runtime disassembly helper `+0x1704e0`

```asm
0x1704e0: b00300d0 adrp x16, #0x1e6000
0x1704e4: 113243f9 ldr x17, [x16, #0x660]
0x1704e8: 10821991 add x16, x16, #0x660
0x1704ec: 20021fd6 br x17
0x1704f0: b00300d0 adrp x16, #0x1e6000
0x1704f4: 113643f9 ldr x17, [x16, #0x668]
0x1704f8: 10a21991 add x16, x16, #0x668
0x1704fc: 20021fd6 br x17
0x170500: b00300d0 adrp x16, #0x1e6000
0x170504: 113a43f9 ldr x17, [x16, #0x670]
0x170508: 10c21991 add x16, x16, #0x670
0x17050c: 20021fd6 br x17
0x170510: b00300d0 adrp x16, #0x1e6000
0x170514: 113e43f9 ldr x17, [x16, #0x678]
0x170518: 10e21991 add x16, x16, #0x678
0x17051c: 20021fd6 br x17
0x170520: b00300d0 adrp x16, #0x1e6000
0x170524: 114243f9 ldr x17, [x16, #0x680]
0x170528: 10021a91 add x16, x16, #0x680
0x17052c: 20021fd6 br x17
0x170530: b00300d0 adrp x16, #0x1e6000
0x170534: 114643f9 ldr x17, [x16, #0x688]
0x170538: 10221a91 add x16, x16, #0x688
0x17053c: 20021fd6 br x17
0x170540: b00300d0 adrp x16, #0x1e6000
0x170544: 114a43f9 ldr x17, [x16, #0x690]
0x170548: 10421a91 add x16, x16, #0x690
0x17054c: 20021fd6 br x17
0x170550: b00300d0 adrp x16, #0x1e6000
0x170554: 114e43f9 ldr x17, [x16, #0x698]
0x170558: 10621a91 add x16, x16, #0x698
0x17055c: 20021fd6 br x17
0x170560: b00300d0 adrp x16, #0x1e6000
0x170564: 115243f9 ldr x17, [x16, #0x6a0]
0x170568: 10821a91 add x16, x16, #0x6a0
0x17056c: 20021fd6 br x17
0x170570: b00300d0 adrp x16, #0x1e6000
0x170574: 115643f9 ldr x17, [x16, #0x6a8]
0x170578: 10a21a91 add x16, x16, #0x6a8
0x17057c: 20021fd6 br x17
0x170580: b00300d0 adrp x16, #0x1e6000
0x170584: 115a43f9 ldr x17, [x16, #0x6b0]
0x170588: 10c21a91 add x16, x16, #0x6b0
0x17058c: 20021fd6 br x17
0x170590: b00300d0 adrp x16, #0x1e6000
0x170594: 115e43f9 ldr x17, [x16, #0x6b8]
0x170598: 10e21a91 add x16, x16, #0x6b8
0x17059c: 20021fd6 br x17
0x1705a0: b00300d0 adrp x16, #0x1e6000
0x1705a4: 116243f9 ldr x17, [x16, #0x6c0]
0x1705a8: 10021b91 add x16, x16, #0x6c0
0x1705ac: 20021fd6 br x17
0x1705b0: b00300d0 adrp x16, #0x1e6000
0x1705b4: 116643f9 ldr x17, [x16, #0x6c8]
0x1705b8: 10221b91 add x16, x16, #0x6c8
0x1705bc: 20021fd6 br x17
0x1705c0: b00300d0 adrp x16, #0x1e6000
0x1705c4: 116a43f9 ldr x17, [x16, #0x6d0]
0x1705c8: 10421b91 add x16, x16, #0x6d0
0x1705cc: 20021fd6 br x17
0x1705d0: b00300d0 adrp x16, #0x1e6000
0x1705d4: 116e43f9 ldr x17, [x16, #0x6d8]
0x1705d8: 10621b91 add x16, x16, #0x6d8
0x1705dc: 20021fd6 br x17
0x1705e0: b00300d0 adrp x16, #0x1e6000
0x1705e4: 117243f9 ldr x17, [x16, #0x6e0]
0x1705e8: 10821b91 add x16, x16, #0x6e0
0x1705ec: 20021fd6 br x17
0x1705f0: b00300d0 adrp x16, #0x1e6000
0x1705f4: 117643f9 ldr x17, [x16, #0x6e8]
0x1705f8: 10a21b91 add x16, x16, #0x6e8
0x1705fc: 20021fd6 br x17
0x170600: b00300d0 adrp x16, #0x1e6000
0x170604: 117a43f9 ldr x17, [x16, #0x6f0]
0x170608: 10c21b91 add x16, x16, #0x6f0
0x17060c: 20021fd6 br x17
0x170610: b00300d0 adrp x16, #0x1e6000
0x170614: 117e43f9 ldr x17, [x16, #0x6f8]
0x170618: 10e21b91 add x16, x16, #0x6f8
0x17061c: 20021fd6 br x17
0x170620: b00300d0 adrp x16, #0x1e6000
0x170624: 118243f9 ldr x17, [x16, #0x700]
0x170628: 10021c91 add x16, x16, #0x700
0x17062c: 20021fd6 br x17
0x170630: b00300d0 adrp x16, #0x1e6000
0x170634: 118643f9 ldr x17, [x16, #0x708]
0x170638: 10221c91 add x16, x16, #0x708
0x17063c: 20021fd6 br x17
0x170640: b00300d0 adrp x16, #0x1e6000
0x170644: 118a43f9 ldr x17, [x16, #0x710]
0x170648: 10421c91 add x16, x16, #0x710
0x17064c: 20021fd6 br x17
0x170650: b00300d0 adrp x16, #0x1e6000
0x170654: 118e43f9 ldr x17, [x16, #0x718]
0x170658: 10621c91 add x16, x16, #0x718
0x17065c: 20021fd6 br x17
0x170660: b00300d0 adrp x16, #0x1e6000
0x170664: 119243f9 ldr x17, [x16, #0x720]
0x170668: 10821c91 add x16, x16, #0x720
0x17066c: 20021fd6 br x17
0x170670: b00300d0 adrp x16, #0x1e6000
0x170674: 119643f9 ldr x17, [x16, #0x728]
0x170678: 10a21c91 add x16, x16, #0x728
0x17067c: 20021fd6 br x17
0x170680: b00300d0 adrp x16, #0x1e6000
0x170684: 119a43f9 ldr x17, [x16, #0x730]
0x170688: 10c21c91 add x16, x16, #0x730
0x17068c: 20021fd6 br x17
0x170690: b00300d0 adrp x16, #0x1e6000
0x170694: 119e43f9 ldr x17, [x16, #0x738]
0x170698: 10e21c91 add x16, x16, #0x738
0x17069c: 20021fd6 br x17
0x1706a0: b00300d0 adrp x16, #0x1e6000
0x1706a4: 11a243f9 ldr x17, [x16, #0x740]
0x1706a8: 10021d91 add x16, x16, #0x740
0x1706ac: 20021fd6 br x17
0x1706b0: b00300d0 adrp x16, #0x1e6000
0x1706b4: 11a643f9 ldr x17, [x16, #0x748]
0x1706b8: 10221d91 add x16, x16, #0x748
0x1706bc: 20021fd6 br x17
0x1706c0: b00300d0 adrp x16, #0x1e6000
0x1706c4: 11aa43f9 ldr x17, [x16, #0x750]
0x1706c8: 10421d91 add x16, x16, #0x750
0x1706cc: 20021fd6 br x17
0x1706d0: b00300d0 adrp x16, #0x1e6000
0x1706d4: 11ae43f9 ldr x17, [x16, #0x758]
0x1706d8: 10621d91 add x16, x16, #0x758
0x1706dc: 20021fd6 br x17
0x1706e0: b00300d0 adrp x16, #0x1e6000
0x1706e4: 11b243f9 ldr x17, [x16, #0x760]
0x1706e8: 10821d91 add x16, x16, #0x760
0x1706ec: 20021fd6 br x17
0x1706f0: b00300d0 adrp x16, #0x1e6000
0x1706f4: 11b643f9 ldr x17, [x16, #0x768]
0x1706f8: 10a21d91 add x16, x16, #0x768
0x1706fc: 20021fd6 br x17
0x170700: b00300d0 adrp x16, #0x1e6000
0x170704: 11ba43f9 ldr x17, [x16, #0x770]
0x170708: 10c21d91 add x16, x16, #0x770
0x17070c: 20021fd6 br x17
0x170710: b00300d0 adrp x16, #0x1e6000
0x170714: 11be43f9 ldr x17, [x16, #0x778]
0x170718: 10e21d91 add x16, x16, #0x778
0x17071c: 20021fd6 br x17
0x170720: b00300d0 adrp x16, #0x1e6000
0x170724: 11c243f9 ldr x17, [x16, #0x780]
0x170728: 10021e91 add x16, x16, #0x780
0x17072c: 20021fd6 br x17
0x170730: b00300d0 adrp x16, #0x1e6000
0x170734: 11c643f9 ldr x17, [x16, #0x788]
0x170738: 10221e91 add x16, x16, #0x788
0x17073c: 20021fd6 br x17
0x170740: b00300d0 adrp x16, #0x1e6000
0x170744: 11ca43f9 ldr x17, [x16, #0x790]
0x170748: 10421e91 add x16, x16, #0x790
0x17074c: 20021fd6 br x17
0x170750: b00300d0 adrp x16, #0x1e6000
0x170754: 11ce43f9 ldr x17, [x16, #0x798]
0x170758: 10621e91 add x16, x16, #0x798
0x17075c: 20021fd6 br x17
0x170760: b00300d0 adrp x16, #0x1e6000
0x170764: 11d243f9 ldr x17, [x16, #0x7a0]
0x170768: 10821e91 add x16, x16, #0x7a0
0x17076c: 20021fd6 br x17
0x170770: b00300d0 adrp x16, #0x1e6000
0x170774: 11d643f9 ldr x17, [x16, #0x7a8]
0x170778: 10a21e91 add x16, x16, #0x7a8
0x17077c: 20021fd6 br x17
0x170780: b00300d0 adrp x16, #0x1e6000
0x170784: 11da43f9 ldr x17, [x16, #0x7b0]
0x170788: 10c21e91 add x16, x16, #0x7b0
0x17078c: 20021fd6 br x17
0x170790: b00300d0 adrp x16, #0x1e6000
0x170794: 11de43f9 ldr x17, [x16, #0x7b8]
0x170798: 10e21e91 add x16, x16, #0x7b8
0x17079c: 20021fd6 br x17
0x1707a0: b00300d0 adrp x16, #0x1e6000
0x1707a4: 11e243f9 ldr x17, [x16, #0x7c0]
0x1707a8: 10021f91 add x16, x16, #0x7c0
0x1707ac: 20021fd6 br x17
0x1707b0: b00300d0 adrp x16, #0x1e6000
0x1707b4: 11e643f9 ldr x17, [x16, #0x7c8]
0x1707b8: 10221f91 add x16, x16, #0x7c8
0x1707bc: 20021fd6 br x17
0x1707c0: b00300d0 adrp x16, #0x1e6000
0x1707c4: 11ea43f9 ldr x17, [x16, #0x7d0]
0x1707c8: 10421f91 add x16, x16, #0x7d0
0x1707cc: 20021fd6 br x17
0x1707d0: b00300d0 adrp x16, #0x1e6000
0x1707d4: 11ee43f9 ldr x17, [x16, #0x7d8]
0x1707d8: 10621f91 add x16, x16, #0x7d8
0x1707dc: 20021fd6 br x17
```

## Runtime disassembly helper `+0x11cbec`

```asm
0x11cbec: 80860339 strb w0, [x20, #0xe1]
0x11cbf0: 600240f9 ldr x0, [x19]
0x11cbf4: 14805ef8 ldur x20, [x0, #-0x18]
0x11cbf8: 7402148b add x20, x19, x20
0x11cbfc: e00314aa mov x0, x20
0x11cc00: cbffff17 b #0x11cb2c
0x11cc04: e00318aa mov x0, x24
0x11cc08: 7ed8ff97 bl #0x112e00
0x11cc0c: 020340f9 ldr x2, [x24]
0x11cc10: e00318aa mov x0, x24
0x11cc14: 01048052 mov w1, #0x20
0x11cc18: 421840f9 ldr x2, [x2, #0x30]
0x11cc1c: 40003fd6 blr x2
0x11cc20: 181c0053 uxtb w24, w0
0x11cc24: e3ffff17 b #0x11cbb0
0x11cc28: e00316aa mov x0, x22
0x11cc2c: 75d8ff97 bl #0x112e00
0x11cc30: c20240f9 ldr x2, [x22]
0x11cc34: e00316aa mov x0, x22
0x11cc38: 01048052 mov w1, #0x20
0x11cc3c: 421840f9 ldr x2, [x2, #0x30]
0x11cc40: 40003fd6 blr x2
0x11cc44: 161c0053 uxtb w22, w0
0x11cc48: e7ffff17 b #0x11cbe4
0x11cc4c: 0fa0ff97 bl #0x104c88
0x11cc50: 3f0400f1 cmp x1, #1
0x11cc54: a1020054 b.ne #0x11cca8
0x11cc58: 624e0194 bl #0x1705e0
0x11cc5c: 600240f9 ldr x0, [x19]
0x11cc60: 00805ef8 ldur x0, [x0, #-0x18]
0x11cc64: 7302008b add x19, x19, x0
0x11cc68: 602240b9 ldr w0, [x19, #0x20]
0x11cc6c: 611e40b9 ldr w1, [x19, #0x1c]
0x11cc70: 00000032 orr w0, w0, #1
0x11cc74: 602200b9 str w0, [x19, #0x20]
0x11cc78: 61010036 tbz w1, #0, #0x11cca4
0x11cc7c: 5d4e0194 bl #0x1705f0
0x11cc80: 02a0ff97 bl #0x104c88
0x11cc84: a03700f9 str x0, [x29, #0x68]
0x11cc88: 564c0194 bl #0x16fde0
0x11cc8c: a03740f9 ldr x0, [x29, #0x68]
0x11cc90: f30300aa mov x19, x0
0x11cc94: e00317aa mov x0, x23
0x11cc98: 1ffdff97 bl #0x11c114
0x11cc9c: e00313aa mov x0, x19
0x11cca0: 784e0194 bl #0x170680
0x11cca4: 534e0194 bl #0x1705f0
0x11cca8: 4e4e0194 bl #0x1705e0
0x11ccac: 600240f9 ldr x0, [x19]
0x11ccb0: 00805ef8 ldur x0, [x0, #-0x18]
0x11ccb4: 6002008b add x0, x19, x0
0x11ccb8: 012040b9 ldr w1, [x0, #0x20]
0x11ccbc: 021c40b9 ldr w2, [x0, #0x1c]
0x11ccc0: 21000032 orr w1, w1, #1
0x11ccc4: 012000b9 str w1, [x0, #0x20]
0x11ccc8: 62000037 tbnz w2, #0, #0x11ccd4
0x11cccc: 454c0194 bl #0x16fde0
0x11ccd0: 17ffff17 b #0x11c92c
0x11ccd4: 474e0194 bl #0x1705f0
0x11ccd8: f30300aa mov x19, x0
0x11ccdc: eeffff17 b #0x11cc94
0x11cce0: a03700f9 str x0, [x29, #0x68]
0x11cce4: 3f4c0194 bl #0x16fde0
0x11cce8: a03740f9 ldr x0, [x29, #0x68]
0x11ccec: f30300aa mov x19, x0
0x11ccf0: e9ffff17 b #0x11cc94
0x11ccf4: fd7bbea9 stp x29, x30, [sp, #-0x20]!
0x11ccf8: 220080d2 mov x2, #1
0x11ccfc: fd030091 mov x29, sp
0x11cd00: a3830091 add x3, x29, #0x20
0x11cd04: 61fc1f38 strb w1, [x3, #-1]!
0x11cd08: e10303aa mov x1, x3
0x11cd0c: e8feff97 bl #0x11c8ac
0x11cd10: fd7bc2a8 ldp x29, x30, [sp], #0x20
0x11cd14: c0035fd6 ret 
0x11cd18: fd7bbea9 stp x29, x30, [sp, #-0x20]!
0x11cd1c: 220080d2 mov x2, #1
0x11cd20: fd030091 mov x29, sp
0x11cd24: a3830091 add x3, x29, #0x20
0x11cd28: 61fc1f38 strb w1, [x3, #-1]!
0x11cd2c: e10303aa mov x1, x3
0x11cd30: dffeff97 bl #0x11c8ac
0x11cd34: fd7bc2a8 ldp x29, x30, [sp], #0x20
0x11cd38: c0035fd6 ret 
0x11cd3c: fd7bbea9 stp x29, x30, [sp, #-0x20]!
0x11cd40: 220080d2 mov x2, #1
0x11cd44: fd030091 mov x29, sp
0x11cd48: a3830091 add x3, x29, #0x20
0x11cd4c: 61fc1f38 strb w1, [x3, #-1]!
0x11cd50: e10303aa mov x1, x3
0x11cd54: d6feff97 bl #0x11c8ac
0x11cd58: fd7bc2a8 ldp x29, x30, [sp], #0x20
0x11cd5c: c0035fd6 ret 
0x11cd60: fd7bbda9 stp x29, x30, [sp, #-0x30]!
0x11cd64: fd030091 mov x29, sp
0x11cd68: f30b00f9 str x19, [sp, #0x10]
0x11cd6c: f30300aa mov x19, x0
0x11cd70: 810100b4 cbz x1, #0x11cda0
0x11cd74: e00301aa mov x0, x1
0x11cd78: a11700f9 str x1, [x29, #0x28]
0x11cd7c: e94c0194 bl #0x170120
0x11cd80: e20300aa mov x2, x0
0x11cd84: a11740f9 ldr x1, [x29, #0x28]
0x11cd88: e00313aa mov x0, x19
0x11cd8c: c8feff97 bl #0x11c8ac
0x11cd90: e00313aa mov x0, x19
0x11cd94: f30b40f9 ldr x19, [sp, #0x10]
0x11cd98: fd7bc3a8 ldp x29, x30, [sp], #0x30
0x11cd9c: c0035fd6 ret 
0x11cda0: 000040f9 ldr x0, [x0]
0x11cda4: 01805ef8 ldur x1, [x0, #-0x18]
0x11cda8: 6102018b add x1, x19, x1
0x11cdac: e00301aa mov x0, x1
0x11cdb0: 212040b9 ldr w1, [x1, #0x20]
0x11cdb4: 21000032 orr w1, w1, #1
0x11cdb8: 6fdbff97 bl #0x113b74
0x11cdbc: e00313aa mov x0, x19
0x11cdc0: f30b40f9 ldr x19, [sp, #0x10]
0x11cdc4: fd7bc3a8 ldp x29, x30, [sp], #0x30
0x11cdc8: c0035fd6 ret 
0x11cdcc: fd7bbda9 stp x29, x30, [sp, #-0x30]!
0x11cdd0: fd030091 mov x29, sp
0x11cdd4: f30b00f9 str x19, [sp, #0x10]
0x11cdd8: f30300aa mov x19, x0
0x11cddc: 810100b4 cbz x1, #0x11ce0c
0x11cde0: e00301aa mov x0, x1
0x11cde4: a11700f9 str x1, [x29, #0x28]
0x11cde8: ce4c0194 bl #0x170120
0x11cdec: e20300aa mov x2, x0
0x11cdf0: a11740f9 ldr x1, [x29, #0x28]
0x11cdf4: e00313aa mov x0, x19
0x11cdf8: adfeff97 bl #0x11c8ac
0x11cdfc: e00313aa mov x0, x19
0x11ce00: f30b40f9 ldr x19, [sp, #0x10]
0x11ce04: fd7bc3a8 ldp x29, x30, [sp], #0x30
0x11ce08: c0035fd6 ret 
0x11ce0c: 000040f9 ldr x0, [x0]
0x11ce10: 01805ef8 ldur x1, [x0, #-0x18]
0x11ce14: 6102018b add x1, x19, x1
0x11ce18: e00301aa mov x0, x1
0x11ce1c: 212040b9 ldr w1, [x1, #0x20]
0x11ce20: 21000032 orr w1, w1, #1
0x11ce24: 54dbff97 bl #0x113b74
0x11ce28: e00313aa mov x0, x19
0x11ce2c: f30b40f9 ldr x19, [sp, #0x10]
0x11ce30: fd7bc3a8 ldp x29, x30, [sp], #0x30
0x11ce34: c0035fd6 ret 
0x11ce38: fd7bbda9 stp x29, x30, [sp, #-0x30]!
0x11ce3c: fd030091 mov x29, sp
0x11ce40: f30b00f9 str x19, [sp, #0x10]
0x11ce44: f30300aa mov x19, x0
0x11ce48: 810100b4 cbz x1, #0x11ce78
0x11ce4c: e00301aa mov x0, x1
0x11ce50: a11700f9 str x1, [x29, #0x28]
0x11ce54: b34c0194 bl #0x170120
0x11ce58: e20300aa mov x2, x0
0x11ce5c: a11740f9 ldr x1, [x29, #0x28]
0x11ce60: e00313aa mov x0, x19
0x11ce64: 92feff97 bl #0x11c8ac
0x11ce68: e00313aa mov x0, x19
0x11ce6c: f30b40f9 ldr x19, [sp, #0x10]
0x11ce70: fd7bc3a8 ldp x29, x30, [sp], #0x30
0x11ce74: c0035fd6 ret 
0x11ce78: 000040f9 ldr x0, [x0]
0x11ce7c: 01805ef8 ldur x1, [x0, #-0x18]
0x11ce80: 6102018b add x1, x19, x1
0x11ce84: e00301aa mov x0, x1
0x11ce88: 212040b9 ldr w1, [x1, #0x20]
0x11ce8c: 21000032 orr w1, w1, #1
0x11ce90: 39dbff97 bl #0x113b74
0x11ce94: e00313aa mov x0, x19
0x11ce98: f30b40f9 ldr x19, [sp, #0x10]
0x11ce9c: fd7bc3a8 ldp x29, x30, [sp], #0x30
0x11cea0: c0035fd6 ret 
0x11cea4: fd7bb9a9 stp x29, x30, [sp, #-0x70]!
0x11cea8: fd030091 mov x29, sp
0x11ceac: f35301a9 stp x19, x20, [sp, #0x10]
0x11ceb0: f76303a9 stp x23, x24, [sp, #0x30]
0x11ceb4: f40300aa mov x20, x0
0x11ceb8: b7830191 add x23, x29, #0x60
0x11cebc: f96b04a9 stp x25, x26, [sp, #0x40]
0x11cec0: e00317aa mov x0, x23
0x11cec4: f90301aa mov x25, x1
0x11cec8: e10314aa mov x1, x20
0x11cecc: f55b02a9 stp x21, x22, [sp, #0x20]
0x11ced0: 72fcff97 bl #0x11c098
0x11ced4: a0834139 ldrb w0, [x29, #0x60]
0x11ced8: c0040034 cbz w0, #0x11cf70
0x11cedc: 800240f9 ldr x0, [x20]
0x11cee0: 13805ef8 ldur x19, [x0, #-0x18]
0x11cee4: 9302138b add x19, x20, x19
0x11cee8: 757e40f9 ldr x21, [x19, #0xf8]
```

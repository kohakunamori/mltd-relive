# `cac34` matcher inputs / returns

- gate w0: `0x0`

## Decoded candidates

| stage | returned pointer | length | text | hex |
|---|---:|---:|---|---|
| `candidate_d48` | `0x7000ff8b24` | 13 | `lib3btrans.so` | `6c696233627472616e732e736f` |
| `candidate_e48` | `0x7000ff870c` | 13 | `libhoudini.so` | `6c6962686f7564696e692e736f` |
| `candidate_c48` | `0x7000ff82f4` | 19 | `/lib/arm/nb/libc.so` | `2f6c69622f61726d2f6e622f6c6962632e736f` |

## Matcher calls

| # | object | candidate | x2 | x3 | return w0 |
|---:|---:|---|---:|---:|---:|
| 0 | `0x5000002390` | `libhoudini.so` | `0x0` | `0x0` | `0x0` |
| 1 | `0x5000002390` | `lib3btrans.so` | `0x0` | `0x0` | `0x0` |
| 2 | `0x5000002390` | `/lib/arm/nb/libc.so` | `0x0` | `+0x1e9d00` | `0x0` |

## Relocations / runtime values for top-level globals

| slot | relocation | symbol | runtime value |
|---:|---|---|---:|
| `+0x1e5910` | type 1027 `RELA` | `-` | `+0x1e9d00` |
| `+0x1e60d0` | type 1027 `RELA` | `-` | `+0x1e9cf1` |

## Runtime disassembly `ctor`

```asm
0x15bd84: f44fbea9 stp x20, x19, [sp, #-0x20]!
0x15bd88: fd7b01a9 stp x29, x30, [sp, #0x10]
0x15bd8c: fd430091 add x29, sp, #0x10
0x15bd90: 800400d0 adrp x0, #0x1ed000
0x15bd94: 00602e91 add x0, x0, #0xb98
0x15bd98: 8a520094 bl #0x1707c0
0x15bd9c: 940400d0 adrp x20, #0x1ed000
0x15bda0: 88ca45f9 ldr x8, [x20, #0xb90]
0x15bda4: c80000b5 cbnz x8, #0x15bdbc
0x15bda8: e00b1a32 mov w0, #0x1c0
0x15bdac: 95520094 bl #0x170800
0x15bdb0: f30300aa mov x19, x0
0x15bdb4: 0e000094 bl #0x15bdec
0x15bdb8: 93ca05f9 str x19, [x20, #0xb90]
0x15bdbc: 800400d0 adrp x0, #0x1ed000
0x15bdc0: 00602e91 add x0, x0, #0xb98
0x15bdc4: 67510094 bl #0x170360
0x15bdc8: 80ca45f9 ldr x0, [x20, #0xb90]
0x15bdcc: fd7b41a9 ldp x29, x30, [sp, #0x10]
0x15bdd0: f44fc2a8 ldp x20, x19, [sp], #0x20
0x15bdd4: c0035fd6 ret 
0x15bdd8: f40300aa mov x20, x0
0x15bddc: e00313aa mov x0, x19
0x15bde0: c84f0094 bl #0x16fd00
0x15bde4: e00314aa mov x0, x20
0x15bde8: 26520094 bl #0x170680
0x15bdec: ff4306d1 sub sp, sp, #0x190
0x15bdf0: fca300f9 str x28, [sp, #0x140]
0x15bdf4: f85f15a9 stp x24, x23, [sp, #0x150]
0x15bdf8: f65716a9 stp x22, x21, [sp, #0x160]
0x15bdfc: f44f17a9 stp x20, x19, [sp, #0x170]
0x15be00: fd7b18a9 stp x29, x30, [sp, #0x180]
0x15be04: fd030691 add x29, sp, #0x180
0x15be08: 48d03bd5 mrs x8, tpidr_el0
0x15be0c: 081540f9 ldr x8, [x8, #0x28]
0x15be10: f30300aa mov x19, x0
0x15be14: a8831bf8 stur x8, [x29, #-0x48]
0x15be18: 8f080094 bl #0x15e054
0x15be1c: 880c8052 mov w8, #0x64
0x15be20: f40313aa mov x20, x19
0x15be24: e0031d32 mov w0, #8
0x15be28: 810c8052 mov w1, #0x64
0x15be2c: 888e07f8 str x8, [x20, #0x78]!
0x15be30: 34500094 bl #0x16ff00
0x15be34: 95420091 add x21, x20, #0x10
0x15be38: 96220191 add x22, x20, #0x48
0x15be3c: 800600f9 str x0, [x20, #8]
0x15be40: e00313aa mov x0, x19
0x15be44: e10315aa mov x1, x21
0x15be48: 96090094 bl #0x15e4a0
0x15be4c: 1f040031 cmn w0, #1
0x15be50: 00020054 b.eq #0x15be90
0x15be54: e8031faa mov x8, xzr
0x15be58: c96a6838 ldrb w9, [x22, x8]
0x15be5c: 08050091 add x8, x8, #1
0x15be60: c9ffff35 cbnz w9, #0x15be58
0x15be64: 1f0500f1 cmp x8, #1
0x15be68: c0feff54 b.eq #0x15be40
0x15be6c: e0030091 mov x0, sp
0x15be70: 02278052 mov w2, #0x138
0x15be74: e10315aa mov x1, x21
0x15be78: 624f0094 bl #0x16fc00
0x15be7c: e2030091 mov x2, sp
0x15be80: e00314aa mov x0, x20
0x15be84: e10316aa mov x1, x22
0x15be88: 4dbcfd97 bl #0xcafbc
0x15be8c: edffff17 b #0x15be40
0x15be90: 48d03bd5 mrs x8, tpidr_el0
0x15be94: 081540f9 ldr x8, [x8, #0x28]
0x15be98: a9835bf8 ldur x9, [x29, #-0x48]
0x15be9c: 1f0109eb cmp x8, x9
0x15bea0: 01010054 b.ne #0x15bec0
0x15bea4: fd7b58a9 ldp x29, x30, [sp, #0x180]
0x15bea8: f44f57a9 ldp x20, x19, [sp, #0x170]
0x15beac: f65756a9 ldp x22, x21, [sp, #0x160]
0x15beb0: f85f55a9 ldp x24, x23, [sp, #0x150]
0x15beb4: fca340f9 ldr x28, [sp, #0x140]
0x15beb8: ff430691 add sp, sp, #0x190
0x15bebc: c0035fd6 ret 
0x15bec0: 80520094 bl #0x1708c0
0x15bec4: 684240f9 ldr x8, [x19, #0x80]
0x15bec8: f50300aa mov x21, x0
0x15becc: 480300b4 cbz x8, #0x15bf34
0x15bed0: 890240b9 ldr w9, [x20]
0x15bed4: 3f050071 cmp w9, #1
0x15bed8: ab020054 b.lt #0x15bf2c
0x15bedc: f7031faa mov x23, xzr
0x15bee0: 167977f8 ldr x22, [x8, x23, lsl #3]
0x15bee4: b60000b5 cbnz x22, #0x15bef8
0x15bee8: 0d000014 b #0x15bf1c
0x15beec: 684240f9 ldr x8, [x19, #0x80]
0x15bef0: 167977f8 ldr x22, [x8, x23, lsl #3]
0x15bef4: 560100b4 cbz x22, #0x15bf1c
0x15bef8: c00640f9 ldr x0, [x22, #8]
0x15befc: a00000b4 cbz x0, #0x15bf10
0x15bf00: 18a040f9 ldr x24, [x0, #0x140]
0x15bf04: ef4f0094 bl #0x16fec0
0x15bf08: e00318aa mov x0, x24
0x15bf0c: b8ffffb5 cbnz x24, #0x15bf00
0x15bf10: e00316aa mov x0, x22
0x15bf14: 7b4f0094 bl #0x16fd00
0x15bf18: 890240b9 ldr w9, [x20]
0x15bf1c: f7060091 add x23, x23, #1
0x15bf20: ffc229eb cmp x23, w9, sxtw
0x15bf24: 4bfeff54 b.lt #0x15beec
0x15bf28: 684240f9 ldr x8, [x19, #0x80]
0x15bf2c: e00308aa mov x0, x8
0x15bf30: e44f0094 bl #0x16fec0
0x15bf34: e00313aa mov x0, x19
0x15bf38: b6080094 bl #0x15e210
0x15bf3c: e00315aa mov x0, x21
0x15bf40: d0510094 bl #0x170680
0x15bf44: ff0306d1 sub sp, sp, #0x180
0x15bf48: fc5f14a9 stp x28, x23, [sp, #0x140]
0x15bf4c: f65715a9 stp x22, x21, [sp, #0x150]
0x15bf50: f44f16a9 stp x20, x19, [sp, #0x160]
0x15bf54: fd7b17a9 stp x29, x30, [sp, #0x170]
0x15bf58: fdc30591 add x29, sp, #0x170
0x15bf5c: 48d03bd5 mrs x8, tpidr_el0
0x15bf60: 081540f9 ldr x8, [x8, #0x28]
0x15bf64: f30300aa mov x19, x0
0x15bf68: a8831cf8 stur x8, [x29, #-0x38]
0x15bf6c: ec080094 bl #0x15e31c
0x15bf70: 694240f9 ldr x9, [x19, #0x80]
0x15bf74: 74e20191 add x20, x19, #0x78
0x15bf78: 290300b4 cbz x9, #0x15bfdc
0x15bf7c: 880240b9 ldr w8, [x20]
0x15bf80: 1f050071 cmp w8, #1
0x15bf84: cb020054 b.lt #0x15bfdc
0x15bf88: f6031faa mov x22, xzr
0x15bf8c: 357976f8 ldr x21, [x9, x22, lsl #3]
0x15bf90: b50000b5 cbnz x21, #0x15bfa4
0x15bf94: 0f000014 b #0x15bfd0
0x15bf98: 694240f9 ldr x9, [x19, #0x80]
0x15bf9c: 357976f8 ldr x21, [x9, x22, lsl #3]
0x15bfa0: 950100b4 cbz x21, #0x15bfd0
0x15bfa4: a00640f9 ldr x0, [x21, #8]
0x15bfa8: a00000b4 cbz x0, #0x15bfbc
0x15bfac: 17a040f9 ldr x23, [x0, #0x140]
0x15bfb0: c44f0094 bl #0x16fec0
0x15bfb4: e00317aa mov x0, x23
0x15bfb8: b7ffffb5 cbnz x23, #0x15bfac
0x15bfbc: e00315aa mov x0, x21
0x15bfc0: 504f0094 bl #0x16fd00
0x15bfc4: 684240f9 ldr x8, [x19, #0x80]
0x15bfc8: 1f7936f8 str xzr, [x8, x22, lsl #3]
0x15bfcc: 687a40b9 ldr w8, [x19, #0x78]
0x15bfd0: d6060091 add x22, x22, #1
0x15bfd4: dfc228eb cmp x22, w8, sxtw
0x15bfd8: 0bfeff54 b.lt #0x15bf98
0x15bfdc: 75220291 add x21, x19, #0x88
0x15bfe0: e00313aa mov x0, x19
0x15bfe4: e10315aa mov x1, x21
0x15bfe8: 7f7e00b9 str wzr, [x19, #0x7c]
0x15bfec: 2d090094 bl #0x15e4a0
0x15bff0: 1f040031 cmn w0, #1
0x15bff4: a0020054 b.eq #0x15c048
0x15bff8: 76020391 add x22, x19, #0xc0
0x15bffc: e8031faa mov x8, xzr
0x15c000: c96a6838 ldrb w9, [x22, x8]
0x15c004: 08050091 add x8, x8, #1
0x15c008: c9ffff35 cbnz w9, #0x15c000
0x15c00c: 1f0500f1 cmp x8, #1
0x15c010: 20010054 b.eq #0x15c034
0x15c014: e0030091 mov x0, sp
0x15c018: 02278052 mov w2, #0x138
0x15c01c: e10315aa mov x1, x21
0x15c020: f84e0094 bl #0x16fc00
0x15c024: e2030091 mov x2, sp
0x15c028: e00314aa mov x0, x20
0x15c02c: e10316aa mov x1, x22
0x15c030: e3bbfd97 bl #0xcafbc
0x15c034: e00313aa mov x0, x19
0x15c038: e10315aa mov x1, x21
0x15c03c: 19090094 bl #0x15e4a0
0x15c040: 1f040031 cmn w0, #1
0x15c044: c1fdff54 b.ne #0x15bffc
0x15c048: 48d03bd5 mrs x8, tpidr_el0
0x15c04c: 081540f9 ldr x8, [x8, #0x28]
0x15c050: a9835cf8 ldur x9, [x29, #-0x38]
0x15c054: 1f0109eb cmp x8, x9
0x15c058: e1000054 b.ne #0x15c074
0x15c05c: fd7b57a9 ldp x29, x30, [sp, #0x170]
0x15c060: f44f56a9 ldp x20, x19, [sp, #0x160]
0x15c064: f65755a9 ldp x22, x21, [sp, #0x150]
0x15c068: fc5f54a9 ldp x28, x23, [sp, #0x140]
0x15c06c: ff030691 add sp, sp, #0x180
0x15c070: c0035fd6 ret 
0x15c074: 13520094 bl #0x1708c0
0x15c078: 43000012 and w3, w2, #1
0x15c07c: 62fbffd0 adrp x2, #0xca000
0x15c080: 42d03e91 add x2, x2, #0xfb4
0x15c084: 01000014 b #0x15c088
0x15c088: fc6fbaa9 stp x28, x27, [sp, #-0x60]!
0x15c08c: fa6701a9 stp x26, x25, [sp, #0x10]
0x15c090: f85f02a9 stp x24, x23, [sp, #0x20]
0x15c094: f65703a9 stp x22, x21, [sp, #0x30]
0x15c098: f44f04a9 stp x20, x19, [sp, #0x40]
0x15c09c: fd7b05a9 stp x29, x30, [sp, #0x50]
0x15c0a0: fd430191 add x29, sp, #0x50
0x15c0a4: ff0b40d1 sub sp, sp, #2, lsl #12
0x15c0a8: ff030fd1 sub sp, sp, #0x3c0
0x15c0ac: f30308aa mov x19, x8
0x15c0b0: 48d03bd5 mrs x8, tpidr_el0
0x15c0b4: 081540f9 ldr x8, [x8, #0x28]
0x15c0b8: f40302aa mov x20, x2
0x15c0bc: f60301aa mov x22, x1
0x15c0c0: f50300aa mov x21, x0
0x15c0c4: 02278052 mov w2, #0x138
0x15c0c8: e00313aa mov x0, x19
0x15c0cc: e1031f2a mov w1, wzr
0x15c0d0: f703032a mov w23, w3
0x15c0d4: a8831af8 stur x8, [x29, #-0x58]
0x15c0d8: 02510094 bl #0x1704e0
0x15c0dc: e0074091 add x0, sp, #1, lsl #12
0x15c0e0: 00e00e91 add x0, x0, #0x3b8
0x15c0e4: e2031432 mov w2, #0x1000
0x15c0e8: f8074091 add x24, sp, #1, lsl #12
0x15c0ec: e1031f2a mov w1, wzr
0x15c0f0: 18e30e91 add x24, x24, #0x3b8
0x15c0f4: fb500094 bl #0x1704e0
0x15c0f8: e0e30e91 add x0, sp, #0x3b8
0x15c0fc: e2031432 mov w2, #0x1000
0x15c100: e1031f2a mov w1, wzr
0x15c104: f7500094 bl #0x1704e0
0x15c108: e2074091 add x2, sp, #1, lsl #12
0x15c10c: 42e00e91 add x2, x2, #0x3b8
0x15c110: e00315aa mov x0, x21
0x15c114: e10316aa mov x1, x22
0x15c118: d2000094 bl #0x15c460
0x15c11c: 170c0036 tbz w23, #0, #0x15c29c
0x15c120: 090700d1 sub x9, x24, #1
0x15c124: 281d4038 ldrb w8, [x9, #1]!
0x15c128: e8ffff35 cbnz w8, #0x15c124
0x15c12c: a87e40b9 ldr w8, [x21, #0x7c]
0x15c130: 1f050071 cmp w8, #1
0x15c134: 8b170054 b.lt #0x15c424
0x15c138: ea074091 add x10, sp, #1, lsl #12
0x15c13c: 4ae10e91 add x10, x10, #0x3b8
0x15c140: 29010a4b sub w9, w9, w10
0x15c144: ebe30991 add x11, sp, #0x278
0x15c148: 397d4093 sxtw x25, w9
0x15c14c: f7031f2a mov w23, wzr
0x15c150: f8030032 mov w24, #1
0x15c154: 76e10091 add x22, x11, #0x38
0x15c158: fa0319cb neg x26, x25
0x15c15c: fb030032 mov w27, #1
0x15c160: 1f01176b cmp w8, w23
0x15c164: 2d040054 b.le #0x15c1e8
0x15c168: a97a80b9 ldrsw x9, [x21, #0x78]
0x15c16c: ec031f2a mov w12, wzr
0x15c170: eb031faa mov x11, xzr
0x15c174: e8030c2a mov w8, w12
0x15c178: 6c7d4093 sxtw x12, w11
0x15c17c: 9f0109eb cmp x12, x9
0x15c180: 4a030054 b.ge #0x15c1e8
0x15c184: aa4240f9 ldr x10, [x21, #0x80]
0x15c188: 8b050091 add x11, x12, #1
0x15c18c: 4a796cf8 ldr x10, [x10, x12, lsl #3]
0x15c190: ec030baa mov x12, x11
0x15c194: 4affffb4 cbz x10, #0x15c17c
0x15c198: 4d0140b9 ldr w13, [x10]
0x15c19c: ac01080b add w12, w13, w8
0x15c1a0: 9f01176b cmp w12, w23
0x15c1a4: 8dfeff54 b.le #0x15c174
0x15c1a8: e902084b sub w9, w23, w8
0x15c1ac: bf01096b cmp w13, w9
0x15c1b0: 0d010054 b.le #0x15c1d0
0x15c1b4: 490540f9 ldr x9, [x10, #8]
0x15c1b8: c90000b4 cbz x9, #0x15c1d0
0x15c1bc: 6803084b sub w8, w27, w8
0x15c1c0: 08050051 sub w8, w8, #1
0x15c1c4: 68020034 cbz w8, #0x15c210
0x15c1c8: 29a140f9 ldr x9, [x9, #0x140]
0x15c1cc: a9ffffb5 cbnz x9, #0x15c1c0
0x15c1d0: e0e30991 add x0, sp, #0x278
0x15c1d4: 02288052 mov w2, #0x140
0x15c1d8: e1031f2a mov w1, wzr
0x15c1dc: c1500094 bl #0x1704e0
0x15c1e0: ffc30e39 strb wzr, [sp, #0x3b0]
0x15c1e4: 05000014 b #0x15c1f8
0x15c1e8: e0e30991 add x0, sp, #0x278
0x15c1ec: 02288052 mov w2, #0x140
0x15c1f0: e1031f2a mov w1, wzr
0x15c1f4: bb500094 bl #0x1704e0
0x15c1f8: a87e40b9 ldr w8, [x21, #0x7c]
0x15c1fc: f7060011 add w23, w23, #1
0x15c200: 7b070011 add w27, w27, #1
0x15c204: ff02086b cmp w23, w8
0x15c208: cbfaff54 b.lt #0x15c160
0x15c20c: 86000014 b #0x15c424
0x15c210: 21210091 add x1, x9, #8
0x15c214: e0e30991 add x0, sp, #0x278
0x15c218: 02278052 mov w2, #0x138
0x15c21c: 794e0094 bl #0x16fc00
0x15c220: e0e30e91 add x0, sp, #0x3b8
0x15c224: e2031432 mov w2, #0x1000
0x15c228: e1031f2a mov w1, wzr
0x15c22c: f8c30e39 strb w24, [sp, #0x3b0]
0x15c230: ac500094 bl #0x1704e0
0x15c234: e2e30e91 add x2, sp, #0x3b8
0x15c238: e00315aa mov x0, x21
0x15c23c: e10316aa mov x1, x22
0x15c240: 88000094 bl #0x15c460
0x15c244: d90100b4 cbz x25, #0x15c27c
0x15c248: e9074091 add x9, sp, #1, lsl #12
0x15c24c: e8e30e91 add x8, sp, #0x3b8
0x15c250: 29e10e91 add x9, x9, #0x3b8
0x15c254: ea031aaa mov x10, x26
0x15c258: 0b014039 ldrb w11, [x8]
0x15c25c: 2c014039 ldrb w12, [x9]
0x15c260: 7f010c6b cmp w11, w12
0x15c264: a1fcff54 b.ne #0x15c1f8
0x15c268: ab000034 cbz w11, #0x15c27c
0x15c26c: 08050091 add x8, x8, #1
0x15c270: 4a050091 add x10, x10, #1
0x15c274: 29050091 add x9, x9, #1
0x15c278: 0affffb5 cbnz x10, #0x15c258
0x15c27c: e0030591 add x0, sp, #0x140
0x15c280: e1e30991 add x1, sp, #0x278
0x15c284: 02278052 mov w2, #0x138
0x15c288: 5e4e0094 bl #0x16fc00
0x15c28c: e0030591 add x0, sp, #0x140
0x15c290: 80023fd6 blr x20
0x15c294: 20fb0736 tbz w0, #0, #0x15c1f8
0x15c298: 5f000014 b #0x15c414
0x15c29c: a87e40b9 ldr w8, [x21, #0x7c]
0x15c2a0: 1f050071 cmp w8, #1
0x15c2a4: 0b0c0054 b.lt #0x15c424
0x15c2a8: e9e30991 add x9, sp, #0x278
0x15c2ac: f8031f2a mov w24, wzr
0x15c2b0: d9060091 add x25, x22, #1
0x15c2b4: fa030032 mov w26, #1
0x15c2b8: 37e10091 add x23, x9, #0x38
0x15c2bc: fb030032 mov w27, #1
0x15c2c0: 1f01186b cmp w8, w24
0x15c2c4: 2d040054 b.le #0x15c348
0x15c2c8: a97a80b9 ldrsw x9, [x21, #0x78]
0x15c2cc: ec031f2a mov w12, wzr
0x15c2d0: eb031faa mov x11, xzr
0x15c2d4: e8030c2a mov w8, w12
0x15c2d8: 6c7d4093 sxtw x12, w11
0x15c2dc: 9f0109eb cmp x12, x9
0x15c2e0: 4a030054 b.ge #0x15c348
0x15c2e4: aa4240f9 ldr x10, [x21, #0x80]
0x15c2e8: 8b050091 add x11, x12, #1
0x15c2ec: 4a796cf8 ldr x10, [x10, x12, lsl #3]
0x15c2f0: ec030baa mov x12, x11
0x15c2f4: 4affffb4 cbz x10, #0x15c2dc
0x15c2f8: 4d0140b9 ldr w13, [x10]
0x15c2fc: ac01080b add w12, w13, w8
0x15c300: 9f01186b cmp w12, w24
0x15c304: 8dfeff54 b.le #0x15c2d4
0x15c308: 0903084b sub w9, w24, w8
0x15c30c: bf01096b cmp w13, w9
0x15c310: 0d010054 b.le #0x15c330
0x15c314: 490540f9 ldr x9, [x10, #8]
0x15c318: c90000b4 cbz x9, #0x15c330
0x15c31c: 6803084b sub w8, w27, w8
0x15c320: 08050051 sub w8, w8, #1
0x15c324: 68020034 cbz w8, #0x15c370
0x15c328: 29a140f9 ldr x9, [x9, #0x140]
0x15c32c: a9ffffb5 cbnz x9, #0x15c320
0x15c330: e0e30991 add x0, sp, #0x278
0x15c334: 02288052 mov w2, #0x140
0x15c338: e1031f2a mov w1, wzr
0x15c33c: 69500094 bl #0x1704e0
0x15c340: ffc30e39 strb wzr, [sp, #0x3b0]
0x15c344: 05000014 b #0x15c358
0x15c348: e0e30991 add x0, sp, #0x278
0x15c34c: 02288052 mov w2, #0x140
0x15c350: e1031f2a mov w1, wzr
0x15c354: 63500094 bl #0x1704e0
0x15c358: a87e40b9 ldr w8, [x21, #0x7c]
0x15c35c: 18070011 add w24, w24, #1
0x15c360: 7b070011 add w27, w27, #1
0x15c364: 1f03086b cmp w24, w8
0x15c368: cbfaff54 b.lt #0x15c2c0
0x15c36c: 2e000014 b #0x15c424
0x15c370: 21210091 add x1, x9, #8
0x15c374: e0e30991 add x0, sp, #0x278
0x15c378: 02278052 mov w2, #0x138
0x15c37c: 214e0094 bl #0x16fc00
0x15c380: e0e30e91 add x0, sp, #0x3b8
0x15c384: e2031432 mov w2, #0x1000
0x15c388: e1031f2a mov w1, wzr
0x15c38c: fac30e39 strb w26, [sp, #0x3b0]
0x15c390: 54500094 bl #0x1704e0
0x15c394: e2e30e91 add x2, sp, #0x3b8
0x15c398: e00315aa mov x0, x21
0x15c39c: e10317aa mov x1, x23
0x15c3a0: 30000094 bl #0x15c460
0x15c3a4: c8024039 ldrb w8, [x22]
0x15c3a8: 88020034 cbz w8, #0x15c3f8
0x15c3ac: ea0316aa mov x10, x22
0x15c3b0: 491d4038 ldrb w9, [x10, #1]!
0x15c3b4: e9ffff35 cbnz w9, #0x15c3b0
0x15c3b8: e9e30e91 add x9, sp, #0x3b8
0x15c3bc: 4a0119cb sub x10, x10, x25
0x15c3c0: 2b154038 ldrb w11, [x9], #1
0x15c3c4: abfcff34 cbz w11, #0x15c358
0x15c3c8: 7f01086b cmp w11, w8
0x15c3cc: a1ffff54 b.ne #0x15c3c0
0x15c3d0: 4a0100b4 cbz x10, #0x15c3f8
0x15c3d4: eb031faa mov x11, xzr
0x15c3d8: 2c696b38 ldrb w12, [x9, x11]
0x15c3dc: 2d6b6b38 ldrb w13, [x25, x11]
0x15c3e0: 9f010d6b cmp w12, w13
0x15c3e4: e1feff54 b.ne #0x15c3c0
0x15c3e8: 8c000034 cbz w12, #0x15c3f8
0x15c3ec: 6b050091 add x11, x11, #1
0x15c3f0: 5f010beb cmp x10, x11
0x15c3f4: 21ffff54 b.ne #0x15c3d8
0x15c3f8: e0230091 add x0, sp, #8
0x15c3fc: 02278052 mov w2, #0x138
0x15c400: e10313aa mov x1, x19
0x15c404: ff4d0094 bl #0x16fc00
0x15c408: e0230091 add x0, sp, #8
0x15c40c: 80023fd6 blr x20
0x15c410: 40fa0736 tbz w0, #0, #0x15c358
0x15c414: e1e30991 add x1, sp, #0x278
0x15c418: 02278052 mov w2, #0x138
0x15c41c: e00313aa mov x0, x19
0x15c420: f84d0094 bl #0x16fc00
0x15c424: 48d03bd5 mrs x8, tpidr_el0
0x15c428: 081540f9 ldr x8, [x8, #0x28]
0x15c42c: a9835af8 ldur x9, [x29, #-0x58]
0x15c430: 1f0109eb cmp x8, x9
0x15c434: 41010054 b.ne #0x15c45c
0x15c438: ff0b4091 add sp, sp, #2, lsl #12
0x15c43c: ff030f91 add sp, sp, #0x3c0
0x15c440: fd7b45a9 ldp x29, x30, [sp, #0x50]
0x15c444: f44f44a9 ldp x20, x19, [sp, #0x40]
0x15c448: f65743a9 ldp x22, x21, [sp, #0x30]
0x15c44c: f85f42a9 ldp x24, x23, [sp, #0x20]
0x15c450: fa6741a9 ldp x26, x25, [sp, #0x10]
0x15c454: fc6fc6a8 ldp x28, x27, [sp], #0x60
0x15c458: c0035fd6 ret 
0x15c45c: 19510094 bl #0x1708c0
0x15c460: fc0f1cf8 str x28, [sp, #-0x40]!
0x15c464: f65701a9 stp x22, x21, [sp, #0x10]
0x15c468: f44f02a9 stp x20, x19, [sp, #0x20]
0x15c46c: fd7b03a9 stp x29, x30, [sp, #0x30]
0x15c470: fdc30091 add x29, sp, #0x30
0x15c474: ff031dd1 sub sp, sp, #0x740
0x15c478: 48d03bd5 mrs x8, tpidr_el0
0x15c47c: 081540f9 ldr x8, [x8, #0x28]
0x15c480: 550400b0 adrp x21, #0x1e5000
0x15c484: 076abc52 mov w7, #-0x1cb00000
0x15c488: 89208052 mov w9, #0x104
0x15c48c: a8831cf8 stur x8, [x29, #-0x38]
0x15c490: b59e46f9 ldr x21, [x21, #0xd38]
0x15c494: 600c8092 mov x0, #-0x64
0x15c498: 83208052 mov w3, #0x104
0x15c49c: e40b0032 mov w4, #7
0x15c4a0: a85240f9 ldr x8, [x21, #0xa0]
0x15c4a4: e50b1f32 mov w5, #0xe
0x15c4a8: e6c31891 add x6, sp, #0x630
0x15c4ac: 67e59e72 movk w7, #0xf72b
0x15c4b0: f40302aa mov x20, x2
0x15c4b4: f30301aa mov x19, x1
0x15c4b8: e91b03f9 str x9, [sp, #0x630]
0x15c4bc: 00013fd6 blr x8
0x15c4c0: 1f044031 cmn w0, #1, lsl #12
0x15c4c4: 48030054 b.hi #0x15c52c
0x15c4c8: e8031faa mov x8, xzr
0x15c4cc: 896a6838 ldrb w9, [x20, x8]
0x15c4d0: 08050091 add x8, x8, #1
0x15c4d4: c9ffff35 cbnz w9, #0x15c4cc
0x15c4d8: 1f0500f1 cmp x8, #1
0x15c4dc: 21010054 b.ne #0x15c500
0x15c4e0: 68024039 ldrb w8, [x19]
0x15c4e4: 88020039 strb w8, [x20]
0x15c4e8: c8000034 cbz w8, #0x15c500
0x15c4ec: 88060091 add x8, x20, #1
0x15c4f0: 69060091 add x9, x19, #1
0x15c4f4: 2a154038 ldrb w10, [x9], #1
0x15c4f8: 0a150038 strb w10, [x8], #1
0x15c4fc: caffff35 cbnz w10, #0x15c4f4
0x15c500: 48d03bd5 mrs x8, tpidr_el0
0x15c504: 081540f9 ldr x8, [x8, #0x28]
0x15c508: a9835cf8 ldur x9, [x29, #-0x38]
0x15c50c: 1f0109eb cmp x8, x9
0x15c510: 01070054 b.ne #0x15c5f0
0x15c514: ff031d91 add sp, sp, #0x740
0x15c518: fd7b43a9 ldp x29, x30, [sp, #0x30]
0x15c51c: f44f42a9 ldp x20, x19, [sp, #0x20]
0x15c520: f65741a9 ldp x22, x21, [sp, #0x10]
0x15c524: fc0744f8 ldr x28, [sp], #0x40
0x15c528: c0035fd6 ret 
0x15c52c: f603004b neg w22, w0
0x15c530: 84500094 bl #0x170740
0x15c534: 160000b9 str w22, [x0]
0x15c538: e0c31891 add x0, sp, #0x630
0x15c53c: 82208052 mov w2, #0x104
0x15c540: e1031f2a mov w1, wzr
0x15c544: 96208052 mov w22, #0x104
0x15c548: e64f0094 bl #0x1704e0
0x15c54c: e0b31491 add x0, sp, #0x52c
0x15c550: 82208052 mov w2, #0x104
0x15c554: e1031f2a mov w1, wzr
0x15c558: e24f0094 bl #0x1704e0
0x15c55c: e0a31091 add x0, sp, #0x428
0x15c560: 82208052 mov w2, #0x104
0x15c564: e1031f2a mov w1, wzr
0x15c568: de4f0094 bl #0x1704e0
0x15c56c: e2c31891 add x2, sp, #0x630
0x15c570: e3b31491 add x3, sp, #0x52c
0x15c574: e10313aa mov x1, x19
0x15c578: 3e010094 bl #0x15ca70
0x15c57c: a85240f9 ldr x8, [x21, #0xa0]
0x15c580: 076abc52 mov w7, #-0x1cb00000
```

## Runtime disassembly `matcher`

```asm
0x15c778: fc0f1af8 str x28, [sp, #-0x60]!
0x15c77c: fa6701a9 stp x26, x25, [sp, #0x10]
0x15c780: f85f02a9 stp x24, x23, [sp, #0x20]
0x15c784: f65703a9 stp x22, x21, [sp, #0x30]
0x15c788: f44f04a9 stp x20, x19, [sp, #0x40]
0x15c78c: fd7b05a9 stp x29, x30, [sp, #0x50]
0x15c790: fd430191 add x29, sp, #0x50
0x15c794: ff0740d1 sub sp, sp, #1, lsl #12
0x15c798: ff4305d1 sub sp, sp, #0x150
0x15c79c: 48d03bd5 mrs x8, tpidr_el0
0x15c7a0: 081540f9 ldr x8, [x8, #0x28]
0x15c7a4: f603022a mov w22, w2
0x15c7a8: f50301aa mov x21, x1
0x15c7ac: f40300aa mov x20, x0
0x15c7b0: e0230591 add x0, sp, #0x148
0x15c7b4: e2031432 mov w2, #0x1000
0x15c7b8: e1031f2a mov w1, wzr
0x15c7bc: f30303aa mov x19, x3
0x15c7c0: a8831af8 stur x8, [x29, #-0x58]
0x15c7c4: 474f0094 bl #0x1704e0
0x15c7c8: 36040036 tbz w22, #0, #0x15c84c
0x15c7cc: a80600d1 sub x8, x21, #1
0x15c7d0: 091d4038 ldrb w9, [x8, #1]!
0x15c7d4: e9ffff35 cbnz w9, #0x15c7d0
0x15c7d8: 0901154b sub w9, w8, w21
0x15c7dc: 283d0012 and w8, w9, #0xffff
0x15c7e0: 28010034 cbz w8, #0x15c804
0x15c7e4: e8031f2a mov w8, wzr
0x15c7e8: aa164038 ldrb w10, [x21], #1
0x15c7ec: 0c691b53 lsl w12, w8, #5
0x15c7f0: 29050051 sub w9, w9, #1
0x15c7f4: 8801084b sub w8, w12, w8
0x15c7f8: 2b3d0012 and w11, w9, #0xffff
0x15c7fc: 4801080b add w8, w10, w8
0x15c800: 4bffff35 cbnz w11, #0x15c7e8
0x15c804: 897a40b9 ldr w9, [x20, #0x78]
0x15c808: 8a4240f9 ldr x10, [x20, #0x80]
0x15c80c: 29050051 sub w9, w9, #1
0x15c810: 2901080a and w9, w9, w8
0x15c814: 49d969f8 ldr x9, [x10, w9, sxtw #3]
0x15c818: 090100b4 cbz x9, #0x15c838
0x15c81c: 290540f9 ldr x9, [x9, #8]
0x15c820: c90000b4 cbz x9, #0x15c838
0x15c824: 2a0140b9 ldr w10, [x9]
0x15c828: 5f01086b cmp w10, w8
0x15c82c: 200f0054 b.eq #0x15ca10
0x15c830: 29a140f9 ldr x9, [x9, #0x140]
0x15c834: 89ffffb5 cbnz x9, #0x15c824
0x15c838: e0230091 add x0, sp, #8
0x15c83c: 02288052 mov w2, #0x140
0x15c840: e1031f2a mov w1, wzr
0x15c844: 274f0094 bl #0x1704e0
0x15c848: 63000014 b #0x15c9d4
0x15c84c: 887e40b9 ldr w8, [x20, #0x7c]
0x15c850: 1f050071 cmp w8, #1
0x15c854: 0b0c0054 b.lt #0x15c9d4
0x15c858: e9230091 add x9, sp, #8
0x15c85c: f7031f2a mov w23, wzr
0x15c860: b8060091 add x24, x21, #1
0x15c864: f9030032 mov w25, #1
0x15c868: 36e10091 add x22, x9, #0x38
0x15c86c: fa030032 mov w26, #1
0x15c870: 1f01176b cmp w8, w23
0x15c874: 2d040054 b.le #0x15c8f8
0x15c878: 897a80b9 ldrsw x9, [x20, #0x78]
0x15c87c: ec031f2a mov w12, wzr
0x15c880: eb031faa mov x11, xzr
0x15c884: e8030c2a mov w8, w12
0x15c888: 6c7d4093 sxtw x12, w11
0x15c88c: 9f0109eb cmp x12, x9
0x15c890: 4a030054 b.ge #0x15c8f8
0x15c894: 8a4240f9 ldr x10, [x20, #0x80]
0x15c898: 8b050091 add x11, x12, #1
0x15c89c: 4a796cf8 ldr x10, [x10, x12, lsl #3]
0x15c8a0: ec030baa mov x12, x11
0x15c8a4: 4affffb4 cbz x10, #0x15c88c
0x15c8a8: 4d0140b9 ldr w13, [x10]
0x15c8ac: ac01080b add w12, w13, w8
0x15c8b0: 9f01176b cmp w12, w23
0x15c8b4: 8dfeff54 b.le #0x15c884
0x15c8b8: e902084b sub w9, w23, w8
0x15c8bc: bf01096b cmp w13, w9
0x15c8c0: 0d010054 b.le #0x15c8e0
0x15c8c4: 490540f9 ldr x9, [x10, #8]
0x15c8c8: c90000b4 cbz x9, #0x15c8e0
0x15c8cc: 4803084b sub w8, w26, w8
0x15c8d0: 08050051 sub w8, w8, #1
0x15c8d4: 68020034 cbz w8, #0x15c920
0x15c8d8: 29a140f9 ldr x9, [x9, #0x140]
0x15c8dc: a9ffffb5 cbnz x9, #0x15c8d0
0x15c8e0: e0230091 add x0, sp, #8
0x15c8e4: 02288052 mov w2, #0x140
0x15c8e8: e1031f2a mov w1, wzr
0x15c8ec: fd4e0094 bl #0x1704e0
0x15c8f0: ff030539 strb wzr, [sp, #0x140]
0x15c8f4: 05000014 b #0x15c908
0x15c8f8: e0230091 add x0, sp, #8
0x15c8fc: 02288052 mov w2, #0x140
0x15c900: e1031f2a mov w1, wzr
0x15c904: f74e0094 bl #0x1704e0
0x15c908: 887e40b9 ldr w8, [x20, #0x7c]
0x15c90c: f7060011 add w23, w23, #1
0x15c910: 5a070011 add w26, w26, #1
0x15c914: ff02086b cmp w23, w8
0x15c918: cbfaff54 b.lt #0x15c870
0x15c91c: 2e000014 b #0x15c9d4
0x15c920: 21210091 add x1, x9, #8
0x15c924: e0230091 add x0, sp, #8
0x15c928: 02278052 mov w2, #0x138
0x15c92c: b54c0094 bl #0x16fc00
0x15c930: e0230591 add x0, sp, #0x148
0x15c934: e2031432 mov w2, #0x1000
0x15c938: e1031f2a mov w1, wzr
0x15c93c: f9030539 strb w25, [sp, #0x140]
0x15c940: e84e0094 bl #0x1704e0
0x15c944: e2230591 add x2, sp, #0x148
0x15c948: e00314aa mov x0, x20
0x15c94c: e10316aa mov x1, x22
0x15c950: c4feff97 bl #0x15c460
0x15c954: a8024039 ldrb w8, [x21]
0x15c958: 88020034 cbz w8, #0x15c9a8
0x15c95c: ea0315aa mov x10, x21
0x15c960: 491d4038 ldrb w9, [x10, #1]!
0x15c964: e9ffff35 cbnz w9, #0x15c960
0x15c968: e9230591 add x9, sp, #0x148
0x15c96c: 4a0118cb sub x10, x10, x24
0x15c970: 2b154038 ldrb w11, [x9], #1
0x15c974: abfcff34 cbz w11, #0x15c908
0x15c978: 7f01086b cmp w11, w8
0x15c97c: a1ffff54 b.ne #0x15c970
0x15c980: 4a0100b4 cbz x10, #0x15c9a8
0x15c984: eb031faa mov x11, xzr
0x15c988: 2c696b38 ldrb w12, [x9, x11]
0x15c98c: 0d6b6b38 ldrb w13, [x24, x11]
0x15c990: 9f010d6b cmp w12, w13
0x15c994: e1feff54 b.ne #0x15c970
0x15c998: 8c000034 cbz w12, #0x15c9a8
0x15c99c: 6b050091 add x11, x11, #1
0x15c9a0: 5f010beb cmp x10, x11
0x15c9a4: 21ffff54 b.ne #0x15c988
0x15c9a8: f30500b4 cbz x19, #0x15ca64
0x15c9ac: e8234539 ldrb w8, [sp, #0x148]
0x15c9b0: 68020039 strb w8, [x19]
0x15c9b4: 88050034 cbz w8, #0x15ca64
0x15c9b8: e9230591 add x9, sp, #0x148
0x15c9bc: 68060091 add x8, x19, #1
0x15c9c0: 290140b2 orr x9, x9, #1
0x15c9c4: 2a154038 ldrb w10, [x9], #1
0x15c9c8: 0a150038 strb w10, [x8], #1
0x15c9cc: caffff35 cbnz w10, #0x15c9c4
0x15c9d0: 25000014 b #0x15ca64
0x15c9d4: e0031f2a mov w0, wzr
0x15c9d8: 48d03bd5 mrs x8, tpidr_el0
0x15c9dc: 081540f9 ldr x8, [x8, #0x28]
0x15c9e0: a9835af8 ldur x9, [x29, #-0x58]
0x15c9e4: 1f0109eb cmp x8, x9
0x15c9e8: 21040054 b.ne #0x15ca6c
0x15c9ec: ff074091 add sp, sp, #1, lsl #12
0x15c9f0: ff430591 add sp, sp, #0x150
0x15c9f4: fd7b45a9 ldp x29, x30, [sp, #0x50]
0x15c9f8: f44f44a9 ldp x20, x19, [sp, #0x40]
0x15c9fc: f65743a9 ldp x22, x21, [sp, #0x30]
0x15ca00: f85f42a9 ldp x24, x23, [sp, #0x20]
0x15ca04: fa6741a9 ldp x26, x25, [sp, #0x10]
0x15ca08: fc0746f8 ldr x28, [sp], #0x60
0x15ca0c: c0035fd6 ret 
0x15ca10: 21210091 add x1, x9, #8
0x15ca14: e0230091 add x0, sp, #8
0x15ca18: 02278052 mov w2, #0x138
0x15ca1c: f5230091 add x21, sp, #8
0x15ca20: 784c0094 bl #0x16fc00
0x15ca24: e8030032 mov w8, #1
0x15ca28: e8030539 strb w8, [sp, #0x140]
0x15ca2c: d30100b4 cbz x19, #0x15ca64
0x15ca30: a1e20091 add x1, x21, #0x38
0x15ca34: e2230591 add x2, sp, #0x148
0x15ca38: e00314aa mov x0, x20
0x15ca3c: f5230591 add x21, sp, #0x148
0x15ca40: 88feff97 bl #0x15c460
0x15ca44: e8234539 ldrb w8, [sp, #0x148]
0x15ca48: 68020039 strb w8, [x19]
0x15ca4c: c8000034 cbz w8, #0x15ca64
0x15ca50: 68060091 add x8, x19, #1
0x15ca54: a90240b2 orr x9, x21, #1
0x15ca58: 2a154038 ldrb w10, [x9], #1
0x15ca5c: 0a150038 strb w10, [x8], #1
0x15ca60: caffff35 cbnz w10, #0x15ca58
0x15ca64: e0030032 mov w0, #1
0x15ca68: dcffff17 b #0x15c9d8
0x15ca6c: 954f0094 bl #0x1708c0
0x15ca70: ffc305d1 sub sp, sp, #0x170
0x15ca74: fc9b00f9 str x28, [sp, #0x130]
0x15ca78: f65714a9 stp x22, x21, [sp, #0x140]
0x15ca7c: f44f15a9 stp x20, x19, [sp, #0x150]
0x15ca80: fd7b16a9 stp x29, x30, [sp, #0x160]
0x15ca84: fd830591 add x29, sp, #0x160
0x15ca88: 48d03bd5 mrs x8, tpidr_el0
0x15ca8c: 081540f9 ldr x8, [x8, #0x28]
0x15ca90: f30303aa mov x19, x3
0x15ca94: f40302aa mov x20, x2
0x15ca98: a8831cf8 stur x8, [x29, #-0x38]
0x15ca9c: e0430091 add x0, sp, #0x10
0x15caa0: e2830091 add x2, sp, #0x20
0x15caa4: b5aafe97 bl #0x107578
0x15caa8: c10000b0 adrp x1, #0x175000
0x15caac: 21101391 add x1, x1, #0x4c4
0x15cab0: e0430091 add x0, sp, #0x10
0x15cab4: 02008092 mov x2, #-1
0x15cab8: e3030032 mov w3, #1
0x15cabc: 98affe97 bl #0x10891c
0x15cac0: f50300aa mov x21, x0
0x15cac4: bf0600b1 cmn x21, #1
0x15cac8: a00a0054 b.eq #0x15cc1c
0x15cacc: e0830091 add x0, sp, #0x20
0x15cad0: 82208052 mov w2, #0x104
0x15cad4: e1031f2a mov w1, wzr
0x15cad8: 824e0094 bl #0x1704e0
0x15cadc: e80b40f9 ldr x8, [sp, #0x10]
0x15cae0: a2060091 add x2, x21, #1
0x15cae4: 03815ef8 ldur x3, [x8, #-0x18]
0x15cae8: 7f0002eb cmp x3, x2
0x15caec: 63120054 b.lo #0x15cd38
0x15caf0: e0230091 add x0, sp, #8
0x15caf4: e1430091 add x1, sp, #0x10
0x15caf8: 03008092 mov x3, #-1
0x15cafc: 92a9fe97 bl #0x107144
0x15cb00: e80740f9 ldr x8, [sp, #8]
0x15cb04: 09014039 ldrb w9, [x8]
0x15cb08: e9830039 strb w9, [sp, #0x20]
0x15cb0c: 09010034 cbz w9, #0x15cb2c
0x15cb10: e9830091 add x9, sp, #0x20
0x15cb14: 290140b2 orr x9, x9, #1
0x15cb18: 08050091 add x8, x8, #1
0x15cb1c: 0a154038 ldrb w10, [x8], #1
0x15cb20: 2a150038 strb w10, [x9], #1
0x15cb24: caffff35 cbnz w10, #0x15cb1c
0x15cb28: e80740f9 ldr x8, [sp, #8]
0x15cb2c: 560400d0 adrp x22, #0x1e6000
0x15cb30: d61640f9 ldr x22, [x22, #0x28]
0x15cb34: 006100d1 sub x0, x8, #0x18
0x15cb38: 1f0016eb cmp x0, x22
0x15cb3c: 810a0054 b.ne #0x15cc8c
0x15cb40: e8031faa mov x8, xzr
0x15cb44: e9830091 add x9, sp, #0x20
0x15cb48: 2a696838 ldrb w10, [x9, x8]
0x15cb4c: 08050091 add x8, x8, #1
0x15cb50: caffff35 cbnz w10, #0x15cb48
0x15cb54: 940100b4 cbz x20, #0x15cb84
0x15cb58: 1f0500f1 cmp x8, #1
0x15cb5c: 40010054 b.eq #0x15cb84
0x15cb60: e8834039 ldrb w8, [sp, #0x20]
0x15cb64: 88020039 strb w8, [x20]
0x15cb68: e8000034 cbz w8, #0x15cb84
0x15cb6c: e9830091 add x9, sp, #0x20
0x15cb70: 88060091 add x8, x20, #1
0x15cb74: 290140b2 orr x9, x9, #1
0x15cb78: 2a154038 ldrb w10, [x9], #1
0x15cb7c: 0a150038 strb w10, [x8], #1
0x15cb80: caffff35 cbnz w10, #0x15cb78
0x15cb84: e0230091 add x0, sp, #8
0x15cb88: e1430091 add x1, sp, #0x10
0x15cb8c: e2031faa mov x2, xzr
0x15cb90: e30315aa mov x3, x21
0x15cb94: 6ca9fe97 bl #0x107144
0x15cb98: e80740f9 ldr x8, [sp, #8]
0x15cb9c: 09014039 ldrb w9, [x8]
0x15cba0: e9830039 strb w9, [sp, #0x20]
0x15cba4: 09010034 cbz w9, #0x15cbc4
0x15cba8: e9830091 add x9, sp, #0x20
0x15cbac: 290140b2 orr x9, x9, #1
0x15cbb0: 08050091 add x8, x8, #1
0x15cbb4: 0a154038 ldrb w10, [x8], #1
0x15cbb8: 2a150038 strb w10, [x9], #1
0x15cbbc: caffff35 cbnz w10, #0x15cbb4
0x15cbc0: e80740f9 ldr x8, [sp, #8]
0x15cbc4: 006100d1 sub x0, x8, #0x18
0x15cbc8: 1f0016eb cmp x0, x22
0x15cbcc: 21070054 b.ne #0x15ccb0
0x15cbd0: e8031faa mov x8, xzr
0x15cbd4: e9830091 add x9, sp, #0x20
0x15cbd8: 2a696838 ldrb w10, [x9, x8]
0x15cbdc: 08050091 add x8, x8, #1
0x15cbe0: caffff35 cbnz w10, #0x15cbd8
0x15cbe4: 930100b4 cbz x19, #0x15cc14
0x15cbe8: 1f0500f1 cmp x8, #1
0x15cbec: 40010054 b.eq #0x15cc14
0x15cbf0: e8834039 ldrb w8, [sp, #0x20]
0x15cbf4: 68020039 strb w8, [x19]
0x15cbf8: e8000034 cbz w8, #0x15cc14
0x15cbfc: e9830091 add x9, sp, #0x20
0x15cc00: 68060091 add x8, x19, #1
0x15cc04: 290140b2 orr x9, x9, #1
0x15cc08: 2a154038 ldrb w10, [x9], #1
0x15cc0c: 0a150038 strb w10, [x8], #1
0x15cc10: caffff35 cbnz w10, #0x15cc08
0x15cc14: f3030032 mov w19, #1
0x15cc18: 02000014 b #0x15cc20
0x15cc1c: f3031f2a mov w19, wzr
0x15cc20: e80b40f9 ldr x8, [sp, #0x10]
0x15cc24: 490400d0 adrp x9, #0x1e6000
0x15cc28: 291540f9 ldr x9, [x9, #0x28]
0x15cc2c: 006100d1 sub x0, x8, #0x18
0x15cc30: 1f0009eb cmp x0, x9
0x15cc34: a1010054 b.ne #0x15cc68
0x15cc38: 48d03bd5 mrs x8, tpidr_el0
0x15cc3c: 081540f9 ldr x8, [x8, #0x28]
0x15cc40: a9835cf8 ldur x9, [x29, #-0x38]
0x15cc44: 1f0109eb cmp x8, x9
0x15cc48: 61070054 b.ne #0x15cd34
0x15cc4c: e003132a mov w0, w19
0x15cc50: fd7b56a9 ldp x29, x30, [sp, #0x160]
0x15cc54: f44f55a9 ldp x20, x19, [sp, #0x150]
0x15cc58: f65754a9 ldp x22, x21, [sp, #0x140]
0x15cc5c: fc9b40f9 ldr x28, [sp, #0x130]
0x15cc60: ffc30591 add sp, sp, #0x170
0x15cc64: c0035fd6 ret 
0x15cc68: 490400b0 adrp x9, #0x1e5000
0x15cc6c: 293946f9 ldr x9, [x9, #0xc70]
0x15cc70: 082100d1 sub x8, x8, #8
0x15cc74: 090300b4 cbz x9, #0x15ccd4
0x15cc78: 09fd5f88 ldaxr w9, [x8]
0x15cc7c: 2a050051 sub w10, w9, #1
0x15cc80: 0afd0b88 stlxr w11, w10, [x8]
0x15cc84: abffff35 cbnz w11, #0x15cc78
0x15cc88: 16000014 b #0x15cce0
0x15cc8c: 490400b0 adrp x9, #0x1e5000
0x15cc90: 293946f9 ldr x9, [x9, #0xc70]
0x15cc94: 082100d1 sub x8, x8, #8
0x15cc98: e90200b4 cbz x9, #0x15ccf4
0x15cc9c: 09fd5f88 ldaxr w9, [x8]
0x15cca0: 2a050051 sub w10, w9, #1
0x15cca4: 0afd0b88 stlxr w11, w10, [x8]
0x15cca8: abffff35 cbnz w11, #0x15cc9c
0x15ccac: 15000014 b #0x15cd00
0x15ccb0: 490400b0 adrp x9, #0x1e5000
0x15ccb4: 293946f9 ldr x9, [x9, #0xc70]
0x15ccb8: 082100d1 sub x8, x8, #8
0x15ccbc: c90200b4 cbz x9, #0x15cd14
0x15ccc0: 09fd5f88 ldaxr w9, [x8]
0x15ccc4: 2a050051 sub w10, w9, #1
0x15ccc8: 0afd0b88 stlxr w11, w10, [x8]
0x15cccc: abffff35 cbnz w11, #0x15ccc0
0x15ccd0: 14000014 b #0x15cd20
0x15ccd4: 090140b9 ldr w9, [x8]
0x15ccd8: 2a050051 sub w10, w9, #1
0x15ccdc: 0a0100b9 str w10, [x8]
0x15cce0: 3f010071 cmp w9, #0
0x15cce4: acfaff54 b.gt #0x15cc38
0x15cce8: e1830091 add x1, sp, #0x20
0x15ccec: 1eb8fe97 bl #0x10ad64
0x15ccf0: d2ffff17 b #0x15cc38
0x15ccf4: 090140b9 ldr w9, [x8]
0x15ccf8: 2a050051 sub w10, w9, #1
0x15ccfc: 0a0100b9 str w10, [x8]
0x15cd00: 3f010071 cmp w9, #0
0x15cd04: ecf1ff54 b.gt #0x15cb40
0x15cd08: e1630091 add x1, sp, #0x18
0x15cd0c: 16b8fe97 bl #0x10ad64
0x15cd10: 8cffff17 b #0x15cb40
0x15cd14: 090140b9 ldr w9, [x8]
0x15cd18: 2a050051 sub w10, w9, #1
0x15cd1c: 0a0100b9 str w10, [x8]
0x15cd20: 3f010071 cmp w9, #0
0x15cd24: 6cf5ff54 b.gt #0x15cbd0
0x15cd28: e1630091 add x1, sp, #0x18
0x15cd2c: 0eb8fe97 bl #0x10ad64
0x15cd30: a8ffff17 b #0x15cbd0
0x15cd34: e34e0094 bl #0x1708c0
0x15cd38: c00000b0 adrp x0, #0x175000
0x15cd3c: c10000b0 adrp x1, #0x175000
0x15cd40: 00d01391 add x0, x0, #0x4f4
0x15cd44: 217c1391 add x1, x1, #0x4df
0x15cd48: cba4fe97 bl #0x106074
0x15cd4c: 02000014 b #0x15cd54
0x15cd50: 01000014 b #0x15cd54
0x15cd54: e80b40f9 ldr x8, [sp, #0x10]
0x15cd58: 490400d0 adrp x9, #0x1e6000
0x15cd5c: 291540f9 ldr x9, [x9, #0x28]
0x15cd60: f30300aa mov x19, x0
0x15cd64: 006100d1 sub x0, x8, #0x18
0x15cd68: 1f0009eb cmp x0, x9
0x15cd6c: a0010054 b.eq #0x15cda0
0x15cd70: 490400b0 adrp x9, #0x1e5000
0x15cd74: 293946f9 ldr x9, [x9, #0xc70]
0x15cd78: 082100d1 sub x8, x8, #8
0x15cd7c: 690100b4 cbz x9, #0x15cda8
0x15cd80: 09fd5f88 ldaxr w9, [x8]
0x15cd84: 2a050051 sub w10, w9, #1
0x15cd88: 0afd0b88 stlxr w11, w10, [x8]
0x15cd8c: abffff35 cbnz w11, #0x15cd80
0x15cd90: 3f010071 cmp w9, #0
0x15cd94: 6c000054 b.gt #0x15cda0
0x15cd98: e1830091 add x1, sp, #0x20
0x15cd9c: f2b7fe97 bl #0x10ad64
0x15cda0: e00313aa mov x0, x19
0x15cda4: 374e0094 bl #0x170680
0x15cda8: 090140b9 ldr w9, [x8]
0x15cdac: 2a050051 sub w10, w9, #1
0x15cdb0: 0a0100b9 str w10, [x8]
0x15cdb4: 3f010071 cmp w9, #0
0x15cdb8: 0dffff54 b.le #0x15cd98
0x15cdbc: f9ffff17 b #0x15cda0
0x15cdc0: 304e0094 bl #0x170680
0x15cdc4: fc0f1cf8 str x28, [sp, #-0x40]!
0x15cdc8: f65701a9 stp x22, x21, [sp, #0x10]
0x15cdcc: f44f02a9 stp x20, x19, [sp, #0x20]
0x15cdd0: fd7b03a9 stp x29, x30, [sp, #0x30]
0x15cdd4: fdc30091 add x29, sp, #0x30
0x15cdd8: ff0321d1 sub sp, sp, #0x840
0x15cddc: 48d03bd5 mrs x8, tpidr_el0
0x15cde0: 081540f9 ldr x8, [x8, #0x28]
0x15cde4: b50100d0 adrp x21, #0x192000
0x15cde8: f303032a mov w19, w3
0x15cdec: f40300aa mov x20, x0
0x15cdf0: 09008012 mov w9, #-1
0x15cdf4: f6030032 mov w22, #1
0x15cdf8: b5920291 add x21, x21, #0xa4
0x15cdfc: a8831cf8 stur x8, [x29, #-0x38]
0x15ce00: 890200b9 str w9, [x20]
0x15ce04: 818a00a9 stp x1, x2, [x20, #8]
0x15ce08: 9f0e00f9 str xzr, [x20, #0x18]
0x15ce0c: e0831091 add x0, sp, #0x420
0x15ce10: e10315aa mov x1, x21
0x15ce14: e2031faa mov x2, xzr
0x15ce18: 0a4f0094 bl #0x170a40
0x15ce1c: e0831091 add x0, sp, #0x420
0x15ce20: 09510094 bl #0x171244
0x15ce24: e1031f2a mov w1, wzr
0x15ce28: 9fc2ff97 bl #0x14d8a4
0x15ce2c: 800200b9 str w0, [x20]
0x15ce30: e0831091 add x0, sp, #0x420
0x15ce34: fc500094 bl #0x171224
0x15ce38: 880240b9 ldr w8, [x20]
0x15ce3c: 1f050031 cmn w8, #1
0x15ce40: 81000054 b.ne #0x15ce50
0x15ce44: df920171 cmp w22, #0x64
0x15ce48: d6060011 add w22, w22, #1
0x15ce4c: 0bfeff54 b.lt #0x15ce0c
0x15ce50: a10100d0 adrp x1, #0x192000
0x15ce54: 21d00391 add x1, x1, #0xf4
0x15ce58: e0230091 add x0, sp, #8
0x15ce5c: e2031faa mov x2, xzr
0x15ce60: f84e0094 bl #0x170a40
0x15ce64: e0230091 add x0, sp, #8
0x15ce68: f7500094 bl #0x171244
0x15ce6c: 08004039 ldrb w8, [x0]
0x15ce70: 88860039 strb w8, [x20, #0x21]
0x15ce74: c8000034 cbz w8, #0x15ce8c
0x15ce78: 888a0091 add x8, x20, #0x22
0x15ce7c: 09040091 add x9, x0, #1
0x15ce80: 2a154038 ldrb w10, [x9], #1
0x15ce84: 0a150038 strb w10, [x8], #1
0x15ce88: caffff35 cbnz w10, #0x15ce80
0x15ce8c: e0230091 add x0, sp, #8
0x15ce90: e5500094 bl #0x171224
0x15ce94: 7f020071 cmp w19, #0
0x15ce98: e8079f1a cset w8, ne
0x15ce9c: 88820039 strb w8, [x20, #0x20]
0x15cea0: 48d03bd5 mrs x8, tpidr_el0
0x15cea4: 081540f9 ldr x8, [x8, #0x28]
0x15cea8: a9835cf8 ldur x9, [x29, #-0x38]
0x15ceac: 1f0109eb cmp x8, x9
0x15ceb0: e1000054 b.ne #0x15cecc
0x15ceb4: ff032191 add sp, sp, #0x840
0x15ceb8: fd7b43a9 ldp x29, x30, [sp, #0x30]
0x15cebc: f44f42a9 ldp x20, x19, [sp, #0x20]
0x15cec0: f65741a9 ldp x22, x21, [sp, #0x10]
0x15cec4: fc0744f8 ldr x28, [sp], #0x40
0x15cec8: c0035fd6 ret 
0x15cecc: 7d4e0094 bl #0x1708c0
0x15ced0: f30300aa mov x19, x0
0x15ced4: e0230091 add x0, sp, #8
0x15ced8: 03000014 b #0x15cee4
0x15cedc: f30300aa mov x19, x0
0x15cee0: e0831091 add x0, sp, #0x420
0x15cee4: d0500094 bl #0x171224
0x15cee8: e00313aa mov x0, x19
0x15ceec: e54d0094 bl #0x170680
0x15cef0: fc5fbca9 stp x28, x23, [sp, #-0x40]!
0x15cef4: f65701a9 stp x22, x21, [sp, #0x10]
0x15cef8: f44f02a9 stp x20, x19, [sp, #0x20]
0x15cefc: fd7b03a9 stp x29, x30, [sp, #0x30]
0x15cf00: fdc30091 add x29, sp, #0x30
0x15cf04: ff0321d1 sub sp, sp, #0x840
0x15cf08: 48d03bd5 mrs x8, tpidr_el0
0x15cf0c: 081540f9 ldr x8, [x8, #0x28]
0x15cf10: b60100d0 adrp x22, #0x192000
0x15cf14: f303032a mov w19, w3
0x15cf18: f50301aa mov x21, x1
0x15cf1c: f40300aa mov x20, x0
0x15cf20: 09008012 mov w9, #-1
0x15cf24: 0a008092 mov x10, #-1
0x15cf28: f7030032 mov w23, #1
0x15cf2c: d6920291 add x22, x22, #0xa4
0x15cf30: a8831cf8 stur x8, [x29, #-0x38]
0x15cf34: 890200b9 str w9, [x20]
0x15cf38: 8a8a00a9 stp x10, x2, [x20, #8]
0x15cf3c: 9f0e00f9 str xzr, [x20, #0x18]
0x15cf40: e0831091 add x0, sp, #0x420
0x15cf44: e10316aa mov x1, x22
0x15cf48: e2031faa mov x2, xzr
0x15cf4c: bd4e0094 bl #0x170a40
0x15cf50: e0831091 add x0, sp, #0x420
0x15cf54: bc500094 bl #0x171244
0x15cf58: e1031f2a mov w1, wzr
0x15cf5c: 52c2ff97 bl #0x14d8a4
0x15cf60: 800200b9 str w0, [x20]
0x15cf64: e0831091 add x0, sp, #0x420
0x15cf68: af500094 bl #0x171224
0x15cf6c: 880240b9 ldr w8, [x20]
0x15cf70: 1f050031 cmn w8, #1
0x15cf74: 81000054 b.ne #0x15cf84
0x15cf78: ff920171 cmp w23, #0x64
0x15cf7c: f7060011 add w23, w23, #1
0x15cf80: 0bfeff54 b.lt #0x15cf40
0x15cf84: a10100d0 adrp x1, #0x192000
0x15cf88: 21d00391 add x1, x1, #0xf4
0x15cf8c: e0230091 add x0, sp, #8
0x15cf90: e2031faa mov x2, xzr
0x15cf94: ab4e0094 bl #0x170a40
0x15cf98: e0230091 add x0, sp, #8
0x15cf9c: aa500094 bl #0x171244
0x15cfa0: 08004039 ldrb w8, [x0]
0x15cfa4: 88860039 strb w8, [x20, #0x21]
0x15cfa8: c8000034 cbz w8, #0x15cfc0
0x15cfac: 888a0091 add x8, x20, #0x22
0x15cfb0: 09040091 add x9, x0, #1
0x15cfb4: 2a154038 ldrb w10, [x9], #1
0x15cfb8: 0a150038 strb w10, [x8], #1
0x15cfbc: caffff35 cbnz w10, #0x15cfb4
0x15cfc0: e0230091 add x0, sp, #8
0x15cfc4: 98500094 bl #0x171224
0x15cfc8: 550200b4 cbz x21, #0x15d010
0x15cfcc: a80600d1 sub x8, x21, #1
0x15cfd0: 091d4038 ldrb w9, [x8, #1]!
0x15cfd4: e9ffff35 cbnz w9, #0x15cfd0
0x15cfd8: e9030032 mov w9, #1
0x15cfdc: 290115cb sub x9, x9, x21
0x15cfe0: 2001088b add x0, x9, x8
0x15cfe4: e1070032 mov w1, #3
0x15cfe8: 9d050094 bl #0x15e65c
0x15cfec: 800e00f9 str x0, [x20, #0x18]
0x15cff0: a8024039 ldrb w8, [x21]
0x15cff4: 08000039 strb w8, [x0]
0x15cff8: c8000034 cbz w8, #0x15d010
0x15cffc: 08040091 add x8, x0, #1
0x15d000: a9060091 add x9, x21, #1
0x15d004: 2a154038 ldrb w10, [x9], #1
0x15d008: 0a150038 strb w10, [x8], #1
0x15d00c: caffff35 cbnz w10, #0x15d004
0x15d010: 7f020071 cmp w19, #0
0x15d014: e8079f1a cset w8, ne
0x15d018: 88820039 strb w8, [x20, #0x20]
0x15d01c: 48d03bd5 mrs x8, tpidr_el0
0x15d020: 081540f9 ldr x8, [x8, #0x28]
0x15d024: a9835cf8 ldur x9, [x29, #-0x38]
0x15d028: 1f0109eb cmp x8, x9
0x15d02c: e1000054 b.ne #0x15d048
0x15d030: ff032191 add sp, sp, #0x840
0x15d034: fd7b43a9 ldp x29, x30, [sp, #0x30]
0x15d038: f44f42a9 ldp x20, x19, [sp, #0x20]
0x15d03c: f65741a9 ldp x22, x21, [sp, #0x10]
0x15d040: fc5fc4a8 ldp x28, x23, [sp], #0x40
0x15d044: c0035fd6 ret 
0x15d048: 1e4e0094 bl #0x1708c0
0x15d04c: f30300aa mov x19, x0
0x15d050: e0230091 add x0, sp, #8
0x15d054: 03000014 b #0x15d060
0x15d058: f30300aa mov x19, x0
0x15d05c: e0831091 add x0, sp, #0x420
0x15d060: 71500094 bl #0x171224
0x15d064: e00313aa mov x0, x19
0x15d068: 864d0094 bl #0x170680
0x15d06c: f30f1ef8 str x19, [sp, #-0x20]!
0x15d070: fd7b01a9 stp x29, x30, [sp, #0x10]
0x15d074: fd430091 add x29, sp, #0x10
0x15d078: f30300aa mov x19, x0
0x15d07c: 600240b9 ldr w0, [x19]
0x15d080: 1f040031 cmn w0, #1
0x15d084: 80000054 b.eq #0x15d094
0x15d088: e6c1ff97 bl #0x14d820
0x15d08c: 08008012 mov w8, #-1
0x15d090: 680200b9 str w8, [x19]
0x15d094: 600e40f9 ldr x0, [x19, #0x18]
0x15d098: 400000b4 cbz x0, #0x15d0a0
0x15d09c: 14060094 bl #0x15e8ec
0x15d0a0: fd7b41a9 ldp x29, x30, [sp, #0x10]
0x15d0a4: f30742f8 ldr x19, [sp], #0x20
0x15d0a8: c0035fd6 ret 
0x15d0ac: 36c0fc97 bl #0x8d184
0x15d0b0: fc57bda9 stp x28, x21, [sp, #-0x30]!
0x15d0b4: f44f01a9 stp x20, x19, [sp, #0x10]
0x15d0b8: fd7b02a9 stp x29, x30, [sp, #0x20]
0x15d0bc: fd830091 add x29, sp, #0x20
0x15d0c0: ff8310d1 sub sp, sp, #0x420
0x15d0c4: 48d03bd5 mrs x8, tpidr_el0
0x15d0c8: 081540f9 ldr x8, [x8, #0x28]
0x15d0cc: f30300aa mov x19, x0
0x15d0d0: a8831df8 stur x8, [x29, #-0x28]
0x15d0d4: 600240b9 ldr w0, [x19]
0x15d0d8: 1f040031 cmn w0, #1
0x15d0dc: 40000054 b.eq #0x15d0e4
0x15d0e0: d0c1ff97 bl #0x14d820
0x15d0e4: b40100b0 adrp x20, #0x192000
0x15d0e8: f5030032 mov w21, #1
0x15d0ec: 94920291 add x20, x20, #0xa4
0x15d0f0: e0030091 mov x0, sp
0x15d0f4: e10314aa mov x1, x20
0x15d0f8: e2031faa mov x2, xzr
0x15d0fc: 514e0094 bl #0x170a40
0x15d100: e0030091 mov x0, sp
0x15d104: 50500094 bl #0x171244
0x15d108: e1031f2a mov w1, wzr
0x15d10c: e6c1ff97 bl #0x14d8a4
0x15d110: 600200b9 str w0, [x19]
0x15d114: e0030091 mov x0, sp
0x15d118: 43500094 bl #0x171224
0x15d11c: 680240b9 ldr w8, [x19]
0x15d120: 1f050031 cmn w8, #1
0x15d124: 81000054 b.ne #0x15d134
0x15d128: bf920171 cmp w21, #0x64
0x15d12c: b5060011 add w21, w21, #1
0x15d130: 0bfeff54 b.lt #0x15d0f0
0x15d134: 48d03bd5 mrs x8, tpidr_el0
0x15d138: 081540f9 ldr x8, [x8, #0x28]
0x15d13c: a9835df8 ldur x9, [x29, #-0x28]
0x15d140: 1f0109eb cmp x8, x9
0x15d144: c1000054 b.ne #0x15d15c
0x15d148: ff831091 add sp, sp, #0x420
0x15d14c: fd7b42a9 ldp x29, x30, [sp, #0x20]
0x15d150: f44f41a9 ldp x20, x19, [sp, #0x10]
0x15d154: fc57c3a8 ldp x28, x21, [sp], #0x30
0x15d158: c0035fd6 ret 
0x15d15c: d94d0094 bl #0x1708c0
0x15d160: f30300aa mov x19, x0
0x15d164: e0030091 mov x0, sp
0x15d168: 2f500094 bl #0x171224
0x15d16c: e00313aa mov x0, x19
0x15d170: 444d0094 bl #0x170680
0x15d174: fc6fbaa9 stp x28, x27, [sp, #-0x60]!
0x15d178: fa6701a9 stp x26, x25, [sp, #0x10]
0x15d17c: f85f02a9 stp x24, x23, [sp, #0x20]
0x15d180: f65703a9 stp x22, x21, [sp, #0x30]
0x15d184: f44f04a9 stp x20, x19, [sp, #0x40]
0x15d188: fd7b05a9 stp x29, x30, [sp, #0x50]
0x15d18c: fd430191 add x29, sp, #0x50
0x15d190: ff0740d1 sub sp, sp, #1, lsl #12
0x15d194: ff8333d1 sub sp, sp, #0xce0
0x15d198: 48d03bd5 mrs x8, tpidr_el0
0x15d19c: 081540f9 ldr x8, [x8, #0x28]
0x15d1a0: e9074091 add x9, sp, #1, lsl #12
0x15d1a4: f50301aa mov x21, x1
0x15d1a8: f40300aa mov x20, x0
0x15d1ac: 29e12291 add x9, x9, #0x8b8
0x15d1b0: e0e32291 add x0, sp, #0x8b8
0x15d1b4: e2031432 mov w2, #0x1000
0x15d1b8: e1031f2a mov w1, wzr
0x15d1bc: f3632291 add x19, sp, #0x898
0x15d1c0: 281102f9 str x8, [x9, #0x420]
0x15d1c4: c74c0094 bl #0x1704e0
0x15d1c8: a10100b0 adrp x1, #0x192000
0x15d1cc: 21100591 add x1, x1, #0x144
0x15d1d0: e0031291 add x0, sp, #0x480
0x15d1d4: e2031faa mov x2, xzr
0x15d1d8: 7f7e01a9 stp xzr, xzr, [x19, #0x10]
0x15d1dc: 7f7e00a9 stp xzr, xzr, [x19]
0x15d1e0: 184e0094 bl #0x170a40
0x15d1e4: e0031291 add x0, sp, #0x480
0x15d1e8: 17500094 bl #0x171244
0x15d1ec: f50f00f9 str x21, [sp, #0x18]
0x15d1f0: 08004039 ldrb w8, [x0]
0x15d1f4: e8632239 strb w8, [sp, #0x898]
0x15d1f8: e8000034 cbz w8, #0x15d214
0x15d1fc: e8632291 add x8, sp, #0x898
0x15d200: 080140b2 orr x8, x8, #1
0x15d204: 09040091 add x9, x0, #1
0x15d208: 2a154038 ldrb w10, [x9], #1
0x15d20c: 0a150038 strb w10, [x8], #1
0x15d210: caffff35 cbnz w10, #0x15d208
0x15d214: e0031291 add x0, sp, #0x480
0x15d218: 03500094 bl #0x171224
0x15d21c: 5a040090 adrp x26, #0x1e5000
0x15d220: 5a9f46f9 ldr x26, [x26, #0xd38]
0x15d224: e8632291 add x8, sp, #0x898
0x15d228: fb074091 add x27, sp, #1, lsl #12
0x15d22c: 95860091 add x21, x20, #0x21
0x15d230: f9030032 mov w25, #1
0x15d234: 7b632391 add x27, x27, #0x8d8
0x15d238: fce32291 add x28, sp, #0x8b8
0x15d23c: 080140b2 orr x8, x8, #1
0x15d240: e81300f9 str x8, [sp, #0x20]
0x15d244: 14000014 b #0x15d294
0x15d248: ece32291 add x12, sp, #0x8b8
0x15d24c: ed030baa mov x13, x11
0x15d250: ee0308aa mov x14, x8
0x15d254: 8f697638 ldrb w15, [x12, x22]
0x15d258: d0014039 ldrb w16, [x14]
0x15d25c: ff01106b cmp w15, w16
0x15d260: a1110054 b.ne #0x15d494
0x15d264: af000034 cbz w15, #0x15d278
0x15d268: ce050091 add x14, x14, #1
0x15d26c: ad050091 add x13, x13, #1
0x15d270: 8c050091 add x12, x12, #1
0x15d274: 0dffffb5 cbnz x13, #0x15d254
0x15d278: e0a30191 add x0, sp, #0x68
0x15d27c: ea4f0094 bl #0x171224
0x15d280: df0600f1 cmp x22, #1
0x15d284: 80000054 b.eq #0x15d294
0x15d288: 8c000014 b #0x15d4b8
0x15d28c: e0a30191 add x0, sp, #0x68
0x15d290: e54f0094 bl #0x171224
0x15d294: 930240b9 ldr w19, [x20]
0x15d298: f6031faa mov x22, xzr
0x15d29c: f8031632 mov w24, #0x400
0x15d2a0: 777e4093 sxtw x23, w19
0x15d2a4: 07000014 b #0x15d2c0
0x15d2a8: e803004b neg w8, w0
0x15d2ac: e81700b9 str w8, [sp, #0x14]
0x15d2b0: 244d0094 bl #0x170740
0x15d2b4: e81740b9 ldr w8, [sp, #0x14]
0x15d2b8: 080000b9 str w8, [x0]
0x15d2bc: 15000014 b #0x15d310
0x15d2c0: 1f0b0071 cmp w24, #2
0x15d2c4: cb030054 b.lt #0x15d33c
0x15d2c8: 485340f9 ldr x8, [x26, #0xa0]
0x15d2cc: 05e0a352 mov w5, #0x1f000000
0x15d2d0: c6ffa152 mov w6, #0xffe0000
0x15d2d4: 076abc52 mov w7, #-0x1cb00000
0x15d2d8: e1530191 add x1, sp, #0x54
0x15d2dc: e2030032 mov w2, #1
0x15d2e0: e3930191 add x3, sp, #0x64
0x15d2e4: e4630191 add x4, sp, #0x58
0x15d2e8: 05268972 movk w5, #0x4930
0x15d2ec: a6928072 movk w6, #0x495
0x15d2f0: 47eb9e72 movk w7, #0xf75a
0x15d2f4: e00317aa mov x0, x23
0x15d2f8: f36700b9 str w19, [sp, #0x64]
0x15d2fc: f92f00f9 str x25, [sp, #0x58]
0x15d300: 00013fd6 blr x8
0x15d304: 1ffc3f31 cmn w0, #0xfff
0x15d308: 02fdff54 b.hs #0x15d2a8
0x15d30c: 60010034 cbz w0, #0x15d338
0x15d310: e8534139 ldrb w8, [sp, #0x54]
0x15d314: c9060091 add x9, x22, #1
0x15d318: 18070051 sub w24, w24, #1
0x15d31c: 1f290071 cmp w8, #0xa
0x15d320: 686b3638 strb w8, [x27, x22]
0x15d324: f60309aa mov x22, x9
0x15d328: c1fcff54 b.ne #0x15d2c0
0x15d32c: 48018052 mov w8, #0xa
0x15d330: f60309aa mov x22, x9
0x15d334: 02000014 b #0x15d33c
0x15d338: e8534139 ldrb w8, [sp, #0x54]
0x15d33c: e0031f2a mov w0, wzr
0x15d340: 7f6b3638 strb wzr, [x27, x22]
0x15d344: b61b00b4 cbz x22, #0x15d6b8
0x15d348: e803282a mvn w8, w8
0x15d34c: 081d0012 and w8, w8, #0xff
0x15d350: 481b0034 cbz w8, #0x15d6b8
0x15d354: e0074091 add x0, sp, #1, lsl #12
0x15d358: e4074091 add x4, sp, #1, lsl #12
0x15d35c: e6074091 add x6, sp, #1, lsl #12
0x15d360: 00602391 add x0, x0, #0x8d8
0x15d364: e2230191 add x2, sp, #0x48
0x15d368: e3030191 add x3, sp, #0x40
0x15d36c: 84202391 add x4, x4, #0x8c8
0x15d370: e5e30091 add x5, sp, #0x38
0x15d374: c6e02291 add x6, x6, #0x8b8
0x15d378: e7d30091 add x7, sp, #0x34
0x15d37c: e10315aa mov x1, x21
0x15d380: fc0300f9 str x28, [sp]
0x15d384: b8affd97 bl #0xc9264
0x15d388: 1f040071 cmp w0, #1
0x15d38c: 6b0e0054 b.lt #0x15d558
0x15d390: 880640f9 ldr x8, [x20, #8]
0x15d394: 1f0500b1 cmn x8, #1
0x15d398: 80000054 b.eq #0x15d3a8
0x15d39c: e93780b9 ldrsw x9, [sp, #0x34]
0x15d3a0: 3f0108eb cmp x9, x8
0x15d3a4: 81f7ff54 b.ne #0x15d294
0x15d3a8: 880e40f9 ldr x8, [x20, #0x18]
0x15d3ac: 280100b4 cbz x8, #0x15d3d0
0x15d3b0: e9e32291 add x9, sp, #0x8b8
0x15d3b4: 0a014039 ldrb w10, [x8]
0x15d3b8: 2b014039 ldrb w11, [x9]
0x15d3bc: 5f010b6b cmp w10, w11
0x15d3c0: a1f6ff54 b.ne #0x15d294
0x15d3c4: 29050091 add x9, x9, #1
0x15d3c8: 08050091 add x8, x8, #1
0x15d3cc: 4affff35 cbnz w10, #0x15d3b4
0x15d3d0: 490400f0 adrp x9, #0x1e8000
0x15d3d4: 88824039 ldrb w8, [x20, #0x20]
0x15d3d8: 29b541b9 ldr w9, [x9, #0x1b4]
0x15d3dc: 1f01096b cmp w8, w9
0x15d3e0: c1060054 b.ne #0x15d4b8
0x15d3e4: e8636239 ldrb w8, [sp, #0x898]
0x15d3e8: 68f5ff34 cbz w8, #0x15d294
0x15d3ec: eb632291 add x11, sp, #0x898
0x15d3f0: 691d4038 ldrb w9, [x11, #1]!
0x15d3f4: e9ffff35 cbnz w9, #0x15d3f0
0x15d3f8: ec1340f9 ldr x12, [sp, #0x20]
0x15d3fc: e9031faa mov x9, xzr
0x15d400: 6a010ccb sub x10, x11, x12
0x15d404: 8b010bcb sub x11, x12, x11
0x15d408: 8c6b6938 ldrb w12, [x28, x9]
0x15d40c: 6c020034 cbz w12, #0x15d458
0x15d410: 9f01086b cmp w12, w8
0x15d414: 29050091 add x9, x9, #1
0x15d418: 81ffff54 b.ne #0x15d408
0x15d41c: aa0100b4 cbz x10, #0x15d450
0x15d420: ee1340f9 ldr x14, [sp, #0x20]
0x15d424: ece32291 add x12, sp, #0x8b8
0x15d428: ed030baa mov x13, x11
0x15d42c: 8f696938 ldrb w15, [x12, x9]
0x15d430: d0014039 ldrb w16, [x14]
0x15d434: ff01106b cmp w15, w16
0x15d438: 81feff54 b.ne #0x15d408
0x15d43c: af000034 cbz w15, #0x15d450
0x15d440: ce050091 add x14, x14, #1
0x15d444: ad050091 add x13, x13, #1
0x15d448: 8c050091 add x12, x12, #1
0x15d44c: 0dffffb5 cbnz x13, #0x15d42c
0x15d450: 3f0500f1 cmp x9, #1
0x15d454: 00f2ff54 b.eq #0x15d294
0x15d458: a10100b0 adrp x1, #0x192000
0x15d45c: e0a30191 add x0, sp, #0x68
0x15d460: 21500691 add x1, x1, #0x194
0x15d464: e2031faa mov x2, xzr
0x15d468: 764d0094 bl #0x170a40
0x15d46c: e0a30191 add x0, sp, #0x68
0x15d470: 754f0094 bl #0x171244
0x15d474: e80300aa mov x8, x0
0x15d478: 09154038 ldrb w9, [x8], #1
0x15d47c: 89f0ff34 cbz w9, #0x15d28c
0x15d480: 0a1c4038 ldrb w10, [x0, #1]!
0x15d484: eaffff35 cbnz w10, #0x15d480
0x15d488: f6031faa mov x22, xzr
0x15d48c: 0a0008cb sub x10, x0, x8
0x15d490: 0b0100cb sub x11, x8, x0
0x15d494: 8c6b7638 ldrb w12, [x28, x22]
0x15d498: cc000034 cbz w12, #0x15d4b0
0x15d49c: 9f01096b cmp w12, w9
0x15d4a0: d6060091 add x22, x22, #1
0x15d4a4: 81ffff54 b.ne #0x15d494
0x15d4a8: 0aedffb5 cbnz x10, #0x15d248
0x15d4ac: 73ffff17 b #0x15d278
0x15d4b0: e0a30191 add x0, sp, #0x68
0x15d4b4: 5c4f0094 bl #0x171224
0x15d4b8: e82740f9 ldr x8, [sp, #0x48]
0x15d4bc: eb0f40f9 ldr x11, [sp, #0x18]
0x15d4c0: ea074091 add x10, sp, #1, lsl #12
0x15d4c4: 4ae12291 add x10, x10, #0x8b8
0x15d4c8: 680100f9 str x8, [x11]
0x15d4cc: e92340f9 ldr x9, [sp, #0x40]
0x15d4d0: 7f610039 strb wzr, [x11, #0x18]
0x15d4d4: 280108cb sub x8, x9, x8
0x15d4d8: 69a100a9 stp x9, x8, [x11, #8]
0x15d4dc: 48414039 ldrb w8, [x10, #0x10]
0x15d4e0: 1fc90171 cmp w8, #0x72
0x15d4e4: e8179f1a cset w8, eq
0x15d4e8: 68610039 strb w8, [x11, #0x18]
0x15d4ec: 49454039 ldrb w9, [x10, #0x11]
0x15d4f0: 3fdd0171 cmp w9, #0x77
0x15d4f4: 61000054 b.ne #0x15d500
0x15d4f8: 08011f32 orr w8, w8, #2
0x15d4fc: 68610039 strb w8, [x11, #0x18]
0x15d500: 49494039 ldrb w9, [x10, #0x12]
0x15d504: 3fe10171 cmp w9, #0x78
0x15d508: 61000054 b.ne #0x15d514
0x15d50c: 08011e32 orr w8, w8, #4
0x15d510: 68610039 strb w8, [x11, #0x18]
0x15d514: 494d4039 ldrb w9, [x10, #0x13]
0x15d518: 3fc10171 cmp w9, #0x70
0x15d51c: 61000054 b.ne #0x15d528
0x15d520: 08011d32 orr w8, w8, #8
0x15d524: 68610039 strb w8, [x11, #0x18]
0x15d528: 48054039 ldrb w8, [x10, #1]
0x15d52c: 08c10051 sub w8, w8, #0x30
0x15d530: 1fd90071 cmp w8, #0x36
0x15d534: e8040054 b.hi #0x15d5d0
0x15d538: a9010090 adrp x9, #0x191000
0x15d53c: 29d13491 add x9, x9, #0xd34
0x15d540: 2879a8b8 ldrsw x8, [x9, x8, lsl #2]
0x15d544: 0901098b add x9, x8, x9
0x15d548: e8031f2a mov w8, wzr
0x15d54c: 20011fd6 br x9
0x15d550: 48018052 mov w8, #0xa
0x15d554: 20000014 b #0x15d5d4
0x15d558: e0031f2a mov w0, wzr
0x15d55c: 57000014 b #0x15d6b8
0x15d560: 68018052 mov w8, #0xb
0x15d564: 1c000014 b #0x15d5d4
0x15d568: e8071e32 mov w8, #0xc
0x15d56c: 1a000014 b #0x15d5d4
0x15d570: a8018052 mov w8, #0xd
0x15d574: 18000014 b #0x15d5d4
0x15d578: e80b1f32 mov w8, #0xe
0x15d57c: 16000014 b #0x15d5d4
0x15d580: e80f0032 mov w8, #0xf
0x15d584: 14000014 b #0x15d5d4
0x15d588: e8030032 mov w8, #1
0x15d58c: 12000014 b #0x15d5d4
0x15d590: e8031f32 mov w8, #2
0x15d594: 10000014 b #0x15d5d4
0x15d598: e8070032 mov w8, #3
0x15d59c: 0e000014 b #0x15d5d4
0x15d5a0: e8031e32 mov w8, #4
0x15d5a4: 0c000014 b #0x15d5d4
0x15d5a8: a8008052 mov w8, #5
0x15d5ac: 0a000014 b #0x15d5d4
0x15d5b0: e8071f32 mov w8, #6
0x15d5b4: 08000014 b #0x15d5d4
0x15d5b8: e80b0032 mov w8, #7
0x15d5bc: 06000014 b #0x15d5d4
0x15d5c0: e8031d32 mov w8, #8
0x15d5c4: 04000014 b #0x15d5d4
0x15d5c8: 28018052 mov w8, #9
0x15d5cc: 02000014 b #0x15d5d4
0x15d5d0: e81f0032 mov w8, #0xff
0x15d5d4: 68a10039 strb w8, [x11, #0x28]
0x15d5d8: 480d4039 ldrb w8, [x10, #3]
0x15d5dc: 08c10051 sub w8, w8, #0x30
0x15d5e0: 1fd90071 cmp w8, #0x36
0x15d5e4: a8040054 b.hi #0x15d678
0x15d5e8: a9010090 adrp x9, #0x191000
0x15d5ec: 29413891 add x9, x9, #0xe10
0x15d5f0: 2879a8b8 ldrsw x8, [x9, x8, lsl #2]
0x15d5f4: 0901098b add x9, x8, x9
0x15d5f8: e8031f2a mov w8, wzr
0x15d5fc: 20011fd6 br x9
0x15d600: 48018052 mov w8, #0xa
0x15d604: 1e000014 b #0x15d67c
0x15d608: 68018052 mov w8, #0xb
0x15d60c: 1c000014 b #0x15d67c
0x15d610: e8071e32 mov w8, #0xc
0x15d614: 1a000014 b #0x15d67c
0x15d618: a8018052 mov w8, #0xd
0x15d61c: 18000014 b #0x15d67c
0x15d620: e80b1f32 mov w8, #0xe
0x15d624: 16000014 b #0x15d67c
0x15d628: e80f0032 mov w8, #0xf
0x15d62c: 14000014 b #0x15d67c
0x15d630: e8030032 mov w8, #1
0x15d634: 12000014 b #0x15d67c
0x15d638: e8031f32 mov w8, #2
0x15d63c: 10000014 b #0x15d67c
0x15d640: e8070032 mov w8, #3
0x15d644: 0e000014 b #0x15d67c
0x15d648: e8031e32 mov w8, #4
0x15d64c: 0c000014 b #0x15d67c
0x15d650: a8008052 mov w8, #5
0x15d654: 0a000014 b #0x15d67c
0x15d658: e8071f32 mov w8, #6
0x15d65c: 08000014 b #0x15d67c
0x15d660: e80b0032 mov w8, #7
0x15d664: 06000014 b #0x15d67c
0x15d668: e8031d32 mov w8, #8
0x15d66c: 04000014 b #0x15d67c
0x15d670: 28018052 mov w8, #9
0x15d674: 02000014 b #0x15d67c
0x15d678: e81f0032 mov w8, #0xff
0x15d67c: 68a50039 strb w8, [x11, #0x29]
0x15d680: e81f40f9 ldr x8, [sp, #0x38]
0x15d684: 681100f9 str x8, [x11, #0x20]
0x15d688: e83780b9 ldrsw x8, [sp, #0x34]
0x15d68c: 681900f9 str x8, [x11, #0x30]
0x15d690: e8e36239 ldrb w8, [sp, #0x8b8]
0x15d694: 68e10039 strb w8, [x11, #0x38]
0x15d698: e8000034 cbz w8, #0x15d6b4
0x15d69c: e9e32291 add x9, sp, #0x8b8
0x15d6a0: 68e50091 add x8, x11, #0x39
0x15d6a4: 290140b2 orr x9, x9, #1
0x15d6a8: 2a154038 ldrb w10, [x9], #1
0x15d6ac: 0a150038 strb w10, [x8], #1
0x15d6b0: caffff35 cbnz w10, #0x15d6a8
0x15d6b4: e0030032 mov w0, #1
0x15d6b8: e9074091 add x9, sp, #1, lsl #12
0x15d6bc: 48d03bd5 mrs x8, tpidr_el0
0x15d6c0: 29e12291 add x9, x9, #0x8b8
0x15d6c4: 081540f9 ldr x8, [x8, #0x28]
0x15d6c8: 291142f9 ldr x9, [x9, #0x420]
0x15d6cc: 1f0109eb cmp x8, x9
0x15d6d0: 41010054 b.ne #0x15d6f8
0x15d6d4: ff074091 add sp, sp, #1, lsl #12
0x15d6d8: ff833391 add sp, sp, #0xce0
0x15d6dc: fd7b45a9 ldp x29, x30, [sp, #0x50]
0x15d6e0: f44f44a9 ldp x20, x19, [sp, #0x40]
0x15d6e4: f65743a9 ldp x22, x21, [sp, #0x30]
0x15d6e8: f85f42a9 ldp x24, x23, [sp, #0x20]
0x15d6ec: fa6741a9 ldp x26, x25, [sp, #0x10]
0x15d6f0: fc6fc6a8 ldp x28, x27, [sp], #0x60
0x15d6f4: c0035fd6 ret 
0x15d6f8: 724c0094 bl #0x1708c0
0x15d6fc: f30300aa mov x19, x0
0x15d700: e0031291 add x0, sp, #0x480
0x15d704: 03000014 b #0x15d710
0x15d708: f30300aa mov x19, x0
0x15d70c: e0a30191 add x0, sp, #0x68
0x15d710: c54e0094 bl #0x171224
0x15d714: e00313aa mov x0, x19
0x15d718: da4b0094 bl #0x170680
0x15d71c: fc57bda9 stp x28, x21, [sp, #-0x30]!
0x15d720: f44f01a9 stp x20, x19, [sp, #0x10]
0x15d724: fd7b02a9 stp x29, x30, [sp, #0x20]
0x15d728: fd830091 add x29, sp, #0x20
0x15d72c: ff0321d1 sub sp, sp, #0x840
0x15d730: 48d03bd5 mrs x8, tpidr_el0
0x15d734: 081540f9 ldr x8, [x8, #0x28]
0x15d738: b40100b0 adrp x20, #0x192000
0x15d73c: f30300aa mov x19, x0
0x15d740: 09008012 mov w9, #-1
0x15d744: f5030032 mov w21, #1
0x15d748: 94920791 add x20, x20, #0x1e4
0x15d74c: a8831df8 stur x8, [x29, #-0x28]
0x15d750: 690200b9 str w9, [x19]
0x15d754: 618a00a9 stp x1, x2, [x19, #8]
0x15d758: 7f0e00f9 str xzr, [x19, #0x18]
0x15d75c: e0831091 add x0, sp, #0x420
0x15d760: e10314aa mov x1, x20
0x15d764: e2031faa mov x2, xzr
0x15d768: b64c0094 bl #0x170a40
0x15d76c: e0831091 add x0, sp, #0x420
0x15d770: b54e0094 bl #0x171244
0x15d774: e1031f2a mov w1, wzr
```

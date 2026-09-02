# Annotated `DT_INIT` bootstrap region

Range: `0x6a70..0x7800`

```asm
0x006a70: stp      x28, x27, [sp, #-0x60]!
0x006a74: stp      x26, x25, [sp, #0x10]
0x006a78: stp      x24, x23, [sp, #0x20]
0x006a7c: stp      x22, x21, [sp, #0x30]
0x006a80: stp      x20, x19, [sp, #0x40]
0x006a84: stp      x29, x30, [sp, #0x50]
0x006a88: add      x29, sp, #0x50
0x006a8c: sub      sp, sp, #0x90
0x006a90: mrs      x8, tpidr_el0
0x006a94: ldr      x8, [x8, #0x28]
0x006a98: adrp     x9, #0x1e5000
0x006a9c: ldr      x9, [x9, #0xe28]
0x006aa0: adrp     x10, #0x1e5000
0x006aa4: stur     x8, [x29, #-0x58]
0x006aa8: ldr      w8, [x9]
0x006aac: ldr      x10, [x10, #0x838]
0x006ab0: mov      w9, #-0x76f30000
0x006ab4: movk     w9, #0x27b5
0x006ab8: cmp      w8, #0xa
0x006abc: ldr      w10, [x10]
0x006ac0: cset     w11, lt
0x006ac4: cmp      w8, #9
0x006ac8: sub      w8, w10, w9
0x006acc: sub      w8, w8, #1
0x006ad0: add      w8, w8, w9
0x006ad4: mul      w8, w8, w10
0x006ad8: mvn      w8, w8
0x006adc: orr      w9, w8, #0xfffffffe
0x006ae0: cset     w8, gt
0x006ae4: cmn      w9, #1
0x006ae8: cset     w9, eq
0x006aec: eor      w10, w11, w9
0x006af0: cset     w9, ne
0x006af4: tbnz     w10, #0, #0x72d4
0x006af8: orr      w8, w8, w9
0x006afc: eor      w8, w8, #1
0x006b00: tbnz     w8, #0, #0x72d4
0x006b04: b        #0x6b04
0x006b08: orr      w8, w8, w9
0x006b0c: eor      w8, w8, #1
0x006b10: tbnz     w8, #0, #0x76c8
0x006b14: mov      x26, #0x7f96000000000000
0x006b18: mov      x27, #-0x1860000000000000
0x006b1c: mov      x28, #0x775000000000000
0x006b20: mov      x23, #0x7aff000000000000
0x006b24: movk     x26, #0x4285, lsl #32
0x006b28: movk     x27, #0x1a1c, lsl #32
0x006b2c: movk     x28, #0x781d, lsl #32
0x006b30: movk     x23, #0x3cbf, lsl #32
0x006b34: movk     x26, #0xf3f5, lsl #16
0x006b38: movk     x27, #0x7ae9, lsl #16
0x006b3c: movk     x28, #0x3c9d, lsl #16
0x006b40: movk     x23, #0xf282, lsl #16
0x006b44: and      x24, x22, #0xfffffffffffffffe
0x006b48: movk     x26, #0x25f6
0x006b4c: mov      w25, #4
0x006b50: movk     x27, #0x640f
0x006b54: movk     x28, #0xbd29
0x006b58: movk     x23, #0xc77e
0x006b5c: b        #0x6ba8
0x006b60: neg      w20, w0
0x006b64: bl       #0x170740    ; -> iIIIIIIiIi+0x231b4
0x006b68: str      w20, [x0]
0x006b6c: mov      x0, #-1
0x006b70: b        #0x6eb4
0x006b74: mov      w8, #0x4d10000
0x006b78: mov      x9, #-0x2f1e000000000000
0x006b7c: movk     w8, #0x2e20
0x006b80: movk     x9, #0xfa8e, lsl #32
0x006b84: neg      w8, w8
0x006b88: movk     x9, #0x4d1, lsl #16
0x006b8c: sub      w8, w8, w0
0x006b90: movk     x9, #0x2e20
0x006b94: add      x20, x8, x9
0x006b98: bl       #0x170740    ; -> iIIIIIIiIi+0x231b4
0x006b9c: str      w20, [x0]
0x006ba0: mov      x0, #-1
0x006ba4: b        #0x7238
0x006ba8: sub      x19, sp, #0x470
0x006bac: mov      sp, x19
0x006bb0: mov      w0, #1
0x006bb4: mov      w1, #0x1070
0x006bb8: bl       #0x16ff00    ; PLT -> calloc
0x006bbc: cmp      x0, x24
0x006bc0: adrp     x18, #0x1ec000
0x006bc4: str      x0, [x18, #0xea0]
0x006bc8: b.eq     #0x6df4
0x006bcc: and      x8, x22, #0xfffffffffffffffe
0x006bd0: and      w9, w0, w8
0x006bd4: eor      w10, w0, w8
0x006bd8: orr      w9, w9, w10
0x006bdc: mvn      w9, w9
0x006be0: orr      x9, x9, #0xfffffffffffffff8
0x006be4: cmn      x9, #1
0x006be8: b.eq     #0x6d14
0x006bec: mov      x14, #-0x40f1000000000000
0x006bf0: movk     x14, #0xea41, lsl #32
0x006bf4: movk     x14, #0x8d93, lsl #16
0x006bf8: movk     x14, #0xd995
0x006bfc: bic      x9, x14, x0
0x006c00: bic      x10, x0, x14
0x006c04: mvn      x11, x22
0x006c08: orr      x9, x9, x10
0x006c0c: and      x10, x22, #6
0x006c10: orr      x11, x11, #1
0x006c14: mov      w13, #8
0x006c18: bic      x12, x8, x14
0x006c1c: sub      x13, x13, x10
0x006c20: and      x10, x11, x14
0x006c24: orr      x10, x10, x12
0x006c28: eor      x9, x9, x10
0x006c2c: eor      x10, x9, #0xfffffffffffffff8
0x006c30: tst      x10, x9
0x006c34: mov      w9, #0x70
0x006c38: csel     x10, x9, x13, ne
0x006c3c: cset     w9, eq
0x006c40: cmp      x13, #0x20
0x006c44: cset     w11, lo
0x006c48: cmp      w9, w11
0x006c4c: b.ne     #0x6c54
0x006c50: tbnz     w9, #0, #0x6cc4
0x006c54: mvn      x9, x10
0x006c58: orr      x8, x9, #0xffffffffffffff9f
0x006c5c: cmn      x8, #1
0x006c60: and      x8, x22, #0xfffffffffffffffe
0x006c64: b.eq     #0x6cc4
0x006c68: mov      x14, #0x4834000000000000
0x006c6c: movk     x14, #0x1d5d, lsl #32
0x006c70: movk     x14, #0x652, lsl #16
0x006c74: mvn      w9, w9
0x006c78: movk     x14, #0x2df0
0x006c7c: sub      x11, x10, x14
0x006c80: and      x13, x9, #0x60
0x006c84: sub      x11, x11, x13
0x006c88: mov      x12, xzr
0x006c8c: add      x9, x0, x13
0x006c90: add      x8, x8, x13
0x006c94: add      x11, x11, x14
0x006c98: and      x14, x22, #0xfffffffffffffffe
0x006c9c: add      x14, x14, x12
0x006ca0: ldp      q0, q1, [x14]
0x006ca4: add      x15, x0, x12
0x006ca8: add      x12, x12, #0x20
0x006cac: cmp      x13, x12
0x006cb0: stp      q0, q1, [x15]
0x006cb4: b.ne     #0x6c98
0x006cb8: cmp      x10, x13
0x006cbc: b.ne     #0x6ccc
0x006cc0: b        #0x6cdc
0x006cc4: mov      x9, x0
0x006cc8: mov      x11, x10
0x006ccc: ldrb     w12, [x8], #1
0x006cd0: sub      x11, x11, #1
0x006cd4: strb     w12, [x9], #1
0x006cd8: cbnz     x11, #0x6ccc
0x006cdc: mov      x11, #0x2df2000000000000
0x006ce0: movk     x11, #0x3ea0, lsl #32
0x006ce4: movk     x11, #0x3285, lsl #16
0x006ce8: mov      w9, #0x70
0x006cec: movk     x11, #0x19ec
0x006cf0: sub      x9, x9, x11
0x006cf4: sub      x9, x9, x10
0x006cf8: and      x8, x22, #0xfffffffffffffffe
0x006cfc: add      x9, x9, x11
0x006d00: add      x8, x8, x10
0x006d04: lsr      x12, x9, #3
0x006d08: add      x0, x0, x10
0x006d0c: cbnz     x12, #0x6d1c
0x006d10: b        #0x6dc4
0x006d14: mov      w12, #0xe
0x006d18: mov      w9, #0x70
0x006d1c: cmp      x12, #4
0x006d20: lsl      x10, x12, #3
0x006d24: b.lo     #0x6d98
0x006d28: eor      x11, x12, #0xfffffffffffffffc
0x006d2c: and      x11, x11, x12
0x006d30: sub      x13, x12, x11
0x006d34: cbz      x13, #0x6d98
0x006d38: mov      x14, #-0x2594000000000000
0x006d3c: movk     x14, #0xe5d3, lsl #32
0x006d40: movk     x14, #0x5124, lsl #16
0x006d44: movk     x14, #0x8c55
0x006d48: sub      x13, x12, x14
0x006d4c: sub      x13, x13, x11
0x006d50: add      x13, x13, x14
0x006d54: lsl      x14, x13, #3
0x006d58: mov      x15, xzr
0x006d5c: add      x16, x8, #0x10
0x006d60: add      x13, x0, x14
0x006d64: add      x14, x8, x14
0x006d68: add      x17, x0, #0x10
0x006d6c: ldp      q0, q1, [x16, #-0x10]
0x006d70: neg      x15, x15
0x006d74: sub      x12, x12, #4
0x006d78: add      x16, x16, #0x20
0x006d7c: sub      x15, x25, x15
0x006d80: cmp      x11, x12
0x006d84: stp      q0, q1, [x17, #-0x10]
0x006d88: add      x17, x17, #0x20
0x006d8c: b.ne     #0x6d6c
0x006d90: cbnz     x11, #0x6da4
0x006d94: b        #0x6dbc
0x006d98: mov      x13, x0
0x006d9c: mov      x14, x8
0x006da0: mov      x11, x12
0x006da4: ldr      x12, [x14], #8
0x006da8: add      x11, x11, x23
0x006dac: sub      x11, x11, #1
0x006db0: sub      x11, x11, x23
0x006db4: str      x12, [x13], #8
0x006db8: cbnz     x11, #0x6da4
0x006dbc: add      x8, x8, x10
0x006dc0: add      x0, x0, x10
0x006dc4: mov      x10, #-0x3fd1000000000000
0x006dc8: movk     x10, #0x661e, lsl #32
0x006dcc: movk     x10, #0x3ec7, lsl #16
0x006dd0: movk     x10, #0xd2e
0x006dd4: orn      w10, w10, w10
0x006dd8: and      w9, w9, w10
0x006ddc: and      x9, x9, #7
0x006de0: cbz      x9, #0x6df4
0x006de4: ldrb     w10, [x8], #1
0x006de8: sub      x9, x9, #1
0x006dec: strb     w10, [x0], #1
0x006df0: cbnz     x9, #0x6de4
0x006df4: ldr      x8, [x18, #0xea0]
0x006df8: adrp     x9, #0x1e5000
0x006dfc: ldr      x8, [x8, #0x30]
0x006e00: ldr      x9, [x9, #0xcb8]
0x006e04: sub      x0, x9, x8
0x006e08: ldrh     w8, [x0, #0x38]
0x006e0c: adrp     x9, #0x1ec000
0x006e10: str      x0, [x9, #0xea8]
0x006e14: cbz      x8, #0x6e64
0x006e18: ldr      x11, [x0, #0x20]
0x006e1c: mov      x10, xzr
0x006e20: mov      x9, xzr
0x006e24: neg      x11, x11
0x006e28: sub      x11, x11, x0
0x006e2c: neg      x11, x11
0x006e30: ldr      w12, [x11]
0x006e34: cmp      w12, #1
0x006e38: b.ne     #0x6e50
0x006e3c: ldr      x9, [x11, #0x28]
0x006e40: ldr      x12, [x11, #0x10]
0x006e44: sub      x9, x9, x28
0x006e48: add      x9, x9, x12
0x006e4c: add      x9, x9, x28
0x006e50: add      x10, x10, #1
0x006e54: sub      x8, x8, #1
0x006e58: add      x11, x11, #0x38
0x006e5c: cbnz     x8, #0x6e30
0x006e60: b        #0x6e68
0x006e64: mov      x9, xzr
0x006e68: eor      x8, x9, #0xfff
0x006e6c: and      x20, x8, x9
0x006e70: mov      w2, #7
0x006e74: mov      x1, x20
0x006e78: bl       #0x1707f0    ; PLT -> mprotect
0x006e7c: adrp     x8, #0x1ec000
0x006e80: ldr      x8, [x8, #0xea8]
0x006e84: adrp     x9, #0x1ec000
0x006e88: mov      w1, #0x1000
0x006e8c: mov      w2, #7
0x006e90: add      x8, x8, x20
0x006e94: mov      w3, #0x22
0x006e98: mov      w4, #-1
0x006e9c: mov      x0, xzr
0x006ea0: mov      x5, xzr
0x006ea4: str      x8, [x9, #0xeb0]
0x006ea8: bl       #0x16ffa0    ; -> iIIIIIIiIi+0x22a14
0x006eac: cmn      x0, #0xfff
0x006eb0: b.hs     #0x6b60
0x006eb4: str      x0, [x21]
0x006eb8: mov      x0, x19
0x006ebc: bl       #0x171c1c    ; -> iIIIIIIiIi+0x24690
0x006ec0: sub      x19, sp, #0x470
0x006ec4: mov      sp, x19
0x006ec8: mov      w0, #1
0x006ecc: mov      w1, #0x1070
0x006ed0: bl       #0x16ff00    ; PLT -> calloc
0x006ed4: and      x8, x22, #0xfffffffffffffffe
0x006ed8: cmp      x0, x8
0x006edc: adrp     x18, #0x1ec000
0x006ee0: str      x0, [x18, #0xea0]
0x006ee4: b.eq     #0x7138
0x006ee8: mvn      w10, w22
0x006eec: mov      w11, #0x43af0000
0x006ef0: mov      w12, #0x43af0000
0x006ef4: mvn      w9, w0
0x006ef8: movk     w11, #0xda19
0x006efc: movk     w12, #0xda18
0x006f00: orr      w10, w10, #1
0x006f04: and      w11, w0, w11
0x006f08: and      w12, w8, w12
0x006f0c: and      w9, w9, #6
0x006f10: and      w13, w10, #6
0x006f14: orr      w9, w9, w11
0x006f18: orr      w11, w13, w12
0x006f1c: eor      w9, w9, w11
0x006f20: orn      w10, w10, w0
0x006f24: orn      w9, w9, w10
0x006f28: mvn      w9, w9
0x006f2c: orr      x9, x9, #0xfffffffffffffff8
0x006f30: cmn      x9, #1
0x006f34: b.eq     #0x7038
0x006f38: mov      w8, #-0x6cf60000
0x006f3c: movk     w8, #0xf4e1
0x006f40: mvn      w9, w0
0x006f44: bic      w10, w0, w8
0x006f48: and      x8, x22, #0xfffffffffffffffe
0x006f4c: bfxil    w10, w9, #0, #1
0x006f50: orr      w9, w8, #1
0x006f54: eon      w9, w10, w9
0x006f58: and      x11, x22, #6
0x006f5c: mov      w12, #8
0x006f60: orr      x9, x9, #0xfffffffffffffff8
0x006f64: sub      x11, x12, x11
0x006f68: cmn      x9, #1
0x006f6c: mov      w10, #0x70
0x006f70: csel     x10, x10, x11, ne
0x006f74: cmp      x11, #0x1f
0x006f78: mov      x11, #-1
0x006f7c: ccmp     x9, x11, #0, ls
0x006f80: b.ne     #0x6f8c
0x006f84: mov      w9, #1
0x006f88: tbnz     w9, #0, #0x6ff8
0x006f8c: mvn      x9, x10
0x006f90: orr      x11, x9, #0xffffffffffffff9f
0x006f94: cmn      x11, #1
0x006f98: b.eq     #0x6ff8
0x006f9c: mov      x14, #0x78ec000000000000
0x006fa0: movk     x14, #0xdbe5, lsl #32
0x006fa4: movk     x14, #0x798, lsl #16
0x006fa8: mvn      w9, w9
0x006fac: movk     x14, #0x380c
0x006fb0: sub      x11, x10, x14
0x006fb4: and      x13, x9, #0x60
0x006fb8: sub      x11, x11, x13
0x006fbc: mov      x12, xzr
0x006fc0: add      x9, x0, x13
0x006fc4: add      x8, x8, x13
0x006fc8: add      x11, x11, x14
0x006fcc: and      x14, x22, #0xfffffffffffffffe
0x006fd0: add      x14, x14, x12
0x006fd4: ldp      q0, q1, [x14]
0x006fd8: add      x15, x0, x12
0x006fdc: add      x12, x12, #0x20
0x006fe0: cmp      x13, x12
0x006fe4: stp      q0, q1, [x15]
0x006fe8: b.ne     #0x6fcc
0x006fec: cmp      x10, x13
0x006ff0: b.ne     #0x7000
0x006ff4: b        #0x7018
0x006ff8: mov      x9, x0
0x006ffc: mov      x11, x10
0x007000: ldrb     w12, [x8], #1
0x007004: add      x11, x11, x27
0x007008: sub      x11, x11, #1
0x00700c: sub      x11, x11, x27
0x007010: strb     w12, [x9], #1
0x007014: cbnz     x11, #0x7000
0x007018: mov      w9, #0x70
0x00701c: and      x8, x22, #0xfffffffffffffffe
0x007020: sub      x9, x9, x10
0x007024: add      x8, x8, x10
0x007028: lsr      x12, x9, #3
0x00702c: add      x0, x0, x10
0x007030: cbnz     x12, #0x7040
0x007034: b        #0x7108
0x007038: mov      w12, #0xe
0x00703c: mov      w9, #0x70
0x007040: cmp      x12, #4
0x007044: lsl      x10, x12, #3
0x007048: b.lo     #0x70e4
0x00704c: mov      x13, #0x1bf4000000000000
0x007050: movk     x13, #0x64ac, lsl #32
0x007054: movk     x13, #0xb0a4, lsl #16
0x007058: mov      x14, #-0x1bf5000000000000
0x00705c: eor      x11, x12, #0xfffffffffffffffc
0x007060: movk     x13, #0x178e
0x007064: movk     x14, #0x9b53, lsl #32
0x007068: and      x11, x11, x12
0x00706c: sub      x13, x12, x13
0x007070: movk     x14, #0x4f5b, lsl #16
0x007074: sub      x13, x13, x11
0x007078: movk     x14, #0xe872
0x00707c: cmp      x13, x14
0x007080: b.eq     #0x70e4
0x007084: mov      x14, #0x2a0a000000000000
0x007088: movk     x14, #0x42eb, lsl #32
0x00708c: movk     x14, #0xbbb6, lsl #16
0x007090: movk     x14, #0xd88f
0x007094: sub      x13, x12, x14
0x007098: sub      x13, x13, x11
0x00709c: add      x13, x13, x14
0x0070a0: lsl      x14, x13, #3
0x0070a4: mov      x15, xzr
0x0070a8: add      x16, x8, #0x10
0x0070ac: add      x13, x0, x14
0x0070b0: add      x14, x8, x14
0x0070b4: add      x17, x0, #0x10
0x0070b8: ldp      q0, q1, [x16, #-0x10]
0x0070bc: neg      x15, x15
0x0070c0: sub      x12, x12, #4
0x0070c4: add      x16, x16, #0x20
0x0070c8: sub      x15, x25, x15
0x0070cc: cmp      x11, x12
0x0070d0: stp      q0, q1, [x17, #-0x10]
0x0070d4: add      x17, x17, #0x20
0x0070d8: b.ne     #0x70b8
0x0070dc: cbnz     x11, #0x70f0
0x0070e0: b        #0x7100
0x0070e4: mov      x13, x0
0x0070e8: mov      x14, x8
0x0070ec: mov      x11, x12
0x0070f0: ldr      x12, [x14], #8
0x0070f4: sub      x11, x11, #1
0x0070f8: str      x12, [x13], #8
0x0070fc: cbnz     x11, #0x70f0
0x007100: add      x8, x8, x10
0x007104: add      x0, x0, x10
0x007108: mov      x10, #0x6a75000000000000
0x00710c: movk     x10, #0xffc4, lsl #32
0x007110: movk     x10, #0x9bc5, lsl #16
0x007114: movk     x10, #0xd49d
0x007118: orn      w10, w10, w10
0x00711c: and      w9, w9, w10
0x007120: and      x9, x9, #7
0x007124: cbz      x9, #0x7138
0x007128: ldrb     w10, [x8], #1
0x00712c: sub      x9, x9, #1
0x007130: strb     w10, [x0], #1
0x007134: cbnz     x9, #0x7128
0x007138: ldr      x8, [x18, #0xea0]
0x00713c: mov      x10, #0x19db000000000000
0x007140: movk     x10, #0x197f, lsl #32
0x007144: movk     x10, #0x9271, lsl #16
0x007148: ldr      x8, [x8, #0x30]
0x00714c: movk     x10, #0x77b0
0x007150: add      x9, x10, #0
0x007154: sub      x8, x9, x8
0x007158: adrp     x9, #0x1e5000
0x00715c: ldr      x9, [x9, #0xcb8]
0x007160: sub      x8, x8, x10
0x007164: add      x0, x9, x8
0x007168: ldrh     w8, [x0, #0x38]
0x00716c: adrp     x9, #0x1ec000
0x007170: str      x0, [x9, #0xea8]
0x007174: cbz      x8, #0x71d4
0x007178: mov      x13, #0x625f000000000000
0x00717c: ldr      x11, [x0, #0x20]
0x007180: movk     x13, #0xd45e, lsl #32
0x007184: movk     x13, #0x2930, lsl #16
0x007188: movk     x13, #0x6d6e
0x00718c: sub      x12, x0, x13
0x007190: add      x11, x12, x11
0x007194: mov      x10, xzr
0x007198: mov      x9, xzr
0x00719c: add      x11, x11, x13
0x0071a0: ldr      w12, [x11]
0x0071a4: cmp      w12, #1
0x0071a8: b.ne     #0x71c0
0x0071ac: ldr      x9, [x11, #0x28]
0x0071b0: ldr      x12, [x11, #0x10]
0x0071b4: sub      x9, x9, x26
0x0071b8: add      x9, x9, x12
0x0071bc: add      x9, x9, x26
0x0071c0: add      x10, x10, #1
0x0071c4: sub      x8, x8, #1
0x0071c8: add      x11, x11, #0x38
0x0071cc: cbnz     x8, #0x71a0
0x0071d0: b        #0x71d8
0x0071d4: mov      x9, xzr
0x0071d8: mov      x8, #-0x685000000000000
0x0071dc: movk     x8, #0xbc51, lsl #32
0x0071e0: movk     x8, #0xcf02, lsl #16
0x0071e4: movk     x8, #0xdbd3
0x0071e8: orn      x8, x8, x8
0x0071ec: and      x8, x9, x8
0x0071f0: and      x20, x8, #0xfffffffffffff000
0x0071f4: mov      w2, #7
0x0071f8: mov      x1, x20
0x0071fc: bl       #0x1707f0    ; PLT -> mprotect
0x007200: adrp     x8, #0x1ec000
0x007204: ldr      x8, [x8, #0xea8]
0x007208: adrp     x9, #0x1ec000
0x00720c: mov      w1, #0x1000
0x007210: mov      w2, #7
0x007214: add      x8, x8, x20
0x007218: mov      w3, #0x22
0x00721c: mov      w4, #-1
0x007220: mov      x0, xzr
0x007224: mov      x5, xzr
0x007228: str      x8, [x9, #0xeb0]
0x00722c: bl       #0x16ffa0    ; -> iIIIIIIiIi+0x22a14
0x007230: cmn      x0, #0xfff
0x007234: b.hs     #0x6b74
0x007238: str      x0, [x21]
0x00723c: mov      x0, x19
0x007240: bl       #0x171c1c    ; -> iIIIIIIiIi+0x24690
0x007244: adrp     x8, #0x1e5000
0x007248: ldr      x8, [x8, #0x838]
0x00724c: adrp     x9, #0x1e5000
0x007250: ldr      w8, [x8]
0x007254: ldr      x9, [x9, #0xe28]
0x007258: neg      w10, w8
0x00725c: ldr      w9, [x9]
0x007260: mvn      w10, w10
0x007264: mul      w8, w10, w8
0x007268: eor      w10, w8, #0xfffffffe
0x00726c: cmp      w9, #0xa
0x007270: cset     w11, lt
0x007274: cmp      w9, #9
0x007278: cset     w9, gt
0x00727c: tst      w10, w8
0x007280: cset     w8, eq
0x007284: cset     w10, ne
0x007288: eor      w11, w11, w8
0x00728c: orr      w8, w9, w10
0x007290: eor      w8, w8, #1
0x007294: tbnz     w11, #0, #0x72d4
0x007298: tbz      w8, #0, #0x6ba8
0x00729c: b        #0x72d4
0x0072a0: mov      w8, #0x63840000
0x0072a4: mov      x9, #-0x38ae000000000000
0x0072a8: movk     w8, #0xe3f7
0x0072ac: movk     x9, #0xa5bc, lsl #32
0x0072b0: neg      w8, w8
0x0072b4: movk     x9, #0x6384, lsl #16
0x0072b8: sub      w8, w8, w20
0x0072bc: movk     x9, #0xe3f7
0x0072c0: add      x20, x8, x9
0x0072c4: bl       #0x170740    ; -> iIIIIIIiIi+0x231b4
0x0072c8: str      w20, [x0]
0x0072cc: mov      x20, #-1
0x0072d0: b        #0x765c
0x0072d4: sub      x27, sp, #0x470
0x0072d8: mov      sp, x27
0x0072dc: sub      x8, sp, #0x60
0x0072e0: stur     x8, [x29, #-0x60]
0x0072e4: mov      sp, x8
0x0072e8: sub      x19, sp, #0x420
0x0072ec: mov      sp, x19
0x0072f0: sub      x8, sp, #0x420
0x0072f4: stur     x8, [x29, #-0x68]
0x0072f8: mov      sp, x8
0x0072fc: sub      x8, sp, #0x420
0x007300: stur     x8, [x29, #-0x78]
0x007304: mov      sp, x8
0x007308: sub      x8, sp, #0x420
0x00730c: stur     x8, [x29, #-0xa0]
0x007310: mov      sp, x8
0x007314: sub      x8, sp, #0x420
0x007318: stur     x8, [x29, #-0x80]
0x00731c: mov      sp, x8
0x007320: sub      x8, sp, #0x420
0x007324: stur     x8, [x29, #-0x98]
0x007328: mov      sp, x8
0x00732c: sub      x8, sp, #0x420
0x007330: stur     x8, [x29, #-0x90]
0x007334: mov      sp, x8
0x007338: sub      x8, sp, #0x420
0x00733c: stur     x8, [x29, #-0x88]
0x007340: mov      sp, x8
0x007344: sub      x8, sp, #0x420
0x007348: stur     x8, [x29, #-0x70]
0x00734c: mov      sp, x8
0x007350: sub      x28, sp, #0x470
0x007354: mov      sp, x28
0x007358: mov      w0, #1
0x00735c: mov      w1, #0x1070
0x007360: bl       #0x16ff00    ; PLT -> calloc
0x007364: adrp     x22, #0x1e5000
0x007368: ldr      x22, [x22, #0x6a0]
0x00736c: adrp     x1, #0x1ec000
0x007370: str      x0, [x1, #0xea0]
0x007374: and      x8, x22, #0xfffffffffffffffe
0x007378: cmp      x0, x8
0x00737c: b.eq     #0x7590
0x007380: mvn      w9, w22
0x007384: mov      w11, #0x51680000
0x007388: mov      w10, #5
0x00738c: movk     w11, #0xa00a
0x007390: orr      w9, w9, #1
0x007394: bic      w12, w10, w0
0x007398: and      w13, w0, w11
0x00739c: and      w11, w8, w11
0x0073a0: and      w10, w9, w10
0x0073a4: orr      w12, w12, w13
0x0073a8: orr      w10, w10, w11
0x0073ac: eor      w10, w12, w10
0x0073b0: orn      w9, w9, w0
0x0073b4: orn      w9, w10, w9
0x0073b8: mvn      w9, w9
0x0073bc: orr      x9, x9, #0xfffffffffffffff8
0x0073c0: cmn      x9, #1
0x0073c4: b.eq     #0x74c8
0x0073c8: and      x8, x22, #0xfffffffffffffffe
0x0073cc: and      x9, x22, #6
0x0073d0: mov      w10, #8
0x0073d4: bic      w12, w8, w0
0x0073d8: bic      w13, w0, w8
0x0073dc: sub      x9, x10, x9
0x0073e0: orr      w10, w12, w13
0x0073e4: mvn      w10, w10
0x0073e8: orr      x12, x10, #0xfffffffffffffff8
0x0073ec: mov      w11, #0x70
0x0073f0: cmn      x12, #1
0x0073f4: csel     x10, x11, x9, ne
0x0073f8: cmp      x9, #0x1f
0x0073fc: mov      x9, #-1
0x007400: ccmp     x12, x9, #0, ls
0x007404: b.ne     #0x7410
0x007408: mov      w9, #1
0x00740c: tbnz     w9, #0, #0x747c
0x007410: mvn      x9, x10
0x007414: orr      x11, x9, #0xffffffffffffff9f
0x007418: cmn      x11, #1
0x00741c: b.eq     #0x747c
0x007420: mov      x11, #0x541000000000000
0x007424: movk     x11, #0x28f1, lsl #32
0x007428: movk     x11, #0x5273, lsl #16
0x00742c: mvn      w9, w9
0x007430: movk     x11, #0xca2a
0x007434: and      x13, x9, #0x60
0x007438: sub      x14, x10, x11
0x00743c: sub      x14, x14, x13
0x007440: mov      x12, xzr
0x007444: add      x9, x0, x13
0x007448: add      x8, x8, x13
0x00744c: add      x11, x14, x11
0x007450: and      x14, x22, #0xfffffffffffffffe
0x007454: add      x15, x14, x12
0x007458: ldp      q0, q1, [x15]
0x00745c: add      x16, x0, x12
0x007460: add      x12, x12, #0x20
0x007464: cmp      x13, x12
0x007468: stp      q0, q1, [x16]
0x00746c: b.ne     #0x7454
0x007470: cmp      x10, x13
0x007474: b.ne     #0x7484
0x007478: b        #0x7494
0x00747c: mov      x9, x0
0x007480: mov      x11, x10
0x007484: ldrb     w12, [x8], #1
0x007488: sub      x11, x11, #1
0x00748c: strb     w12, [x9], #1
0x007490: cbnz     x11, #0x7484
0x007494: mov      x9, #0x1ab9000000000000
0x007498: movk     x9, #0xaeca, lsl #32
0x00749c: movk     x9, #0xc5b3, lsl #16
0x0074a0: movk     x9, #0x998c
0x0074a4: add      x11, x9, #0x70
0x0074a8: sub      x11, x11, x10
0x0074ac: and      x8, x22, #0xfffffffffffffffe
0x0074b0: sub      x9, x11, x9
0x0074b4: add      x8, x8, x10
0x0074b8: lsr      x11, x9, #3
0x0074bc: add      x0, x0, x10
0x0074c0: cbnz     x11, #0x74d0
0x0074c4: b        #0x7574
0x0074c8: mov      w9, #0x70
0x0074cc: mov      w11, #0xe
0x0074d0: cmp      x11, #4
0x0074d4: lsl      x10, x11, #3
0x0074d8: b.lo     #0x7550
0x0074dc: eor      x12, x11, #0xfffffffffffffffc
0x0074e0: and      x12, x12, x11
0x0074e4: sub      x13, x11, x12
0x0074e8: cbz      x13, #0x7550
0x0074ec: mov      x13, #0x128c000000000000
0x0074f0: movk     x13, #0x4b8c, lsl #32
0x0074f4: movk     x13, #0xfc69, lsl #16
0x0074f8: movk     x13, #0xfe76
0x0074fc: sub      x14, x11, x13
0x007500: sub      x14, x14, x12
0x007504: add      x13, x14, x13
0x007508: lsl      x14, x13, #3
0x00750c: mov      x15, xzr
0x007510: add      x16, x8, #0x10
0x007514: add      x17, x0, #0x10
0x007518: add      x13, x0, x14
0x00751c: add      x14, x8, x14
0x007520: mov      w18, #4
0x007524: ldp      q0, q1, [x16, #-0x10]
0x007528: neg      x15, x15
0x00752c: sub      x11, x11, #4
0x007530: add      x16, x16, #0x20
0x007534: sub      x15, x18, x15
0x007538: cmp      x12, x11
0x00753c: stp      q0, q1, [x17, #-0x10]
0x007540: add      x17, x17, #0x20
0x007544: b.ne     #0x7524
0x007548: cbnz     x12, #0x755c
0x00754c: b        #0x756c
0x007550: mov      x13, x0
0x007554: mov      x14, x8
0x007558: mov      x12, x11
0x00755c: ldr      x11, [x14], #8
0x007560: sub      x12, x12, #1
0x007564: str      x11, [x13], #8
0x007568: cbnz     x12, #0x755c
0x00756c: add      x8, x8, x10
0x007570: add      x0, x0, x10
0x007574: eor      x10, x9, #0xfffffffffffffff8
0x007578: and      x9, x10, x9
0x00757c: cbz      x9, #0x7590
0x007580: ldrb     w10, [x8], #1
0x007584: sub      x9, x9, #1
0x007588: strb     w10, [x0], #1
0x00758c: cbnz     x9, #0x7580
0x007590: ldr      x8, [x1, #0xea0]
0x007594: adrp     x9, #0x1e5000
0x007598: ldr      x8, [x8, #0x30]
0x00759c: ldr      x9, [x9, #0xcb8]
0x0075a0: sub      x0, x9, x8
0x0075a4: adrp     x8, #0x1ec000
0x0075a8: ldrh     w9, [x0, #0x38]
0x0075ac: str      x0, [x8, #0xea8]
0x0075b0: mov      x8, #-0x7447000000000000
0x0075b4: movk     x8, #0x13c2, lsl #32
0x0075b8: movk     x8, #0x2a08, lsl #16
0x0075bc: movk     x8, #0xbc02
0x0075c0: cbz      x9, #0x7604
0x0075c4: ldr      x12, [x0, #0x20]
0x0075c8: mov      x11, xzr
0x0075cc: mov      x10, xzr
0x0075d0: add      x12, x0, x12
0x0075d4: ldr      w13, [x12]
0x0075d8: cmp      w13, #1
0x0075dc: b.ne     #0x75f0
0x0075e0: ldr      x10, [x12, #0x10]
0x0075e4: ldr      x13, [x12, #0x28]
0x0075e8: neg      x10, x10
0x0075ec: sub      x10, x13, x10
0x0075f0: add      x11, x11, #1
0x0075f4: sub      x9, x9, #1
0x0075f8: add      x12, x12, #0x38
0x0075fc: cbnz     x9, #0x75d4
0x007600: b        #0x7608
0x007604: mov      x10, xzr
0x007608: orn      x8, x8, x8
0x00760c: and      x8, x10, x8
0x007610: and      x21, x8, #0xfffffffffffff000
0x007614: mov      w2, #7
0x007618: mov      x1, x21
0x00761c: bl       #0x1707f0    ; PLT -> mprotect
0x007620: adrp     x8, #0x1ec000
0x007624: ldr      x8, [x8, #0xea8]
0x007628: adrp     x9, #0x1ec000
0x00762c: mov      w1, #0x1000
0x007630: mov      w2, #7
0x007634: add      x8, x8, x21
0x007638: mov      w3, #0x22
0x00763c: mov      w4, #-1
0x007640: mov      x0, xzr
0x007644: mov      x5, xzr
0x007648: str      x8, [x9, #0xeb0]
0x00764c: bl       #0x16ffa0    ; -> iIIIIIIiIi+0x22a14
0x007650: mov      x20, x0
0x007654: cmn      x20, #0xfff
0x007658: b.hs     #0x72a0
0x00765c: adrp     x8, #0x1ec000
0x007660: adrp     x21, #0x1e5000
0x007664: ldr      x8, [x8, #0xea0]
0x007668: ldr      x21, [x21, #0x7e8]
0x00766c: adrp     x9, #0x1ec000
0x007670: ldr      x24, [x9, #0xea8]
0x007674: mov      x0, x27
0x007678: str      x20, [x21]
0x00767c: ldr      x25, [x8, #0x60]
0x007680: add      x26, x24, x25
0x007684: ldr      x23, [x26]
0x007688: bl       #0x171c1c    ; -> iIIIIIIiIi+0x24690
0x00768c: adrp     x8, #0x1e5000
0x007690: ldr      x8, [x8, #0x838]
0x007694: adrp     x9, #0x1e5000
0x007698: ldr      w8, [x8]
0x00769c: ldr      x9, [x9, #0xe28]
0x0076a0: sub      w10, w8, #1
0x0076a4: ldr      w9, [x9]
0x0076a8: cmp      w9, #9
0x0076ac: mul      w9, w10, w8
0x0076b0: eor      w10, w9, #0xfffffffe
0x0076b4: cset     w8, gt
0x0076b8: tst      w10, w9
0x0076bc: cset     w9, ne
0x0076c0: eor      w10, w8, w9
0x0076c4: tbz      w10, #0, #0x6b08
0x0076c8: add      x1, x26, #4
0x0076cc: mov      w3, #0x10
0x0076d0: mov      w4, #0x10
0x0076d4: mov      x0, x27
0x0076d8: mov      x2, x1
0x0076dc: bl       #0x171c28    ; -> iIIIIIIiIi+0x2469c
0x0076e0: adrp     x8, #0x1e5000
0x0076e4: ldr      x8, [x8, #0x838]
0x0076e8: adrp     x9, #0x1e5000
0x0076ec: adrp     x2, #0x1ec000
0x0076f0: ldr      w8, [x8]
0x0076f4: ldr      x9, [x9, #0xe28]
0x0076f8: sub      w10, w8, #1
0x0076fc: ldr      w9, [x9]
0x007700: mul      w10, w10, w8
0x007704: cmp      w9, #0xa
0x007708: cset     w11, lt
0x00770c: cmp      w9, #9
0x007710: eor      w9, w10, #0xfffffffe
0x007714: cset     w8, gt
0x007718: tst      w9, w10
0x00771c: cset     w9, eq
0x007720: eor      w10, w11, w9
0x007724: cset     w9, ne
0x007728: tbnz     w10, #0, #0x773c
0x00772c: orr      w8, w8, w9
0x007730: eor      w8, w8, #1
0x007734: tbnz     w8, #0, #0x773c
0x007738: b        #0x7738
0x00773c: mov      x11, #-0x7e21000000000000
0x007740: mov      x12, #0x5d73000000000000
0x007744: movk     x11, #0x5b88, lsl #32
0x007748: movk     x12, #0xdc14, lsl #32
0x00774c: add      x8, x26, #0x14
0x007750: movk     x11, #0xdb85, lsl #16
0x007754: movk     x12, #0x6a93, lsl #16
0x007758: stp      x28, x27, [x29, #-0xd8]
0x00775c: mov      w9, #8
0x007760: movk     x11, #0xb63
0x007764: movk     x12, #0x3911
0x007768: mov      x14, #0x2b9b000000000000
0x00776c: mov      x15, #0x2944000000000000
0x007770: mov      x17, #-0x5fcc000000000000
0x007774: mov      x18, #0x5a5f000000000000
0x007778: mov      x0, #0x6e70000000000000
0x00777c: mov      x5, #-0x5e00000000000000
0x007780: mov      x6, #0x39d3000000000000
0x007784: eor      x16, x8, #0xfffffffffffffff8
0x007788: mov      x7, #-0x477c000000000000
0x00778c: mov      x27, #-0x577000000000000
0x007790: movk     x14, #0xe195, lsl #32
0x007794: movk     x15, #0x7fac, lsl #32
0x007798: movk     x17, #0xd94b, lsl #32
0x00779c: movk     x18, #0xdad3, lsl #32
0x0077a0: movk     x0, #0x56b8, lsl #32
0x0077a4: movk     x5, #0xcf7, lsl #32
0x0077a8: movk     x6, #0x9593, lsl #32
0x0077ac: sub      x1, x9, x11
0x0077b0: sub      x9, x9, x12
0x0077b4: and      x16, x16, x8
0x0077b8: movk     x7, #0x414b, lsl #32
0x0077bc: movk     x27, #0x1c8f, lsl #32
0x0077c0: add      x13, x24, x25
0x0077c4: movk     x14, #0xc5ad, lsl #16
0x0077c8: movk     x15, #0xef65, lsl #16
0x0077cc: movk     x17, #0xccb1, lsl #16
0x0077d0: movk     x18, #0xa2b9, lsl #16
0x0077d4: movk     x0, #0x3438, lsl #16
0x0077d8: movk     x5, #0x88e2, lsl #16
0x0077dc: movk     x6, #0x6fa6, lsl #16
0x0077e0: sub      x1, x1, x16
0x0077e4: sub      x9, x9, x16
0x0077e8: movk     x7, #0xe6e0, lsl #16
0x0077ec: movk     x27, #0x30e2, lsl #16
0x0077f0: mov      w10, #0x1000
0x0077f4: movk     x14, #0xd36f
0x0077f8: movk     x15, #0xded9
0x0077fc: movk     x17, #0xa385
```


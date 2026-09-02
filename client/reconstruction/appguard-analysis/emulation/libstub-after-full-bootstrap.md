# AppGuard libstub stage after extended libcompatible bootstrap

- bootstrap stop: `instruction limit 30000000`
- bootstrap instructions: **30000001**
- callback captured: **True**
- writes into `0x4d000..0x52000`: **20480**
- write range: `0x4d000..0x52000`
- target `+0x4d1d0` before SHA: `e1842634f7f2956417b6cce35230c304e3dc6144827857b3747cbb490c5a24ee`
- target `+0x4d1d0` after SHA: `9414357b2cbcdefa0d241e08af60f7fb168c91bf6e4115249f120a104898bcf2`
- valid ARM64 words in first 0x800 bytes after: **512 / 512**

## Decrypted target head

```asm
0x4d1d0: stp x28, x27, [sp, #-0x60]!
0x4d1d4: stp x26, x25, [sp, #0x10]
0x4d1d8: stp x24, x23, [sp, #0x20]
0x4d1dc: stp x22, x21, [sp, #0x30]
0x4d1e0: stp x20, x19, [sp, #0x40]
0x4d1e4: stp x29, x30, [sp, #0x50]
0x4d1e8: add x29, sp, #0x50
0x4d1ec: sub sp, sp, #0x80
0x4d1f0: stur x0, [x29, #-0xc8]
0x4d1f4: mrs x8, tpidr_el0
0x4d1f8: ldr x8, [x8, #0x28]
0x4d1fc: adrp x9, #0x1e5000
0x4d200: ldr x9, [x9, #0xdb8]
0x4d204: adrp x10, #0x1e6000
0x4d208: ldr x10, [x10, #0x128]
0x4d20c: stur x8, [x29, #-0x58]
0x4d210: ldr w8, [x9]
0x4d214: ldr w9, [x10]
0x4d218: sub w10, w8, #1
0x4d21c: mul w8, w10, w8
0x4d220: cmp w9, #0xa
0x4d224: mvn w8, w8
0x4d228: cset w10, lt
0x4d22c: cmp w9, #9
0x4d230: orr w9, w8, #0xfffffffe
0x4d234: cset w8, gt
0x4d238: cmn w9, #1
0x4d23c: cset w9, eq
0x4d240: eor w10, w10, w9
0x4d244: cset w9, ne
0x4d248: tbnz w10, #0, #0x4d278
0x4d24c: orr w8, w8, w9
0x4d250: eor w8, w8, #1
0x4d254: tbnz w8, #0, #0x4d278
0x4d258: b #0x4d258
0x4d25c: mov w8, #0x55340000
0x4d260: movk w8, #0xef96
0x4d264: neg w9, w8
0x4d268: sub w9, w9, w0
0x4d26c: add w19, w9, w8
0x4d270: bl #0x170740
0x4d274: str w19, [x0]
0x4d278: sub x23, sp, #0x40
0x4d27c: mov sp, x23
0x4d280: sub x8, sp, #0x10
0x4d284: stur x8, [x29, #-0x98]
0x4d288: mov sp, x8
0x4d28c: sub x21, sp, #0x420
0x4d290: mov sp, x21
0x4d294: sub x19, sp, #0x420
0x4d298: mov sp, x19
0x4d29c: sub x20, sp, #0x420
0x4d2a0: mov sp, x20
0x4d2a4: sub x27, sp, #0x420
0x4d2a8: mov sp, x27
0x4d2ac: sub x28, sp, #0x420
0x4d2b0: mov sp, x28
0x4d2b4: sub x26, sp, #0x420
0x4d2b8: mov sp, x26
0x4d2bc: sub x25, sp, #0x420
0x4d2c0: mov sp, x25
0x4d2c4: sub x8, sp, #0x420
0x4d2c8: stur x8, [x29, #-0xa8]
0x4d2cc: mov sp, x8
0x4d2d0: sub x8, sp, #0x420
0x4d2d4: stur x8, [x29, #-0xb8]
0x4d2d8: mov sp, x8
0x4d2dc: sub x8, sp, #0x420
0x4d2e0: stur x8, [x29, #-0xb0]
0x4d2e4: mov sp, x8
0x4d2e8: sub x8, sp, #0x40
0x4d2ec: stur x8, [x29, #-0xa0]
0x4d2f0: mov sp, x8
0x4d2f4: sub x8, sp, #0x10
0x4d2f8: stur x8, [x29, #-0xc0]
0x4d2fc: mov sp, x8
0x4d300: adrp x24, #0x1e5000
0x4d304: ldr x24, [x24, #0xc68]
0x4d308: adrp x11, #0x1e5000
0x4d30c: mov x9, #-0x7a6c000000000000
0x4d310: movk x9, #0xf7e5, lsl #32
0x4d314: ldr x8, [x24]
0x4d318: movk x9, #0xe7db, lsl #16
0x4d31c: movk x9, #0xdb0b
0x4d320: mov w7, #-0x1cb00000
0x4d324: ldp x10, x8, [x8, #0x80]
0x4d328: ldr x11, [x11, #0xd38]
0x4d32c: mov w2, #7
0x4d330: sub x3, x29, #0x60
0x4d334: add x8, x8, #0xfff
0x4d338: ldr x11, [x11, #0xa0]
0x4d33c: and x8, x8, #0xfffffffffffff000
0x4d340: and x0, x10, #0xfffffffffffff000
0x4d344: sub x8, x8, x9
0x4d348: sub x8, x8, x0
0x4d34c: add x1, x8, x9
0x4d350: mov w8, #7
0x4d354: sub x4, x29, #0x64
0x4d358: mov w5, #0xe2
0x4d35c: mov w6, #0xd9
0x4d360: movk w7, #0xf787
0x4d364: stur w8, [x29, #-0x64]
0x4d368: stur x1, [x29, #-0x60]
0x4d36c: blr x11
0x4d370: cmn w0, #0xfff
0x4d374: b.hs #0x4d470
0x4d378: adrp x8, #0x1e5000
0x4d37c: ldr x9, [x24]
0x4d380: ldr x8, [x8, #0xdb8]
0x4d384: mov w12, #0x2c600000
0x4d388: movk w12, #0x54d8
0x4d38c: ldr w10, [x8]
0x4d390: adrp x8, #0x1e6000
0x4d394: ldr x8, [x8, #0x128]
0x4d398: ldr x22, [x9, #0x80]
0x4d39c: add w13, w10, w12
0x4d3a0: sub w13, w13, #1
0x4d3a4: sub w12, w13, w12
0x4d3a8: ldr w11, [x8]
0x4d3ac: mul w10, w12, w10
```

## Bootstrap checkpoints

| Instructions | PC | Target SHA | valid/512 |
|---:|---:|---|---:|
| 4000000 | `0xf33c` | `8e00d1578f71a1717f19a0c297a6dedf8d2d169adc05bd257c4c21c8a0c0f0f6` | 512 |
| 8000000 | `0xfe14` | `9414357b2cbcdefa0d241e08af60f7fb168c91bf6e4115249f120a104898bcf2` | 512 |
| 12000000 | `0xfb18` | `9414357b2cbcdefa0d241e08af60f7fb168c91bf6e4115249f120a104898bcf2` | 512 |
| 20000000 | `0xfdac` | `9414357b2cbcdefa0d241e08af60f7fb168c91bf6e4115249f120a104898bcf2` | 512 |
| 30000000 | `0x10d20` | `9414357b2cbcdefa0d241e08af60f7fb168c91bf6e4115249f120a104898bcf2` | 512 |

## libstub stage

- stop: `unsupported direct syscall 7884805022383697014 at 0x1001cd84`
- instructions: **20**
- protected libstub bytes changed: **0**
- observed libstub writes: **0**
- weak SoLibraryStart probe changed: **False**

### External calls

- none

### Direct exceptions/syscalls

- pc=`0x1001cd84` intno=1 nr=`7884805022383697014` name=`sys_7884805022383697014`

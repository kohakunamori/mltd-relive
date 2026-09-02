# `asmFunction` backward definition slices

- DT_INIT blocks: **1245**

| Field | Write | Reg | Nearest definition(s) | Edge distance |
|---:|---:|---|---|---:|
| `+0x0` | `0x87c0` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 9 |
| `+0x8` | `0x87d4` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 9 |
| `+0x10` | `0x86a4` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 8 |
| `+0x18` | `0x85b0` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 7 |
| `+0x20` | `0x8884` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 7 |
| `+0x28` | `0x8894` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 8 |
| `+0x30` | `0x882c` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 9 |
| `+0x38` | `0x86d8` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 8 |
| `+0x40` | `0x8574` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 8 |
| `+0x48` | `0x8644` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 8 |
| `+0x50` | `0x8588` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 8 |
| `+0x58` | `0x85e8` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 8 |
| `+0x60` | `0x84e8` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 7 |
| `+0x68` | `0x850c` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 7 |
| `+0x70` | `0x8608` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 8 |
| `+0x78` | `0x859c` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 7 |
| `+0x80` | `0x8874` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 10 |
| `+0x88` | `0x84bc` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 9 |
| `+0x90` | `0x88d8` | `x27` | `0x7eec: add x27, x20, w14, uxtw` | 10 |
| `+0x98` | `0xc2798` | `x19` | `0xc2240: add x19, x14, w12, uxtw #2` | 4 |
| `+0xa0` | `0xc2798` | `x19` | `0xc2240: add x19, x14, w12, uxtw #2` | 4 |

## `asmFunction+0x0`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x84c4(cfg) <- 0x84cc(cfg) <- 0x85a4(cfg) <- 0x86e0(cfg) <- 0x8718(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x8`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x84c4(cfg) <- 0x84cc(cfg) <- 0x85a4(cfg) <- 0x86e0(cfg) <- 0x87c8(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x10`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x844c(cfg) <- 0x84f0(cfg) <- 0x84fc(cfg) <- 0x864c(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x18`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x84c4(cfg) <- 0x84cc(cfg) <- 0x85a4(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x20`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x844c(cfg) <- 0x8454(cfg) <- 0x8460(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x28`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x844c(cfg) <- 0x84f0(cfg) <- 0x85b8(cfg) <- 0x87dc(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x30`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x844c(cfg) <- 0x84f0(cfg) <- 0x85b8(cfg) <- 0x87dc(cfg) <- 0x87e4(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x38`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x844c(cfg) <- 0x8454(cfg) <- 0x8590(cfg) <- 0x86ac(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x40`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x84c4(cfg) <- 0x8514(cfg) <- 0x8520(cfg) <- 0x8568(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x48`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x84c4(cfg) <- 0x84cc(cfg) <- 0x84d8(cfg) <- 0x8610(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x50`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x84c4(cfg) <- 0x8514(cfg) <- 0x8520(cfg) <- 0x857c(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x58`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x844c(cfg) <- 0x84f0(cfg) <- 0x85b8(cfg) <- 0x85bc(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x60`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x84c4(cfg) <- 0x84cc(cfg) <- 0x84d8(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x68`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x844c(cfg) <- 0x84f0(cfg) <- 0x84fc(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x70`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x84c4(cfg) <- 0x8514(cfg) <- 0x85f0(cfg) <- 0x85f8(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x78`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x844c(cfg) <- 0x8454(cfg) <- 0x8590(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x80`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x84c4(cfg) <- 0x8514(cfg) <- 0x85f0(cfg) <- 0x8834(cfg) <- 0x883c(cfg) <- 0x8844(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x88`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x844c(cfg) <- 0x8454(cfg) <- 0x8460(cfg) <- 0x8468(cfg) <- 0x8470(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x90`

### definition `0x7eec`; reverse path: 0x7ed0(cfg) <- 0x8190(cfg) <- 0x83b4(cfg) <- 0x8414(cfg) <- 0x84c4(cfg) <- 0x8514(cfg) <- 0x85f0(cfg) <- 0x8834(cfg) <- 0x889c(cfg) <- 0x88a0(cfg)

```asm
0x7ed0: ldur x8, [x29, #-0xc0]
0x7ed4: mov w9, #0xc
0x7ed8: stur x10, [x29, #-0xb0]
0x7edc: stur w14, [x29, #-0xa4]
0x7ee0: nop 
0x7ee4: madd x21, x10, x9, x8
0x7ee8: ldr w9, [x21, #4]
0x7eec: add x27, x20, w14, uxtw  ; <-- definition
0x7ef0: mov x14, #0x6cc9000000000000
0x7ef4: movk x14, #0x119, lsl #32
0x7ef8: add x11, x22, x9
0x7efc: eor w12, w9, #0xfffffffe
0x7f00: sub x13, x11, #1
0x7f04: tst w12, w9
0x7f08: csel x24, x11, x13, eq
```


## `asmFunction+0x98`

### definition `0xc2240`; reverse path: 0xc2150(cfg) <- 0xc2448(cfg) <- 0xc254c(cfg) <- 0xc2650(cfg)

```asm
0xc2224: str q0, [sp]
0xc2228: ldr q0, [x9]
0xc222c: mul x9, x11, x13
0xc2230: lsr x9, x9, #0x23
0xc2234: lsl w13, w9, #4
0xc2238: sub w9, w13, w9
0xc223c: sub x13, x29, #0x50
0xc2240: add x19, x14, w12, uxtw #2  ; <-- definition
0xc2244: cmp x19, x13
0xc2248: lsl w13, w15, #2
0xc224c: mov x10, #0x4a07000000000000
0xc2250: sub w9, w11, w9
0xc2254: lsl w11, w12, #2
0xc2258: add w13, w13, #0x198
0xc225c: movk x10, #0x108, lsl #32
```


## `asmFunction+0xa0`

### definition `0xc2240`; reverse path: 0xc2150(cfg) <- 0xc2448(cfg) <- 0xc254c(cfg) <- 0xc2650(cfg)

```asm
0xc2224: str q0, [sp]
0xc2228: ldr q0, [x9]
0xc222c: mul x9, x11, x13
0xc2230: lsr x9, x9, #0x23
0xc2234: lsl w13, w9, #4
0xc2238: sub w9, w13, w9
0xc223c: sub x13, x29, #0x50
0xc2240: add x19, x14, w12, uxtw #2  ; <-- definition
0xc2244: cmp x19, x13
0xc2248: lsl w13, w15, #2
0xc224c: mov x10, #0x4a07000000000000
0xc2250: sub w9, w11, w9
0xc2254: lsl w11, w12, #2
0xc2258: add w13, w13, #0x198
0xc225c: movk x10, #0x108, lsl #32
```


# AppGuard runtime loader callback CFG

- entry: `0xd356c`
- blocks: **1**
- instructions: **6**
- direct calls: **0**
- indirect-call boundaries: **0**
- invalid boundaries: **0**

## Imported functions reached

| Import | Calls |
|---|---:|

## Direct calls

| Callsite | Depth | Target | Label | Import |
|---:|---:|---:|---|---|

## Indirect-call boundaries

| Address | Depth | Instruction | Owner |
|---:|---:|---|---|

## First code blocks

### `0xd356c` depth 0 (ret)

```asm
0xd356c: ldr x19, [x19, #0x20]
0xd3570: mov x2, x19
0xd3574: ldr x20, [x20, #0x10]
0xd3578: mov x0, x20
0xd357c: ldr x0, [x0, #8]
0xd3580: ret 
```


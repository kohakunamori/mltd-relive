# Minimal AppGuard `DT_INIT` emulation

- sample: `8880c415e1ab82c31858be68ce12b76b95dc8ff8875b76c1246a8bc0679647bc`
- instructions executed: **336**
- relocations applied: **3105**
- external stubs: **130**
- stop: `Unicorn error: Unhandled CPU exception (UC_ERR_EXCEPTION)`
- forced opaque edges: **0**
- invalid memory accesses: **0**

## Runtime snapshots

| Checkpoint | config ptr | +0x70 u32 | diff vs relocated source | RWX nonzero |
|---|---:|---:|---:|---:|
| `source-copy-complete` | `0x5000001000` | `0x0` | 3321 | - |
| `final-state` | `0x5000001000` | `0x0` | 3321 | - |

## External calls reached

- `calloc`: 1
- `mprotect`: 1

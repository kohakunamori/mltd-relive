# AppGuard `DT_INIT` emulation with direct-syscall handling

- instructions executed: **4000001**
- stop: `instruction limit 4000000`
- direct SVC calls: **1**
- invalid memory accesses: **0**

## Runtime snapshots

| Checkpoint | config ptr | +0x70 u32 | diff vs loaded source | RWX nonzero |
|---|---:|---:|---:|---:|
| `source-copy-complete` | `0x5000001000` | `0x0` | 3321 | - |
| `rwx-mmap-returned` | `0x5000001000` | `0x0` | 3321 | 0 |
| `builder-entry` | `0x5000001000` | `0x12` | 3889 | 0 |
| `asm-table-complete` | `0x5000001000` | `0x12` | 3889 | 818 |

## Direct syscalls

| # | PC | nr | name | x0 | x1 | x2 |
|---:|---:|---:|---|---:|---:|---:|
| 0 | `0x100d2338` | 222 | `mmap` | `0x0` | `0x1000` | `0x7` |

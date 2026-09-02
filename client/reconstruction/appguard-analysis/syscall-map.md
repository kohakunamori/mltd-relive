# AppGuard direct-syscall / loader map

This report disassembles executable PT_LOAD segments directly, so it remains useful when AppGuard has damaged section names/metadata.

## `libcompatible.so`

- AArch64 `asm_*` wrapper symbols: **18**
- direct calls resolved to those wrappers: **0**
- raw `svc` instructions: **0**

### Exported syscall/helper wrappers

| Symbol | Address | First instructions |
|---|---:|---|
| `asm_close` | `0xd2340` | `` |
| `asm_fstatat` | `0xd34a0` | `` |
| `asm_getdents64` | `0xd2370` | `` |
| `asm_getpid` | `0xd2420` | `` |
| `asm_inotify_add_watch` | `0xd2410` | `` |
| `asm_inotify_init` | `0xd2400` | `` |
| `asm_kill` | `0xd2380` | `` |
| `asm_lseek` | `0xd2390` | `` |
| `asm_mmap2` | `0xd2350` | `` |
| `asm_mprotect` | `0xd23a0` | `` |
| `asm_munmap` | `0xd23b0` | `` |
| `asm_openat` | `0xd2360` | `` |
| `asm_prctl` | `0xd23e0` | `` |
| `asm_ptrace` | `0xd2430` | `` |
| `asm_read` | `0xd23c0` | `` |
| `asm_readlink_64` | `0xd23f0` | `` |
| `asm_waitpid` | `0xd3910` | `` |
| `asm_write` | `0xd23d0` | `` |

### Highest-scoring loader candidates

| Score | Function | Wrapper set |
|---:|---|---|

### Decoded raw SVC syscalls

| Address | Owner | x8 | Syscall |
|---:|---|---:|---|

## `libstub.so`

- AArch64 `asm_*` wrapper symbols: **0**
- direct calls resolved to those wrappers: **0**
- raw `svc` instructions: **0**

### Exported syscall/helper wrappers

| Symbol | Address | First instructions |
|---|---:|---|

### Highest-scoring loader candidates

| Score | Function | Wrapper set |
|---:|---|---|

### Decoded raw SVC syscalls

| Address | Owner | x8 | Syscall |
|---:|---|---:|---|

## `libcompatible_x86.so`

Skipped: not AArch64

## `libengine-hlp.so`

Skipped: not AArch64


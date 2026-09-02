# AppGuard static trampoline-config extraction

- sample: `8880c415e1ab82c31858be68ce12b76b95dc8ff8875b76c1246a8bc0679647bc`
- relocations parsed: **3105**

## Key globals

| Name | Slot | Relocation | Resolved pointer | File offset |
|---|---:|---|---:|---:|
| `runtime_config_source` | `0x1e56a0` | R_AARCH64_GLOB_DAT:iiIiiIIiII1 add=0x0 | `0x94c` | `0x94c` |
| `asmfunction_tail_code_pool` | `0x1e59e0` | R_AARCH64_GLOB_DAT:iiliiilill add=0x0 | `0xd34b0` | `0xd34b0` |

## Extracted 0x1070 config

- source VA: `0x94c`
- file offset: `0x94c`
- SHA-256: `23de57c729f52e48552aad4221c6227aeccb56d3f568fcdbc51670a6517dddfc`
- descriptor count @ +0x70: **285214125**
- generated RWX bytes: **None**

| # | id | src_off | size | dest_off | blob | AArch64 |
|---:|---:|---:|---:|---:|---|---|

## Tail (+0x98/+0xa0) code-pool global

- pointer: `0xd34b0`
- file offset: `0xd34b0`
- file-backed: **True**

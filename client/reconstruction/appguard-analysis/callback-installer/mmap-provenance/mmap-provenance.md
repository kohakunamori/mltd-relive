# AppGuard mapping provenance before fallback callback

- bootstrap: `bootstrap callback table ready`
- installer: `None`
- JNI: `Unicorn error: Invalid memory fetch (UC_ERR_FETCH_UNMAPPED); pc=0x7250`
- mapping/protection events: **2**
- mmap events: **1**
- requested low mmap: **1**
- fixed mmap: **0**
- executable mmap: **1**
- mappings that would cover `0x7250` if request were honored: **0**

## mmap requests

| # | stage | source | callsite | requested | len | prot | flags | returned | low | fixed | exec | covers 0x7250 |
|---:|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | `bootstrap` | `svc` | `+0xd2338` | `0x0` | `0x1000` | `0x7` | `0x22` | `0x5100001000` | True | False | True | False |

## mprotect / munmap / madvise

| # | stage | API | callsite | x0 | x1 | x2 | x3 | return |
|---:|---|---|---:|---:|---:|---:|---:|---:|
| 0 | `bootstrap` | `mprotect` | `+0x761c` | `0x10000000` | `0x20e000` | `0x7` | `0x0` | `0x0` |

## Callback slots after installer

| slot | value |
|---:|---:|
| `0x1eb838` | `0x7250` |
| `0x1eb840` | `0x3420` |
| `0x1eb848` | `0x2530` |
| `0x1eb850` | `0x1100` |
| `0x1eb858` | `0x4580` |
| `0x1eb860` | `0x7510` |
| `0x1eb868` | `0x7130` |

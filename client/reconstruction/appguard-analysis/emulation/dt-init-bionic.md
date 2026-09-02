# AppGuard DT_INIT with Android/Bionic rand semantics

- stop: `instruction limit 4000000`
- instructions: **4000001**
- rand/random calls: **20**
- srand/srandom calls: **1**
- loader callback captured: **True**

## First PRNG calls

| # | API | value/seed |
|---:|---|---:|
| 0 | `srand` | `0x0` |
| 1 | `rand` | `0x6b101346` |
| 2 | `rand` | `0x322b7fb2` |
| 3 | `rand` | `0x63cf1b50` |
| 4 | `rand` | `0x659ed455` |
| 5 | `rand` | `0x744e733f` |
| 6 | `rand` | `0x18cbc05c` |
| 7 | `rand` | `0x2a367506` |
| 8 | `rand` | `0x61db66e0` |
| 9 | `rand` | `0x22fde1e8` |
| 10 | `rand` | `0x4613a7cc` |
| 11 | `rand` | `0x3c840028` |
| 12 | `rand` | `0x4fd8eabe` |
| 13 | `rand` | `0x2db3f870` |
| 14 | `rand` | `0x40fb3326` |
| 15 | `rand` | `0x7923463b` |
| 16 | `rand` | `0x74199b39` |
| 17 | `rand` | `0x5075c7df` |
| 18 | `rand` | `0x5af2d378` |
| 19 | `rand` | `0x10bd5c3d` |
| 20 | `rand` | `0x4c9015f1` |

## Runtime table snapshots

| checkpoint | +0x98 | +0xa0 |
|---|---:|---:|
| `source-copy-complete` | `0x0` | `0x0` |
| `rwx-mmap-returned` | `0x0` | `0x0` |
| `builder-entry` | `0x0` | `0x0` |
| `asm-table-complete` | `0x0` | `0x0` |
| `loader-callback-installed` | `0x100d356c` | `0x100d356c` |

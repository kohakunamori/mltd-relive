# AppGuard SIGILL / lazy-decryption bridge analysis

- runtime stop: `instruction limit 9000000`
- runtime instructions: **9000001**
- callback captured: **True**
- static signal-family callsites: **0**
- runtime signal-family calls: **0**
- pointers into decrypted `+0x4d000..+0x52000`: **2**

## Static signal-family PLT callsites

- none

## Runtime signal-family calls

| API | signal | handler / act | args |
|---|---:|---|---|
| - | - | - | - |

## Runtime pointers into decrypted code region

| Region | Storage | Target | Target rel | Context qwords |
|---|---:|---:|---:|---|
| `mmap` | `0x5100002088` | `0x1004d1d0` | `0x4d1d0` | `+0x1068=0x10070d30 +0x1070=0x524 +0x1078=0x54ffff0c2e50cbcf +0x1080=0x1001b660 +0x1088=0x1004d1d0 +0x1090=0x31b70 +0x1098=0xb82c680df36e7bd1 +0x10a0=0x101712a8 +0x10a8=0x10171878` |
| `mmap` | `0x51000020c0` | `0x1004d1d0` | `0x4d1d0` | `+0x10a0=0x101712a8 +0x10a8=0x10171878 +0x10b0=0x5d0 +0x10b8=0x8b05080f272245f7 +0x10c0=0x1004d1d0 +0x10c8=0x100521fc +0x10d0=0x502c +0x10d8=0xeb09025fe7d08d99 +0x10e0=0x100521fc` |

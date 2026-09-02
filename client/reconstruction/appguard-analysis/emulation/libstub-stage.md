# Cross-library AppGuard `libcompatible -> libstub` emulation

- libcompatible bootstrap stop: `libcompatible loader callback ready`
- callback captured: **True**
- libstub stage stop: `unsupported direct syscall 7884805022383697014 at 0x1001cd84`
- libstub stage instructions: **20**
- libstub bytes changed: **0**
- observed libstub writes: **0**

## Proven entry

- `SoLibraryStart = libcompatible+0xc0d64`
- `x0 = libstub+0x16000` = `0x20016000`
- libstub `JUMP_SLOT[SoLibraryStart] = 0x20041e70` -> `0x100c0d64`

## Encrypted weak `SoLibraryStart` probe

- before SHA-256: `bebe2d7d56bfd6167775a10765dbb5a89aaaacf3edb02b54ea46b4b04349178a`; valid words: 27
- after SHA-256: `bebe2d7d56bfd6167775a10765dbb5a89aaaacf3edb02b54ea46b4b04349178a`; valid words: 27
- changed: **False**

## Modified libstub ranges

| Start | End | Size |
|---:|---:|---:|
| - | - | 0 |

## Loader-related/external calls

| API | Args | String arg |
|---|---|---|
| - | - | - |

## ELF / metadata magic after stage

| Region | Size | ELF offsets | metadata offsets |
|---|---:|---|---|
| `heap` | 5008 | - | - |
| `mmap` | 4096 | - | - |
| `libstub` | 880640 | 0x0 | - |

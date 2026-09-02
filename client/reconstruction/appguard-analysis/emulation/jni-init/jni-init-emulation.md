# AppGuard `AppGuardProxyApplication` JNI initializer emulation

- bootstrap stop: `bootstrap callback table ready`
- callback table captured: **True**
- JNI entry: `libcompatible+0x1338e4`
- JNI stop: `external fatal call: abort`
- JNI instructions: **22416**
- callback slot final: `0x0`
- callback-slot writes: **0**

## Pre-decrypted ranges

| Range | Key source | Key | XOR bytes |
|---|---:|---|---:|
| `0x1b660..0x4d1d0` | `0x7080c` | `a80b00d008d18db9c90b00f029e12291` | 203632 |
| `0x4d1d0..0x521fc` | `0x1712a8` | `a80300b008d18db9c90300d029e12291` | 20512 |

## JNI calls reached

| # | index | API | details |
|---:|---:|---|---|
| 0 | 21 | `NewGlobalRef` | `` |
| 1 | 6 | `FindClass` | `android/content/Context` |
| 2 | 167 | `generic` | `` |

## Writes to callback slot

- none

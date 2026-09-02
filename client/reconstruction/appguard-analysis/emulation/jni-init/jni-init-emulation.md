# AppGuard `AppGuardProxyApplication` JNI initializer emulation

- bootstrap stop: `bootstrap callback table ready`
- callback table captured: **True**
- JNI entry: `libcompatible+0x1338e4`
- JNI stop: `unsupported direct syscall 0 at 0x0`
- JNI instructions: **251579**
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
| 2 | 167 | `NewStringUTF` | `activity` |
| 3 | 6 | `FindClass` | `java/lang/String` |
| 4 | 33 | `GetMethodID` | `<init> (Ljava/lang/String;)V` |
| 5 | 29 | `generic` | `` |
| 6 | 15 | `generic` | `` |
| 7 | 15 | `generic` | `` |
| 8 | 23 | `DeleteLocalRef` | `` |
| 9 | 6 | `FindClass` | `android/app/ActivityManager` |
| 10 | 6 | `FindClass` | `android/app/ActivityManager$RunningServiceInfo` |
| 11 | 33 | `GetMethodID` | `getRunningServices (I)Ljava/util/List;` |
| 12 | 94 | `generic` | `` |
| 13 | 6 | `FindClass` | `java/util/List` |
| 14 | 33 | `GetMethodID` | `get (I)Ljava/lang/Object;` |
| 15 | 33 | `GetMethodID` | `size ()I` |
| 16 | 33 | `GetMethodID` | `getSystemService (Ljava/lang/String;)Ljava/lang/Object;` |
| 17 | 15 | `generic` | `` |
| 18 | 35 | `generic` | `` |
| 19 | 15 | `generic` | `` |
| 20 | 35 | `generic` | `` |
| 21 | 23 | `DeleteLocalRef` | `` |
| 22 | 23 | `DeleteLocalRef` | `` |
| 23 | 23 | `DeleteLocalRef` | `` |
| 24 | 23 | `DeleteLocalRef` | `` |
| 25 | 23 | `DeleteLocalRef` | `` |
| 26 | 23 | `DeleteLocalRef` | `` |

## Writes to callback slot

- none

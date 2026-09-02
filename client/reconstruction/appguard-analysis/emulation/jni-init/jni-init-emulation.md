# AppGuard `AppGuardProxyApplication` JNI initializer emulation

- bootstrap stop: `bootstrap callback table ready`
- callback table captured: **True**
- JNI entry: `libcompatible+0x1338e4`
- JNI stop: `reached PC=0 during JNI initialization`
- JNI instructions: **219032**
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
| 5 | 29 | `NewObjectV` | `<init> (Ljava/lang/String;)V` |
| 6 | 23 | `DeleteLocalRef` | `` |
| 7 | 6 | `FindClass` | `android/app/ActivityManager` |
| 8 | 6 | `FindClass` | `android/app/ActivityManager$RunningServiceInfo` |
| 9 | 33 | `GetMethodID` | `getRunningServices (I)Ljava/util/List;` |
| 10 | 94 | `GetFieldID` | `pid I` |
| 11 | 6 | `FindClass` | `java/util/List` |
| 12 | 33 | `GetMethodID` | `get (I)Ljava/lang/Object;` |
| 13 | 33 | `GetMethodID` | `size ()I` |
| 14 | 33 | `GetMethodID` | `getSystemService (Ljava/lang/String;)Ljava/lang/Object;` |
| 15 | 15 | `ExceptionOccurred` | `` |
| 16 | 35 | `CallObjectMethodV` | `getSystemService (Ljava/lang/String;)Ljava/lang/Object;` |
| 17 | 15 | `ExceptionOccurred` | `` |
| 18 | 35 | `CallObjectMethodV` | `getRunningServices (I)Ljava/util/List;` |
| 19 | 50 | `CallIntMethodV` | `size ()I` |
| 20 | 23 | `DeleteLocalRef` | `` |
| 21 | 23 | `DeleteLocalRef` | `` |
| 22 | 23 | `DeleteLocalRef` | `` |
| 23 | 23 | `DeleteLocalRef` | `` |
| 24 | 23 | `DeleteLocalRef` | `` |
| 25 | 23 | `DeleteLocalRef` | `` |
| 26 | 23 | `DeleteLocalRef` | `` |

## Writes to callback slot

- none

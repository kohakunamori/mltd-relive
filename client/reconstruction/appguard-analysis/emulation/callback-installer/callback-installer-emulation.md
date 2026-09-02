# AppGuard callback-installer execution

- bootstrap: `bootstrap callback table ready`
- installer: `+0xc2a30`
- installer stop: `None`
- installer instructions: **1184002**
- JNI stop: `Unicorn error: Invalid memory fetch (UC_ERR_FETCH_UNMAPPED); pc=0x7250`
- JNI instructions: **219031**
- JNI target slot `1eb858`: `0x4580`

## Slots after installer

| slot | value |
|---:|---:|
| `0x1eb838` | `0x7250` |
| `0x1eb840` | `0x3420` |
| `0x1eb848` | `0x2530` |
| `0x1eb850` | `0x1100` |
| `0x1eb858` | `0x4580` |
| `0x1eb860` | `0x7510` |
| `0x1eb868` | `0x7130` |

## Installer writes

| PC | slot | value | size |
|---:|---:|---:|---:|
| `+0x7678` | `+0x1eb830` | `0x5100001000` | 8 |
| `+0xc2ad0` | `+0x1eb838` | `0x7250` | 8 |
| `+0xc2ad4` | `+0x1eb840` | `0x3420` | 8 |
| `+0xc2ad8` | `+0x1eb848` | `0x2530` | 8 |
| `+0xc2adc` | `+0x1eb850` | `0x1100` | 8 |
| `+0xc2ae0` | `+0x1eb858` | `0x4580` | 8 |
| `+0xc2ae4` | `+0x1eb860` | `0x7510` | 8 |
| `+0xc2ae8` | `+0x1eb868` | `0x7130` | 8 |

## JNI calls reached after installation

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
| 10 | 94 | `GetFieldID` | `` |
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

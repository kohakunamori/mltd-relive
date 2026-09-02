# AppGuard native/JNI static map

Generated from the exact verified official Traditional Chinese MLTD 2.1.000 bundle.
Offsets in this report are sample-specific; no offset is borrowed from another AppGuard version.

## Native libraries

| Library | Size | SHA-256 | DT_NEEDED | Interesting imports |
|---|---:|---|---|---|
| `libcompatible.so` | 1935632 | `8880c415e1ab82c31858be68ce12b76b95dc8ff8875b76c1246a8bc0679647bc` | - | - |
| `libcompatible_x86.so` | 2026048 | `6cca8c7be501e0fe8560cc229dec1b986f389832fdf83f11d068793a386f7e02` | - | - |
| `libengine-hlp.so` | 236400 | `ceb581eda775b8a2dfa53483e7a994d4bda25e99c3565ad95cad5c2bd16b1b2e` | - | - |
| `libstub.so` | 813143 | `041c81c97b77bc182c08207a6ac174e422795c9857c5d71076b16ec48dde201b` | `liblog.so`, `libz.so`, `libdl.so`, `libc.so`, `libm.so`, `libstdc++.so`, `libcompatible.so` | - |

## Security-relevant PLT callsites

### `libcompatible.so`

No direct PLT callsites resolved by the static mapper.

### `libcompatible_x86.so`

No direct PLT callsites resolved by the static mapper.

### `libengine-hlp.so`

No direct PLT callsites resolved by the static mapper.

### `libstub.so`

No direct PLT callsites resolved by the static mapper.

## Java/JNI bridge

AppGuard smali classes discovered: **13**

### Native methods

| Class | Native method |
|---|---|
| `Lcom/inca/security/Proxy/AppGuardFrontApplication;` | `IiIiIiiIII(I)Ljava/lang/String;` |
| `Lcom/inca/security/Proxy/AppGuardProxyApplication;` | `IiIiiIiIiI(Landroid/content/Context;)V` |
| `Lcom/inca/security/Proxy/AppGuardProxyHandler;` | `iiIiIIiIIi(Landroid/os/Message;)Z` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `IIiIiIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)J` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `IIiIiIiiII(Ljava/lang/Object;I[Ljava/lang/Object;)D` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `IIiIiIiiii(Ljava/lang/Object;I[Ljava/lang/Object;)[D` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `IiIIIiIIiI(Ljava/lang/Object;I[Ljava/lang/Object;)B` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `IiIiIiIIii(Ljava/lang/Object;I[Ljava/lang/Object;)[B` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `IiIiIiiIii(Ljava/lang/Object;I[Ljava/lang/Object;)C` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `IiiIiIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)[J` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `IiiiIiIIiI(Ljava/lang/Object;I[Ljava/lang/Object;)[Z` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `IiiiIiiiII(Ljava/lang/Object;I[Ljava/lang/Object;)V` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `IiiiIiiiii(Ljava/lang/Object;I[Ljava/lang/Object;)Z` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `iIIiIIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)[Ljava/lang/Object;` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `iIIiiIiIii(Ljava/lang/Object;I[Ljava/lang/Object;)Ljava/lang/Object;` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `iIiIIIiIII(Ljava/lang/Object;I[Ljava/lang/Object;)[S` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `iIiIIIiIii(Ljava/lang/Object;I[Ljava/lang/Object;)I` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `iIiIIIiiIi(Ljava/lang/Object;I[Ljava/lang/Object;)[I` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `iIiIIiIiiI(Landroid/content/Context;Ljava/lang/Object;)V` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `iIiIiIiiII(Ljava/lang/Object;I[Ljava/lang/Object;)[F` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `iIiIiIiiIi(Ljava/lang/Object;I[Ljava/lang/Object;)F` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `iIiiIIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)S` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `iIiiIIiIii(Ljava/lang/Object;I[Ljava/lang/Object;)[C` |
| `Lcom/inca/security/Proxy/iIiIiIiIii;` | `iiIiIIIiII(J)Ljava/lang/Object;` |
| `Lcom/inca/security/Service/AppGuardService;` | `IiiiIIiIIi(I)I` |
| `Lcom/inca/security/Service/AppGuardServiceCaller;` | `IiiIiIiiIi(III)V` |

## Navigation priorities


The next reverse-engineering pass should start from loader/file-mapping callsites, then walk backward to the buffer transform and forward to the executable mapping/JNI registration boundary.

# Official AppGuard Java/native bridge

This is a compact preservation of only the AppGuard/loader smali removed by zh-fixed, decoded from the verified official 2.1.000 base APK.

## Native and loader references

### `smali/com/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener.smali`

- class: `.class Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;`
- L6: `.implements Lcom/inca/security/AppGuard/AppGuardEventListener;`
- L835: `invoke-static {}, Lcom/inca/security/AppGuard/SecureObjectFactory;->newInstanceOfSecureBytes()Lcom/inca/security/Interface/SecureBytes;`
- L841: `.catch Lcom/inca/security/Exception/AppGuardException; {:try_start_0 .. :try_end_0} :catch_1`
- L858: `invoke-virtual {p1}, Lcom/inca/security/Exception/AppGuardException;->printStackTrace()V`

### `smali/com/inca/security/DexProtect/SupportActivity.smali`

- class: `.class public Lcom/inca/security/DexProtect/SupportActivity;`
- L105: `const-string v2, "AppGuard RunTime \u517c\u5bb9\u6027"`
- L160: `const-string v2, "AppGuard Runtime Compatibility"`

### `smali/com/inca/security/IiiIiiiiiI.smali`

- class: `.class public Lcom/inca/security/IiiIiiiiiI;`
- L8: `value = Lcom/inca/security/Service/AppGuardService;`
- L18: `.field public final synthetic IIiIIiiiIi:Lcom/inca/security/Service/AppGuardService;`
- L22: `.method public constructor <init>(Lcom/inca/security/Service/AppGuardService;)V`
- L26: `iput-object p1, p0, Lcom/inca/security/IiiIiiiiiI;->IIiIIiiiIi:Lcom/inca/security/Service/AppGuardService;`
- L53: `iget-object v0, p0, Lcom/inca/security/IiiIiiiiiI;->IIiIIiiiIi:Lcom/inca/security/Service/AppGuardService;`
- L55: `invoke-static {v0, v1}, Lcom/inca/security/Service/AppGuardService;->IIIIiiIIII(Lcom/inca/security/Service/AppGuardService;I)I`

### `smali/com/inca/security/Proxy/AppGuardFrontApplication.smali`

- class: `.class public Lcom/inca/security/Proxy/AppGuardFrontApplication;`
- native method: `.method private static native synthetic IiIiIiiIII(I)Ljava/lang/String;`
- L1: `.class public Lcom/inca/security/Proxy/AppGuardFrontApplication;`
- L65: `invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V`
- L83: `iput-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;`
- L86: `iput-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiiiiI:Landroid/content/Context;`
- L91: `iput-boolean v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiiiiI:Z`
- L100: `iput-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiiIiIIiII:[B`
- L109: `iput-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIiiiIIiI:[B`
- L118: `iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiIiIIi:[B`
- L127: `iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiIIIi:[B`
- L136: `iput-object v2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiiiiiiiIi:[B`
- L143: `iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiiiIIiIii:[B`
- L152: `iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiIIIiiiii:[B`
- L161: `iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiIIiIIIII:[B`
- L168: `iput-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiiIiIiiIi:[B`
- L374: `invoke-static {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiIII(I)Ljava/lang/String;`
- L397: `invoke-static {p1}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(I)Ljava/lang/String;`
- L424: `iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiiIiIiiIi:[B`
- L430: `iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiIIIiiiii:[B`
- L436: `iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiiiIIiIii:[B`
- L442: `iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiIIIi:[B`
- L448: `iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiIIiIIIII:[B`
- L454: `iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiiiiiiiIi:[B`
- L464: `invoke-direct {p0, p1}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;`
- L546: `iget-object v2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiiIiIIiII:[B`
- L550: `invoke-direct {p0, v1}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;`
- L565: `iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;`
- L572: `invoke-direct {p0, v2}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Z)V`
- L577: `iget-object v4, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIiiiIIiI:[B`
- L581: `invoke-direct {p0, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;`
- L601: `iget-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;`
- L605: `iget-object v4, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiiiiI:Landroid/content/Context;`
- L627: `iget-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiiiiI:Landroid/content/Context;`
- L635: `invoke-direct {p0, v2, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;`
- L641: `iget-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;`
- L648: `iget-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiiiiI:Landroid/content/Context;`
- L656: `invoke-direct {p0, v2, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;`
- L675: `invoke-direct {p0, v2, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;`
- L681: `iget-object v2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;`
- L694: `invoke-direct {p0, v2, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;`
- L713: `invoke-direct {p0, v2, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;`
- L719: `iget-object v2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;`
- L726: `iget-boolean v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiiiiI:Z`
- L739: `invoke-direct {p0, v2, p1}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;`
- L754: `iput-boolean v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiiiiI:Z`
- L760: `iget-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;`
- L798: `invoke-virtual {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->getPackageManager()Landroid/content/pm/PackageManager;`
- L817: `iget-object v3, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiIiIIi:[B`
- L852: `invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V`
- L868: `invoke-direct {p0, v0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Z)V`
- L871: `iget-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;`
- L912: `.method private static native synthetic IiIiIiiIII(I)Ljava/lang/String;`
- L924: `iput-object p1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiiiiI:Landroid/content/Context;`
- L927: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z`
- L933: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z`
- L939: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII()Z`
- L947: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII()V`
- L957: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z`
- L963: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z`
- L969: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII()Z`
- L988: `iget-boolean v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiiiiI:Z`
- L994: `invoke-direct {p0, v0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Z)V`
- L1009: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z`
- L1015: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z`
- L1021: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII()Z`
- L1031: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIiiIiIiIi()V`
- L1038: `invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()V`

### `smali/com/inca/security/Proxy/AppGuardProxyApplication.smali`

- class: `.class public Lcom/inca/security/Proxy/AppGuardProxyApplication;`
- native method: `.method private native IiIiiIiIiI(Landroid/content/Context;)V`
- L1: `.class public Lcom/inca/security/Proxy/AppGuardProxyApplication;`
- L3: `.source "AppGuardProxyApplication.java"`
- L16: `.method private native IiIiiIiIiI(Landroid/content/Context;)V`
- L56: `invoke-virtual {p0}, Lcom/inca/security/Proxy/AppGuardProxyApplication;->getApplicationContext()Landroid/content/Context;`
- L60: `invoke-static {v0}, Lcom/inca/security/Proxy/JNISoxProxy;->setApplicationContext(Landroid/content/Context;)V`
- L63: `invoke-direct {p0, p0}, Lcom/inca/security/Proxy/AppGuardProxyApplication;->IiIiiIiIiI(Landroid/content/Context;)V`

### `smali/com/inca/security/Proxy/AppGuardProxyHandler.smali`

- class: `.class public Lcom/inca/security/Proxy/AppGuardProxyHandler;`
- native method: `.method private native iiIiIIiIIi(Landroid/os/Message;)Z`
- L1: `.class public Lcom/inca/security/Proxy/AppGuardProxyHandler;`
- L3: `.source "AppGuardProxyHandler.java"`
- L10: `.field private static mInstance:Lcom/inca/security/Proxy/AppGuardProxyHandler;`
- L23: `.method public static declared-synchronized getInstance()Lcom/inca/security/Proxy/AppGuardProxyHandler;`
- L26: `const-class v0, Lcom/inca/security/Proxy/AppGuardProxyHandler;`
- L32: `sget-object v1, Lcom/inca/security/Proxy/AppGuardProxyHandler;->mInstance:Lcom/inca/security/Proxy/AppGuardProxyHandler;`
- L37: `new-instance v1, Lcom/inca/security/Proxy/AppGuardProxyHandler;`
- L39: `invoke-direct {v1}, Lcom/inca/security/Proxy/AppGuardProxyHandler;-><init>()V`
- L41: `sput-object v1, Lcom/inca/security/Proxy/AppGuardProxyHandler;->mInstance:Lcom/inca/security/Proxy/AppGuardProxyHandler;`
- L45: `sget-object v1, Lcom/inca/security/Proxy/AppGuardProxyHandler;->mInstance:Lcom/inca/security/Proxy/AppGuardProxyHandler;`
- L61: `.method private native iiIiIIiIIi(Landroid/os/Message;)Z`
- L70: `invoke-direct {p0, p1}, Lcom/inca/security/Proxy/AppGuardProxyHandler;->iiIiIIiIIi(Landroid/os/Message;)Z`

### `smali/com/inca/security/Proxy/JNISoxProxy.smali`

- class: `.class public Lcom/inca/security/Proxy/JNISoxProxy;`
- L1: `.class public Lcom/inca/security/Proxy/JNISoxProxy;`
- L34: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->iIIIIiiIiI:Landroid/content/Context;`
- L43: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;`
- L52: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;`
- L68: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;`
- L88: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;`
- L120: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;`
- L154: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;`
- L162: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;`
- L168: `iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->nativeLibraryDir:Ljava/lang/String;`
- L171: `sget-object v5, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;`
- L227: `invoke-static/range {p0 .. p0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V`
- L271: `sget-object v7, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;`
- L2179: `invoke-static {v5}, Ljava/lang/System;->load(Ljava/lang/String;)V`
- L2182: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;`
- L2197: `invoke-static/range {p0 .. p0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V`
- L2227: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;`
- L2249: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;`
- L2261: `new-instance v0, Lcom/inca/security/Proxy/JNISoxProxy$1;`
- L2263: `invoke-direct {v0}, Lcom/inca/security/Proxy/JNISoxProxy$1;-><init>()V`
- L2266: `invoke-virtual {v0}, Lcom/inca/security/Proxy/JNISoxProxy$1;->start()V`
- L2309: `invoke-static {}, Lcom/inca/security/Proxy/JNISoxProxy;->getContext()Landroid/content/Context;`
- L2432: `sput-object p0, Lcom/inca/security/Proxy/JNISoxProxy;->iIIIIiiIiI:Landroid/content/Context;`
- L2437: `.method public static setContext(Landroid/content/Context;)V`
- L2441: `sput-object p0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;`
- L2444: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;`
- L2448: `sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;`
- L2457: `sput-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;`

### `smali/com/inca/security/Proxy/iIiIiIiIii.smali`

- class: `.class public Lcom/inca/security/Proxy/iIiIiIiIii;`
- native method: `.method public static varargs native IIiIiIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)J`
- native method: `.method public static varargs native IIiIiIiiII(Ljava/lang/Object;I[Ljava/lang/Object;)D`
- native method: `.method public static varargs native IIiIiIiiii(Ljava/lang/Object;I[Ljava/lang/Object;)[D`
- native method: `.method public static varargs native IiIIIiIIiI(Ljava/lang/Object;I[Ljava/lang/Object;)B`
- native method: `.method public static varargs native IiIiIiIIii(Ljava/lang/Object;I[Ljava/lang/Object;)[B`
- native method: `.method public static varargs native IiIiIiiIii(Ljava/lang/Object;I[Ljava/lang/Object;)C`
- native method: `.method public static varargs native IiiIiIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)[J`
- native method: `.method public static varargs native IiiiIiIIiI(Ljava/lang/Object;I[Ljava/lang/Object;)[Z`
- native method: `.method public static varargs native IiiiIiiiII(Ljava/lang/Object;I[Ljava/lang/Object;)V`
- native method: `.method public static varargs native IiiiIiiiii(Ljava/lang/Object;I[Ljava/lang/Object;)Z`
- native method: `.method public static varargs native iIIiIIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)[Ljava/lang/Object;`
- native method: `.method public static varargs native iIIiiIiIii(Ljava/lang/Object;I[Ljava/lang/Object;)Ljava/lang/Object;`
- native method: `.method public static varargs native iIiIIIiIII(Ljava/lang/Object;I[Ljava/lang/Object;)[S`
- native method: `.method public static varargs native iIiIIIiIii(Ljava/lang/Object;I[Ljava/lang/Object;)I`
- native method: `.method public static varargs native iIiIIIiiIi(Ljava/lang/Object;I[Ljava/lang/Object;)[I`
- native method: `.method public static native iIiIIiIiiI(Landroid/content/Context;Ljava/lang/Object;)V`
- native method: `.method public static varargs native iIiIiIiiII(Ljava/lang/Object;I[Ljava/lang/Object;)[F`
- native method: `.method public static varargs native iIiIiIiiIi(Ljava/lang/Object;I[Ljava/lang/Object;)F`
- native method: `.method public static varargs native iIiiIIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)S`
- native method: `.method public static varargs native iIiiIIiIii(Ljava/lang/Object;I[Ljava/lang/Object;)[C`
- native method: `.method public static native iiIiIIIiII(J)Ljava/lang/Object;`
- L16: `.method public static varargs native IIiIiIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)J`
- L19: `.method public static varargs native IIiIiIiiII(Ljava/lang/Object;I[Ljava/lang/Object;)D`
- L22: `.method public static varargs native IIiIiIiiii(Ljava/lang/Object;I[Ljava/lang/Object;)[D`
- L33: `.method public static varargs native IiIIIiIIiI(Ljava/lang/Object;I[Ljava/lang/Object;)B`
- L36: `.method public static varargs native IiIiIiIIii(Ljava/lang/Object;I[Ljava/lang/Object;)[B`
- L39: `.method public static varargs native IiIiIiiIii(Ljava/lang/Object;I[Ljava/lang/Object;)C`
- L42: `.method public static varargs native IiiIiIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)[J`
- L45: `.method public static varargs native IiiiIiIIiI(Ljava/lang/Object;I[Ljava/lang/Object;)[Z`
- L48: `.method public static varargs native IiiiIiiiII(Ljava/lang/Object;I[Ljava/lang/Object;)V`
- L51: `.method public static varargs native IiiiIiiiii(Ljava/lang/Object;I[Ljava/lang/Object;)Z`
- L58: `invoke-static {p0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V`
- L63: `.method public static varargs native iIIiIIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)[Ljava/lang/Object;`
- L66: `.method public static varargs native iIIiiIiIii(Ljava/lang/Object;I[Ljava/lang/Object;)Ljava/lang/Object;`
- L69: `.method public static varargs native iIiIIIiIII(Ljava/lang/Object;I[Ljava/lang/Object;)[S`
- L72: `.method public static varargs native iIiIIIiIii(Ljava/lang/Object;I[Ljava/lang/Object;)I`
- L75: `.method public static varargs native iIiIIIiiIi(Ljava/lang/Object;I[Ljava/lang/Object;)[I`
- L78: `.method public static native iIiIIiIiiI(Landroid/content/Context;Ljava/lang/Object;)V`
- L81: `.method public static varargs native iIiIiIiiII(Ljava/lang/Object;I[Ljava/lang/Object;)[F`
- L84: `.method public static varargs native iIiIiIiiIi(Ljava/lang/Object;I[Ljava/lang/Object;)F`
- L87: `.method public static varargs native iIiiIIiIiI(Ljava/lang/Object;I[Ljava/lang/Object;)S`
- L90: `.method public static varargs native iIiiIIiIii(Ljava/lang/Object;I[Ljava/lang/Object;)[C`
- L93: `.method public static native iiIiIIIiII(J)Ljava/lang/Object;`

### `smali/com/inca/security/Service/AppGuardService.smali`

- class: `.class public Lcom/inca/security/Service/AppGuardService;`
- native method: `.method private native synthetic IiiiIIiIIi(I)I`
- L1: `.class public Lcom/inca/security/Service/AppGuardService;`
- L24: `invoke-direct {v0, p0}, Lcom/inca/security/IiiIiiiiiI;-><init>(Lcom/inca/security/Service/AppGuardService;)V`
- L26: `iput-object v0, p0, Lcom/inca/security/Service/AppGuardService;->IiiiIIiIii:Landroid/os/Handler;`
- L31: `.method public static synthetic IIIIiiIIII(Lcom/inca/security/Service/AppGuardService;I)I`
- L35: `invoke-direct {p0, p1}, Lcom/inca/security/Service/AppGuardService;->IiiiIIiIIi(I)I`
- L42: `.method private native synthetic IiiiIIiIIi(I)I`
- L55: `iget-object v0, p0, Lcom/inca/security/Service/AppGuardService;->IiiiIIiIii:Landroid/os/Handler;`

### `smali/com/inca/security/Service/AppGuardServiceCaller.smali`

- class: `.class public Lcom/inca/security/Service/AppGuardServiceCaller;`
- native method: `.method private static native synthetic IiiIiIiiIi(III)V`
- L1: `.class public Lcom/inca/security/Service/AppGuardServiceCaller;`
- L27: `sput-object v0, Lcom/inca/security/Service/AppGuardServiceCaller;->IIiIIiiiIi:Landroid/content/ServiceConnection;`
- L45: `sget v0, Lcom/inca/security/Service/AppGuardServiceCaller;->iIIIIiiIiI:I`
- L54: `sget-object v0, Lcom/inca/security/Service/AppGuardServiceCaller;->iiIIIiiiii:Landroid/os/Messenger;`
- L63: `sput-object p0, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIiiiIIiI:Landroid/os/Messenger;`
- L72: `invoke-static {p0, p1, p2}, Lcom/inca/security/Service/AppGuardServiceCaller;->IiiIiIiiIi(III)V`
- L81: `sput-boolean p0, Lcom/inca/security/Service/AppGuardServiceCaller;->IiiiIIiIii:Z`
- L90: `sget-object v0, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIiiiIIiI:Landroid/os/Messenger;`
- L99: `sput-object p0, Lcom/inca/security/Service/AppGuardServiceCaller;->iiIIIiiiii:Landroid/os/Messenger;`
- L104: `.method private static native synthetic IiiIiIiiIi(III)V`
- L111: `sput p1, Lcom/inca/security/Service/AppGuardServiceCaller;->iIIIIiiIiI:I`
- L114: `sget-boolean p0, Lcom/inca/security/Service/AppGuardServiceCaller;->IiiiIIiIii:Z`
- L123: `invoke-static {}, Lcom/inca/security/Proxy/JNISoxProxy;->getApplicationContext()Landroid/content/Context;`
- L127: `const-class v1, Lcom/inca/security/Service/AppGuardService;`
- L132: `invoke-static {}, Lcom/inca/security/Proxy/JNISoxProxy;->getApplicationContext()Landroid/content/Context;`
- L136: `sget-object v1, Lcom/inca/security/Service/AppGuardServiceCaller;->IIiIIiiiIi:Landroid/content/ServiceConnection;`
- L153: `sget-object p1, Lcom/inca/security/Service/AppGuardServiceCaller;->iiIIIiiiii:Landroid/os/Messenger;`
- L159: `sget-object p1, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIiiiIIiI:Landroid/os/Messenger;`

### `smali/com/inca/security/iiIiiiiIIi.smali`

- class: `.class public final Lcom/inca/security/iiIiiiiIIi;`
- L11: `value = Lcom/inca/security/Service/AppGuardServiceCaller;`
- L37: `invoke-static {p1}, Lcom/inca/security/Service/AppGuardServiceCaller;->IiIIiiiiiI(Landroid/os/Messenger;)Landroid/os/Messenger;`
- L42: `invoke-static {p1}, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIIiiIIII(Z)Z`
- L51: `invoke-static {}, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIIiiIIII()Landroid/os/Messenger;`
- L70: `invoke-static {p1}, Lcom/inca/security/Service/AppGuardServiceCaller;->IiIIiiiiiI(Landroid/os/Messenger;)Landroid/os/Messenger;`
- L78: `invoke-static {p1}, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIIiiIIII(Landroid/os/Messenger;)Landroid/os/Messenger;`
- L92: `invoke-static {}, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIIiiIIII()Landroid/os/Messenger;`
- L100: `invoke-static {}, Lcom/inca/security/Service/AppGuardServiceCaller;->IiIIiiiiiI()Landroid/os/Messenger;`
- L110: `invoke-static {v0}, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIIiiIIII(Z)Z`
- L121: `invoke-static {p1}, Lcom/inca/security/Service/AppGuardServiceCaller;->IiIIiiiiiI(Landroid/os/Messenger;)Landroid/os/Messenger;`
- L126: `invoke-static {p1}, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIIiiIIII(Z)Z`


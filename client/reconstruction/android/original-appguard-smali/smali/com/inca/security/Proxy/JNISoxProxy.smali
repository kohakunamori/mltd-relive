.class public Lcom/inca/security/Proxy/JNISoxProxy;
.super Ljava/lang/Object;
.source "lb"


# static fields
.field private static synthetic IIiIIiiiIi:Landroid/content/Context;

.field private static synthetic IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;

.field private static synthetic iIIIIiiIiI:Landroid/content/Context;


# direct methods
.method public static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getApplicationContext()Landroid/content/Context;
    .locals 1

    .line 265
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->iIIIIiiIiI:Landroid/content/Context;

    return-object v0
.end method

.method public static getContext()Landroid/content/Context;
    .locals 1

    .line 331
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;

    return-object v0
.end method

.method public static getDeviceInfo()Lcom/inca/security/IiiiiiiiiI;
    .locals 1

    .line 482
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;

    return-object v0
.end method

.method public static getLocaleString()Ljava/lang/String;
    .locals 2

    .line 169
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-ge v0, v1, :cond_0

    .line 104
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 154
    :cond_0
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Configuration;->getLocales()Landroid/os/LocaleList;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/LocaleList;->get(I)Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static loadSecureLibrary(Ljava/lang/String;)V
    .locals 22

    .line 128
    :goto_0
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;

    if-nez v0, :cond_0

    const-wide/16 v0, 0x32

    .line 5
    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    nop

    goto :goto_0

    .line 113
    :cond_0
    invoke-virtual {v0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v0

    const/4 v2, 0x2

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-nez v0, :cond_1

    .line 7
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;

    invoke-virtual {v0, v3}, Lcom/inca/security/IiiiiiiiiI;->IIIIiiIIII(Z)V

    goto/16 :goto_1

    .line 82
    :cond_1
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->nativeLibraryDir:Ljava/lang/String;

    .line 60
    sget-object v5, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v5

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    const-string v6, "bkht.zbkik("

    .line 3
    invoke-static {v6}, Lcom/inca/security/IIiIiiiiii;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    new-array v7, v2, [Ljava/lang/Object;

    aput-object v0, v7, v4

    aput-object p0, v7, v3

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v6, "q={\"=,q=z=;"

    .line 75
    invoke-static {v6}, Lcom/inca/security/IIiiiiiiii;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    new-array v7, v2, [Ljava/lang/Object;

    aput-object v5, v7, v4

    aput-object p0, v7, v3

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    .line 64
    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v6

    if-nez v6, :cond_2

    .line 88
    invoke-static/range {p0 .. p0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void

    :cond_2
    const/4 v6, 0x3

    .line 107
    :try_start_1
    new-array v6, v6, [B

    .line 102
    new-instance v7, Ljava/io/FileInputStream;

    invoke-direct {v7, v0}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    .line 212
    invoke-virtual {v7, v6}, Ljava/io/FileInputStream;->read([B)I

    .line 167
    invoke-virtual {v7}, Ljava/io/FileInputStream;->close()V

    .line 95
    aget-byte v7, v6, v4

    const/16 v8, 0x53

    if-ne v7, v8, :cond_3

    aget-byte v7, v6, v3

    const/16 v8, 0x4f

    if-ne v7, v8, :cond_3

    aget-byte v6, v6, v2

    const/16 v7, 0x58

    if-ne v6, v7, :cond_3

    .line 21
    new-instance v6, Lcom/inca/security/iIiIiiiIii;

    sget-object v7, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;

    invoke-direct {v6, v7}, Lcom/inca/security/iIiIiiiIii;-><init>(Landroid/content/Context;)V

    const/16 v7, 0x10

    .line 127
    new-array v9, v7, [B

    const/16 v10, 0x3d

    aput-byte v10, v9, v4

    const/16 v10, 0x55

    aput-byte v10, v9, v3

    const/16 v10, -0x4a

    aput-byte v10, v9, v2

    const/4 v10, 0x3

    const/16 v11, 0x65

    aput-byte v11, v9, v10

    const/16 v10, -0x52

    const/4 v11, 0x4

    aput-byte v10, v9, v11

    const/16 v10, 0x6d

    const/4 v12, 0x5

    aput-byte v10, v9, v12

    const/4 v10, 0x6

    const/16 v13, -0x20

    aput-byte v13, v9, v10

    const/4 v10, 0x7

    const/16 v13, 0x7a

    aput-byte v13, v9, v10

    const/16 v10, 0x8

    const/16 v14, -0x28

    aput-byte v14, v9, v10

    const/16 v10, 0x44

    const/16 v14, 0x9

    aput-byte v10, v9, v14

    const/16 v10, 0x66

    const/16 v15, 0xa

    aput-byte v10, v9, v15

    const/16 v10, 0xb

    const/16 v16, -0x37

    aput-byte v16, v9, v10

    const/16 v10, 0xc

    const/16 v16, 0x52

    aput-byte v16, v9, v10

    const/16 v10, 0xd

    const/16 v16, 0x6c

    aput-byte v16, v9, v10

    const/16 v10, 0xe

    const/16 v16, -0x40

    aput-byte v16, v9, v10

    const/16 v10, 0xf

    const/16 v16, 0xe

    aput-byte v16, v9, v10

    const/16 v10, 0x14

    .line 131
    new-array v10, v10, [B

    aput-byte v4, v10, v4

    aput-byte v4, v10, v3

    aput-byte v4, v10, v2

    const/16 v16, 0x3

    aput-byte v7, v10, v16

    aput-byte v14, v10, v11

    const/16 v16, -0x48

    aput-byte v16, v10, v12

    const/16 v16, 0x6

    aput-byte v12, v10, v16

    const/16 v16, 0x7

    const/16 v17, 0x53

    aput-byte v17, v10, v16

    const/16 v16, 0x8

    const/16 v17, -0x5b

    aput-byte v17, v10, v16

    const/16 v16, 0x26

    aput-byte v16, v10, v14

    const/16 v16, 0x23

    aput-byte v16, v10, v15

    const/16 v16, 0xb

    const/16 v17, 0x43

    aput-byte v17, v10, v16

    const/16 v16, 0xc

    const/16 v17, -0x72

    aput-byte v17, v10, v16

    const/16 v16, 0xd

    const/16 v17, 0x12

    aput-byte v17, v10, v16

    const/16 v16, 0xe

    const/16 v17, 0x1d

    aput-byte v17, v10, v16

    const/16 v16, 0xf

    const/16 v17, -0x21

    aput-byte v17, v10, v16

    const/16 v16, 0x24

    aput-byte v16, v10, v7

    const/16 v16, 0x11

    const/16 v17, -0x43

    aput-byte v17, v10, v16

    const/16 v16, 0x12

    const/16 v17, -0x1

    aput-byte v17, v10, v16

    const/16 v16, 0x6e

    const/16 v17, 0x13

    aput-byte v16, v10, v17

    const/16 v1, 0x12c

    .line 134
    new-array v1, v1, [B

    aput-byte v4, v1, v4

    aput-byte v4, v1, v3

    aput-byte v3, v1, v2

    const/16 v18, 0x3

    const/16 v19, 0x26

    aput-byte v19, v1, v18

    const/16 v18, -0x6

    aput-byte v18, v1, v11

    const/16 v18, 0x2f

    aput-byte v18, v1, v12

    const/16 v18, 0x6

    const/16 v19, -0x1e

    aput-byte v19, v1, v18

    const/16 v18, 0x7

    const/16 v19, 0x55

    aput-byte v19, v1, v18

    const/16 v18, 0x8

    const/16 v19, 0x31

    aput-byte v19, v1, v18

    const/16 v18, 0x2e

    aput-byte v18, v1, v14

    const/16 v18, -0x76

    aput-byte v18, v1, v15

    const/16 v18, 0xb

    const/16 v19, -0x3e

    aput-byte v19, v1, v18

    const/16 v18, 0xc

    const/16 v19, 0x24

    aput-byte v19, v1, v18

    const/16 v18, 0xd

    const/16 v19, 0xe

    aput-byte v19, v1, v18

    const/16 v18, 0xe

    const/16 v19, -0x71

    aput-byte v19, v1, v18

    const/16 v18, 0xf

    const/16 v19, -0x4d

    aput-byte v19, v1, v18

    const/16 v18, -0x75

    aput-byte v18, v1, v7

    const/16 v18, 0x11

    const/16 v19, 0x47

    aput-byte v19, v1, v18

    const/16 v18, 0x12

    const/16 v19, -0x56

    aput-byte v19, v1, v18

    const/16 v18, -0x2

    aput-byte v18, v1, v17

    const/16 v18, 0x14

    const/16 v19, -0x1

    aput-byte v19, v1, v18

    const/16 v18, 0x15

    const/16 v19, 0x34

    aput-byte v19, v1, v18

    const/16 v18, 0x16

    const/16 v20, 0x23

    aput-byte v20, v1, v18

    const/16 v18, 0x17

    const/16 v20, 0x16

    aput-byte v20, v1, v18

    const/16 v18, 0x18

    const/16 v20, 0x5b

    aput-byte v20, v1, v18

    const/16 v18, 0x19

    const/16 v20, 0x3a

    aput-byte v20, v1, v18

    const/16 v18, 0x1a

    const/16 v20, 0x2a

    aput-byte v20, v1, v18

    const/16 v18, 0x1b

    const/16 v20, -0x24

    aput-byte v20, v1, v18

    const/16 v18, 0x1c

    const/16 v20, 0x65

    aput-byte v20, v1, v18

    const/16 v18, 0x1d

    const/16 v20, 0x2d

    aput-byte v20, v1, v18

    const/16 v18, 0x1e

    const/16 v20, 0x5d

    aput-byte v20, v1, v18

    const/16 v18, 0x1f

    const/16 v20, 0x4c

    aput-byte v20, v1, v18

    const/16 v18, 0x20

    const/16 v20, -0x1c

    aput-byte v20, v1, v18

    const/16 v18, 0x21

    const/16 v20, 0x48

    aput-byte v20, v1, v18

    const/16 v18, 0x22

    const/16 v20, 0x16

    aput-byte v20, v1, v18

    const/16 v18, 0x23

    const/16 v20, -0x78

    aput-byte v20, v1, v18

    const/16 v18, 0x24

    const/16 v20, 0xd

    aput-byte v20, v1, v18

    const/16 v18, 0x25

    const/16 v20, -0x74

    aput-byte v20, v1, v18

    const/16 v18, 0x26

    const/16 v20, -0x17

    aput-byte v20, v1, v18

    const/16 v18, 0x27

    const/16 v20, 0x76

    aput-byte v20, v1, v18

    const/16 v18, 0x28

    const/16 v20, -0x75

    aput-byte v20, v1, v18

    const/16 v18, 0x29

    const/16 v20, 0x33

    aput-byte v20, v1, v18

    const/16 v18, 0x2a

    aput-byte v8, v1, v18

    const/16 v18, 0x2b

    const/16 v20, -0x4

    aput-byte v20, v1, v18

    const/16 v18, 0x2c

    const/16 v20, 0x27

    aput-byte v20, v1, v18

    const/16 v18, 0x2d

    const/16 v20, 0x5d

    aput-byte v20, v1, v18

    const/16 v18, 0x2e

    const/16 v20, -0x38

    aput-byte v20, v1, v18

    const/16 v18, 0x2f

    const/16 v21, 0x44

    aput-byte v21, v1, v18

    const/16 v18, 0x30

    const/16 v21, -0x2c

    aput-byte v21, v1, v18

    const/16 v18, 0x31

    const/16 v21, 0x72

    aput-byte v21, v1, v18

    const/16 v18, 0x32

    const/16 v21, -0xf

    aput-byte v21, v1, v18

    const/16 v18, 0x33

    const/16 v21, 0x2b

    aput-byte v21, v1, v18

    const/16 v18, -0x80

    aput-byte v18, v1, v19

    const/16 v18, 0x35

    const/16 v21, -0x5e

    aput-byte v21, v1, v18

    const/16 v18, 0x36

    const/16 v21, -0x56

    aput-byte v21, v1, v18

    const/16 v18, 0x37

    aput-byte v15, v1, v18

    const/16 v18, 0x38

    const/16 v21, 0x2b

    aput-byte v21, v1, v18

    const/16 v18, 0x39

    const/16 v21, 0x4d

    aput-byte v21, v1, v18

    const/16 v18, 0x3a

    const/16 v21, 0x12

    aput-byte v21, v1, v18

    const/16 v18, 0x3b

    aput-byte v20, v1, v18

    const/16 v18, 0x3c

    const/16 v21, -0x63

    aput-byte v21, v1, v18

    const/16 v18, 0x3d

    const/16 v21, -0x63

    aput-byte v21, v1, v18

    const/16 v18, 0x3e

    const/16 v21, -0x32

    aput-byte v21, v1, v18

    const/16 v18, 0x3f

    const/16 v21, 0xb

    aput-byte v21, v1, v18

    const/16 v18, 0x40

    aput-byte v11, v1, v18

    const/16 v18, 0x41

    const/16 v21, -0x2

    aput-byte v21, v1, v18

    const/16 v18, 0x42

    const/16 v21, 0x5b

    aput-byte v21, v1, v18

    const/16 v18, 0x43

    const/16 v21, -0x10

    aput-byte v21, v1, v18

    const/16 v18, 0x44

    const/16 v21, 0x27

    aput-byte v21, v1, v18

    const/16 v18, 0x45

    const/16 v21, -0x52

    aput-byte v21, v1, v18

    const/16 v18, 0x46

    aput-byte v20, v1, v18

    const/16 v18, 0x47

    const/16 v21, 0x6b

    aput-byte v21, v1, v18

    const/16 v18, 0x48

    const/16 v21, 0x33

    aput-byte v21, v1, v18

    const/16 v18, 0x49

    const/16 v21, 0x50

    aput-byte v21, v1, v18

    const/16 v18, 0x4a

    const/16 v21, 0x23

    aput-byte v21, v1, v18

    const/16 v18, 0x4b

    aput-byte v7, v1, v18

    const/16 v18, 0x4c

    const/16 v21, -0x10

    aput-byte v21, v1, v18

    const/16 v18, 0x4d

    aput-byte v7, v1, v18

    const/16 v18, 0x4e

    const/16 v21, 0x19

    aput-byte v21, v1, v18

    const/16 v18, -0x1c

    aput-byte v18, v1, v8

    const/16 v18, 0x50

    const/16 v21, -0x64

    aput-byte v21, v1, v18

    const/16 v18, 0x51

    const/16 v21, -0x43

    aput-byte v21, v1, v18

    const/16 v18, 0x52

    const/16 v21, 0x68

    aput-byte v21, v1, v18

    const/16 v18, 0x53

    const/16 v21, -0x3b

    aput-byte v21, v1, v18

    const/16 v18, 0x54

    const/16 v21, -0x68

    aput-byte v21, v1, v18

    const/16 v18, 0x55

    const/16 v21, 0x3a

    aput-byte v21, v1, v18

    const/16 v18, 0x56

    const/16 v21, 0x59

    aput-byte v21, v1, v18

    const/16 v18, 0x57

    const/16 v21, -0x78

    aput-byte v21, v1, v18

    const/16 v18, 0x58

    const/16 v21, 0x70

    aput-byte v21, v1, v18

    const/16 v18, 0x59

    const/16 v21, 0x78

    aput-byte v21, v1, v18

    const/16 v18, 0x5a

    const/16 v21, -0x67

    aput-byte v21, v1, v18

    const/16 v18, 0x5b

    const/16 v21, 0x55

    aput-byte v21, v1, v18

    const/16 v18, 0x5c

    const/16 v21, -0x1d

    aput-byte v21, v1, v18

    const/16 v18, 0x5d

    aput-byte v14, v1, v18

    const/16 v18, 0x5e

    const/16 v21, 0xd

    aput-byte v21, v1, v18

    const/16 v18, 0x5f

    const/16 v21, -0x4a

    aput-byte v21, v1, v18

    const/16 v18, 0x60

    const/16 v21, -0x4a

    aput-byte v21, v1, v18

    const/16 v18, 0x61

    const/16 v21, 0x64

    aput-byte v21, v1, v18

    const/16 v18, 0x62

    const/16 v21, -0x63

    aput-byte v21, v1, v18

    const/16 v18, 0x63

    aput-byte v19, v1, v18

    const/16 v18, 0x64

    const/16 v21, -0x27

    aput-byte v21, v1, v18

    const/16 v18, 0x65

    const/16 v21, -0x14

    aput-byte v21, v1, v18

    const/16 v18, 0x66

    const/16 v21, -0x58

    aput-byte v21, v1, v18

    const/16 v18, 0x67

    const/16 v21, 0x1c

    aput-byte v21, v1, v18

    const/16 v18, 0x68

    const/16 v21, -0x2b

    aput-byte v21, v1, v18

    const/16 v18, 0x69

    const/16 v21, -0x15

    aput-byte v21, v1, v18

    const/16 v18, 0x6a

    const/16 v21, -0x64

    aput-byte v21, v1, v18

    const/16 v18, 0x6b

    const/16 v21, 0x32

    aput-byte v21, v1, v18

    const/16 v18, 0x6c

    const/16 v21, 0x75

    aput-byte v21, v1, v18

    const/16 v18, 0x6d

    const/16 v21, -0x47

    aput-byte v21, v1, v18

    const/16 v18, 0x6c

    aput-byte v18, v1, v16

    const/16 v18, 0x6f

    const/16 v21, -0x75

    aput-byte v21, v1, v18

    const/16 v18, 0x70

    const/16 v21, -0x77

    aput-byte v21, v1, v18

    const/16 v18, 0x71

    const/16 v21, -0x70

    aput-byte v21, v1, v18

    const/16 v18, 0x72

    const/16 v21, -0x77

    aput-byte v21, v1, v18

    const/16 v18, 0x73

    aput-byte v8, v1, v18

    const/16 v18, 0x74

    const/16 v21, -0x59

    aput-byte v21, v1, v18

    const/16 v18, 0x75

    const/16 v21, 0x60

    aput-byte v21, v1, v18

    const/16 v18, 0x76

    const/16 v21, -0x62

    aput-byte v21, v1, v18

    const/16 v18, 0x77

    const/16 v21, -0x10

    aput-byte v21, v1, v18

    const/16 v18, 0x78

    const/16 v21, -0x2f

    aput-byte v21, v1, v18

    const/16 v18, 0x79

    const/16 v21, 0x6a

    aput-byte v21, v1, v18

    const/16 v18, -0x6e

    aput-byte v18, v1, v13

    const/16 v18, 0x7b

    const/16 v21, -0x59

    aput-byte v21, v1, v18

    const/16 v18, 0x7c

    aput-byte v13, v1, v18

    const/16 v18, 0x7d

    const/16 v21, -0x3f

    aput-byte v21, v1, v18

    const/16 v18, 0x7e

    aput-byte v8, v1, v18

    const/16 v8, 0x7f

    aput-byte v19, v1, v8

    const/16 v8, 0x80

    const/16 v18, 0x15

    aput-byte v18, v1, v8

    const/16 v8, 0x81

    const/16 v18, -0x40

    aput-byte v18, v1, v8

    const/16 v8, 0x82

    const/16 v18, -0x45

    aput-byte v18, v1, v8

    const/16 v8, 0x83

    const/16 v18, -0x7c

    aput-byte v18, v1, v8

    const/16 v8, 0x84

    const/16 v18, 0x11

    aput-byte v18, v1, v8

    const/16 v8, 0x85

    const/16 v18, 0x60

    aput-byte v18, v1, v8

    const/16 v8, 0x86

    const/16 v18, -0x18

    aput-byte v18, v1, v8

    const/16 v8, 0x87

    const/16 v18, 0x50

    aput-byte v18, v1, v8

    const/16 v8, 0x88

    const/16 v18, 0x39

    aput-byte v18, v1, v8

    const/16 v8, 0x89

    const/16 v18, 0x27

    aput-byte v18, v1, v8

    const/16 v8, 0x8a

    const/16 v18, -0x68

    aput-byte v18, v1, v8

    const/16 v8, 0x8b

    const/16 v18, 0x5c

    aput-byte v18, v1, v8

    const/16 v8, 0x8c

    const/16 v18, 0x70

    aput-byte v18, v1, v8

    const/16 v8, 0x8d

    const/16 v18, -0x57

    aput-byte v18, v1, v8

    const/16 v8, 0x8e

    aput-byte v15, v1, v8

    const/16 v8, 0x8f

    const/16 v15, 0x62

    aput-byte v15, v1, v8

    const/16 v8, 0x90

    const/16 v15, 0x37

    aput-byte v15, v1, v8

    const/16 v8, 0x91

    aput-byte v2, v1, v8

    const/16 v8, 0x92

    const/16 v15, 0x51

    aput-byte v15, v1, v8

    const/16 v8, 0x93

    const/16 v15, 0x2f

    aput-byte v15, v1, v8

    const/16 v8, 0x94

    aput-byte v14, v1, v8

    const/16 v8, 0x95

    const/16 v14, -0x25

    aput-byte v14, v1, v8

    const/16 v8, 0x96

    const/16 v14, 0x2e

    aput-byte v14, v1, v8

    const/16 v8, 0x97

    const/16 v14, -0x1f

    aput-byte v14, v1, v8

    const/16 v8, 0x98

    const/16 v14, -0x2d

    aput-byte v14, v1, v8

    const/16 v8, 0x99

    const/16 v14, -0x58

    aput-byte v14, v1, v8

    const/16 v8, 0x9a

    const/16 v14, -0x76

    aput-byte v14, v1, v8

    const/16 v8, 0x9b

    const/16 v14, 0x5d

    aput-byte v14, v1, v8

    const/16 v8, 0x9c

    const/16 v14, -0x46

    aput-byte v14, v1, v8

    const/16 v8, 0x9d

    const/16 v14, 0x62

    aput-byte v14, v1, v8

    const/16 v8, 0x9e

    const/16 v14, 0x19

    aput-byte v14, v1, v8

    const/16 v8, 0x9f

    const/16 v14, -0x43

    aput-byte v14, v1, v8

    const/16 v8, 0xa0

    const/16 v14, 0x3c

    aput-byte v14, v1, v8

    const/16 v8, 0xa1

    const/16 v14, -0x41

    aput-byte v14, v1, v8

    const/16 v8, 0xa2

    aput-byte v17, v1, v8

    const/16 v8, 0xa3

    const/16 v14, 0x19

    aput-byte v14, v1, v8

    const/16 v8, 0xa4

    const/16 v14, 0x30

    aput-byte v14, v1, v8

    const/16 v8, 0xa5

    const/4 v14, -0x6

    aput-byte v14, v1, v8

    const/16 v8, 0xa6

    const/16 v14, 0x14

    aput-byte v14, v1, v8

    const/16 v8, 0xa7

    const/16 v14, 0x51

    aput-byte v14, v1, v8

    const/16 v8, 0xa8

    const/16 v14, 0x41

    aput-byte v14, v1, v8

    const/16 v8, 0xa9

    const/16 v14, 0x23

    aput-byte v14, v1, v8

    const/16 v8, 0xaa

    const/16 v14, -0x76

    aput-byte v14, v1, v8

    const/16 v8, 0xab

    const/16 v14, 0x4a

    aput-byte v14, v1, v8

    const/16 v8, 0xac

    const/16 v14, -0x51

    aput-byte v14, v1, v8

    const/16 v8, 0xad

    const/16 v14, -0x49

    aput-byte v14, v1, v8

    const/16 v8, 0xae

    const/16 v14, 0x15

    aput-byte v14, v1, v8

    const/16 v8, 0xaf

    const/16 v14, 0x3c

    aput-byte v14, v1, v8

    const/16 v8, 0xb0

    const/16 v14, 0x64

    aput-byte v14, v1, v8

    const/16 v8, 0xb1

    const/16 v14, -0x1d

    aput-byte v14, v1, v8

    const/16 v8, 0xb2

    const/16 v14, -0x7c

    aput-byte v14, v1, v8

    const/16 v8, 0xb3

    const/16 v14, -0x11

    aput-byte v14, v1, v8

    const/16 v8, 0xb4

    const/16 v14, -0x7b

    aput-byte v14, v1, v8

    const/16 v8, 0xb5

    const/16 v14, -0x36

    aput-byte v14, v1, v8

    const/16 v8, 0xb6

    const/16 v14, -0x19

    aput-byte v14, v1, v8

    const/16 v8, 0xb7

    const/16 v14, -0xd

    aput-byte v14, v1, v8

    const/16 v8, 0xb8

    const/16 v14, -0x19

    aput-byte v14, v1, v8

    const/16 v8, 0xb9

    const/16 v14, -0x32

    aput-byte v14, v1, v8

    const/16 v8, 0xba

    const/16 v14, -0x3e

    aput-byte v14, v1, v8

    const/16 v8, 0xbb

    const/16 v14, -0x2f

    aput-byte v14, v1, v8

    const/16 v8, 0xbc

    const/16 v14, 0x3a

    aput-byte v14, v1, v8

    const/16 v8, 0xbd

    const/16 v14, -0x24

    aput-byte v14, v1, v8

    const/16 v8, 0xbe

    const/16 v14, -0x59

    aput-byte v14, v1, v8

    const/16 v8, 0xbf

    const/16 v14, -0x31

    aput-byte v14, v1, v8

    const/16 v8, 0xc0

    const/16 v14, -0x5f

    aput-byte v14, v1, v8

    const/16 v8, 0xc1

    const/16 v14, 0x46

    aput-byte v14, v1, v8

    const/16 v8, 0xc2

    const/16 v14, -0x39

    aput-byte v14, v1, v8

    const/16 v8, 0xc3

    const/16 v14, -0x7b

    aput-byte v14, v1, v8

    const/16 v8, 0xc4

    const/16 v14, 0x3f

    aput-byte v14, v1, v8

    const/16 v8, 0xc5

    const/16 v14, -0x42

    aput-byte v14, v1, v8

    const/16 v8, 0xc6

    const/16 v14, -0x28

    aput-byte v14, v1, v8

    const/16 v8, 0xc7

    const/16 v14, 0x37

    aput-byte v14, v1, v8

    const/16 v8, 0xc8

    const/16 v14, -0x7d

    aput-byte v14, v1, v8

    const/16 v8, 0xc9

    const/16 v14, -0x28

    aput-byte v14, v1, v8

    const/16 v8, 0xca

    aput-byte v17, v1, v8

    const/16 v8, 0xcb

    aput-byte v7, v1, v8

    const/16 v7, 0xcc

    const/16 v8, -0x27

    aput-byte v8, v1, v7

    const/16 v7, 0xcd

    const/16 v8, -0x2f

    aput-byte v8, v1, v7

    const/16 v7, 0xce

    const/16 v8, 0x61

    aput-byte v8, v1, v7

    const/16 v7, 0xcf

    const/16 v8, -0x48

    aput-byte v8, v1, v7

    const/16 v7, 0xd0

    const/16 v8, 0x53

    aput-byte v8, v1, v7

    const/16 v7, 0xd1

    const/16 v8, -0x54

    aput-byte v8, v1, v7

    const/16 v7, 0xd2

    const/16 v8, 0x21

    aput-byte v8, v1, v7

    const/16 v7, 0xd3

    const/16 v8, 0x47

    aput-byte v8, v1, v7

    const/16 v7, 0xd4

    const/4 v8, -0x6

    aput-byte v8, v1, v7

    const/16 v7, 0xd5

    const/16 v8, 0xc

    aput-byte v8, v1, v7

    const/16 v7, 0xd6

    aput-byte v13, v1, v7

    const/16 v7, 0xd7

    const/16 v8, -0x63

    aput-byte v8, v1, v7

    const/16 v7, 0xd8

    const/16 v8, 0x35

    aput-byte v8, v1, v7

    const/16 v7, 0xd9

    aput-byte v12, v1, v7

    const/16 v7, 0xda

    const/16 v8, 0x78

    aput-byte v8, v1, v7

    const/16 v7, 0xdb

    const/16 v8, 0x72

    aput-byte v8, v1, v7

    const/16 v7, 0xdc

    const/16 v8, 0x6c

    aput-byte v8, v1, v7

    const/16 v7, 0xdd

    const/4 v8, -0x8

    aput-byte v8, v1, v7

    const/16 v7, 0xde

    const/16 v8, -0x64

    aput-byte v8, v1, v7

    const/16 v7, 0xdf

    const/16 v8, 0x27

    aput-byte v8, v1, v7

    const/16 v7, 0xe0

    const/16 v8, -0x4e

    aput-byte v8, v1, v7

    const/16 v7, 0xe1

    const/16 v8, 0x7e

    aput-byte v8, v1, v7

    const/16 v7, 0xe2

    const/16 v8, 0x2e

    aput-byte v8, v1, v7

    const/16 v7, 0xe3

    aput-byte v16, v1, v7

    const/16 v7, 0xe4

    const/16 v8, -0x7c

    aput-byte v8, v1, v7

    const/16 v7, 0xe5

    const/16 v8, -0x6b

    aput-byte v8, v1, v7

    const/16 v7, 0xe6

    const/16 v8, 0x73

    aput-byte v8, v1, v7

    const/16 v7, 0xe7

    const/16 v8, 0x46

    aput-byte v8, v1, v7

    const/16 v7, 0xe8

    const/16 v8, 0x6a

    aput-byte v8, v1, v7

    const/16 v7, 0xe9

    const/16 v8, 0x3b

    aput-byte v8, v1, v7

    const/16 v7, 0xea

    const/16 v8, -0x21

    aput-byte v8, v1, v7

    const/16 v7, 0xeb

    const/16 v8, 0x36

    aput-byte v8, v1, v7

    const/16 v7, 0xec

    const/16 v8, 0x71

    aput-byte v8, v1, v7

    const/16 v7, 0xed

    const/16 v8, 0x7d

    aput-byte v8, v1, v7

    const/16 v7, 0xee

    const/16 v8, -0x21

    aput-byte v8, v1, v7

    const/16 v7, 0xef

    const/16 v8, 0x7b

    aput-byte v8, v1, v7

    const/16 v7, 0xf0

    const/16 v8, -0x80

    aput-byte v8, v1, v7

    const/16 v7, 0xf1

    const/16 v8, 0xb

    aput-byte v8, v1, v7

    const/16 v7, 0xf2

    const/16 v8, 0x2b

    aput-byte v8, v1, v7

    const/16 v7, 0xf3

    aput-byte v16, v1, v7

    const/16 v7, 0xf4

    const/16 v8, 0x7e

    aput-byte v8, v1, v7

    const/16 v7, 0xf5

    const/16 v8, -0x6f

    aput-byte v8, v1, v7

    const/16 v7, 0xf6

    const/4 v8, -0x1

    aput-byte v8, v1, v7

    const/16 v7, 0xf7

    const/16 v8, -0x6e

    aput-byte v8, v1, v7

    const/16 v7, 0xf8

    aput-byte v20, v1, v7

    const/16 v7, 0xf9

    aput-byte v20, v1, v7

    const/16 v7, 0xfa

    const/16 v8, 0x56

    aput-byte v8, v1, v7

    const/16 v7, 0xfb

    const/16 v8, 0x18

    aput-byte v8, v1, v7

    const/16 v7, 0xfc

    const/16 v8, 0x4e

    aput-byte v8, v1, v7

    const/16 v7, 0xfd

    const/16 v8, 0x78

    aput-byte v8, v1, v7

    const/16 v7, 0xfe

    const/16 v8, -0x7e

    aput-byte v8, v1, v7

    const/16 v7, 0xff

    aput-byte v11, v1, v7

    const/16 v7, 0x100

    const/16 v8, -0xd

    aput-byte v8, v1, v7

    const/16 v7, 0x101

    aput-byte v13, v1, v7

    const/16 v7, 0x102

    const/16 v8, 0x35

    aput-byte v8, v1, v7

    const/16 v7, 0x103

    const/16 v8, 0x16

    aput-byte v8, v1, v7

    const/16 v7, 0x104

    const/4 v8, -0x3

    aput-byte v8, v1, v7

    const/16 v7, 0x105

    const/16 v8, 0x1a

    aput-byte v8, v1, v7

    const/16 v7, 0x106

    const/16 v8, -0x1f

    aput-byte v8, v1, v7

    const/16 v7, 0x107

    const/16 v8, -0x6c

    aput-byte v8, v1, v7

    const/16 v7, 0x108

    const/16 v8, 0x1a

    aput-byte v8, v1, v7

    const/16 v7, 0x109

    const/16 v8, 0x50

    aput-byte v8, v1, v7

    const/16 v7, 0x10a

    aput-byte v20, v1, v7

    const/16 v7, 0x10b

    aput-byte v19, v1, v7

    const/16 v7, 0x10c

    const/16 v8, -0xc

    aput-byte v8, v1, v7

    const/16 v7, 0x10d

    const/16 v8, -0x6c

    aput-byte v8, v1, v7

    const/16 v7, 0x10e

    aput-byte v17, v1, v7

    const/16 v7, 0x10f

    const/16 v8, -0x4d

    aput-byte v8, v1, v7

    const/16 v7, 0x110

    const/16 v8, -0xc

    aput-byte v8, v1, v7

    const/16 v7, 0x111

    const/16 v8, -0x51

    aput-byte v8, v1, v7

    const/16 v7, 0x112

    const/16 v8, -0x45

    aput-byte v8, v1, v7

    const/16 v7, 0x113

    aput-byte v16, v1, v7

    const/16 v7, 0x114

    const/16 v8, -0x6c

    aput-byte v8, v1, v7

    const/16 v7, 0x115

    const/16 v8, 0x73

    aput-byte v8, v1, v7

    const/16 v7, 0x116

    aput-byte v17, v1, v7

    const/16 v7, 0x117

    const/16 v8, 0x8

    aput-byte v8, v1, v7

    const/16 v7, 0x118

    aput-byte v19, v1, v7

    const/16 v7, 0x119

    const/16 v8, -0x20

    aput-byte v8, v1, v7

    const/16 v7, 0x11a

    const/16 v8, 0x67

    aput-byte v8, v1, v7

    const/16 v7, 0x11b

    const/16 v8, -0x9

    aput-byte v8, v1, v7

    const/16 v7, 0x11c

    const/16 v8, 0x61

    aput-byte v8, v1, v7

    const/16 v7, 0x11d

    const/16 v8, -0x39

    aput-byte v8, v1, v7

    const/16 v7, 0x11e

    aput-byte v16, v1, v7

    const/16 v7, 0x11f

    const/16 v8, 0x31

    aput-byte v8, v1, v7

    const/16 v7, 0x120

    const/16 v8, 0x1e

    aput-byte v8, v1, v7

    const/16 v7, 0x121

    const/16 v8, -0x59

    aput-byte v8, v1, v7

    const/16 v7, 0x122

    const/16 v8, 0x48

    aput-byte v8, v1, v7

    const/16 v7, 0x123

    const/16 v8, -0x77

    aput-byte v8, v1, v7

    const/16 v7, 0x124

    const/16 v8, -0x60

    aput-byte v8, v1, v7

    const/16 v7, 0x125

    const/16 v8, -0xf

    aput-byte v8, v1, v7

    const/16 v7, 0x126

    const/16 v8, 0xc

    aput-byte v8, v1, v7

    const/16 v7, 0x127

    const/16 v8, 0x14

    aput-byte v8, v1, v7

    const/16 v7, 0x128

    const/16 v8, -0x67

    aput-byte v8, v1, v7

    const/16 v7, 0x129

    aput-byte v13, v1, v7

    const/16 v7, 0x12a

    const/16 v8, 0x37

    aput-byte v8, v1, v7

    const/16 v7, 0x12b

    const/16 v8, -0xf

    aput-byte v8, v1, v7

    .line 26
    invoke-virtual {v6, v9, v10, v1}, Lcom/inca/security/iIiIiiiIii;->IIIIiiIIII([B[B[B)V

    const/4 v1, 0x0

    .line 4
    invoke-virtual {v6, v0, v5, v1}, Lcom/inca/security/iIiIiiiIii;->IiIIiiiiiI(Ljava/lang/String;Ljava/lang/String;[B)Z

    .line 136
    invoke-static {v5}, Ljava/lang/System;->load(Ljava/lang/String;)V

    .line 198
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;

    invoke-virtual {v0, v4}, Lcom/inca/security/IiiiiiiiiI;->IIIIiiIIII(Z)V

    .line 140
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    goto :goto_1

    .line 29
    :cond_3
    invoke-static/range {p0 .. p0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v0

    .line 173
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 42
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    const-string v1, "]\tW\u0014H\u0004"

    invoke-static {v1}, Lcom/inca/security/IIiIiiiiii;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 98
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;

    invoke-virtual {v0, v3}, Lcom/inca/security/IiiiiiiiiI;->IIIIiiIIII(Z)V

    .line 199
    :cond_4
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 30
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 77
    :cond_5
    :goto_1
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;

    invoke-virtual {v0}, Lcom/inca/security/IiiiiiiiiI;->IiIIiiiiiI()Z

    move-result v0

    if-eqz v0, :cond_7

    :goto_2
    if-lez v2, :cond_6

    .line 129
    new-instance v0, Lcom/inca/security/Proxy/JNISoxProxy$1;

    invoke-direct {v0}, Lcom/inca/security/Proxy/JNISoxProxy$1;-><init>()V

    .line 201
    invoke-virtual {v0}, Lcom/inca/security/Proxy/JNISoxProxy$1;->start()V

    const-wide/16 v0, 0xfa0

    .line 14
    :try_start_2
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    add-int/lit8 v2, v2, -0x1

    goto :goto_2

    .line 22
    :cond_6
    new-instance v0, Landroid/content/Intent;

    const-string v1, "/:*&!=*z\'::1  `5- \'; z\u0003\u0015\u0007\u001a"

    invoke-static {v1}, Lcom/inca/security/IIiiiiiiii;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "y)|5w.|iq)l\"v36$y3} w5aiP\u0008U\u0002"

    .line 58
    invoke-static {v1}, Lcom/inca/security/IIiIiiiiii;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    const/high16 v1, 0x14000000

    .line 87
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 101
    :try_start_3
    invoke-static {}, Lcom/inca/security/Proxy/JNISoxProxy;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :try_start_4
    const-string v0, "/:*&!=*z!\'`\u0004<;-1=\'"

    .line 38
    invoke-static {v0}, Lcom/inca/security/IIiiiiiiii;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, ",q+t\u0017j({\"k4"

    .line 12
    invoke-static {v1}, Lcom/inca/security/IIiIiiiiii;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Class;

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v5, v2, v4

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    const-string v2, "97\u0004\'0"

    .line 92
    invoke-static {v2}, Lcom/inca/security/IIiiiiiiii;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v5, 0x0

    move-object v6, v5

    check-cast v6, [Ljava/lang/Class;

    invoke-virtual {v0, v2, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 97
    move-object v2, v5

    check-cast v2, [Ljava/lang/Object;

    invoke-virtual {v0, v5, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 218
    new-array v2, v3, [Ljava/lang/Object;

    aput-object v0, v2, v4

    invoke-virtual {v1, v5, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "r&n&6+y)\u007fiK>k3}*"

    .line 99
    invoke-static {v0}, Lcom/inca/security/IIiIiiiiii;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "+,\' "

    .line 182
    invoke-static {v1}, Lcom/inca/security/IIiiiiiiii;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Class;

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v5, v2, v4

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 150
    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v4

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    :cond_7
    return-void
.end method

.method public static setApplicationContext(Landroid/content/Context;)V
    .locals 0

    .line 461
    sput-object p0, Lcom/inca/security/Proxy/JNISoxProxy;->iIIIIiiIiI:Landroid/content/Context;

    return-void
.end method

.method public static setContext(Landroid/content/Context;)V
    .locals 1

    .line 306
    sput-object p0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;

    .line 311
    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IIiIIiiiIi:Landroid/content/Context;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;

    if-nez v0, :cond_0

    .line 233
    new-instance v0, Lcom/inca/security/IiiiiiiiiI;

    invoke-direct {v0, p0}, Lcom/inca/security/IiiiiiiiiI;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/inca/security/Proxy/JNISoxProxy;->IiiiIIiIii:Lcom/inca/security/IiiiiiiiiI;

    :cond_0
    return-void
.end method

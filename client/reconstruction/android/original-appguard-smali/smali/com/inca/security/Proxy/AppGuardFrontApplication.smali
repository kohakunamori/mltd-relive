.class public Lcom/inca/security/Proxy/AppGuardFrontApplication;
.super Landroid/app/Application;
.source "tb"


# static fields
.field public static final synthetic IIIIiiiIIi:I = 0x16

.field public static final synthetic IIiIIiiiIi:I = 0xf

.field public static final synthetic IIiiIiiiIi:I = 0x10

.field public static final synthetic iIIIIiiIiI:I = 0x5

.field public static final synthetic iIiIIiiiii:I = 0x11

.field public static final synthetic iIiiIiIiii:I = 0xd

.field public static final synthetic iiIiiiiIiI:I = 0xb

.field public static final synthetic iiiiiiiiII:I = 0xc


# instance fields
.field private synthetic IIIIiIiIIi:[B

.field private synthetic IIIIiiiiiI:Landroid/content/Context;

.field private synthetic IIIiiiIIiI:[B

.field private synthetic IiIiIiiiIi:Landroid/app/Application;

.field private synthetic IiiIiIiiIi:[B

.field private synthetic IiiiIIiIii:[B

.field private synthetic iIIiIiIIIi:[B

.field private synthetic iIIiIiiiiI:Z

.field private synthetic iiIIIiiiii:[B

.field private synthetic iiIIiIIIII:[B

.field private synthetic iiiIiIIiII:[B

.field private synthetic iiiiiiiiIi:[B


# direct methods
.method public static constructor <clinit>()V
    .locals 1

    .line 151
    :try_start_0
    invoke-static {}, Lcom/inca/security/DexProtect/Binder;->getABI()I

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "compatible"

    .line 46
    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .line 149
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    const/4 v0, 0x0

    .line 35
    iput-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;

    .line 49
    iput-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiiiiI:Landroid/content/Context;

    const/4 v0, 0x0

    .line 175
    iput-boolean v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiiiiI:Z

    const/16 v0, 0x30

    .line 84
    new-array v0, v0, [B

    fill-array-data v0, :array_0

    iput-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiiIiIIiII:[B

    const/4 v0, 0x6

    .line 124
    new-array v0, v0, [B

    fill-array-data v0, :array_1

    iput-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIiiiIIiI:[B

    const/16 v0, 0x10

    .line 74
    new-array v1, v0, [B

    fill-array-data v1, :array_2

    iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiIiIIi:[B

    const/16 v1, 0xd

    .line 40
    new-array v1, v1, [B

    fill-array-data v1, :array_3

    iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiIIIi:[B

    const/16 v1, 0xc

    .line 113
    new-array v2, v1, [B

    fill-array-data v2, :array_4

    iput-object v2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiiiiiiiIi:[B

    .line 105
    new-array v1, v1, [B

    fill-array-data v1, :array_5

    iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiiiIIiIii:[B

    const/16 v1, 0xf

    .line 82
    new-array v1, v1, [B

    fill-array-data v1, :array_6

    iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiIIIiiiii:[B

    const/16 v1, 0x13

    .line 20
    new-array v1, v1, [B

    fill-array-data v1, :array_7

    iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiIIiIIIII:[B

    .line 75
    new-array v0, v0, [B

    fill-array-data v0, :array_8

    iput-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiiIiIiiIi:[B

    return-void

    :array_0
    .array-data 1
        0x14t
        0x4bt
        0x1at
        0xat
        0x1et
        0x4at
        0x14t
        0x45t
        0x59t
        0x57t
        0x12t
        0x47t
        0x2t
        0x56t
        0x1et
        0x50t
        0xet
        0xat
        0x27t
        0x56t
        0x18t
        0x5ct
        0xet
        0xat
        0x36t
        0x54t
        0x7t
        0x63t
        0x2t
        0x45t
        0x5t
        0x40t
        0x27t
        0x56t
        0x18t
        0x5ct
        0xet
        0x65t
        0x7t
        0x54t
        0x1bt
        0x4dt
        0x14t
        0x45t
        0x3t
        0x4dt
        0x18t
        0x4at
    .end array-data

    :array_1
    .array-data 1
        0x16t
        0x50t
        0x3t
        0x45t
        0x14t
        0x4ct
    .end array-data

    nop

    :array_2
    .array-data 1
        0x36t
        0x54t
        0x7t
        0x63t
        0x2t
        0x45t
        0x5t
        0x40t
        0x3et
        0x57t
        0x18t
        0x48t
        0x16t
        0x50t
        0x12t
        0x40t
    .end array-data

    :array_3
    .array-data 1
        0x49t
        0x38t
        0x51t
        0x3t
        0x41t
        0x5t
        0x67t
        0x18t
        0x4at
        0x3t
        0x41t
        0xft
        0x50t
    .end array-data

    nop

    :array_4
    .array-data 1
        0x1at
        0x74t
        0x16t
        0x47t
        0x1ct
        0x45t
        0x10t
        0x41t
        0x3et
        0x4at
        0x11t
        0x4bt
    .end array-data

    :array_5
    .array-data 1
        0x1at
        0x65t
        0x7t
        0x54t
        0x1bt
        0x4dt
        0x14t
        0x45t
        0x3t
        0x4dt
        0x18t
        0x4at
    .end array-data

    :array_6
    .array-data 1
        0x49t
        0x36t
        0x47t
        0x3t
        0x4dt
        0x1t
        0x4dt
        0x3t
        0x5dt
        0x23t
        0x4ct
        0x5t
        0x41t
        0x16t
        0x40t
    .end array-data

    :array_7
    .array-data 1
        0x49t
        0x3et
        0x4at
        0x1et
        0x50t
        0x1et
        0x45t
        0x1bt
        0x65t
        0x7t
        0x54t
        0x1bt
        0x4dt
        0x14t
        0x45t
        0x3t
        0x4dt
        0x18t
        0x4at
    .end array-data

    :array_8
    .array-data 1
        0x1at
        0x65t
        0x1bt
        0x48t
        0x36t
        0x54t
        0x7t
        0x48t
        0x1et
        0x47t
        0x16t
        0x50t
        0x1et
        0x4bt
        0x19t
        0x57t
    .end array-data
.end method

.method private static synthetic IIIIiiIIII(I)Ljava/lang/String;
    .locals 0

    .line 201
    invoke-static {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiIII(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private synthetic IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1
    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p2

    if-eqz p2, :cond_0

    .line 99
    invoke-static {p1}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(I)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p2, 0x0

    const/4 v0, 0x5

    if-eq p1, v0, :cond_3

    const/16 v0, 0xf

    if-eq p1, v0, :cond_2

    const/16 v0, 0x10

    if-eq p1, v0, :cond_1

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    .line 442
    :pswitch_0
    iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiiIiIiiIi:[B

    goto :goto_0

    .line 472
    :pswitch_1
    iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiIIIiiiii:[B

    goto :goto_0

    .line 311
    :pswitch_2
    iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiiiIIiIii:[B

    goto :goto_0

    .line 411
    :cond_1
    iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiIIIi:[B

    goto :goto_0

    .line 461
    :cond_2
    iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiIIiIIIII:[B

    goto :goto_0

    .line 300
    :cond_3
    iget-object p2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiiiiiiiIi:[B

    .line 293
    :goto_0
    new-instance p1, Ljava/lang/String;

    const-string v0, "UTF-8"

    invoke-direct {p1, p2, v0}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-direct {p0, p1}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :pswitch_data_0
    .packed-switch 0xb
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private synthetic IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .line 453
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v1, v0, -0x1

    .line 443
    new-array v0, v0, [C

    :goto_0
    if-ltz v1, :cond_1

    add-int/lit8 v2, v1, -0x1

    .line 430
    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    xor-int/lit8 v3, v3, 0x24

    int-to-char v3, v3

    aput-char v3, v0, v1

    if-gez v2, :cond_0

    goto :goto_1

    :cond_0
    add-int/lit8 v1, v2, -0x1

    .line 361
    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    xor-int/lit8 v3, v3, 0x77

    int-to-char v3, v3

    aput-char v3, v0, v2

    goto :goto_0

    .line 342
    :cond_1
    :goto_1
    new-instance p1, Ljava/lang/String;

    invoke-direct {p1, v0}, Ljava/lang/String;-><init>([C)V

    return-object p1
.end method

.method private synthetic IIIIiiIIII()V
    .locals 6

    const-string v0, "UTF-8"

    .line 68
    :try_start_0
    new-instance v1, Ljava/lang/String;

    iget-object v2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iiiIiIIiII:[B

    invoke-direct {v1, v2, v0}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-direct {p0, v1}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 145
    invoke-virtual {v1}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/Application;

    iput-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;

    const-class v1, Landroid/app/Application;

    const/4 v2, 0x0

    .line 130
    invoke-direct {p0, v2}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Z)V

    .line 209
    new-instance v3, Ljava/lang/String;

    iget-object v4, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIiiiIIiI:[B

    invoke-direct {v3, v4, v0}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-direct {p0, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v3, 0x1

    new-array v4, v3, [Ljava/lang/Class;

    const-class v5, Landroid/content/Context;

    aput-object v5, v4, v2

    invoke-virtual {v1, v0, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 36
    invoke-virtual {v0, v3}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 73
    iget-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;

    new-array v3, v3, [Ljava/lang/Object;

    iget-object v4, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiiiiI:Landroid/content/Context;

    aput-object v4, v3, v2

    invoke-virtual {v0, v1, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private synthetic IIIIiiIIII(Z)V
    .locals 4

    .line 122
    monitor-enter p0

    .line 193
    :try_start_0
    new-instance v0, Lcom/inca/security/Core/ObjectReflector;

    iget-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiiiiI:Landroid/content/Context;

    const/16 v2, 0x10

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-direct {p0, v2, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/inca/security/Core/ObjectReflector;-><init>(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;

    invoke-virtual {v0, v1}, Lcom/inca/security/Core/ObjectReflector;->set(Ljava/lang/Object;)V

    .line 108
    new-instance v0, Lcom/inca/security/Core/ObjectReflector;

    iget-object v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiiiiI:Landroid/content/Context;

    const/4 v2, 0x5

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-direct {p0, v2, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/inca/security/Core/ObjectReflector;-><init>(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/inca/security/Core/ObjectReflector;->get()Ljava/lang/Object;

    move-result-object v0

    .line 180
    new-instance v1, Lcom/inca/security/Core/ObjectReflector;

    const/16 v2, 0xb

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-direct {p0, v2, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v0, v2}, Lcom/inca/security/Core/ObjectReflector;-><init>(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;

    invoke-virtual {v1, v2}, Lcom/inca/security/Core/ObjectReflector;->set(Ljava/lang/Object;)V

    .line 67
    new-instance v1, Lcom/inca/security/Core/ObjectReflector;

    const/16 v2, 0xc

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-direct {p0, v2, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v0, v2}, Lcom/inca/security/Core/ObjectReflector;-><init>(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/inca/security/Core/ObjectReflector;->get()Ljava/lang/Object;

    move-result-object v0

    .line 187
    new-instance v1, Lcom/inca/security/Core/ObjectReflector;

    const/16 v2, 0xf

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-direct {p0, v2, v3}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v0, v2}, Lcom/inca/security/Core/ObjectReflector;-><init>(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;

    invoke-virtual {v1, v2}, Lcom/inca/security/Core/ObjectReflector;->set(Ljava/lang/Object;)V

    if-eqz p1, :cond_0

    .line 19
    iget-boolean v1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiiiiI:Z

    if-nez v1, :cond_0

    .line 147
    new-instance v1, Lcom/inca/security/Core/ObjectReflector;

    const/16 v2, 0xd

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    invoke-direct {p0, v2, p1}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(ILjava/lang/Boolean;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v1, v0, p1}, Lcom/inca/security/Core/ObjectReflector;-><init>(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/inca/security/Core/ObjectReflector;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/ArrayList;

    const/4 v0, 0x1

    .line 65
    iput-boolean v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiiiiI:Z

    .line 168
    invoke-virtual {p1, p0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 222
    iget-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    goto :goto_1

    .line 26
    :catch_0
    :cond_0
    :goto_0
    :try_start_1
    monitor-exit p0

    return-void

    :goto_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method private synthetic IIIIiiIIII()Z
    .locals 5

    const/4 v0, 0x0

    .line 27
    :try_start_0
    invoke-virtual {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-super {p0}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x80

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    .line 83
    iget-object v1, v1, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    new-instance v2, Ljava/lang/String;

    iget-object v3, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiIiIIi:[B

    const-string v4, "UTF-8"

    invoke-direct {v2, v3, v4}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-virtual {v1, v2, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :catch_0
    :cond_0
    return v0
.end method

.method private synthetic IIiiIiIiIi()V
    .locals 1

    .line 188
    :try_start_0
    invoke-static {}, Lcom/inca/security/DexProtect/Binder;->getABI()I

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "compatible"

    .line 17
    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private synthetic IiIIiiiiiI()V
    .locals 1

    const/4 v0, 0x1

    .line 9
    :try_start_0
    invoke-direct {p0, v0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Z)V

    .line 13
    iget-object v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIiIiiiIi:Landroid/app/Application;

    invoke-virtual {v0}, Landroid/app/Application;->onCreate()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private synthetic IiIIiiiiiI()Z
    .locals 2

    .line 77
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v0

    const v1, 0x186a0

    .line 61
    rem-int/2addr v0, v1

    const v1, 0x15f90

    if-lt v0, v1, :cond_0

    const v1, 0x1869f

    if-gt v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method private static native synthetic IiIiIiiIII(I)Ljava/lang/String;
.end method


# virtual methods
.method public attachBaseContext(Landroid/content/Context;)V
    .locals 0

    .line 95
    invoke-super {p0, p1}, Landroid/app/Application;->attachBaseContext(Landroid/content/Context;)V

    .line 21
    iput-object p1, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiiiiI:Landroid/content/Context;

    .line 174
    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII()Z

    move-result p1

    if-eqz p1, :cond_1

    .line 127
    :cond_0
    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII()V

    :cond_1
    return-void
.end method

.method public getPackageName()Ljava/lang/String;
    .locals 1

    .line 10
    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 191
    :cond_0
    invoke-super {p0}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 213
    :cond_1
    :goto_0
    iget-boolean v0, p0, Lcom/inca/security/Proxy/AppGuardFrontApplication;->iIIiIiiiiI:Z

    if-nez v0, :cond_2

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII(Z)V

    :cond_2
    const-string v0, ""

    return-object v0
.end method

.method public onCreate()V
    .locals 1

    .line 70
    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    .line 204
    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIIIiiIIII()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 194
    :cond_0
    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IIiiIiIiIi()V

    return-void

    .line 219
    :cond_1
    :goto_0
    invoke-direct {p0}, Lcom/inca/security/Proxy/AppGuardFrontApplication;->IiIIiiiiiI()V

    return-void
.end method

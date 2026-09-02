.class public Lcom/smrtbeat/SmartBeat;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static _leaveAutomaticBreadcrumbs(Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_1

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/smrtbeat/d;

    sget-object v1, Lcom/smrtbeat/e;->e:Lcom/smrtbeat/e;

    invoke-direct {v0, v1, p0, p1}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    :cond_2
    :goto_0
    return-void
.end method

.method private static a(Landroid/app/Application;Ljava/lang/String;ZLjava/util/Collection;ZZ)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Application;",
            "Ljava/lang/String;",
            "Z",
            "Ljava/util/Collection<",
            "Ljava/lang/Integer;",
            ">;ZZ)V"
        }
    .end annotation

    const/4 v0, 0x1

    xor-int/2addr p2, v0

    invoke-static {p2}, Lcom/smrtbeat/f0;->a(Z)V

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result p2

    if-nez p2, :cond_0

    sget-object p0, Lcom/smrtbeat/f0$e;->c:Lcom/smrtbeat/f0$e;

    new-array p1, v0, [Ljava/lang/Object;

    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const/4 p3, 0x0

    aput-object p2, p1, p3

    const-string p2, "This Android version(%d) is not supported"

    invoke-static {p2, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return-void

    :cond_0
    invoke-static {}, Lcom/smrtbeat/f0;->l()Z

    move-result p2

    if-eqz p2, :cond_1

    return-void

    :cond_1
    invoke-virtual {p0}, Landroid/app/Application;->getApplicationContext()Landroid/content/Context;

    move-result-object p2

    if-eqz p2, :cond_7

    if-eqz p1, :cond_6

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_6

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x24

    if-eq v0, v1, :cond_2

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Invalid api key:"

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string p1, "SmartBeat"

    invoke-static {p1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_2
    invoke-static {p2}, Lcom/smrtbeat/f0;->f(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-static {v0}, Lcom/smrtbeat/f0;->e(Landroid/content/SharedPreferences;)V

    sput-object p1, Lcom/smrtbeat/j;->o:Ljava/lang/String;

    invoke-static {p2}, Lcom/smrtbeat/f0;->k(Landroid/content/Context;)V

    invoke-static {p2}, Lcom/smrtbeat/j;->a(Landroid/content/Context;)V

    invoke-static {}, Lcom/smrtbeat/k;->g()V

    invoke-static {p0, p3, p5}, Lcom/smrtbeat/SmartBeatJni;->a(Landroid/content/Context;Ljava/util/Collection;Z)Z

    move-result p1

    sput-boolean p1, Lcom/smrtbeat/j;->E:Z

    invoke-static {p0}, Lcom/smrtbeat/SmartBeatJni;->a(Landroid/content/Context;)Z

    move-result p1

    sput-boolean p1, Lcom/smrtbeat/j;->F:Z

    invoke-static {}, Ljava/lang/Thread;->getDefaultUncaughtExceptionHandler()Ljava/lang/Thread$UncaughtExceptionHandler;

    move-result-object p1

    new-instance p2, Lcom/smrtbeat/ExceptionHandler;

    invoke-direct {p2, p1}, Lcom/smrtbeat/ExceptionHandler;-><init>(Ljava/lang/Thread$UncaughtExceptionHandler;)V

    invoke-static {p2}, Ljava/lang/Thread;->setDefaultUncaughtExceptionHandler(Ljava/lang/Thread$UncaughtExceptionHandler;)V

    if-eqz p4, :cond_3

    new-instance p1, Lcom/smrtbeat/d;

    sget-object p2, Lcom/smrtbeat/e;->i:Lcom/smrtbeat/e;

    const-string p3, "BOOT"

    invoke-direct {p1, p2, p3}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;)V

    invoke-static {p1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    invoke-static {p0}, Lcom/smrtbeat/f0;->a(Landroid/app/Application;)V

    :cond_3
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 p2, 0xe

    if-lt p1, p2, :cond_5

    invoke-static {p0, p4}, Lcom/smrtbeat/u;->a(Landroid/app/Application;Z)V

    :try_start_0
    invoke-static {}, Lcom/smrtbeat/a;->e()Lorg/json/JSONObject;

    move-result-object p0

    invoke-static {p0}, Lcom/smrtbeat/o;->c(Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p0

    if-eqz p0, :cond_4

    invoke-static {}, Lcom/smrtbeat/f0;->k()Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-static {p0}, Lcom/smrtbeat/k;->a(Lorg/json/JSONObject;)V

    :cond_4
    invoke-static {}, Lcom/smrtbeat/a;->f()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    sget-object p1, Lcom/smrtbeat/f0$e;->b:Lcom/smrtbeat/f0$e;

    const-string p2, "failed to handle abort data"

    invoke-static {p1, p2, p0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_5
    :goto_0
    invoke-static {}, Lcom/smrtbeat/k;->e()V

    invoke-static {}, Lcom/smrtbeat/k;->p()V

    return-void

    :cond_6
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "apiKey must not be empty"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_7
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "context must not be null"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static a()Z
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x8

    if-ge v0, v1, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public static addExtraData(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {p0, p1}, Lcom/smrtbeat/f0;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static addExtraData(Ljava/util/HashMap;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v1, v0}, Lcom/smrtbeat/SmartBeat;->addExtraData(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method public static beginOnDrawFrame()Z
    .locals 1

    invoke-static {}, Lcom/smrtbeat/s;->b()Z

    move-result v0

    return v0
.end method

.method public static disable()V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Z)V

    return-void
.end method

.method public static disableAutoScreenCapture()V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    sput-boolean v0, Lcom/smrtbeat/j;->Q:Z

    return-void
.end method

.method public static enable()V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Z)V

    return-void
.end method

.method public static enableAutoScreenCapture()V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/smrtbeat/j;->Q:Z

    return-void
.end method

.method public static enableDebugLog(Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sput-object p0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    return-void
.end method

.method public static enableLogCat()V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/smrtbeat/j;->K:Z

    const-string v0, ""

    sput-object v0, Lcom/smrtbeat/j;->L:Ljava/lang/String;

    return-void
.end method

.method public static enableLogCat(Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/smrtbeat/j;->K:Z

    sput-object p0, Lcom/smrtbeat/j;->L:Ljava/lang/String;

    return-void
.end method

.method public static endOnDrawFrame()V
    .locals 0

    invoke-static {}, Lcom/smrtbeat/s;->e()V

    return-void
.end method

.method public static flush()V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lcom/smrtbeat/f0;->l()Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    invoke-static {}, Lcom/smrtbeat/k;->p()V

    return-void
.end method

.method public static initAndStartSession(Landroid/app/Application;Lcom/smrtbeat/SmartBeatConfig;)V
    .locals 6

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/smrtbeat/SmartBeatConfig;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/smrtbeat/SmartBeatConfig;->b()Z

    move-result v2

    invoke-virtual {p1}, Lcom/smrtbeat/SmartBeatConfig;->c()Ljava/util/Collection;

    move-result-object v3

    invoke-virtual {p1}, Lcom/smrtbeat/SmartBeatConfig;->getAutoBreadcrumb()Z

    move-result v4

    invoke-virtual {p1}, Lcom/smrtbeat/SmartBeatConfig;->getCallOtherSignalHandlers()Z

    move-result v5

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lcom/smrtbeat/SmartBeat;->a(Landroid/app/Application;Ljava/lang/String;ZLjava/util/Collection;ZZ)V

    return-void

    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p0
.end method

.method public static initAndStartSession(Landroid/app/Application;Ljava/lang/String;)V
    .locals 6

    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v4, 0x1

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    invoke-static/range {v0 .. v5}, Lcom/smrtbeat/SmartBeat;->a(Landroid/app/Application;Ljava/lang/String;ZLjava/util/Collection;ZZ)V

    return-void
.end method

.method public static initAndStartSession(Landroid/app/Application;Ljava/lang/String;Z)V
    .locals 6

    const/4 v3, 0x0

    const/4 v4, 0x1

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    invoke-static/range {v0 .. v5}, Lcom/smrtbeat/SmartBeat;->a(Landroid/app/Application;Ljava/lang/String;ZLjava/util/Collection;ZZ)V

    return-void
.end method

.method public static initAndStartSession(Landroid/app/Application;Ljava/lang/String;ZZ)V
    .locals 6

    const/4 v3, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v4, p3

    invoke-static/range {v0 .. v5}, Lcom/smrtbeat/SmartBeat;->a(Landroid/app/Application;Ljava/lang/String;ZLjava/util/Collection;ZZ)V

    return-void
.end method

.method public static isEnabled()Z
    .locals 1

    sget-boolean v0, Lcom/smrtbeat/j;->e0:Z

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public static isReadyForDuplicateUserCountPrevention()Z
    .locals 1

    invoke-static {}, Lcom/smrtbeat/f0;->a()Z

    move-result v0

    return v0
.end method

.method public static isWhiteListed()Z
    .locals 1

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-static {v0}, Lcom/smrtbeat/s;->e(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static leaveBreadcrumbs(Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_1

    goto :goto_0

    :cond_1
    invoke-static {p0}, Lcom/smrtbeat/f0;->a(Ljava/lang/String;)V

    :cond_2
    :goto_0
    return-void
.end method

.method public static leaveBreadcrumbs(Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_1

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/smrtbeat/d;

    sget-object v1, Lcom/smrtbeat/e;->c:Lcom/smrtbeat/e;

    invoke-direct {v0, v1, p0, p1}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    :cond_2
    :goto_0
    return-void
.end method

.method public static log(Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/smrtbeat/q;->a(Ljava/lang/String;)V

    return-void
.end method

.method static logHandleExceptionCustom(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/lang/String;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lcom/smrtbeat/f0;->l()Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    invoke-static {p6}, Lcom/smrtbeat/i;->a(Ljava/lang/String;)Lcom/smrtbeat/i;

    move-result-object v6

    if-nez v6, :cond_2

    return-void

    :cond_2
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object p6

    invoke-virtual {p6}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object p6

    if-nez p4, :cond_3

    const/4 v0, 0x1

    const/4 v8, 0x1

    goto :goto_0

    :cond_3
    const/4 v0, 0x0

    const/4 v8, 0x0

    :goto_0
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p5

    move-object v7, p6

    invoke-static/range {v1 .. v8}, Lcom/smrtbeat/ExceptionHandler;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/smrtbeat/i;Ljava/lang/String;Z)V

    if-eqz p4, :cond_4

    invoke-virtual {p4}, Ljava/lang/String;->length()I

    move-result p0

    if-lez p0, :cond_4

    new-instance p0, Ljava/lang/Thread;

    new-instance p1, Lcom/smrtbeat/SmartBeat$a;

    invoke-direct {p1}, Lcom/smrtbeat/SmartBeat$a;-><init>()V

    new-instance p2, Ljava/io/File;

    invoke-direct {p2, p4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, p2, p6}, Lcom/smrtbeat/SmartBeat$a;->a(Ljava/io/File;Ljava/lang/String;)Ljava/lang/Runnable;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    const/4 p1, 0x2

    invoke-virtual {p0, p1}, Ljava/lang/Thread;->setPriority(I)V

    invoke-virtual {p0}, Ljava/lang/Thread;->start()V

    :cond_4
    return-void
.end method

.method public static logHandleExceptionForCocos2dJs(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    new-instance v5, Ljava/util/HashMap;

    invoke-direct {v5}, Ljava/util/HashMap;-><init>()V

    const-string v0, "engineVersion"

    invoke-interface {v5, v0, p3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p3, "scriptDirPath"

    const-string v0, "assets"

    invoke-interface {v5, p3, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object p3, Lcom/smrtbeat/i;->g:Lcom/smrtbeat/i;

    invoke-virtual {p3}, Lcom/smrtbeat/i;->c()Ljava/lang/String;

    move-result-object v6

    const/4 v0, 0x0

    const/4 v4, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    invoke-static/range {v0 .. v6}, Lcom/smrtbeat/SmartBeat;->logHandleExceptionCustom(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/lang/String;)V

    return-void
.end method

.method public static logHandleExceptionForUnity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const-string v0, ""

    invoke-static {p0, p1, p2, v0}, Lcom/smrtbeat/SmartBeat;->logHandleExceptionForUnity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static logHandleExceptionForUnity(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 8

    sget-object v0, Lcom/smrtbeat/i;->f:Lcom/smrtbeat/i;

    invoke-virtual {v0}, Lcom/smrtbeat/i;->c()Ljava/lang/String;

    move-result-object v7

    const/4 v2, 0x0

    const/4 v6, 0x0

    move-object v1, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-static/range {v1 .. v7}, Lcom/smrtbeat/SmartBeat;->logHandleExceptionCustom(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/lang/String;)V

    return-void
.end method

.method public static logHandledException(Landroid/content/Context;Ljava/lang/Throwable;)V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lcom/smrtbeat/f0;->l()Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    invoke-static {p0, p1}, Lcom/smrtbeat/ExceptionHandler;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    return-void
.end method

.method public static notifyActivityStarted(Landroid/app/Activity;)V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xe

    if-lt v0, v1, :cond_0

    sget-object v0, Lcom/smrtbeat/j;->o:Ljava/lang/String;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    invoke-virtual {p0}, Landroid/app/Activity;->hasWindowFocus()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/smrtbeat/b;->a()Lcom/smrtbeat/b;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/smrtbeat/b;->b(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public static notifyOnPause(Landroid/app/Activity;)V
    .locals 2

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xe

    if-ge v0, v1, :cond_1

    invoke-static {p0}, Lcom/smrtbeat/f0;->a(Landroid/app/Activity;)V

    :cond_1
    return-void
.end method

.method public static notifyOnResume(Landroid/app/Activity;)V
    .locals 2

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xe

    if-ge v0, v1, :cond_1

    invoke-static {p0}, Lcom/smrtbeat/f0;->b(Landroid/app/Activity;)V

    goto :goto_0

    :cond_1
    invoke-static {p0}, Lcom/smrtbeat/f0;->c(Landroid/app/Activity;)V

    :goto_0
    return-void
.end method

.method public static notifyRunning()V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lcom/smrtbeat/f0;->l()Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    invoke-static {}, Lcom/smrtbeat/k;->k()V

    return-void
.end method

.method public static onSurfaceCreated(I)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/smrtbeat/SmartBeat;->onSurfaceCreated(IZ)V

    return-void
.end method

.method public static onSurfaceCreated(IZ)V
    .locals 0

    sput p0, Lcom/smrtbeat/j;->G:I

    invoke-static {p1}, Lcom/smrtbeat/s;->a(Z)V

    return-void
.end method

.method public static setActivityAsSensitive(Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/smrtbeat/j;->S:Ljava/util/List;

    monitor-enter v0

    :try_start_0
    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0

    :cond_2
    :goto_0
    return-void
.end method

.method public static setActivityAsSensitive(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p0, :cond_2

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/smrtbeat/j;->S:Ljava/util/List;

    monitor-enter v0

    :try_start_0
    invoke-interface {v0, p0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0

    :cond_2
    :goto_0
    return-void
.end method

.method public static setOpenGLESVersion(I)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const-string p0, "SmartBeat"

    const-string v0, "deprecated API (SmartBeat.setOpenGLESVersion) is used."

    invoke-static {p0, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public static setUserId(Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/SmartBeat;->a()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sput-object p0, Lcom/smrtbeat/j;->M:Ljava/lang/String;

    return-void
.end method

.method public static whiteListBoardForOpenGLES(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const-string p0, "SmartBeat"

    const-string v0, "deprecated API (SmartBeat.whiteListBoardForOpenGLES) is used."

    invoke-static {p0, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public static whiteListModelForOpenGLES(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Lcom/smrtbeat/s;->b(Ljava/lang/String;)V

    return-void
.end method

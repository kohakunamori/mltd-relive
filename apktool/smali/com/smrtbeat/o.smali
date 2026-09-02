.class Lcom/smrtbeat/o;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:I = 0x1


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static a()Lorg/json/JSONObject;
    .locals 4

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    const-string v2, "type"

    const-string v3, "ping"

    invoke-static {v1, v2, v3}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v2, Lcom/smrtbeat/j;->M:Ljava/lang/String;

    const-string v3, "userId"

    invoke-static {v1, v3, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    const-string v3, "occuredAt"

    invoke-static {v1, v3, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string v2, "request"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/o;->d()Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "environment"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/o;->c()Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "sdk"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method private static a(J)Lorg/json/JSONObject;
    .locals 3

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "type"

    const-string v2, "breakpad-exception-report"

    invoke-static {v0, v1, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Lcom/smrtbeat/j;->M:Ljava/lang/String;

    const-string v2, "userId"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Lcom/smrtbeat/j;->D:Ljava/lang/String;

    const-string v2, "requestId"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {p0, p1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p0

    const-string p1, "occuredAt"

    invoke-static {v0, p1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method private static a(JZ)Lorg/json/JSONObject;
    .locals 3

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    sget-object v1, Lcom/smrtbeat/j;->M:Ljava/lang/String;

    const-string v2, "userId"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    if-nez p2, :cond_0

    sget-object p2, Lcom/smrtbeat/j;->D:Ljava/lang/String;

    :goto_0
    const-string v1, "requestId"

    invoke-static {v0, v1, p2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_1

    :cond_0
    invoke-static {}, Lcom/smrtbeat/f0;->b()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :goto_1
    invoke-static {p0, p1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p0

    const-string p1, "occuredAt"

    invoke-static {v0, p1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method static a(Landroid/content/Context;)Lorg/json/JSONObject;
    .locals 6

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Lcom/smrtbeat/o;->a(J)Lorg/json/JSONObject;

    move-result-object v3

    const-string v4, "request"

    invoke-static {v0, v4, v3}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v4, v3}, Lcom/smrtbeat/o;->a(Ljava/lang/Throwable;Z)Lorg/json/JSONObject;

    move-result-object v4

    const-string v5, "exception"

    invoke-static {v0, v5, v4}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {p0}, Lcom/smrtbeat/o;->b(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v4

    const-string v5, "performance"

    invoke-static {v0, v5, v4}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {p0, v1, v2, v3}, Lcom/smrtbeat/o;->a(Landroid/content/Context;JZ)Lorg/json/JSONObject;

    move-result-object p0

    const-string v1, "environment"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/o;->c()Lorg/json/JSONObject;

    move-result-object p0

    const-string v1, "sdk"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method private static a(Landroid/content/Context;JZ)Lorg/json/JSONObject;
    .locals 3

    invoke-static {}, Lcom/smrtbeat/o;->d()Lorg/json/JSONObject;

    move-result-object v0

    if-eqz p0, :cond_0

    invoke-static {p0}, Lcom/smrtbeat/f0;->d(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "mobileNet"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {p0}, Lcom/smrtbeat/f0;->i(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "wifi"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {p0}, Lcom/smrtbeat/f0;->e(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    const-string v1, "screenRotation"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    :cond_0
    sget p0, Lcom/smrtbeat/j;->y:I

    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    const-string v1, "screenDpi"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget p0, Lcom/smrtbeat/j;->z:I

    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    const-string v1, "screenWidth"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget p0, Lcom/smrtbeat/j;->A:I

    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    const-string v1, "screenHeight"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/f0;->c()Ljava/lang/String;

    move-result-object p0

    const-string v1, "board"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/f0;->e()Ljava/lang/String;

    move-result-object p0

    const-string v1, "boardPlatform"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/f0;->f()Ljava/lang/String;

    move-result-object p0

    const-string v1, "cpuAbi"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object p0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v1, "manufacturer"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object p0, Landroid/os/Build;->TYPE:Ljava/lang/String;

    const-string v1, "buildType"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {v0, p1, p2, p3}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;JZ)V

    invoke-static {v0}, Lcom/smrtbeat/o;->b(Lorg/json/JSONObject;)V

    return-object v0
.end method

.method static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/smrtbeat/i;Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Lcom/smrtbeat/i;",
            "Ljava/lang/String;",
            ")",
            "Lorg/json/JSONObject;"
        }
    .end annotation

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Lcom/smrtbeat/o;->a(JZ)Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {p5}, Lcom/smrtbeat/i;->d()Ljava/lang/String;

    move-result-object v4

    const-string v5, "type"

    invoke-static {v3, v5, v4}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string v4, "requestId"

    invoke-static {v3, v4, p6}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p6

    const-string v4, "occuredAt"

    invoke-static {v3, v4, p6}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string p6, "request"

    invoke-static {v0, p6, v3}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {p5, p4}, Lcom/smrtbeat/i;->a(Ljava/util/Map;)Ljava/util/Map;

    move-result-object p4

    invoke-virtual {p5}, Lcom/smrtbeat/i;->b()Z

    move-result p6

    invoke-static {p1, p2, p3, p4, p6}, Lcom/smrtbeat/o;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Lorg/json/JSONObject;

    move-result-object p1

    const-string p2, "exception"

    invoke-static {v0, p2, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {p0}, Lcom/smrtbeat/o;->b(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object p1

    const-string p2, "performance"

    invoke-static {v0, p2, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {p5}, Lcom/smrtbeat/i;->a()Z

    move-result p1

    invoke-static {p0, v1, v2, p1}, Lcom/smrtbeat/o;->a(Landroid/content/Context;JZ)Lorg/json/JSONObject;

    move-result-object p0

    const-string p1, "environment"

    invoke-static {v0, p1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/o;->c()Lorg/json/JSONObject;

    move-result-object p0

    const-string p1, "sdk"

    invoke-static {v0, p1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method static a(Landroid/content/Context;Ljava/lang/Throwable;Z)Lorg/json/JSONObject;
    .locals 6

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2, p2}, Lcom/smrtbeat/o;->a(JZ)Lorg/json/JSONObject;

    move-result-object v3

    const-string v4, "type"

    const-string v5, "exception-report"

    invoke-static {v3, v4, v5}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string v4, "request"

    invoke-static {v0, v4, v3}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {p1, p2}, Lcom/smrtbeat/o;->a(Ljava/lang/Throwable;Z)Lorg/json/JSONObject;

    move-result-object p1

    const-string p2, "exception"

    invoke-static {v0, p2, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {p0}, Lcom/smrtbeat/o;->b(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object p1

    const-string p2, "performance"

    invoke-static {v0, p2, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const/4 p1, 0x0

    invoke-static {p0, v1, v2, p1}, Lcom/smrtbeat/o;->a(Landroid/content/Context;JZ)Lorg/json/JSONObject;

    move-result-object p0

    const-string p1, "environment"

    invoke-static {v0, p1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/o;->c()Lorg/json/JSONObject;

    move-result-object p0

    const-string p1, "sdk"

    invoke-static {v0, p1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method private static a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Lorg/json/JSONObject;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;Z)",
            "Lorg/json/JSONObject;"
        }
    .end annotation

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    if-eqz p0, :cond_0

    const-string v1, "cause"

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    :cond_0
    if-eqz p1, :cond_1

    const-string p0, "message"

    invoke-static {v0, p0, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    :cond_1
    if-eqz p2, :cond_2

    const-string p0, "stackTrace"

    invoke-static {v0, p0, p2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    :cond_2
    if-eqz p3, :cond_3

    new-instance p0, Lorg/json/JSONObject;

    invoke-direct {p0, p3}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    const-string p1, "auxData"

    invoke-static {v0, p1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    :cond_3
    invoke-static {v0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;)V

    invoke-static {p4}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object p0

    const-string p1, "handled"

    invoke-static {v0, p1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method private static a(Ljava/lang/Throwable;Z)Lorg/json/JSONObject;
    .locals 1

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    if-eqz p0, :cond_0

    invoke-static {v0, p0}, Lcom/smrtbeat/o;->b(Lorg/json/JSONObject;Ljava/lang/Throwable;)V

    invoke-static {v0, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/Throwable;)V

    invoke-static {v0, p0}, Lcom/smrtbeat/o;->c(Lorg/json/JSONObject;Ljava/lang/Throwable;)V

    invoke-static {v0, p0}, Lcom/smrtbeat/o;->d(Lorg/json/JSONObject;Ljava/lang/Throwable;)V

    :cond_0
    invoke-static {v0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;)V

    invoke-static {p1}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object p0

    const-string p1, "handled"

    invoke-static {v0, p1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method private static a(Lorg/json/JSONObject;)V
    .locals 4

    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    sget-object v1, Lcom/smrtbeat/j;->H:Ljava/util/List;

    if-eqz v1, :cond_1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_1

    monitor-enter v1

    :try_start_0
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :catch_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/smrtbeat/d;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v3}, Lcom/smrtbeat/d;->a()Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v0, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :cond_0
    :try_start_2
    monitor-exit v1

    goto :goto_1

    :catchall_0
    move-exception p0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p0

    :cond_1
    :goto_1
    const-string v1, "breadcrumbV2s"

    invoke-static {p0, v1, v0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method private static a(Lorg/json/JSONObject;JZ)V
    .locals 3

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    sget-boolean v1, Lcom/smrtbeat/j;->K:Z

    if-eqz v1, :cond_0

    if-nez p3, :cond_0

    invoke-static {}, Lcom/smrtbeat/f0;->p()Ljava/lang/String;

    move-result-object p3

    :goto_0
    const-string v1, "log"

    invoke-static {v0, v1, p3}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_1

    :cond_0
    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object p3

    invoke-virtual {p3}, Lcom/smrtbeat/q;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_1

    goto :goto_0

    :cond_1
    :goto_1
    sget-boolean p3, Lcom/smrtbeat/j;->x:Z

    invoke-static {p3}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object p3

    const-string v1, "hacked"

    invoke-static {v0, v1, p3}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-wide v1, Lcom/smrtbeat/j;->B:J

    sub-long/2addr p1, v1

    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p1

    const-string p2, "msFromStart"

    invoke-static {v0, p2, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string p1, "log"

    invoke-static {p0, p1, v0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method private static a(Lorg/json/JSONObject;Landroid/content/Context;)V
    .locals 4

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    if-eqz p1, :cond_0

    new-instance v1, Landroid/app/ActivityManager$MemoryInfo;

    invoke-direct {v1}, Landroid/app/ActivityManager$MemoryInfo;-><init>()V

    const-string v2, "activity"

    invoke-virtual {p1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/ActivityManager;

    invoke-virtual {p1, v1}, Landroid/app/ActivityManager;->getMemoryInfo(Landroid/app/ActivityManager$MemoryInfo;)V

    iget-wide v2, v1, Landroid/app/ActivityManager$MemoryInfo;->availMem:J

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    const-string v3, "sysAvail"

    invoke-static {v0, v3, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    iget-boolean v2, v1, Landroid/app/ActivityManager$MemoryInfo;->lowMemory:Z

    invoke-static {v2}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v2

    const-string v3, "sysLow"

    invoke-static {v0, v3, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    iget-wide v1, v1, Landroid/app/ActivityManager$MemoryInfo;->threshold:J

    invoke-static {v1, v2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    const-string v2, "sysThreshold"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const/4 v1, 0x1

    new-array v1, v1, [I

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v2

    const/4 v3, 0x0

    aput v2, v1, v3

    invoke-virtual {p1, v1}, Landroid/app/ActivityManager;->getProcessMemoryInfo([I)[Landroid/os/Debug$MemoryInfo;

    move-result-object p1

    aget-object p1, p1, v3

    invoke-virtual {p1}, Landroid/os/Debug$MemoryInfo;->getTotalPss()I

    move-result p1

    mul-int/lit16 p1, p1, 0x400

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    const-string v1, "appPss"

    invoke-static {v0, v1, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const-string p1, "sysAvail"

    const-string v1, ""

    invoke-static {v0, p1, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string p1, "sysLow"

    const-string v1, ""

    invoke-static {v0, p1, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string p1, "sysThreshold"

    const-string v1, ""

    invoke-static {v0, p1, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string p1, "appPss"

    const-string v1, ""

    invoke-static {v0, p1, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    :goto_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Runtime;->freeMemory()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    const-string v2, "appAvail"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {p1}, Ljava/lang/Runtime;->maxMemory()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    const-string v2, "appMax"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {p1}, Ljava/lang/Runtime;->totalMemory()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p1

    const-string v1, "appTotal"

    invoke-static {v0, v1, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string p1, "memory"

    invoke-static {p0, p1, v0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method static a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0

    :try_start_0
    invoke-virtual {p0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static a(Lorg/json/JSONObject;Ljava/lang/Throwable;)V
    .locals 1

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "cause"

    invoke-static {p0, v0, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method static b()Lorg/json/JSONObject;
    .locals 4

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    const-string v2, "type"

    const-string v3, "remote"

    invoke-static {v1, v2, v3}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v2, Lcom/smrtbeat/j;->M:Ljava/lang/String;

    const-string v3, "userId"

    invoke-static {v1, v3, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    const-string v3, "occuredAt"

    invoke-static {v1, v3, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string v2, "request"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/o;->d()Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "environment"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/o;->c()Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "sdk"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method private static b(Landroid/content/Context;)Lorg/json/JSONObject;
    .locals 1

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    invoke-static {v0, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Landroid/content/Context;)V

    return-object v0
.end method

.method private static b(Lorg/json/JSONObject;)V
    .locals 5

    sget-object v0, Lcom/smrtbeat/j;->I:Ljava/util/Map;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v1

    if-lez v1, :cond_1

    monitor-enter v0

    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v4, v3}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    const-string v2, "customMeta"

    invoke-static {p0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    monitor-exit v0

    goto :goto_1

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0

    :cond_1
    :goto_1
    return-void
.end method

.method private static b(Lorg/json/JSONObject;Ljava/lang/Throwable;)V
    .locals 1

    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_0

    const-string p1, ""

    :cond_0
    const-string v0, "message"

    invoke-static {p0, v0, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method private static c()Lorg/json/JSONObject;
    .locals 3

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "name"

    const-string v2, "SmartBeat-Android"

    invoke-static {v0, v1, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string v1, "version"

    const-string v2, "1.23.1"

    invoke-static {v0, v1, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method static c(Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 5

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    const/4 v4, 0x1

    invoke-static {v2, v3, v4}, Lcom/smrtbeat/o;->a(JZ)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "type"

    const-string v4, "abort-report"

    invoke-static {v2, v3, v4}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string v3, "request"

    invoke-static {v1, v3, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {p0}, Lcom/smrtbeat/o;->d(Lorg/json/JSONObject;)Lorg/json/JSONObject;

    move-result-object p0

    if-nez p0, :cond_1

    return-object v0

    :cond_1
    const-string v0, "abort"

    invoke-static {v1, v0, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/o;->d()Lorg/json/JSONObject;

    move-result-object p0

    const-string v0, "environment"

    invoke-static {v1, v0, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/o;->c()Lorg/json/JSONObject;

    move-result-object p0

    const-string v0, "sdk"

    invoke-static {v1, v0, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v1
.end method

.method private static c(Lorg/json/JSONObject;Ljava/lang/Throwable;)V
    .locals 4

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {p1}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object p1

    if-eqz p1, :cond_0

    array-length v1, p1

    const/4 v2, 0x1

    if-le v1, v2, :cond_0

    const/4 v1, 0x0

    aget-object v2, p1, v1

    if-eqz v2, :cond_0

    aget-object v2, p1, v1

    invoke-virtual {v2}, Ljava/lang/StackTraceElement;->getFileName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "file"

    invoke-static {v0, v3, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    aget-object v2, p1, v1

    invoke-virtual {v2}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    const-string v3, "line"

    invoke-static {v0, v3, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    aget-object v2, p1, v1

    invoke-virtual {v2}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "class"

    invoke-static {v0, v3, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    aget-object p1, p1, v1

    invoke-virtual {p1}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object p1

    const-string v1, "method"

    invoke-static {v0, v1, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    :cond_0
    const-string p1, "location"

    invoke-static {p0, p1, v0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.method private static d()Lorg/json/JSONObject;
    .locals 3

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    sget-object v1, Lcom/smrtbeat/j;->t:Ljava/lang/String;

    const-string v2, "uid"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Lcom/smrtbeat/j;->u:Ljava/lang/String;

    if-eqz v1, :cond_0

    const-string v2, "idv2"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    :cond_0
    sget-object v1, Lcom/smrtbeat/j;->s:Ljava/lang/String;

    const-string v2, "model"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Lcom/smrtbeat/j;->r:Ljava/lang/String;

    const-string v2, "brand"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Lcom/smrtbeat/j;->q:Ljava/lang/String;

    const-string v2, "appVer"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Lcom/smrtbeat/j;->v:Ljava/lang/String;

    const-string v2, "appVerCode"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Lcom/smrtbeat/j;->p:Ljava/lang/String;

    const-string v2, "appName"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Lcom/smrtbeat/j;->p:Ljava/lang/String;

    const-string v2, "appIdentifier"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Lcom/smrtbeat/j;->w:Ljava/lang/String;

    const-string v2, "osVer"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/f0;->d()Ljava/lang/String;

    move-result-object v1

    const-string v2, "locale"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-boolean v1, Lcom/smrtbeat/j;->e0:Z

    invoke-static {v1}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v1

    const-string v2, "optOutCrashLog"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method private static d(Lorg/json/JSONObject;)Lorg/json/JSONObject;
    .locals 4

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "lastActivateTime"

    :try_start_0
    const-string v2, "last_fg_time"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    const-string v1, "lastActivateTimeFromBoot"

    :try_start_1
    const-string v2, "elapsed_time"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    const-string v1, "timeZoneOffset"

    :try_start_2
    const-string v2, "zone_offset"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    const-string v1, "exit"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result p0
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_0

    const-string v1, "reason"

    :try_start_3
    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    invoke-static {v0, v1, p0}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_0

    return-object v0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static d(Lorg/json/JSONObject;Ljava/lang/Throwable;)V
    .locals 2

    new-instance v0, Ljava/io/StringWriter;

    invoke-direct {v0}, Ljava/io/StringWriter;-><init>()V

    new-instance v1, Ljava/io/PrintWriter;

    invoke-direct {v1, v0}, Ljava/io/PrintWriter;-><init>(Ljava/io/Writer;)V

    invoke-virtual {p1, v1}, Ljava/lang/Throwable;->printStackTrace(Ljava/io/PrintWriter;)V

    invoke-virtual {v0}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "stackTrace"

    invoke-static {p0, v0, p1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method

.class Lcom/smrtbeat/a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/smrtbeat/b$e;


# static fields
.field static final a:Ljava/lang/String; = "version"

.field static final b:Ljava/lang/String; = "app_version_name"

.field static final c:Ljava/lang/String; = "app_version_code"

.field static final d:Ljava/lang/String; = "os_version_fp"

.field static final e:Ljava/lang/String; = "last_fg_time"

.field static final f:Ljava/lang/String; = "zone_offset"

.field static final g:Ljava/lang/String; = "elapsed_time"

.field static final h:Ljava/lang/String; = "exit"

.field private static final i:Ljava/lang/Integer;

.field private static final j:J = 0x5265c00L

.field private static final k:J = 0x927c0L

.field private static l:Lcom/smrtbeat/a;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/a;->i:Ljava/lang/Integer;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a(Lorg/json/JSONObject;)Z
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lcom/smrtbeat/a;->i:Ljava/lang/Integer;

    const-string v2, "version"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    return v0

    :cond_0
    sget-object v1, Lcom/smrtbeat/j;->q:Ljava/lang/String;

    const-string v2, "app_version_name"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    return v0

    :cond_1
    sget-object v1, Lcom/smrtbeat/j;->v:Ljava/lang/String;

    const-string v2, "app_version_code"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v0

    :cond_2
    sget-object v1, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    const-string v2, "os_version_fp"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez p0, :cond_3

    return v0

    :cond_3
    const/4 p0, 0x1

    return p0

    :catch_0
    return v0
.end method

.method static b(Lorg/json/JSONObject;)Z
    .locals 7

    const/4 v0, 0x1

    :try_start_0
    const-string v1, "abort"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p0

    const-string v1, "lastActivateTime"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    const-wide/16 v5, 0x0

    cmp-long p0, v1, v5

    if-lez p0, :cond_1

    cmp-long p0, v3, v5

    if-lez p0, :cond_1

    const-wide/32 v5, 0x5265c00

    sub-long v5, v3, v5

    cmp-long p0, v1, v5

    if-ltz p0, :cond_1

    const-wide/32 v5, 0x927c0

    sub-long/2addr v1, v5

    cmp-long p0, v1, v3

    if-lez p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :catch_0
    :cond_1
    :goto_0
    return v0
.end method

.method static declared-synchronized c()V
    .locals 2

    const-class v0, Lcom/smrtbeat/a;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/smrtbeat/a;->l:Lcom/smrtbeat/a;

    if-eqz v1, :cond_0

    invoke-static {}, Lcom/smrtbeat/k;->f()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private d()Lorg/json/JSONObject;
    .locals 3

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    sget-object v1, Lcom/smrtbeat/a;->i:Ljava/lang/Integer;

    const-string v2, "version"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    const-string v2, "os_version_fp"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "last_fg_time"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Ljava/util/TimeZone;->getDefault()Ljava/util/TimeZone;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/TimeZone;->getRawOffset()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "zone_offset"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "elapsed_time"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    const-string v2, "exit"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Lcom/smrtbeat/j;->q:Ljava/lang/String;

    const-string v2, "app_version_name"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    sget-object v1, Lcom/smrtbeat/j;->v:Ljava/lang/String;

    const-string v2, "app_version_code"

    invoke-static {v0, v2, v1}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v0
.end method

.method static declared-synchronized e()Lorg/json/JSONObject;
    .locals 3

    const-class v0, Lcom/smrtbeat/a;

    monitor-enter v0

    :try_start_0
    invoke-static {}, Lcom/smrtbeat/k;->i()Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-static {}, Lcom/smrtbeat/k;->f()V

    invoke-static {v1}, Lcom/smrtbeat/a;->a(Lorg/json/JSONObject;)Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_0

    const/4 v1, 0x0

    :cond_0
    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method static f()V
    .locals 3

    const-class v0, Lcom/smrtbeat/a;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/smrtbeat/a;->l:Lcom/smrtbeat/a;

    if-nez v1, :cond_0

    new-instance v1, Lcom/smrtbeat/a;

    invoke-direct {v1}, Lcom/smrtbeat/a;-><init>()V

    sput-object v1, Lcom/smrtbeat/a;->l:Lcom/smrtbeat/a;

    invoke-static {}, Lcom/smrtbeat/b;->a()Lcom/smrtbeat/b;

    move-result-object v1

    sget-object v2, Lcom/smrtbeat/a;->l:Lcom/smrtbeat/a;

    invoke-virtual {v1, v2}, Lcom/smrtbeat/b;->a(Lcom/smrtbeat/b$e;)V

    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method static declared-synchronized g()V
    .locals 4

    const-class v0, Lcom/smrtbeat/a;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/smrtbeat/a;->l:Lcom/smrtbeat/a;

    if-eqz v1, :cond_0

    invoke-static {}, Lcom/smrtbeat/k;->i()Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :cond_0

    sget-object v2, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    const-string v3, "exit"

    invoke-static {v1, v3, v2}, Lcom/smrtbeat/o;->a(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-static {}, Lcom/smrtbeat/k;->f()V

    invoke-static {v1}, Lcom/smrtbeat/k;->d(Lorg/json/JSONObject;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method static declared-synchronized h()V
    .locals 2

    const-class v0, Lcom/smrtbeat/a;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/smrtbeat/a;->l:Lcom/smrtbeat/a;

    if-eqz v1, :cond_0

    invoke-direct {v1}, Lcom/smrtbeat/a;->d()Lorg/json/JSONObject;

    move-result-object v1

    invoke-static {v1}, Lcom/smrtbeat/k;->d(Lorg/json/JSONObject;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public a()V
    .locals 0

    invoke-static {}, Lcom/smrtbeat/a;->h()V

    return-void
.end method

.method public b()V
    .locals 0

    invoke-static {}, Lcom/smrtbeat/a;->c()V

    return-void
.end method

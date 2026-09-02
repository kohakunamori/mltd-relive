.class public Lcom/smrtbeat/ExceptionHandler;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Thread$UncaughtExceptionHandler;


# instance fields
.field private a:Ljava/lang/Thread$UncaughtExceptionHandler;


# direct methods
.method constructor <init>(Ljava/lang/Thread$UncaughtExceptionHandler;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/smrtbeat/ExceptionHandler;->a:Ljava/lang/Thread$UncaughtExceptionHandler;

    return-void
.end method

.method static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/smrtbeat/i;Ljava/lang/String;Z)V
    .locals 7
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
            "Z)V"
        }
    .end annotation

    if-nez p0, :cond_0

    invoke-static {}, Lcom/smrtbeat/j;->a()Landroid/content/Context;

    move-result-object p0

    :cond_0
    move-object v0, p0

    invoke-static {}, Lcom/smrtbeat/f0;->k()Z

    move-result p0

    if-eqz p0, :cond_3

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    :try_start_0
    invoke-static/range {v0 .. v6}, Lcom/smrtbeat/o;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/smrtbeat/i;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p0

    if-nez p0, :cond_1

    return-void

    :cond_1
    if-eqz p7, :cond_2

    invoke-static {p6}, Lcom/smrtbeat/f0;->b(Ljava/lang/String;)Ljava/io/File;

    move-result-object p3

    goto :goto_0

    :cond_2
    const/4 p3, 0x0

    :goto_0
    new-instance p4, Ljava/lang/Thread;

    new-instance p5, Lcom/smrtbeat/ExceptionHandler$c;

    invoke-direct {p5, p0, p3}, Lcom/smrtbeat/ExceptionHandler$c;-><init>(Lorg/json/JSONObject;Ljava/io/File;)V

    invoke-direct {p4, p5}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    const/4 p0, 0x2

    invoke-virtual {p4, p0}, Ljava/lang/Thread;->setPriority(I)V

    invoke-virtual {p4}, Ljava/lang/Thread;->start()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p0

    sget-object p3, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    invoke-virtual {p0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p3, p0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :cond_3
    :goto_1
    new-instance p0, Lcom/smrtbeat/d;

    sget-object p3, Lcom/smrtbeat/e;->g:Lcom/smrtbeat/e;

    if-eqz p1, :cond_4

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p4

    if-gtz p4, :cond_5

    :cond_4
    move-object p1, p2

    :cond_5
    const-string p4, "message"

    invoke-static {p4, p2}, Ljava/util/Collections;->singletonMap(Ljava/lang/Object;Ljava/lang/Object;)Ljava/util/Map;

    move-result-object p2

    invoke-direct {p0, p3, p1, p2}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {p0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    return-void
.end method

.method static a(Landroid/content/Context;Ljava/lang/Throwable;)V
    .locals 3

    if-nez p1, :cond_0

    sget-object p0, Lcom/smrtbeat/f0$e;->b:Lcom/smrtbeat/f0$e;

    const-string p1, "Throwable should not be null when calling logHandledException()"

    invoke-static {p0, p1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return-void

    :cond_0
    invoke-static {}, Lcom/smrtbeat/f0;->k()Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Lcom/smrtbeat/o;->a(Landroid/content/Context;Ljava/lang/Throwable;Z)Lorg/json/JSONObject;

    move-result-object p0

    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/smrtbeat/ExceptionHandler$b;

    invoke-direct {v1}, Lcom/smrtbeat/ExceptionHandler$b;-><init>()V

    invoke-virtual {v1, p0}, Lcom/smrtbeat/ExceptionHandler$b;->a(Lorg/json/JSONObject;)Ljava/lang/Runnable;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    new-instance p0, Lcom/smrtbeat/d;

    sget-object v0, Lcom/smrtbeat/e;->g:Lcom/smrtbeat/e;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v2, "message"

    invoke-static {v2, p1}, Ljava/util/Collections;->singletonMap(Ljava/lang/Object;Ljava/lang/Object;)Ljava/util/Map;

    move-result-object p1

    invoke-direct {p0, v0, v1, p1}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {p0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    return-void
.end method


# virtual methods
.method public uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    .locals 5

    invoke-static {}, Lcom/smrtbeat/a;->c()V

    invoke-static {}, Lcom/smrtbeat/j;->a()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x1

    sput-boolean v1, Lcom/smrtbeat/j;->d0:Z

    invoke-static {}, Lcom/smrtbeat/f0;->k()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    :try_start_0
    invoke-static {v0, p2, v1}, Lcom/smrtbeat/o;->a(Landroid/content/Context;Ljava/lang/Throwable;Z)Lorg/json/JSONObject;

    move-result-object v0

    invoke-static {v0}, Lcom/smrtbeat/k;->e(Lorg/json/JSONObject;)Ljava/io/File;

    move-result-object v1

    invoke-static {}, Lcom/smrtbeat/f0;->q()Ljava/io/File;

    move-result-object v2

    new-instance v3, Ljava/lang/Thread;

    new-instance v4, Lcom/smrtbeat/ExceptionHandler$a;

    invoke-direct {v4, p0, v0, v1, v2}, Lcom/smrtbeat/ExceptionHandler$a;-><init>(Lcom/smrtbeat/ExceptionHandler;Lorg/json/JSONObject;Ljava/io/File;Ljava/io/File;)V

    invoke-direct {v3, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v3}, Ljava/lang/Thread;->start()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    sget-object v1, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/smrtbeat/ExceptionHandler;->a:Ljava/lang/Thread$UncaughtExceptionHandler;

    if-eqz v0, :cond_1

    invoke-interface {v0, p1, p2}, Ljava/lang/Thread$UncaughtExceptionHandler;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V

    :cond_1
    const-wide/16 p1, 0x1388

    :try_start_1
    invoke-static {p1, p2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

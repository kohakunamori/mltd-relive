.class Lcom/smrtbeat/ExceptionHandler$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/ExceptionHandler;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lorg/json/JSONObject;

.field final synthetic b:Ljava/io/File;

.field final synthetic c:Ljava/io/File;

.field final synthetic d:Lcom/smrtbeat/ExceptionHandler;


# direct methods
.method constructor <init>(Lcom/smrtbeat/ExceptionHandler;Lorg/json/JSONObject;Ljava/io/File;Ljava/io/File;)V
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/ExceptionHandler$a;->d:Lcom/smrtbeat/ExceptionHandler;

    iput-object p2, p0, Lcom/smrtbeat/ExceptionHandler$a;->a:Lorg/json/JSONObject;

    iput-object p3, p0, Lcom/smrtbeat/ExceptionHandler$a;->b:Ljava/io/File;

    iput-object p4, p0, Lcom/smrtbeat/ExceptionHandler$a;->c:Ljava/io/File;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iget-object v2, p0, Lcom/smrtbeat/ExceptionHandler$a;->a:Lorg/json/JSONObject;

    const-wide/16 v3, 0x1388

    invoke-static {v2, v3, v4}, Lcom/smrtbeat/k;->a(Lorg/json/JSONObject;J)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/smrtbeat/ExceptionHandler$a;->b:Ljava/io/File;

    invoke-static {v2}, Lcom/smrtbeat/k;->b(Ljava/io/File;)V

    iget-object v2, p0, Lcom/smrtbeat/ExceptionHandler$a;->c:Ljava/io/File;

    if-nez v2, :cond_0

    invoke-static {}, Lcom/smrtbeat/k;->h()V

    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v5

    sub-long/2addr v5, v0

    iget-object v0, p0, Lcom/smrtbeat/ExceptionHandler$a;->c:Ljava/io/File;

    if-eqz v0, :cond_1

    cmp-long v1, v3, v5

    if-lez v1, :cond_1

    sub-long/2addr v3, v5

    invoke-static {v0, v3, v4}, Lcom/smrtbeat/k;->a(Ljava/io/File;J)Lcom/smrtbeat/b0;

    move-result-object v0

    iget-object v1, p0, Lcom/smrtbeat/ExceptionHandler$a;->c:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/smrtbeat/b0;->a(Ljava/lang/String;)Lcom/smrtbeat/b0$a;

    move-result-object v0

    sget-object v1, Lcom/smrtbeat/b0$a;->a:Lcom/smrtbeat/b0$a;

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/smrtbeat/ExceptionHandler$a;->c:Ljava/io/File;

    invoke-static {v0}, Lcom/smrtbeat/k;->b(Ljava/io/File;)V

    invoke-static {}, Lcom/smrtbeat/k;->h()V

    :cond_1
    return-void
.end method

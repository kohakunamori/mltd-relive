.class Lcom/smrtbeat/e0;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static a(Lcom/smrtbeat/c0;J)Lcom/smrtbeat/b0;
    .locals 4

    new-instance v0, Ljava/lang/Thread;

    invoke-direct {v0, p0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    const-wide/16 v1, 0x0

    cmp-long v3, p1, v1

    if-lez v3, :cond_0

    :try_start_0
    invoke-virtual {v0, p1, p2}, Ljava/lang/Thread;->join(J)V

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/Thread;->join()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    invoke-interface {p0}, Lcom/smrtbeat/c0;->a()Lcom/smrtbeat/b0;

    move-result-object p0

    if-nez p0, :cond_1

    new-instance p0, Lcom/smrtbeat/b0;

    invoke-direct {p0}, Lcom/smrtbeat/b0;-><init>()V

    :cond_1
    return-object p0
.end method

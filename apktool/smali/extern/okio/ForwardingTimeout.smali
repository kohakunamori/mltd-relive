.class public Lextern/okio/ForwardingTimeout;
.super Lextern/okio/Timeout;
.source "ForwardingTimeout.java"


# instance fields
.field private delegate:Lextern/okio/Timeout;


# direct methods
.method public constructor <init>(Lextern/okio/Timeout;)V
    .locals 1

    .line 25
    invoke-direct {p0}, Lextern/okio/Timeout;-><init>()V

    if-eqz p1, :cond_0

    .line 27
    iput-object p1, p0, Lextern/okio/ForwardingTimeout;->delegate:Lextern/okio/Timeout;

    return-void

    .line 26
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "delegate == null"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method


# virtual methods
.method public clearDeadline()Lextern/okio/Timeout;
    .locals 1

    .line 66
    iget-object v0, p0, Lextern/okio/ForwardingTimeout;->delegate:Lextern/okio/Timeout;

    invoke-virtual {v0}, Lextern/okio/Timeout;->clearDeadline()Lextern/okio/Timeout;

    move-result-object v0

    return-object v0
.end method

.method public clearTimeout()Lextern/okio/Timeout;
    .locals 1

    .line 62
    iget-object v0, p0, Lextern/okio/ForwardingTimeout;->delegate:Lextern/okio/Timeout;

    invoke-virtual {v0}, Lextern/okio/Timeout;->clearTimeout()Lextern/okio/Timeout;

    move-result-object v0

    return-object v0
.end method

.method public deadlineNanoTime()J
    .locals 2

    .line 54
    iget-object v0, p0, Lextern/okio/ForwardingTimeout;->delegate:Lextern/okio/Timeout;

    invoke-virtual {v0}, Lextern/okio/Timeout;->deadlineNanoTime()J

    move-result-wide v0

    return-wide v0
.end method

.method public deadlineNanoTime(J)Lextern/okio/Timeout;
    .locals 1

    .line 58
    iget-object v0, p0, Lextern/okio/ForwardingTimeout;->delegate:Lextern/okio/Timeout;

    invoke-virtual {v0, p1, p2}, Lextern/okio/Timeout;->deadlineNanoTime(J)Lextern/okio/Timeout;

    move-result-object p1

    return-object p1
.end method

.method public final delegate()Lextern/okio/Timeout;
    .locals 1

    .line 32
    iget-object v0, p0, Lextern/okio/ForwardingTimeout;->delegate:Lextern/okio/Timeout;

    return-object v0
.end method

.method public hasDeadline()Z
    .locals 1

    .line 50
    iget-object v0, p0, Lextern/okio/ForwardingTimeout;->delegate:Lextern/okio/Timeout;

    invoke-virtual {v0}, Lextern/okio/Timeout;->hasDeadline()Z

    move-result v0

    return v0
.end method

.method public final setDelegate(Lextern/okio/Timeout;)Lextern/okio/ForwardingTimeout;
    .locals 1

    if-eqz p1, :cond_0

    .line 37
    iput-object p1, p0, Lextern/okio/ForwardingTimeout;->delegate:Lextern/okio/Timeout;

    return-object p0

    .line 36
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "delegate == null"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public throwIfReached()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 70
    iget-object v0, p0, Lextern/okio/ForwardingTimeout;->delegate:Lextern/okio/Timeout;

    invoke-virtual {v0}, Lextern/okio/Timeout;->throwIfReached()V

    return-void
.end method

.method public timeout(JLjava/util/concurrent/TimeUnit;)Lextern/okio/Timeout;
    .locals 1

    .line 42
    iget-object v0, p0, Lextern/okio/ForwardingTimeout;->delegate:Lextern/okio/Timeout;

    invoke-virtual {v0, p1, p2, p3}, Lextern/okio/Timeout;->timeout(JLjava/util/concurrent/TimeUnit;)Lextern/okio/Timeout;

    move-result-object p1

    return-object p1
.end method

.method public timeoutNanos()J
    .locals 2

    .line 46
    iget-object v0, p0, Lextern/okio/ForwardingTimeout;->delegate:Lextern/okio/Timeout;

    invoke-virtual {v0}, Lextern/okio/Timeout;->timeoutNanos()J

    move-result-wide v0

    return-wide v0
.end method

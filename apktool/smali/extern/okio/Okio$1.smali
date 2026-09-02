.class final Lextern/okio/Okio$1;
.super Ljava/lang/Object;
.source "Okio.java"

# interfaces
.implements Lextern/okio/Sink;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lextern/okio/Okio;->sink(Ljava/io/OutputStream;Lextern/okio/Timeout;)Lextern/okio/Sink;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$out:Ljava/io/OutputStream;

.field final synthetic val$timeout:Lextern/okio/Timeout;


# direct methods
.method constructor <init>(Lextern/okio/Timeout;Ljava/io/OutputStream;)V
    .locals 0

    .line 70
    iput-object p1, p0, Lextern/okio/Okio$1;->val$timeout:Lextern/okio/Timeout;

    iput-object p2, p0, Lextern/okio/Okio$1;->val$out:Ljava/io/OutputStream;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 95
    iget-object v0, p0, Lextern/okio/Okio$1;->val$out:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    return-void
.end method

.method public flush()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 91
    iget-object v0, p0, Lextern/okio/Okio$1;->val$out:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V

    return-void
.end method

.method public timeout()Lextern/okio/Timeout;
    .locals 1

    .line 99
    iget-object v0, p0, Lextern/okio/Okio$1;->val$timeout:Lextern/okio/Timeout;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 103
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "sink("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lextern/okio/Okio$1;->val$out:Ljava/io/OutputStream;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public write(Lextern/okio/Buffer;J)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 72
    iget-wide v0, p1, Lextern/okio/Buffer;->size:J

    const-wide/16 v2, 0x0

    move-wide v4, p2

    invoke-static/range {v0 .. v5}, Lextern/okio/Util;->checkOffsetAndCount(JJJ)V

    :cond_0
    :goto_0
    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-lez v2, :cond_1

    .line 74
    iget-object v0, p0, Lextern/okio/Okio$1;->val$timeout:Lextern/okio/Timeout;

    invoke-virtual {v0}, Lextern/okio/Timeout;->throwIfReached()V

    .line 75
    iget-object v0, p1, Lextern/okio/Buffer;->head:Lextern/okio/Segment;

    .line 76
    iget v1, v0, Lextern/okio/Segment;->limit:I

    iget v2, v0, Lextern/okio/Segment;->pos:I

    sub-int/2addr v1, v2

    int-to-long v1, v1

    invoke-static {p2, p3, v1, v2}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v1

    long-to-int v2, v1

    .line 77
    iget-object v1, p0, Lextern/okio/Okio$1;->val$out:Ljava/io/OutputStream;

    iget-object v3, v0, Lextern/okio/Segment;->data:[B

    iget v4, v0, Lextern/okio/Segment;->pos:I

    invoke-virtual {v1, v3, v4, v2}, Ljava/io/OutputStream;->write([BII)V

    .line 79
    iget v1, v0, Lextern/okio/Segment;->pos:I

    add-int/2addr v1, v2

    iput v1, v0, Lextern/okio/Segment;->pos:I

    int-to-long v1, v2

    sub-long/2addr p2, v1

    .line 81
    iget-wide v3, p1, Lextern/okio/Buffer;->size:J

    sub-long/2addr v3, v1

    iput-wide v3, p1, Lextern/okio/Buffer;->size:J

    .line 83
    iget v1, v0, Lextern/okio/Segment;->pos:I

    iget v2, v0, Lextern/okio/Segment;->limit:I

    if-ne v1, v2, :cond_0

    .line 84
    invoke-virtual {v0}, Lextern/okio/Segment;->pop()Lextern/okio/Segment;

    move-result-object v1

    iput-object v1, p1, Lextern/okio/Buffer;->head:Lextern/okio/Segment;

    .line 85
    invoke-static {v0}, Lextern/okio/SegmentPool;->recycle(Lextern/okio/Segment;)V

    goto :goto_0

    :cond_1
    return-void
.end method

.class final Lextern/okhttp3/internal/ws/WebSocketWriter;
.super Ljava/lang/Object;
.source "WebSocketWriter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lextern/okhttp3/internal/ws/WebSocketWriter$FrameSink;
    }
.end annotation


# instance fields
.field activeWriter:Z

.field final buffer:Lextern/okio/Buffer;

.field final frameSink:Lextern/okhttp3/internal/ws/WebSocketWriter$FrameSink;

.field final isClient:Z

.field private final maskCursor:Lextern/okio/Buffer$UnsafeCursor;

.field private final maskKey:[B

.field final random:Ljava/util/Random;

.field final sink:Lextern/okio/BufferedSink;

.field final sinkBuffer:Lextern/okio/Buffer;

.field writerClosed:Z


# direct methods
.method constructor <init>(ZLextern/okio/BufferedSink;Ljava/util/Random;)V
    .locals 1

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    new-instance v0, Lextern/okio/Buffer;

    invoke-direct {v0}, Lextern/okio/Buffer;-><init>()V

    iput-object v0, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->buffer:Lextern/okio/Buffer;

    .line 41
    new-instance v0, Lextern/okhttp3/internal/ws/WebSocketWriter$FrameSink;

    invoke-direct {v0, p0}, Lextern/okhttp3/internal/ws/WebSocketWriter$FrameSink;-><init>(Lextern/okhttp3/internal/ws/WebSocketWriter;)V

    iput-object v0, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->frameSink:Lextern/okhttp3/internal/ws/WebSocketWriter$FrameSink;

    if-eqz p2, :cond_3

    if-eqz p3, :cond_2

    .line 51
    iput-boolean p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->isClient:Z

    .line 52
    iput-object p2, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sink:Lextern/okio/BufferedSink;

    .line 53
    invoke-interface {p2}, Lextern/okio/BufferedSink;->buffer()Lextern/okio/Buffer;

    move-result-object p2

    iput-object p2, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    .line 54
    iput-object p3, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->random:Ljava/util/Random;

    const/4 p2, 0x0

    if-eqz p1, :cond_0

    const/4 p3, 0x4

    .line 57
    new-array p3, p3, [B

    goto :goto_0

    :cond_0
    move-object p3, p2

    :goto_0
    iput-object p3, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    if-eqz p1, :cond_1

    .line 58
    new-instance p2, Lextern/okio/Buffer$UnsafeCursor;

    invoke-direct {p2}, Lextern/okio/Buffer$UnsafeCursor;-><init>()V

    :cond_1
    iput-object p2, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskCursor:Lextern/okio/Buffer$UnsafeCursor;

    return-void

    .line 50
    :cond_2
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "random == null"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 49
    :cond_3
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "sink == null"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method private writeControlFrame(ILextern/okio/ByteString;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 100
    iget-boolean v0, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->writerClosed:Z

    if-nez v0, :cond_3

    .line 102
    invoke-virtual {p2}, Lextern/okio/ByteString;->size()I

    move-result v0

    int-to-long v1, v0

    const-wide/16 v3, 0x7d

    cmp-long v5, v1, v3

    if-gtz v5, :cond_2

    or-int/lit16 p1, p1, 0x80

    .line 109
    iget-object v1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {v1, p1}, Lextern/okio/Buffer;->writeByte(I)Lextern/okio/Buffer;

    .line 112
    iget-boolean p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->isClient:Z

    if-eqz p1, :cond_0

    or-int/lit16 p1, v0, 0x80

    .line 114
    iget-object v1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {v1, p1}, Lextern/okio/Buffer;->writeByte(I)Lextern/okio/Buffer;

    .line 116
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->random:Ljava/util/Random;

    iget-object v1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    invoke-virtual {p1, v1}, Ljava/util/Random;->nextBytes([B)V

    .line 117
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    iget-object v1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    invoke-virtual {p1, v1}, Lextern/okio/Buffer;->write([B)Lextern/okio/Buffer;

    if-lez v0, :cond_1

    .line 120
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {p1}, Lextern/okio/Buffer;->size()J

    move-result-wide v0

    .line 121
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {p1, p2}, Lextern/okio/Buffer;->write(Lextern/okio/ByteString;)Lextern/okio/Buffer;

    .line 123
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    iget-object p2, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskCursor:Lextern/okio/Buffer$UnsafeCursor;

    invoke-virtual {p1, p2}, Lextern/okio/Buffer;->readAndWriteUnsafe(Lextern/okio/Buffer$UnsafeCursor;)Lextern/okio/Buffer$UnsafeCursor;

    .line 124
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskCursor:Lextern/okio/Buffer$UnsafeCursor;

    invoke-virtual {p1, v0, v1}, Lextern/okio/Buffer$UnsafeCursor;->seek(J)I

    .line 125
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskCursor:Lextern/okio/Buffer$UnsafeCursor;

    iget-object p2, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    invoke-static {p1, p2}, Lextern/okhttp3/internal/ws/WebSocketProtocol;->toggleMask(Lextern/okio/Buffer$UnsafeCursor;[B)V

    .line 126
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskCursor:Lextern/okio/Buffer$UnsafeCursor;

    invoke-virtual {p1}, Lextern/okio/Buffer$UnsafeCursor;->close()V

    goto :goto_0

    .line 129
    :cond_0
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {p1, v0}, Lextern/okio/Buffer;->writeByte(I)Lextern/okio/Buffer;

    .line 130
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {p1, p2}, Lextern/okio/Buffer;->write(Lextern/okio/ByteString;)Lextern/okio/Buffer;

    .line 133
    :cond_1
    :goto_0
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sink:Lextern/okio/BufferedSink;

    invoke-interface {p1}, Lextern/okio/BufferedSink;->flush()V

    return-void

    .line 104
    :cond_2
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "Payload size must be less than or equal to 125"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 100
    :cond_3
    new-instance p1, Ljava/io/IOException;

    const-string p2, "closed"

    invoke-direct {p1, p2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1
.end method


# virtual methods
.method newMessageSink(IJ)Lextern/okio/Sink;
    .locals 2

    .line 141
    iget-boolean v0, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->activeWriter:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    .line 144
    iput-boolean v0, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->activeWriter:Z

    .line 147
    iget-object v1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->frameSink:Lextern/okhttp3/internal/ws/WebSocketWriter$FrameSink;

    iput p1, v1, Lextern/okhttp3/internal/ws/WebSocketWriter$FrameSink;->formatOpcode:I

    .line 148
    iput-wide p2, v1, Lextern/okhttp3/internal/ws/WebSocketWriter$FrameSink;->contentLength:J

    .line 149
    iput-boolean v0, v1, Lextern/okhttp3/internal/ws/WebSocketWriter$FrameSink;->isFirstFrame:Z

    const/4 p1, 0x0

    .line 150
    iput-boolean p1, v1, Lextern/okhttp3/internal/ws/WebSocketWriter$FrameSink;->closed:Z

    return-object v1

    .line 142
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Another message writer is active. Did you call close()?"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method writeClose(ILextern/okio/ByteString;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 79
    sget-object v0, Lextern/okio/ByteString;->EMPTY:Lextern/okio/ByteString;

    if-nez p1, :cond_0

    if-eqz p2, :cond_3

    :cond_0
    if-eqz p1, :cond_1

    .line 82
    invoke-static {p1}, Lextern/okhttp3/internal/ws/WebSocketProtocol;->validateCloseCode(I)V

    .line 84
    :cond_1
    new-instance v0, Lextern/okio/Buffer;

    invoke-direct {v0}, Lextern/okio/Buffer;-><init>()V

    .line 85
    invoke-virtual {v0, p1}, Lextern/okio/Buffer;->writeShort(I)Lextern/okio/Buffer;

    if-eqz p2, :cond_2

    .line 87
    invoke-virtual {v0, p2}, Lextern/okio/Buffer;->write(Lextern/okio/ByteString;)Lextern/okio/Buffer;

    .line 89
    :cond_2
    invoke-virtual {v0}, Lextern/okio/Buffer;->readByteString()Lextern/okio/ByteString;

    move-result-object v0

    :cond_3
    const/16 p1, 0x8

    const/4 p2, 0x1

    .line 93
    :try_start_0
    invoke-direct {p0, p1, v0}, Lextern/okhttp3/internal/ws/WebSocketWriter;->writeControlFrame(ILextern/okio/ByteString;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 95
    iput-boolean p2, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->writerClosed:Z

    return-void

    :catchall_0
    move-exception p1

    iput-boolean p2, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->writerClosed:Z

    throw p1
.end method

.method writeMessageFrame(IJZZ)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 157
    iget-boolean v0, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->writerClosed:Z

    if-nez v0, :cond_7

    const/4 v0, 0x0

    if-eqz p4, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    if-eqz p5, :cond_1

    or-int/lit16 p1, p1, 0x80

    .line 163
    :cond_1
    iget-object p4, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {p4, p1}, Lextern/okio/Buffer;->writeByte(I)Lextern/okio/Buffer;

    .line 166
    iget-boolean p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->isClient:Z

    if-eqz p1, :cond_2

    const/16 v0, 0x80

    :cond_2
    const-wide/16 p4, 0x7d

    cmp-long p1, p2, p4

    if-gtz p1, :cond_3

    long-to-int p1, p2

    or-int/2addr p1, v0

    .line 171
    iget-object p4, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {p4, p1}, Lextern/okio/Buffer;->writeByte(I)Lextern/okio/Buffer;

    goto :goto_1

    :cond_3
    const-wide/32 p4, 0xffff

    cmp-long p1, p2, p4

    if-gtz p1, :cond_4

    or-int/lit8 p1, v0, 0x7e

    .line 174
    iget-object p4, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {p4, p1}, Lextern/okio/Buffer;->writeByte(I)Lextern/okio/Buffer;

    .line 175
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    long-to-int p4, p2

    invoke-virtual {p1, p4}, Lextern/okio/Buffer;->writeShort(I)Lextern/okio/Buffer;

    goto :goto_1

    :cond_4
    or-int/lit8 p1, v0, 0x7f

    .line 178
    iget-object p4, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {p4, p1}, Lextern/okio/Buffer;->writeByte(I)Lextern/okio/Buffer;

    .line 179
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {p1, p2, p3}, Lextern/okio/Buffer;->writeLong(J)Lextern/okio/Buffer;

    .line 182
    :goto_1
    iget-boolean p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->isClient:Z

    if-eqz p1, :cond_5

    .line 183
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->random:Ljava/util/Random;

    iget-object p4, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    invoke-virtual {p1, p4}, Ljava/util/Random;->nextBytes([B)V

    .line 184
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    iget-object p4, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    invoke-virtual {p1, p4}, Lextern/okio/Buffer;->write([B)Lextern/okio/Buffer;

    const-wide/16 p4, 0x0

    cmp-long p1, p2, p4

    if-lez p1, :cond_6

    .line 187
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    invoke-virtual {p1}, Lextern/okio/Buffer;->size()J

    move-result-wide p4

    .line 188
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    iget-object v0, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->buffer:Lextern/okio/Buffer;

    invoke-virtual {p1, v0, p2, p3}, Lextern/okio/Buffer;->write(Lextern/okio/Buffer;J)V

    .line 190
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    iget-object p2, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskCursor:Lextern/okio/Buffer$UnsafeCursor;

    invoke-virtual {p1, p2}, Lextern/okio/Buffer;->readAndWriteUnsafe(Lextern/okio/Buffer$UnsafeCursor;)Lextern/okio/Buffer$UnsafeCursor;

    .line 191
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskCursor:Lextern/okio/Buffer$UnsafeCursor;

    invoke-virtual {p1, p4, p5}, Lextern/okio/Buffer$UnsafeCursor;->seek(J)I

    .line 192
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskCursor:Lextern/okio/Buffer$UnsafeCursor;

    iget-object p2, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    invoke-static {p1, p2}, Lextern/okhttp3/internal/ws/WebSocketProtocol;->toggleMask(Lextern/okio/Buffer$UnsafeCursor;[B)V

    .line 193
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->maskCursor:Lextern/okio/Buffer$UnsafeCursor;

    invoke-virtual {p1}, Lextern/okio/Buffer$UnsafeCursor;->close()V

    goto :goto_2

    .line 196
    :cond_5
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sinkBuffer:Lextern/okio/Buffer;

    iget-object p4, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->buffer:Lextern/okio/Buffer;

    invoke-virtual {p1, p4, p2, p3}, Lextern/okio/Buffer;->write(Lextern/okio/Buffer;J)V

    .line 199
    :cond_6
    :goto_2
    iget-object p1, p0, Lextern/okhttp3/internal/ws/WebSocketWriter;->sink:Lextern/okio/BufferedSink;

    invoke-interface {p1}, Lextern/okio/BufferedSink;->emit()Lextern/okio/BufferedSink;

    return-void

    .line 157
    :cond_7
    new-instance p1, Ljava/io/IOException;

    const-string p2, "closed"

    invoke-direct {p1, p2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method writePing(Lextern/okio/ByteString;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/16 v0, 0x9

    .line 63
    invoke-direct {p0, v0, p1}, Lextern/okhttp3/internal/ws/WebSocketWriter;->writeControlFrame(ILextern/okio/ByteString;)V

    return-void
.end method

.method writePong(Lextern/okio/ByteString;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/16 v0, 0xa

    .line 68
    invoke-direct {p0, v0, p1}, Lextern/okhttp3/internal/ws/WebSocketWriter;->writeControlFrame(ILextern/okio/ByteString;)V

    return-void
.end method

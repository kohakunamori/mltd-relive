.class public final Lorg/apache/commons/net/io/Util;
.super Ljava/lang/Object;
.source "Util.java"


# static fields
.field public static final DEFAULT_COPY_BUFFER_SIZE:I = 0x400


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static closeQuietly(Ljava/io/Closeable;)V
    .locals 0

    if-eqz p0, :cond_0

    .line 354
    :try_start_0
    invoke-interface {p0}, Ljava/io/Closeable;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public static closeQuietly(Ljava/net/Socket;)V
    .locals 0

    if-eqz p0, :cond_0

    .line 370
    :try_start_0
    invoke-virtual {p0}, Ljava/net/Socket;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public static final copyReader(Ljava/io/Reader;Ljava/io/Writer;)J
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/net/io/CopyStreamException;
        }
    .end annotation

    const/16 v0, 0x400

    .line 341
    invoke-static {p0, p1, v0}, Lorg/apache/commons/net/io/Util;->copyReader(Ljava/io/Reader;Ljava/io/Writer;I)J

    move-result-wide p0

    return-wide p0
.end method

.method public static final copyReader(Ljava/io/Reader;Ljava/io/Writer;I)J
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/net/io/CopyStreamException;
        }
    .end annotation

    const-wide/16 v3, -0x1

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    .line 330
    invoke-static/range {v0 .. v5}, Lorg/apache/commons/net/io/Util;->copyReader(Ljava/io/Reader;Ljava/io/Writer;IJLorg/apache/commons/net/io/CopyStreamListener;)J

    move-result-wide p0

    return-wide p0
.end method

.method public static final copyReader(Ljava/io/Reader;Ljava/io/Writer;IJLorg/apache/commons/net/io/CopyStreamListener;)J
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/net/io/CopyStreamException;
        }
    .end annotation

    move-object v0, p1

    if-ltz p2, :cond_0

    move v1, p2

    goto :goto_0

    :cond_0
    const/16 v1, 0x400

    .line 264
    :goto_0
    new-array v7, v1, [C

    const-wide/16 v1, 0x0

    move-object v8, p0

    .line 268
    :goto_1
    :try_start_0
    invoke-virtual {p0, v7}, Ljava/io/Reader;->read([C)I

    move-result v4

    const/4 v3, -0x1

    if-eq v4, v3, :cond_4

    if-nez v4, :cond_2

    .line 274
    invoke-virtual {p0}, Ljava/io/Reader;->read()I

    move-result v4

    if-gez v4, :cond_1

    goto :goto_3

    .line 278
    :cond_1
    invoke-virtual {p1, v4}, Ljava/io/Writer;->write(I)V

    .line 279
    invoke-virtual {p1}, Ljava/io/Writer;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    const-wide/16 v5, 0x1

    add-long v9, v1, v5

    if-eqz p5, :cond_3

    move-object/from16 v1, p5

    move-wide v2, v9

    move-wide v5, p3

    .line 282
    :try_start_1
    invoke-interface/range {v1 .. v6}, Lorg/apache/commons/net/io/CopyStreamListener;->bytesTransferred(JIJ)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :cond_2
    const/4 v3, 0x0

    .line 287
    :try_start_2
    invoke-virtual {p1, v7, v3, v4}, Ljava/io/Writer;->write([CII)V

    .line 288
    invoke-virtual {p1}, Ljava/io/Writer;->flush()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    int-to-long v5, v4

    add-long v9, v1, v5

    if-eqz p5, :cond_3

    move-object/from16 v1, p5

    move-wide v2, v9

    move-wide v5, p3

    .line 291
    :try_start_3
    invoke-interface/range {v1 .. v6}, Lorg/apache/commons/net/io/CopyStreamListener;->bytesTransferred(JIJ)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    move-wide v1, v9

    goto :goto_4

    :cond_3
    :goto_2
    move-wide v1, v9

    goto :goto_1

    :cond_4
    :goto_3
    return-wide v1

    :catch_1
    move-exception v0

    .line 297
    :goto_4
    new-instance v3, Lorg/apache/commons/net/io/CopyStreamException;

    const-string v4, "IOException caught while copying."

    invoke-direct {v3, v4, v1, v2, v0}, Lorg/apache/commons/net/io/CopyStreamException;-><init>(Ljava/lang/String;JLjava/io/IOException;)V

    goto :goto_6

    :goto_5
    throw v3

    :goto_6
    goto :goto_5
.end method

.method public static final copyStream(Ljava/io/InputStream;Ljava/io/OutputStream;)J
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/net/io/CopyStreamException;
        }
    .end annotation

    const/16 v0, 0x400

    .line 221
    invoke-static {p0, p1, v0}, Lorg/apache/commons/net/io/Util;->copyStream(Ljava/io/InputStream;Ljava/io/OutputStream;I)J

    move-result-wide p0

    return-wide p0
.end method

.method public static final copyStream(Ljava/io/InputStream;Ljava/io/OutputStream;I)J
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/net/io/CopyStreamException;
        }
    .end annotation

    const-wide/16 v3, -0x1

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    .line 210
    invoke-static/range {v0 .. v5}, Lorg/apache/commons/net/io/Util;->copyStream(Ljava/io/InputStream;Ljava/io/OutputStream;IJLorg/apache/commons/net/io/CopyStreamListener;)J

    move-result-wide p0

    return-wide p0
.end method

.method public static final copyStream(Ljava/io/InputStream;Ljava/io/OutputStream;IJLorg/apache/commons/net/io/CopyStreamListener;)J
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/net/io/CopyStreamException;
        }
    .end annotation

    const/4 v6, 0x1

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-wide v3, p3

    move-object v5, p5

    .line 179
    invoke-static/range {v0 .. v6}, Lorg/apache/commons/net/io/Util;->copyStream(Ljava/io/InputStream;Ljava/io/OutputStream;IJLorg/apache/commons/net/io/CopyStreamListener;Z)J

    move-result-wide p0

    return-wide p0
.end method

.method public static final copyStream(Ljava/io/InputStream;Ljava/io/OutputStream;IJLorg/apache/commons/net/io/CopyStreamListener;Z)J
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/net/io/CopyStreamException;
        }
    .end annotation

    move-object v0, p1

    if-ltz p2, :cond_0

    move v1, p2

    goto :goto_0

    :cond_0
    const/16 v1, 0x400

    .line 96
    :goto_0
    new-array v7, v1, [B

    const-wide/16 v1, 0x0

    move-object v8, p0

    .line 100
    :goto_1
    :try_start_0
    invoke-virtual {p0, v7}, Ljava/io/InputStream;->read([B)I

    move-result v4

    const/4 v3, -0x1

    if-eq v4, v3, :cond_6

    if-nez v4, :cond_3

    .line 107
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    move-result v3

    if-gez v3, :cond_1

    goto :goto_3

    .line 111
    :cond_1
    invoke-virtual {p1, v3}, Ljava/io/OutputStream;->write(I)V

    if-eqz p6, :cond_2

    .line 113
    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    :cond_2
    const-wide/16 v3, 0x1

    add-long v9, v1, v3

    if-eqz p5, :cond_5

    const/4 v4, 0x1

    move-object/from16 v1, p5

    move-wide v2, v9

    move-wide v5, p3

    .line 117
    :try_start_1
    invoke-interface/range {v1 .. v6}, Lorg/apache/commons/net/io/CopyStreamListener;->bytesTransferred(JIJ)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :cond_3
    const/4 v3, 0x0

    .line 122
    :try_start_2
    invoke-virtual {p1, v7, v3, v4}, Ljava/io/OutputStream;->write([BII)V

    if-eqz p6, :cond_4

    .line 124
    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    :cond_4
    int-to-long v5, v4

    add-long v9, v1, v5

    if-eqz p5, :cond_5

    move-object/from16 v1, p5

    move-wide v2, v9

    move-wide v5, p3

    .line 128
    :try_start_3
    invoke-interface/range {v1 .. v6}, Lorg/apache/commons/net/io/CopyStreamListener;->bytesTransferred(JIJ)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    move-wide v1, v9

    goto :goto_4

    :cond_5
    :goto_2
    move-wide v1, v9

    goto :goto_1

    :cond_6
    :goto_3
    return-wide v1

    :catch_1
    move-exception v0

    .line 134
    :goto_4
    new-instance v3, Lorg/apache/commons/net/io/CopyStreamException;

    const-string v4, "IOException caught while copying."

    invoke-direct {v3, v4, v1, v2, v0}, Lorg/apache/commons/net/io/CopyStreamException;-><init>(Ljava/lang/String;JLjava/io/IOException;)V

    goto :goto_6

    :goto_5
    throw v3

    :goto_6
    goto :goto_5
.end method

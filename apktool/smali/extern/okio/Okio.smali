.class public final Lextern/okio/Okio;
.super Ljava/lang/Object;
.source "Okio.java"


# static fields
.field static final logger:Ljava/util/logging/Logger;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 38
    const-class v0, Lextern/okio/Okio;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lextern/okio/Okio;->logger:Ljava/util/logging/Logger;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static appendingSink(Ljava/io/File;)Lextern/okio/Sink;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/FileNotFoundException;
        }
    .end annotation

    if-eqz p0, :cond_0

    .line 185
    new-instance v0, Ljava/io/FileOutputStream;

    const/4 v1, 0x1

    invoke-direct {v0, p0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V

    invoke-static {v0}, Lextern/okio/Okio;->sink(Ljava/io/OutputStream;)Lextern/okio/Sink;

    move-result-object p0

    return-object p0

    .line 184
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "file == null"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static blackhole()Lextern/okio/Sink;
    .locals 1

    .line 197
    new-instance v0, Lextern/okio/Okio$3;

    invoke-direct {v0}, Lextern/okio/Okio$3;-><init>()V

    return-object v0
.end method

.method public static buffer(Lextern/okio/Sink;)Lextern/okio/BufferedSink;
    .locals 1

    .line 58
    new-instance v0, Lextern/okio/RealBufferedSink;

    invoke-direct {v0, p0}, Lextern/okio/RealBufferedSink;-><init>(Lextern/okio/Sink;)V

    return-object v0
.end method

.method public static buffer(Lextern/okio/Source;)Lextern/okio/BufferedSource;
    .locals 1

    .line 49
    new-instance v0, Lextern/okio/RealBufferedSource;

    invoke-direct {v0, p0}, Lextern/okio/RealBufferedSource;-><init>(Lextern/okio/Source;)V

    return-object v0
.end method

.method static isAndroidGetsocknameError(Ljava/lang/AssertionError;)Z
    .locals 1

    .line 260
    invoke-virtual {p0}, Ljava/lang/AssertionError;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/AssertionError;->getMessage()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 261
    invoke-virtual {p0}, Ljava/lang/AssertionError;->getMessage()Ljava/lang/String;

    move-result-object p0

    const-string v0, "getsockname failed"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public static sink(Ljava/io/File;)Lextern/okio/Sink;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/FileNotFoundException;
        }
    .end annotation

    if-eqz p0, :cond_0

    .line 179
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-static {v0}, Lextern/okio/Okio;->sink(Ljava/io/OutputStream;)Lextern/okio/Sink;

    move-result-object p0

    return-object p0

    .line 178
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "file == null"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static sink(Ljava/io/OutputStream;)Lextern/okio/Sink;
    .locals 1

    .line 63
    new-instance v0, Lextern/okio/Timeout;

    invoke-direct {v0}, Lextern/okio/Timeout;-><init>()V

    invoke-static {p0, v0}, Lextern/okio/Okio;->sink(Ljava/io/OutputStream;Lextern/okio/Timeout;)Lextern/okio/Sink;

    move-result-object p0

    return-object p0
.end method

.method private static sink(Ljava/io/OutputStream;Lextern/okio/Timeout;)Lextern/okio/Sink;
    .locals 1

    if-eqz p0, :cond_1

    if-eqz p1, :cond_0

    .line 70
    new-instance v0, Lextern/okio/Okio$1;

    invoke-direct {v0, p1, p0}, Lextern/okio/Okio$1;-><init>(Lextern/okio/Timeout;Ljava/io/OutputStream;)V

    return-object v0

    .line 68
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "timeout == null"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 67
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "out == null"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static sink(Ljava/net/Socket;)Lextern/okio/Sink;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    if-eqz p0, :cond_1

    .line 115
    invoke-virtual {p0}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 116
    invoke-static {p0}, Lextern/okio/Okio;->timeout(Ljava/net/Socket;)Lextern/okio/AsyncTimeout;

    move-result-object v0

    .line 117
    invoke-virtual {p0}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object p0

    invoke-static {p0, v0}, Lextern/okio/Okio;->sink(Ljava/io/OutputStream;Lextern/okio/Timeout;)Lextern/okio/Sink;

    move-result-object p0

    .line 118
    invoke-virtual {v0, p0}, Lextern/okio/AsyncTimeout;->sink(Lextern/okio/Sink;)Lextern/okio/Sink;

    move-result-object p0

    return-object p0

    .line 115
    :cond_0
    new-instance p0, Ljava/io/IOException;

    const-string v0, "socket\'s output stream == null"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 114
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "socket == null"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static varargs sink(Ljava/nio/file/Path;[Ljava/nio/file/OpenOption;)Lextern/okio/Sink;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .annotation build Lorg/codehaus/mojo/animal_sniffer/IgnoreJRERequirement;
    .end annotation

    if-eqz p0, :cond_0

    .line 192
    invoke-static {p0, p1}, Ljava/nio/file/Files;->newOutputStream(Ljava/nio/file/Path;[Ljava/nio/file/OpenOption;)Ljava/io/OutputStream;

    move-result-object p0

    invoke-static {p0}, Lextern/okio/Okio;->sink(Ljava/io/OutputStream;)Lextern/okio/Sink;

    move-result-object p0

    return-object p0

    .line 191
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "path == null"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static source(Ljava/io/File;)Lextern/okio/Source;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/FileNotFoundException;
        }
    .end annotation

    if-eqz p0, :cond_0

    .line 166
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-static {v0}, Lextern/okio/Okio;->source(Ljava/io/InputStream;)Lextern/okio/Source;

    move-result-object p0

    return-object p0

    .line 165
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "file == null"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static source(Ljava/io/InputStream;)Lextern/okio/Source;
    .locals 1

    .line 123
    new-instance v0, Lextern/okio/Timeout;

    invoke-direct {v0}, Lextern/okio/Timeout;-><init>()V

    invoke-static {p0, v0}, Lextern/okio/Okio;->source(Ljava/io/InputStream;Lextern/okio/Timeout;)Lextern/okio/Source;

    move-result-object p0

    return-object p0
.end method

.method private static source(Ljava/io/InputStream;Lextern/okio/Timeout;)Lextern/okio/Source;
    .locals 1

    if-eqz p0, :cond_1

    if-eqz p1, :cond_0

    .line 130
    new-instance v0, Lextern/okio/Okio$2;

    invoke-direct {v0, p1, p0}, Lextern/okio/Okio$2;-><init>(Lextern/okio/Timeout;Ljava/io/InputStream;)V

    return-object v0

    .line 128
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "timeout == null"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 127
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "in == null"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static source(Ljava/net/Socket;)Lextern/okio/Source;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    if-eqz p0, :cond_1

    .line 221
    invoke-virtual {p0}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 222
    invoke-static {p0}, Lextern/okio/Okio;->timeout(Ljava/net/Socket;)Lextern/okio/AsyncTimeout;

    move-result-object v0

    .line 223
    invoke-virtual {p0}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object p0

    invoke-static {p0, v0}, Lextern/okio/Okio;->source(Ljava/io/InputStream;Lextern/okio/Timeout;)Lextern/okio/Source;

    move-result-object p0

    .line 224
    invoke-virtual {v0, p0}, Lextern/okio/AsyncTimeout;->source(Lextern/okio/Source;)Lextern/okio/Source;

    move-result-object p0

    return-object p0

    .line 221
    :cond_0
    new-instance p0, Ljava/io/IOException;

    const-string v0, "socket\'s input stream == null"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 220
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "socket == null"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static varargs source(Ljava/nio/file/Path;[Ljava/nio/file/OpenOption;)Lextern/okio/Source;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .annotation build Lorg/codehaus/mojo/animal_sniffer/IgnoreJRERequirement;
    .end annotation

    if-eqz p0, :cond_0

    .line 173
    invoke-static {p0, p1}, Ljava/nio/file/Files;->newInputStream(Ljava/nio/file/Path;[Ljava/nio/file/OpenOption;)Ljava/io/InputStream;

    move-result-object p0

    invoke-static {p0}, Lextern/okio/Okio;->source(Ljava/io/InputStream;)Lextern/okio/Source;

    move-result-object p0

    return-object p0

    .line 172
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "path == null"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static timeout(Ljava/net/Socket;)Lextern/okio/AsyncTimeout;
    .locals 1

    .line 228
    new-instance v0, Lextern/okio/Okio$4;

    invoke-direct {v0, p0}, Lextern/okio/Okio$4;-><init>(Ljava/net/Socket;)V

    return-object v0
.end method

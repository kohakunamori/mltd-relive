.class public abstract Lextern/okhttp3/internal/ws/RealWebSocket$Streams;
.super Ljava/lang/Object;
.source "RealWebSocket.java"

# interfaces
.implements Ljava/io/Closeable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lextern/okhttp3/internal/ws/RealWebSocket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Streams"
.end annotation


# instance fields
.field public final client:Z

.field public final sink:Lextern/okio/BufferedSink;

.field public final source:Lextern/okio/BufferedSource;


# direct methods
.method public constructor <init>(ZLextern/okio/BufferedSource;Lextern/okio/BufferedSink;)V
    .locals 0

    .line 600
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 601
    iput-boolean p1, p0, Lextern/okhttp3/internal/ws/RealWebSocket$Streams;->client:Z

    .line 602
    iput-object p2, p0, Lextern/okhttp3/internal/ws/RealWebSocket$Streams;->source:Lextern/okio/BufferedSource;

    .line 603
    iput-object p3, p0, Lextern/okhttp3/internal/ws/RealWebSocket$Streams;->sink:Lextern/okio/BufferedSink;

    return-void
.end method

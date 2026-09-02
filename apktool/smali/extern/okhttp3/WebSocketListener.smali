.class public abstract Lextern/okhttp3/WebSocketListener;
.super Ljava/lang/Object;
.source "WebSocketListener.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed(Lextern/okhttp3/WebSocket;ILjava/lang/String;)V
    .locals 0

    return-void
.end method

.method public onClosing(Lextern/okhttp3/WebSocket;ILjava/lang/String;)V
    .locals 0

    return-void
.end method

.method public onFailure(Lextern/okhttp3/WebSocket;Ljava/lang/Throwable;Lextern/okhttp3/Response;)V
    .locals 0
    .param p3    # Lextern/okhttp3/Response;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    return-void
.end method

.method public onMessage(Lextern/okhttp3/WebSocket;Lextern/okio/ByteString;)V
    .locals 0

    return-void
.end method

.method public onMessage(Lextern/okhttp3/WebSocket;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public onOpen(Lextern/okhttp3/WebSocket;Lextern/okhttp3/Response;)V
    .locals 0

    return-void
.end method

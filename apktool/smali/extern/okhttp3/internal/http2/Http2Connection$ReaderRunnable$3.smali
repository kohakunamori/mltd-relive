.class Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable$3;
.super Lextern/okhttp3/internal/NamedRunnable;
.source "Http2Connection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable;->applyAndAckSettings(ZLextern/okhttp3/internal/http2/Settings;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable;


# direct methods
.method varargs constructor <init>(Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0

    .line 811
    iput-object p1, p0, Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable$3;->this$1:Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable;

    invoke-direct {p0, p2, p3}, Lextern/okhttp3/internal/NamedRunnable;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public execute()V
    .locals 2

    .line 813
    iget-object v0, p0, Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable$3;->this$1:Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable;

    iget-object v0, v0, Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable;->this$0:Lextern/okhttp3/internal/http2/Http2Connection;

    iget-object v0, v0, Lextern/okhttp3/internal/http2/Http2Connection;->listener:Lextern/okhttp3/internal/http2/Http2Connection$Listener;

    iget-object v1, p0, Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable$3;->this$1:Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable;

    iget-object v1, v1, Lextern/okhttp3/internal/http2/Http2Connection$ReaderRunnable;->this$0:Lextern/okhttp3/internal/http2/Http2Connection;

    invoke-virtual {v0, v1}, Lextern/okhttp3/internal/http2/Http2Connection$Listener;->onSettings(Lextern/okhttp3/internal/http2/Http2Connection;)V

    return-void
.end method

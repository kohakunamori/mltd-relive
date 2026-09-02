.class Lextern/okhttp3/internal/http2/Http2Connection$3;
.super Lextern/okhttp3/internal/NamedRunnable;
.source "Http2Connection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lextern/okhttp3/internal/http2/Http2Connection;->sendDegradedPingLater()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lextern/okhttp3/internal/http2/Http2Connection;


# direct methods
.method varargs constructor <init>(Lextern/okhttp3/internal/http2/Http2Connection;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0

    .line 597
    iput-object p1, p0, Lextern/okhttp3/internal/http2/Http2Connection$3;->this$0:Lextern/okhttp3/internal/http2/Http2Connection;

    invoke-direct {p0, p2, p3}, Lextern/okhttp3/internal/NamedRunnable;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public execute()V
    .locals 3

    .line 599
    iget-object v0, p0, Lextern/okhttp3/internal/http2/Http2Connection$3;->this$0:Lextern/okhttp3/internal/http2/Http2Connection;

    const/4 v1, 0x0

    const/4 v2, 0x2

    invoke-virtual {v0, v1, v2, v1}, Lextern/okhttp3/internal/http2/Http2Connection;->writePing(ZII)V

    return-void
.end method

.class Lextern/okhttp3/RealCall$1;
.super Lextern/okio/AsyncTimeout;
.source "RealCall.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lextern/okhttp3/RealCall;-><init>(Lextern/okhttp3/OkHttpClient;Lextern/okhttp3/Request;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lextern/okhttp3/RealCall;


# direct methods
.method constructor <init>(Lextern/okhttp3/RealCall;)V
    .locals 0

    .line 65
    iput-object p1, p0, Lextern/okhttp3/RealCall$1;->this$0:Lextern/okhttp3/RealCall;

    invoke-direct {p0}, Lextern/okio/AsyncTimeout;-><init>()V

    return-void
.end method


# virtual methods
.method protected timedOut()V
    .locals 1

    .line 67
    iget-object v0, p0, Lextern/okhttp3/RealCall$1;->this$0:Lextern/okhttp3/RealCall;

    invoke-virtual {v0}, Lextern/okhttp3/RealCall;->cancel()V

    return-void
.end method

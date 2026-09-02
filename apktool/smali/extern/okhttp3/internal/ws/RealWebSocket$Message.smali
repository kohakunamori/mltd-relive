.class final Lextern/okhttp3/internal/ws/RealWebSocket$Message;
.super Ljava/lang/Object;
.source "RealWebSocket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lextern/okhttp3/internal/ws/RealWebSocket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Message"
.end annotation


# instance fields
.field final data:Lextern/okio/ByteString;

.field final formatOpcode:I


# direct methods
.method constructor <init>(ILextern/okio/ByteString;)V
    .locals 0

    .line 577
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 578
    iput p1, p0, Lextern/okhttp3/internal/ws/RealWebSocket$Message;->formatOpcode:I

    .line 579
    iput-object p2, p0, Lextern/okhttp3/internal/ws/RealWebSocket$Message;->data:Lextern/okio/ByteString;

    return-void
.end method

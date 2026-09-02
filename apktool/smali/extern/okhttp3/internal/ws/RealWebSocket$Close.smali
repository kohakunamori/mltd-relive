.class final Lextern/okhttp3/internal/ws/RealWebSocket$Close;
.super Ljava/lang/Object;
.source "RealWebSocket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lextern/okhttp3/internal/ws/RealWebSocket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Close"
.end annotation


# instance fields
.field final cancelAfterCloseMillis:J

.field final code:I

.field final reason:Lextern/okio/ByteString;


# direct methods
.method constructor <init>(ILextern/okio/ByteString;J)V
    .locals 0

    .line 588
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 589
    iput p1, p0, Lextern/okhttp3/internal/ws/RealWebSocket$Close;->code:I

    .line 590
    iput-object p2, p0, Lextern/okhttp3/internal/ws/RealWebSocket$Close;->reason:Lextern/okio/ByteString;

    .line 591
    iput-wide p3, p0, Lextern/okhttp3/internal/ws/RealWebSocket$Close;->cancelAfterCloseMillis:J

    return-void
.end method

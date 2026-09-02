.class final Lextern/okhttp3/internal/http/CallServerInterceptor$CountingSink;
.super Lextern/okio/ForwardingSink;
.source "CallServerInterceptor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lextern/okhttp3/internal/http/CallServerInterceptor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "CountingSink"
.end annotation


# instance fields
.field successfulCount:J


# direct methods
.method constructor <init>(Lextern/okio/Sink;)V
    .locals 0

    .line 146
    invoke-direct {p0, p1}, Lextern/okio/ForwardingSink;-><init>(Lextern/okio/Sink;)V

    return-void
.end method


# virtual methods
.method public write(Lextern/okio/Buffer;J)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 150
    invoke-super {p0, p1, p2, p3}, Lextern/okio/ForwardingSink;->write(Lextern/okio/Buffer;J)V

    .line 151
    iget-wide v0, p0, Lextern/okhttp3/internal/http/CallServerInterceptor$CountingSink;->successfulCount:J

    add-long/2addr v0, p2

    iput-wide v0, p0, Lextern/okhttp3/internal/http/CallServerInterceptor$CountingSink;->successfulCount:J

    return-void
.end method

.class Lextern/okhttp3/ResponseBody$1;
.super Lextern/okhttp3/ResponseBody;
.source "ResponseBody.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lextern/okhttp3/ResponseBody;->create(Lextern/okhttp3/MediaType;JLextern/okio/BufferedSource;)Lextern/okhttp3/ResponseBody;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$content:Lextern/okio/BufferedSource;

.field final synthetic val$contentLength:J

.field final synthetic val$contentType:Lextern/okhttp3/MediaType;


# direct methods
.method constructor <init>(Lextern/okhttp3/MediaType;JLextern/okio/BufferedSource;)V
    .locals 0

    .line 223
    iput-object p1, p0, Lextern/okhttp3/ResponseBody$1;->val$contentType:Lextern/okhttp3/MediaType;

    iput-wide p2, p0, Lextern/okhttp3/ResponseBody$1;->val$contentLength:J

    iput-object p4, p0, Lextern/okhttp3/ResponseBody$1;->val$content:Lextern/okio/BufferedSource;

    invoke-direct {p0}, Lextern/okhttp3/ResponseBody;-><init>()V

    return-void
.end method


# virtual methods
.method public contentLength()J
    .locals 2

    .line 229
    iget-wide v0, p0, Lextern/okhttp3/ResponseBody$1;->val$contentLength:J

    return-wide v0
.end method

.method public contentType()Lextern/okhttp3/MediaType;
    .locals 1
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 225
    iget-object v0, p0, Lextern/okhttp3/ResponseBody$1;->val$contentType:Lextern/okhttp3/MediaType;

    return-object v0
.end method

.method public source()Lextern/okio/BufferedSource;
    .locals 1

    .line 233
    iget-object v0, p0, Lextern/okhttp3/ResponseBody$1;->val$content:Lextern/okio/BufferedSource;

    return-object v0
.end method

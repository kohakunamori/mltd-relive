.class public Lextern/okhttp3/Response$Builder;
.super Ljava/lang/Object;
.source "Response.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lextern/okhttp3/Response;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field body:Lextern/okhttp3/ResponseBody;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field cacheResponse:Lextern/okhttp3/Response;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field code:I

.field handshake:Lextern/okhttp3/Handshake;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field headers:Lextern/okhttp3/Headers$Builder;

.field message:Ljava/lang/String;

.field networkResponse:Lextern/okhttp3/Response;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field priorResponse:Lextern/okhttp3/Response;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field protocol:Lextern/okhttp3/Protocol;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field receivedResponseAtMillis:J

.field request:Lextern/okhttp3/Request;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field sentRequestAtMillis:J


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 317
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    .line 306
    iput v0, p0, Lextern/okhttp3/Response$Builder;->code:I

    .line 318
    new-instance v0, Lextern/okhttp3/Headers$Builder;

    invoke-direct {v0}, Lextern/okhttp3/Headers$Builder;-><init>()V

    iput-object v0, p0, Lextern/okhttp3/Response$Builder;->headers:Lextern/okhttp3/Headers$Builder;

    return-void
.end method

.method constructor <init>(Lextern/okhttp3/Response;)V
    .locals 2

    .line 321
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    .line 306
    iput v0, p0, Lextern/okhttp3/Response$Builder;->code:I

    .line 322
    iget-object v0, p1, Lextern/okhttp3/Response;->request:Lextern/okhttp3/Request;

    iput-object v0, p0, Lextern/okhttp3/Response$Builder;->request:Lextern/okhttp3/Request;

    .line 323
    iget-object v0, p1, Lextern/okhttp3/Response;->protocol:Lextern/okhttp3/Protocol;

    iput-object v0, p0, Lextern/okhttp3/Response$Builder;->protocol:Lextern/okhttp3/Protocol;

    .line 324
    iget v0, p1, Lextern/okhttp3/Response;->code:I

    iput v0, p0, Lextern/okhttp3/Response$Builder;->code:I

    .line 325
    iget-object v0, p1, Lextern/okhttp3/Response;->message:Ljava/lang/String;

    iput-object v0, p0, Lextern/okhttp3/Response$Builder;->message:Ljava/lang/String;

    .line 326
    iget-object v0, p1, Lextern/okhttp3/Response;->handshake:Lextern/okhttp3/Handshake;

    iput-object v0, p0, Lextern/okhttp3/Response$Builder;->handshake:Lextern/okhttp3/Handshake;

    .line 327
    iget-object v0, p1, Lextern/okhttp3/Response;->headers:Lextern/okhttp3/Headers;

    invoke-virtual {v0}, Lextern/okhttp3/Headers;->newBuilder()Lextern/okhttp3/Headers$Builder;

    move-result-object v0

    iput-object v0, p0, Lextern/okhttp3/Response$Builder;->headers:Lextern/okhttp3/Headers$Builder;

    .line 328
    iget-object v0, p1, Lextern/okhttp3/Response;->body:Lextern/okhttp3/ResponseBody;

    iput-object v0, p0, Lextern/okhttp3/Response$Builder;->body:Lextern/okhttp3/ResponseBody;

    .line 329
    iget-object v0, p1, Lextern/okhttp3/Response;->networkResponse:Lextern/okhttp3/Response;

    iput-object v0, p0, Lextern/okhttp3/Response$Builder;->networkResponse:Lextern/okhttp3/Response;

    .line 330
    iget-object v0, p1, Lextern/okhttp3/Response;->cacheResponse:Lextern/okhttp3/Response;

    iput-object v0, p0, Lextern/okhttp3/Response$Builder;->cacheResponse:Lextern/okhttp3/Response;

    .line 331
    iget-object v0, p1, Lextern/okhttp3/Response;->priorResponse:Lextern/okhttp3/Response;

    iput-object v0, p0, Lextern/okhttp3/Response$Builder;->priorResponse:Lextern/okhttp3/Response;

    .line 332
    iget-wide v0, p1, Lextern/okhttp3/Response;->sentRequestAtMillis:J

    iput-wide v0, p0, Lextern/okhttp3/Response$Builder;->sentRequestAtMillis:J

    .line 333
    iget-wide v0, p1, Lextern/okhttp3/Response;->receivedResponseAtMillis:J

    iput-wide v0, p0, Lextern/okhttp3/Response$Builder;->receivedResponseAtMillis:J

    return-void
.end method

.method private checkPriorResponse(Lextern/okhttp3/Response;)V
    .locals 1

    .line 426
    iget-object p1, p1, Lextern/okhttp3/Response;->body:Lextern/okhttp3/ResponseBody;

    if-nez p1, :cond_0

    return-void

    .line 427
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "priorResponse.body != null"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method private checkSupportResponse(Ljava/lang/String;Lextern/okhttp3/Response;)V
    .locals 1

    .line 408
    iget-object v0, p2, Lextern/okhttp3/Response;->body:Lextern/okhttp3/ResponseBody;

    if-nez v0, :cond_3

    .line 410
    iget-object v0, p2, Lextern/okhttp3/Response;->networkResponse:Lextern/okhttp3/Response;

    if-nez v0, :cond_2

    .line 412
    iget-object v0, p2, Lextern/okhttp3/Response;->cacheResponse:Lextern/okhttp3/Response;

    if-nez v0, :cond_1

    .line 414
    iget-object p2, p2, Lextern/okhttp3/Response;->priorResponse:Lextern/okhttp3/Response;

    if-nez p2, :cond_0

    return-void

    .line 415
    :cond_0
    new-instance p2, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ".priorResponse != null"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p2

    .line 413
    :cond_1
    new-instance p2, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ".cacheResponse != null"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p2

    .line 411
    :cond_2
    new-instance p2, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ".networkResponse != null"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p2

    .line 409
    :cond_3
    new-instance p2, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ".body != null"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p2
.end method


# virtual methods
.method public addHeader(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Response$Builder;
    .locals 1

    .line 375
    iget-object v0, p0, Lextern/okhttp3/Response$Builder;->headers:Lextern/okhttp3/Headers$Builder;

    invoke-virtual {v0, p1, p2}, Lextern/okhttp3/Headers$Builder;->add(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Headers$Builder;

    return-object p0
.end method

.method public body(Lextern/okhttp3/ResponseBody;)Lextern/okhttp3/Response$Builder;
    .locals 0
    .param p1    # Lextern/okhttp3/ResponseBody;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 391
    iput-object p1, p0, Lextern/okhttp3/Response$Builder;->body:Lextern/okhttp3/ResponseBody;

    return-object p0
.end method

.method public build()Lextern/okhttp3/Response;
    .locals 3

    .line 442
    iget-object v0, p0, Lextern/okhttp3/Response$Builder;->request:Lextern/okhttp3/Request;

    if-eqz v0, :cond_3

    .line 443
    iget-object v0, p0, Lextern/okhttp3/Response$Builder;->protocol:Lextern/okhttp3/Protocol;

    if-eqz v0, :cond_2

    .line 444
    iget v0, p0, Lextern/okhttp3/Response$Builder;->code:I

    if-ltz v0, :cond_1

    .line 445
    iget-object v0, p0, Lextern/okhttp3/Response$Builder;->message:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 446
    new-instance v0, Lextern/okhttp3/Response;

    invoke-direct {v0, p0}, Lextern/okhttp3/Response;-><init>(Lextern/okhttp3/Response$Builder;)V

    return-object v0

    .line 445
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "message == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 444
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "code < 0: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p0, Lextern/okhttp3/Response$Builder;->code:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 443
    :cond_2
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "protocol == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 442
    :cond_3
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "request == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public cacheResponse(Lextern/okhttp3/Response;)Lextern/okhttp3/Response$Builder;
    .locals 1
    .param p1    # Lextern/okhttp3/Response;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    if-eqz p1, :cond_0

    const-string v0, "cacheResponse"

    .line 402
    invoke-direct {p0, v0, p1}, Lextern/okhttp3/Response$Builder;->checkSupportResponse(Ljava/lang/String;Lextern/okhttp3/Response;)V

    .line 403
    :cond_0
    iput-object p1, p0, Lextern/okhttp3/Response$Builder;->cacheResponse:Lextern/okhttp3/Response;

    return-object p0
.end method

.method public code(I)Lextern/okhttp3/Response$Builder;
    .locals 0

    .line 347
    iput p1, p0, Lextern/okhttp3/Response$Builder;->code:I

    return-object p0
.end method

.method public handshake(Lextern/okhttp3/Handshake;)Lextern/okhttp3/Response$Builder;
    .locals 0
    .param p1    # Lextern/okhttp3/Handshake;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 357
    iput-object p1, p0, Lextern/okhttp3/Response$Builder;->handshake:Lextern/okhttp3/Handshake;

    return-object p0
.end method

.method public header(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Response$Builder;
    .locals 1

    .line 366
    iget-object v0, p0, Lextern/okhttp3/Response$Builder;->headers:Lextern/okhttp3/Headers$Builder;

    invoke-virtual {v0, p1, p2}, Lextern/okhttp3/Headers$Builder;->set(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Headers$Builder;

    return-object p0
.end method

.method public headers(Lextern/okhttp3/Headers;)Lextern/okhttp3/Response$Builder;
    .locals 0

    .line 386
    invoke-virtual {p1}, Lextern/okhttp3/Headers;->newBuilder()Lextern/okhttp3/Headers$Builder;

    move-result-object p1

    iput-object p1, p0, Lextern/okhttp3/Response$Builder;->headers:Lextern/okhttp3/Headers$Builder;

    return-object p0
.end method

.method public message(Ljava/lang/String;)Lextern/okhttp3/Response$Builder;
    .locals 0

    .line 352
    iput-object p1, p0, Lextern/okhttp3/Response$Builder;->message:Ljava/lang/String;

    return-object p0
.end method

.method public networkResponse(Lextern/okhttp3/Response;)Lextern/okhttp3/Response$Builder;
    .locals 1
    .param p1    # Lextern/okhttp3/Response;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    if-eqz p1, :cond_0

    const-string v0, "networkResponse"

    .line 396
    invoke-direct {p0, v0, p1}, Lextern/okhttp3/Response$Builder;->checkSupportResponse(Ljava/lang/String;Lextern/okhttp3/Response;)V

    .line 397
    :cond_0
    iput-object p1, p0, Lextern/okhttp3/Response$Builder;->networkResponse:Lextern/okhttp3/Response;

    return-object p0
.end method

.method public priorResponse(Lextern/okhttp3/Response;)Lextern/okhttp3/Response$Builder;
    .locals 0
    .param p1    # Lextern/okhttp3/Response;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    if-eqz p1, :cond_0

    .line 420
    invoke-direct {p0, p1}, Lextern/okhttp3/Response$Builder;->checkPriorResponse(Lextern/okhttp3/Response;)V

    .line 421
    :cond_0
    iput-object p1, p0, Lextern/okhttp3/Response$Builder;->priorResponse:Lextern/okhttp3/Response;

    return-object p0
.end method

.method public protocol(Lextern/okhttp3/Protocol;)Lextern/okhttp3/Response$Builder;
    .locals 0

    .line 342
    iput-object p1, p0, Lextern/okhttp3/Response$Builder;->protocol:Lextern/okhttp3/Protocol;

    return-object p0
.end method

.method public receivedResponseAtMillis(J)Lextern/okhttp3/Response$Builder;
    .locals 0

    .line 437
    iput-wide p1, p0, Lextern/okhttp3/Response$Builder;->receivedResponseAtMillis:J

    return-object p0
.end method

.method public removeHeader(Ljava/lang/String;)Lextern/okhttp3/Response$Builder;
    .locals 1

    .line 380
    iget-object v0, p0, Lextern/okhttp3/Response$Builder;->headers:Lextern/okhttp3/Headers$Builder;

    invoke-virtual {v0, p1}, Lextern/okhttp3/Headers$Builder;->removeAll(Ljava/lang/String;)Lextern/okhttp3/Headers$Builder;

    return-object p0
.end method

.method public request(Lextern/okhttp3/Request;)Lextern/okhttp3/Response$Builder;
    .locals 0

    .line 337
    iput-object p1, p0, Lextern/okhttp3/Response$Builder;->request:Lextern/okhttp3/Request;

    return-object p0
.end method

.method public sentRequestAtMillis(J)Lextern/okhttp3/Response$Builder;
    .locals 0

    .line 432
    iput-wide p1, p0, Lextern/okhttp3/Response$Builder;->sentRequestAtMillis:J

    return-object p0
.end method

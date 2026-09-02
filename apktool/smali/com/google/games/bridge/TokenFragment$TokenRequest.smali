.class Lcom/google/games/bridge/TokenFragment$TokenRequest;
.super Ljava/lang/Object;
.source "TokenFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/games/bridge/TokenFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "TokenRequest"
.end annotation


# instance fields
.field private accountName:Ljava/lang/String;

.field private doAuthCode:Z

.field private doEmail:Z

.field private doIdToken:Z

.field private forceRefresh:Z

.field private hidePopups:Z

.field private pendingResponse:Lcom/google/games/bridge/TokenPendingResult;

.field private scopes:[Lcom/google/android/gms/common/api/Scope;

.field private silent:Z

.field private webClientId:Ljava/lang/String;


# direct methods
.method public constructor <init>(ZZZZLjava/lang/String;Z[Ljava/lang/String;ZLjava/lang/String;)V
    .locals 1

    .line 421
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 422
    new-instance v0, Lcom/google/games/bridge/TokenPendingResult;

    invoke-direct {v0}, Lcom/google/games/bridge/TokenPendingResult;-><init>()V

    iput-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->pendingResponse:Lcom/google/games/bridge/TokenPendingResult;

    .line 423
    iput-boolean p1, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->silent:Z

    .line 424
    iput-boolean p2, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->doAuthCode:Z

    .line 425
    iput-boolean p3, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->doEmail:Z

    .line 426
    iput-boolean p4, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->doIdToken:Z

    .line 427
    iput-object p5, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->webClientId:Ljava/lang/String;

    .line 428
    iput-boolean p6, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->forceRefresh:Z

    if-eqz p7, :cond_0

    .line 429
    array-length p1, p7

    if-lez p1, :cond_0

    .line 430
    array-length p1, p7

    new-array p1, p1, [Lcom/google/android/gms/common/api/Scope;

    iput-object p1, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->scopes:[Lcom/google/android/gms/common/api/Scope;

    const/4 p1, 0x0

    .line 431
    :goto_0
    array-length p2, p7

    if-ge p1, p2, :cond_1

    .line 432
    iget-object p2, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->scopes:[Lcom/google/android/gms/common/api/Scope;

    new-instance p3, Lcom/google/android/gms/common/api/Scope;

    aget-object p4, p7, p1

    invoke-direct {p3, p4}, Lcom/google/android/gms/common/api/Scope;-><init>(Ljava/lang/String;)V

    aput-object p3, p2, p1

    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    .line 435
    iput-object p1, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->scopes:[Lcom/google/android/gms/common/api/Scope;

    .line 437
    :cond_1
    iput-boolean p8, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->hidePopups:Z

    .line 438
    iput-object p9, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->accountName:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000(Lcom/google/games/bridge/TokenFragment$TokenRequest;)[Lcom/google/android/gms/common/api/Scope;
    .locals 0

    .line 406
    iget-object p0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->scopes:[Lcom/google/android/gms/common/api/Scope;

    return-object p0
.end method

.method static synthetic access$300(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Z
    .locals 0

    .line 406
    iget-boolean p0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->doAuthCode:Z

    return p0
.end method

.method static synthetic access$400(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Z
    .locals 0

    .line 406
    iget-boolean p0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->doEmail:Z

    return p0
.end method

.method static synthetic access$500(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Z
    .locals 0

    .line 406
    iget-boolean p0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->doIdToken:Z

    return p0
.end method

.method static synthetic access$600(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Z
    .locals 0

    .line 406
    iget-boolean p0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->hidePopups:Z

    return p0
.end method

.method static synthetic access$700(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Ljava/lang/String;
    .locals 0

    .line 406
    iget-object p0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->accountName:Ljava/lang/String;

    return-object p0
.end method


# virtual methods
.method public canReuseAccount()Z
    .locals 1

    .line 442
    iget-boolean v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->doAuthCode:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->doIdToken:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public cancel()V
    .locals 1

    .line 461
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->pendingResponse:Lcom/google/games/bridge/TokenPendingResult;

    invoke-virtual {v0}, Lcom/google/games/bridge/TokenPendingResult;->cancel()V

    return-void
.end method

.method public getAuthCode()Ljava/lang/String;
    .locals 1

    .line 481
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->pendingResponse:Lcom/google/games/bridge/TokenPendingResult;

    iget-object v0, v0, Lcom/google/games/bridge/TokenPendingResult;->result:Lcom/google/games/bridge/TokenResult;

    invoke-virtual {v0}, Lcom/google/games/bridge/TokenResult;->getAuthCode()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getEmail()Ljava/lang/String;
    .locals 1

    .line 473
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->pendingResponse:Lcom/google/games/bridge/TokenPendingResult;

    iget-object v0, v0, Lcom/google/games/bridge/TokenPendingResult;->result:Lcom/google/games/bridge/TokenResult;

    invoke-virtual {v0}, Lcom/google/games/bridge/TokenResult;->getEmail()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getForceRefresh()Z
    .locals 1

    .line 496
    iget-boolean v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->forceRefresh:Z

    return v0
.end method

.method public getIdToken()Ljava/lang/String;
    .locals 1

    .line 477
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->pendingResponse:Lcom/google/games/bridge/TokenPendingResult;

    iget-object v0, v0, Lcom/google/games/bridge/TokenPendingResult;->result:Lcom/google/games/bridge/TokenResult;

    invoke-virtual {v0}, Lcom/google/games/bridge/TokenResult;->getIdToken()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getPendingResponse()Lcom/google/android/gms/common/api/PendingResult;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/android/gms/common/api/PendingResult<",
            "Lcom/google/games/bridge/TokenResult;",
            ">;"
        }
    .end annotation

    .line 446
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->pendingResponse:Lcom/google/games/bridge/TokenPendingResult;

    return-object v0
.end method

.method public getSilent()Z
    .locals 1

    .line 449
    iget-boolean v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->silent:Z

    return v0
.end method

.method public getWebClientId()Ljava/lang/String;
    .locals 1

    .line 492
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->webClientId:Ljava/lang/String;

    if-nez v0, :cond_0

    const-string v0, ""

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->webClientId:Ljava/lang/String;

    :goto_0
    return-object v0
.end method

.method public setAuthCode(Ljava/lang/String;)V
    .locals 1

    .line 465
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->pendingResponse:Lcom/google/games/bridge/TokenPendingResult;

    invoke-virtual {v0, p1}, Lcom/google/games/bridge/TokenPendingResult;->setAuthCode(Ljava/lang/String;)V

    return-void
.end method

.method public setEmail(Ljava/lang/String;)V
    .locals 1

    .line 457
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->pendingResponse:Lcom/google/games/bridge/TokenPendingResult;

    invoke-virtual {v0, p1}, Lcom/google/games/bridge/TokenPendingResult;->setEmail(Ljava/lang/String;)V

    return-void
.end method

.method public setIdToken(Ljava/lang/String;)V
    .locals 1

    .line 469
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->pendingResponse:Lcom/google/games/bridge/TokenPendingResult;

    invoke-virtual {v0, p1}, Lcom/google/games/bridge/TokenPendingResult;->setIdToken(Ljava/lang/String;)V

    return-void
.end method

.method public setResult(I)V
    .locals 1

    .line 453
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->pendingResponse:Lcom/google/games/bridge/TokenPendingResult;

    invoke-virtual {v0, p1}, Lcom/google/games/bridge/TokenPendingResult;->setStatus(I)V

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 486
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->hashCode()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " (a:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->doAuthCode:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, " e:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->doEmail:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, " i:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->doIdToken:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, " wc: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->webClientId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " f: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v1, p0, Lcom/google/games/bridge/TokenFragment$TokenRequest;->forceRefresh:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

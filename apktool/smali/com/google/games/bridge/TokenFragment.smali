.class public Lcom/google/games/bridge/TokenFragment;
.super Landroid/app/Fragment;
.source "TokenFragment.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/games/bridge/TokenFragment$TokenRequest;
    }
.end annotation


# static fields
.field private static final FRAGMENT_TAG:Ljava/lang/String; = "gpg.AuthTokenSupport"

.field private static final RC_ACCT:I = 0x232a

.field private static final TAG:Ljava/lang/String; = "TokenFragment"

.field private static helperFragment:Lcom/google/games/bridge/TokenFragment;

.field private static final lock:Ljava/lang/Object;

.field private static mStartUpSignInCheckPerformed:Z

.field private static pendingTokenRequest:Lcom/google/games/bridge/TokenFragment$TokenRequest;


# instance fields
.field private mGoogleSignInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 58
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/google/games/bridge/TokenFragment;->lock:Ljava/lang/Object;

    const/4 v0, 0x0

    .line 63
    sput-boolean v0, Lcom/google/games/bridge/TokenFragment;->mStartUpSignInCheckPerformed:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 49
    invoke-direct {p0}, Landroid/app/Fragment;-><init>()V

    return-void
.end method

.method static synthetic access$100(Lcom/google/games/bridge/TokenFragment;ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V
    .locals 0

    .line 49
    invoke-direct {p0, p1, p2}, Lcom/google/games/bridge/TokenFragment;->onSignedIn(ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V

    return-void
.end method

.method static synthetic access$200(Lcom/google/games/bridge/TokenFragment;)V
    .locals 0

    .line 49
    invoke-direct {p0}, Lcom/google/games/bridge/TokenFragment;->signIn()V

    return-void
.end method

.method private buildClient(Landroid/app/Activity;Lcom/google/games/bridge/TokenFragment$TokenRequest;)Z
    .locals 7

    const-string v0, "TokenFragment"

    .line 282
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Building client for: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 283
    new-instance v0, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;

    invoke-direct {v0}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;-><init>()V

    .line 284
    invoke-static {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->access$300(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Z

    move-result v1

    const/16 v2, 0xa

    const/4 v3, 0x0

    if-eqz v1, :cond_1

    .line 285
    invoke-virtual {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->getWebClientId()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->getWebClientId()Ljava/lang/String;

    move-result-object v1

    const-string v4, "__WEB_CLIENTID__"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 286
    invoke-virtual {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->getWebClientId()Ljava/lang/String;

    move-result-object v1

    .line 287
    invoke-virtual {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->getForceRefresh()Z

    move-result v4

    .line 286
    invoke-virtual {v0, v1, v4}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;->requestServerAuthCode(Ljava/lang/String;Z)Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;

    goto :goto_0

    :cond_0
    const-string p1, "TokenFragment"

    const-string v0, "Web client ID is needed for Auth Code"

    .line 289
    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 290
    invoke-virtual {p2, v2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->setResult(I)V

    return v3

    .line 295
    :cond_1
    :goto_0
    invoke-static {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->access$400(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 296
    invoke-virtual {v0}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;->requestEmail()Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;

    .line 299
    :cond_2
    invoke-static {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->access$500(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 300
    invoke-virtual {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->getWebClientId()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_3

    invoke-virtual {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->getWebClientId()Ljava/lang/String;

    move-result-object v1

    const-string v4, "__WEB_CLIENTID__"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 301
    invoke-virtual {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->getWebClientId()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;->requestIdToken(Ljava/lang/String;)Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;

    goto :goto_1

    :cond_3
    const-string p1, "TokenFragment"

    const-string v0, "Web client ID is needed for ID Token"

    .line 303
    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 304
    invoke-virtual {p2, v2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->setResult(I)V

    return v3

    .line 308
    :cond_4
    :goto_1
    invoke-static {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->access$000(Lcom/google/games/bridge/TokenFragment$TokenRequest;)[Lcom/google/android/gms/common/api/Scope;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 309
    invoke-static {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->access$000(Lcom/google/games/bridge/TokenFragment$TokenRequest;)[Lcom/google/android/gms/common/api/Scope;

    move-result-object v1

    array-length v2, v1

    const/4 v4, 0x0

    :goto_2
    if-ge v4, v2, :cond_5

    aget-object v5, v1, v4

    .line 310
    new-array v6, v3, [Lcom/google/android/gms/common/api/Scope;

    invoke-virtual {v0, v5, v6}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;->requestScopes(Lcom/google/android/gms/common/api/Scope;[Lcom/google/android/gms/common/api/Scope;)Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;

    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 314
    :cond_5
    invoke-static {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->access$600(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Z

    move-result v1

    if-eqz v1, :cond_6

    const-string v1, "TokenFragment"

    const-string v2, "hiding popup views for games API"

    .line 315
    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 317
    invoke-static {}, Lcom/google/android/gms/games/Games$GamesOptions;->builder()Lcom/google/android/gms/games/Games$GamesOptions$Builder;

    move-result-object v1

    invoke-virtual {v1, v3}, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->setShowConnectingPopup(Z)Lcom/google/android/gms/games/Games$GamesOptions$Builder;

    move-result-object v1

    .line 318
    invoke-virtual {v1}, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->build()Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object v1

    .line 316
    invoke-virtual {v0, v1}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;->addExtension(Lcom/google/android/gms/auth/api/signin/GoogleSignInOptionsExtension;)Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;

    .line 321
    :cond_6
    invoke-static {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->access$700(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_7

    invoke-static {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->access$700(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_7

    .line 322
    invoke-static {p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->access$700(Lcom/google/games/bridge/TokenFragment$TokenRequest;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;->setAccountName(Ljava/lang/String;)Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;

    .line 325
    :cond_7
    invoke-virtual {v0}, Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions$Builder;->build()Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions;

    move-result-object p2

    .line 326
    invoke-static {p1, p2}, Lcom/google/android/gms/auth/api/signin/GoogleSignIn;->getClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInOptions;)Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    move-result-object p1

    iput-object p1, p0, Lcom/google/games/bridge/TokenFragment;->mGoogleSignInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    const/4 p1, 0x1

    return p1
.end method

.method public static checkGooglePlayServicesAvailable()Z
    .locals 1

    const/4 v0, 0x0

    .line 501
    invoke-static {v0}, Lcom/google/android/gms/common/GooglePlayServicesUtil;->isGooglePlayServicesAvailable(Landroid/content/Context;)I

    const/4 v0, 0x0

    return v0
.end method

.method public static createInvisibleView(Landroid/app/Activity;)Landroid/view/View;
    .locals 1

    .line 506
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    const/4 p0, 0x4

    .line 507
    invoke-virtual {v0, p0}, Landroid/view/View;->setVisibility(I)V

    const/4 p0, 0x0

    .line 508
    invoke-virtual {v0, p0}, Landroid/view/View;->setClickable(Z)V

    return-object v0
.end method

.method public static fetchToken(Landroid/app/Activity;ZZZZLjava/lang/String;Z[Ljava/lang/String;ZLjava/lang/String;)Lcom/google/android/gms/common/api/PendingResult;
    .locals 12

    .line 106
    new-instance v11, Lcom/google/games/bridge/TokenFragment$TokenRequest;

    move-object v1, v11

    move v2, p1

    move v3, p2

    move v4, p3

    move/from16 v5, p4

    move-object/from16 v6, p5

    move/from16 v7, p6

    move-object/from16 v8, p7

    move/from16 v9, p8

    move-object/from16 v10, p9

    invoke-direct/range {v1 .. v10}, Lcom/google/games/bridge/TokenFragment$TokenRequest;-><init>(ZZZZLjava/lang/String;Z[Ljava/lang/String;ZLjava/lang/String;)V

    .line 111
    sget-object v1, Lcom/google/games/bridge/TokenFragment;->lock:Ljava/lang/Object;

    monitor-enter v1

    .line 112
    :try_start_0
    sget-object v0, Lcom/google/games/bridge/TokenFragment;->pendingTokenRequest:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    if-nez v0, :cond_0

    .line 113
    sput-object v11, Lcom/google/games/bridge/TokenFragment;->pendingTokenRequest:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 116
    :goto_0
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez v0, :cond_1

    const-string v0, "TokenFragment"

    .line 118
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Already a pending token request (requested == ): "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "TokenFragment"

    .line 119
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Already a pending token request: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v2, Lcom/google/games/bridge/TokenFragment;->pendingTokenRequest:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v0, 0xa

    .line 120
    invoke-virtual {v11, v0}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->setResult(I)V

    .line 121
    invoke-virtual {v11}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->getPendingResponse()Lcom/google/android/gms/common/api/PendingResult;

    move-result-object v0

    return-object v0

    .line 126
    :cond_1
    invoke-virtual {p0}, Landroid/app/Activity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v0

    const-string v1, "gpg.AuthTokenSupport"

    invoke-virtual {v0, v1}, Landroid/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroid/app/Fragment;

    move-result-object v0

    check-cast v0, Lcom/google/games/bridge/TokenFragment;

    if-nez v0, :cond_2

    :try_start_1
    const-string v0, "TokenFragment"

    const-string v1, "Creating fragment"

    .line 130
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 131
    new-instance v0, Lcom/google/games/bridge/TokenFragment;

    invoke-direct {v0}, Lcom/google/games/bridge/TokenFragment;-><init>()V

    .line 132
    invoke-virtual {p0}, Landroid/app/Activity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/FragmentManager;->beginTransaction()Landroid/app/FragmentTransaction;

    move-result-object v1

    const-string v2, "gpg.AuthTokenSupport"

    .line 133
    invoke-virtual {v1, v0, v2}, Landroid/app/FragmentTransaction;->add(Landroid/app/Fragment;Ljava/lang/String;)Landroid/app/FragmentTransaction;

    .line 134
    invoke-virtual {v1}, Landroid/app/FragmentTransaction;->commit()I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    const-string v1, "TokenFragment"

    .line 136
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Cannot launch token fragment:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/16 v0, 0xd

    .line 137
    invoke-virtual {v11, v0}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->setResult(I)V

    .line 138
    sget-object v1, Lcom/google/games/bridge/TokenFragment;->lock:Ljava/lang/Object;

    monitor-enter v1

    const/4 v0, 0x0

    .line 139
    :try_start_2
    sput-object v0, Lcom/google/games/bridge/TokenFragment;->pendingTokenRequest:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    .line 140
    monitor-exit v1

    goto :goto_1

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    :cond_2
    const-string v1, "TokenFragment"

    const-string v2, "Fragment exists.. calling processRequests"

    .line 143
    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 144
    invoke-direct {v0}, Lcom/google/games/bridge/TokenFragment;->processRequest()V

    .line 147
    :goto_1
    invoke-virtual {v11}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->getPendingResponse()Lcom/google/android/gms/common/api/PendingResult;

    move-result-object v0

    return-object v0

    :catchall_1
    move-exception v0

    .line 116
    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v0
.end method

.method private onSignedIn(ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V
    .locals 3

    .line 369
    sget-object v0, Lcom/google/games/bridge/TokenFragment;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 370
    :try_start_0
    sget-object v1, Lcom/google/games/bridge/TokenFragment;->pendingTokenRequest:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    const/4 v2, 0x0

    .line 371
    sput-object v2, Lcom/google/games/bridge/TokenFragment;->pendingTokenRequest:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    .line 372
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_2

    if-eqz p2, :cond_0

    .line 376
    invoke-virtual {p2}, Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;->getServerAuthCode()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->setAuthCode(Ljava/lang/String;)V

    .line 377
    invoke-virtual {p2}, Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;->getEmail()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->setEmail(Ljava/lang/String;)V

    .line 378
    invoke-virtual {p2}, Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;->getIdToken()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->setIdToken(Ljava/lang/String;)V

    :cond_0
    if-eqz p1, :cond_1

    const-string p2, "TokenFragment"

    .line 381
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Setting result error status code to: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 383
    :cond_1
    invoke-virtual {v1, p1}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->setResult(I)V

    :cond_2
    return-void

    :catchall_0
    move-exception p1

    .line 372
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method private processRequest()V
    .locals 2

    .line 262
    sget-object v0, Lcom/google/games/bridge/TokenFragment;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 263
    :try_start_0
    sget-object v1, Lcom/google/games/bridge/TokenFragment;->pendingTokenRequest:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    .line 264
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez v1, :cond_0

    return-void

    .line 271
    :cond_0
    invoke-virtual {p0}, Lcom/google/games/bridge/TokenFragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    invoke-direct {p0, v0, v1}, Lcom/google/games/bridge/TokenFragment;->buildClient(Landroid/app/Activity;Lcom/google/games/bridge/TokenFragment$TokenRequest;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 272
    invoke-direct {p0}, Lcom/google/games/bridge/TokenFragment;->signIn()V

    goto :goto_0

    .line 274
    :cond_1
    sget-object v1, Lcom/google/games/bridge/TokenFragment;->lock:Ljava/lang/Object;

    monitor-enter v1

    const/4 v0, 0x0

    .line 275
    :try_start_1
    sput-object v0, Lcom/google/games/bridge/TokenFragment;->pendingTokenRequest:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    .line 276
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    const-string v0, "TokenFragment"

    const-string v1, "Done with processRequest, result is pending."

    .line 278
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :catchall_0
    move-exception v0

    .line 276
    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    :catchall_1
    move-exception v1

    .line 264
    :try_start_3
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v1
.end method

.method private reset()V
    .locals 1

    .line 165
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment;->mGoogleSignInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    if-eqz v0, :cond_0

    .line 166
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment;->mGoogleSignInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    invoke-virtual {v0}, Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;->signOut()Lcom/google/android/gms/tasks/Task;

    const/4 v0, 0x0

    .line 167
    iput-object v0, p0, Lcom/google/games/bridge/TokenFragment;->mGoogleSignInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    :cond_0
    return-void
.end method

.method private signIn()V
    .locals 5

    const-string v0, "TokenFragment"

    const-string v1, "signIn"

    .line 172
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 175
    sget-object v0, Lcom/google/games/bridge/TokenFragment;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 176
    :try_start_0
    sget-object v1, Lcom/google/games/bridge/TokenFragment;->pendingTokenRequest:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    .line 177
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 179
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment;->mGoogleSignInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    if-eqz v0, :cond_1

    if-eqz v1, :cond_1

    .line 182
    invoke-virtual {v1}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->canReuseAccount()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 183
    invoke-virtual {p0}, Lcom/google/games/bridge/TokenFragment;->getActivity()Landroid/app/Activity;

    move-result-object v2

    invoke-static {v2}, Lcom/google/android/gms/auth/api/signin/GoogleSignIn;->getLastSignedInAccount(Landroid/content/Context;)Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    move-result-object v2

    .line 184
    invoke-static {v1}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->access$000(Lcom/google/games/bridge/TokenFragment$TokenRequest;)[Lcom/google/android/gms/common/api/Scope;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/auth/api/signin/GoogleSignIn;->hasPermissions(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;[Lcom/google/android/gms/common/api/Scope;)Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v1, "TokenFragment"

    const-string v3, "Checking the last signed-in account if it can be used."

    .line 185
    invoke-static {v1, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 186
    invoke-virtual {p0}, Lcom/google/games/bridge/TokenFragment;->getActivity()Landroid/app/Activity;

    move-result-object v1

    invoke-static {v1, v2}, Lcom/google/android/gms/games/Games;->getGamesClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/GamesClient;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/android/gms/games/GamesClient;->getAppId()Lcom/google/android/gms/tasks/Task;

    move-result-object v1

    new-instance v3, Lcom/google/games/bridge/TokenFragment$1;

    invoke-direct {v3, p0, v2, v0}, Lcom/google/games/bridge/TokenFragment$1;-><init>(Lcom/google/games/bridge/TokenFragment;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;)V

    .line 187
    invoke-virtual {v1, v3}, Lcom/google/android/gms/tasks/Task;->addOnCompleteListener(Lcom/google/android/gms/tasks/OnCompleteListener;)Lcom/google/android/gms/tasks/Task;

    return-void

    :cond_0
    const-string v2, "TokenFragment"

    const-string v3, "signInClient.silentSignIn"

    .line 215
    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 216
    invoke-virtual {v0}, Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;->silentSignIn()Lcom/google/android/gms/tasks/Task;

    move-result-object v2

    .line 218
    invoke-virtual {p0}, Lcom/google/games/bridge/TokenFragment;->getActivity()Landroid/app/Activity;

    move-result-object v3

    new-instance v4, Lcom/google/games/bridge/TokenFragment$3;

    invoke-direct {v4, p0}, Lcom/google/games/bridge/TokenFragment$3;-><init>(Lcom/google/games/bridge/TokenFragment;)V

    .line 217
    invoke-virtual {v2, v3, v4}, Lcom/google/android/gms/tasks/Task;->addOnSuccessListener(Landroid/app/Activity;Lcom/google/android/gms/tasks/OnSuccessListener;)Lcom/google/android/gms/tasks/Task;

    move-result-object v2

    .line 227
    invoke-virtual {p0}, Lcom/google/games/bridge/TokenFragment;->getActivity()Landroid/app/Activity;

    move-result-object v3

    new-instance v4, Lcom/google/games/bridge/TokenFragment$2;

    invoke-direct {v4, p0, v1, v0}, Lcom/google/games/bridge/TokenFragment$2;-><init>(Lcom/google/games/bridge/TokenFragment;Lcom/google/games/bridge/TokenFragment$TokenRequest;Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;)V

    .line 226
    invoke-virtual {v2, v3, v4}, Lcom/google/android/gms/tasks/Task;->addOnFailureListener(Landroid/app/Activity;Lcom/google/android/gms/tasks/OnFailureListener;)Lcom/google/android/gms/tasks/Task;

    :cond_1
    return-void

    :catchall_0
    move-exception v1

    .line 177
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static signOut(Landroid/app/Activity;)V
    .locals 1

    .line 152
    invoke-virtual {p0}, Landroid/app/Activity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object p0

    const-string v0, "gpg.AuthTokenSupport"

    invoke-virtual {p0, v0}, Landroid/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroid/app/Fragment;

    move-result-object p0

    check-cast p0, Lcom/google/games/bridge/TokenFragment;

    if-eqz p0, :cond_0

    .line 154
    invoke-direct {p0}, Lcom/google/games/bridge/TokenFragment;->reset()V

    .line 156
    :cond_0
    sget-object p0, Lcom/google/games/bridge/TokenFragment;->lock:Ljava/lang/Object;

    monitor-enter p0

    const/4 v0, 0x0

    .line 157
    :try_start_0
    sput-object v0, Lcom/google/games/bridge/TokenFragment;->pendingTokenRequest:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    .line 158
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method


# virtual methods
.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 2

    const/16 v0, 0x232a

    if-ne p1, v0, :cond_3

    .line 346
    sget-object p1, Lcom/google/android/gms/auth/api/Auth;->GoogleSignInApi:Lcom/google/android/gms/auth/api/signin/GoogleSignInApi;

    .line 347
    invoke-interface {p1, p3}, Lcom/google/android/gms/auth/api/signin/GoogleSignInApi;->getSignInResultFromIntent(Landroid/content/Intent;)Lcom/google/android/gms/auth/api/signin/GoogleSignInResult;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 348
    invoke-virtual {p1}, Lcom/google/android/gms/auth/api/signin/GoogleSignInResult;->isSuccess()Z

    move-result p3

    if-eqz p3, :cond_0

    .line 349
    invoke-virtual {p1}, Lcom/google/android/gms/auth/api/signin/GoogleSignInResult;->getSignInAccount()Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    move-result-object p2

    .line 350
    invoke-virtual {p1}, Lcom/google/android/gms/auth/api/signin/GoogleSignInResult;->getStatus()Lcom/google/android/gms/common/api/Status;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/android/gms/common/api/Status;->getStatusCode()I

    move-result p1

    invoke-direct {p0, p1, p2}, Lcom/google/games/bridge/TokenFragment;->onSignedIn(ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V

    goto :goto_0

    :cond_0
    const/4 p3, 0x0

    if-nez p2, :cond_1

    const/16 p1, 0x10

    .line 352
    invoke-direct {p0, p1, p3}, Lcom/google/games/bridge/TokenFragment;->onSignedIn(ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V

    goto :goto_0

    :cond_1
    if-eqz p1, :cond_2

    const-string p2, "TokenFragment"

    .line 354
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GoogleSignInResult error status code: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lcom/google/android/gms/auth/api/signin/GoogleSignInResult;->getStatus()Lcom/google/android/gms/common/api/Status;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 355
    invoke-virtual {p1}, Lcom/google/android/gms/auth/api/signin/GoogleSignInResult;->getStatus()Lcom/google/android/gms/common/api/Status;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/android/gms/common/api/Status;->getStatusCode()I

    move-result p1

    invoke-direct {p0, p1, p3}, Lcom/google/games/bridge/TokenFragment;->onSignedIn(ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V

    goto :goto_0

    :cond_2
    const-string p1, "TokenFragment"

    .line 357
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Google SignIn Result is null, resultCode is "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 359
    invoke-static {p2}, Lcom/google/android/gms/auth/api/signin/GoogleSignInStatusCodes;->getStatusCodeString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, ")"

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    .line 357
    invoke-static {p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/16 p1, 0xd

    .line 360
    invoke-direct {p0, p1, p3}, Lcom/google/games/bridge/TokenFragment;->onSignedIn(ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V

    :goto_0
    return-void

    .line 364
    :cond_3
    invoke-super {p0, p1, p2, p3}, Landroid/app/Fragment;->onActivityResult(IILandroid/content/Intent;)V

    return-void
.end method

.method public onResume()V
    .locals 2

    const-string v0, "TokenFragment"

    const-string v1, "onResume called"

    .line 395
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 396
    invoke-super {p0}, Landroid/app/Fragment;->onResume()V

    .line 397
    sget-object v0, Lcom/google/games/bridge/TokenFragment;->helperFragment:Lcom/google/games/bridge/TokenFragment;

    if-nez v0, :cond_0

    .line 398
    sput-object p0, Lcom/google/games/bridge/TokenFragment;->helperFragment:Lcom/google/games/bridge/TokenFragment;

    .line 400
    :cond_0
    invoke-direct {p0}, Lcom/google/games/bridge/TokenFragment;->processRequest()V

    return-void
.end method

.class public final Lcom/google/android/gms/games/Games$GamesOptions$Builder;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/games/Games$GamesOptions;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field private zzar:Z

.field private zzas:Z

.field private zzat:I

.field private zzau:Z

.field private zzav:I

.field private zzaw:Ljava/lang/String;

.field private zzax:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private zzay:Z

.field private zzaz:Z

.field private zzba:Z

.field zzbb:Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

.field private zzbc:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 3

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 2
    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzar:Z

    const/4 v1, 0x1

    .line 3
    iput-boolean v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzas:Z

    const/16 v1, 0x11

    .line 4
    iput v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzat:I

    .line 5
    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzau:Z

    const/16 v1, 0x1110

    .line 6
    iput v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzav:I

    const/4 v1, 0x0

    .line 7
    iput-object v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzaw:Ljava/lang/String;

    .line 8
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzax:Ljava/util/ArrayList;

    .line 9
    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzay:Z

    .line 10
    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzaz:Z

    .line 11
    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzba:Z

    .line 12
    iput-object v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzbb:Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    .line 13
    iput-object v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzbc:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>(Lcom/google/android/gms/games/Games$GamesOptions;)V
    .locals 3

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 16
    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzar:Z

    const/4 v1, 0x1

    .line 17
    iput-boolean v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzas:Z

    const/16 v1, 0x11

    .line 18
    iput v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzat:I

    .line 19
    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzau:Z

    const/16 v1, 0x1110

    .line 20
    iput v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzav:I

    const/4 v1, 0x0

    .line 21
    iput-object v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzaw:Ljava/lang/String;

    .line 22
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzax:Ljava/util/ArrayList;

    .line 23
    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzay:Z

    .line 24
    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzaz:Z

    .line 25
    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzba:Z

    .line 26
    iput-object v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzbb:Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    .line 27
    iput-object v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzbc:Ljava/lang/String;

    if-eqz p1, :cond_0

    .line 29
    iget-boolean v0, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzar:Z

    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzar:Z

    .line 30
    iget-boolean v0, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzas:Z

    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzas:Z

    .line 31
    iget v0, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzat:I

    iput v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzat:I

    .line 32
    iget-boolean v0, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzau:Z

    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzau:Z

    .line 33
    iget v0, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzav:I

    iput v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzav:I

    .line 34
    iget-object v0, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzaw:Ljava/lang/String;

    iput-object v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzaw:Ljava/lang/String;

    .line 35
    iget-object v0, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzax:Ljava/util/ArrayList;

    iput-object v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzax:Ljava/util/ArrayList;

    .line 36
    iget-boolean v0, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzay:Z

    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzay:Z

    .line 37
    iget-boolean v0, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzaz:Z

    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzaz:Z

    .line 38
    iget-boolean v0, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzba:Z

    iput-boolean v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzba:Z

    .line 39
    iget-object v0, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzbb:Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    iput-object v0, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzbb:Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    .line 40
    iget-object p1, p1, Lcom/google/android/gms/games/Games$GamesOptions;->zzbc:Ljava/lang/String;

    iput-object p1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzbc:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/android/gms/games/Games$GamesOptions;Lcom/google/android/gms/games/zzi;)V
    .locals 0

    const/4 p1, 0x0

    .line 52
    invoke-direct {p0, p1}, Lcom/google/android/gms/games/Games$GamesOptions$Builder;-><init>(Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-void
.end method

.method synthetic constructor <init>(Lcom/google/android/gms/games/zzi;)V
    .locals 0

    .line 51
    invoke-direct {p0}, Lcom/google/android/gms/games/Games$GamesOptions$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method public final build()Lcom/google/android/gms/games/Games$GamesOptions;
    .locals 15

    .line 50
    new-instance v14, Lcom/google/android/gms/games/Games$GamesOptions;

    iget-boolean v1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzar:Z

    iget-boolean v2, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzas:Z

    iget v3, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzat:I

    iget-boolean v4, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzau:Z

    iget v5, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzav:I

    iget-object v6, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzaw:Ljava/lang/String;

    iget-object v7, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzax:Ljava/util/ArrayList;

    iget-boolean v8, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzay:Z

    iget-boolean v9, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzaz:Z

    iget-boolean v10, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzba:Z

    iget-object v11, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzbb:Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    iget-object v12, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzbc:Ljava/lang/String;

    const/4 v13, 0x0

    move-object v0, v14

    invoke-direct/range {v0 .. v13}, Lcom/google/android/gms/games/Games$GamesOptions;-><init>(ZZIZILjava/lang/String;Ljava/util/ArrayList;ZZZLcom/google/android/gms/auth/api/signin/GoogleSignInAccount;Ljava/lang/String;Lcom/google/android/gms/games/zzi;)V

    return-object v14
.end method

.method public final setSdkVariant(I)Lcom/google/android/gms/games/Games$GamesOptions$Builder;
    .locals 0

    .line 48
    iput p1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzav:I

    return-object p0
.end method

.method public final setShowConnectingPopup(Z)Lcom/google/android/gms/games/Games$GamesOptions$Builder;
    .locals 0

    .line 42
    iput-boolean p1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzas:Z

    const/16 p1, 0x11

    .line 43
    iput p1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzat:I

    return-object p0
.end method

.method public final setShowConnectingPopup(ZI)Lcom/google/android/gms/games/Games$GamesOptions$Builder;
    .locals 0

    .line 45
    iput-boolean p1, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzas:Z

    .line 46
    iput p2, p0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzat:I

    return-object p0
.end method

.class public final Lcom/google/android/gms/internal/games/zzek;
.super Ljava/lang/Object;


# static fields
.field private static final zznr:[Ljava/lang/String;


# instance fields
.field private final statusCode:I

.field private final zzns:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const-string v0, "requestId"

    const-string v1, "outcome"

    .line 22
    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/games/zzek;->zznr:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>(ILjava/util/HashMap;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    iput p1, p0, Lcom/google/android/gms/internal/games/zzek;->statusCode:I

    .line 3
    iput-object p2, p0, Lcom/google/android/gms/internal/games/zzek;->zzns:Ljava/util/HashMap;

    return-void
.end method

.method synthetic constructor <init>(ILjava/util/HashMap;Lcom/google/android/gms/internal/games/zzel;)V
    .locals 0

    .line 21
    invoke-direct {p0, p1, p2}, Lcom/google/android/gms/internal/games/zzek;-><init>(ILjava/util/HashMap;)V

    return-void
.end method

.method public static zzbb(Lcom/google/android/gms/common/data/DataHolder;)Lcom/google/android/gms/internal/games/zzek;
    .locals 6
    .annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
    .end annotation

    .line 10
    new-instance v0, Lcom/google/android/gms/internal/games/zzem;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzem;-><init>()V

    .line 11
    invoke-virtual {p0}, Lcom/google/android/gms/common/data/DataHolder;->getStatusCode()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/games/zzem;->zzo(I)Lcom/google/android/gms/internal/games/zzem;

    .line 12
    invoke-virtual {p0}, Lcom/google/android/gms/common/data/DataHolder;->getCount()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    .line 14
    invoke-virtual {p0, v2}, Lcom/google/android/gms/common/data/DataHolder;->getWindowIndex(I)I

    move-result v3

    const-string v4, "requestId"

    .line 16
    invoke-virtual {p0, v4, v2, v3}, Lcom/google/android/gms/common/data/DataHolder;->getString(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "outcome"

    .line 17
    invoke-virtual {p0, v5, v2, v3}, Lcom/google/android/gms/common/data/DataHolder;->getInteger(Ljava/lang/String;II)I

    move-result v3

    .line 18
    invoke-virtual {v0, v4, v3}, Lcom/google/android/gms/internal/games/zzem;->zzh(Ljava/lang/String;I)Lcom/google/android/gms/internal/games/zzem;

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 20
    :cond_0
    invoke-virtual {v0}, Lcom/google/android/gms/internal/games/zzem;->zzdh()Lcom/google/android/gms/internal/games/zzek;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final getRequestIds()Ljava/util/Set;
    .locals 1
    .annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 9
    iget-object v0, p0, Lcom/google/android/gms/internal/games/zzek;->zzns:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v0

    return-object v0
.end method

.method public final getRequestOutcome(Ljava/lang/String;)I
    .locals 3
    .annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
    .end annotation

    .line 5
    iget-object v0, p0, Lcom/google/android/gms/internal/games/zzek;->zzns:Ljava/util/HashMap;

    .line 6
    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, 0x2e

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v1, "Request "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " was not part of the update operation!"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 7
    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkArgument(ZLjava/lang/Object;)V

    .line 8
    iget-object v0, p0, Lcom/google/android/gms/internal/games/zzek;->zzns:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    return p1
.end method

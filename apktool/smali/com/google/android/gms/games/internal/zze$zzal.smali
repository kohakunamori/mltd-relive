.class final Lcom/google/android/gms/games/internal/zze$zzal;
.super Lcom/google/android/gms/games/internal/zze$zzat;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/games/internal/zze;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "zzal"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/games/internal/zze$zzat<",
        "Lcom/google/android/gms/games/Players$LoadPlayersResult;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>(Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder<",
            "Lcom/google/android/gms/games/Players$LoadPlayersResult;",
            ">;)V"
        }
    .end annotation

    .line 1
    invoke-direct {p0, p1}, Lcom/google/android/gms/games/internal/zze$zzat;-><init>(Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder;)V

    return-void
.end method


# virtual methods
.method public final zze(Lcom/google/android/gms/common/data/DataHolder;)V
    .locals 1

    .line 3
    new-instance v0, Lcom/google/android/gms/games/internal/zze$zzae;

    invoke-direct {v0, p1}, Lcom/google/android/gms/games/internal/zze$zzae;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    invoke-virtual {p0, v0}, Lcom/google/android/gms/games/internal/zze$zzat;->setResult(Ljava/lang/Object;)V

    return-void
.end method

.method public final zzf(Lcom/google/android/gms/common/data/DataHolder;)V
    .locals 1

    .line 5
    new-instance v0, Lcom/google/android/gms/games/internal/zze$zzae;

    invoke-direct {v0, p1}, Lcom/google/android/gms/games/internal/zze$zzae;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    invoke-virtual {p0, v0}, Lcom/google/android/gms/games/internal/zze$zzat;->setResult(Ljava/lang/Object;)V

    return-void
.end method

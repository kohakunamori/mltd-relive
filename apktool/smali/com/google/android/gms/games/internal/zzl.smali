.class final Lcom/google/android/gms/games/internal/zzl;
.super Lcom/google/android/gms/games/internal/zze$zzat;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/games/internal/zze$zzat<",
        "Lcom/google/android/gms/games/quest/Quests$ClaimMilestoneResult;",
        ">;"
    }
.end annotation


# instance fields
.field private final synthetic zzha:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder;Ljava/lang/String;)V
    .locals 0

    .line 1
    iput-object p2, p0, Lcom/google/android/gms/games/internal/zzl;->zzha:Ljava/lang/String;

    invoke-direct {p0, p1}, Lcom/google/android/gms/games/internal/zze$zzat;-><init>(Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder;)V

    return-void
.end method


# virtual methods
.method public final zzai(Lcom/google/android/gms/common/data/DataHolder;)V
    .locals 2

    .line 2
    new-instance v0, Lcom/google/android/gms/games/internal/zze$zzg;

    iget-object v1, p0, Lcom/google/android/gms/games/internal/zzl;->zzha:Ljava/lang/String;

    invoke-direct {v0, p1, v1}, Lcom/google/android/gms/games/internal/zze$zzg;-><init>(Lcom/google/android/gms/common/data/DataHolder;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/google/android/gms/games/internal/zze$zzat;->setResult(Ljava/lang/Object;)V

    return-void
.end method

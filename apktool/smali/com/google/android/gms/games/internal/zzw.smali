.class final Lcom/google/android/gms/games/internal/zzw;
.super Lcom/google/android/gms/games/internal/zze$zzv;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/games/internal/zze$zzv<",
        "TT;>;"
    }
.end annotation


# instance fields
.field private final synthetic zzhf:Lcom/google/android/gms/common/data/DataHolder;

.field private final synthetic zzhg:Lcom/google/android/gms/games/internal/zze$zzav;

.field private final synthetic zzhh:Ljava/util/ArrayList;


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/internal/zze$zzav;Lcom/google/android/gms/common/data/DataHolder;Ljava/util/ArrayList;)V
    .locals 0

    .line 1
    iput-object p1, p0, Lcom/google/android/gms/games/internal/zzw;->zzhg:Lcom/google/android/gms/games/internal/zze$zzav;

    iput-object p2, p0, Lcom/google/android/gms/games/internal/zzw;->zzhf:Lcom/google/android/gms/common/data/DataHolder;

    iput-object p3, p0, Lcom/google/android/gms/games/internal/zzw;->zzhh:Ljava/util/ArrayList;

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lcom/google/android/gms/games/internal/zze$zzv;-><init>(Lcom/google/android/gms/games/internal/zzf;)V

    return-void
.end method


# virtual methods
.method public final notifyListener(Ljava/lang/Object;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .line 2
    iget-object v0, p0, Lcom/google/android/gms/games/internal/zzw;->zzhg:Lcom/google/android/gms/games/internal/zze$zzav;

    iget-object v1, p0, Lcom/google/android/gms/games/internal/zzw;->zzhf:Lcom/google/android/gms/common/data/DataHolder;

    invoke-static {v1}, Lcom/google/android/gms/games/internal/zze;->zzaz(Lcom/google/android/gms/common/data/DataHolder;)Lcom/google/android/gms/games/multiplayer/realtime/Room;

    move-result-object v1

    iget-object v2, p0, Lcom/google/android/gms/games/internal/zzw;->zzhh:Ljava/util/ArrayList;

    invoke-interface {v0, p1, v1, v2}, Lcom/google/android/gms/games/internal/zze$zzav;->zza(Ljava/lang/Object;Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/ArrayList;)V

    return-void
.end method

.class final Lcom/google/android/gms/games/internal/zzx;
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

.field private final synthetic zzhi:Lcom/google/android/gms/games/internal/zze$zzaz;


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/internal/zze$zzaz;Lcom/google/android/gms/common/data/DataHolder;)V
    .locals 0

    .line 1
    iput-object p1, p0, Lcom/google/android/gms/games/internal/zzx;->zzhi:Lcom/google/android/gms/games/internal/zze$zzaz;

    iput-object p2, p0, Lcom/google/android/gms/games/internal/zzx;->zzhf:Lcom/google/android/gms/common/data/DataHolder;

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
    iget-object v0, p0, Lcom/google/android/gms/games/internal/zzx;->zzhi:Lcom/google/android/gms/games/internal/zze$zzaz;

    iget-object v1, p0, Lcom/google/android/gms/games/internal/zzx;->zzhf:Lcom/google/android/gms/common/data/DataHolder;

    invoke-virtual {v1}, Lcom/google/android/gms/common/data/DataHolder;->getStatusCode()I

    move-result v1

    iget-object v2, p0, Lcom/google/android/gms/games/internal/zzx;->zzhf:Lcom/google/android/gms/common/data/DataHolder;

    invoke-static {v2}, Lcom/google/android/gms/games/internal/zze;->zzaz(Lcom/google/android/gms/common/data/DataHolder;)Lcom/google/android/gms/games/multiplayer/realtime/Room;

    move-result-object v2

    invoke-interface {v0, p1, v1, v2}, Lcom/google/android/gms/games/internal/zze$zzaz;->zza(Ljava/lang/Object;ILcom/google/android/gms/games/multiplayer/realtime/Room;)V

    return-void
.end method

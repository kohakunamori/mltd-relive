.class final Lcom/google/android/gms/games/internal/zzv;
.super Lcom/google/android/gms/games/internal/zze$zzv;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/games/internal/zze$zzv<",
        "TT;>;"
    }
.end annotation


# instance fields
.field private final synthetic zzhe:Lcom/google/android/gms/games/internal/zze$zzaw;

.field private final synthetic zzhf:Lcom/google/android/gms/common/data/DataHolder;


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/internal/zze$zzaw;Lcom/google/android/gms/common/data/DataHolder;)V
    .locals 0

    .line 1
    iput-object p1, p0, Lcom/google/android/gms/games/internal/zzv;->zzhe:Lcom/google/android/gms/games/internal/zze$zzaw;

    iput-object p2, p0, Lcom/google/android/gms/games/internal/zzv;->zzhf:Lcom/google/android/gms/common/data/DataHolder;

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lcom/google/android/gms/games/internal/zze$zzv;-><init>(Lcom/google/android/gms/games/internal/zzf;)V

    return-void
.end method


# virtual methods
.method public final notifyListener(Ljava/lang/Object;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .line 2
    iget-object v0, p0, Lcom/google/android/gms/games/internal/zzv;->zzhe:Lcom/google/android/gms/games/internal/zze$zzaw;

    iget-object v1, p0, Lcom/google/android/gms/games/internal/zzv;->zzhf:Lcom/google/android/gms/common/data/DataHolder;

    invoke-static {v1}, Lcom/google/android/gms/games/internal/zze;->zzaz(Lcom/google/android/gms/common/data/DataHolder;)Lcom/google/android/gms/games/multiplayer/realtime/Room;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Lcom/google/android/gms/games/internal/zze$zzaw;->zza(Ljava/lang/Object;Lcom/google/android/gms/games/multiplayer/realtime/Room;)V

    return-void
.end method

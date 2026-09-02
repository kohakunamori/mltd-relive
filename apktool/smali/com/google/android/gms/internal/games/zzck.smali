.class final Lcom/google/android/gms/internal/games/zzck;
.super Lcom/google/android/gms/internal/games/zzcn;


# instance fields
.field private final synthetic zzeh:Lcom/google/android/gms/games/snapshot/Snapshot;

.field private final synthetic zzku:Lcom/google/android/gms/games/snapshot/SnapshotMetadataChange;


# direct methods
.method constructor <init>(Lcom/google/android/gms/internal/games/zzch;Lcom/google/android/gms/common/api/GoogleApiClient;Lcom/google/android/gms/games/snapshot/Snapshot;Lcom/google/android/gms/games/snapshot/SnapshotMetadataChange;)V
    .locals 0

    .line 1
    iput-object p3, p0, Lcom/google/android/gms/internal/games/zzck;->zzeh:Lcom/google/android/gms/games/snapshot/Snapshot;

    iput-object p4, p0, Lcom/google/android/gms/internal/games/zzck;->zzku:Lcom/google/android/gms/games/snapshot/SnapshotMetadataChange;

    const/4 p1, 0x0

    invoke-direct {p0, p2, p1}, Lcom/google/android/gms/internal/games/zzcn;-><init>(Lcom/google/android/gms/common/api/GoogleApiClient;Lcom/google/android/gms/internal/games/zzci;)V

    return-void
.end method


# virtual methods
.method protected final synthetic doExecute(Lcom/google/android/gms/common/api/Api$AnyClient;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 2
    check-cast p1, Lcom/google/android/gms/games/internal/zze;

    .line 3
    iget-object v0, p0, Lcom/google/android/gms/internal/games/zzck;->zzeh:Lcom/google/android/gms/games/snapshot/Snapshot;

    iget-object v1, p0, Lcom/google/android/gms/internal/games/zzck;->zzku:Lcom/google/android/gms/games/snapshot/SnapshotMetadataChange;

    invoke-virtual {p1, p0, v0, v1}, Lcom/google/android/gms/games/internal/zze;->zza(Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder;Lcom/google/android/gms/games/snapshot/Snapshot;Lcom/google/android/gms/games/snapshot/SnapshotMetadataChange;)V

    return-void
.end method

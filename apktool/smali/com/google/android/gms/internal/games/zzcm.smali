.class final Lcom/google/android/gms/internal/games/zzcm;
.super Lcom/google/android/gms/internal/games/zzct;


# instance fields
.field private final synthetic zzku:Lcom/google/android/gms/games/snapshot/SnapshotMetadataChange;

.field private final synthetic zzkw:Ljava/lang/String;

.field private final synthetic zzkx:Ljava/lang/String;

.field private final synthetic zzky:Lcom/google/android/gms/games/snapshot/SnapshotContents;


# direct methods
.method constructor <init>(Lcom/google/android/gms/internal/games/zzch;Lcom/google/android/gms/common/api/GoogleApiClient;Ljava/lang/String;Ljava/lang/String;Lcom/google/android/gms/games/snapshot/SnapshotMetadataChange;Lcom/google/android/gms/games/snapshot/SnapshotContents;)V
    .locals 0

    .line 1
    iput-object p3, p0, Lcom/google/android/gms/internal/games/zzcm;->zzkw:Ljava/lang/String;

    iput-object p4, p0, Lcom/google/android/gms/internal/games/zzcm;->zzkx:Ljava/lang/String;

    iput-object p5, p0, Lcom/google/android/gms/internal/games/zzcm;->zzku:Lcom/google/android/gms/games/snapshot/SnapshotMetadataChange;

    iput-object p6, p0, Lcom/google/android/gms/internal/games/zzcm;->zzky:Lcom/google/android/gms/games/snapshot/SnapshotContents;

    const/4 p1, 0x0

    invoke-direct {p0, p2, p1}, Lcom/google/android/gms/internal/games/zzct;-><init>(Lcom/google/android/gms/common/api/GoogleApiClient;Lcom/google/android/gms/internal/games/zzci;)V

    return-void
.end method


# virtual methods
.method protected final synthetic doExecute(Lcom/google/android/gms/common/api/Api$AnyClient;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 2
    move-object v0, p1

    check-cast v0, Lcom/google/android/gms/games/internal/zze;

    .line 3
    iget-object v2, p0, Lcom/google/android/gms/internal/games/zzcm;->zzkw:Ljava/lang/String;

    iget-object v3, p0, Lcom/google/android/gms/internal/games/zzcm;->zzkx:Ljava/lang/String;

    iget-object v4, p0, Lcom/google/android/gms/internal/games/zzcm;->zzku:Lcom/google/android/gms/games/snapshot/SnapshotMetadataChange;

    iget-object v5, p0, Lcom/google/android/gms/internal/games/zzcm;->zzky:Lcom/google/android/gms/games/snapshot/SnapshotContents;

    move-object v1, p0

    invoke-virtual/range {v0 .. v5}, Lcom/google/android/gms/games/internal/zze;->zza(Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder;Ljava/lang/String;Ljava/lang/String;Lcom/google/android/gms/games/snapshot/SnapshotMetadataChange;Lcom/google/android/gms/games/snapshot/SnapshotContents;)V

    return-void
.end method

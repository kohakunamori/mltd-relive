.class final Lcom/google/android/gms/games/zzbj;
.super Lcom/google/android/gms/games/internal/zzbo;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/games/internal/zzbo<",
        "Lcom/google/android/gms/games/multiplayer/realtime/zzh;",
        ">;"
    }
.end annotation


# instance fields
.field private final synthetic zzbj:Lcom/google/android/gms/common/api/internal/ListenerHolder;

.field private final synthetic zzdq:Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig;


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/RealTimeMultiplayerClient;Lcom/google/android/gms/common/api/internal/ListenerHolder;Lcom/google/android/gms/common/api/internal/ListenerHolder;Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig;)V
    .locals 0

    .line 1
    iput-object p3, p0, Lcom/google/android/gms/games/zzbj;->zzbj:Lcom/google/android/gms/common/api/internal/ListenerHolder;

    iput-object p4, p0, Lcom/google/android/gms/games/zzbj;->zzdq:Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig;

    invoke-direct {p0, p2}, Lcom/google/android/gms/games/internal/zzbo;-><init>(Lcom/google/android/gms/common/api/internal/ListenerHolder;)V

    return-void
.end method


# virtual methods
.method protected final zzb(Lcom/google/android/gms/games/internal/zze;Lcom/google/android/gms/tasks/TaskCompletionSource;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/internal/zze;",
            "Lcom/google/android/gms/tasks/TaskCompletionSource<",
            "Ljava/lang/Void;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;,
            Ljava/lang/SecurityException;
        }
    .end annotation

    .line 2
    iget-object v0, p0, Lcom/google/android/gms/games/zzbj;->zzbj:Lcom/google/android/gms/common/api/internal/ListenerHolder;

    iget-object v1, p0, Lcom/google/android/gms/games/zzbj;->zzbj:Lcom/google/android/gms/common/api/internal/ListenerHolder;

    iget-object v2, p0, Lcom/google/android/gms/games/zzbj;->zzbj:Lcom/google/android/gms/common/api/internal/ListenerHolder;

    iget-object v3, p0, Lcom/google/android/gms/games/zzbj;->zzdq:Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig;

    invoke-virtual {p1, v0, v1, v2, v3}, Lcom/google/android/gms/games/internal/zze;->zza(Lcom/google/android/gms/common/api/internal/ListenerHolder;Lcom/google/android/gms/common/api/internal/ListenerHolder;Lcom/google/android/gms/common/api/internal/ListenerHolder;Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig;)V

    const/4 p1, 0x0

    .line 3
    invoke-virtual {p2, p1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->setResult(Ljava/lang/Object;)V

    return-void
.end method

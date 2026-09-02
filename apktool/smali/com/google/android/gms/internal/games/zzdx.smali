.class final Lcom/google/android/gms/internal/games/zzdx;
.super Lcom/google/android/gms/internal/games/zzec;


# direct methods
.method constructor <init>(Lcom/google/android/gms/internal/games/zzdw;Lcom/google/android/gms/common/api/GoogleApiClient;)V
    .locals 0

    const/4 p1, 0x0

    .line 1
    invoke-direct {p0, p2, p1}, Lcom/google/android/gms/internal/games/zzec;-><init>(Lcom/google/android/gms/common/api/GoogleApiClient;Lcom/google/android/gms/internal/games/zzdx;)V

    return-void
.end method


# virtual methods
.method protected final synthetic doExecute(Lcom/google/android/gms/common/api/Api$AnyClient;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 2
    check-cast p1, Lcom/google/android/gms/games/internal/zze;

    .line 3
    invoke-virtual {p1, p0}, Lcom/google/android/gms/games/internal/zze;->zzc(Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder;)V

    return-void
.end method

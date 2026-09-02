.class final Lcom/google/android/gms/internal/games/zzbq;
.super Lcom/google/android/gms/internal/games/zzbw;


# instance fields
.field private final synthetic zzjz:Z

.field private final synthetic zzkd:I

.field private final synthetic zzkm:[I


# direct methods
.method constructor <init>(Lcom/google/android/gms/internal/games/zzbn;Lcom/google/android/gms/common/api/GoogleApiClient;[IIZ)V
    .locals 0

    .line 1
    iput-object p3, p0, Lcom/google/android/gms/internal/games/zzbq;->zzkm:[I

    iput p4, p0, Lcom/google/android/gms/internal/games/zzbq;->zzkd:I

    iput-boolean p5, p0, Lcom/google/android/gms/internal/games/zzbq;->zzjz:Z

    const/4 p1, 0x0

    invoke-direct {p0, p2, p1}, Lcom/google/android/gms/internal/games/zzbw;-><init>(Lcom/google/android/gms/common/api/GoogleApiClient;Lcom/google/android/gms/internal/games/zzbo;)V

    return-void
.end method


# virtual methods
.method protected final synthetic doExecute(Lcom/google/android/gms/common/api/Api$AnyClient;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 2
    check-cast p1, Lcom/google/android/gms/games/internal/zze;

    .line 3
    iget-object v0, p0, Lcom/google/android/gms/internal/games/zzbq;->zzkm:[I

    iget v1, p0, Lcom/google/android/gms/internal/games/zzbq;->zzkd:I

    iget-boolean v2, p0, Lcom/google/android/gms/internal/games/zzbq;->zzjz:Z

    invoke-virtual {p1, p0, v0, v1, v2}, Lcom/google/android/gms/games/internal/zze;->zza(Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder;[IIZ)V

    return-void
.end method

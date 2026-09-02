.class final Lcom/google/android/gms/internal/games/zzdj;
.super Lcom/google/android/gms/internal/games/zzds;


# instance fields
.field private final synthetic zzld:I

.field private final synthetic zzle:[I


# direct methods
.method constructor <init>(Lcom/google/android/gms/internal/games/zzcz;Lcom/google/android/gms/common/api/GoogleApiClient;I[I)V
    .locals 0

    .line 1
    iput p3, p0, Lcom/google/android/gms/internal/games/zzdj;->zzld:I

    iput-object p4, p0, Lcom/google/android/gms/internal/games/zzdj;->zzle:[I

    const/4 p1, 0x0

    invoke-direct {p0, p2, p1}, Lcom/google/android/gms/internal/games/zzds;-><init>(Lcom/google/android/gms/common/api/GoogleApiClient;Lcom/google/android/gms/internal/games/zzda;)V

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
    iget v0, p0, Lcom/google/android/gms/internal/games/zzdj;->zzld:I

    iget-object v1, p0, Lcom/google/android/gms/internal/games/zzdj;->zzle:[I

    invoke-virtual {p1, p0, v0, v1}, Lcom/google/android/gms/games/internal/zze;->zza(Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder;I[I)V

    return-void
.end method

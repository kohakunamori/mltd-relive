.class final Lcom/google/android/gms/internal/games/zzbf;
.super Lcom/google/android/gms/internal/games/zzbl;


# instance fields
.field private final synthetic zzjz:Z

.field private final synthetic zzkj:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/google/android/gms/internal/games/zzbd;Lcom/google/android/gms/common/api/GoogleApiClient;Ljava/lang/String;Z)V
    .locals 0

    .line 1
    iput-object p3, p0, Lcom/google/android/gms/internal/games/zzbf;->zzkj:Ljava/lang/String;

    iput-boolean p4, p0, Lcom/google/android/gms/internal/games/zzbf;->zzjz:Z

    invoke-direct {p0, p2}, Lcom/google/android/gms/internal/games/zzbl;-><init>(Lcom/google/android/gms/common/api/GoogleApiClient;)V

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
    iget-object v0, p0, Lcom/google/android/gms/internal/games/zzbf;->zzkj:Ljava/lang/String;

    iget-boolean v1, p0, Lcom/google/android/gms/internal/games/zzbf;->zzjz:Z

    invoke-virtual {p1, p0, v0, v1}, Lcom/google/android/gms/games/internal/zze;->zza(Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder;Ljava/lang/String;Z)V

    return-void
.end method

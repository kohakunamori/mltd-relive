.class final Lcom/google/android/gms/games/zzbo;
.super Lcom/google/android/gms/internal/games/zzag;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/games/zzag<",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic zzdt:Lcom/google/android/gms/games/zzbn;


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/zzbn;)V
    .locals 0

    .line 1
    iput-object p1, p0, Lcom/google/android/gms/games/zzbo;->zzdt:Lcom/google/android/gms/games/zzbn;

    invoke-direct {p0}, Lcom/google/android/gms/internal/games/zzag;-><init>()V

    return-void
.end method


# virtual methods
.method protected final zza(Lcom/google/android/gms/games/internal/zze;Lcom/google/android/gms/tasks/TaskCompletionSource;)V
    .locals 1
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
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 2
    iget-object p1, p0, Lcom/google/android/gms/games/zzbo;->zzdt:Lcom/google/android/gms/games/zzbn;

    iget-object p1, p1, Lcom/google/android/gms/games/zzbn;->zzdr:Lcom/google/android/gms/common/api/internal/ListenerHolder;

    new-instance v0, Lcom/google/android/gms/games/zzbp;

    invoke-direct {v0, p0}, Lcom/google/android/gms/games/zzbp;-><init>(Lcom/google/android/gms/games/zzbo;)V

    invoke-virtual {p1, v0}, Lcom/google/android/gms/common/api/internal/ListenerHolder;->notifyListener(Lcom/google/android/gms/common/api/internal/ListenerHolder$Notifier;)V

    const/4 p1, 0x0

    .line 3
    invoke-virtual {p2, p1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->setResult(Ljava/lang/Object;)V

    return-void
.end method

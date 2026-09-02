.class final Lcom/google/android/gms/games/zzai;
.super Lcom/google/android/gms/internal/games/zzag;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/internal/games/zzag<",
        "Landroid/content/Intent;",
        ">;"
    }
.end annotation


# instance fields
.field private final synthetic zzbr:Ljava/lang/String;

.field private final synthetic zzbs:I

.field private final synthetic zzbt:I


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/LeaderboardsClient;Ljava/lang/String;II)V
    .locals 0

    .line 1
    iput-object p2, p0, Lcom/google/android/gms/games/zzai;->zzbr:Ljava/lang/String;

    iput p3, p0, Lcom/google/android/gms/games/zzai;->zzbs:I

    iput p4, p0, Lcom/google/android/gms/games/zzai;->zzbt:I

    invoke-direct {p0}, Lcom/google/android/gms/internal/games/zzag;-><init>()V

    return-void
.end method


# virtual methods
.method protected final zza(Lcom/google/android/gms/games/internal/zze;Lcom/google/android/gms/tasks/TaskCompletionSource;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/internal/zze;",
            "Lcom/google/android/gms/tasks/TaskCompletionSource<",
            "Landroid/content/Intent;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 2
    iget-object v0, p0, Lcom/google/android/gms/games/zzai;->zzbr:Ljava/lang/String;

    iget v1, p0, Lcom/google/android/gms/games/zzai;->zzbs:I

    iget v2, p0, Lcom/google/android/gms/games/zzai;->zzbt:I

    .line 3
    invoke-virtual {p1, v0, v1, v2}, Lcom/google/android/gms/games/internal/zze;->zza(Ljava/lang/String;II)Landroid/content/Intent;

    move-result-object p1

    .line 4
    invoke-virtual {p2, p1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->setResult(Ljava/lang/Object;)V

    return-void
.end method

.class final synthetic Lcom/google/android/gms/games/internal/zzbj;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/common/api/PendingResult$StatusListener;


# instance fields
.field private final zzji:Lcom/google/android/gms/tasks/TaskCompletionSource;

.field private final zzjj:Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;

.field private final zzjq:Lcom/google/android/gms/common/api/PendingResult;

.field private final zzjr:Lcom/google/android/gms/games/internal/zzbn;


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/internal/zzbn;Lcom/google/android/gms/common/api/PendingResult;Lcom/google/android/gms/tasks/TaskCompletionSource;Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/games/internal/zzbj;->zzjr:Lcom/google/android/gms/games/internal/zzbn;

    iput-object p2, p0, Lcom/google/android/gms/games/internal/zzbj;->zzjq:Lcom/google/android/gms/common/api/PendingResult;

    iput-object p3, p0, Lcom/google/android/gms/games/internal/zzbj;->zzji:Lcom/google/android/gms/tasks/TaskCompletionSource;

    iput-object p4, p0, Lcom/google/android/gms/games/internal/zzbj;->zzjj:Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;

    return-void
.end method


# virtual methods
.method public final onComplete(Lcom/google/android/gms/common/api/Status;)V
    .locals 4

    iget-object v0, p0, Lcom/google/android/gms/games/internal/zzbj;->zzjr:Lcom/google/android/gms/games/internal/zzbn;

    iget-object v1, p0, Lcom/google/android/gms/games/internal/zzbj;->zzjq:Lcom/google/android/gms/common/api/PendingResult;

    iget-object v2, p0, Lcom/google/android/gms/games/internal/zzbj;->zzji:Lcom/google/android/gms/tasks/TaskCompletionSource;

    iget-object v3, p0, Lcom/google/android/gms/games/internal/zzbj;->zzjj:Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;

    invoke-static {v0, v1, v2, v3, p1}, Lcom/google/android/gms/games/internal/zzbe;->zza(Lcom/google/android/gms/games/internal/zzbn;Lcom/google/android/gms/common/api/PendingResult;Lcom/google/android/gms/tasks/TaskCompletionSource;Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method

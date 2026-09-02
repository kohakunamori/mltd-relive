.class final Lcom/google/android/gms/internal/games/zzar;
.super Lcom/google/android/gms/internal/games/zzax;


# instance fields
.field private final synthetic zzkg:I

.field private final synthetic zzkh:Lcom/google/android/gms/games/leaderboard/LeaderboardScoreBuffer;

.field private final synthetic zzki:I


# direct methods
.method constructor <init>(Lcom/google/android/gms/internal/games/zzal;Lcom/google/android/gms/common/api/GoogleApiClient;Lcom/google/android/gms/games/leaderboard/LeaderboardScoreBuffer;II)V
    .locals 0

    .line 1
    iput-object p3, p0, Lcom/google/android/gms/internal/games/zzar;->zzkh:Lcom/google/android/gms/games/leaderboard/LeaderboardScoreBuffer;

    iput p4, p0, Lcom/google/android/gms/internal/games/zzar;->zzkg:I

    iput p5, p0, Lcom/google/android/gms/internal/games/zzar;->zzki:I

    const/4 p1, 0x0

    invoke-direct {p0, p2, p1}, Lcom/google/android/gms/internal/games/zzax;-><init>(Lcom/google/android/gms/common/api/GoogleApiClient;Lcom/google/android/gms/internal/games/zzam;)V

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
    iget-object v0, p0, Lcom/google/android/gms/internal/games/zzar;->zzkh:Lcom/google/android/gms/games/leaderboard/LeaderboardScoreBuffer;

    iget v1, p0, Lcom/google/android/gms/internal/games/zzar;->zzkg:I

    iget v2, p0, Lcom/google/android/gms/internal/games/zzar;->zzki:I

    invoke-virtual {p1, p0, v0, v1, v2}, Lcom/google/android/gms/games/internal/zze;->zza(Lcom/google/android/gms/common/api/internal/BaseImplementation$ResultHolder;Lcom/google/android/gms/games/leaderboard/LeaderboardScoreBuffer;II)V

    return-void
.end method

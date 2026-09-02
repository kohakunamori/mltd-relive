.class final Lcom/google/android/gms/games/zzam;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter<",
        "Lcom/google/android/gms/games/leaderboard/Leaderboards$LeaderboardMetadataResult;",
        "Lcom/google/android/gms/games/leaderboard/Leaderboard;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static zza(Lcom/google/android/gms/games/leaderboard/Leaderboards$LeaderboardMetadataResult;)Lcom/google/android/gms/games/leaderboard/Leaderboard;
    .locals 2

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 4
    :cond_0
    invoke-interface {p0}, Lcom/google/android/gms/games/leaderboard/Leaderboards$LeaderboardMetadataResult;->getLeaderboards()Lcom/google/android/gms/games/leaderboard/LeaderboardBuffer;

    move-result-object p0

    if-eqz p0, :cond_3

    .line 5
    :try_start_0
    invoke-virtual {p0}, Lcom/google/android/gms/games/leaderboard/LeaderboardBuffer;->getCount()I

    move-result v1

    if-lez v1, :cond_3

    const/4 v0, 0x0

    .line 6
    invoke-virtual {p0, v0}, Lcom/google/android/gms/games/leaderboard/LeaderboardBuffer;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/games/leaderboard/Leaderboard;

    invoke-interface {v0}, Lcom/google/android/gms/games/leaderboard/Leaderboard;->freeze()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/games/leaderboard/Leaderboard;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p0, :cond_1

    .line 8
    invoke-virtual {p0}, Lcom/google/android/gms/games/leaderboard/LeaderboardBuffer;->release()V

    :cond_1
    return-object v0

    :catchall_0
    move-exception v0

    if-eqz p0, :cond_2

    .line 15
    invoke-virtual {p0}, Lcom/google/android/gms/games/leaderboard/LeaderboardBuffer;->release()V

    :cond_2
    throw v0

    :cond_3
    if-eqz p0, :cond_4

    .line 12
    invoke-virtual {p0}, Lcom/google/android/gms/games/leaderboard/LeaderboardBuffer;->release()V

    :cond_4
    return-object v0
.end method


# virtual methods
.method public final synthetic convert(Lcom/google/android/gms/common/api/Result;)Ljava/lang/Object;
    .locals 0

    .line 16
    check-cast p1, Lcom/google/android/gms/games/leaderboard/Leaderboards$LeaderboardMetadataResult;

    invoke-static {p1}, Lcom/google/android/gms/games/zzam;->zza(Lcom/google/android/gms/games/leaderboard/Leaderboards$LeaderboardMetadataResult;)Lcom/google/android/gms/games/leaderboard/Leaderboard;

    move-result-object p1

    return-object p1
.end method

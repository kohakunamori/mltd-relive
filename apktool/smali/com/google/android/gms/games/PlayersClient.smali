.class public Lcom/google/android/gms/games/PlayersClient;
.super Lcom/google/android/gms/internal/games/zzt;


# static fields
.field public static final EXTRA_PLAYER_SEARCH_RESULTS:Ljava/lang/String; = "player_search_results"

.field private static final zzdb:Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter<",
            "Lcom/google/android/gms/games/Players$LoadPlayersResult;",
            "Lcom/google/android/gms/games/PlayerBuffer;",
            ">;"
        }
    .end annotation
.end field

.field private static final zzdc:Lcom/google/android/gms/games/internal/zzbm;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/games/internal/zzbm<",
            "Lcom/google/android/gms/games/Players$LoadPlayersResult;",
            ">;"
        }
    .end annotation
.end field

.field private static final zzdd:Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter<",
            "Lcom/google/android/gms/games/Players$LoadPlayersResult;",
            "Lcom/google/android/gms/games/Player;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 22
    new-instance v0, Lcom/google/android/gms/games/zzax;

    invoke-direct {v0}, Lcom/google/android/gms/games/zzax;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/PlayersClient;->zzdb:Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;

    .line 23
    new-instance v0, Lcom/google/android/gms/games/zzay;

    invoke-direct {v0}, Lcom/google/android/gms/games/zzay;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/PlayersClient;->zzdc:Lcom/google/android/gms/games/internal/zzbm;

    .line 24
    new-instance v0, Lcom/google/android/gms/games/zzaz;

    invoke-direct {v0}, Lcom/google/android/gms/games/zzaz;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/PlayersClient;->zzdd:Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;

    return-void
.end method

.method constructor <init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V
    .locals 0
    .param p1    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/games/Games$GamesOptions;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    .line 3
    invoke-direct {p0, p1, p2}, Lcom/google/android/gms/internal/games/zzt;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-void
.end method

.method constructor <init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V
    .locals 0
    .param p1    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/games/Games$GamesOptions;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    .line 1
    invoke-direct {p0, p1, p2}, Lcom/google/android/gms/internal/games/zzt;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-void
.end method


# virtual methods
.method public getCompareProfileIntent(Lcom/google/android/gms/games/Player;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/android/gms/games/Player;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/Player;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Landroid/content/Intent;",
            ">;"
        }
    .end annotation

    .line 20
    new-instance v0, Lcom/google/android/gms/games/zzav;

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/zzav;-><init>(Lcom/google/android/gms/games/PlayersClient;Lcom/google/android/gms/games/Player;)V

    invoke-virtual {p0, v0}, Lcom/google/android/gms/games/PlayersClient;->doRead(Lcom/google/android/gms/common/api/internal/TaskApiCall;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public getCurrentPlayer()Lcom/google/android/gms/tasks/Task;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/android/gms/games/Player;",
            ">;"
        }
    .end annotation

    .line 6
    new-instance v0, Lcom/google/android/gms/games/zzau;

    invoke-direct {v0, p0}, Lcom/google/android/gms/games/zzau;-><init>(Lcom/google/android/gms/games/PlayersClient;)V

    invoke-virtual {p0, v0}, Lcom/google/android/gms/games/PlayersClient;->doRead(Lcom/google/android/gms/common/api/internal/TaskApiCall;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0
.end method

.method public getCurrentPlayerId()Lcom/google/android/gms/tasks/Task;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 5
    new-instance v0, Lcom/google/android/gms/games/zzat;

    invoke-direct {v0, p0}, Lcom/google/android/gms/games/zzat;-><init>(Lcom/google/android/gms/games/PlayersClient;)V

    invoke-virtual {p0, v0}, Lcom/google/android/gms/games/PlayersClient;->doRead(Lcom/google/android/gms/common/api/internal/TaskApiCall;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0
.end method

.method public getPlayerSearchIntent()Lcom/google/android/gms/tasks/Task;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/android/gms/tasks/Task<",
            "Landroid/content/Intent;",
            ">;"
        }
    .end annotation

    .line 21
    new-instance v0, Lcom/google/android/gms/games/zzaw;

    invoke-direct {v0, p0}, Lcom/google/android/gms/games/zzaw;-><init>(Lcom/google/android/gms/games/PlayersClient;)V

    invoke-virtual {p0, v0}, Lcom/google/android/gms/games/PlayersClient;->doRead(Lcom/google/android/gms/common/api/internal/TaskApiCall;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0
.end method

.method public loadMoreRecentlyPlayedWithPlayers(I)Lcom/google/android/gms/tasks/Task;
    .locals 2
    .param p1    # I
        .annotation build Landroidx/annotation/IntRange;
            from = 0x1L
            to = 0x19L
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/android/gms/games/AnnotatedData<",
            "Lcom/google/android/gms/games/PlayerBuffer;",
            ">;>;"
        }
    .end annotation

    .line 16
    sget-object v0, Lcom/google/android/gms/games/Games;->Players:Lcom/google/android/gms/games/Players;

    .line 17
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayersClient;->asGoogleApiClient()Lcom/google/android/gms/common/api/GoogleApiClient;

    move-result-object v1

    invoke-interface {v0, v1, p1}, Lcom/google/android/gms/games/Players;->loadMoreRecentlyPlayedWithPlayers(Lcom/google/android/gms/common/api/GoogleApiClient;I)Lcom/google/android/gms/common/api/PendingResult;

    move-result-object p1

    .line 18
    sget-object v0, Lcom/google/android/gms/games/PlayersClient;->zzdb:Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;

    invoke-static {p1, v0}, Lcom/google/android/gms/games/internal/zzbe;->zzb(Lcom/google/android/gms/common/api/PendingResult;Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public loadPlayer(Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/android/gms/games/AnnotatedData<",
            "Lcom/google/android/gms/games/Player;",
            ">;>;"
        }
    .end annotation

    const/4 v0, 0x0

    .line 7
    invoke-virtual {p0, p1, v0}, Lcom/google/android/gms/games/PlayersClient;->loadPlayer(Ljava/lang/String;Z)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public loadPlayer(Ljava/lang/String;Z)Lcom/google/android/gms/tasks/Task;
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Z)",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/android/gms/games/AnnotatedData<",
            "Lcom/google/android/gms/games/Player;",
            ">;>;"
        }
    .end annotation

    .line 8
    sget-object v0, Lcom/google/android/gms/games/Games;->Players:Lcom/google/android/gms/games/Players;

    .line 9
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayersClient;->asGoogleApiClient()Lcom/google/android/gms/common/api/GoogleApiClient;

    move-result-object v1

    invoke-interface {v0, v1, p1, p2}, Lcom/google/android/gms/games/Players;->loadPlayer(Lcom/google/android/gms/common/api/GoogleApiClient;Ljava/lang/String;Z)Lcom/google/android/gms/common/api/PendingResult;

    move-result-object p1

    .line 10
    sget-object p2, Lcom/google/android/gms/games/PlayersClient;->zzdd:Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;

    sget-object v0, Lcom/google/android/gms/games/PlayersClient;->zzdc:Lcom/google/android/gms/games/internal/zzbm;

    invoke-static {p1, p2, v0}, Lcom/google/android/gms/games/internal/zzbe;->zza(Lcom/google/android/gms/common/api/PendingResult;Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;Lcom/google/android/gms/games/internal/zzbm;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public loadRecentlyPlayedWithPlayers(IZ)Lcom/google/android/gms/tasks/Task;
    .locals 2
    .param p1    # I
        .annotation build Landroidx/annotation/IntRange;
            from = 0x1L
            to = 0x19L
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(IZ)",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/android/gms/games/AnnotatedData<",
            "Lcom/google/android/gms/games/PlayerBuffer;",
            ">;>;"
        }
    .end annotation

    .line 12
    sget-object v0, Lcom/google/android/gms/games/Games;->Players:Lcom/google/android/gms/games/Players;

    .line 13
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayersClient;->asGoogleApiClient()Lcom/google/android/gms/common/api/GoogleApiClient;

    move-result-object v1

    invoke-interface {v0, v1, p1, p2}, Lcom/google/android/gms/games/Players;->loadRecentlyPlayedWithPlayers(Lcom/google/android/gms/common/api/GoogleApiClient;IZ)Lcom/google/android/gms/common/api/PendingResult;

    move-result-object p1

    .line 14
    sget-object p2, Lcom/google/android/gms/games/PlayersClient;->zzdb:Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;

    invoke-static {p1, p2}, Lcom/google/android/gms/games/internal/zzbe;->zzb(Lcom/google/android/gms/common/api/PendingResult;Lcom/google/android/gms/common/internal/PendingResultUtil$ResultConverter;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

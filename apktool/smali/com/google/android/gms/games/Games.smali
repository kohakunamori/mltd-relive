.class public final Lcom/google/android/gms/games/Games;
.super Ljava/lang/Object;


# annotations
.annotation build Lcom/google/android/gms/common/annotation/KeepForSdk;
.end annotation

.annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/android/gms/games/Games$zzd;,
        Lcom/google/android/gms/games/Games$zzc;,
        Lcom/google/android/gms/games/Games$GetServerAuthCodeResult;,
        Lcom/google/android/gms/games/Games$zza;,
        Lcom/google/android/gms/games/Games$zzb;,
        Lcom/google/android/gms/games/Games$GamesOptions;
    }
.end annotation


# static fields
.field public static final API:Lcom/google/android/gms/common/api/Api;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/api/Api<",
            "Lcom/google/android/gms/games/Games$GamesOptions;",
            ">;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final Achievements:Lcom/google/android/gms/games/achievement/Achievements;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field static final CLIENT_KEY:Lcom/google/android/gms/common/api/Api$ClientKey;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/api/Api$ClientKey<",
            "Lcom/google/android/gms/games/internal/zze;",
            ">;"
        }
    .end annotation
.end field

.field public static final EXTRA_PLAYER_IDS:Ljava/lang/String; = "players"

.field public static final EXTRA_STATUS:Ljava/lang/String; = "status"

.field public static final Events:Lcom/google/android/gms/games/event/Events;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final GamesMetadata:Lcom/google/android/gms/games/GamesMetadata;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final Invitations:Lcom/google/android/gms/games/multiplayer/Invitations;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final Leaderboards:Lcom/google/android/gms/games/leaderboard/Leaderboards;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final Notifications:Lcom/google/android/gms/games/Notifications;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final Players:Lcom/google/android/gms/games/Players;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final Quests:Lcom/google/android/gms/games/quest/Quests;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final RealTimeMultiplayer:Lcom/google/android/gms/games/multiplayer/realtime/RealTimeMultiplayer;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final Requests:Lcom/google/android/gms/games/request/Requests;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final SCOPE_GAMES:Lcom/google/android/gms/common/api/Scope;

.field public static final SCOPE_GAMES_LITE:Lcom/google/android/gms/common/api/Scope;

.field public static final Snapshots:Lcom/google/android/gms/games/snapshot/Snapshots;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final Stats:Lcom/google/android/gms/games/stats/Stats;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final TurnBasedMultiplayer:Lcom/google/android/gms/games/multiplayer/turnbased/TurnBasedMultiplayer;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final Videos:Lcom/google/android/gms/games/video/Videos;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field private static final zzak:Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/api/Api$AbstractClientBuilder<",
            "Lcom/google/android/gms/games/internal/zze;",
            "Lcom/google/android/gms/games/Games$GamesOptions;",
            ">;"
        }
    .end annotation
.end field

.field private static final zzal:Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/api/Api$AbstractClientBuilder<",
            "Lcom/google/android/gms/games/internal/zze;",
            "Lcom/google/android/gms/games/Games$GamesOptions;",
            ">;"
        }
    .end annotation
.end field

.field public static final zzam:Lcom/google/android/gms/common/api/Scope;
    .annotation build Lcom/google/android/gms/common/internal/ShowFirstParty;
    .end annotation
.end field

.field private static final zzan:Lcom/google/android/gms/common/api/Api;
    .annotation build Lcom/google/android/gms/common/internal/ShowFirstParty;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/android/gms/common/api/Api<",
            "Lcom/google/android/gms/games/Games$GamesOptions;",
            ">;"
        }
    .end annotation
.end field

.field private static final zzao:Lcom/google/android/gms/games/appcontent/zzm;

.field private static final zzap:Lcom/google/android/gms/games/multiplayer/Multiplayer;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 97
    new-instance v0, Lcom/google/android/gms/common/api/Api$ClientKey;

    invoke-direct {v0}, Lcom/google/android/gms/common/api/Api$ClientKey;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->CLIENT_KEY:Lcom/google/android/gms/common/api/Api$ClientKey;

    .line 98
    new-instance v0, Lcom/google/android/gms/games/zzi;

    invoke-direct {v0}, Lcom/google/android/gms/games/zzi;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->zzak:Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;

    .line 99
    new-instance v0, Lcom/google/android/gms/games/zzj;

    invoke-direct {v0}, Lcom/google/android/gms/games/zzj;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->zzal:Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;

    .line 100
    new-instance v0, Lcom/google/android/gms/common/api/Scope;

    const-string v1, "https://www.googleapis.com/auth/games"

    invoke-direct {v0, v1}, Lcom/google/android/gms/common/api/Scope;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/google/android/gms/games/Games;->SCOPE_GAMES:Lcom/google/android/gms/common/api/Scope;

    .line 101
    new-instance v0, Lcom/google/android/gms/common/api/Scope;

    const-string v1, "https://www.googleapis.com/auth/games_lite"

    invoke-direct {v0, v1}, Lcom/google/android/gms/common/api/Scope;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/google/android/gms/games/Games;->SCOPE_GAMES_LITE:Lcom/google/android/gms/common/api/Scope;

    .line 102
    new-instance v0, Lcom/google/android/gms/common/api/Api;

    const-string v1, "Games.API"

    sget-object v2, Lcom/google/android/gms/games/Games;->zzak:Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;

    sget-object v3, Lcom/google/android/gms/games/Games;->CLIENT_KEY:Lcom/google/android/gms/common/api/Api$ClientKey;

    invoke-direct {v0, v1, v2, v3}, Lcom/google/android/gms/common/api/Api;-><init>(Ljava/lang/String;Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;Lcom/google/android/gms/common/api/Api$ClientKey;)V

    sput-object v0, Lcom/google/android/gms/games/Games;->API:Lcom/google/android/gms/common/api/Api;

    .line 103
    new-instance v0, Lcom/google/android/gms/common/api/Scope;

    const-string v1, "https://www.googleapis.com/auth/games.firstparty"

    invoke-direct {v0, v1}, Lcom/google/android/gms/common/api/Scope;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/google/android/gms/games/Games;->zzam:Lcom/google/android/gms/common/api/Scope;

    .line 104
    new-instance v0, Lcom/google/android/gms/common/api/Api;

    const-string v1, "Games.API_1P"

    sget-object v2, Lcom/google/android/gms/games/Games;->zzal:Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;

    sget-object v3, Lcom/google/android/gms/games/Games;->CLIENT_KEY:Lcom/google/android/gms/common/api/Api$ClientKey;

    invoke-direct {v0, v1, v2, v3}, Lcom/google/android/gms/common/api/Api;-><init>(Ljava/lang/String;Lcom/google/android/gms/common/api/Api$AbstractClientBuilder;Lcom/google/android/gms/common/api/Api$ClientKey;)V

    sput-object v0, Lcom/google/android/gms/games/Games;->zzan:Lcom/google/android/gms/common/api/Api;

    .line 105
    new-instance v0, Lcom/google/android/gms/internal/games/zzac;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzac;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->GamesMetadata:Lcom/google/android/gms/games/GamesMetadata;

    .line 106
    new-instance v0, Lcom/google/android/gms/internal/games/zze;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zze;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->Achievements:Lcom/google/android/gms/games/achievement/Achievements;

    .line 107
    new-instance v0, Lcom/google/android/gms/internal/games/zzs;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzs;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->zzao:Lcom/google/android/gms/games/appcontent/zzm;

    .line 108
    new-instance v0, Lcom/google/android/gms/internal/games/zzu;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzu;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->Events:Lcom/google/android/gms/games/event/Events;

    .line 109
    new-instance v0, Lcom/google/android/gms/internal/games/zzal;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzal;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->Leaderboards:Lcom/google/android/gms/games/leaderboard/Leaderboards;

    .line 110
    new-instance v0, Lcom/google/android/gms/internal/games/zzah;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzah;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->Invitations:Lcom/google/android/gms/games/multiplayer/Invitations;

    .line 111
    new-instance v0, Lcom/google/android/gms/internal/games/zzcz;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzcz;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->TurnBasedMultiplayer:Lcom/google/android/gms/games/multiplayer/turnbased/TurnBasedMultiplayer;

    .line 112
    new-instance v0, Lcom/google/android/gms/internal/games/zzby;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzby;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->RealTimeMultiplayer:Lcom/google/android/gms/games/multiplayer/realtime/RealTimeMultiplayer;

    .line 113
    new-instance v0, Lcom/google/android/gms/internal/games/zzbb;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzbb;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->zzap:Lcom/google/android/gms/games/multiplayer/Multiplayer;

    .line 114
    new-instance v0, Lcom/google/android/gms/internal/games/zzbd;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzbd;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->Players:Lcom/google/android/gms/games/Players;

    .line 115
    new-instance v0, Lcom/google/android/gms/internal/games/zzbc;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzbc;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->Notifications:Lcom/google/android/gms/games/Notifications;

    .line 116
    new-instance v0, Lcom/google/android/gms/internal/games/zzbn;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzbn;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->Quests:Lcom/google/android/gms/games/quest/Quests;

    .line 117
    new-instance v0, Lcom/google/android/gms/internal/games/zzbz;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzbz;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->Requests:Lcom/google/android/gms/games/request/Requests;

    .line 118
    new-instance v0, Lcom/google/android/gms/internal/games/zzch;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzch;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->Snapshots:Lcom/google/android/gms/games/snapshot/Snapshots;

    .line 119
    new-instance v0, Lcom/google/android/gms/internal/games/zzcv;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzcv;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->Stats:Lcom/google/android/gms/games/stats/Stats;

    .line 120
    new-instance v0, Lcom/google/android/gms/internal/games/zzdw;

    invoke-direct {v0}, Lcom/google/android/gms/internal/games/zzdw;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/Games;->Videos:Lcom/google/android/gms/games/video/Videos;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getAchievementsClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/AchievementsClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 46
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 47
    new-instance v0, Lcom/google/android/gms/games/AchievementsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/AchievementsClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getAchievementsClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/AchievementsClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 48
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 49
    new-instance v0, Lcom/google/android/gms/games/AchievementsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/AchievementsClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getAppId(Lcom/google/android/gms/common/api/GoogleApiClient;)Ljava/lang/String;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const/4 v0, 0x1

    .line 28
    invoke-static {p0, v0}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/common/api/GoogleApiClient;Z)Lcom/google/android/gms/games/internal/zze;

    move-result-object p0

    .line 29
    invoke-virtual {p0}, Lcom/google/android/gms/games/internal/zze;->zzbs()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static getCurrentAccountName(Lcom/google/android/gms/common/api/GoogleApiClient;)Ljava/lang/String;
    .locals 1
    .annotation build Landroidx/annotation/RequiresPermission;
        value = "android.permission.GET_ACCOUNTS"
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const/4 v0, 0x1

    .line 23
    invoke-static {p0, v0}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/common/api/GoogleApiClient;Z)Lcom/google/android/gms/games/internal/zze;

    move-result-object p0

    .line 24
    invoke-virtual {p0}, Lcom/google/android/gms/games/internal/zze;->zzav()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static getEventsClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/EventsClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 50
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 51
    new-instance v0, Lcom/google/android/gms/games/EventsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/EventsClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getEventsClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/EventsClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 52
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 53
    new-instance v0, Lcom/google/android/gms/games/EventsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/EventsClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getGamesClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/GamesClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 90
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 91
    new-instance v0, Lcom/google/android/gms/games/GamesClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/GamesClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getGamesClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/GamesClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 92
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 93
    new-instance v0, Lcom/google/android/gms/games/GamesClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/GamesClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getGamesMetadataClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/GamesMetadataClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 42
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 43
    new-instance v0, Lcom/google/android/gms/games/GamesMetadataClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/GamesMetadataClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getGamesMetadataClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/GamesMetadataClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 44
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 45
    new-instance v0, Lcom/google/android/gms/games/GamesMetadataClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/GamesMetadataClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getGamesServerAuthCode(Lcom/google/android/gms/common/api/GoogleApiClient;Ljava/lang/String;)Lcom/google/android/gms/common/api/PendingResult;
    .locals 1
    .annotation build Lcom/google/android/gms/common/annotation/KeepForSdk;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/common/api/GoogleApiClient;",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/android/gms/common/api/PendingResult<",
            "Lcom/google/android/gms/games/Games$GetServerAuthCodeResult;",
            ">;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const-string v0, "Please provide a valid serverClientId"

    .line 25
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    .line 26
    new-instance v0, Lcom/google/android/gms/games/zzk;

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/zzk;-><init>(Lcom/google/android/gms/common/api/GoogleApiClient;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/google/android/gms/common/api/GoogleApiClient;->execute(Lcom/google/android/gms/common/api/internal/BaseImplementation$ApiMethodImpl;)Lcom/google/android/gms/common/api/internal/BaseImplementation$ApiMethodImpl;

    move-result-object p0

    return-object p0
.end method

.method public static getInvitationsClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/InvitationsClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 58
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 59
    new-instance v0, Lcom/google/android/gms/games/InvitationsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/InvitationsClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getInvitationsClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/InvitationsClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 60
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 61
    new-instance v0, Lcom/google/android/gms/games/InvitationsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/InvitationsClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getLeaderboardsClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/LeaderboardsClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 54
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 55
    new-instance v0, Lcom/google/android/gms/games/LeaderboardsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/LeaderboardsClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getLeaderboardsClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/LeaderboardsClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 56
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 57
    new-instance v0, Lcom/google/android/gms/games/LeaderboardsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/LeaderboardsClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getNotificationsClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/NotificationsClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 74
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 75
    new-instance v0, Lcom/google/android/gms/games/NotificationsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/NotificationsClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getNotificationsClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/NotificationsClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 76
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 77
    new-instance v0, Lcom/google/android/gms/games/NotificationsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/NotificationsClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getPlayerStatsClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/PlayerStatsClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 82
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 83
    new-instance v0, Lcom/google/android/gms/games/PlayerStatsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/PlayerStatsClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getPlayerStatsClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/PlayerStatsClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 84
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 85
    new-instance v0, Lcom/google/android/gms/games/PlayerStatsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/PlayerStatsClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getPlayersClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/PlayersClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 70
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 71
    new-instance v0, Lcom/google/android/gms/games/PlayersClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/PlayersClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getPlayersClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/PlayersClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 72
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 73
    new-instance v0, Lcom/google/android/gms/games/PlayersClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/PlayersClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getRealTimeMultiplayerClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/RealTimeMultiplayerClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 66
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 67
    new-instance v0, Lcom/google/android/gms/games/RealTimeMultiplayerClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/RealTimeMultiplayerClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getRealTimeMultiplayerClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/RealTimeMultiplayerClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 68
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 69
    new-instance v0, Lcom/google/android/gms/games/RealTimeMultiplayerClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/RealTimeMultiplayerClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getSdkVariant(Lcom/google/android/gms/common/api/GoogleApiClient;)I
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const/4 v0, 0x1

    .line 95
    invoke-static {p0, v0}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/common/api/GoogleApiClient;Z)Lcom/google/android/gms/games/internal/zze;

    move-result-object p0

    .line 96
    invoke-virtual {p0}, Lcom/google/android/gms/games/internal/zze;->zzbq()I

    move-result p0

    return p0
.end method

.method public static getSettingsIntent(Lcom/google/android/gms/common/api/GoogleApiClient;)Landroid/content/Intent;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const/4 v0, 0x1

    .line 31
    invoke-static {p0, v0}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/common/api/GoogleApiClient;Z)Lcom/google/android/gms/games/internal/zze;

    move-result-object p0

    .line 32
    invoke-virtual {p0}, Lcom/google/android/gms/games/internal/zze;->zzbo()Landroid/content/Intent;

    move-result-object p0

    return-object p0
.end method

.method public static getSnapshotsClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/SnapshotsClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 78
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 79
    new-instance v0, Lcom/google/android/gms/games/SnapshotsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/SnapshotsClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getSnapshotsClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/SnapshotsClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 80
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 81
    new-instance v0, Lcom/google/android/gms/games/SnapshotsClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/SnapshotsClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getTurnBasedMultiplayerClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/TurnBasedMultiplayerClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 62
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 63
    new-instance v0, Lcom/google/android/gms/games/TurnBasedMultiplayerClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/TurnBasedMultiplayerClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getTurnBasedMultiplayerClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/TurnBasedMultiplayerClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 64
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 65
    new-instance v0, Lcom/google/android/gms/games/TurnBasedMultiplayerClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/TurnBasedMultiplayerClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getVideosClient(Landroid/app/Activity;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/VideosClient;
    .locals 1
    .param p0    # Landroid/app/Activity;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 86
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 87
    new-instance v0, Lcom/google/android/gms/games/VideosClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/VideosClient;-><init>(Landroid/app/Activity;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static getVideosClient(Landroid/content/Context;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/VideosClient;
    .locals 1
    .param p0    # Landroid/content/Context;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    const-string v0, "GoogleSignInAccount must not be null"

    .line 88
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 89
    new-instance v0, Lcom/google/android/gms/games/VideosClient;

    invoke-static {p1}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/games/VideosClient;-><init>(Landroid/content/Context;Lcom/google/android/gms/games/Games$GamesOptions;)V

    return-object v0
.end method

.method public static setGravityForPopups(Lcom/google/android/gms/common/api/GoogleApiClient;I)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const/4 v0, 0x0

    .line 13
    invoke-static {p0, v0}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/common/api/GoogleApiClient;Z)Lcom/google/android/gms/games/internal/zze;

    move-result-object p0

    if-eqz p0, :cond_0

    .line 15
    invoke-virtual {p0, p1}, Lcom/google/android/gms/games/internal/zze;->zzk(I)V

    :cond_0
    return-void
.end method

.method public static setViewForPopups(Lcom/google/android/gms/common/api/GoogleApiClient;Landroid/view/View;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 17
    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v0, 0x0

    .line 18
    invoke-static {p0, v0}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/common/api/GoogleApiClient;Z)Lcom/google/android/gms/games/internal/zze;

    move-result-object p0

    if-eqz p0, :cond_0

    .line 20
    invoke-virtual {p0, p1}, Lcom/google/android/gms/games/internal/zze;->zza(Landroid/view/View;)V

    :cond_0
    return-void
.end method

.method public static signOut(Lcom/google/android/gms/common/api/GoogleApiClient;)Lcom/google/android/gms/common/api/PendingResult;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/common/api/GoogleApiClient;",
            ")",
            "Lcom/google/android/gms/common/api/PendingResult<",
            "Lcom/google/android/gms/common/api/Status;",
            ">;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 33
    new-instance v0, Lcom/google/android/gms/games/zzl;

    invoke-direct {v0, p0}, Lcom/google/android/gms/games/zzl;-><init>(Lcom/google/android/gms/common/api/GoogleApiClient;)V

    invoke-virtual {p0, v0}, Lcom/google/android/gms/common/api/GoogleApiClient;->execute(Lcom/google/android/gms/common/api/internal/BaseImplementation$ApiMethodImpl;)Lcom/google/android/gms/common/api/internal/BaseImplementation$ApiMethodImpl;

    move-result-object p0

    return-object p0
.end method

.method private static zza(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)Lcom/google/android/gms/games/Games$GamesOptions;
    .locals 2
    .param p0    # Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    .line 35
    new-instance v0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, v1, v1}, Lcom/google/android/gms/games/Games$GamesOptions$Builder;-><init>(Lcom/google/android/gms/games/Games$GamesOptions;Lcom/google/android/gms/games/zzi;)V

    .line 36
    iput-object p0, v0, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->zzbb:Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    const p0, 0x101113

    .line 39
    invoke-virtual {v0, p0}, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->setSdkVariant(I)Lcom/google/android/gms/games/Games$GamesOptions$Builder;

    move-result-object p0

    .line 40
    invoke-virtual {p0}, Lcom/google/android/gms/games/Games$GamesOptions$Builder;->build()Lcom/google/android/gms/games/Games$GamesOptions;

    move-result-object p0

    return-object p0
.end method

.method public static zza(Lcom/google/android/gms/common/api/GoogleApiClient;)Lcom/google/android/gms/games/internal/zze;
    .locals 1

    const/4 v0, 0x1

    .line 2
    invoke-static {p0, v0}, Lcom/google/android/gms/games/Games;->zza(Lcom/google/android/gms/common/api/GoogleApiClient;Z)Lcom/google/android/gms/games/internal/zze;

    move-result-object p0

    return-object p0
.end method

.method public static zza(Lcom/google/android/gms/common/api/GoogleApiClient;Z)Lcom/google/android/gms/games/internal/zze;
    .locals 2

    if-eqz p0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    const-string v1, "GoogleApiClient parameter is required."

    .line 3
    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkArgument(ZLjava/lang/Object;)V

    .line 4
    invoke-virtual {p0}, Lcom/google/android/gms/common/api/GoogleApiClient;->isConnected()Z

    move-result v0

    const-string v1, "GoogleApiClient must be connected."

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    .line 5
    invoke-static {p0, p1}, Lcom/google/android/gms/games/Games;->zzb(Lcom/google/android/gms/common/api/GoogleApiClient;Z)Lcom/google/android/gms/games/internal/zze;

    move-result-object p0

    return-object p0
.end method

.method public static zzb(Lcom/google/android/gms/common/api/GoogleApiClient;Z)Lcom/google/android/gms/games/internal/zze;
    .locals 2

    .line 6
    sget-object v0, Lcom/google/android/gms/games/Games;->API:Lcom/google/android/gms/common/api/Api;

    .line 7
    invoke-virtual {p0, v0}, Lcom/google/android/gms/common/api/GoogleApiClient;->hasApi(Lcom/google/android/gms/common/api/Api;)Z

    move-result v0

    const-string v1, "GoogleApiClient is not configured to use the Games Api. Pass Games.API into GoogleApiClient.Builder#addApi() to use this feature."

    .line 8
    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    .line 9
    sget-object v0, Lcom/google/android/gms/games/Games;->API:Lcom/google/android/gms/common/api/Api;

    invoke-virtual {p0, v0}, Lcom/google/android/gms/common/api/GoogleApiClient;->hasConnectedApi(Lcom/google/android/gms/common/api/Api;)Z

    move-result v0

    if-eqz p1, :cond_1

    if-eqz v0, :cond_0

    goto :goto_0

    .line 11
    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "GoogleApiClient has an optional Games.API and is not connected to Games. Use GoogleApiClient.hasConnectedApi(Games.API) to guard this call."

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_1
    :goto_0
    if-eqz v0, :cond_2

    .line 12
    sget-object p1, Lcom/google/android/gms/games/Games;->CLIENT_KEY:Lcom/google/android/gms/common/api/Api$ClientKey;

    invoke-virtual {p0, p1}, Lcom/google/android/gms/common/api/GoogleApiClient;->getClient(Lcom/google/android/gms/common/api/Api$AnyClientKey;)Lcom/google/android/gms/common/api/Api$Client;

    move-result-object p0

    check-cast p0, Lcom/google/android/gms/games/internal/zze;

    return-object p0

    :cond_2
    const/4 p0, 0x0

    return-object p0
.end method

.class public final Lcom/google/android/gms/games/multiplayer/turnbased/zzb;
.super Lcom/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchConfig;


# instance fields
.field private final zzpd:I

.field private final zzpz:Landroid/os/Bundle;

.field private final zzqb:[Ljava/lang/String;

.field private final zzql:I


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchConfig$Builder;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchConfig;-><init>()V

    .line 2
    iget v0, p1, Lcom/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchConfig$Builder;->zzpd:I

    iput v0, p0, Lcom/google/android/gms/games/multiplayer/turnbased/zzb;->zzpd:I

    .line 3
    iget v0, p1, Lcom/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchConfig$Builder;->zzql:I

    iput v0, p0, Lcom/google/android/gms/games/multiplayer/turnbased/zzb;->zzql:I

    .line 4
    iget-object v0, p1, Lcom/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchConfig$Builder;->zzpz:Landroid/os/Bundle;

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/turnbased/zzb;->zzpz:Landroid/os/Bundle;

    .line 5
    iget-object v0, p1, Lcom/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchConfig$Builder;->zzpy:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    .line 6
    iget-object p1, p1, Lcom/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchConfig$Builder;->zzpy:Ljava/util/ArrayList;

    new-array v0, v0, [Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/String;

    iput-object p1, p0, Lcom/google/android/gms/games/multiplayer/turnbased/zzb;->zzqb:[Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final getAutoMatchCriteria()Landroid/os/Bundle;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/turnbased/zzb;->zzpz:Landroid/os/Bundle;

    return-object v0
.end method

.method public final getInvitedPlayerIds()[Ljava/lang/String;
    .locals 1

    .line 10
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/turnbased/zzb;->zzqb:[Ljava/lang/String;

    return-object v0
.end method

.method public final getVariant()I
    .locals 1

    .line 8
    iget v0, p0, Lcom/google/android/gms/games/multiplayer/turnbased/zzb;->zzpd:I

    return v0
.end method

.method public final zzdp()I
    .locals 1

    .line 9
    iget v0, p0, Lcom/google/android/gms/games/multiplayer/turnbased/zzb;->zzql:I

    return v0
.end method

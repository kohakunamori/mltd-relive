.class public final Lcom/google/android/gms/games/multiplayer/realtime/zzd;
.super Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig;


# instance fields
.field private final zzoy:Ljava/lang/String;

.field private final zzpd:I

.field private final zzpr:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateListener;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field private final zzps:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateListener;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field private final zzpt:Lcom/google/android/gms/games/multiplayer/realtime/RealTimeMessageReceivedListener;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field private final zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

.field private final zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

.field private final zzpw:Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;

.field private final zzpz:Landroid/os/Bundle;

.field private final zzqa:Lcom/google/android/gms/games/multiplayer/realtime/zzg;

.field private final zzqb:[Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;)V
    .locals 4

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig;-><init>()V

    .line 2
    iget-object v0, p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;->zzpr:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateListener;

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpr:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateListener;

    .line 3
    iget-object v0, p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;->zzps:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateListener;

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzps:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateListener;

    .line 4
    iget-object v0, p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;->zzpt:Lcom/google/android/gms/games/multiplayer/realtime/RealTimeMessageReceivedListener;

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpt:Lcom/google/android/gms/games/multiplayer/realtime/RealTimeMessageReceivedListener;

    .line 5
    iget-object v0, p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    .line 6
    iget-object v0, p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    .line 7
    iget-object v0, p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;->zzpw:Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpw:Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;

    .line 8
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 9
    new-instance v0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;

    iget-object v1, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    iget-object v2, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    iget-object v3, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpw:Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;

    invoke-direct {v0, v1, v2, v3}, Lcom/google/android/gms/games/multiplayer/realtime/zzg;-><init>(Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;)V

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzqa:Lcom/google/android/gms/games/multiplayer/realtime/zzg;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 10
    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzqa:Lcom/google/android/gms/games/multiplayer/realtime/zzg;

    .line 11
    :goto_0
    iget-object v0, p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;->zzpx:Ljava/lang/String;

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzoy:Ljava/lang/String;

    .line 12
    iget v0, p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;->zzpd:I

    iput v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpd:I

    .line 13
    iget-object v0, p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;->zzpz:Landroid/os/Bundle;

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpz:Landroid/os/Bundle;

    .line 14
    iget-object v0, p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;->zzpy:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    .line 15
    iget-object p1, p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder;->zzpy:Ljava/util/ArrayList;

    new-array v0, v0, [Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/String;

    iput-object p1, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzqb:[Ljava/lang/String;

    .line 16
    iget-object p1, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpw:Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpt:Lcom/google/android/gms/games/multiplayer/realtime/RealTimeMessageReceivedListener;

    if-eqz p1, :cond_1

    goto :goto_1

    .line 17
    :cond_1
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Must specify a message listener"

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_2
    :goto_1
    return-void
.end method


# virtual methods
.method public final getAutoMatchCriteria()Landroid/os/Bundle;
    .locals 1

    .line 29
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpz:Landroid/os/Bundle;

    return-object v0
.end method

.method public final getInvitationId()Ljava/lang/String;
    .locals 1

    .line 22
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzoy:Ljava/lang/String;

    return-object v0
.end method

.method public final getInvitedPlayerIds()[Ljava/lang/String;
    .locals 1

    .line 28
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzqb:[Ljava/lang/String;

    return-object v0
.end method

.method public final getMessageReceivedListener()Lcom/google/android/gms/games/multiplayer/realtime/RealTimeMessageReceivedListener;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 25
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpt:Lcom/google/android/gms/games/multiplayer/realtime/RealTimeMessageReceivedListener;

    return-object v0
.end method

.method public final getOnMessageReceivedListener()Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 26
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpw:Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;

    return-object v0
.end method

.method public final getRoomStatusUpdateCallback()Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 24
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    return-object v0
.end method

.method public final getRoomStatusUpdateListener()Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateListener;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 23
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzps:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateListener;

    return-object v0
.end method

.method public final getRoomUpdateCallback()Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 21
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    return-object v0
.end method

.method public final getRoomUpdateListener()Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateListener;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 20
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpr:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateListener;

    return-object v0
.end method

.method public final getVariant()I
    .locals 1

    .line 27
    iget v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzpd:I

    return v0
.end method

.method public final zzdo()Lcom/google/android/gms/games/multiplayer/realtime/zzh;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzd;->zzqa:Lcom/google/android/gms/games/multiplayer/realtime/zzg;

    return-object v0
.end method

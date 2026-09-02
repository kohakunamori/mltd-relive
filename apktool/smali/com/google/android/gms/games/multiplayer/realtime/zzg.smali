.class public final Lcom/google/android/gms/games/multiplayer/realtime/zzg;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/games/multiplayer/realtime/zzh;


# instance fields
.field private final zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

.field private final zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

.field private final zzqg:Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;


# direct methods
.method public constructor <init>(Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;)V
    .locals 0
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param
    .param p3    # Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    iput-object p1, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    .line 3
    iput-object p2, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    .line 4
    iput-object p3, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzqg:Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;

    return-void
.end method


# virtual methods
.method public final onConnectedToRoom(Lcom/google/android/gms/games/multiplayer/realtime/Room;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 27
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 28
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onConnectedToRoom(Lcom/google/android/gms/games/multiplayer/realtime/Room;)V

    :cond_0
    return-void
.end method

.method public final onDisconnectedFromRoom(Lcom/google/android/gms/games/multiplayer/realtime/Room;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 30
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 31
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onDisconnectedFromRoom(Lcom/google/android/gms/games/multiplayer/realtime/Room;)V

    :cond_0
    return-void
.end method

.method public final onJoinedRoom(ILcom/google/android/gms/games/multiplayer/realtime/Room;)V
    .locals 1
    .param p2    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 48
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    if-eqz v0, :cond_0

    .line 49
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;->onJoinedRoom(ILcom/google/android/gms/games/multiplayer/realtime/Room;)V

    :cond_0
    return-void
.end method

.method public final onLeftRoom(ILjava/lang/String;)V
    .locals 1
    .param p2    # Ljava/lang/String;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    .line 51
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    if-eqz v0, :cond_0

    .line 52
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;->onLeftRoom(ILjava/lang/String;)V

    :cond_0
    return-void
.end method

.method public final onP2PConnected(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    .line 39
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 40
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onP2PConnected(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public final onP2PDisconnected(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    .line 42
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 43
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onP2PDisconnected(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public final onPeerDeclined(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # Ljava/util/List;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/multiplayer/realtime/Room;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 18
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 19
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onPeerDeclined(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V

    :cond_0
    return-void
.end method

.method public final onPeerInvitedToRoom(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # Ljava/util/List;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/multiplayer/realtime/Room;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 15
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 16
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onPeerInvitedToRoom(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V

    :cond_0
    return-void
.end method

.method public final onPeerJoined(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # Ljava/util/List;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/multiplayer/realtime/Room;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 21
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 22
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onPeerJoined(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V

    :cond_0
    return-void
.end method

.method public final onPeerLeft(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # Ljava/util/List;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/multiplayer/realtime/Room;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 24
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 25
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onPeerLeft(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V

    :cond_0
    return-void
.end method

.method public final onPeersConnected(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # Ljava/util/List;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/multiplayer/realtime/Room;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 33
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 34
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onPeersConnected(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V

    :cond_0
    return-void
.end method

.method public final onPeersDisconnected(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # Ljava/util/List;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/multiplayer/realtime/Room;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 36
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 37
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onPeersDisconnected(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V

    :cond_0
    return-void
.end method

.method public final onRealTimeMessageReceived(Lcom/google/android/gms/games/multiplayer/realtime/RealTimeMessage;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/RealTimeMessage;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    .line 6
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzqg:Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;

    if-eqz v0, :cond_0

    .line 7
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzqg:Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;

    invoke-interface {v0, p1}, Lcom/google/android/gms/games/multiplayer/realtime/OnRealTimeMessageReceivedListener;->onRealTimeMessageReceived(Lcom/google/android/gms/games/multiplayer/realtime/RealTimeMessage;)V

    :cond_0
    return-void
.end method

.method public final onRoomAutoMatching(Lcom/google/android/gms/games/multiplayer/realtime/Room;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 12
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 13
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onRoomAutoMatching(Lcom/google/android/gms/games/multiplayer/realtime/Room;)V

    :cond_0
    return-void
.end method

.method public final onRoomConnected(ILcom/google/android/gms/games/multiplayer/realtime/Room;)V
    .locals 1
    .param p2    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 54
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    if-eqz v0, :cond_0

    .line 55
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;->onRoomConnected(ILcom/google/android/gms/games/multiplayer/realtime/Room;)V

    :cond_0
    return-void
.end method

.method public final onRoomConnecting(Lcom/google/android/gms/games/multiplayer/realtime/Room;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 9
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    if-eqz v0, :cond_0

    .line 10
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpv:Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateCallback;->onRoomConnecting(Lcom/google/android/gms/games/multiplayer/realtime/Room;)V

    :cond_0
    return-void
.end method

.method public final onRoomCreated(ILcom/google/android/gms/games/multiplayer/realtime/Room;)V
    .locals 1
    .param p2    # Lcom/google/android/gms/games/multiplayer/realtime/Room;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    .line 45
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    if-eqz v0, :cond_0

    .line 46
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/realtime/zzg;->zzpu:Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateCallback;->onRoomCreated(ILcom/google/android/gms/games/multiplayer/realtime/Room;)V

    :cond_0
    return-void
.end method

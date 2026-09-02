package com.google.android.gms.games.multiplayer.realtime;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class zzg implements zzh {
    private final RoomUpdateCallback zzpu;
    private final RoomStatusUpdateCallback zzpv;
    private final OnRealTimeMessageReceivedListener zzqg;

    public zzg(@NonNull RoomUpdateCallback roomUpdateCallback, @Nullable RoomStatusUpdateCallback roomStatusUpdateCallback, @Nullable OnRealTimeMessageReceivedListener onRealTimeMessageReceivedListener) {
        this.zzpu = roomUpdateCallback;
        this.zzpv = roomStatusUpdateCallback;
        this.zzqg = onRealTimeMessageReceivedListener;
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.OnRealTimeMessageReceivedListener, com.google.android.gms.games.multiplayer.realtime.RealTimeMessageReceivedListener
    public final void onRealTimeMessageReceived(@NonNull RealTimeMessage realTimeMessage) {
        if (this.zzqg != null) {
            this.zzqg.onRealTimeMessageReceived(realTimeMessage);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onRoomConnecting(@Nullable Room room) {
        if (this.zzpv != null) {
            this.zzpv.onRoomConnecting(room);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onRoomAutoMatching(@Nullable Room room) {
        if (this.zzpv != null) {
            this.zzpv.onRoomAutoMatching(room);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onPeerInvitedToRoom(@Nullable Room room, @NonNull List<String> list) {
        if (this.zzpv != null) {
            this.zzpv.onPeerInvitedToRoom(room, list);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onPeerDeclined(@Nullable Room room, @NonNull List<String> list) {
        if (this.zzpv != null) {
            this.zzpv.onPeerDeclined(room, list);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onPeerJoined(@Nullable Room room, @NonNull List<String> list) {
        if (this.zzpv != null) {
            this.zzpv.onPeerJoined(room, list);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onPeerLeft(@Nullable Room room, @NonNull List<String> list) {
        if (this.zzpv != null) {
            this.zzpv.onPeerLeft(room, list);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onConnectedToRoom(@Nullable Room room) {
        if (this.zzpv != null) {
            this.zzpv.onConnectedToRoom(room);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onDisconnectedFromRoom(@Nullable Room room) {
        if (this.zzpv != null) {
            this.zzpv.onDisconnectedFromRoom(room);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onPeersConnected(@Nullable Room room, @NonNull List<String> list) {
        if (this.zzpv != null) {
            this.zzpv.onPeersConnected(room, list);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onPeersDisconnected(@Nullable Room room, @NonNull List<String> list) {
        if (this.zzpv != null) {
            this.zzpv.onPeersDisconnected(room, list);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onP2PConnected(@NonNull String str) {
        if (this.zzpv != null) {
            this.zzpv.onP2PConnected(str);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public final void onP2PDisconnected(@NonNull String str) {
        if (this.zzpv != null) {
            this.zzpv.onP2PDisconnected(str);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener
    public final void onRoomCreated(int i, @Nullable Room room) {
        if (this.zzpu != null) {
            this.zzpu.onRoomCreated(i, room);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener
    public final void onJoinedRoom(int i, @Nullable Room room) {
        if (this.zzpu != null) {
            this.zzpu.onJoinedRoom(i, room);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener
    public final void onLeftRoom(int i, @NonNull String str) {
        if (this.zzpu != null) {
            this.zzpu.onLeftRoom(i, str);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener
    public final void onRoomConnected(int i, @Nullable Room room) {
        if (this.zzpu != null) {
            this.zzpu.onRoomConnected(i, room);
        }
    }
}

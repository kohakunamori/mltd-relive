package com.google.android.gms.games.multiplayer.realtime;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class RoomStatusUpdateCallback implements RoomStatusUpdateListener {
    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onConnectedToRoom(@Nullable Room room);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onDisconnectedFromRoom(@Nullable Room room);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onP2PConnected(@NonNull String str);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onP2PDisconnected(@NonNull String str);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onPeerDeclined(@Nullable Room room, @NonNull List<String> list);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onPeerInvitedToRoom(@Nullable Room room, @NonNull List<String> list);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onPeerJoined(@Nullable Room room, @NonNull List<String> list);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onPeerLeft(@Nullable Room room, @NonNull List<String> list);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onPeersConnected(@Nullable Room room, @NonNull List<String> list);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onPeersDisconnected(@Nullable Room room, @NonNull List<String> list);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onRoomAutoMatching(@Nullable Room room);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
    public abstract void onRoomConnecting(@Nullable Room room);
}

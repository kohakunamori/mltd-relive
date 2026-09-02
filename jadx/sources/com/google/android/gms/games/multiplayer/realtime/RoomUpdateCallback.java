package com.google.android.gms.games.multiplayer.realtime;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

/* JADX INFO: loaded from: classes.dex */
public abstract class RoomUpdateCallback implements RoomUpdateListener {
    @Override // com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener
    public abstract void onJoinedRoom(int i, @Nullable Room room);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener
    public abstract void onLeftRoom(int i, @NonNull String str);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener
    public abstract void onRoomConnected(int i, @Nullable Room room);

    @Override // com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener
    public abstract void onRoomCreated(int i, @Nullable Room room);
}

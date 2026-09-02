package com.google.android.gms.games.internal;

import com.google.android.gms.games.multiplayer.realtime.Room;
import com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener;

/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzan implements zze.zzaz {
    static final zze.zzaz zziw = new zzan();

    private zzan() {
    }

    @Override // com.google.android.gms.games.internal.zze.zzaz
    public final void zza(Object obj, int i, Room room) {
        ((RoomUpdateListener) obj).onJoinedRoom(i, room);
    }
}

package com.google.android.gms.games.internal;

import com.google.android.gms.games.multiplayer.realtime.Room;
import com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener;

/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzay implements zze.zzaw {
    static final zze.zzaw zzja = new zzay();

    private zzay() {
    }

    @Override // com.google.android.gms.games.internal.zze.zzaw
    public final void zza(Object obj, Room room) {
        ((RoomStatusUpdateListener) obj).onRoomAutoMatching(room);
    }
}

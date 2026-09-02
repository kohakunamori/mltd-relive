package com.google.android.gms.games.internal;

import com.google.android.gms.games.multiplayer.realtime.Room;
import com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener;

/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzam implements zze.zzaz {
    static final zze.zzaz zziw = new zzam();

    private zzam() {
    }

    @Override // com.google.android.gms.games.internal.zze.zzaz
    public final void zza(Object obj, int i, Room room) {
        ((RoomUpdateListener) obj).onRoomCreated(i, room);
    }
}

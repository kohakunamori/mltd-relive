package com.google.android.gms.games.internal;

import com.google.android.gms.games.multiplayer.realtime.Room;
import com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzaq implements zze.zzav {
    static final zze.zzav zzix = new zzaq();

    private zzaq() {
    }

    @Override // com.google.android.gms.games.internal.zze.zzav
    public final void zza(Object obj, Room room, ArrayList arrayList) {
        ((RoomStatusUpdateListener) obj).onPeerLeft(room, arrayList);
    }
}

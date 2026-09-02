package com.google.android.gms.games.internal;

import com.google.android.gms.games.multiplayer.realtime.Room;
import com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzar implements zze.zzav {
    static final zze.zzav zzix = new zzar();

    private zzar() {
    }

    @Override // com.google.android.gms.games.internal.zze.zzav
    public final void zza(Object obj, Room room, ArrayList arrayList) {
        ((RoomStatusUpdateListener) obj).onPeerDeclined(room, arrayList);
    }
}

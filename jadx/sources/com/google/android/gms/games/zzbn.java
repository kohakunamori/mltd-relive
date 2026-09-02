package com.google.android.gms.games;

import androidx.annotation.NonNull;
import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.games.multiplayer.realtime.RoomConfig;
import com.google.android.gms.tasks.Continuation;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
final class zzbn implements Continuation<Boolean, Task<Void>> {
    final /* synthetic */ String zzdi;
    final /* synthetic */ RoomConfig zzdq;
    final /* synthetic */ ListenerHolder zzdr;
    private final /* synthetic */ RealTimeMultiplayerClient zzds;

    zzbn(RealTimeMultiplayerClient realTimeMultiplayerClient, ListenerHolder listenerHolder, String str, RoomConfig roomConfig) {
        this.zzds = realTimeMultiplayerClient;
        this.zzdr = listenerHolder;
        this.zzdi = str;
        this.zzdq = roomConfig;
    }

    @Override // com.google.android.gms.tasks.Continuation
    public final /* synthetic */ Task<Void> then(@NonNull Task<Boolean> task) throws Exception {
        return this.zzds.doRead(new zzbo(this));
    }
}

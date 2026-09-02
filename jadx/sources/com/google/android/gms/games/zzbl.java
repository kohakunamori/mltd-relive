package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.games.multiplayer.realtime.RoomConfig;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzbl extends com.google.android.gms.games.internal.zzbo<com.google.android.gms.games.multiplayer.realtime.zzh> {
    private final /* synthetic */ ListenerHolder zzbj;
    private final /* synthetic */ RoomConfig zzdq;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzbl(RealTimeMultiplayerClient realTimeMultiplayerClient, ListenerHolder listenerHolder, ListenerHolder listenerHolder2, RoomConfig roomConfig) {
        super(listenerHolder);
        this.zzbj = listenerHolder2;
        this.zzdq = roomConfig;
    }

    @Override // com.google.android.gms.games.internal.zzbo
    protected final void zzb(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException, SecurityException {
        zzeVar.zzc(this.zzbj, this.zzbj, this.zzbj, this.zzdq);
        taskCompletionSource.setResult(null);
    }
}

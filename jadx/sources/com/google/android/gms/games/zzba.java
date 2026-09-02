package com.google.android.gms.games;

import android.content.Intent;
import android.os.RemoteException;
import com.google.android.gms.games.multiplayer.realtime.Room;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzba extends com.google.android.gms.internal.games.zzag<Intent> {
    private final /* synthetic */ Room zzdf;
    private final /* synthetic */ int zzdg;

    zzba(RealTimeMultiplayerClient realTimeMultiplayerClient, Room room, int i) {
        this.zzdf = room;
        this.zzdg = i;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Intent> taskCompletionSource) throws RemoteException {
        taskCompletionSource.setResult(zzeVar.zza(this.zzdf, this.zzdg));
    }
}

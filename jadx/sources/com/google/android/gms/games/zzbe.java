package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzbe extends com.google.android.gms.internal.games.zzag<Void> {
    private final /* synthetic */ String zzdl;

    zzbe(RealTimeMultiplayerClient realTimeMultiplayerClient, String str) {
        this.zzdl = str;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException {
        zzeVar.zzd(this.zzdl, 0);
        taskCompletionSource.setResult(null);
    }
}

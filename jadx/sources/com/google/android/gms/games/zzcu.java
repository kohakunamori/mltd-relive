package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzcu extends com.google.android.gms.internal.games.zzag<Void> {
    private final /* synthetic */ String zzey;

    zzcu(TurnBasedMultiplayerClient turnBasedMultiplayerClient, String str) {
        this.zzey = str;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException {
        zzeVar.zzb(this.zzey);
        taskCompletionSource.setResult(null);
    }
}

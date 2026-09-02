package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzn extends com.google.android.gms.internal.games.zzag<Void> {
    private final /* synthetic */ int zzbe;

    zzn(GamesClient gamesClient, int i) {
        this.zzbe = i;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException {
        zzeVar.zzk(this.zzbe);
        taskCompletionSource.setResult(null);
    }
}

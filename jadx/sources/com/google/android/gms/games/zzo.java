package com.google.android.gms.games;

import android.os.RemoteException;
import android.view.View;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzo extends com.google.android.gms.internal.games.zzag<Void> {
    private final /* synthetic */ View zzbf;

    zzo(GamesClient gamesClient, View view) {
        this.zzbf = view;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException {
        zzeVar.zza(this.zzbf);
        taskCompletionSource.setResult(null);
    }
}

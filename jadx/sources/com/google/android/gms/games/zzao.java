package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzao extends com.google.android.gms.internal.games.zzag<Void> {
    private final /* synthetic */ int zzby;

    zzao(NotificationsClient notificationsClient, int i) {
        this.zzby = i;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException {
        zzeVar.zzl(this.zzby);
        taskCompletionSource.setResult(null);
    }
}

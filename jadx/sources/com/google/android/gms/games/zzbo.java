package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzbo extends com.google.android.gms.internal.games.zzag<Void> {
    final /* synthetic */ zzbn zzdt;

    zzbo(zzbn zzbnVar) {
        this.zzdt = zzbnVar;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException {
        this.zzdt.zzdr.notifyListener(new zzbp(this));
        taskCompletionSource.setResult(null);
    }
}

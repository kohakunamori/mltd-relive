package com.google.android.gms.games;

import android.content.Intent;
import android.os.RemoteException;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzcq extends com.google.android.gms.internal.games.zzag<Intent> {
    private final /* synthetic */ int zzdn;
    private final /* synthetic */ int zzdo;
    private final /* synthetic */ boolean zzdp;

    zzcq(TurnBasedMultiplayerClient turnBasedMultiplayerClient, int i, int i2, boolean z) {
        this.zzdn = i;
        this.zzdo = i2;
        this.zzdp = z;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Intent> taskCompletionSource) throws RemoteException {
        taskCompletionSource.setResult(zzeVar.zza(this.zzdn, this.zzdo, this.zzdp));
    }
}

package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.games.snapshot.Snapshot;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzbx extends com.google.android.gms.internal.games.zzag<Void> {
    private final /* synthetic */ Snapshot zzeh;

    zzbx(SnapshotsClient snapshotsClient, Snapshot snapshot) {
        this.zzeh = snapshot;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException {
        zzeVar.zza(this.zzeh);
        taskCompletionSource.setResult(null);
    }
}

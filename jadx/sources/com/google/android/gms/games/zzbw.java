package com.google.android.gms.games;

import android.content.Intent;
import android.os.RemoteException;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzbw extends com.google.android.gms.internal.games.zzag<Intent> {
    private final /* synthetic */ String zzed;
    private final /* synthetic */ boolean zzee;
    private final /* synthetic */ boolean zzef;
    private final /* synthetic */ int zzeg;

    zzbw(SnapshotsClient snapshotsClient, String str, boolean z, boolean z2, int i) {
        this.zzed = str;
        this.zzee = z;
        this.zzef = z2;
        this.zzeg = i;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Intent> taskCompletionSource) throws RemoteException {
        taskCompletionSource.setResult(zzeVar.zza(this.zzed, this.zzee, this.zzef, this.zzeg));
    }
}

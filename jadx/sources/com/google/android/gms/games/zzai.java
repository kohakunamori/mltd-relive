package com.google.android.gms.games;

import android.content.Intent;
import android.os.RemoteException;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzai extends com.google.android.gms.internal.games.zzag<Intent> {
    private final /* synthetic */ String zzbr;
    private final /* synthetic */ int zzbs;
    private final /* synthetic */ int zzbt;

    zzai(LeaderboardsClient leaderboardsClient, String str, int i, int i2) {
        this.zzbr = str;
        this.zzbs = i;
        this.zzbt = i2;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Intent> taskCompletionSource) throws RemoteException {
        taskCompletionSource.setResult(zzeVar.zza(this.zzbr, this.zzbs, this.zzbt));
    }
}

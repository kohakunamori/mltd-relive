package com.google.android.gms.games;

import android.content.Intent;
import android.os.RemoteException;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzah extends com.google.android.gms.internal.games.zzag<Intent> {
    private final /* synthetic */ String zzbr;
    private final /* synthetic */ int zzbs;

    zzah(LeaderboardsClient leaderboardsClient, String str, int i) {
        this.zzbr = str;
        this.zzbs = i;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Intent> taskCompletionSource) throws RemoteException {
        taskCompletionSource.setResult(zzeVar.zza(this.zzbr, this.zzbs, -1));
    }
}

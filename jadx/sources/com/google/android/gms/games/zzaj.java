package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.games.leaderboard.Leaderboards;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzaj extends com.google.android.gms.internal.games.zzag<Void> {
    private final /* synthetic */ String zzbr;
    private final /* synthetic */ long zzbu;

    zzaj(LeaderboardsClient leaderboardsClient, String str, long j) {
        this.zzbr = str;
        this.zzbu = j;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException {
        zzeVar.zza((BaseImplementation.ResultHolder<Leaderboards.SubmitScoreResult>) null, this.zzbr, this.zzbu, (String) null);
    }
}

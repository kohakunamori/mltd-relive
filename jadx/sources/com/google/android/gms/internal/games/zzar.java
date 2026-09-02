package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.games.leaderboard.LeaderboardScoreBuffer;

/* JADX INFO: loaded from: classes.dex */
final class zzar extends zzax {
    private final /* synthetic */ int zzkg;
    private final /* synthetic */ LeaderboardScoreBuffer zzkh;
    private final /* synthetic */ int zzki;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzar(zzal zzalVar, GoogleApiClient googleApiClient, LeaderboardScoreBuffer leaderboardScoreBuffer, int i, int i2) {
        super(googleApiClient, null);
        this.zzkh = leaderboardScoreBuffer;
        this.zzkg = i;
        this.zzki = i2;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzkh, this.zzkg, this.zzki);
    }
}

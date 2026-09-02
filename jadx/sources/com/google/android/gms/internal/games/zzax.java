package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.leaderboard.Leaderboards;

/* JADX INFO: loaded from: classes.dex */
abstract class zzax extends Games.zza<Leaderboards.LoadScoresResult> {
    private zzax(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzay(this, status);
    }

    /* synthetic */ zzax(GoogleApiClient googleApiClient, zzam zzamVar) {
        this(googleApiClient);
    }
}

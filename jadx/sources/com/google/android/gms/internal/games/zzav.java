package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.leaderboard.Leaderboards;

/* JADX INFO: loaded from: classes.dex */
abstract class zzav extends Games.zza<Leaderboards.LoadPlayerScoreResult> {
    private zzav(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzaw(this, status);
    }

    /* synthetic */ zzav(GoogleApiClient googleApiClient, zzam zzamVar) {
        this(googleApiClient);
    }
}

package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer;

/* JADX INFO: loaded from: classes.dex */
abstract class zzdo extends Games.zza<TurnBasedMultiplayer.LeaveMatchResult> {
    private zzdo(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzdp(this, status);
    }

    /* synthetic */ zzdo(GoogleApiClient googleApiClient, zzda zzdaVar) {
        this(googleApiClient);
    }
}

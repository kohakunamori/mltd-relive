package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;

/* JADX INFO: loaded from: classes.dex */
abstract class zzaa extends Games.zza<Result> {
    private zzaa(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public Result createFailedResult(Status status) {
        return new zzab(this, status);
    }

    /* synthetic */ zzaa(GoogleApiClient googleApiClient, zzv zzvVar) {
        this(googleApiClient);
    }
}

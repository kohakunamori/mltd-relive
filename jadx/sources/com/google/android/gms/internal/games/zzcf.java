package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.request.Requests;

/* JADX INFO: loaded from: classes.dex */
abstract class zzcf extends Games.zza<Requests.UpdateRequestsResult> {
    private zzcf(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzcg(this, status);
    }

    /* synthetic */ zzcf(GoogleApiClient googleApiClient, zzca zzcaVar) {
        this(googleApiClient);
    }
}

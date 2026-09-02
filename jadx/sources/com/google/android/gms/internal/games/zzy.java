package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.event.Events;

/* JADX INFO: loaded from: classes.dex */
abstract class zzy extends Games.zza<Events.LoadEventsResult> {
    private zzy(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzz(this, status);
    }

    /* synthetic */ zzy(GoogleApiClient googleApiClient, zzv zzvVar) {
        this(googleApiClient);
    }
}

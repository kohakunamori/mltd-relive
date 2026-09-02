package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.snapshot.Snapshots;

/* JADX INFO: loaded from: classes.dex */
abstract class zzct extends Games.zza<Snapshots.OpenSnapshotResult> {
    private zzct(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzcu(this, status);
    }

    /* synthetic */ zzct(GoogleApiClient googleApiClient, zzci zzciVar) {
        this(googleApiClient);
    }
}

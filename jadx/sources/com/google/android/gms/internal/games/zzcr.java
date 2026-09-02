package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.snapshot.Snapshots;

/* JADX INFO: loaded from: classes.dex */
abstract class zzcr extends Games.zza<Snapshots.LoadSnapshotsResult> {
    private zzcr(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzcs(this, status);
    }

    /* synthetic */ zzcr(GoogleApiClient googleApiClient, zzci zzciVar) {
        this(googleApiClient);
    }
}

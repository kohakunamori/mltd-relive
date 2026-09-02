package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.GamesMetadata;

/* JADX INFO: loaded from: classes.dex */
abstract class zzae extends Games.zza<GamesMetadata.LoadGamesResult> {
    private zzae(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzaf(this, status);
    }

    /* synthetic */ zzae(GoogleApiClient googleApiClient, zzad zzadVar) {
        this(googleApiClient);
    }
}

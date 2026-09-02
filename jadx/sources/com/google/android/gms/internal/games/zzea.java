package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.video.Videos;

/* JADX INFO: loaded from: classes.dex */
abstract class zzea extends Games.zza<Videos.CaptureAvailableResult> {
    private zzea(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzeb(this, status);
    }

    /* synthetic */ zzea(GoogleApiClient googleApiClient, zzdx zzdxVar) {
        this(googleApiClient);
    }
}

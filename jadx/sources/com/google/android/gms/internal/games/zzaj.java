package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.multiplayer.Invitations;

/* JADX INFO: loaded from: classes.dex */
abstract class zzaj extends Games.zza<Invitations.LoadInvitationsResult> {
    private zzaj(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzak(this, status);
    }

    /* synthetic */ zzaj(GoogleApiClient googleApiClient, zzai zzaiVar) {
        this(googleApiClient);
    }
}

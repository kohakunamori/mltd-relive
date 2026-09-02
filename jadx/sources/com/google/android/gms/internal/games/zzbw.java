package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.quest.Quests;

/* JADX INFO: loaded from: classes.dex */
abstract class zzbw extends Games.zza<Quests.LoadQuestsResult> {
    private zzbw(GoogleApiClient googleApiClient) {
        super(googleApiClient);
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzbx(this, status);
    }

    /* synthetic */ zzbw(GoogleApiClient googleApiClient, zzbo zzboVar) {
        this(googleApiClient);
    }
}

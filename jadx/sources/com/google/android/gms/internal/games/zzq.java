package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.achievement.Achievements;

/* JADX INFO: loaded from: classes.dex */
abstract class zzq extends Games.zza<Achievements.UpdateAchievementResult> {
    private final String zzfr;

    public zzq(String str, GoogleApiClient googleApiClient) {
        super(googleApiClient);
        this.zzfr = str;
    }

    @Override // com.google.android.gms.common.api.internal.BasePendingResult
    public /* synthetic */ Result createFailedResult(Status status) {
        return new zzr(this, status);
    }
}

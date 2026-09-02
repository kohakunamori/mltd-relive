package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.achievement.Achievements;

/* JADX INFO: loaded from: classes.dex */
final class zzr implements Achievements.UpdateAchievementResult {
    private final /* synthetic */ Status zzbd;
    private final /* synthetic */ zzq zzkb;

    zzr(zzq zzqVar, Status status) {
        this.zzkb = zzqVar;
        this.zzbd = status;
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }

    @Override // com.google.android.gms.games.achievement.Achievements.UpdateAchievementResult
    public final String getAchievementId() {
        return this.zzkb.zzfr;
    }
}

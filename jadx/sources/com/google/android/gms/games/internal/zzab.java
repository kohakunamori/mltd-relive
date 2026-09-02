package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.achievement.Achievements;

/* JADX INFO: loaded from: classes.dex */
final class zzab extends zze.zzat<Achievements.LoadAchievementsResult> {
    zzab(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zza(DataHolder dataHolder) {
        setResult(new zze.zzw(dataHolder));
    }
}

package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.stats.Stats;

/* JADX INFO: loaded from: classes.dex */
final class zzj extends zze.zzat<Stats.LoadPlayerStatsResult> {
    zzj(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zzao(DataHolder dataHolder) {
        setResult(new zze.zzad(dataHolder));
    }
}

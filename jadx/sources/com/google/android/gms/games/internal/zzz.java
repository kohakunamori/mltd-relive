package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.leaderboard.Leaderboards;

/* JADX INFO: loaded from: classes.dex */
final class zzz extends zze.zzat<Leaderboards.LoadPlayerScoreResult> {
    zzz(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zzac(DataHolder dataHolder) {
        setResult(new zze.zzac(dataHolder));
    }
}

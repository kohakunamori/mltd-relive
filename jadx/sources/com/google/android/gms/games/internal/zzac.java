package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.GamesMetadata;

/* JADX INFO: loaded from: classes.dex */
final class zzac extends zze.zzat<GamesMetadata.LoadGamesResult> {
    zzac(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zzg(DataHolder dataHolder) {
        setResult(new zze.zzy(dataHolder));
    }
}

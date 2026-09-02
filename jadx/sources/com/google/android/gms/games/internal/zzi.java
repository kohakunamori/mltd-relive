package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer;

/* JADX INFO: loaded from: classes.dex */
final class zzi extends zze.zzat<TurnBasedMultiplayer.LoadMatchResult> {
    zzi(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zzn(DataHolder dataHolder) {
        setResult(new zze.zzaa(dataHolder));
    }
}

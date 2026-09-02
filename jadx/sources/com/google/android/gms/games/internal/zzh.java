package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.games.GamesStatusCodes;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer;

/* JADX INFO: loaded from: classes.dex */
final class zzh extends zze.zzat<TurnBasedMultiplayer.CancelMatchResult> {
    zzh(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zzc(int i, String str) {
        setResult(new zze.zzc(GamesStatusCodes.zza(i), str));
    }
}

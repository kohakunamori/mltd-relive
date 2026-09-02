package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.GamesStatusCodes;

/* JADX INFO: loaded from: classes.dex */
final class zzy extends zze.zzat<Games.GetServerAuthCodeResult> {
    zzy(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zza(int i, String str) {
        setResult(new zze.zzm(GamesStatusCodes.zza(i), str));
    }
}

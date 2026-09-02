package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.games.GamesStatusCodes;

/* JADX INFO: loaded from: classes.dex */
final class zzg extends zze.zzat<Status> {
    zzg(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void onSignOutComplete() {
        setResult(GamesStatusCodes.zza(0));
    }
}

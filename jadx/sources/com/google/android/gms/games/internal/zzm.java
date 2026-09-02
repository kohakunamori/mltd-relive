package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.snapshot.Snapshots;

/* JADX INFO: loaded from: classes.dex */
final class zzm extends zze.zzat<Snapshots.CommitSnapshotResult> {
    zzm(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zzah(DataHolder dataHolder) {
        setResult(new zze.zzh(dataHolder));
    }
}

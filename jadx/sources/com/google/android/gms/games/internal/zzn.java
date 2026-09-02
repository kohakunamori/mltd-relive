package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.games.snapshot.Snapshots;

/* JADX INFO: loaded from: classes.dex */
final class zzn extends zze.zzat<Snapshots.DeleteSnapshotResult> {
    zzn(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zzd(int i, String str) {
        setResult(new zze.zzi(i, str));
    }
}

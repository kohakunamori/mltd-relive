package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.snapshot.Snapshots;

/* JADX INFO: loaded from: classes.dex */
final class zzcq implements Snapshots.DeleteSnapshotResult {
    private final /* synthetic */ Status zzbd;

    zzcq(zzcp zzcpVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.games.snapshot.Snapshots.DeleteSnapshotResult
    public final String getSnapshotId() {
        return null;
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }
}

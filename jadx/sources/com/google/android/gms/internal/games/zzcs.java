package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.snapshot.SnapshotMetadataBuffer;
import com.google.android.gms.games.snapshot.Snapshots;

/* JADX INFO: loaded from: classes.dex */
final class zzcs implements Snapshots.LoadSnapshotsResult {
    private final /* synthetic */ Status zzbd;

    zzcs(zzcr zzcrVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.common.api.Releasable
    public final void release() {
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }

    @Override // com.google.android.gms.games.snapshot.Snapshots.LoadSnapshotsResult
    public final SnapshotMetadataBuffer getSnapshots() {
        return new SnapshotMetadataBuffer(DataHolder.empty(14));
    }
}

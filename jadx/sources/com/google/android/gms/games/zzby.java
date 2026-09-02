package com.google.android.gms.games;

import androidx.annotation.NonNull;
import com.google.android.gms.common.api.ApiException;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.ApiExceptionUtil;
import com.google.android.gms.games.snapshot.Snapshots;

/* JADX INFO: loaded from: classes.dex */
final class zzby implements com.google.android.gms.games.internal.zzbl<Snapshots.OpenSnapshotResult> {
    zzby() {
    }

    @Override // com.google.android.gms.games.internal.zzbl
    public final /* synthetic */ ApiException zza(@NonNull Status status, @NonNull Snapshots.OpenSnapshotResult openSnapshotResult) {
        Snapshots.OpenSnapshotResult openSnapshotResult2 = openSnapshotResult;
        return (status.getStatusCode() != 26572 || openSnapshotResult2.getSnapshot() == null || openSnapshotResult2.getSnapshot().getMetadata() == null) ? ApiExceptionUtil.fromStatus(status) : new SnapshotsClient.SnapshotContentUnavailableApiException(status, openSnapshotResult2.getSnapshot().getMetadata().freeze());
    }
}

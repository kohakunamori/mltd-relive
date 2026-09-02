package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.games.snapshot.Snapshot;
import com.google.android.gms.games.snapshot.SnapshotMetadataChange;

/* JADX INFO: loaded from: classes.dex */
final class zzck extends zzcn {
    private final /* synthetic */ Snapshot zzeh;
    private final /* synthetic */ SnapshotMetadataChange zzku;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzck(zzch zzchVar, GoogleApiClient googleApiClient, Snapshot snapshot, SnapshotMetadataChange snapshotMetadataChange) {
        super(googleApiClient, null);
        this.zzeh = snapshot;
        this.zzku = snapshotMetadataChange;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzeh, this.zzku);
    }
}

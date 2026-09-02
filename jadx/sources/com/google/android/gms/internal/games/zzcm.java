package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.games.snapshot.SnapshotContents;
import com.google.android.gms.games.snapshot.SnapshotMetadataChange;

/* JADX INFO: loaded from: classes.dex */
final class zzcm extends zzct {
    private final /* synthetic */ SnapshotMetadataChange zzku;
    private final /* synthetic */ String zzkw;
    private final /* synthetic */ String zzkx;
    private final /* synthetic */ SnapshotContents zzky;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzcm(zzch zzchVar, GoogleApiClient googleApiClient, String str, String str2, SnapshotMetadataChange snapshotMetadataChange, SnapshotContents snapshotContents) {
        super(googleApiClient, null);
        this.zzkw = str;
        this.zzkx = str2;
        this.zzku = snapshotMetadataChange;
        this.zzky = snapshotContents;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzkw, this.zzkx, this.zzku, this.zzky);
    }
}

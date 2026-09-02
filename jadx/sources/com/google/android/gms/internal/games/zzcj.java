package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzcj extends zzct {
    private final /* synthetic */ String zzkr;
    private final /* synthetic */ boolean zzks;
    private final /* synthetic */ int zzkt;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzcj(zzch zzchVar, GoogleApiClient googleApiClient, String str, boolean z, int i) {
        super(googleApiClient, null);
        this.zzkr = str;
        this.zzks = z;
        this.zzkt = i;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzkr, this.zzks, this.zzkt);
    }
}

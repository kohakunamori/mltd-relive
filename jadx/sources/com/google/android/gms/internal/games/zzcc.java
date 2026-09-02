package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzcc extends zzcd {
    private final /* synthetic */ int zzkd;
    private final /* synthetic */ int zzkp;
    private final /* synthetic */ int zzkq;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzcc(zzbz zzbzVar, GoogleApiClient googleApiClient, int i, int i2, int i3) {
        super(googleApiClient, null);
        this.zzkp = i;
        this.zzkq = i2;
        this.zzkd = i3;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzkp, this.zzkq, this.zzkd);
    }
}

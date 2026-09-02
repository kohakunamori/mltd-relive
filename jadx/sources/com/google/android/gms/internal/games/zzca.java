package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzca extends zzcf {
    private final /* synthetic */ String[] zzko;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzca(zzbz zzbzVar, GoogleApiClient googleApiClient, String[] strArr) {
        super(googleApiClient, null);
        this.zzko = strArr;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzko);
    }
}

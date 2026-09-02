package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzai extends zzaj {
    private final /* synthetic */ int zzkd;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzai(zzah zzahVar, GoogleApiClient googleApiClient, int i) {
        super(googleApiClient, null);
        this.zzkd = i;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzkd);
    }
}

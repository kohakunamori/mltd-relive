package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzdi extends zzdk {
    private final /* synthetic */ String zzey;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzdi(zzcz zzczVar, String str, GoogleApiClient googleApiClient, String str2) {
        super(str, googleApiClient);
        this.zzey = str2;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zzf(this, this.zzey);
    }
}

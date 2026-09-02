package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzbk extends zzbl {
    private final /* synthetic */ boolean zzjz;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzbk(zzbd zzbdVar, GoogleApiClient googleApiClient, boolean z) {
        super(googleApiClient);
        this.zzjz = z;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzjz);
    }
}

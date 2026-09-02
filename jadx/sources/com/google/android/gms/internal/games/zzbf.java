package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzbf extends zzbl {
    private final /* synthetic */ boolean zzjz;
    private final /* synthetic */ String zzkj;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzbf(zzbd zzbdVar, GoogleApiClient googleApiClient, String str, boolean z) {
        super(googleApiClient);
        this.zzkj = str;
        this.zzjz = z;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzkj, this.zzjz);
    }
}

package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzas extends zzaz {
    private final /* synthetic */ String zzbr;
    private final /* synthetic */ long zzbu;
    private final /* synthetic */ String zzbv;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzas(zzal zzalVar, GoogleApiClient googleApiClient, String str, long j, String str2) {
        super(googleApiClient);
        this.zzbr = str;
        this.zzbu = j;
        this.zzbv = str2;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzbr, this.zzbu, this.zzbv);
    }
}

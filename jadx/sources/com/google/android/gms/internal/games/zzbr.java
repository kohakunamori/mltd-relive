package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzbr extends zzbw {
    private final /* synthetic */ boolean zzjz;
    private final /* synthetic */ String[] zzkn;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzbr(zzbn zzbnVar, GoogleApiClient googleApiClient, boolean z, String[] strArr) {
        super(googleApiClient, null);
        this.zzjz = z;
        this.zzkn = strArr;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zzb(this, this.zzjz, this.zzkn);
    }
}

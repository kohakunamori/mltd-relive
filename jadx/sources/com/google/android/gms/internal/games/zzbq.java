package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzbq extends zzbw {
    private final /* synthetic */ boolean zzjz;
    private final /* synthetic */ int zzkd;
    private final /* synthetic */ int[] zzkm;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzbq(zzbn zzbnVar, GoogleApiClient googleApiClient, int[] iArr, int i, boolean z) {
        super(googleApiClient, null);
        this.zzkm = iArr;
        this.zzkd = i;
        this.zzjz = z;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzkm, this.zzkd, this.zzjz);
    }
}

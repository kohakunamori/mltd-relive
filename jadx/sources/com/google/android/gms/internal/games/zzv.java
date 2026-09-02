package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzv extends zzy {
    private final /* synthetic */ boolean zzjz;
    private final /* synthetic */ String[] zzkc;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzv(zzu zzuVar, GoogleApiClient googleApiClient, boolean z, String[] strArr) {
        super(googleApiClient, null);
        this.zzjz = z;
        this.zzkc = strArr;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    public final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzjz, this.zzkc);
    }
}

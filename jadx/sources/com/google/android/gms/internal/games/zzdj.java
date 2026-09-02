package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzdj extends zzds {
    private final /* synthetic */ int zzld;
    private final /* synthetic */ int[] zzle;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzdj(zzcz zzczVar, GoogleApiClient googleApiClient, int i, int[] iArr) {
        super(googleApiClient, null);
        this.zzld = i;
        this.zzle = iArr;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzld, this.zzle);
    }
}

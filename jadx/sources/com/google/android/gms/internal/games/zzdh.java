package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzdh extends zzdo {
    private final /* synthetic */ String zzey;
    private final /* synthetic */ String zzlb;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzdh(zzcz zzczVar, GoogleApiClient googleApiClient, String str, String str2) {
        super(googleApiClient, null);
        this.zzey = str;
        this.zzlb = str2;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzey, this.zzlb);
    }
}

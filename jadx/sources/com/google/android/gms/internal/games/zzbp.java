package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzbp extends zzbu {
    private final /* synthetic */ String zzha;
    private final /* synthetic */ String zzkl;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzbp(zzbn zzbnVar, GoogleApiClient googleApiClient, String str, String str2) {
        super(googleApiClient, null);
        this.zzkl = str;
        this.zzha = str2;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zzb(this, this.zzkl, this.zzha);
    }
}

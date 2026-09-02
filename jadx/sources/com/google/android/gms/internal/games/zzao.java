package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzao extends zzav {
    private final /* synthetic */ String zzbr;
    private final /* synthetic */ int zzke;
    private final /* synthetic */ int zzkf;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzao(zzal zzalVar, GoogleApiClient googleApiClient, String str, int i, int i2) {
        super(googleApiClient, null);
        this.zzbr = str;
        this.zzke = i;
        this.zzkf = i2;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, (String) null, this.zzbr, this.zzke, this.zzkf);
    }
}

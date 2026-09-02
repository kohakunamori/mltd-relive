package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzap extends zzax {
    private final /* synthetic */ String zzbr;
    private final /* synthetic */ boolean zzjz;
    private final /* synthetic */ int zzke;
    private final /* synthetic */ int zzkf;
    private final /* synthetic */ int zzkg;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzap(zzal zzalVar, GoogleApiClient googleApiClient, String str, int i, int i2, int i3, boolean z) {
        super(googleApiClient, null);
        this.zzbr = str;
        this.zzke = i;
        this.zzkf = i2;
        this.zzkg = i3;
        this.zzjz = z;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzbr, this.zzke, this.zzkf, this.zzkg, this.zzjz);
    }
}

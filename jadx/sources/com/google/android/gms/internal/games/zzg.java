package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;

/* JADX INFO: loaded from: classes.dex */
final class zzg extends zzq {
    private final /* synthetic */ String val$id;
    private final /* synthetic */ int zzka;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzg(zze zzeVar, String str, GoogleApiClient googleApiClient, String str2, int i) {
        super(str, googleApiClient);
        this.val$id = str2;
        this.zzka = i;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    public final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zzb(this, this.val$id, this.zzka);
    }
}

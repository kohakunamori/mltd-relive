package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.games.Players;

/* JADX INFO: loaded from: classes.dex */
final class zzbi extends zzbl {
    private final /* synthetic */ boolean zzjz;
    private final /* synthetic */ int zzkk;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzbi(zzbd zzbdVar, GoogleApiClient googleApiClient, int i, boolean z) {
        super(googleApiClient);
        this.zzkk = i;
        this.zzjz = z;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza((BaseImplementation.ResultHolder<Players.LoadPlayersResult>) this, "played_with", this.zzkk, false, this.zzjz);
    }
}

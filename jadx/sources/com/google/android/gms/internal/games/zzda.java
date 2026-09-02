package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchConfig;

/* JADX INFO: loaded from: classes.dex */
final class zzda extends zzdm {
    private final /* synthetic */ TurnBasedMatchConfig zzkz;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzda(zzcz zzczVar, GoogleApiClient googleApiClient, TurnBasedMatchConfig turnBasedMatchConfig) {
        super(googleApiClient, null);
        this.zzkz = turnBasedMatchConfig;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzkz);
    }
}

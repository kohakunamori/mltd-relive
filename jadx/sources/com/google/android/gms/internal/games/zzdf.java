package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.games.multiplayer.ParticipantResult;

/* JADX INFO: loaded from: classes.dex */
final class zzdf extends zzdu {
    private final /* synthetic */ String zzey;
    private final /* synthetic */ byte[] zzla;
    private final /* synthetic */ ParticipantResult[] zzlc;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzdf(zzcz zzczVar, GoogleApiClient googleApiClient, String str, byte[] bArr, ParticipantResult[] participantResultArr) {
        super(googleApiClient, null);
        this.zzey = str;
        this.zzla = bArr;
        this.zzlc = participantResultArr;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    protected final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zza(this, this.zzey, this.zzla, this.zzlc);
    }
}

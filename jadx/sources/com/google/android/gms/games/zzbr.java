package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.common.internal.ApiExceptionUtil;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzbr extends com.google.android.gms.internal.games.zzag<Integer> {
    private final /* synthetic */ byte[] zzdh;
    private final /* synthetic */ String zzdi;
    private final /* synthetic */ String zzdj;
    private final /* synthetic */ ListenerHolder zzdv;

    zzbr(RealTimeMultiplayerClient realTimeMultiplayerClient, ListenerHolder listenerHolder, byte[] bArr, String str, String str2) {
        this.zzdv = listenerHolder;
        this.zzdh = bArr;
        this.zzdi = str;
        this.zzdj = str2;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Integer> taskCompletionSource) throws RemoteException {
        Integer numValueOf = Integer.valueOf(zzeVar.zza(this.zzdv, this.zzdh, this.zzdi, this.zzdj));
        if (numValueOf.intValue() == -1) {
            taskCompletionSource.trySetException(ApiExceptionUtil.fromStatus(GamesClientStatusCodes.zza(GamesClientStatusCodes.REAL_TIME_MESSAGE_SEND_FAILED)));
        } else {
            taskCompletionSource.setResult(numValueOf);
        }
    }
}

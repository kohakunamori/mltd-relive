package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.common.internal.ApiExceptionUtil;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzbd extends com.google.android.gms.internal.games.zzag<Void> {
    private final /* synthetic */ byte[] zzdh;
    private final /* synthetic */ String zzdi;

    zzbd(RealTimeMultiplayerClient realTimeMultiplayerClient, byte[] bArr, String str) {
        this.zzdh = bArr;
        this.zzdi = str;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException {
        if (zzeVar.zza(this.zzdh, this.zzdi) == 0) {
            taskCompletionSource.setResult(null);
        } else {
            taskCompletionSource.trySetException(ApiExceptionUtil.fromStatus(GamesClientStatusCodes.zza(GamesClientStatusCodes.REAL_TIME_MESSAGE_SEND_FAILED)));
        }
    }
}

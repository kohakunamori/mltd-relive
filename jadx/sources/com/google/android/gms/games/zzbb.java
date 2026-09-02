package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.common.internal.ApiExceptionUtil;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzbb extends com.google.android.gms.internal.games.zzag<Void> {
    private final /* synthetic */ byte[] zzdh;
    private final /* synthetic */ String zzdi;
    private final /* synthetic */ String zzdj;

    zzbb(RealTimeMultiplayerClient realTimeMultiplayerClient, byte[] bArr, String str, String str2) {
        this.zzdh = bArr;
        this.zzdi = str;
        this.zzdj = str2;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException {
        if (((com.google.android.gms.games.internal.zzbu) zzeVar.getService()).zzb(this.zzdh, this.zzdi, new String[]{this.zzdj}) == 0) {
            taskCompletionSource.setResult(null);
        } else {
            taskCompletionSource.trySetException(ApiExceptionUtil.fromStatus(GamesClientStatusCodes.zza(GamesClientStatusCodes.REAL_TIME_MESSAGE_SEND_FAILED)));
        }
    }
}

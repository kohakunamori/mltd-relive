package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.common.internal.ApiExceptionUtil;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.tasks.TaskCompletionSource;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
final class zzbc extends com.google.android.gms.internal.games.zzag<Void> {
    private final /* synthetic */ byte[] zzdh;
    private final /* synthetic */ String zzdi;
    private final /* synthetic */ List zzdk;

    zzbc(RealTimeMultiplayerClient realTimeMultiplayerClient, List list, byte[] bArr, String str) {
        this.zzdk = list;
        this.zzdh = bArr;
        this.zzdi = str;
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException {
        Preconditions.checkNotNull(this.zzdk, "Participant IDs must not be null");
        if (((com.google.android.gms.games.internal.zzbu) zzeVar.getService()).zzb(this.zzdh, this.zzdi, (String[]) this.zzdk.toArray(new String[this.zzdk.size()])) == 0) {
            taskCompletionSource.setResult(null);
        } else {
            taskCompletionSource.trySetException(ApiExceptionUtil.fromStatus(GamesClientStatusCodes.zza(GamesClientStatusCodes.REAL_TIME_MESSAGE_SEND_FAILED)));
        }
    }
}

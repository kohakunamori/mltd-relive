package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzcx extends com.google.android.gms.internal.games.zzag<Boolean> {
    zzcx(VideosClient videosClient) {
    }

    @Override // com.google.android.gms.internal.games.zzag
    protected final void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Boolean> taskCompletionSource) throws RemoteException {
        taskCompletionSource.setResult(Boolean.valueOf(zzeVar.zzce()));
    }
}

package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.internal.TaskApiCall;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzag<TResult> extends TaskApiCall<com.google.android.gms.games.internal.zze, TResult> {
    protected abstract void zza(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<TResult> taskCompletionSource) throws RemoteException;

    @Override // com.google.android.gms.common.api.internal.TaskApiCall
    protected /* synthetic */ void doExecute(Api.AnyClient anyClient, TaskCompletionSource taskCompletionSource) throws RemoteException {
        try {
            zza((com.google.android.gms.games.internal.zze) anyClient, taskCompletionSource);
        } catch (RemoteException | SecurityException e) {
            taskCompletionSource.trySetException(e);
        }
    }
}

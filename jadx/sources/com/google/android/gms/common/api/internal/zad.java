package com.google.android.gms.common.api.internal;

import android.os.DeadObjectException;
import android.os.RemoteException;
import androidx.annotation.NonNull;
import com.google.android.gms.common.api.ApiException;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
abstract class zad<T> extends zac {
    protected final TaskCompletionSource<T> zacn;

    public zad(int i, TaskCompletionSource<T> taskCompletionSource) {
        super(i);
        this.zacn = taskCompletionSource;
    }

    @Override // com.google.android.gms.common.api.internal.zab
    public void zaa(@NonNull zaab zaabVar, boolean z) {
    }

    protected abstract void zad(GoogleApiManager.zaa<?> zaaVar) throws RemoteException;

    @Override // com.google.android.gms.common.api.internal.zab
    public void zaa(@NonNull Status status) {
        this.zacn.trySetException(new ApiException(status));
    }

    @Override // com.google.android.gms.common.api.internal.zab
    public void zaa(@NonNull RuntimeException runtimeException) {
        this.zacn.trySetException(runtimeException);
    }

    @Override // com.google.android.gms.common.api.internal.zab
    public final void zaa(GoogleApiManager.zaa<?> zaaVar) throws DeadObjectException {
        try {
            zad(zaaVar);
        } catch (DeadObjectException e) {
            zaa(zab.zaa(e));
            throw e;
        } catch (RemoteException e2) {
            zaa(zab.zaa(e2));
        } catch (RuntimeException e3) {
            zaa(e3);
        }
    }
}

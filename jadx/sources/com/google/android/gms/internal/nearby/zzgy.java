package com.google.android.gms.internal.nearby;

import android.os.RemoteException;
import android.util.Log;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.api.internal.ListenerHolder;

/* JADX INFO: loaded from: classes.dex */
public final class zzgy extends com.google.android.gms.nearby.messages.internal.zzq {
    private final ListenerHolder<BaseImplementation.ResultHolder<Status>> zzjj;
    private boolean zzjl = false;

    public zzgy(ListenerHolder<BaseImplementation.ResultHolder<Status>> listenerHolder) {
        this.zzjj = listenerHolder;
    }

    @Override // com.google.android.gms.nearby.messages.internal.zzp
    public final synchronized void zza(Status status) throws RemoteException {
        if (!this.zzjl) {
            this.zzjj.notifyListener(new zzgz(this, status));
            this.zzjl = true;
            return;
        }
        String strValueOf = String.valueOf(status);
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 28);
        sb.append("Received multiple statuses: ");
        sb.append(strValueOf);
        Log.wtf("NearbyMessagesCallbackWrapper", sb.toString(), new Exception());
    }
}

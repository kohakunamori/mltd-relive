package com.google.android.gms.games;

import androidx.annotation.NonNull;
import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.tasks.Continuation;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
final class zzbq implements Continuation<String, Task<Boolean>> {
    private final /* synthetic */ ListenerHolder zzdr;
    private final /* synthetic */ RealTimeMultiplayerClient zzds;

    zzbq(RealTimeMultiplayerClient realTimeMultiplayerClient, ListenerHolder listenerHolder) {
        this.zzds = realTimeMultiplayerClient;
        this.zzdr = listenerHolder;
    }

    @Override // com.google.android.gms.tasks.Continuation
    public final /* synthetic */ Task<Boolean> then(@NonNull Task<String> task) throws Exception {
        return this.zzds.doUnregisterEventListener(this.zzdr.getListenerKey());
    }
}

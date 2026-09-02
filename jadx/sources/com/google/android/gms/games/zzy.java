package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.games.multiplayer.OnInvitationReceivedListener;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzy extends com.google.android.gms.games.internal.zzbo<OnInvitationReceivedListener> {
    private final /* synthetic */ ListenerHolder zzbj;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzy(InvitationsClient invitationsClient, ListenerHolder listenerHolder, ListenerHolder listenerHolder2) {
        super(listenerHolder);
        this.zzbj = listenerHolder2;
    }

    @Override // com.google.android.gms.games.internal.zzbo
    protected final void zzb(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException, SecurityException {
        zzeVar.zza(this.zzbj);
        taskCompletionSource.setResult(null);
    }
}

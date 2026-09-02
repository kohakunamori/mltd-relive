package com.google.android.gms.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.games.video.Videos;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes.dex */
final class zzcy extends com.google.android.gms.games.internal.zzbo<Videos.CaptureOverlayStateListener> {
    private final /* synthetic */ ListenerHolder zzbj;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzcy(VideosClient videosClient, ListenerHolder listenerHolder, ListenerHolder listenerHolder2) {
        super(listenerHolder);
        this.zzbj = listenerHolder2;
    }

    @Override // com.google.android.gms.games.internal.zzbo
    protected final void zzb(com.google.android.gms.games.internal.zze zzeVar, TaskCompletionSource<Void> taskCompletionSource) throws RemoteException, SecurityException {
        zzeVar.zzg(this.zzbj);
        taskCompletionSource.setResult(null);
    }
}

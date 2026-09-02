package com.google.android.gms.games;

import com.google.android.gms.common.api.internal.ListenerHolder;

/* JADX INFO: loaded from: classes.dex */
final class zzbp implements ListenerHolder.Notifier<com.google.android.gms.games.multiplayer.realtime.zzh> {
    private final /* synthetic */ zzbo zzdu;

    zzbp(zzbo zzboVar) {
        this.zzdu = zzboVar;
    }

    @Override // com.google.android.gms.common.api.internal.ListenerHolder.Notifier
    public final void onNotifyListenerFailed() {
        this.zzdu.zzdt.zzdq.getRoomUpdateCallback().onLeftRoom(0, this.zzdu.zzdt.zzdi);
    }

    @Override // com.google.android.gms.common.api.internal.ListenerHolder.Notifier
    public final /* synthetic */ void notifyListener(com.google.android.gms.games.multiplayer.realtime.zzh zzhVar) {
        zzhVar.onLeftRoom(0, this.zzdu.zzdt.zzdi);
    }
}

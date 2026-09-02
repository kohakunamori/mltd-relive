package com.google.android.gms.games;

import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
final class zzm implements Games.GetServerAuthCodeResult {
    private final /* synthetic */ Status zzbd;

    zzm(Games.zzc zzcVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.games.Games.GetServerAuthCodeResult
    public final String getCode() {
        return null;
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }
}

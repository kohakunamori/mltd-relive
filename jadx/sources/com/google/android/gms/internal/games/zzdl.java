package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer;

/* JADX INFO: loaded from: classes.dex */
final class zzdl implements TurnBasedMultiplayer.CancelMatchResult {
    private final /* synthetic */ Status zzbd;
    private final /* synthetic */ zzdk zzlf;

    zzdl(zzdk zzdkVar, Status status) {
        this.zzlf = zzdkVar;
        this.zzbd = status;
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer.CancelMatchResult
    public final String getMatchId() {
        return this.zzlf.zzfr;
    }
}

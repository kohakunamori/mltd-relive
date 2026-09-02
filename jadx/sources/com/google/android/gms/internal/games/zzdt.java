package com.google.android.gms.internal.games;

import android.os.Bundle;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.multiplayer.turnbased.LoadMatchesResponse;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer;

/* JADX INFO: loaded from: classes.dex */
final class zzdt implements TurnBasedMultiplayer.LoadMatchesResult {
    private final /* synthetic */ Status zzbd;

    zzdt(zzds zzdsVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.common.api.Releasable
    public final void release() {
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer.LoadMatchesResult
    public final LoadMatchesResponse getMatches() {
        return new LoadMatchesResponse(new Bundle());
    }
}

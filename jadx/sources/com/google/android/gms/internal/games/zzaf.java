package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.GameBuffer;
import com.google.android.gms.games.GamesMetadata;

/* JADX INFO: loaded from: classes.dex */
final class zzaf implements GamesMetadata.LoadGamesResult {
    private final /* synthetic */ Status zzbd;

    zzaf(zzae zzaeVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.common.api.Releasable
    public final void release() {
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }

    @Override // com.google.android.gms.games.GamesMetadata.LoadGamesResult
    public final GameBuffer getGames() {
        return new GameBuffer(DataHolder.empty(14));
    }
}

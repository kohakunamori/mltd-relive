package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.leaderboard.LeaderboardBuffer;
import com.google.android.gms.games.leaderboard.Leaderboards;

/* JADX INFO: loaded from: classes.dex */
final class zzau implements Leaderboards.LeaderboardMetadataResult {
    private final /* synthetic */ Status zzbd;

    zzau(zzat zzatVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.common.api.Releasable
    public final void release() {
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }

    @Override // com.google.android.gms.games.leaderboard.Leaderboards.LeaderboardMetadataResult
    public final LeaderboardBuffer getLeaderboards() {
        return new LeaderboardBuffer(DataHolder.empty(14));
    }
}

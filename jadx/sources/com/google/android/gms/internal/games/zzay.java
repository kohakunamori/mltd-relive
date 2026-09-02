package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.leaderboard.Leaderboard;
import com.google.android.gms.games.leaderboard.LeaderboardScoreBuffer;
import com.google.android.gms.games.leaderboard.Leaderboards;

/* JADX INFO: loaded from: classes.dex */
final class zzay implements Leaderboards.LoadScoresResult {
    private final /* synthetic */ Status zzbd;

    zzay(zzax zzaxVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.games.leaderboard.Leaderboards.LoadScoresResult
    public final Leaderboard getLeaderboard() {
        return null;
    }

    @Override // com.google.android.gms.common.api.Releasable
    public final void release() {
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }

    @Override // com.google.android.gms.games.leaderboard.Leaderboards.LoadScoresResult
    public final LeaderboardScoreBuffer getScores() {
        return new LeaderboardScoreBuffer(DataHolder.empty(14));
    }
}

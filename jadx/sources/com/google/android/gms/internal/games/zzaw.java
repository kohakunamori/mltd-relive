package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.leaderboard.LeaderboardScore;
import com.google.android.gms.games.leaderboard.Leaderboards;

/* JADX INFO: loaded from: classes.dex */
final class zzaw implements Leaderboards.LoadPlayerScoreResult {
    private final /* synthetic */ Status zzbd;

    zzaw(zzav zzavVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.games.leaderboard.Leaderboards.LoadPlayerScoreResult
    public final LeaderboardScore getScore() {
        return null;
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }
}

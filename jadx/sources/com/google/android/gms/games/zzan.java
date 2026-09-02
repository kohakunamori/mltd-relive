package com.google.android.gms.games;

import androidx.annotation.NonNull;
import com.google.android.gms.games.leaderboard.Leaderboards;

/* JADX INFO: loaded from: classes.dex */
final class zzan implements com.google.android.gms.games.internal.zzbm<Leaderboards.LeaderboardMetadataResult> {
    zzan() {
    }

    @Override // com.google.android.gms.games.internal.zzbm
    public final /* synthetic */ void release(@NonNull Leaderboards.LeaderboardMetadataResult leaderboardMetadataResult) {
        Leaderboards.LeaderboardMetadataResult leaderboardMetadataResult2 = leaderboardMetadataResult;
        if (leaderboardMetadataResult2.getLeaderboards() != null) {
            leaderboardMetadataResult2.getLeaderboards().release();
        }
    }
}

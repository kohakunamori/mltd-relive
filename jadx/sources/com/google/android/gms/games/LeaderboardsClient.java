package com.google.android.gms.games;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import androidx.annotation.IntRange;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.gms.common.api.Releasable;
import com.google.android.gms.common.internal.PendingResultUtil;
import com.google.android.gms.games.leaderboard.Leaderboard;
import com.google.android.gms.games.leaderboard.LeaderboardBuffer;
import com.google.android.gms.games.leaderboard.LeaderboardScore;
import com.google.android.gms.games.leaderboard.LeaderboardScoreBuffer;
import com.google.android.gms.games.leaderboard.Leaderboards;
import com.google.android.gms.games.leaderboard.ScoreSubmissionData;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public class LeaderboardsClient extends com.google.android.gms.internal.games.zzt {
    private static final PendingResultUtil.ResultConverter<Leaderboards.LeaderboardMetadataResult, LeaderboardBuffer> zzbk = new zzal();
    private static final PendingResultUtil.ResultConverter<Leaderboards.LeaderboardMetadataResult, Leaderboard> zzbl = new zzam();
    private static final com.google.android.gms.games.internal.zzbm<Leaderboards.LeaderboardMetadataResult> zzbm = new zzan();
    private static final PendingResultUtil.ResultConverter<Leaderboards.LoadPlayerScoreResult, LeaderboardScore> zzbn = new zzac();
    private static final com.google.android.gms.games.internal.zzbn zzbo = new zzad();
    private static final PendingResultUtil.ResultConverter<Leaderboards.SubmitScoreResult, ScoreSubmissionData> zzbp = new zzae();
    private static final PendingResultUtil.ResultConverter<Leaderboards.LoadScoresResult, LeaderboardScores> zzbq = new zzaf();

    LeaderboardsClient(@NonNull Context context, @NonNull Games.GamesOptions gamesOptions) {
        super(context, gamesOptions);
    }

    LeaderboardsClient(@NonNull Activity activity, @NonNull Games.GamesOptions gamesOptions) {
        super(activity, gamesOptions);
    }

    public static class LeaderboardScores implements Releasable {
        private final Leaderboard zzbw;
        private final LeaderboardScoreBuffer zzbx;

        public LeaderboardScores(@Nullable Leaderboard leaderboard, @NonNull LeaderboardScoreBuffer leaderboardScoreBuffer) {
            this.zzbw = leaderboard;
            this.zzbx = leaderboardScoreBuffer;
        }

        @Nullable
        public Leaderboard getLeaderboard() {
            return this.zzbw;
        }

        @NonNull
        public LeaderboardScoreBuffer getScores() {
            return this.zzbx;
        }

        @Override // com.google.android.gms.common.api.Releasable
        public void release() {
            if (this.zzbx != null) {
                this.zzbx.release();
            }
        }
    }

    public Task<Intent> getAllLeaderboardsIntent() {
        return doRead(new zzab(this));
    }

    public Task<Intent> getLeaderboardIntent(@NonNull String str) {
        return doRead(new zzag(this, str));
    }

    public Task<Intent> getLeaderboardIntent(@NonNull String str, int i) {
        return doRead(new zzah(this, str, i));
    }

    public Task<Intent> getLeaderboardIntent(@NonNull String str, int i, int i2) {
        return doRead(new zzai(this, str, i, i2));
    }

    public Task<AnnotatedData<LeaderboardBuffer>> loadLeaderboardMetadata(boolean z) {
        return com.google.android.gms.games.internal.zzbe.zzb(Games.Leaderboards.loadLeaderboardMetadata(asGoogleApiClient(), z), zzbk);
    }

    public Task<AnnotatedData<Leaderboard>> loadLeaderboardMetadata(@NonNull String str, boolean z) {
        return com.google.android.gms.games.internal.zzbe.zza(Games.Leaderboards.loadLeaderboardMetadata(asGoogleApiClient(), str, z), zzbl, zzbm);
    }

    public Task<AnnotatedData<LeaderboardScore>> loadCurrentPlayerLeaderboardScore(@NonNull String str, int i, int i2) {
        return com.google.android.gms.games.internal.zzbe.zza(Games.Leaderboards.loadCurrentPlayerLeaderboardScore(asGoogleApiClient(), str, i, i2), zzbn);
    }

    public Task<AnnotatedData<LeaderboardScores>> loadTopScores(@NonNull String str, int i, int i2, @IntRange(from = 1, m1to = 25) int i3) {
        return com.google.android.gms.games.internal.zzbe.zzb(Games.Leaderboards.loadTopScores(asGoogleApiClient(), str, i, i2, i3), zzbq);
    }

    public Task<AnnotatedData<LeaderboardScores>> loadTopScores(@NonNull String str, int i, int i2, @IntRange(from = 1, m1to = 25) int i3, boolean z) {
        return com.google.android.gms.games.internal.zzbe.zzb(Games.Leaderboards.loadTopScores(asGoogleApiClient(), str, i, i2, i3, z), zzbq);
    }

    public Task<AnnotatedData<LeaderboardScores>> loadPlayerCenteredScores(@NonNull String str, int i, int i2, @IntRange(from = 1, m1to = 25) int i3) {
        return com.google.android.gms.games.internal.zzbe.zzb(Games.Leaderboards.loadPlayerCenteredScores(asGoogleApiClient(), str, i, i2, i3), zzbq);
    }

    public Task<AnnotatedData<LeaderboardScores>> loadPlayerCenteredScores(@NonNull String str, int i, int i2, @IntRange(from = 1, m1to = 25) int i3, boolean z) {
        return com.google.android.gms.games.internal.zzbe.zzb(Games.Leaderboards.loadPlayerCenteredScores(asGoogleApiClient(), str, i, i2, i3, z), zzbq);
    }

    public Task<AnnotatedData<LeaderboardScores>> loadMoreScores(@NonNull LeaderboardScoreBuffer leaderboardScoreBuffer, @IntRange(from = 1, m1to = 25) int i, int i2) {
        return com.google.android.gms.games.internal.zzbe.zzb(Games.Leaderboards.loadMoreScores(asGoogleApiClient(), leaderboardScoreBuffer, i, i2), zzbq);
    }

    public void submitScore(@NonNull String str, long j) {
        doWrite(new zzaj(this, str, j));
    }

    public void submitScore(@NonNull String str, long j, @NonNull String str2) {
        doWrite(new zzak(this, str, j, str2));
    }

    public Task<ScoreSubmissionData> submitScoreImmediate(@NonNull String str, long j) {
        return com.google.android.gms.games.internal.zzbe.zza(Games.Leaderboards.submitScoreImmediate(asGoogleApiClient(), str, j), zzbo, zzbp);
    }

    public Task<ScoreSubmissionData> submitScoreImmediate(@NonNull String str, long j, @NonNull String str2) {
        return com.google.android.gms.games.internal.zzbe.zza(Games.Leaderboards.submitScoreImmediate(asGoogleApiClient(), str, j, str2), zzbo, zzbp);
    }
}

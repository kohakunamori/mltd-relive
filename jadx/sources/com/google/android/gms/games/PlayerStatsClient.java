package com.google.android.gms.games;

import android.app.Activity;
import android.content.Context;
import androidx.annotation.NonNull;
import com.google.android.gms.common.internal.PendingResultUtil;
import com.google.android.gms.games.stats.PlayerStats;
import com.google.android.gms.games.stats.Stats;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public class PlayerStatsClient extends com.google.android.gms.internal.games.zzt {
    private static final PendingResultUtil.ResultConverter<Stats.LoadPlayerStatsResult, PlayerStats> zzda = new zzas();

    PlayerStatsClient(@NonNull Context context, @NonNull Games.GamesOptions gamesOptions) {
        super(context, gamesOptions);
    }

    PlayerStatsClient(@NonNull Activity activity, @NonNull Games.GamesOptions gamesOptions) {
        super(activity, gamesOptions);
    }

    public Task<AnnotatedData<PlayerStats>> loadPlayerStats(boolean z) {
        return com.google.android.gms.games.internal.zzbe.zza(Games.Stats.loadPlayerStats(asGoogleApiClient(), z), zzda);
    }
}

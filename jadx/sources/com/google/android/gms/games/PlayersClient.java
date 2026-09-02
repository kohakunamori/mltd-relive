package com.google.android.gms.games;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import androidx.annotation.IntRange;
import androidx.annotation.NonNull;
import com.google.android.gms.common.internal.PendingResultUtil;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public class PlayersClient extends com.google.android.gms.internal.games.zzt {
    public static final String EXTRA_PLAYER_SEARCH_RESULTS = "player_search_results";
    private static final PendingResultUtil.ResultConverter<Players.LoadPlayersResult, PlayerBuffer> zzdb = new zzax();
    private static final com.google.android.gms.games.internal.zzbm<Players.LoadPlayersResult> zzdc = new zzay();
    private static final PendingResultUtil.ResultConverter<Players.LoadPlayersResult, Player> zzdd = new zzaz();

    PlayersClient(@NonNull Context context, @NonNull Games.GamesOptions gamesOptions) {
        super(context, gamesOptions);
    }

    PlayersClient(@NonNull Activity activity, @NonNull Games.GamesOptions gamesOptions) {
        super(activity, gamesOptions);
    }

    public Task<String> getCurrentPlayerId() {
        return doRead(new zzat(this));
    }

    public Task<Player> getCurrentPlayer() {
        return doRead(new zzau(this));
    }

    public Task<AnnotatedData<Player>> loadPlayer(@NonNull String str) {
        return loadPlayer(str, false);
    }

    public Task<AnnotatedData<Player>> loadPlayer(@NonNull String str, boolean z) {
        return com.google.android.gms.games.internal.zzbe.zza(Games.Players.loadPlayer(asGoogleApiClient(), str, z), zzdd, zzdc);
    }

    public Task<AnnotatedData<PlayerBuffer>> loadRecentlyPlayedWithPlayers(@IntRange(from = 1, m1to = 25) int i, boolean z) {
        return com.google.android.gms.games.internal.zzbe.zzb(Games.Players.loadRecentlyPlayedWithPlayers(asGoogleApiClient(), i, z), zzdb);
    }

    public Task<AnnotatedData<PlayerBuffer>> loadMoreRecentlyPlayedWithPlayers(@IntRange(from = 1, m1to = 25) int i) {
        return com.google.android.gms.games.internal.zzbe.zzb(Games.Players.loadMoreRecentlyPlayedWithPlayers(asGoogleApiClient(), i), zzdb);
    }

    public Task<Intent> getCompareProfileIntent(@NonNull Player player) {
        return doRead(new zzav(this, player));
    }

    public Task<Intent> getPlayerSearchIntent() {
        return doRead(new zzaw(this));
    }
}

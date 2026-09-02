package com.google.android.gms.internal.games;

import android.content.Intent;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.PendingResult;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.Player;
import com.google.android.gms.games.PlayerEntity;
import com.google.android.gms.games.Players;

/* JADX INFO: loaded from: classes.dex */
public final class zzbd implements Players {
    @Override // com.google.android.gms.games.Players
    public final String getCurrentPlayerId(GoogleApiClient googleApiClient) {
        return Games.zza(googleApiClient).zzb(true);
    }

    @Override // com.google.android.gms.games.Players
    public final Player getCurrentPlayer(GoogleApiClient googleApiClient) {
        return Games.zza(googleApiClient).zzax();
    }

    @Override // com.google.android.gms.games.Players
    public final PendingResult<Players.LoadPlayersResult> loadPlayer(GoogleApiClient googleApiClient, String str) {
        return googleApiClient.enqueue(new zzbe(this, googleApiClient, str));
    }

    @Override // com.google.android.gms.games.Players
    public final PendingResult<Players.LoadPlayersResult> loadPlayer(GoogleApiClient googleApiClient, String str, boolean z) {
        return googleApiClient.enqueue(new zzbf(this, googleApiClient, str, z));
    }

    @Override // com.google.android.gms.games.Players
    public final PendingResult<Players.LoadPlayersResult> loadInvitablePlayers(GoogleApiClient googleApiClient, int i, boolean z) {
        return googleApiClient.enqueue(new zzbg(this, googleApiClient, i, z));
    }

    @Override // com.google.android.gms.games.Players
    public final PendingResult<Players.LoadPlayersResult> loadMoreInvitablePlayers(GoogleApiClient googleApiClient, int i) {
        return googleApiClient.enqueue(new zzbh(this, googleApiClient, i));
    }

    @Override // com.google.android.gms.games.Players
    public final PendingResult<Players.LoadPlayersResult> loadRecentlyPlayedWithPlayers(GoogleApiClient googleApiClient, int i, boolean z) {
        return googleApiClient.enqueue(new zzbi(this, googleApiClient, i, z));
    }

    @Override // com.google.android.gms.games.Players
    public final PendingResult<Players.LoadPlayersResult> loadMoreRecentlyPlayedWithPlayers(GoogleApiClient googleApiClient, int i) {
        return googleApiClient.enqueue(new zzbj(this, googleApiClient, i));
    }

    @Override // com.google.android.gms.games.Players
    public final PendingResult<Players.LoadPlayersResult> loadConnectedPlayers(GoogleApiClient googleApiClient, boolean z) {
        return googleApiClient.enqueue(new zzbk(this, googleApiClient, z));
    }

    @Override // com.google.android.gms.games.Players
    public final Intent getCompareProfileIntent(GoogleApiClient googleApiClient, Player player) {
        return Games.zza(googleApiClient).zzb(new PlayerEntity(player));
    }

    @Override // com.google.android.gms.games.Players
    public final Intent getPlayerSearchIntent(GoogleApiClient googleApiClient) {
        return Games.zza(googleApiClient).zzbm();
    }
}

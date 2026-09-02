package com.google.android.gms.games;

import androidx.annotation.NonNull;

/* JADX INFO: loaded from: classes.dex */
final class zzw implements com.google.android.gms.games.internal.zzbm<GamesMetadata.LoadGamesResult> {
    zzw() {
    }

    @Override // com.google.android.gms.games.internal.zzbm
    public final /* synthetic */ void release(@NonNull GamesMetadata.LoadGamesResult loadGamesResult) {
        GamesMetadata.LoadGamesResult loadGamesResult2 = loadGamesResult;
        if (loadGamesResult2.getGames() != null) {
            loadGamesResult2.getGames().release();
        }
    }
}

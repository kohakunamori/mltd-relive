package com.google.android.gms.games;

import androidx.annotation.NonNull;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer;

/* JADX INFO: loaded from: classes.dex */
final class zzcf implements com.google.android.gms.games.internal.zzbm<TurnBasedMultiplayer.LoadMatchesResult> {
    zzcf() {
    }

    @Override // com.google.android.gms.games.internal.zzbm
    public final /* synthetic */ void release(@NonNull TurnBasedMultiplayer.LoadMatchesResult loadMatchesResult) {
        TurnBasedMultiplayer.LoadMatchesResult loadMatchesResult2 = loadMatchesResult;
        if (loadMatchesResult2.getMatches() != null) {
            loadMatchesResult2.getMatches().release();
        }
    }
}

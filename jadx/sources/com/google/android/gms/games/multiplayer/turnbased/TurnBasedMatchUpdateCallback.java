package com.google.android.gms.games.multiplayer.turnbased;

import androidx.annotation.NonNull;

/* JADX INFO: loaded from: classes.dex */
public abstract class TurnBasedMatchUpdateCallback implements OnTurnBasedMatchUpdateReceivedListener {
    @Override // com.google.android.gms.games.multiplayer.turnbased.OnTurnBasedMatchUpdateReceivedListener
    public abstract void onTurnBasedMatchReceived(@NonNull TurnBasedMatch turnBasedMatch);

    @Override // com.google.android.gms.games.multiplayer.turnbased.OnTurnBasedMatchUpdateReceivedListener
    public abstract void onTurnBasedMatchRemoved(@NonNull String str);
}

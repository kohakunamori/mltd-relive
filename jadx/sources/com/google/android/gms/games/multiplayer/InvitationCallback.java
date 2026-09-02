package com.google.android.gms.games.multiplayer;

import androidx.annotation.NonNull;

/* JADX INFO: loaded from: classes.dex */
public abstract class InvitationCallback implements OnInvitationReceivedListener {
    @Override // com.google.android.gms.games.multiplayer.OnInvitationReceivedListener
    public abstract void onInvitationReceived(@NonNull Invitation invitation);

    @Override // com.google.android.gms.games.multiplayer.OnInvitationReceivedListener
    public abstract void onInvitationRemoved(@NonNull String str);
}

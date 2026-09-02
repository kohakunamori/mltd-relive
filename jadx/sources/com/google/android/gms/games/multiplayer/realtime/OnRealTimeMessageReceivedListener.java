package com.google.android.gms.games.multiplayer.realtime;

import androidx.annotation.NonNull;

/* JADX INFO: loaded from: classes.dex */
public interface OnRealTimeMessageReceivedListener extends RealTimeMessageReceivedListener {
    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMessageReceivedListener
    void onRealTimeMessageReceived(@NonNull RealTimeMessage realTimeMessage);
}

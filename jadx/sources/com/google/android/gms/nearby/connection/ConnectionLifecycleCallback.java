package com.google.android.gms.nearby.connection;

import androidx.annotation.NonNull;

/* JADX INFO: loaded from: classes.dex */
public abstract class ConnectionLifecycleCallback {
    public abstract void onConnectionInitiated(@NonNull String str, @NonNull ConnectionInfo connectionInfo);

    public abstract void onConnectionResult(@NonNull String str, @NonNull ConnectionResolution connectionResolution);

    public abstract void onDisconnected(@NonNull String str);
}

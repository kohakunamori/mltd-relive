package com.google.android.gms.nearby.connection;

import androidx.annotation.NonNull;

/* JADX INFO: loaded from: classes.dex */
public abstract class EndpointDiscoveryCallback {
    public abstract void onEndpointFound(@NonNull String str, @NonNull DiscoveredEndpointInfo discoveredEndpointInfo);

    public abstract void onEndpointLost(@NonNull String str);
}

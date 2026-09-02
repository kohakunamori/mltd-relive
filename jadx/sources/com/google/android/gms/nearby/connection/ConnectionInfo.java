package com.google.android.gms.nearby.connection;

import androidx.annotation.NonNull;

/* JADX INFO: loaded from: classes.dex */
public final class ConnectionInfo {
    private final String zzq;
    private final String zzr;
    private final boolean zzs;

    @Deprecated
    public ConnectionInfo(String str, String str2, boolean z) {
        this.zzq = str;
        this.zzr = str2;
        this.zzs = z;
    }

    @NonNull
    public final String getAuthenticationToken() {
        return this.zzr;
    }

    @NonNull
    public final String getEndpointName() {
        return this.zzq;
    }

    public final boolean isIncomingConnection() {
        return this.zzs;
    }
}

package com.google.android.gms.common.internal;

import android.content.Context;
import android.util.SparseIntArray;
import androidx.annotation.NonNull;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.common.GoogleApiAvailabilityLight;
import com.google.android.gms.common.api.Api;

/* JADX INFO: loaded from: classes.dex */
public class GoogleApiAvailabilityCache {
    private final SparseIntArray zaos;
    private GoogleApiAvailabilityLight zaot;

    public GoogleApiAvailabilityCache() {
        this(GoogleApiAvailability.getInstance());
    }

    public GoogleApiAvailabilityCache(@NonNull GoogleApiAvailabilityLight googleApiAvailabilityLight) {
        this.zaos = new SparseIntArray();
        Preconditions.checkNotNull(googleApiAvailabilityLight);
        this.zaot = googleApiAvailabilityLight;
    }

    public int getClientAvailability(@NonNull Context context, @NonNull Api.Client client) {
        Preconditions.checkNotNull(context);
        Preconditions.checkNotNull(client);
        if (!client.requiresGooglePlayServices()) {
            return 0;
        }
        int minApkVersion = client.getMinApkVersion();
        int iIsGooglePlayServicesAvailable = this.zaos.get(minApkVersion, -1);
        if (iIsGooglePlayServicesAvailable != -1) {
            return iIsGooglePlayServicesAvailable;
        }
        for (int i = 0; i < this.zaos.size(); i++) {
            int iKeyAt = this.zaos.keyAt(i);
            if (iKeyAt > minApkVersion && this.zaos.get(iKeyAt) == 0) {
                iIsGooglePlayServicesAvailable = 0;
                break;
            }
        }
        if (iIsGooglePlayServicesAvailable == -1) {
            iIsGooglePlayServicesAvailable = this.zaot.isGooglePlayServicesAvailable(context, minApkVersion);
        }
        this.zaos.put(minApkVersion, iIsGooglePlayServicesAvailable);
        return iIsGooglePlayServicesAvailable;
    }

    public void flush() {
        this.zaos.clear();
    }
}

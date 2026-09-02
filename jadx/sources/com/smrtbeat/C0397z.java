package com.smrtbeat;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

/* JADX INFO: renamed from: com.smrtbeat.z */
/* JADX INFO: loaded from: classes.dex */
class C0397z {
    C0397z() {
    }

    /* JADX INFO: renamed from: a */
    static String m355a(Context context) {
        return m356a(context, 0);
    }

    /* JADX INFO: renamed from: a */
    private static String m356a(Context context, int i) {
        if (context.getPackageManager().checkPermission("android.permission.ACCESS_NETWORK_STATE", C0382j.f243p) != 0) {
            return "no permission";
        }
        NetworkInfo networkInfo = ((ConnectivityManager) context.getSystemService("connectivity")).getNetworkInfo(i);
        return String.valueOf(networkInfo != null && networkInfo.isConnected());
    }

    /* JADX INFO: renamed from: b */
    static String m357b(Context context) {
        return m356a(context, 1);
    }
}

package com.smrtbeat;

import android.annotation.TargetApi;
import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkInfo;
import android.os.Build;

/* JADX INFO: renamed from: com.smrtbeat.x */
/* JADX INFO: loaded from: classes.dex */
@TargetApi(23)
class C0395x {
    C0395x() {
    }

    /* JADX INFO: renamed from: a */
    static int m350a() {
        return Build.VERSION.PREVIEW_SDK_INT;
    }

    /* JADX INFO: renamed from: a */
    static String m351a(Context context) {
        return m352a(context, 0);
    }

    /* JADX INFO: renamed from: a */
    private static String m352a(Context context, int i) {
        if (context.getPackageManager().checkPermission("android.permission.ACCESS_NETWORK_STATE", C0382j.f243p) != 0) {
            return "no permission";
        }
        ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService("connectivity");
        Network[] allNetworks = connectivityManager.getAllNetworks();
        if (allNetworks != null) {
            for (Network network : allNetworks) {
                NetworkInfo networkInfo = connectivityManager.getNetworkInfo(network);
                if (networkInfo != null && networkInfo.getType() == i) {
                    return String.valueOf(networkInfo.isConnected());
                }
            }
        }
        return String.valueOf(false);
    }

    /* JADX INFO: renamed from: b */
    static String m353b(Context context) {
        return m352a(context, 1);
    }
}

package com.unity3d.player;

import android.app.Activity;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.content.pm.PackageItemInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;

/* JADX INFO: renamed from: com.unity3d.player.h */
/* JADX INFO: loaded from: classes.dex */
public final class C0459h implements InterfaceC0456e {
    /* JADX INFO: renamed from: a */
    private static boolean m506a(PackageItemInfo packageItemInfo) {
        try {
            return packageItemInfo.metaData.getBoolean("unityplayer.SkipPermissionsDialog");
        } catch (Exception unused) {
            return false;
        }
    }

    @Override // com.unity3d.player.InterfaceC0456e
    /* JADX INFO: renamed from: a */
    public final void mo504a(Activity activity, String str) {
        if (activity == null || str == null) {
            return;
        }
        FragmentManager fragmentManager = activity.getFragmentManager();
        if (fragmentManager.findFragmentByTag("96489") == null) {
            FragmentC0460i fragmentC0460i = new FragmentC0460i();
            Bundle bundle = new Bundle();
            bundle.putString("PermissionNames", str);
            fragmentC0460i.setArguments(bundle);
            FragmentTransaction fragmentTransactionBeginTransaction = fragmentManager.beginTransaction();
            fragmentTransactionBeginTransaction.add(0, fragmentC0460i, "96489");
            fragmentTransactionBeginTransaction.commit();
        }
    }

    @Override // com.unity3d.player.InterfaceC0456e
    /* JADX INFO: renamed from: a */
    public final boolean mo505a(Activity activity) {
        try {
            PackageManager packageManager = activity.getPackageManager();
            return m506a(packageManager.getActivityInfo(activity.getComponentName(), 128)) || m506a(packageManager.getApplicationInfo(activity.getPackageName(), 128));
        } catch (Exception unused) {
            return false;
        }
    }
}

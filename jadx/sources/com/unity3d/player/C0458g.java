package com.unity3d.player;

import android.util.Log;

/* JADX INFO: renamed from: com.unity3d.player.g */
/* JADX INFO: loaded from: classes.dex */
final class C0458g {

    /* JADX INFO: renamed from: a */
    protected static boolean f650a;

    protected static void Log(int i, String str) {
        if (f650a) {
            return;
        }
        if (i == 6) {
            Log.e("Unity", str);
        }
        if (i == 5) {
            Log.w("Unity", str);
        }
    }
}

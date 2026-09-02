package com.unity3d.player;

import android.os.Build;

/* JADX INFO: renamed from: com.unity3d.player.j */
/* JADX INFO: loaded from: classes.dex */
public final class C0461j {

    /* JADX INFO: renamed from: a */
    static final boolean f651a;

    /* JADX INFO: renamed from: b */
    static final boolean f652b;

    /* JADX INFO: renamed from: c */
    static final boolean f653c;

    /* JADX INFO: renamed from: d */
    static final InterfaceC0456e f654d;

    static {
        f651a = Build.VERSION.SDK_INT >= 19;
        f652b = Build.VERSION.SDK_INT >= 21;
        boolean z = Build.VERSION.SDK_INT >= 23;
        f653c = z;
        f654d = z ? new C0459h() : null;
    }
}

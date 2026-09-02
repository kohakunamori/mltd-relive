package com.smrtbeat;

import android.content.Context;
import android.graphics.Bitmap;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/* JADX INFO: renamed from: com.smrtbeat.j */
/* JADX INFO: loaded from: classes.dex */
class C0382j {

    /* JADX INFO: renamed from: A */
    static int f193A = 0;

    /* JADX INFO: renamed from: a */
    static final String f219a = "https://api.smbeat.jp/api/errors";

    /* JADX INFO: renamed from: b */
    static final String f221b = "https://images.smbeat.jp/api/upload";

    /* JADX INFO: renamed from: c */
    static final String f223c = "https://minidumps.smbeat.jp/api/errors/multi";

    /* JADX INFO: renamed from: d */
    static final String f225d = "https://control.smbeat.jp/api/remote";

    /* JADX INFO: renamed from: e */
    static final String f227e = "https://abort-count.smbeat.jp/api/abort";

    /* JADX INFO: renamed from: f */
    static final long f229f = 21600000;

    /* JADX INFO: renamed from: g */
    static final int f231g = 140;

    /* JADX INFO: renamed from: h */
    static final int f233h = 128;

    /* JADX INFO: renamed from: i */
    static final int f235i = 1024;

    /* JADX INFO: renamed from: j */
    static final long f237j = 5000;

    /* JADX INFO: renamed from: k */
    static final int f238k = 3;

    /* JADX INFO: renamed from: l */
    static final int f239l = 65536;

    /* JADX INFO: renamed from: m */
    static final int f240m = 500;

    /* JADX INFO: renamed from: n */
    static final String f241n = "1.23.1";

    /* JADX INFO: renamed from: o */
    static String f242o = "";

    /* JADX INFO: renamed from: p */
    static String f243p = "";

    /* JADX INFO: renamed from: q */
    static String f244q = "";

    /* JADX INFO: renamed from: r */
    static String f245r = "";

    /* JADX INFO: renamed from: s */
    static String f246s = "";

    /* JADX INFO: renamed from: t */
    static String f247t = "";

    /* JADX INFO: renamed from: u */
    static String f248u = null;

    /* JADX INFO: renamed from: v */
    static String f249v = "";

    /* JADX INFO: renamed from: w */
    static String f250w = "";

    /* JADX INFO: renamed from: x */
    static boolean f251x;

    /* JADX INFO: renamed from: y */
    static int f252y;

    /* JADX INFO: renamed from: z */
    static int f253z;

    /* JADX INFO: renamed from: B */
    static long f194B = System.currentTimeMillis();

    /* JADX INFO: renamed from: C */
    static String f195C = "";

    /* JADX INFO: renamed from: D */
    static String f196D = "";

    /* JADX INFO: renamed from: E */
    static boolean f197E = false;

    /* JADX INFO: renamed from: F */
    static boolean f198F = false;

    /* JADX INFO: renamed from: G */
    static int f199G = 0;

    /* JADX INFO: renamed from: H */
    static final List<C0372d> f200H = Collections.synchronizedList(new ArrayList(128));

    /* JADX INFO: renamed from: I */
    static final Map<String, String> f201I = Collections.synchronizedMap(new HashMap());

    /* JADX INFO: renamed from: J */
    static String f202J = "";

    /* JADX INFO: renamed from: K */
    static boolean f203K = false;

    /* JADX INFO: renamed from: L */
    static String f204L = "";

    /* JADX INFO: renamed from: M */
    static String f205M = "";

    /* JADX INFO: renamed from: N */
    static boolean f206N = false;

    /* JADX INFO: renamed from: O */
    static RunnableC0378g f207O = null;

    /* JADX INFO: renamed from: P */
    static Thread f208P = null;

    /* JADX INFO: renamed from: Q */
    static boolean f209Q = false;

    /* JADX INFO: renamed from: R */
    static boolean f210R = true;

    /* JADX INFO: renamed from: S */
    static final List<String> f211S = Collections.synchronizedList(new ArrayList());

    /* JADX INFO: renamed from: T */
    static int f212T = 5;

    /* JADX INFO: renamed from: U */
    static String f213U = "";

    /* JADX INFO: renamed from: V */
    static Bitmap f214V = null;

    /* JADX INFO: renamed from: W */
    static Bitmap f215W = null;

    /* JADX INFO: renamed from: X */
    static long f216X = 0;

    /* JADX INFO: renamed from: Y */
    static a f217Y = a.ENone;

    /* JADX INFO: renamed from: Z */
    static boolean f218Z = false;

    /* JADX INFO: renamed from: a0 */
    static String f220a0 = null;

    /* JADX INFO: renamed from: b0 */
    static String f222b0 = null;

    /* JADX INFO: renamed from: c0 */
    static String f224c0 = null;

    /* JADX INFO: renamed from: d0 */
    static boolean f226d0 = false;

    /* JADX INFO: renamed from: e0 */
    static boolean f228e0 = false;

    /* JADX INFO: renamed from: f0 */
    static boolean f230f0 = false;

    /* JADX INFO: renamed from: g0 */
    static boolean f232g0 = false;

    /* JADX INFO: renamed from: h0 */
    static Thread f234h0 = null;

    /* JADX INFO: renamed from: i0 */
    private static WeakReference<Context> f236i0 = null;

    /* JADX INFO: renamed from: com.smrtbeat.j$a */
    enum a {
        ENone,
        ENative,
        EGles
    }

    C0382j() {
    }

    /* JADX INFO: renamed from: a */
    static Context m217a() {
        WeakReference<Context> weakReference = f236i0;
        if (weakReference == null) {
            return null;
        }
        return weakReference.get();
    }

    /* JADX INFO: renamed from: a */
    static void m218a(Context context) {
        f236i0 = new WeakReference<>(context);
    }
}

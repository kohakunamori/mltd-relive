package com.smrtbeat;

import android.content.Context;
import java.lang.reflect.Method;

/* JADX INFO: renamed from: com.smrtbeat.t */
/* JADX INFO: loaded from: classes.dex */
class C0391t {
    C0391t() {
    }

    /* JADX INFO: renamed from: a */
    static String m345a(Context context) {
        try {
            try {
                Class<?> cls = Class.forName("com.google.android.gms.ads.identifier.AdvertisingIdClient");
                Object objInvoke = cls.getMethod("getAdvertisingIdInfo", Context.class).invoke(cls, context);
                Method method = objInvoke.getClass().getMethod("getId", new Class[0]);
                if (method != null) {
                    return (String) method.invoke(objInvoke, new Object[0]);
                }
                return null;
            } catch (IllegalStateException | NoClassDefFoundError | NoSuchMethodError unused) {
                return null;
            }
        } catch (Throwable th) {
            C0377f0.m160a(C0377f0.e.ERROR, "error to access google play service", th);
            return null;
        }
    }
}

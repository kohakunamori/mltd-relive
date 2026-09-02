package com.unity3d.player;

import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes.dex */
public class GoogleVrApi {

    /* JADX INFO: renamed from: a */
    private static AtomicReference f449a = new AtomicReference();

    private GoogleVrApi() {
    }

    /* JADX INFO: renamed from: a */
    static void m362a() {
        f449a.set(null);
    }

    /* JADX INFO: renamed from: a */
    static void m363a(InterfaceC0457f interfaceC0457f) {
        f449a.compareAndSet(null, new GoogleVrProxy(interfaceC0457f));
    }

    /* JADX INFO: renamed from: b */
    static GoogleVrProxy m364b() {
        return (GoogleVrProxy) f449a.get();
    }

    public static GoogleVrVideo getGoogleVrVideo() {
        return (GoogleVrVideo) f449a.get();
    }
}

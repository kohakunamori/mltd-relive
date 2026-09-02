package com.smrtbeat;

/* JADX INFO: renamed from: com.smrtbeat.e0 */
/* JADX INFO: loaded from: classes.dex */
class C0375e0 {
    C0375e0() {
    }

    /* JADX INFO: renamed from: a */
    static C0369b0 m145a(InterfaceRunnableC0371c0 interfaceRunnableC0371c0, long j) {
        Thread thread = new Thread(interfaceRunnableC0371c0);
        thread.start();
        try {
            if (j > 0) {
                thread.join(j);
            } else {
                thread.join();
            }
        } catch (InterruptedException unused) {
        }
        C0369b0 c0369b0Mo129a = interfaceRunnableC0371c0.mo129a();
        return c0369b0Mo129a == null ? new C0369b0() : c0369b0Mo129a;
    }
}

package com.unity3d.player;

/* JADX INFO: renamed from: com.unity3d.player.n */
/* JADX INFO: loaded from: classes.dex */
final class C0465n {

    /* JADX INFO: renamed from: a */
    private static boolean f675a;

    /* JADX INFO: renamed from: b */
    private boolean f676b = false;

    /* JADX INFO: renamed from: c */
    private boolean f677c = false;

    /* JADX INFO: renamed from: d */
    private boolean f678d = true;

    /* JADX INFO: renamed from: e */
    private boolean f679e = false;

    C0465n() {
    }

    /* JADX INFO: renamed from: a */
    static void m521a() {
        f675a = true;
    }

    /* JADX INFO: renamed from: b */
    static void m522b() {
        f675a = false;
    }

    /* JADX INFO: renamed from: c */
    static boolean m523c() {
        return f675a;
    }

    /* JADX INFO: renamed from: a */
    final void m524a(boolean z) {
        this.f676b = z;
    }

    /* JADX INFO: renamed from: b */
    final void m525b(boolean z) {
        this.f678d = z;
    }

    /* JADX INFO: renamed from: c */
    final void m526c(boolean z) {
        this.f679e = z;
    }

    /* JADX INFO: renamed from: d */
    final void m527d(boolean z) {
        this.f677c = z;
    }

    /* JADX INFO: renamed from: d */
    final boolean m528d() {
        return this.f678d;
    }

    /* JADX INFO: renamed from: e */
    final boolean m529e() {
        return this.f679e;
    }

    /* JADX INFO: renamed from: f */
    final boolean m530f() {
        return f675a && this.f676b && !this.f678d && !this.f677c;
    }

    /* JADX INFO: renamed from: g */
    final boolean m531g() {
        return this.f677c;
    }

    public final String toString() {
        return super.toString();
    }
}

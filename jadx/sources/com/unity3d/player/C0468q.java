package com.unity3d.player;

import android.app.Activity;
import android.content.Context;
import java.util.concurrent.Semaphore;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/* JADX INFO: renamed from: com.unity3d.player.q */
/* JADX INFO: loaded from: classes.dex */
final class C0468q {

    /* JADX INFO: renamed from: a */
    private UnityPlayer f715a;

    /* JADX INFO: renamed from: c */
    private a f717c;

    /* JADX INFO: renamed from: b */
    private Context f716b = null;

    /* JADX INFO: renamed from: d */
    private final Semaphore f718d = new Semaphore(0);

    /* JADX INFO: renamed from: e */
    private final Lock f719e = new ReentrantLock();

    /* JADX INFO: renamed from: f */
    private SurfaceHolderCallbackC0467p f720f = null;

    /* JADX INFO: renamed from: g */
    private int f721g = 2;

    /* JADX INFO: renamed from: h */
    private boolean f722h = false;

    /* JADX INFO: renamed from: i */
    private boolean f723i = false;

    /* JADX INFO: renamed from: com.unity3d.player.q$1, reason: invalid class name */
    final class AnonymousClass1 implements Runnable {

        /* JADX INFO: renamed from: a */
        final /* synthetic */ String f724a;

        /* JADX INFO: renamed from: b */
        final /* synthetic */ int f725b;

        /* JADX INFO: renamed from: c */
        final /* synthetic */ int f726c;

        /* JADX INFO: renamed from: d */
        final /* synthetic */ int f727d;

        /* JADX INFO: renamed from: e */
        final /* synthetic */ boolean f728e;

        /* JADX INFO: renamed from: f */
        final /* synthetic */ long f729f;

        /* JADX INFO: renamed from: g */
        final /* synthetic */ long f730g;

        AnonymousClass1(String str, int i, int i2, int i3, boolean z, long j, long j2) {
            this.f724a = str;
            this.f725b = i;
            this.f726c = i2;
            this.f727d = i3;
            this.f728e = z;
            this.f729f = j;
            this.f730g = j2;
        }

        @Override // java.lang.Runnable
        public final void run() {
            if (C0468q.this.f720f != null) {
                C0458g.Log(5, "Video already playing");
                C0468q.this.f721g = 2;
                C0468q.this.f718d.release();
            } else {
                C0468q.this.f720f = new SurfaceHolderCallbackC0467p(C0468q.this.f716b, this.f724a, this.f725b, this.f726c, this.f727d, this.f728e, this.f729f, this.f730g, new SurfaceHolderCallbackC0467p.a() { // from class: com.unity3d.player.q.1.1
                    @Override // com.unity3d.player.SurfaceHolderCallbackC0467p.a
                    /* JADX INFO: renamed from: a */
                    public final void mo542a(int i) {
                        C0468q.this.f719e.lock();
                        C0468q.this.f721g = i;
                        if (i == 3 && C0468q.this.f723i) {
                            C0468q.this.runOnUiThread(new Runnable() { // from class: com.unity3d.player.q.1.1.1
                                @Override // java.lang.Runnable
                                public final void run() {
                                    C0468q.this.m550d();
                                    C0468q.this.f715a.resume();
                                }
                            });
                        }
                        if (i != 0) {
                            C0468q.this.f718d.release();
                        }
                        C0468q.this.f719e.unlock();
                    }
                });
                if (C0468q.this.f720f != null) {
                    C0468q.this.f715a.addView(C0468q.this.f720f);
                }
            }
        }
    }

    /* JADX INFO: renamed from: com.unity3d.player.q$a */
    public interface a {
        /* JADX INFO: renamed from: a */
        void mo447a();
    }

    C0468q(UnityPlayer unityPlayer) {
        this.f715a = null;
        this.f715a = unityPlayer;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: d */
    public void m550d() {
        if (this.f720f != null) {
            this.f715a.removeViewFromPlayer(this.f720f);
            this.f723i = false;
            this.f720f.destroyPlayer();
            this.f720f = null;
            if (this.f717c != null) {
                this.f717c.mo447a();
            }
        }
    }

    /* JADX INFO: renamed from: h */
    static /* synthetic */ boolean m554h(C0468q c0468q) {
        c0468q.f723i = true;
        return true;
    }

    /* JADX INFO: renamed from: a */
    public final void m555a() {
        this.f719e.lock();
        if (this.f720f != null) {
            if (this.f721g == 0) {
                this.f720f.CancelOnPrepare();
            } else if (this.f723i) {
                this.f722h = this.f720f.m541a();
                if (!this.f722h) {
                    this.f720f.pause();
                }
            }
        }
        this.f719e.unlock();
    }

    /* JADX INFO: renamed from: a */
    public final boolean m556a(Context context, String str, int i, int i2, int i3, boolean z, long j, long j2, a aVar) {
        this.f719e.lock();
        this.f717c = aVar;
        this.f716b = context;
        this.f718d.drainPermits();
        this.f721g = 2;
        runOnUiThread(new AnonymousClass1(str, i, i2, i3, z, j, j2));
        boolean z2 = false;
        try {
            this.f719e.unlock();
            this.f718d.acquire();
            this.f719e.lock();
            if (this.f721g != 2) {
                z2 = true;
            }
        } catch (InterruptedException unused) {
        }
        runOnUiThread(new Runnable() { // from class: com.unity3d.player.q.2
            @Override // java.lang.Runnable
            public final void run() {
                C0468q.this.f715a.pause();
            }
        });
        runOnUiThread((!z2 || this.f721g == 3) ? new Runnable() { // from class: com.unity3d.player.q.4
            @Override // java.lang.Runnable
            public final void run() {
                C0468q.this.m550d();
                C0468q.this.f715a.resume();
            }
        } : new Runnable() { // from class: com.unity3d.player.q.3
            @Override // java.lang.Runnable
            public final void run() {
                if (C0468q.this.f720f != null) {
                    C0468q.this.f715a.addViewToPlayer(C0468q.this.f720f, true);
                    C0468q.m554h(C0468q.this);
                    C0468q.this.f720f.requestFocus();
                }
            }
        });
        this.f719e.unlock();
        return z2;
    }

    /* JADX INFO: renamed from: b */
    public final void m557b() {
        this.f719e.lock();
        if (this.f720f != null && this.f723i && !this.f722h) {
            this.f720f.start();
        }
        this.f719e.unlock();
    }

    /* JADX INFO: renamed from: c */
    public final void m558c() {
        this.f719e.lock();
        if (this.f720f != null) {
            this.f720f.updateVideoLayout();
        }
        this.f719e.unlock();
    }

    protected final void runOnUiThread(Runnable runnable) {
        if (this.f716b instanceof Activity) {
            ((Activity) this.f716b).runOnUiThread(runnable);
        } else {
            C0458g.Log(5, "Not running from an Activity; Ignoring execution request...");
        }
    }
}

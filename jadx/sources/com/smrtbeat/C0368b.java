package com.smrtbeat;

import android.app.Activity;
import android.os.Handler;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/* JADX INFO: renamed from: com.smrtbeat.b */
/* JADX INFO: loaded from: classes.dex */
class C0368b {

    /* JADX INFO: renamed from: d */
    private static C0368b f57d = new C0368b();

    /* JADX INFO: renamed from: e */
    private static final long f58e = 1000;

    /* JADX INFO: renamed from: a */
    private Map<Activity, c> f59a = new HashMap();

    /* JADX INFO: renamed from: b */
    private Handler f60b = new Handler(C0382j.m217a().getMainLooper());

    /* JADX INFO: renamed from: c */
    private List<WeakReference<e>> f61c = new ArrayList();

    /* JADX INFO: renamed from: com.smrtbeat.b$a */
    class a implements Runnable {

        /* JADX INFO: renamed from: a */
        final /* synthetic */ Activity f62a;

        a(Activity activity) {
            this.f62a = activity;
        }

        @Override // java.lang.Runnable
        public void run() {
            C0368b.this.m83a(this.f62a, d.ON_PAUSE_TIMER);
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.b$b */
    static /* synthetic */ class b {

        /* JADX INFO: renamed from: a */
        static final /* synthetic */ int[] f64a;

        static {
            int[] iArr = new int[d.values().length];
            f64a = iArr;
            try {
                iArr[d.ON_RESUME.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f64a[d.ON_PAUSE.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                f64a[d.ON_STOP.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
            try {
                f64a[d.ON_PAUSE_TIMER.ordinal()] = 4;
            } catch (NoSuchFieldError unused4) {
            }
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.b$c */
    enum c {
        RESUME,
        PAUSE,
        STOP,
        PAUSE_TIMEOUT
    }

    /* JADX INFO: renamed from: com.smrtbeat.b$d */
    enum d {
        ON_RESUME,
        ON_PAUSE,
        ON_STOP,
        ON_PAUSE_TIMER
    }

    /* JADX INFO: renamed from: com.smrtbeat.b$e */
    interface e {
        /* JADX INFO: renamed from: a */
        void mo78a();

        /* JADX INFO: renamed from: b */
        void mo79b();
    }

    C0368b() {
    }

    /* JADX INFO: renamed from: a */
    static C0368b m82a() {
        return f57d;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: a */
    public synchronized void m83a(Activity activity, d dVar) {
        Map<Activity, c> map;
        c cVar;
        if (activity == null) {
            return;
        }
        boolean zM85b = m85b();
        switch (b.f64a[dVar.ordinal()]) {
            case 1:
                map = this.f59a;
                cVar = c.RESUME;
                map.put(activity, cVar);
                break;
            case 2:
                if (this.f59a.get(activity) != null) {
                    map = this.f59a;
                    cVar = c.PAUSE;
                    map.put(activity, cVar);
                }
                break;
            case 3:
                if (this.f59a.get(activity) != null) {
                    this.f59a.remove(activity);
                }
                break;
            case 4:
                c cVar2 = this.f59a.get(activity);
                if (cVar2 != null && cVar2 == c.PAUSE) {
                    map = this.f59a;
                    cVar = c.PAUSE_TIMEOUT;
                    map.put(activity, cVar);
                }
                break;
        }
        boolean zM85b2 = m85b();
        if (zM85b != zM85b2) {
            C0377f0.e eVar = C0377f0.e.DEBUG;
            StringBuilder sb = new StringBuilder();
            sb.append("Updated Active Status : ");
            sb.append(zM85b2 ? "true" : "false");
            C0377f0.m159a(eVar, sb.toString());
            m88a(zM85b2);
        }
    }

    /* JADX INFO: renamed from: b */
    private boolean m85b() {
        for (c cVar : this.f59a.values()) {
            if (cVar == c.RESUME || cVar == c.PAUSE) {
                return true;
            }
        }
        return false;
    }

    /* JADX INFO: renamed from: a */
    void m86a(Activity activity) {
        m83a(activity, d.ON_PAUSE);
        this.f60b.postDelayed(new a(activity), f58e);
    }

    /* JADX INFO: renamed from: a */
    void m87a(e eVar) {
        synchronized (this.f61c) {
            this.f61c.add(new WeakReference<>(eVar));
        }
    }

    /* JADX INFO: renamed from: a */
    void m88a(boolean z) {
        ArrayList<e> arrayList = new ArrayList();
        synchronized (this.f61c) {
            for (int size = this.f61c.size() - 1; size >= 0; size--) {
                e eVar = this.f61c.get(size).get();
                if (eVar == null) {
                    this.f61c.remove(size);
                } else {
                    arrayList.add(eVar);
                }
            }
        }
        for (e eVar2 : arrayList) {
            if (z) {
                try {
                    eVar2.mo78a();
                } catch (Exception e2) {
                    C0377f0.m160a(C0377f0.e.WARN, "failed to call callbacks.", e2);
                }
            } else {
                eVar2.mo79b();
            }
        }
    }

    /* JADX INFO: renamed from: b */
    void m89b(Activity activity) {
        m83a(activity, d.ON_RESUME);
    }

    /* JADX INFO: renamed from: c */
    void m90c(Activity activity) {
        m83a(activity, d.ON_STOP);
    }
}

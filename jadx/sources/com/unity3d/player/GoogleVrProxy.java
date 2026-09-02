package com.unity3d.player;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.view.Surface;
import android.view.SurfaceView;
import android.view.View;
import com.google.android.gms.drive.DriveFile;
import java.lang.reflect.Array;
import java.util.Iterator;
import java.util.Vector;
import java.util.concurrent.atomic.AtomicLong;

/* JADX INFO: loaded from: classes.dex */
class GoogleVrProxy extends C0454c implements GoogleVrVideo {

    /* JADX INFO: renamed from: f */
    private boolean f450f;

    /* JADX INFO: renamed from: g */
    private boolean f451g;

    /* JADX INFO: renamed from: h */
    private Runnable f452h;

    /* JADX INFO: renamed from: i */
    private Vector f453i;

    /* JADX INFO: renamed from: j */
    private SurfaceView f454j;

    /* JADX INFO: renamed from: k */
    private C0418a f455k;

    /* JADX INFO: renamed from: l */
    private Thread f456l;

    /* JADX INFO: renamed from: m */
    private Handler f457m;

    /* JADX INFO: renamed from: com.unity3d.player.GoogleVrProxy$a */
    class C0418a {

        /* JADX INFO: renamed from: a */
        public boolean f469a = false;

        /* JADX INFO: renamed from: b */
        public boolean f470b = false;

        /* JADX INFO: renamed from: c */
        public boolean f471c = false;

        /* JADX INFO: renamed from: d */
        public boolean f472d = false;

        /* JADX INFO: renamed from: e */
        public boolean f473e = true;

        /* JADX INFO: renamed from: f */
        public boolean f474f = false;

        C0418a() {
        }

        /* JADX INFO: renamed from: a */
        public final boolean m380a() {
            return this.f469a && this.f470b;
        }

        /* JADX INFO: renamed from: b */
        public final void m381b() {
            this.f469a = false;
            this.f470b = false;
            this.f472d = false;
            this.f473e = true;
            this.f474f = false;
        }
    }

    public GoogleVrProxy(InterfaceC0457f interfaceC0457f) {
        super("Google VR", interfaceC0457f);
        this.f450f = false;
        this.f451g = false;
        this.f452h = null;
        this.f453i = new Vector();
        this.f454j = null;
        this.f455k = new C0418a();
        this.f456l = null;
        this.f457m = new Handler(Looper.getMainLooper()) { // from class: com.unity3d.player.GoogleVrProxy.1
            @Override // android.os.Handler
            public final void handleMessage(Message message) {
                if (message.what != 135711) {
                    super.handleMessage(message);
                }
                switch (message.arg1) {
                    case 2147483645:
                        Iterator it = GoogleVrProxy.this.f453i.iterator();
                        while (it.hasNext()) {
                            ((GoogleVrVideo.GoogleVrVideoCallbacks) it.next()).onFrameAvailable();
                        }
                        break;
                    case 2147483646:
                        Surface surface = (Surface) message.obj;
                        Iterator it2 = GoogleVrProxy.this.f453i.iterator();
                        while (it2.hasNext()) {
                            ((GoogleVrVideo.GoogleVrVideoCallbacks) it2.next()).onSurfaceAvailable(surface);
                        }
                        break;
                    default:
                        super.handleMessage(message);
                        break;
                }
            }
        };
        initVrJni();
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: a */
    public void m367a(boolean z) {
        this.f455k.f472d = z;
    }

    /* JADX INFO: renamed from: a */
    private static boolean m368a(int i) {
        return Build.VERSION.SDK_INT >= i;
    }

    /* JADX INFO: renamed from: a */
    private boolean m369a(ClassLoader classLoader) {
        try {
            Class<?> clsLoadClass = classLoader.loadClass("com.unity3d.unitygvr.GoogleVR");
            C0466o c0466o = new C0466o(clsLoadClass, clsLoadClass.getConstructor(new Class[0]).newInstance(new Object[0]));
            c0466o.m534a("initialize", new Class[]{Activity.class, Context.class, SurfaceView.class, Boolean.TYPE, Handler.class});
            c0466o.m534a("deinitialize", new Class[0]);
            c0466o.m534a("load", new Class[]{Boolean.TYPE, Boolean.TYPE, Boolean.TYPE, Boolean.TYPE, Boolean.TYPE, Runnable.class});
            c0466o.m534a("enable", new Class[]{Boolean.TYPE});
            c0466o.m534a("unload", new Class[0]);
            c0466o.m534a("pause", new Class[0]);
            c0466o.m534a("resume", new Class[0]);
            c0466o.m534a("getGvrLayout", new Class[0]);
            c0466o.m534a("getVideoSurfaceId", new Class[0]);
            c0466o.m534a("getVideoSurface", new Class[0]);
            this.f642a = c0466o;
            return true;
        } catch (Exception e) {
            reportError("Exception initializing GoogleVR from Unity library. " + e.getLocalizedMessage());
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: d */
    public boolean m372d() {
        return this.f455k.f472d;
    }

    /* JADX INFO: renamed from: e */
    private void m374e() {
        Activity activity = (Activity) this.f644c;
        if (!this.f451g || this.f455k.f474f || activity == null) {
            return;
        }
        this.f455k.f474f = true;
        Intent intent = new Intent("android.intent.action.MAIN");
        intent.addCategory("android.intent.category.HOME");
        intent.setFlags(DriveFile.MODE_READ_ONLY);
        activity.startActivity(intent);
    }

    private final native void initVrJni();

    private final native boolean isQuiting();

    private final native void setVrVideoTransform(float[][] fArr);

    /* JADX INFO: renamed from: a */
    public final void m375a(Intent intent) {
        if (intent == null || !intent.getBooleanExtra("android.intent.extra.VR_LAUNCH", false)) {
            return;
        }
        this.f451g = true;
    }

    /* JADX INFO: renamed from: a */
    public final boolean m376a() {
        return this.f455k.f469a;
    }

    /* JADX INFO: renamed from: a */
    public final boolean m377a(Activity activity, Context context, SurfaceView surfaceView, Runnable runnable) {
        String str;
        boolean zBooleanValue;
        if (activity == null || context == null || surfaceView == null || runnable == null) {
            str = "Invalid parameters passed to Google VR initiialization.";
        } else {
            this.f455k.m381b();
            this.f644c = context;
            this.f452h = runnable;
            if (!m368a(19)) {
                str = "Google VR requires a device that supports an api version of 19 (KitKat) or better.";
            } else if (this.f451g && !m368a(24)) {
                str = "Daydream requires a device that supports an api version of 24 (Nougat) or better.";
            } else {
                if (!m369a(UnityPlayer.class.getClassLoader())) {
                    return false;
                }
                try {
                    zBooleanValue = ((Boolean) this.f642a.m533a("initialize", activity, context, surfaceView, Boolean.valueOf(this.f451g), this.f457m)).booleanValue();
                } catch (Exception e) {
                    reportError("Exception while trying to intialize Unity Google VR Library. " + e.getLocalizedMessage());
                    zBooleanValue = false;
                }
                if (zBooleanValue) {
                    this.f454j = surfaceView;
                    this.f455k.f469a = true;
                    this.f645d = "";
                    return true;
                }
                str = "Unable to initialize GoogleVR library.";
            }
        }
        reportError(str);
        return false;
    }

    /* JADX INFO: renamed from: b */
    public final void m378b() {
        resumeGvrLayout();
    }

    /* JADX INFO: renamed from: c */
    public final void m379c() {
        if (this.f454j != null) {
            this.f454j.getHolder().setSizeFromLayout();
        }
    }

    @Override // com.unity3d.player.GoogleVrVideo
    public void deregisterGoogleVrVideoListener(GoogleVrVideo.GoogleVrVideoCallbacks googleVrVideoCallbacks) {
        if (this.f453i.contains(googleVrVideoCallbacks)) {
            googleVrVideoCallbacks.onSurfaceUnavailable();
            this.f453i.remove(googleVrVideoCallbacks);
        }
    }

    protected Object getVideoSurface() {
        if (m372d() && !this.f455k.f473e) {
            try {
                return this.f642a.m533a("getVideoSurface", new Object[0]);
            } catch (Exception e) {
                reportError("Exception caught while Getting GoogleVR Video Surface. " + e.getLocalizedMessage());
            }
        }
        return null;
    }

    protected int getVideoSurfaceId() {
        if (m372d() && !this.f455k.f473e) {
            try {
                return ((Integer) this.f642a.m533a("getVideoSurfaceId", new Object[0])).intValue();
            } catch (Exception e) {
                reportError("Exception caught while getting Video Surface ID from GoogleVR. " + e.getLocalizedMessage());
            }
        }
        return -1;
    }

    protected long loadGoogleVr(final boolean z, final boolean z2, final boolean z3, final boolean z4, final boolean z5) {
        if (!this.f455k.f469a) {
            return 0L;
        }
        final AtomicLong atomicLong = new AtomicLong(0L);
        this.f645d = (z || z2) ? "Daydream" : "Cardboard";
        if (!runOnUiThreadWithSync(new Runnable() { // from class: com.unity3d.player.GoogleVrProxy.2
            @Override // java.lang.Runnable
            public final void run() {
                try {
                    atomicLong.set(((Long) GoogleVrProxy.this.f642a.m533a("load", Boolean.valueOf(z), Boolean.valueOf(z2), Boolean.valueOf(z3), Boolean.valueOf(z4), Boolean.valueOf(z5), GoogleVrProxy.this.f452h)).longValue());
                    GoogleVrProxy.this.f455k.f470b = true;
                } catch (Exception e) {
                    GoogleVrProxy.this.reportError("Exception caught while loading GoogleVR. " + e.getLocalizedMessage());
                    atomicLong.set(0L);
                }
            }
        }) || atomicLong.longValue() == 0) {
            reportError("Google VR had a fatal issue while loading. VR will not be available.");
        }
        return atomicLong.longValue();
    }

    protected void pauseGvrLayout() {
        if (this.f455k.m380a() && !this.f455k.f473e) {
            if (m372d()) {
                Iterator it = this.f453i.iterator();
                while (it.hasNext()) {
                    ((GoogleVrVideo.GoogleVrVideoCallbacks) it.next()).onSurfaceUnavailable();
                }
            }
            if (this.f642a != null) {
                this.f642a.m533a("pause", new Object[0]);
            }
            this.f455k.f473e = true;
        }
    }

    @Override // com.unity3d.player.GoogleVrVideo
    public void registerGoogleVrVideoListener(GoogleVrVideo.GoogleVrVideoCallbacks googleVrVideoCallbacks) {
        if (this.f453i.contains(googleVrVideoCallbacks)) {
            return;
        }
        this.f453i.add(googleVrVideoCallbacks);
        Surface surface = (Surface) getVideoSurface();
        if (surface != null) {
            googleVrVideoCallbacks.onSurfaceAvailable(surface);
        }
    }

    protected void resumeGvrLayout() {
        if (this.f455k.m380a() && this.f455k.f473e) {
            if (this.f642a != null) {
                this.f642a.m533a("resume", new Object[0]);
            }
            this.f455k.f473e = false;
        }
    }

    protected void setGoogleVrModeEnabled(final boolean z) {
        if (!this.f455k.m380a() || this.f643b == null || this.f644c == null) {
            return;
        }
        if (!z && isQuiting()) {
            m374e();
        }
        runOnUiThread(new Runnable() { // from class: com.unity3d.player.GoogleVrProxy.3
            @Override // java.lang.Runnable
            public final void run() {
                if (z == GoogleVrProxy.this.m372d()) {
                    return;
                }
                try {
                    if (z && !GoogleVrProxy.this.m372d()) {
                        if (GoogleVrProxy.this.f642a != null && GoogleVrProxy.this.f643b != null && !GoogleVrProxy.this.f643b.addViewToPlayer((View) GoogleVrProxy.this.f642a.m533a("getGvrLayout", new Object[0]), true)) {
                            GoogleVrProxy.this.reportError("Unable to add Google VR to view hierarchy.");
                            return;
                        }
                        if (GoogleVrProxy.this.f642a != null) {
                            GoogleVrProxy.this.f642a.m533a("enable", true);
                        }
                        GoogleVrProxy.this.m367a(true);
                        return;
                    }
                    if (z || !GoogleVrProxy.this.m372d()) {
                        return;
                    }
                    GoogleVrProxy.this.m367a(false);
                    if (GoogleVrProxy.this.f642a != null) {
                        GoogleVrProxy.this.f642a.m533a("enable", false);
                    }
                    if (GoogleVrProxy.this.f642a == null || GoogleVrProxy.this.f643b == null) {
                        return;
                    }
                    GoogleVrProxy.this.f643b.removeViewFromPlayer((View) GoogleVrProxy.this.f642a.m533a("getGvrLayout", new Object[0]));
                } catch (Exception e) {
                    GoogleVrProxy.this.reportError("Exception enabling Google VR on UI Thread. " + e.getLocalizedMessage());
                }
            }
        });
    }

    @Override // com.unity3d.player.GoogleVrVideo
    public void setVideoLocationTransform(float[] fArr) {
        float[][] fArr2 = (float[][]) Array.newInstance((Class<?>) float.class, 4, 4);
        for (int i = 0; i < 4; i++) {
            for (int i2 = 0; i2 < 4; i2++) {
                fArr2[i][i2] = fArr[(i * 4) + i2];
            }
        }
        setVrVideoTransform(fArr2);
    }

    protected void unloadGoogleVr() {
        if (this.f455k.f472d) {
            setGoogleVrModeEnabled(false);
        }
        if (this.f455k.f471c) {
            this.f455k.f471c = false;
        }
        this.f454j = null;
        runOnUiThread(new Runnable() { // from class: com.unity3d.player.GoogleVrProxy.4
            @Override // java.lang.Runnable
            public final void run() {
                try {
                    if (GoogleVrProxy.this.f642a != null) {
                        GoogleVrProxy.this.f642a.m533a("unload", new Object[0]);
                        GoogleVrProxy.this.f642a.m533a("deinitialize", new Object[0]);
                        GoogleVrProxy.this.f642a = null;
                    }
                    GoogleVrProxy.this.f455k.f470b = false;
                } catch (Exception e) {
                    GoogleVrProxy.this.reportError("Exception unloading Google VR on UI Thread. " + e.getLocalizedMessage());
                }
            }
        });
    }
}

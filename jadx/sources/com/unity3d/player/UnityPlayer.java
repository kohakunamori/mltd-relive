package com.unity3d.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.BroadcastReceiver;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.pm.ApplicationInfo;
import android.content.res.Configuration;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.Process;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;
import android.util.TypedValue;
import android.view.InputEvent;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.Surface;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.FrameLayout;
import com.adjust.sdk.Constants;
import java.io.UnsupportedEncodingException;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
public class UnityPlayer extends FrameLayout implements InterfaceC0457f {
    public static Activity currentActivity;

    /* JADX INFO: renamed from: a */
    C0448e f486a;

    /* JADX INFO: renamed from: b */
    DialogC0462k f487b;

    /* JADX INFO: renamed from: c */
    private int f488c;

    /* JADX INFO: renamed from: d */
    private boolean f489d;

    /* JADX INFO: renamed from: e */
    private boolean f490e;

    /* JADX INFO: renamed from: f */
    private C0465n f491f;

    /* JADX INFO: renamed from: g */
    private final ConcurrentLinkedQueue f492g;

    /* JADX INFO: renamed from: h */
    private BroadcastReceiver f493h;

    /* JADX INFO: renamed from: i */
    private boolean f494i;

    /* JADX INFO: renamed from: j */
    private C0446c f495j;

    /* JADX INFO: renamed from: k */
    private TelephonyManager f496k;

    /* JADX INFO: renamed from: l */
    private ClipboardManager f497l;

    /* JADX INFO: renamed from: m */
    private C0463l f498m;

    /* JADX INFO: renamed from: n */
    private GoogleARCoreApi f499n;

    /* JADX INFO: renamed from: o */
    private C0444a f500o;

    /* JADX INFO: renamed from: p */
    private Camera2Wrapper f501p;

    /* JADX INFO: renamed from: q */
    private Context f502q;

    /* JADX INFO: renamed from: r */
    private SurfaceView f503r;

    /* JADX INFO: renamed from: s */
    private boolean f504s;

    /* JADX INFO: renamed from: t */
    private C0468q f505t;

    /* JADX INFO: renamed from: com.unity3d.player.UnityPlayer$a */
    class C0444a implements SensorEventListener {
        C0444a() {
        }

        @Override // android.hardware.SensorEventListener
        public final void onAccuracyChanged(Sensor sensor, int i) {
        }

        @Override // android.hardware.SensorEventListener
        public final void onSensorChanged(SensorEvent sensorEvent) {
        }
    }

    /* JADX WARN: $VALUES field not found */
    /* JADX WARN: Failed to restore enum class, 'enum' modifier and super class removed */
    /* JADX INFO: renamed from: com.unity3d.player.UnityPlayer$b */
    static final class EnumC0445b {

        /* JADX INFO: renamed from: a */
        public static final int f558a = 1;

        /* JADX INFO: renamed from: b */
        public static final int f559b = 2;

        /* JADX INFO: renamed from: c */
        public static final int f560c = 3;

        /* JADX INFO: renamed from: d */
        private static final /* synthetic */ int[] f561d = {f558a, f559b, f560c};
    }

    /* JADX INFO: renamed from: com.unity3d.player.UnityPlayer$c */
    private class C0446c extends PhoneStateListener {
        private C0446c() {
        }

        /* synthetic */ C0446c(UnityPlayer unityPlayer, byte b) {
            this();
        }

        @Override // android.telephony.PhoneStateListener
        public final void onCallStateChanged(int i, String str) {
            UnityPlayer.this.nativeMuteMasterAudio(i == 1);
        }
    }

    /* JADX INFO: renamed from: com.unity3d.player.UnityPlayer$d */
    enum EnumC0447d {
        PAUSE,
        RESUME,
        QUIT,
        SURFACE_LOST,
        SURFACE_ACQUIRED,
        FOCUS_LOST,
        FOCUS_GAINED,
        NEXT_FRAME
    }

    /* JADX INFO: renamed from: com.unity3d.player.UnityPlayer$e */
    private class C0448e extends Thread {

        /* JADX INFO: renamed from: a */
        Handler f572a;

        /* JADX INFO: renamed from: b */
        boolean f573b;

        /* JADX INFO: renamed from: c */
        boolean f574c;

        /* JADX INFO: renamed from: d */
        int f575d;

        /* JADX INFO: renamed from: e */
        int f576e;

        /* JADX INFO: renamed from: f */
        int f577f;

        private C0448e() {
            this.f573b = false;
            this.f574c = false;
            this.f575d = EnumC0445b.f559b;
            this.f576e = 0;
            this.f577f = 5;
        }

        /* synthetic */ C0448e(UnityPlayer unityPlayer, byte b) {
            this();
        }

        /* JADX INFO: renamed from: a */
        private void m448a(EnumC0447d enumC0447d) {
            if (this.f572a != null) {
                Message.obtain(this.f572a, 2269, enumC0447d).sendToTarget();
            }
        }

        /* JADX INFO: renamed from: a */
        public final void m449a() {
            m448a(EnumC0447d.QUIT);
        }

        /* JADX INFO: renamed from: a */
        public final void m450a(Runnable runnable) {
            if (this.f572a == null) {
                return;
            }
            m448a(EnumC0447d.PAUSE);
            Message.obtain(this.f572a, runnable).sendToTarget();
        }

        /* JADX INFO: renamed from: b */
        public final void m451b() {
            m448a(EnumC0447d.RESUME);
        }

        /* JADX INFO: renamed from: b */
        public final void m452b(Runnable runnable) {
            if (this.f572a == null) {
                return;
            }
            m448a(EnumC0447d.SURFACE_LOST);
            Message.obtain(this.f572a, runnable).sendToTarget();
        }

        /* JADX INFO: renamed from: c */
        public final void m453c() {
            m448a(EnumC0447d.FOCUS_GAINED);
        }

        /* JADX INFO: renamed from: c */
        public final void m454c(Runnable runnable) {
            if (this.f572a == null) {
                return;
            }
            Message.obtain(this.f572a, runnable).sendToTarget();
            m448a(EnumC0447d.SURFACE_ACQUIRED);
        }

        /* JADX INFO: renamed from: d */
        public final void m455d() {
            m448a(EnumC0447d.FOCUS_LOST);
        }

        /* JADX INFO: renamed from: d */
        public final void m456d(Runnable runnable) {
            if (this.f572a != null) {
                Message.obtain(this.f572a, runnable).sendToTarget();
            }
        }

        @Override // java.lang.Thread, java.lang.Runnable
        public final void run() {
            setName("UnityMain");
            Looper.prepare();
            this.f572a = new Handler(new Handler.Callback() { // from class: com.unity3d.player.UnityPlayer.e.1
                /* JADX INFO: renamed from: a */
                private void m457a() {
                    if (C0448e.this.f575d == EnumC0445b.f560c && C0448e.this.f574c) {
                        UnityPlayer.this.nativeFocusChanged(true);
                        C0448e.this.f575d = EnumC0445b.f558a;
                    }
                }

                @Override // android.os.Handler.Callback
                public final boolean handleMessage(Message message) {
                    if (message.what != 2269) {
                        return false;
                    }
                    EnumC0447d enumC0447d = (EnumC0447d) message.obj;
                    if (enumC0447d == EnumC0447d.NEXT_FRAME) {
                        C0448e.this.f576e--;
                        UnityPlayer.this.executeGLThreadJobs();
                        if (!C0448e.this.f573b || !C0448e.this.f574c) {
                            return true;
                        }
                        if (C0448e.this.f577f >= 0) {
                            if (C0448e.this.f577f == 0 && UnityPlayer.this.m431k()) {
                                UnityPlayer.this.m396a();
                            }
                            C0448e.this.f577f--;
                        }
                        if (!UnityPlayer.this.isFinishing() && !UnityPlayer.this.nativeRender()) {
                            UnityPlayer.this.m419e();
                        }
                    } else if (enumC0447d == EnumC0447d.QUIT) {
                        Looper.myLooper().quit();
                    } else if (enumC0447d == EnumC0447d.RESUME) {
                        C0448e.this.f573b = true;
                    } else if (enumC0447d == EnumC0447d.PAUSE) {
                        C0448e.this.f573b = false;
                    } else if (enumC0447d == EnumC0447d.SURFACE_LOST) {
                        C0448e.this.f574c = false;
                    } else {
                        if (enumC0447d == EnumC0447d.SURFACE_ACQUIRED) {
                            C0448e.this.f574c = true;
                        } else if (enumC0447d == EnumC0447d.FOCUS_LOST) {
                            if (C0448e.this.f575d == EnumC0445b.f558a) {
                                UnityPlayer.this.nativeFocusChanged(false);
                            }
                            C0448e.this.f575d = EnumC0445b.f559b;
                        } else if (enumC0447d == EnumC0447d.FOCUS_GAINED) {
                            C0448e.this.f575d = EnumC0445b.f560c;
                        }
                        m457a();
                    }
                    if (C0448e.this.f573b && C0448e.this.f576e <= 0) {
                        Message.obtain(C0448e.this.f572a, 2269, EnumC0447d.NEXT_FRAME).sendToTarget();
                        C0448e.this.f576e++;
                    }
                    return true;
                }
            });
            Looper.loop();
        }
    }

    /* JADX INFO: renamed from: com.unity3d.player.UnityPlayer$f */
    private abstract class AbstractRunnableC0449f implements Runnable {
        private AbstractRunnableC0449f() {
        }

        /* synthetic */ AbstractRunnableC0449f(UnityPlayer unityPlayer, byte b) {
            this();
        }

        /* JADX INFO: renamed from: a */
        public abstract void mo446a();

        @Override // java.lang.Runnable
        public final void run() {
            if (UnityPlayer.this.isFinishing()) {
                return;
            }
            mo446a();
        }
    }

    static {
        new C0464m().m520a();
    }

    public UnityPlayer(Context context) {
        super(context);
        this.f488c = -1;
        byte b = 0;
        this.f489d = false;
        this.f490e = true;
        this.f491f = new C0465n();
        this.f492g = new ConcurrentLinkedQueue();
        this.f493h = null;
        this.f486a = new C0448e(this, b);
        this.f494i = false;
        this.f495j = new C0446c(this, b);
        this.f499n = null;
        this.f500o = new C0444a();
        this.f501p = null;
        this.f487b = null;
        if (context instanceof Activity) {
            currentActivity = (Activity) context;
            this.f488c = currentActivity.getRequestedOrientation();
        }
        m398a(currentActivity);
        this.f502q = context;
        if (currentActivity != null && m431k()) {
            this.f498m = new C0463l(this.f502q, C0463l.a.m519a()[getSplashMode()]);
            addView(this.f498m);
        }
        String strM394a = m394a(this.f502q.getApplicationInfo());
        if (!C0465n.m523c()) {
            C0458g.Log(6, "Your hardware does not support this application.");
            AlertDialog alertDialogCreate = new AlertDialog.Builder(this.f502q).setTitle("Failure to initialize!").setPositiveButton("OK", new DialogInterface.OnClickListener() { // from class: com.unity3d.player.UnityPlayer.1
                @Override // android.content.DialogInterface.OnClickListener
                public final void onClick(DialogInterface dialogInterface, int i) {
                    UnityPlayer.this.m419e();
                }
            }).setMessage("Your hardware does not support this application.\n\n" + strM394a + "\n\n Press OK to quit.").create();
            alertDialogCreate.setCancelable(false);
            alertDialogCreate.show();
            return;
        }
        initJni(context);
        this.f491f.m526c(true);
        this.f503r = m413c();
        this.f503r.setContentDescription(m393a(context));
        addView(this.f503r);
        bringChildToFront(this.f498m);
        this.f504s = false;
        nativeInitWebRequest(UnityWebRequest.class);
        m434m();
        this.f496k = (TelephonyManager) this.f502q.getSystemService("phone");
        this.f497l = (ClipboardManager) this.f502q.getSystemService("clipboard");
        this.f501p = new Camera2Wrapper(this.f502q);
        this.f486a.start();
    }

    public static void UnitySendMessage(String str, String str2, String str3) {
        if (C0465n.m523c()) {
            try {
                nativeUnitySendMessage(str, str2, str3.getBytes(Constants.ENCODING));
                return;
            } catch (UnsupportedEncodingException unused) {
                return;
            }
        }
        C0458g.Log(5, "Native libraries not loaded - dropping message for " + str + "." + str2);
    }

    /* JADX INFO: renamed from: a */
    private static String m393a(Context context) {
        return context.getResources().getString(context.getResources().getIdentifier("game_view_content_description", "string", context.getPackageName()));
    }

    /* JADX INFO: renamed from: a */
    private static String m394a(ApplicationInfo applicationInfo) {
        StringBuilder sb = new StringBuilder();
        sb.append(applicationInfo.nativeLibraryDir);
        sb.append("/libmain.so");
        try {
            System.loadLibrary("main");
            if (NativeLoader.load(applicationInfo.nativeLibraryDir)) {
                C0465n.m521a();
                return "";
            }
            C0458g.Log(6, "NativeLoader.load failure, Unity libraries were not loaded.");
            return "NativeLoader.load failure, Unity libraries were not loaded.";
        } catch (SecurityException e) {
            return m395a(e.toString());
        } catch (UnsatisfiedLinkError e2) {
            return m395a(e2.toString());
        }
    }

    /* JADX INFO: renamed from: a */
    private static String m395a(String str) {
        String str2 = "Failed to load 'libmain.so'\n\n" + str;
        C0458g.Log(6, str2);
        return str2;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: a */
    public void m396a() {
        m406a(new Runnable() { // from class: com.unity3d.player.UnityPlayer.16
            @Override // java.lang.Runnable
            public final void run() {
                UnityPlayer.this.removeView(UnityPlayer.this.f498m);
                UnityPlayer.m420f(UnityPlayer.this);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: a */
    public void m397a(int i, Surface surface) {
        if (this.f489d) {
            return;
        }
        m412b(0, surface);
    }

    /* JADX INFO: renamed from: a */
    private static void m398a(Activity activity) {
        View decorView;
        if (activity == null || !activity.getIntent().getBooleanExtra("android.intent.extra.VR_LAUNCH", false) || activity.getWindow() == null || (decorView = activity.getWindow().getDecorView()) == null) {
            return;
        }
        decorView.setSystemUiVisibility(7);
    }

    /* JADX INFO: renamed from: a */
    private void m399a(View view, View view2) {
        boolean z;
        if (this.f491f.m528d()) {
            z = false;
        } else {
            pause();
            z = true;
        }
        if (view != null) {
            ViewParent parent = view.getParent();
            if (!(parent instanceof UnityPlayer) || ((UnityPlayer) parent) != this) {
                if (parent instanceof ViewGroup) {
                    ((ViewGroup) parent).removeView(view);
                }
                addView(view);
                bringChildToFront(view);
                view.setVisibility(0);
            }
        }
        if (view2 != null && view2.getParent() == this) {
            view2.setVisibility(8);
            removeView(view2);
        }
        if (z) {
            resume();
        }
    }

    /* JADX INFO: renamed from: a */
    private void m400a(AbstractRunnableC0449f abstractRunnableC0449f) {
        if (isFinishing()) {
            return;
        }
        m414c(abstractRunnableC0449f);
    }

    /* JADX INFO: renamed from: a */
    private void m406a(Runnable runnable) {
        if (this.f502q instanceof Activity) {
            ((Activity) this.f502q).runOnUiThread(runnable);
        } else {
            C0458g.Log(5, "Not running Unity from an Activity; ignored...");
        }
    }

    /* JADX INFO: renamed from: b */
    private static void m410b(Runnable runnable) {
        new Handler(Looper.getMainLooper()).post(runnable);
    }

    /* JADX INFO: renamed from: b */
    private static boolean m411b() {
        if (currentActivity == null) {
            return false;
        }
        TypedValue typedValue = new TypedValue();
        return currentActivity.getTheme().resolveAttribute(android.R.attr.windowIsTranslucent, typedValue, true) && typedValue.type == 18 && typedValue.data == 1;
    }

    /* JADX INFO: renamed from: b */
    private boolean m412b(final int i, final Surface surface) {
        if (!C0465n.m523c() || !this.f491f.m529e()) {
            return false;
        }
        final Semaphore semaphore = new Semaphore(0);
        Runnable runnable = new Runnable() { // from class: com.unity3d.player.UnityPlayer.19
            @Override // java.lang.Runnable
            public final void run() {
                UnityPlayer.this.nativeRecreateGfxState(i, surface);
                semaphore.release();
            }
        };
        if (i != 0) {
            runnable.run();
        } else if (surface == null) {
            this.f486a.m452b(runnable);
        } else {
            this.f486a.m454c(runnable);
        }
        if (surface != null || i != 0) {
            return true;
        }
        try {
            if (semaphore.tryAcquire(4L, TimeUnit.SECONDS)) {
                return true;
            }
            C0458g.Log(5, "Timeout while trying detaching primary window.");
            return true;
        } catch (InterruptedException unused) {
            C0458g.Log(5, "UI thread got interrupted while trying to detach the primary window from the Unity Engine.");
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: c */
    public SurfaceView m413c() {
        SurfaceView surfaceView = new SurfaceView(this.f502q);
        surfaceView.setId(this.f502q.getResources().getIdentifier("unitySurfaceView", "id", this.f502q.getPackageName()));
        if (m411b()) {
            surfaceView.getHolder().setFormat(-3);
            surfaceView.setZOrderOnTop(true);
        } else {
            surfaceView.getHolder().setFormat(-1);
        }
        surfaceView.getHolder().addCallback(new SurfaceHolder.Callback() { // from class: com.unity3d.player.UnityPlayer.17
            @Override // android.view.SurfaceHolder.Callback
            public final void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
                UnityPlayer.this.m397a(0, surfaceHolder.getSurface());
                UnityPlayer.this.m416d();
            }

            @Override // android.view.SurfaceHolder.Callback
            public final void surfaceCreated(SurfaceHolder surfaceHolder) {
                UnityPlayer.this.m397a(0, surfaceHolder.getSurface());
            }

            @Override // android.view.SurfaceHolder.Callback
            public final void surfaceDestroyed(SurfaceHolder surfaceHolder) {
                UnityPlayer.this.m397a(0, (Surface) null);
            }
        });
        surfaceView.setFocusable(true);
        surfaceView.setFocusableInTouchMode(true);
        return surfaceView;
    }

    /* JADX INFO: renamed from: c */
    private void m414c(Runnable runnable) {
        if (C0465n.m523c()) {
            if (Thread.currentThread() == this.f486a) {
                runnable.run();
            } else {
                this.f492g.add(runnable);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: d */
    public void m416d() {
        if (C0465n.m523c() && this.f491f.m529e()) {
            this.f486a.m456d(new Runnable() { // from class: com.unity3d.player.UnityPlayer.18
                @Override // java.lang.Runnable
                public final void run() {
                    UnityPlayer.this.nativeSendSurfaceChangedEvent();
                }
            });
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: e */
    public void m419e() {
        if (!(this.f502q instanceof Activity) || ((Activity) this.f502q).isFinishing()) {
            return;
        }
        ((Activity) this.f502q).finish();
    }

    /* JADX INFO: renamed from: f */
    static /* synthetic */ C0463l m420f(UnityPlayer unityPlayer) {
        unityPlayer.f498m = null;
        return null;
    }

    /* JADX INFO: renamed from: f */
    private void m421f() {
        reportSoftInputStr(null, 1, true);
        if (this.f491f.m531g()) {
            if (C0465n.m523c()) {
                final Semaphore semaphore = new Semaphore(0);
                this.f486a.m450a(isFinishing() ? new Runnable() { // from class: com.unity3d.player.UnityPlayer.21
                    @Override // java.lang.Runnable
                    public final void run() {
                        UnityPlayer.this.m422g();
                        semaphore.release();
                    }
                } : new Runnable() { // from class: com.unity3d.player.UnityPlayer.22
                    @Override // java.lang.Runnable
                    public final void run() {
                        if (!UnityPlayer.this.nativePause()) {
                            semaphore.release();
                            return;
                        }
                        UnityPlayer.m435m(UnityPlayer.this);
                        UnityPlayer.this.m422g();
                        semaphore.release(2);
                    }
                });
                try {
                    if (!semaphore.tryAcquire(4L, TimeUnit.SECONDS)) {
                        C0458g.Log(5, "Timeout while trying to pause the Unity Engine.");
                    }
                } catch (InterruptedException unused) {
                    C0458g.Log(5, "UI thread got interrupted while trying to pause the Unity Engine.");
                }
                if (semaphore.drainPermits() > 0) {
                    destroy();
                }
            }
            this.f491f.m527d(false);
            this.f491f.m525b(true);
            if (this.f494i) {
                this.f496k.listen(this.f495j, 0);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: g */
    public void m422g() {
        nativeDone();
        this.f491f.m526c(false);
    }

    /* JADX INFO: renamed from: h */
    private void m424h() {
        if (this.f491f.m530f()) {
            this.f491f.m527d(true);
            m414c(new Runnable() { // from class: com.unity3d.player.UnityPlayer.3
                @Override // java.lang.Runnable
                public final void run() {
                    UnityPlayer.this.nativeResume();
                }
            });
            this.f486a.m451b();
        }
    }

    /* JADX INFO: renamed from: i */
    private static void m426i() {
        if (C0465n.m523c()) {
            if (!NativeLoader.unload()) {
                throw new UnsatisfiedLinkError("Unable to unload libraries from libmain.so");
            }
            C0465n.m522b();
        }
    }

    private final native void initJni(Context context);

    /* JADX INFO: renamed from: j */
    private ApplicationInfo m428j() {
        return this.f502q.getPackageManager().getApplicationInfo(this.f502q.getPackageName(), 128);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: k */
    public boolean m431k() {
        try {
            return m428j().metaData.getBoolean("unity.splash-enable");
        } catch (Exception unused) {
            return false;
        }
    }

    /* JADX INFO: renamed from: l */
    private boolean m432l() {
        try {
            return m428j().metaData.getBoolean("unity.tango-enable");
        } catch (Exception unused) {
            return false;
        }
    }

    protected static boolean loadLibraryStatic(String str) {
        StringBuilder sb;
        try {
            System.loadLibrary(str);
            return true;
        } catch (Exception e) {
            sb = new StringBuilder("Unknown error ");
            sb.append(e);
            C0458g.Log(6, sb.toString());
            return false;
        } catch (UnsatisfiedLinkError unused) {
            sb = new StringBuilder("Unable to find ");
            sb.append(str);
            C0458g.Log(6, sb.toString());
            return false;
        }
    }

    /* JADX INFO: renamed from: m */
    private void m434m() {
        if (this.f502q instanceof Activity) {
            ((Activity) this.f502q).getWindow().setFlags(1024, 1024);
        }
    }

    /* JADX INFO: renamed from: m */
    static /* synthetic */ boolean m435m(UnityPlayer unityPlayer) {
        unityPlayer.f504s = true;
        return true;
    }

    private final native void nativeDone();

    /* JADX INFO: Access modifiers changed from: private */
    public final native void nativeFocusChanged(boolean z);

    private final native void nativeInitWebRequest(Class cls);

    private final native boolean nativeInjectEvent(InputEvent inputEvent);

    /* JADX INFO: Access modifiers changed from: private */
    public final native boolean nativeIsAutorotationOn();

    /* JADX INFO: Access modifiers changed from: private */
    public final native void nativeLowMemory();

    /* JADX INFO: Access modifiers changed from: private */
    public final native void nativeMuteMasterAudio(boolean z);

    /* JADX INFO: Access modifiers changed from: private */
    public final native boolean nativePause();

    /* JADX INFO: Access modifiers changed from: private */
    public final native void nativeRecreateGfxState(int i, Surface surface);

    /* JADX INFO: Access modifiers changed from: private */
    public final native boolean nativeRender();

    private final native void nativeRestartActivityIndicator();

    /* JADX INFO: Access modifiers changed from: private */
    public final native void nativeResume();

    /* JADX INFO: Access modifiers changed from: private */
    public final native void nativeSendSurfaceChangedEvent();

    /* JADX INFO: Access modifiers changed from: private */
    public final native void nativeSetInputSelection(int i, int i2);

    /* JADX INFO: Access modifiers changed from: private */
    public final native void nativeSetInputString(String str);

    /* JADX INFO: Access modifiers changed from: private */
    public final native void nativeSoftInputCanceled();

    /* JADX INFO: Access modifiers changed from: private */
    public final native void nativeSoftInputClosed();

    /* JADX INFO: Access modifiers changed from: private */
    public final native void nativeSoftInputLostFocus();

    private static native void nativeUnitySendMessage(String str, String str2, byte[] bArr);

    /* JADX INFO: renamed from: u */
    static /* synthetic */ C0468q m443u(UnityPlayer unityPlayer) {
        unityPlayer.f505t = null;
        return null;
    }

    protected void addPhoneCallListener() {
        this.f494i = true;
        this.f496k.listen(this.f495j, 32);
    }

    @Override // com.unity3d.player.InterfaceC0457f
    public boolean addViewToPlayer(View view, boolean z) {
        m399a(view, z ? this.f503r : null);
        boolean z2 = false;
        boolean z3 = view.getParent() == this;
        boolean z4 = z && this.f503r.getParent() == null;
        boolean z5 = this.f503r.getParent() == this;
        if (z3 && (z4 || z5)) {
            z2 = true;
        }
        if (!z2) {
            if (!z3) {
                C0458g.Log(6, "addViewToPlayer: Failure adding view to hierarchy");
            }
            if (!z4 && !z5) {
                C0458g.Log(6, "addViewToPlayer: Failure removing old view from hierarchy");
            }
        }
        return z2;
    }

    public void configurationChanged(Configuration configuration) {
        if (this.f503r instanceof SurfaceView) {
            this.f503r.getHolder().setSizeFromLayout();
        }
        if (this.f505t != null) {
            this.f505t.m558c();
        }
        GoogleVrProxy googleVrProxyM364b = GoogleVrApi.m364b();
        if (googleVrProxyM364b != null) {
            googleVrProxyM364b.m379c();
        }
    }

    public void destroy() {
        if (GoogleVrApi.m364b() != null) {
            GoogleVrApi.m362a();
        }
        if (this.f501p != null) {
            this.f501p.m359a();
            this.f501p = null;
        }
        this.f504s = true;
        if (!this.f491f.m528d()) {
            pause();
        }
        this.f486a.m449a();
        try {
            this.f486a.join(4000L);
        } catch (InterruptedException unused) {
            this.f486a.interrupt();
        }
        if (this.f493h != null) {
            this.f502q.unregisterReceiver(this.f493h);
        }
        this.f493h = null;
        if (C0465n.m523c()) {
            removeAllViews();
        }
        kill();
        m426i();
    }

    protected void disableLogger() {
        C0458g.f650a = true;
    }

    public boolean displayChanged(int i, Surface surface) {
        if (i == 0) {
            this.f489d = surface != null;
            m406a(new Runnable() { // from class: com.unity3d.player.UnityPlayer.20
                @Override // java.lang.Runnable
                public final void run() {
                    if (UnityPlayer.this.f489d) {
                        UnityPlayer.this.removeView(UnityPlayer.this.f503r);
                    } else {
                        UnityPlayer.this.addView(UnityPlayer.this.f503r);
                    }
                }
            });
        }
        return m412b(i, surface);
    }

    protected void executeGLThreadJobs() {
        while (true) {
            Runnable runnable = (Runnable) this.f492g.poll();
            if (runnable == null) {
                return;
            } else {
                runnable.run();
            }
        }
    }

    protected String getClipboardText() {
        ClipData primaryClip = this.f497l.getPrimaryClip();
        return primaryClip != null ? primaryClip.getItemAt(0).coerceToText(this.f502q).toString() : "";
    }

    public Bundle getSettings() {
        return Bundle.EMPTY;
    }

    protected int getSplashMode() {
        try {
            return m428j().metaData.getInt("unity.splash-mode");
        } catch (Exception unused) {
            return 0;
        }
    }

    public View getView() {
        return this;
    }

    protected void hideSoftInput() {
        m410b(new Runnable() { // from class: com.unity3d.player.UnityPlayer.5
            @Override // java.lang.Runnable
            public final void run() {
                if (UnityPlayer.this.f487b != null) {
                    UnityPlayer.this.f487b.dismiss();
                    UnityPlayer.this.f487b = null;
                }
            }
        });
    }

    public void init(int i, boolean z) {
    }

    protected boolean initializeGoogleAr() {
        if (this.f499n != null || currentActivity == null || !m432l()) {
            return false;
        }
        this.f499n = new GoogleARCoreApi();
        this.f499n.initializeARCore(currentActivity);
        if (this.f491f.m528d()) {
            return false;
        }
        this.f499n.resumeARCore();
        return false;
    }

    protected boolean initializeGoogleVr() {
        final GoogleVrProxy googleVrProxyM364b = GoogleVrApi.m364b();
        if (googleVrProxyM364b == null) {
            GoogleVrApi.m363a(this);
            googleVrProxyM364b = GoogleVrApi.m364b();
            if (googleVrProxyM364b == null) {
                C0458g.Log(6, "Unable to create Google VR subsystem.");
                return false;
            }
        }
        final Semaphore semaphore = new Semaphore(0);
        final Runnable runnable = new Runnable() { // from class: com.unity3d.player.UnityPlayer.12
            @Override // java.lang.Runnable
            public final void run() {
                UnityPlayer.this.injectEvent(new KeyEvent(0, 4));
                UnityPlayer.this.injectEvent(new KeyEvent(1, 4));
            }
        };
        m406a(new Runnable() { // from class: com.unity3d.player.UnityPlayer.13
            @Override // java.lang.Runnable
            public final void run() {
                if (!googleVrProxyM364b.m377a(UnityPlayer.currentActivity, UnityPlayer.this.f502q, UnityPlayer.this.m413c(), runnable)) {
                    C0458g.Log(6, "Unable to initialize Google VR subsystem.");
                }
                if (UnityPlayer.currentActivity != null) {
                    googleVrProxyM364b.m375a(UnityPlayer.currentActivity.getIntent());
                }
                semaphore.release();
            }
        });
        try {
            if (semaphore.tryAcquire(4L, TimeUnit.SECONDS)) {
                return googleVrProxyM364b.m376a();
            }
            C0458g.Log(5, "Timeout while trying to initialize Google VR.");
            return false;
        } catch (InterruptedException e) {
            C0458g.Log(5, "UI thread was interrupted while initializing Google VR. " + e.getLocalizedMessage());
            return false;
        }
    }

    public boolean injectEvent(InputEvent inputEvent) {
        if (C0465n.m523c()) {
            return nativeInjectEvent(inputEvent);
        }
        return false;
    }

    protected boolean isFinishing() {
        if (!this.f504s) {
            boolean z = (this.f502q instanceof Activity) && ((Activity) this.f502q).isFinishing();
            this.f504s = z;
            if (!z) {
                return false;
            }
        }
        return true;
    }

    protected void kill() {
        Process.killProcess(Process.myPid());
    }

    protected boolean loadLibrary(String str) {
        return loadLibraryStatic(str);
    }

    public void lowMemory() {
        if (C0465n.m523c()) {
            m414c(new Runnable() { // from class: com.unity3d.player.UnityPlayer.2
                @Override // java.lang.Runnable
                public final void run() {
                    UnityPlayer.this.nativeLowMemory();
                }
            });
        }
    }

    @Override // android.view.View
    public boolean onGenericMotionEvent(MotionEvent motionEvent) {
        return injectEvent(motionEvent);
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        return injectEvent(keyEvent);
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyLongPress(int i, KeyEvent keyEvent) {
        return injectEvent(keyEvent);
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyMultiple(int i, int i2, KeyEvent keyEvent) {
        return injectEvent(keyEvent);
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public boolean onKeyUp(int i, KeyEvent keyEvent) {
        return injectEvent(keyEvent);
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        return injectEvent(motionEvent);
    }

    public void pause() {
        if (this.f499n != null) {
            this.f499n.pauseARCore();
        }
        if (this.f505t != null) {
            this.f505t.m555a();
        }
        GoogleVrProxy googleVrProxyM364b = GoogleVrApi.m364b();
        if (googleVrProxyM364b != null) {
            googleVrProxyM364b.pauseGvrLayout();
        }
        m421f();
    }

    public void quit() {
        destroy();
    }

    @Override // com.unity3d.player.InterfaceC0457f
    public void removeViewFromPlayer(View view) {
        m399a(this.f503r, view);
        boolean z = false;
        boolean z2 = view.getParent() == null;
        boolean z3 = this.f503r.getParent() == this;
        if (z2 && z3) {
            z = true;
        }
        if (z) {
            return;
        }
        if (!z2) {
            C0458g.Log(6, "removeViewFromPlayer: Failure removing view from hierarchy");
        }
        if (z3) {
            return;
        }
        C0458g.Log(6, "removeVireFromPlayer: Failure agging old view to hierarchy");
    }

    @Override // com.unity3d.player.InterfaceC0457f
    public void reportError(String str, String str2) {
        C0458g.Log(6, str + ": " + str2);
    }

    protected void reportSoftInputSelection(final int i, final int i2) {
        m400a(new AbstractRunnableC0449f() { // from class: com.unity3d.player.UnityPlayer.11
            /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
            {
                super(UnityPlayer.this, (byte) 0);
            }

            @Override // com.unity3d.player.UnityPlayer.AbstractRunnableC0449f
            /* JADX INFO: renamed from: a */
            public final void mo446a() {
                UnityPlayer.this.nativeSetInputSelection(i, i2);
            }
        });
    }

    protected void reportSoftInputStr(final String str, final int i, final boolean z) {
        if (i == 1) {
            hideSoftInput();
        }
        m400a(new AbstractRunnableC0449f() { // from class: com.unity3d.player.UnityPlayer.10
            /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
            {
                super(UnityPlayer.this, (byte) 0);
            }

            @Override // com.unity3d.player.UnityPlayer.AbstractRunnableC0449f
            /* JADX INFO: renamed from: a */
            public final void mo446a() {
                if (z) {
                    UnityPlayer.this.nativeSoftInputCanceled();
                } else if (str != null) {
                    UnityPlayer.this.nativeSetInputString(str);
                }
                if (i == 1) {
                    UnityPlayer.this.nativeSoftInputClosed();
                }
            }
        });
    }

    protected void requestUserAuthorization(String str) {
        if (!C0461j.f653c || str == null || str.isEmpty() || currentActivity == null) {
            return;
        }
        C0461j.f654d.mo504a(currentActivity, str);
    }

    public void resume() {
        if (this.f499n != null) {
            this.f499n.resumeARCore();
        }
        this.f491f.m525b(false);
        if (this.f505t != null) {
            this.f505t.m557b();
        }
        m424h();
        if (C0465n.m523c()) {
            nativeRestartActivityIndicator();
        }
        GoogleVrProxy googleVrProxyM364b = GoogleVrApi.m364b();
        if (googleVrProxyM364b != null) {
            googleVrProxyM364b.m378b();
        }
    }

    protected void setCharacterLimit(final int i) {
        m406a(new Runnable() { // from class: com.unity3d.player.UnityPlayer.7
            @Override // java.lang.Runnable
            public final void run() {
                if (UnityPlayer.this.f487b != null) {
                    UnityPlayer.this.f487b.m515a(i);
                }
            }
        });
    }

    protected void setClipboardText(String str) {
        this.f497l.setPrimaryClip(ClipData.newPlainText("Text", str));
    }

    protected void setHideInputField(final boolean z) {
        m406a(new Runnable() { // from class: com.unity3d.player.UnityPlayer.8
            @Override // java.lang.Runnable
            public final void run() {
                if (UnityPlayer.this.f487b != null) {
                    UnityPlayer.this.f487b.m518a(z);
                }
            }
        });
    }

    protected void setSelection(final int i, final int i2) {
        m406a(new Runnable() { // from class: com.unity3d.player.UnityPlayer.9
            @Override // java.lang.Runnable
            public final void run() {
                if (UnityPlayer.this.f487b != null) {
                    UnityPlayer.this.f487b.m516a(i, i2);
                }
            }
        });
    }

    protected void setSoftInputStr(final String str) {
        m406a(new Runnable() { // from class: com.unity3d.player.UnityPlayer.6
            @Override // java.lang.Runnable
            public final void run() {
                if (UnityPlayer.this.f487b == null || str == null) {
                    return;
                }
                UnityPlayer.this.f487b.m517a(str);
            }
        });
    }

    protected void showSoftInput(final String str, final int i, final boolean z, final boolean z2, final boolean z3, final boolean z4, final String str2, final int i2, final boolean z5) {
        m410b(new Runnable() { // from class: com.unity3d.player.UnityPlayer.4
            @Override // java.lang.Runnable
            public final void run() {
                UnityPlayer.this.f487b = new DialogC0462k(UnityPlayer.this.f502q, this, str, i, z, z2, z3, str2, i2, z5);
                UnityPlayer.this.f487b.setOnCancelListener(new DialogInterface.OnCancelListener() { // from class: com.unity3d.player.UnityPlayer.4.1
                    @Override // android.content.DialogInterface.OnCancelListener
                    public final void onCancel(DialogInterface dialogInterface) {
                        UnityPlayer.this.nativeSoftInputLostFocus();
                        UnityPlayer.this.reportSoftInputStr(null, 1, false);
                    }
                });
                UnityPlayer.this.f487b.show();
            }
        });
    }

    protected boolean showVideoPlayer(String str, int i, int i2, int i3, boolean z, int i4, int i5) {
        if (this.f505t == null) {
            this.f505t = new C0468q(this);
        }
        boolean zM556a = this.f505t.m556a(this.f502q, str, i, i2, i3, z, i4, i5, new C0468q.a() { // from class: com.unity3d.player.UnityPlayer.14
            @Override // com.unity3d.player.C0468q.a
            /* JADX INFO: renamed from: a */
            public final void mo447a() {
                UnityPlayer.m443u(UnityPlayer.this);
            }
        });
        if (zM556a) {
            m406a(new Runnable() { // from class: com.unity3d.player.UnityPlayer.15
                @Override // java.lang.Runnable
                public final void run() {
                    if (UnityPlayer.this.nativeIsAutorotationOn() && (UnityPlayer.this.f502q instanceof Activity)) {
                        ((Activity) UnityPlayer.this.f502q).setRequestedOrientation(UnityPlayer.this.f488c);
                    }
                }
            });
        }
        return zM556a;
    }

    protected boolean skipPermissionsDialog() {
        if (!C0461j.f653c || currentActivity == null) {
            return false;
        }
        return C0461j.f654d.mo505a(currentActivity);
    }

    public void start() {
    }

    public void stop() {
    }

    protected void toggleGyroscopeSensor(boolean z) {
        SensorManager sensorManager = (SensorManager) this.f502q.getSystemService("sensor");
        Sensor defaultSensor = sensorManager.getDefaultSensor(11);
        if (z) {
            sensorManager.registerListener(this.f500o, defaultSensor, 1);
        } else {
            sensorManager.unregisterListener(this.f500o);
        }
    }

    public void windowFocusChanged(boolean z) {
        this.f491f.m524a(z);
        if (this.f491f.m529e()) {
            if (z) {
                this.f486a.m453c();
            } else {
                this.f486a.m455d();
            }
            m424h();
        }
    }
}

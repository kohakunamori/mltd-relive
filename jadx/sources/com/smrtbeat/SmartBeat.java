package com.smrtbeat;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Build;
import android.util.Log;
import android.webkit.MimeTypeMap;
import java.io.File;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class SmartBeat {

    /* JADX INFO: renamed from: com.smrtbeat.SmartBeat$a */
    static class RunnableC0361a implements Runnable {

        /* JADX INFO: renamed from: a */
        File f28a;

        /* JADX INFO: renamed from: b */
        String f29b;

        /* JADX INFO: renamed from: com.smrtbeat.SmartBeat$a$a */
        class a implements Runnable {

            /* JADX INFO: renamed from: a */
            File f30a;

            a() {
            }

            /* JADX INFO: renamed from: a */
            Runnable m52a(File file) {
                this.f30a = file;
                return this;
            }

            @Override // java.lang.Runnable
            public void run() {
                C0383k.m219a(this.f30a, 0L);
                this.f30a.delete();
            }
        }

        RunnableC0361a() {
        }

        /* JADX INFO: renamed from: a */
        Runnable m51a(File file, String str) {
            this.f28a = file;
            this.f29b = str;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            for (int i = 30; i > 0 && !this.f28a.exists(); i--) {
                try {
                    Thread.sleep(100L);
                } catch (InterruptedException unused) {
                }
            }
            if (!this.f28a.exists()) {
                C0377f0.m159a(C0377f0.e.WARN, String.format("missing capture image file path=%s", this.f28a.getAbsolutePath()));
                return;
            }
            if (!C0377f0.m199k()) {
                this.f28a.delete();
                return;
            }
            File fileM141b = C0373d0.m141b(this.f29b, System.currentTimeMillis(), "." + MimeTypeMap.getFileExtensionFromUrl(this.f28a.getName()));
            fileM141b.getParentFile().mkdirs();
            if (!this.f28a.renameTo(fileM141b) && !C0377f0.m168a(this.f28a, fileM141b)) {
                C0377f0.m159a(C0377f0.e.ERROR, String.format("failed to move file from %s to %s", this.f28a.getAbsolutePath(), fileM141b.getAbsolutePath()));
            }
            Thread thread = new Thread(new a().m52a(fileM141b));
            thread.setPriority(2);
            thread.start();
        }
    }

    public static void _leaveAutomaticBreadcrumbs(String str, Map<String, String> map) {
        if (m50a() && str != null && str.length() > 0) {
            C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_AUTO_BREADCRUMB, str, map));
        }
    }

    /* JADX INFO: renamed from: a */
    private static void m49a(Application application, String str, boolean z, Collection<Integer> collection, boolean z2, boolean z3) {
        C0377f0.m165a(!z);
        if (!m50a()) {
            C0377f0.m159a(C0377f0.e.INFO, String.format("This Android version(%d) is not supported", Integer.valueOf(Build.VERSION.SDK_INT)));
            return;
        }
        if (C0377f0.m200l()) {
            return;
        }
        Context applicationContext = application.getApplicationContext();
        if (applicationContext == null) {
            throw new IllegalArgumentException("context must not be null");
        }
        if (str == null || str.length() <= 0) {
            throw new IllegalArgumentException("apiKey must not be empty");
        }
        if (str.length() != 36) {
            Log.e("SmartBeat", "Invalid api key:" + str);
            return;
        }
        C0377f0.m187e(C0377f0.m188f(applicationContext));
        C0382j.f242o = str;
        C0377f0.m198k(applicationContext);
        C0382j.m218a(applicationContext);
        C0383k.m252g();
        C0382j.f197E = SmartBeatJni.m61a(application, collection, z3);
        C0382j.f198F = SmartBeatJni.m58a(application);
        Thread.setDefaultUncaughtExceptionHandler(new ExceptionHandler(Thread.getDefaultUncaughtExceptionHandler()));
        if (z2) {
            C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_SB_BREADCRUMB, "BOOT"));
            C0377f0.m154a(application);
        }
        if (Build.VERSION.SDK_INT >= 14) {
            C0392u.m347a(application, z2);
            try {
                JSONObject jSONObjectM307c = C0387o.m307c(C0366a.m74e());
                if (jSONObjectM307c != null && C0377f0.m199k()) {
                    C0383k.m225a(jSONObjectM307c);
                }
                C0366a.m75f();
            } catch (Exception e) {
                C0377f0.m160a(C0377f0.e.WARN, "failed to handle abort data", e);
            }
        }
        C0383k.m249e();
        C0383k.m261p();
    }

    /* JADX INFO: renamed from: a */
    private static boolean m50a() {
        return Build.VERSION.SDK_INT >= 8;
    }

    public static void addExtraData(String str, String str2) {
        if (m50a()) {
            C0377f0.m164a(str, str2);
        }
    }

    public static void addExtraData(HashMap<String, String> map) {
        if (m50a() && map != null) {
            for (Map.Entry<String, String> entry : map.entrySet()) {
                addExtraData(entry.getKey(), entry.getValue());
            }
        }
    }

    public static boolean beginOnDrawFrame() {
        return C0390s.m326b();
    }

    public static void disable() {
        if (m50a()) {
            C0377f0.m165a(true);
        }
    }

    public static void disableAutoScreenCapture() {
        if (m50a()) {
            C0382j.f209Q = false;
        }
    }

    public static void enable() {
        if (m50a()) {
            C0377f0.m165a(false);
        }
    }

    public static void enableAutoScreenCapture() {
        if (m50a()) {
            C0382j.f209Q = true;
        }
    }

    public static void enableDebugLog(String str) {
        if (m50a()) {
            C0382j.f202J = str;
        }
    }

    public static void enableLogCat() {
        if (m50a()) {
            C0382j.f203K = true;
            C0382j.f204L = "";
        }
    }

    public static void enableLogCat(String str) {
        if (m50a()) {
            C0382j.f203K = true;
            C0382j.f204L = str;
        }
    }

    public static void endOnDrawFrame() {
        C0390s.m334e();
    }

    public static void flush() {
        if (m50a() && C0377f0.m200l()) {
            C0383k.m261p();
        }
    }

    public static void initAndStartSession(Application application, SmartBeatConfig smartBeatConfig) {
        if (smartBeatConfig == null) {
            throw new IllegalArgumentException();
        }
        m49a(application, smartBeatConfig.m53a(), smartBeatConfig.m54b(), smartBeatConfig.m55c(), smartBeatConfig.getAutoBreadcrumb(), smartBeatConfig.getCallOtherSignalHandlers());
    }

    public static void initAndStartSession(Application application, String str) {
        m49a(application, str, true, null, true, false);
    }

    public static void initAndStartSession(Application application, String str, boolean z) {
        m49a(application, str, z, null, true, false);
    }

    public static void initAndStartSession(Application application, String str, boolean z, boolean z2) {
        m49a(application, str, z, null, z2, false);
    }

    public static boolean isEnabled() {
        return !C0382j.f228e0;
    }

    public static boolean isReadyForDuplicateUserCountPrevention() {
        return C0377f0.m166a();
    }

    public static boolean isWhiteListed() {
        return C0390s.m335e(Build.MODEL);
    }

    public static void leaveBreadcrumbs(String str) {
        if (m50a() && str != null && str.length() > 0) {
            C0377f0.m163a(str);
        }
    }

    public static void leaveBreadcrumbs(String str, Map<String, String> map) {
        if (m50a() && str != null && str.length() > 0) {
            C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_BREADCRUMB_META, str, map));
        }
    }

    public static void log(String str) {
        C0389q.m312a().m314a(str);
    }

    static void logHandleExceptionCustom(Context context, String str, String str2, String str3, String str4, Map<String, Object> map, String str5) {
        EnumC0381i enumC0381iM211a;
        if (m50a() && C0377f0.m200l() && (enumC0381iM211a = EnumC0381i.m211a(str5)) != null) {
            String string = UUID.randomUUID().toString();
            ExceptionHandler.m46a(context, str, str2, str3, map, enumC0381iM211a, string, str4 == null);
            if (str4 == null || str4.length() <= 0) {
                return;
            }
            Thread thread = new Thread(new RunnableC0361a().m51a(new File(str4), string));
            thread.setPriority(2);
            thread.start();
        }
    }

    public static void logHandleExceptionForCocos2dJs(String str, String str2, String str3, String str4) {
        HashMap map = new HashMap();
        map.put("engineVersion", str4);
        map.put("scriptDirPath", "assets");
        logHandleExceptionCustom(null, str, str2, str3, null, map, EnumC0381i.COCOS2DJS.m215c());
    }

    public static void logHandleExceptionForUnity(Context context, String str, String str2) {
        logHandleExceptionForUnity(context, str, str2, "");
    }

    public static void logHandleExceptionForUnity(Context context, String str, String str2, String str3) {
        logHandleExceptionCustom(context, null, str, str2, str3, null, EnumC0381i.UNITY.m215c());
    }

    public static void logHandledException(Context context, Throwable th) {
        if (m50a() && C0377f0.m200l()) {
            ExceptionHandler.m47a(context, th);
        }
    }

    public static void notifyActivityStarted(Activity activity) {
        String str;
        if (Build.VERSION.SDK_INT < 14 || (str = C0382j.f242o) == null || str.length() <= 0 || !activity.hasWindowFocus()) {
            return;
        }
        C0368b.m82a().m89b(activity);
    }

    public static void notifyOnPause(Activity activity) {
        if (m50a() && Build.VERSION.SDK_INT < 14) {
            C0377f0.m152a(activity);
        }
    }

    public static void notifyOnResume(Activity activity) {
        if (m50a()) {
            if (Build.VERSION.SDK_INT < 14) {
                C0377f0.m172b(activity);
            } else {
                C0377f0.m179c(activity);
            }
        }
    }

    public static void notifyRunning() {
        if (m50a() && C0377f0.m200l()) {
            C0383k.m256k();
        }
    }

    public static void onSurfaceCreated(int i) {
        onSurfaceCreated(i, false);
    }

    public static void onSurfaceCreated(int i, boolean z) {
        C0382j.f199G = i;
        C0390s.m323a(z);
    }

    public static void setActivityAsSensitive(String str) {
        if (!m50a() || str == null || str.length() == 0) {
            return;
        }
        List<String> list = C0382j.f211S;
        synchronized (list) {
            list.add(str);
        }
    }

    public static void setActivityAsSensitive(List<String> list) {
        if (!m50a() || list == null || list.size() == 0) {
            return;
        }
        List<String> list2 = C0382j.f211S;
        synchronized (list2) {
            list2.addAll(list);
        }
    }

    @Deprecated
    public static void setOpenGLESVersion(int i) {
        Log.w("SmartBeat", "deprecated API (SmartBeat.setOpenGLESVersion) is used.");
    }

    public static void setUserId(String str) {
        if (m50a()) {
            C0382j.f205M = str;
        }
    }

    @Deprecated
    public static void whiteListBoardForOpenGLES(String str) {
        Log.w("SmartBeat", "deprecated API (SmartBeat.whiteListBoardForOpenGLES) is used.");
    }

    public static void whiteListModelForOpenGLES(String str) {
        C0390s.m325b(str);
    }
}

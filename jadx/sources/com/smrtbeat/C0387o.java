package com.smrtbeat;

import android.app.ActivityManager;
import android.content.Context;
import android.os.Build;
import android.os.Process;
import com.google.android.gms.measurement.api.AppMeasurementSdk;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: renamed from: com.smrtbeat.o */
/* JADX INFO: loaded from: classes.dex */
class C0387o {

    /* JADX INFO: renamed from: a */
    private static final int f304a = 1;

    C0387o() {
    }

    /* JADX INFO: renamed from: a */
    static JSONObject m288a() {
        JSONObject jSONObject = new JSONObject();
        JSONObject jSONObject2 = new JSONObject();
        m300a(jSONObject2, "type", "ping");
        m300a(jSONObject2, "userId", C0382j.f205M);
        m300a(jSONObject2, "occuredAt", String.valueOf(System.currentTimeMillis()));
        m300a(jSONObject, "request", jSONObject2);
        m300a(jSONObject, "environment", m309d());
        m300a(jSONObject, "sdk", m306c());
        return jSONObject;
    }

    /* JADX INFO: renamed from: a */
    private static JSONObject m289a(long j) {
        JSONObject jSONObject = new JSONObject();
        m300a(jSONObject, "type", "breakpad-exception-report");
        m300a(jSONObject, "userId", C0382j.f205M);
        m300a(jSONObject, "requestId", C0382j.f196D);
        m300a(jSONObject, "occuredAt", String.valueOf(j));
        return jSONObject;
    }

    /* JADX INFO: renamed from: a */
    private static JSONObject m290a(long j, boolean z) {
        JSONObject jSONObject = new JSONObject();
        m300a(jSONObject, "userId", C0382j.f205M);
        m300a(jSONObject, "requestId", !z ? C0382j.f196D : C0377f0.m171b());
        m300a(jSONObject, "occuredAt", String.valueOf(j));
        return jSONObject;
    }

    /* JADX INFO: renamed from: a */
    static JSONObject m291a(Context context) {
        JSONObject jSONObject = new JSONObject();
        long jCurrentTimeMillis = System.currentTimeMillis();
        m300a(jSONObject, "request", m289a(jCurrentTimeMillis));
        m300a(jSONObject, "exception", m296a((Throwable) null, false));
        m300a(jSONObject, "performance", m303b(context));
        m300a(jSONObject, "environment", m292a(context, jCurrentTimeMillis, false));
        m300a(jSONObject, "sdk", m306c());
        return jSONObject;
    }

    /* JADX INFO: renamed from: a */
    private static JSONObject m292a(Context context, long j, boolean z) throws Throwable {
        JSONObject jSONObjectM309d = m309d();
        if (context != null) {
            m300a(jSONObjectM309d, "mobileNet", C0377f0.m182d(context));
            m300a(jSONObjectM309d, "wifi", C0377f0.m194i(context));
            m300a(jSONObjectM309d, "screenRotation", C0377f0.m186e(context));
        }
        m300a(jSONObjectM309d, "screenDpi", String.valueOf(C0382j.f252y));
        m300a(jSONObjectM309d, "screenWidth", String.valueOf(C0382j.f253z));
        m300a(jSONObjectM309d, "screenHeight", String.valueOf(C0382j.f193A));
        m300a(jSONObjectM309d, "board", C0377f0.m177c());
        m300a(jSONObjectM309d, "boardPlatform", C0377f0.m185e());
        m300a(jSONObjectM309d, "cpuAbi", C0377f0.m189f());
        m300a(jSONObjectM309d, "manufacturer", Build.MANUFACTURER);
        m300a(jSONObjectM309d, "buildType", Build.TYPE);
        m298a(jSONObjectM309d, j, z);
        m304b(jSONObjectM309d);
        return jSONObjectM309d;
    }

    /* JADX INFO: renamed from: a */
    static JSONObject m293a(Context context, String str, String str2, String str3, Map<String, Object> map, EnumC0381i enumC0381i, String str4) {
        JSONObject jSONObject = new JSONObject();
        long jCurrentTimeMillis = System.currentTimeMillis();
        JSONObject jSONObjectM290a = m290a(jCurrentTimeMillis, false);
        m300a(jSONObjectM290a, "type", enumC0381i.m216d());
        m300a(jSONObjectM290a, "requestId", str4);
        m300a(jSONObjectM290a, "occuredAt", String.valueOf(System.currentTimeMillis()));
        m300a(jSONObject, "request", jSONObjectM290a);
        m300a(jSONObject, "exception", m295a(str, str2, str3, enumC0381i.m212a(map), enumC0381i.m214b()));
        m300a(jSONObject, "performance", m303b(context));
        m300a(jSONObject, "environment", m292a(context, jCurrentTimeMillis, enumC0381i.m213a()));
        m300a(jSONObject, "sdk", m306c());
        return jSONObject;
    }

    /* JADX INFO: renamed from: a */
    static JSONObject m294a(Context context, Throwable th, boolean z) {
        JSONObject jSONObject = new JSONObject();
        long jCurrentTimeMillis = System.currentTimeMillis();
        JSONObject jSONObjectM290a = m290a(jCurrentTimeMillis, z);
        m300a(jSONObjectM290a, "type", "exception-report");
        m300a(jSONObject, "request", jSONObjectM290a);
        m300a(jSONObject, "exception", m296a(th, z));
        m300a(jSONObject, "performance", m303b(context));
        m300a(jSONObject, "environment", m292a(context, jCurrentTimeMillis, false));
        m300a(jSONObject, "sdk", m306c());
        return jSONObject;
    }

    /* JADX INFO: renamed from: a */
    private static JSONObject m295a(String str, String str2, String str3, Map<String, Object> map, boolean z) {
        JSONObject jSONObject = new JSONObject();
        if (str != null) {
            m300a(jSONObject, "cause", str);
        }
        if (str2 != null) {
            m300a(jSONObject, "message", str2);
        }
        if (str3 != null) {
            m300a(jSONObject, "stackTrace", str3);
        }
        if (map != null) {
            m300a(jSONObject, "auxData", new JSONObject(map));
        }
        m297a(jSONObject);
        m300a(jSONObject, "handled", String.valueOf(z));
        return jSONObject;
    }

    /* JADX INFO: renamed from: a */
    private static JSONObject m296a(Throwable th, boolean z) {
        JSONObject jSONObject = new JSONObject();
        if (th != null) {
            m305b(jSONObject, th);
            m301a(jSONObject, th);
            m308c(jSONObject, th);
            m311d(jSONObject, th);
        }
        m297a(jSONObject);
        m300a(jSONObject, "handled", String.valueOf(z));
        return jSONObject;
    }

    /* JADX INFO: renamed from: a */
    private static void m297a(JSONObject jSONObject) {
        JSONArray jSONArray = new JSONArray();
        List<C0372d> list = C0382j.f200H;
        if (list != null && list.size() > 0) {
            synchronized (list) {
                Iterator<C0372d> it = list.iterator();
                while (it.hasNext()) {
                    try {
                        jSONArray.put(it.next().m131a());
                    } catch (JSONException unused) {
                    }
                }
            }
        }
        m300a(jSONObject, "breadcrumbV2s", jSONArray);
    }

    /* JADX INFO: renamed from: a */
    private static void m298a(JSONObject jSONObject, long j, boolean z) throws Throwable {
        String string;
        JSONObject jSONObject2 = new JSONObject();
        if (!C0382j.f203K || z) {
            string = C0389q.m312a().toString();
            if (string.length() > 0) {
            }
            m300a(jSONObject2, "hacked", String.valueOf(C0382j.f251x));
            m300a(jSONObject2, "msFromStart", String.valueOf(j - C0382j.f194B));
            m300a(jSONObject, "log", jSONObject2);
        }
        string = C0377f0.m204p();
        m300a(jSONObject2, "log", string);
        m300a(jSONObject2, "hacked", String.valueOf(C0382j.f251x));
        m300a(jSONObject2, "msFromStart", String.valueOf(j - C0382j.f194B));
        m300a(jSONObject, "log", jSONObject2);
    }

    /* JADX INFO: renamed from: a */
    private static void m299a(JSONObject jSONObject, Context context) {
        JSONObject jSONObject2 = new JSONObject();
        if (context != null) {
            ActivityManager.MemoryInfo memoryInfo = new ActivityManager.MemoryInfo();
            ActivityManager activityManager = (ActivityManager) context.getSystemService("activity");
            activityManager.getMemoryInfo(memoryInfo);
            m300a(jSONObject2, "sysAvail", String.valueOf(memoryInfo.availMem));
            m300a(jSONObject2, "sysLow", String.valueOf(memoryInfo.lowMemory));
            m300a(jSONObject2, "sysThreshold", String.valueOf(memoryInfo.threshold));
            m300a(jSONObject2, "appPss", String.valueOf(activityManager.getProcessMemoryInfo(new int[]{Process.myPid()})[0].getTotalPss() * 1024));
        } else {
            m300a(jSONObject2, "sysAvail", "");
            m300a(jSONObject2, "sysLow", "");
            m300a(jSONObject2, "sysThreshold", "");
            m300a(jSONObject2, "appPss", "");
        }
        Runtime runtime = Runtime.getRuntime();
        m300a(jSONObject2, "appAvail", String.valueOf(runtime.freeMemory()));
        m300a(jSONObject2, "appMax", String.valueOf(runtime.maxMemory()));
        m300a(jSONObject2, "appTotal", String.valueOf(runtime.totalMemory()));
        m300a(jSONObject, "memory", jSONObject2);
    }

    /* JADX INFO: renamed from: a */
    static void m300a(JSONObject jSONObject, String str, Object obj) {
        try {
            jSONObject.put(str, obj);
        } catch (JSONException unused) {
        }
    }

    /* JADX INFO: renamed from: a */
    private static void m301a(JSONObject jSONObject, Throwable th) {
        m300a(jSONObject, "cause", th.getClass().getName());
    }

    /* JADX INFO: renamed from: b */
    static JSONObject m302b() {
        JSONObject jSONObject = new JSONObject();
        JSONObject jSONObject2 = new JSONObject();
        m300a(jSONObject2, "type", "remote");
        m300a(jSONObject2, "userId", C0382j.f205M);
        m300a(jSONObject2, "occuredAt", String.valueOf(System.currentTimeMillis()));
        m300a(jSONObject, "request", jSONObject2);
        m300a(jSONObject, "environment", m309d());
        m300a(jSONObject, "sdk", m306c());
        return jSONObject;
    }

    /* JADX INFO: renamed from: b */
    private static JSONObject m303b(Context context) {
        JSONObject jSONObject = new JSONObject();
        m299a(jSONObject, context);
        return jSONObject;
    }

    /* JADX INFO: renamed from: b */
    private static void m304b(JSONObject jSONObject) {
        Map<String, String> map = C0382j.f201I;
        if (map == null || map.size() <= 0) {
            return;
        }
        synchronized (map) {
            JSONObject jSONObject2 = new JSONObject();
            for (Map.Entry<String, String> entry : map.entrySet()) {
                m300a(jSONObject2, entry.getKey(), entry.getValue());
            }
            m300a(jSONObject, "customMeta", jSONObject2);
        }
    }

    /* JADX INFO: renamed from: b */
    private static void m305b(JSONObject jSONObject, Throwable th) {
        String message = th.getMessage();
        if (message == null) {
            message = "";
        }
        m300a(jSONObject, "message", message);
    }

    /* JADX INFO: renamed from: c */
    private static JSONObject m306c() {
        JSONObject jSONObject = new JSONObject();
        m300a(jSONObject, AppMeasurementSdk.ConditionalUserProperty.NAME, "SmartBeat-Android");
        m300a(jSONObject, "version", C0376f.f146d);
        return jSONObject;
    }

    /* JADX INFO: renamed from: c */
    static JSONObject m307c(JSONObject jSONObject) {
        if (jSONObject == null) {
            return null;
        }
        JSONObject jSONObject2 = new JSONObject();
        JSONObject jSONObjectM290a = m290a(System.currentTimeMillis(), true);
        m300a(jSONObjectM290a, "type", "abort-report");
        m300a(jSONObject2, "request", jSONObjectM290a);
        JSONObject jSONObjectM310d = m310d(jSONObject);
        if (jSONObjectM310d == null) {
            return null;
        }
        m300a(jSONObject2, "abort", jSONObjectM310d);
        m300a(jSONObject2, "environment", m309d());
        m300a(jSONObject2, "sdk", m306c());
        return jSONObject2;
    }

    /* JADX INFO: renamed from: c */
    private static void m308c(JSONObject jSONObject, Throwable th) {
        JSONObject jSONObject2 = new JSONObject();
        StackTraceElement[] stackTrace = th.getStackTrace();
        if (stackTrace != null && stackTrace.length > 1 && stackTrace[0] != null) {
            m300a(jSONObject2, "file", stackTrace[0].getFileName());
            m300a(jSONObject2, "line", String.valueOf(stackTrace[0].getLineNumber()));
            m300a(jSONObject2, "class", stackTrace[0].getClassName());
            m300a(jSONObject2, FirebaseAnalytics.Param.METHOD, stackTrace[0].getMethodName());
        }
        m300a(jSONObject, FirebaseAnalytics.Param.LOCATION, jSONObject2);
    }

    /* JADX INFO: renamed from: d */
    private static JSONObject m309d() {
        JSONObject jSONObject = new JSONObject();
        m300a(jSONObject, "uid", C0382j.f247t);
        String str = C0382j.f248u;
        if (str != null) {
            m300a(jSONObject, "idv2", str);
        }
        m300a(jSONObject, "model", C0382j.f246s);
        m300a(jSONObject, "brand", C0382j.f245r);
        m300a(jSONObject, "appVer", C0382j.f244q);
        m300a(jSONObject, "appVerCode", C0382j.f249v);
        m300a(jSONObject, "appName", C0382j.f243p);
        m300a(jSONObject, "appIdentifier", C0382j.f243p);
        m300a(jSONObject, "osVer", C0382j.f250w);
        m300a(jSONObject, "locale", C0377f0.m181d());
        m300a(jSONObject, "optOutCrashLog", String.valueOf(C0382j.f228e0));
        return jSONObject;
    }

    /* JADX INFO: renamed from: d */
    private static JSONObject m310d(JSONObject jSONObject) {
        JSONObject jSONObject2 = new JSONObject();
        try {
            m300a(jSONObject2, "lastActivateTime", Long.valueOf(jSONObject.getLong("last_fg_time")));
            m300a(jSONObject2, "lastActivateTimeFromBoot", Long.valueOf(jSONObject.getLong("elapsed_time")));
            m300a(jSONObject2, "timeZoneOffset", Integer.valueOf(jSONObject.getInt("zone_offset")));
            m300a(jSONObject2, "reason", Integer.valueOf(jSONObject.getBoolean("exit") ? 1 : 0));
            return jSONObject2;
        } catch (JSONException unused) {
            return null;
        }
    }

    /* JADX INFO: renamed from: d */
    private static void m311d(JSONObject jSONObject, Throwable th) {
        StringWriter stringWriter = new StringWriter();
        th.printStackTrace(new PrintWriter(stringWriter));
        m300a(jSONObject, "stackTrace", stringWriter.toString());
    }
}

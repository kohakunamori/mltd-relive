package com.smrtbeat;

import android.os.Build;
import android.os.SystemClock;
import java.util.TimeZone;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: renamed from: com.smrtbeat.a */
/* JADX INFO: loaded from: classes.dex */
class C0366a implements C0368b.e {

    /* JADX INFO: renamed from: a */
    static final String f45a = "version";

    /* JADX INFO: renamed from: b */
    static final String f46b = "app_version_name";

    /* JADX INFO: renamed from: c */
    static final String f47c = "app_version_code";

    /* JADX INFO: renamed from: d */
    static final String f48d = "os_version_fp";

    /* JADX INFO: renamed from: e */
    static final String f49e = "last_fg_time";

    /* JADX INFO: renamed from: f */
    static final String f50f = "zone_offset";

    /* JADX INFO: renamed from: g */
    static final String f51g = "elapsed_time";

    /* JADX INFO: renamed from: h */
    static final String f52h = "exit";

    /* JADX INFO: renamed from: i */
    private static final Integer f53i = 1;

    /* JADX INFO: renamed from: j */
    private static final long f54j = 86400000;

    /* JADX INFO: renamed from: k */
    private static final long f55k = 600000;

    /* JADX INFO: renamed from: l */
    private static C0366a f56l;

    private C0366a() {
    }

    /* JADX INFO: renamed from: a */
    private static boolean m70a(JSONObject jSONObject) {
        try {
            return f53i.equals(Integer.valueOf(jSONObject.getInt(f45a))) && C0382j.f244q.equals(jSONObject.getString(f46b)) && C0382j.f249v.equals(jSONObject.getString(f47c)) && Build.FINGERPRINT.equals(jSONObject.getString(f48d));
        } catch (JSONException unused) {
            return false;
        }
    }

    /* JADX INFO: renamed from: b */
    static boolean m71b(JSONObject jSONObject) {
        try {
            long j = jSONObject.getJSONObject("abort").getLong("lastActivateTime");
            long jCurrentTimeMillis = System.currentTimeMillis();
            return j <= 0 || jCurrentTimeMillis <= 0 || j < jCurrentTimeMillis - f54j || j - f55k > jCurrentTimeMillis;
        } catch (JSONException unused) {
            return true;
        }
    }

    /* JADX INFO: renamed from: c */
    static synchronized void m72c() {
        if (f56l != null) {
            C0383k.m250f();
        }
    }

    /* JADX INFO: renamed from: d */
    private JSONObject m73d() {
        JSONObject jSONObject = new JSONObject();
        C0387o.m300a(jSONObject, f45a, f53i);
        C0387o.m300a(jSONObject, f48d, Build.FINGERPRINT);
        C0387o.m300a(jSONObject, f49e, Long.valueOf(System.currentTimeMillis()));
        C0387o.m300a(jSONObject, f50f, Integer.valueOf(TimeZone.getDefault().getRawOffset()));
        C0387o.m300a(jSONObject, f51g, Long.valueOf(SystemClock.elapsedRealtime()));
        C0387o.m300a(jSONObject, f52h, Boolean.FALSE);
        C0387o.m300a(jSONObject, f46b, C0382j.f244q);
        C0387o.m300a(jSONObject, f47c, C0382j.f249v);
        return jSONObject;
    }

    /* JADX INFO: renamed from: e */
    static synchronized JSONObject m74e() {
        JSONObject jSONObjectM254i;
        jSONObjectM254i = C0383k.m254i();
        if (jSONObjectM254i != null) {
            C0383k.m250f();
            if (!m70a(jSONObjectM254i)) {
                jSONObjectM254i = null;
            }
        }
        return jSONObjectM254i;
    }

    /* JADX INFO: renamed from: f */
    static void m75f() {
        synchronized (C0366a.class) {
            if (f56l == null) {
                f56l = new C0366a();
                C0368b.m82a().m87a(f56l);
            }
        }
    }

    /* JADX INFO: renamed from: g */
    static synchronized void m76g() {
        JSONObject jSONObjectM254i;
        if (f56l != null && (jSONObjectM254i = C0383k.m254i()) != null) {
            C0387o.m300a(jSONObjectM254i, f52h, Boolean.TRUE);
            C0383k.m250f();
            C0383k.m247d(jSONObjectM254i);
        }
    }

    /* JADX INFO: renamed from: h */
    static synchronized void m77h() {
        C0366a c0366a = f56l;
        if (c0366a != null) {
            C0383k.m247d(c0366a.m73d());
        }
    }

    @Override // com.smrtbeat.C0368b.e
    /* JADX INFO: renamed from: a */
    public void mo78a() {
        m77h();
    }

    @Override // com.smrtbeat.C0368b.e
    /* JADX INFO: renamed from: b */
    public void mo79b() {
        m72c();
    }
}

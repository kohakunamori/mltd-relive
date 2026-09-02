package com.smrtbeat;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: renamed from: com.smrtbeat.d */
/* JADX INFO: loaded from: classes.dex */
class C0372d {

    /* JADX INFO: renamed from: a */
    private final long f123a;

    /* JADX INFO: renamed from: b */
    private EnumC0374e f124b;

    /* JADX INFO: renamed from: c */
    private final String f125c;

    /* JADX INFO: renamed from: d */
    private final Map<String, String> f126d;

    C0372d(EnumC0374e enumC0374e, String str) {
        this(enumC0374e, str, null);
    }

    C0372d(EnumC0374e enumC0374e, String str, Map<String, String> map) {
        this.f123a = System.currentTimeMillis();
        this.f124b = enumC0374e;
        this.f125c = str != null ? str.substring(0, Math.min(140, str.length())) : null;
        this.f126d = map != null ? new HashMap<>(map) : Collections.emptyMap();
        m130f();
    }

    C0372d(String str) {
        this(EnumC0374e.BC2_TYPE_LEGACY_BREADCRUMB, str);
    }

    /* JADX INFO: renamed from: f */
    private void m130f() {
        try {
            JSONObject jSONObjectM131a = m131a();
            if (!EnumC0374e.f140j.contains(m134d()) || jSONObjectM131a.toString().length() <= 1024) {
                return;
            }
            this.f124b = EnumC0374e.m143a(m134d().m144a() + 1);
            this.f126d.clear();
        } catch (JSONException unused) {
        }
    }

    /* JADX INFO: renamed from: a */
    JSONObject m131a() throws JSONException {
        JSONObject jSONObject = new JSONObject();
        jSONObject.put("type", m134d().m144a());
        jSONObject.put("value", m135e());
        jSONObject.put("timestamp", m133c());
        JSONObject jSONObject2 = new JSONObject();
        for (Map.Entry<String, String> entry : m132b().entrySet()) {
            jSONObject2.put(entry.getKey(), entry.getValue());
        }
        jSONObject.put("metas", jSONObject2);
        return jSONObject;
    }

    /* JADX INFO: renamed from: b */
    Map<String, String> m132b() {
        return Collections.unmodifiableMap(this.f126d);
    }

    /* JADX INFO: renamed from: c */
    long m133c() {
        return this.f123a;
    }

    /* JADX INFO: renamed from: d */
    EnumC0374e m134d() {
        return this.f124b;
    }

    /* JADX INFO: renamed from: e */
    String m135e() {
        return this.f125c;
    }
}

package com.smrtbeat;

import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: renamed from: com.smrtbeat.b0 */
/* JADX INFO: loaded from: classes.dex */
class C0369b0 {

    /* JADX INFO: renamed from: a */
    int f75a = 0;

    /* JADX INFO: renamed from: b */
    String f76b = "";

    /* JADX INFO: renamed from: com.smrtbeat.b0$a */
    enum a {
        OK,
        FAILED_BY_DATA,
        FAILED_BY_SERVER,
        FAILED_BY_OTHER
    }

    C0369b0() {
    }

    /* JADX INFO: renamed from: a */
    private boolean m91a(String str, String str2) {
        try {
            JSONArray jSONArray = new JSONObject(str).getJSONArray("filesSaved");
            boolean z = false;
            for (int i = 0; i < jSONArray.length(); i++) {
                try {
                    if (str2.equals(jSONArray.get(i))) {
                        z = true;
                    }
                } catch (Exception unused) {
                    return z;
                }
            }
            return z;
        } catch (Exception unused2) {
            return false;
        }
    }

    /* JADX INFO: renamed from: b */
    private static boolean m92b(String str) {
        try {
            return "OK".equals(new JSONObject(str).get("status"));
        } catch (Exception unused) {
            return false;
        }
    }

    /* JADX INFO: renamed from: a */
    a m93a() {
        if (m92b(this.f76b)) {
            return a.OK;
        }
        int i = this.f75a;
        if (i != 400) {
            return i != 500 ? a.FAILED_BY_OTHER : a.FAILED_BY_SERVER;
        }
        return a.FAILED_BY_DATA;
    }

    /* JADX INFO: renamed from: a */
    a m94a(String str) {
        if (this.f75a == 200 && m91a(this.f76b, str)) {
            return a.OK;
        }
        int i = this.f75a;
        if (i != 400) {
            return i != 500 ? a.FAILED_BY_OTHER : a.FAILED_BY_SERVER;
        }
        return a.FAILED_BY_DATA;
    }

    public String toString() {
        return "\"code\":" + this.f75a + ", \"data\":\"" + this.f76b + "\"";
    }
}

package com.smrtbeat;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/* JADX INFO: renamed from: com.smrtbeat.i */
/* JADX INFO: loaded from: classes.dex */
enum EnumC0381i {
    UNITY("unity", "unity-exception-report", false, false, null),
    COCOS2DJS("cocos2djs", "cocos2djs-exception-report", true, true, new String[]{"engineVersion", "scriptDirPath"}),
    UNREAL("unreal", "unreal-exception-report", true, true, new String[]{"engineVersion"}),
    CORDOVA("cordova", "cordova-exception-report", true, true, new String[]{"engineVersion"});


    /* JADX INFO: renamed from: a */
    private String f188a;

    /* JADX INFO: renamed from: b */
    private String f189b;

    /* JADX INFO: renamed from: c */
    private boolean f190c;

    /* JADX INFO: renamed from: d */
    private boolean f191d;

    /* JADX INFO: renamed from: e */
    private List<String> f192e;

    EnumC0381i(String str, String str2, boolean z, boolean z2, String[] strArr) {
        this.f188a = str;
        this.f189b = str2;
        this.f190c = z;
        this.f191d = z2;
        if (strArr != null) {
            this.f192e = Arrays.asList(strArr);
        }
    }

    /* JADX INFO: renamed from: a */
    static EnumC0381i m211a(String str) {
        for (EnumC0381i enumC0381i : values()) {
            if (enumC0381i.f188a.equals(str)) {
                return enumC0381i;
            }
        }
        return null;
    }

    /* JADX INFO: renamed from: a */
    Map<String, Object> m212a(Map<String, Object> map) {
        List<String> list = this.f192e;
        if (list == null || list.isEmpty()) {
            return null;
        }
        HashMap map2 = new HashMap();
        for (String str : this.f192e) {
            Object obj = map != null ? map.get(str) : null;
            if (obj == null) {
                obj = "";
            }
            map2.put(str, obj);
        }
        return map2;
    }

    /* JADX INFO: renamed from: a */
    boolean m213a() {
        return this.f191d;
    }

    /* JADX INFO: renamed from: b */
    boolean m214b() {
        return this.f190c;
    }

    /* JADX INFO: renamed from: c */
    String m215c() {
        return this.f188a;
    }

    /* JADX INFO: renamed from: d */
    String m216d() {
        return this.f189b;
    }
}

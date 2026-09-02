package com.unity3d.player;

import java.lang.reflect.Method;
import java.util.HashMap;

/* JADX INFO: renamed from: com.unity3d.player.o */
/* JADX INFO: loaded from: classes.dex */
final class C0466o {

    /* JADX INFO: renamed from: a */
    private HashMap f680a = new HashMap();

    /* JADX INFO: renamed from: b */
    private Class f681b;

    /* JADX INFO: renamed from: c */
    private Object f682c;

    /* JADX INFO: renamed from: com.unity3d.player.o$a */
    class a {

        /* JADX INFO: renamed from: a */
        public Class[] f683a;

        /* JADX INFO: renamed from: b */
        public Method f684b = null;

        public a(Class[] clsArr) {
            this.f683a = clsArr;
        }
    }

    public C0466o(Class cls, Object obj) {
        this.f681b = null;
        this.f682c = null;
        this.f681b = cls;
        this.f682c = obj;
    }

    /* JADX INFO: renamed from: a */
    private void m532a(String str, a aVar) {
        try {
            aVar.f684b = this.f681b.getMethod(str, aVar.f683a);
        } catch (Exception e) {
            C0458g.Log(6, "Exception while trying to get method " + str + ". " + e.getLocalizedMessage());
            aVar.f684b = null;
        }
    }

    /* JADX INFO: renamed from: a */
    public final Object m533a(String str, Object... objArr) {
        StringBuilder sb;
        if (this.f680a.containsKey(str)) {
            a aVar = (a) this.f680a.get(str);
            if (aVar.f684b == null) {
                m532a(str, aVar);
            }
            if (aVar.f684b != null) {
                try {
                    return objArr.length == 0 ? aVar.f684b.invoke(this.f682c, new Object[0]) : aVar.f684b.invoke(this.f682c, objArr);
                } catch (Exception e) {
                    C0458g.Log(6, "Error trying to call delegated method " + str + ". " + e.getLocalizedMessage());
                    return null;
                }
            }
            sb = new StringBuilder("Unable to create method: ");
        } else {
            sb = new StringBuilder("No definition for method ");
            sb.append(str);
            str = " can be found";
        }
        sb.append(str);
        C0458g.Log(6, sb.toString());
        return null;
    }

    /* JADX INFO: renamed from: a */
    public final void m534a(String str, Class[] clsArr) {
        this.f680a.put(str, new a(clsArr));
    }
}

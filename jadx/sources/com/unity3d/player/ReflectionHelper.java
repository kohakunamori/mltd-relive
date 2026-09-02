package com.unity3d.player;

import java.lang.invoke.MethodHandles;
import java.lang.reflect.Array;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Member;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.lang.reflect.Proxy;
import java.util.ArrayList;
import java.util.Iterator;

/* JADX INFO: loaded from: classes.dex */
final class ReflectionHelper {
    protected static boolean LOG;
    protected static final boolean LOGV = false;

    /* JADX INFO: renamed from: a */
    private static C0421a[] f476a = new C0421a[4096];

    /* JADX INFO: renamed from: b */
    private static long f477b = 0;

    /* JADX INFO: renamed from: com.unity3d.player.ReflectionHelper$a */
    private static class C0421a {

        /* JADX INFO: renamed from: a */
        public volatile Member f481a;

        /* JADX INFO: renamed from: b */
        private final Class f482b;

        /* JADX INFO: renamed from: c */
        private final String f483c;

        /* JADX INFO: renamed from: d */
        private final String f484d;

        /* JADX INFO: renamed from: e */
        private final int f485e;

        C0421a(Class cls, String str, String str2) {
            this.f482b = cls;
            this.f483c = str;
            this.f484d = str2;
            this.f485e = ((((this.f482b.hashCode() + 527) * 31) + this.f483c.hashCode()) * 31) + this.f484d.hashCode();
        }

        public final boolean equals(Object obj) {
            if (obj == this) {
                return true;
            }
            if (obj instanceof C0421a) {
                C0421a c0421a = (C0421a) obj;
                if (this.f485e == c0421a.f485e && this.f484d.equals(c0421a.f484d) && this.f483c.equals(c0421a.f483c) && this.f482b.equals(c0421a.f482b)) {
                    return true;
                }
            }
            return false;
        }

        public final int hashCode() {
            return this.f485e;
        }
    }

    ReflectionHelper() {
    }

    /* JADX INFO: renamed from: a */
    private static float m382a(Class cls, Class cls2) {
        if (cls.equals(cls2)) {
            return 1.0f;
        }
        if (cls.isPrimitive() || cls2.isPrimitive()) {
            return 0.0f;
        }
        try {
            if (cls.asSubclass(cls2) != null) {
                return 0.5f;
            }
        } catch (ClassCastException unused) {
        }
        try {
            return cls2.asSubclass(cls) != null ? 0.1f : 0.0f;
        } catch (ClassCastException unused2) {
            return 0.0f;
        }
    }

    /* JADX INFO: renamed from: a */
    private static float m383a(Class cls, Class[] clsArr, Class[] clsArr2) {
        if (clsArr2.length == 0) {
            return 0.1f;
        }
        int i = 0;
        if ((clsArr == null ? 0 : clsArr.length) + 1 != clsArr2.length) {
            return 0.0f;
        }
        float fM382a = 1.0f;
        if (clsArr != null) {
            int length = clsArr.length;
            int i2 = 0;
            while (i < length) {
                fM382a *= m382a(clsArr[i], clsArr2[i2]);
                i++;
                i2++;
            }
        }
        return fM382a * m382a(cls, clsArr2[clsArr2.length - 1]);
    }

    /* JADX INFO: renamed from: a */
    private static Class m385a(String str, int[] iArr) {
        while (iArr[0] < str.length()) {
            int i = iArr[0];
            iArr[0] = i + 1;
            char cCharAt = str.charAt(i);
            if (cCharAt != '(' && cCharAt != ')') {
                if (cCharAt == 'L') {
                    int iIndexOf = str.indexOf(59, iArr[0]);
                    if (iIndexOf == -1) {
                        return null;
                    }
                    String strSubstring = str.substring(iArr[0], iIndexOf);
                    iArr[0] = iIndexOf + 1;
                    try {
                        return Class.forName(strSubstring.replace('/', '.'));
                    } catch (ClassNotFoundException unused) {
                        return null;
                    }
                }
                if (cCharAt == 'Z') {
                    return Boolean.TYPE;
                }
                if (cCharAt == 'I') {
                    return Integer.TYPE;
                }
                if (cCharAt == 'F') {
                    return Float.TYPE;
                }
                if (cCharAt == 'V') {
                    return Void.TYPE;
                }
                if (cCharAt == 'B') {
                    return Byte.TYPE;
                }
                if (cCharAt == 'C') {
                    return Character.TYPE;
                }
                if (cCharAt == 'S') {
                    return Short.TYPE;
                }
                if (cCharAt == 'J') {
                    return Long.TYPE;
                }
                if (cCharAt == 'D') {
                    return Double.TYPE;
                }
                if (cCharAt == '[') {
                    return Array.newInstance((Class<?>) m385a(str, iArr), 0).getClass();
                }
                C0458g.Log(5, "! parseType; " + cCharAt + " is not known!");
                return null;
            }
        }
        return null;
    }

    /* JADX INFO: renamed from: a */
    private static void m388a(C0421a c0421a, Member member) {
        c0421a.f481a = member;
        f476a[c0421a.hashCode() & (f476a.length - 1)] = c0421a;
    }

    /* JADX INFO: renamed from: a */
    private static boolean m389a(C0421a c0421a) {
        C0421a c0421a2 = f476a[c0421a.hashCode() & (f476a.length - 1)];
        if (!c0421a.equals(c0421a2)) {
            return false;
        }
        c0421a.f481a = c0421a2.f481a;
        return true;
    }

    /* JADX INFO: renamed from: a */
    private static Class[] m390a(String str) {
        Class clsM385a;
        int i = 0;
        int[] iArr = {0};
        ArrayList arrayList = new ArrayList();
        while (iArr[0] < str.length() && (clsM385a = m385a(str, iArr)) != null) {
            arrayList.add(clsM385a);
        }
        Class[] clsArr = new Class[arrayList.size()];
        Iterator it = arrayList.iterator();
        while (it.hasNext()) {
            clsArr[i] = (Class) it.next();
            i++;
        }
        return clsArr;
    }

    protected static void endUnityLaunch() {
        f477b++;
    }

    protected static Constructor getConstructorID(Class cls, String str) {
        Constructor<?> constructor;
        C0421a c0421a = new C0421a(cls, "", str);
        if (m389a(c0421a)) {
            constructor = (Constructor) c0421a.f481a;
        } else {
            Class[] clsArrM390a = m390a(str);
            float f = 0.0f;
            Constructor<?> constructor2 = null;
            for (Constructor<?> constructor3 : cls.getConstructors()) {
                float fM383a = m383a(Void.TYPE, constructor3.getParameterTypes(), clsArrM390a);
                if (fM383a > f) {
                    if (fM383a == 1.0f) {
                        constructor2 = constructor3;
                        break;
                    }
                    constructor2 = constructor3;
                    f = fM383a;
                }
            }
            m388a(c0421a, constructor2);
            constructor = constructor2;
        }
        if (constructor != null) {
            return constructor;
        }
        throw new NoSuchMethodError("<init>" + str + " in class " + cls.getName());
    }

    protected static Field getFieldID(Class cls, String str, String str2, boolean z) {
        Field field;
        Class superclass = cls;
        C0421a c0421a = new C0421a(superclass, str, str2);
        if (m389a(c0421a)) {
            field = (Field) c0421a.f481a;
        } else {
            Class[] clsArrM390a = m390a(str2);
            float f = 0.0f;
            Field field2 = null;
            while (superclass != null) {
                Field[] declaredFields = superclass.getDeclaredFields();
                int length = declaredFields.length;
                Field field3 = field2;
                float f2 = f;
                int i = 0;
                while (true) {
                    if (i >= length) {
                        f = f2;
                        field2 = field3;
                        break;
                    }
                    Field field4 = declaredFields[i];
                    if (z == Modifier.isStatic(field4.getModifiers()) && field4.getName().compareTo(str) == 0) {
                        float fM383a = m383a(field4.getType(), (Class[]) null, clsArrM390a);
                        if (fM383a > f2) {
                            if (fM383a == 1.0f) {
                                field2 = field4;
                                f = fM383a;
                                break;
                            }
                            field3 = field4;
                            f2 = fM383a;
                        } else {
                            continue;
                        }
                    }
                    i++;
                }
                if (f == 1.0f || superclass.isPrimitive() || superclass.isInterface() || superclass.equals(Object.class) || superclass.equals(Void.TYPE)) {
                    break;
                }
                superclass = superclass.getSuperclass();
            }
            m388a(c0421a, field2);
            field = field2;
        }
        if (field != null) {
            return field;
        }
        Object[] objArr = new Object[4];
        objArr[0] = z ? "static" : "non-static";
        objArr[1] = str;
        objArr[2] = str2;
        objArr[3] = superclass.getName();
        throw new NoSuchFieldError(String.format("no %s field with name='%s' signature='%s' in class L%s;", objArr));
    }

    protected static Method getMethodID(Class cls, String str, String str2, boolean z) {
        Method method;
        C0421a c0421a = new C0421a(cls, str, str2);
        if (m389a(c0421a)) {
            method = (Method) c0421a.f481a;
        } else {
            Class[] clsArrM390a = m390a(str2);
            float f = 0.0f;
            Method method2 = null;
            while (cls != null) {
                Method[] declaredMethods = cls.getDeclaredMethods();
                int length = declaredMethods.length;
                Method method3 = method2;
                float f2 = f;
                int i = 0;
                while (true) {
                    if (i >= length) {
                        f = f2;
                        method2 = method3;
                        break;
                    }
                    Method method4 = declaredMethods[i];
                    if (z == Modifier.isStatic(method4.getModifiers()) && method4.getName().compareTo(str) == 0) {
                        float fM383a = m383a(method4.getReturnType(), method4.getParameterTypes(), clsArrM390a);
                        if (fM383a > f2) {
                            if (fM383a == 1.0f) {
                                method2 = method4;
                                f = fM383a;
                                break;
                            }
                            method3 = method4;
                            f2 = fM383a;
                        } else {
                            continue;
                        }
                    }
                    i++;
                }
                if (f == 1.0f || cls.isPrimitive() || cls.isInterface() || cls.equals(Object.class) || cls.equals(Void.TYPE)) {
                    break;
                }
                cls = cls.getSuperclass();
            }
            m388a(c0421a, method2);
            method = method2;
        }
        if (method != null) {
            return method;
        }
        Object[] objArr = new Object[4];
        objArr[0] = z ? "static" : "non-static";
        objArr[1] = str;
        objArr[2] = str2;
        objArr[3] = cls.getName();
        throw new NoSuchMethodError(String.format("no %s method with name='%s' signature='%s' in class L%s;", objArr));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static native void nativeProxyFinalize(int i);

    /* JADX INFO: Access modifiers changed from: private */
    public static native Object nativeProxyInvoke(int i, String str, Object[] objArr);

    /* JADX INFO: Access modifiers changed from: private */
    public static native void nativeProxyLogJNIInvokeException();

    protected static Object newProxyInstance(int i, Class cls) {
        return newProxyInstance(i, new Class[]{cls});
    }

    protected static Object newProxyInstance(final int i, final Class[] clsArr) {
        return Proxy.newProxyInstance(ReflectionHelper.class.getClassLoader(), clsArr, new InvocationHandler() { // from class: com.unity3d.player.ReflectionHelper.1

            /* JADX INFO: renamed from: c */
            private long f480c = ReflectionHelper.f477b;

            /* JADX INFO: renamed from: a */
            private static Object m392a(Object obj, Method method, Object[] objArr) throws NoSuchMethodException {
                if (objArr == null) {
                    try {
                        objArr = new Object[0];
                    } catch (NoClassDefFoundError unused) {
                        C0458g.Log(6, String.format("Java interface default methods are only supported since Android Oreo", new Object[0]));
                        ReflectionHelper.nativeProxyLogJNIInvokeException();
                        return null;
                    }
                }
                Class<?> declaringClass = method.getDeclaringClass();
                Constructor declaredConstructor = MethodHandles.Lookup.class.getDeclaredConstructor(Class.class, Integer.TYPE);
                declaredConstructor.setAccessible(true);
                return ((MethodHandles.Lookup) declaredConstructor.newInstance(declaringClass, 2)).in(declaringClass).unreflectSpecial(method, declaringClass).bindTo(obj).invokeWithArguments(objArr);
            }

            protected final void finalize() throws Throwable {
                try {
                    if (this.f480c == ReflectionHelper.f477b) {
                        ReflectionHelper.nativeProxyFinalize(i);
                    }
                } finally {
                    super.finalize();
                }
            }

            @Override // java.lang.reflect.InvocationHandler
            public final Object invoke(Object obj, Method method, Object[] objArr) {
                if (this.f480c != ReflectionHelper.f477b) {
                    C0458g.Log(6, "Scripting proxy object was destroyed, because Unity player was unloaded.");
                    return null;
                }
                Object objNativeProxyInvoke = ReflectionHelper.nativeProxyInvoke(i, method.getName(), objArr);
                if (objNativeProxyInvoke == null) {
                    if ((method.getModifiers() & 1024) == 0) {
                        return m392a(obj, method, objArr);
                    }
                    ReflectionHelper.nativeProxyLogJNIInvokeException();
                }
                return objNativeProxyInvoke;
            }
        });
    }
}

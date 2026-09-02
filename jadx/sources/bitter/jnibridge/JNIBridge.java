package bitter.jnibridge;

import java.lang.invoke.MethodHandles;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/* JADX INFO: loaded from: classes.dex */
public class JNIBridge {

    /* JADX INFO: renamed from: bitter.jnibridge.JNIBridge$a */
    private static class C0192a implements InvocationHandler {

        /* JADX INFO: renamed from: a */
        private Object f10a = new Object[0];

        /* JADX INFO: renamed from: b */
        private long f11b;

        /* JADX INFO: renamed from: c */
        private Constructor f12c;

        public C0192a(long j) {
            this.f11b = j;
            try {
                this.f12c = MethodHandles.Lookup.class.getDeclaredConstructor(Class.class, Integer.TYPE);
                this.f12c.setAccessible(true);
            } catch (NoClassDefFoundError unused) {
                this.f12c = null;
            } catch (NoSuchMethodException unused2) {
                this.f12c = null;
            }
        }

        /* JADX INFO: renamed from: a */
        private Object m8a(Object obj, Method method, Object[] objArr) {
            if (objArr == null) {
                objArr = new Object[0];
            }
            Class<?> declaringClass = method.getDeclaringClass();
            return ((MethodHandles.Lookup) this.f12c.newInstance(declaringClass, 2)).in(declaringClass).unreflectSpecial(method, declaringClass).bindTo(obj).invokeWithArguments(objArr);
        }

        /* JADX INFO: renamed from: a */
        public final void m9a() {
            synchronized (this.f10a) {
                this.f11b = 0L;
            }
        }

        public final void finalize() {
            synchronized (this.f10a) {
                if (this.f11b == 0) {
                    return;
                }
                JNIBridge.delete(this.f11b);
            }
        }

        @Override // java.lang.reflect.InvocationHandler
        public final Object invoke(Object obj, Method method, Object[] objArr) {
            synchronized (this.f10a) {
                if (this.f11b == 0) {
                    return null;
                }
                try {
                    return JNIBridge.invoke(this.f11b, method.getDeclaringClass(), method, objArr);
                } catch (NoSuchMethodError e) {
                    if (this.f12c == null) {
                        System.err.println("JNIBridge error: Java interface default methods are only supported since Android Oreo");
                        throw e;
                    }
                    if ((method.getModifiers() & 1024) == 0) {
                        return m8a(obj, method, objArr);
                    }
                    throw e;
                }
            }
        }
    }

    static native void delete(long j);

    static void disableInterfaceProxy(Object obj) {
        if (obj != null) {
            ((C0192a) Proxy.getInvocationHandler(obj)).m9a();
        }
    }

    static native Object invoke(long j, Class cls, Method method, Object[] objArr);

    static Object newInterfaceProxy(long j, Class[] clsArr) {
        return Proxy.newProxyInstance(JNIBridge.class.getClassLoader(), clsArr, new C0192a(j));
    }
}

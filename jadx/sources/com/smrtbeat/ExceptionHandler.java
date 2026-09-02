package com.smrtbeat;

import android.content.Context;
import android.os.SystemClock;
import java.io.File;
import java.util.Collections;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class ExceptionHandler implements Thread.UncaughtExceptionHandler {

    /* JADX INFO: renamed from: a */
    private Thread.UncaughtExceptionHandler f20a;

    /* JADX INFO: renamed from: com.smrtbeat.ExceptionHandler$a */
    class RunnableC0358a implements Runnable {

        /* JADX INFO: renamed from: a */
        final /* synthetic */ JSONObject f21a;

        /* JADX INFO: renamed from: b */
        final /* synthetic */ File f22b;

        /* JADX INFO: renamed from: c */
        final /* synthetic */ File f23c;

        RunnableC0358a(JSONObject jSONObject, File file, File file2) {
            this.f21a = jSONObject;
            this.f22b = file;
            this.f23c = file2;
        }

        @Override // java.lang.Runnable
        public void run() {
            long jElapsedRealtime = SystemClock.elapsedRealtime();
            if (C0383k.m231a(this.f21a, 5000L)) {
                C0383k.m236b(this.f22b);
                if (this.f23c == null) {
                    C0383k.m253h();
                }
            }
            long jElapsedRealtime2 = SystemClock.elapsedRealtime() - jElapsedRealtime;
            File file = this.f23c;
            if (file == null || 5000 <= jElapsedRealtime2 || C0383k.m219a(file, 5000 - jElapsedRealtime2).m94a(this.f23c.getName()) != C0369b0.a.OK) {
                return;
            }
            C0383k.m236b(this.f23c);
            C0383k.m253h();
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.ExceptionHandler$b */
    static class RunnableC0359b implements Runnable {

        /* JADX INFO: renamed from: a */
        JSONObject f25a;

        RunnableC0359b() {
        }

        /* JADX INFO: renamed from: a */
        Runnable m48a(JSONObject jSONObject) {
            this.f25a = jSONObject;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            C0383k.m237b(this.f25a);
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.ExceptionHandler$c */
    static class RunnableC0360c implements Runnable {

        /* JADX INFO: renamed from: a */
        final /* synthetic */ JSONObject f26a;

        /* JADX INFO: renamed from: b */
        final /* synthetic */ File f27b;

        RunnableC0360c(JSONObject jSONObject, File file) {
            this.f26a = jSONObject;
            this.f27b = file;
        }

        @Override // java.lang.Runnable
        public void run() {
            C0383k.m237b(this.f26a);
            File file = this.f27b;
            if (file == null || C0383k.m219a(file, 0L).m94a(this.f27b.getName()) != C0369b0.a.OK) {
                return;
            }
            this.f27b.delete();
        }
    }

    ExceptionHandler(Thread.UncaughtExceptionHandler uncaughtExceptionHandler) {
        this.f20a = uncaughtExceptionHandler;
    }

    /* JADX INFO: renamed from: a */
    static void m46a(Context context, String str, String str2, String str3, Map<String, Object> map, EnumC0381i enumC0381i, String str4, boolean z) {
        if (context == null) {
            context = C0382j.m217a();
        }
        Context context2 = context;
        if (C0377f0.m199k()) {
            try {
                JSONObject jSONObjectM293a = C0387o.m293a(context2, str, str2, str3, map, enumC0381i, str4);
                if (jSONObjectM293a == null) {
                    return;
                }
                Thread thread = new Thread(new RunnableC0360c(jSONObjectM293a, z ? C0377f0.m170b(str4) : null));
                thread.setPriority(2);
                thread.start();
            } catch (Exception e) {
                C0377f0.m159a(C0377f0.e.ERROR, e.toString());
            }
        }
        EnumC0374e enumC0374e = EnumC0374e.BC2_TYPE_ERROR_BREADCRUMB;
        if (str == null || str.length() <= 0) {
            str = str2;
        }
        C0377f0.m158a(new C0372d(enumC0374e, str, Collections.singletonMap("message", str2)));
    }

    /* JADX INFO: renamed from: a */
    static void m47a(Context context, Throwable th) {
        if (th == null) {
            C0377f0.m159a(C0377f0.e.WARN, "Throwable should not be null when calling logHandledException()");
        } else if (C0377f0.m199k()) {
            new Thread(new RunnableC0359b().m48a(C0387o.m294a(context, th, true))).start();
            C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_ERROR_BREADCRUMB, th.getClass().getName(), Collections.singletonMap("message", th.getMessage())));
        }
    }

    @Override // java.lang.Thread.UncaughtExceptionHandler
    public void uncaughtException(Thread thread, Throwable th) {
        C0366a.m72c();
        Context contextM217a = C0382j.m217a();
        C0382j.f226d0 = true;
        if (C0377f0.m199k()) {
            try {
                JSONObject jSONObjectM294a = C0387o.m294a(contextM217a, th, false);
                new Thread(new RunnableC0358a(jSONObjectM294a, C0383k.m248e(jSONObjectM294a), C0377f0.m205q())).start();
            } catch (Exception e) {
                C0377f0.m159a(C0377f0.e.ERROR, e.toString());
            }
        }
        Thread.UncaughtExceptionHandler uncaughtExceptionHandler = this.f20a;
        if (uncaughtExceptionHandler != null) {
            uncaughtExceptionHandler.uncaughtException(thread, th);
        }
        try {
            Thread.sleep(5000L);
        } catch (InterruptedException unused) {
        }
    }
}

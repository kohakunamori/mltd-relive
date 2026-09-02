package com.smrtbeat;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.SystemClock;
import com.adjust.sdk.Constants;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Formatter;
import java.util.Random;
import java.util.concurrent.locks.ReentrantLock;
import java.util.zip.GZIPOutputStream;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: renamed from: com.smrtbeat.k */
/* JADX INFO: loaded from: classes.dex */
class C0383k {

    /* JADX INFO: renamed from: a */
    private static final String f258a = "%1$s-%2$s";

    /* JADX INFO: renamed from: b */
    private static final String f259b = "%3$s";

    /* JADX INFO: renamed from: c */
    private static final String f260c = ".dat";

    /* JADX INFO: renamed from: d */
    private static final String f261d = ".id";

    /* JADX INFO: renamed from: e */
    private static final Object f262e = new Object();

    /* JADX INFO: renamed from: f */
    private static final ReentrantLock f263f = new ReentrantLock();

    /* JADX INFO: renamed from: g */
    private static final ReentrantLock f264g = new ReentrantLock();

    /* JADX INFO: renamed from: h */
    private static boolean f265h = false;

    /* JADX INFO: renamed from: i */
    private static boolean f266i = false;

    /* JADX INFO: renamed from: j */
    private static final ReentrantLock f267j = new ReentrantLock();

    /* JADX INFO: renamed from: k */
    private static final long f268k = 3600000;

    /* JADX INFO: renamed from: com.smrtbeat.k$a */
    static /* synthetic */ class a {

        /* JADX INFO: renamed from: a */
        static final /* synthetic */ int[] f269a;

        static {
            int[] iArr = new int[C0369b0.a.values().length];
            f269a = iArr;
            try {
                iArr[C0369b0.a.OK.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f269a[C0369b0.a.FAILED_BY_DATA.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                f269a[C0369b0.a.FAILED_BY_SERVER.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
            try {
                f269a[C0369b0.a.FAILED_BY_OTHER.ordinal()] = 4;
            } catch (NoSuchFieldError unused4) {
            }
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.k$b */
    static class b implements Runnable {

        /* JADX INFO: renamed from: a */
        private SharedPreferences f270a;

        b() {
        }

        /* JADX INFO: renamed from: a */
        Runnable m265a(SharedPreferences sharedPreferences) {
            this.f270a = sharedPreferences;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            if (C0383k.m239b(this.f270a) && C0383k.f263f.tryLock()) {
                try {
                    if (C0383k.m239b(this.f270a)) {
                        JSONObject jSONObjectM288a = C0387o.m288a();
                        C0377f0.m159a(C0377f0.e.INFO, "SendPingData");
                        if (C0383k.m234b(jSONObjectM288a, false).m93a() == C0369b0.a.OK) {
                            SharedPreferences.Editor editorEdit = this.f270a.edit();
                            C0377f0.m180c(editorEdit);
                            C0377f0.m156a(editorEdit);
                        }
                    }
                } finally {
                    C0383k.f263f.unlock();
                }
            }
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.k$c */
    static class c implements Runnable {
        c() {
        }

        @Override // java.lang.Runnable
        public void run() {
            boolean zM241b;
            boolean z = C0382j.f230f0;
            Context contextM217a = C0382j.m217a();
            if (contextM217a != null) {
                SharedPreferences sharedPreferencesM188f = C0377f0.m188f(contextM217a);
                SharedPreferences.Editor editorEdit = sharedPreferencesM188f.edit();
                try {
                    boolean z2 = false;
                    C0369b0 c0369b0M233b = C0383k.m233b("https://control.smbeat.jp/api/remote", C0387o.m302b(), false);
                    if (!C0383k.m240b(c0369b0M233b.f76b) || contextM217a == null) {
                        zM241b = false;
                    } else {
                        JSONObject jSONObject = new JSONObject(c0369b0M233b.f76b);
                        if (jSONObject.has("suppressSdk")) {
                            zM241b = C0383k.m241b(jSONObject, "suppressSdk", false);
                            C0377f0.m175b(editorEdit, zM241b);
                        } else {
                            zM241b = false;
                        }
                        if (jSONObject.has("suppressCap")) {
                            C0377f0.m157a(editorEdit, C0383k.m241b(jSONObject, "suppressCap", false));
                        }
                        z2 = true;
                    }
                    C0377f0.m183d(editorEdit);
                    if (z2) {
                        if (zM241b != z) {
                            C0377f0.m174b(editorEdit);
                        } else if (zM241b) {
                            C0377f0.m184d(sharedPreferencesM188f);
                        }
                    }
                } catch (Exception unused) {
                    C0377f0.m183d(editorEdit);
                } catch (Throwable th) {
                    C0377f0.m183d(editorEdit);
                    C0377f0.m156a(editorEdit);
                    C0382j.f234h0 = null;
                    throw th;
                }
                C0377f0.m156a(editorEdit);
            }
            C0382j.f234h0 = null;
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.k$d */
    static class d implements InterfaceRunnableC0371c0 {

        /* JADX INFO: renamed from: a */
        C0369b0 f271a = null;

        /* JADX INFO: renamed from: b */
        JSONObject f272b = null;

        d() {
        }

        @Override // com.smrtbeat.InterfaceRunnableC0371c0
        /* JADX INFO: renamed from: a */
        public C0369b0 mo129a() {
            return this.f271a;
        }

        /* JADX INFO: renamed from: a */
        InterfaceRunnableC0371c0 m266a(JSONObject jSONObject) {
            this.f272b = jSONObject;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            this.f271a = C0383k.m234b(this.f272b, true);
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.k$e */
    static class e implements InterfaceRunnableC0371c0 {

        /* JADX INFO: renamed from: a */
        C0369b0 f273a = null;

        /* JADX INFO: renamed from: b */
        File f274b = null;

        /* JADX INFO: renamed from: c */
        File f275c = null;

        e() {
        }

        @Override // com.smrtbeat.InterfaceRunnableC0371c0
        /* JADX INFO: renamed from: a */
        public C0369b0 mo129a() {
            return this.f273a;
        }

        /* JADX INFO: renamed from: a */
        InterfaceRunnableC0371c0 m267a(File file, File file2) {
            this.f274b = file;
            this.f275c = file2;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            try {
                ArrayList arrayList = new ArrayList(2);
                arrayList.add(new C0386n.a("errors", "json.txt", this.f274b));
                arrayList.add(new C0386n.a("minidump", this.f275c.getName(), this.f275c));
                this.f273a = new C0386n("https://minidumps.smbeat.jp/api/errors/multi", arrayList).m284a(2000, true);
            } catch (Exception unused) {
            }
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.k$f */
    static class f implements Runnable {

        /* JADX INFO: renamed from: a */
        String f276a;

        /* JADX INFO: renamed from: b */
        JSONObject f277b;

        f() {
        }

        /* JADX INFO: renamed from: a */
        Runnable m268a(String str, JSONObject jSONObject) {
            this.f276a = str;
            this.f277b = jSONObject;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            C0383k.m242c(this.f277b, this.f276a);
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.k$g */
    static class g implements Runnable {
        g() {
        }

        @Override // java.lang.Runnable
        public void run() {
            C0383k.m259n();
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.k$h */
    static class h implements InterfaceRunnableC0371c0 {

        /* JADX INFO: renamed from: a */
        C0369b0 f278a = null;

        /* JADX INFO: renamed from: b */
        File f279b = null;

        h() {
        }

        @Override // com.smrtbeat.InterfaceRunnableC0371c0
        /* JADX INFO: renamed from: a */
        public C0369b0 mo129a() {
            return this.f278a;
        }

        /* JADX INFO: renamed from: a */
        InterfaceRunnableC0371c0 m269a(File file) {
            this.f279b = file;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            ArrayList arrayList = new ArrayList(1);
            arrayList.add(new C0386n.a("screenshot", this.f279b.getName(), this.f279b));
            this.f278a = new C0386n("https://images.smbeat.jp/api/upload", arrayList).m284a(10000, false);
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.k$i */
    static class i implements FileFilter {
        i() {
        }

        @Override // java.io.FileFilter
        public boolean accept(File file) {
            return file.getName().endsWith(C0383k.f261d);
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.k$j */
    static class j implements Runnable {
        j() {
        }

        @Override // java.lang.Runnable
        public void run() {
            if (C0383k.f264g.tryLock()) {
                try {
                    C0383k.m262q();
                } finally {
                    C0383k.f264g.unlock();
                }
            }
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.k$k */
    private enum k {
        Start("/start", "", "", false),
        Crash("/crash", C0383k.f258a, C0383k.f260c, false),
        NativeCrash("/dump", "%3$s/%1$s-%2$s", C0383k.f260c, true),
        NativeCrashTmp("/dump_tmp", C0383k.f258a, C0383k.f260c, false),
        NativeCrashDump("/dump", "%3$s/%3$s", ".dmp", true),
        Exception("/exception", C0383k.f258a, C0383k.f260c, false),
        CrashId("", C0383k.f259b, C0383k.f261d, false),
        Capture("/capture", "", "", false),
        Abort("/abort", C0383k.f258a, C0383k.f260c, false),
        AbortFootprint("", "last_active", C0383k.f260c, false);


        /* JADX INFO: renamed from: a */
        private String f291a;

        /* JADX INFO: renamed from: b */
        private String f292b;

        /* JADX INFO: renamed from: c */
        private String f293c;

        /* JADX INFO: renamed from: d */
        private boolean f294d;

        /* JADX INFO: renamed from: com.smrtbeat.k$k$a */
        class a implements FileFilter {
            a() {
            }

            @Override // java.io.FileFilter
            public boolean accept(File file) {
                return file.isDirectory();
            }
        }

        /* JADX INFO: renamed from: com.smrtbeat.k$k$b */
        class b implements FilenameFilter {
            b() {
            }

            @Override // java.io.FilenameFilter
            public boolean accept(File file, String str) {
                return str.endsWith(k.this.f293c);
            }
        }

        k(String str, String str2, String str3, boolean z) {
            this.f291a = str;
            this.f292b = str2;
            this.f293c = str3;
            this.f294d = z;
        }

        /* JADX INFO: renamed from: a */
        int m271a() {
            File file = new File(m273c());
            if (this.f294d) {
                File[] fileArrListFiles = file.listFiles(new a());
                if (fileArrListFiles != null) {
                    return fileArrListFiles.length;
                }
            } else {
                String[] list = file.list(new b());
                if (list != null) {
                    return list.length;
                }
            }
            return 0;
        }

        /* JADX INFO: renamed from: b */
        String m272b() {
            return m273c() + new Formatter().format(this.f292b, String.valueOf(System.currentTimeMillis()), String.valueOf(new Random(System.currentTimeMillis()).nextInt()), C0382j.f196D) + this.f293c;
        }

        /* JADX INFO: renamed from: c */
        String m273c() {
            return C0382j.f195C + this.f291a + "/";
        }
    }

    C0383k() {
    }

    /* JADX INFO: renamed from: a */
    static C0369b0 m219a(File file, long j2) {
        if (file == null || !file.exists()) {
            return new C0369b0();
        }
        return !C0377f0.m195i() ? new C0369b0() : C0375e0.m145a(new h().m269a(file), j2);
    }

    /* JADX INFO: renamed from: a */
    private static void m224a(k kVar) {
        File[] fileArrListFiles = new File(kVar.m273c()).listFiles();
        if (fileArrListFiles == null) {
            return;
        }
        for (File file : fileArrListFiles) {
            if (file != null && file.isFile()) {
                String strM243c = m243c(file);
                if (strM243c.length() > 0) {
                    try {
                        int i2 = a.f269a[m234b(new JSONObject(strM243c), true).m93a().ordinal()];
                        if (i2 == 1) {
                            file.delete();
                        } else if (i2 == 2 || i2 == 3) {
                            m228a(file);
                        }
                    } catch (JSONException unused) {
                    }
                }
            }
        }
    }

    /* JADX INFO: renamed from: a */
    static void m225a(JSONObject jSONObject) {
        m245c(jSONObject);
    }

    /* JADX INFO: renamed from: a */
    static void m226a(JSONObject jSONObject, File file, long j2) {
        File file2;
        boolean zM255j = m255j();
        if (zM255j) {
            file2 = new File(k.NativeCrashTmp.m272b());
        } else {
            m259n();
            file2 = new File(k.NativeCrash.m272b());
            File file3 = new File(k.NativeCrashDump.m272b());
            file2.getParentFile().mkdirs();
            file.renameTo(file3);
            file = file3;
        }
        m242c(jSONObject, file2.getAbsolutePath());
        if ((C0375e0.m145a(new e().m267a(file2, file), j2).m93a() == C0369b0.a.OK) || zM255j) {
            file.delete();
            file2.delete();
        }
    }

    /* JADX INFO: renamed from: a */
    private static boolean m228a(File file) {
        int iIntValue;
        String name = file.getName();
        int iLastIndexOf = name.lastIndexOf(".");
        int iLastIndexOf2 = name.lastIndexOf(".", iLastIndexOf - 1);
        if (iLastIndexOf < 0 || iLastIndexOf2 < 0) {
            iIntValue = 0;
        } else {
            try {
                iIntValue = Integer.valueOf(name.substring(iLastIndexOf2 + 1, iLastIndexOf)).intValue();
            } catch (NumberFormatException unused) {
                iIntValue = 0;
            }
        }
        int i2 = iIntValue + 1;
        if (i2 >= 3) {
            file.delete();
            return true;
        }
        if (iLastIndexOf >= 0) {
            if (iLastIndexOf2 < 0) {
                iLastIndexOf2 = iLastIndexOf;
            }
            file.renameTo(new File((file.getParent() + File.separator) + name.substring(0, iLastIndexOf2 + 1) + String.valueOf(i2) + name.substring(iLastIndexOf)));
        }
        return false;
    }

    /* JADX INFO: renamed from: a */
    private static boolean m229a(File file, File[] fileArr) {
        if (fileArr == null) {
            return false;
        }
        String str = file.getName() + f261d;
        for (File file2 : fileArr) {
            if (file2.getName().contentEquals(str)) {
                return true;
            }
        }
        return false;
    }

    /* JADX INFO: renamed from: a */
    static boolean m231a(JSONObject jSONObject, long j2) {
        C0377f0.m159a(C0377f0.e.INFO, "SendCrashEvent");
        return C0375e0.m145a(new d().m266a(jSONObject), j2).m93a() == C0369b0.a.OK;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Code duplicated, block: B:53:0x00c2 A[EXC_TOP_SPLITTER, PHI: r1
      0x00c2: PHI (r1v5 java.io.OutputStream) = (r1v4 java.io.OutputStream), (r1v10 java.io.OutputStream) binds: [B:43:0x00c0, B:34:0x0097] A[DONT_GENERATE, DONT_INLINE], SYNTHETIC] */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r5v12 */
    /* JADX WARN: Type inference failed for: r5v13 */
    /* JADX WARN: Type inference failed for: r5v2 */
    /* JADX WARN: Type inference failed for: r5v5, types: [java.net.HttpURLConnection] */
    /* JADX INFO: renamed from: b */
    public static C0369b0 m233b(String str, JSONObject jSONObject, boolean z) throws Throwable {
        Throwable th;
        ?? r5;
        Exception e2;
        HttpURLConnection httpURLConnection;
        C0369b0 c0369b0 = new C0369b0();
        if (C0382j.f242o.length() <= 0) {
            C0377f0.m159a(C0377f0.e.ERROR, "Data cannot send due to invalid api key.");
            return c0369b0;
        }
        OutputStream gZIPOutputStream = null;
        try {
            try {
                HttpURLConnection httpURLConnection2 = (HttpURLConnection) new URL(str).openConnection();
                try {
                    httpURLConnection2.setReadTimeout(20000);
                    httpURLConnection2.setConnectTimeout(20000);
                    httpURLConnection2.addRequestProperty("X-SmartBeat-Api-Key", C0382j.f242o);
                    httpURLConnection2.addRequestProperty("X-SmartBeat-Device-Time", String.valueOf(System.currentTimeMillis()));
                    httpURLConnection2.setRequestProperty("Content-Type", "application/json");
                    if (z) {
                        httpURLConnection2.setRequestProperty("Content-Encoding", "gzip");
                    }
                    httpURLConnection2.setDoOutput(true);
                    httpURLConnection2.setChunkedStreamingMode(0);
                    OutputStream outputStream = httpURLConnection2.getOutputStream();
                    if (z) {
                        try {
                            gZIPOutputStream = new GZIPOutputStream(outputStream);
                        } catch (Exception e3) {
                            e2 = e3;
                            gZIPOutputStream = outputStream;
                            httpURLConnection = httpURLConnection2;
                            C0377f0.m159a(C0377f0.e.DEBUG, "failed to send data" + e2.toString());
                            if (httpURLConnection != null) {
                                httpURLConnection.disconnect();
                            }
                            if (gZIPOutputStream != null) {
                                try {
                                    gZIPOutputStream.close();
                                } catch (IOException unused) {
                                }
                            }
                        } catch (Throwable th2) {
                            th = th2;
                            gZIPOutputStream = outputStream;
                            r5 = httpURLConnection2;
                            if (r5 != 0) {
                                r5.disconnect();
                            }
                            if (gZIPOutputStream != null) {
                                try {
                                    gZIPOutputStream.close();
                                } catch (IOException unused2) {
                                }
                            }
                            throw th;
                        }
                    } else {
                        gZIPOutputStream = outputStream;
                    }
                    gZIPOutputStream.write(jSONObject.toString().getBytes(Constants.ENCODING));
                    gZIPOutputStream.flush();
                    gZIPOutputStream.close();
                    int responseCode = httpURLConnection2.getResponseCode();
                    c0369b0.f75a = responseCode;
                    if (responseCode == 200) {
                        c0369b0.f76b = C0377f0.m151a(httpURLConnection2);
                    }
                    if (httpURLConnection2 != null) {
                        httpURLConnection2.disconnect();
                    }
                    if (gZIPOutputStream != null) {
                        gZIPOutputStream.close();
                    }
                } catch (Exception e4) {
                    e2 = e4;
                    httpURLConnection = httpURLConnection2;
                }
            } catch (Throwable th3) {
                th = th3;
                r5 = str;
            }
        } catch (Exception e5) {
            e2 = e5;
            httpURLConnection = null;
        } catch (Throwable th4) {
            th = th4;
            r5 = 0;
        }
        return c0369b0;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: b */
    public static C0369b0 m234b(JSONObject jSONObject, boolean z) {
        return m233b("https://api.smbeat.jp/api/errors", jSONObject, z);
    }

    /* JADX INFO: renamed from: b */
    public static void m236b(File file) {
        if (file == null) {
            return;
        }
        File[] fileArrListFiles = file.listFiles();
        if (fileArrListFiles != null) {
            for (File file2 : fileArrListFiles) {
                m236b(file2);
            }
        }
        file.delete();
    }

    /* JADX INFO: renamed from: b */
    static void m237b(JSONObject jSONObject) {
        if (m234b(jSONObject, true).m93a() != C0369b0.a.OK) {
            m251f(jSONObject);
        }
    }

    /* JADX INFO: renamed from: b */
    private static void m238b(JSONObject jSONObject, String str) {
        new Thread(new f().m268a(str, jSONObject)).start();
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: b */
    public static boolean m239b(SharedPreferences sharedPreferences) {
        if (!C0377f0.m197j()) {
            return false;
        }
        long jM146a = C0377f0.m146a(sharedPreferences);
        long jElapsedRealtime = SystemClock.elapsedRealtime();
        return jM146a == 0 || jElapsedRealtime - jM146a > 21600000 || jM146a > jElapsedRealtime;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: b */
    public static boolean m240b(String str) {
        try {
            return "OK".equals(new JSONObject(str).get("status"));
        } catch (Exception unused) {
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: b */
    public static boolean m241b(JSONObject jSONObject, String str, boolean z) {
        try {
            if ("true".equalsIgnoreCase(jSONObject.getString(str))) {
                return true;
            }
            return z;
        } catch (JSONException unused) {
            return z;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: c */
    public static File m242c(JSONObject jSONObject, String str) {
        File file = new File(str);
        file.getParentFile().mkdirs();
        try {
            file.createNewFile();
            BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(file), 8192);
            bufferedWriter.write(jSONObject.toString());
            bufferedWriter.flush();
            bufferedWriter.close();
        } catch (IOException unused) {
        }
        return file;
    }

    /* JADX INFO: renamed from: c */
    private static String m243c(File file) {
        BufferedReader bufferedReader;
        try {
            bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(file)), 8192);
            try {
                StringBuffer stringBuffer = new StringBuffer();
                while (true) {
                    String line = bufferedReader.readLine();
                    if (line == null) {
                        break;
                    }
                    stringBuffer.append(line);
                }
                String string = stringBuffer.toString();
                try {
                    bufferedReader.close();
                } catch (IOException unused) {
                }
                return string;
            } catch (Throwable unused2) {
                if (bufferedReader == null) {
                    return "";
                }
                try {
                    bufferedReader.close();
                    return "";
                } catch (IOException unused3) {
                    return "";
                }
            }
        } catch (Throwable unused4) {
            bufferedReader = null;
        }
    }

    /* JADX INFO: renamed from: c */
    private static void m245c(JSONObject jSONObject) {
        k kVar = k.Abort;
        if (kVar.m271a() >= C0382j.f212T) {
            C0377f0.m159a(C0377f0.e.INFO, "Dropped Abort due to Event full");
        } else {
            m242c(jSONObject, kVar.m272b());
        }
    }

    /* JADX INFO: renamed from: d */
    static void m247d(JSONObject jSONObject) {
        synchronized (f262e) {
            m242c(jSONObject, k.AbortFootprint.m272b());
        }
    }

    /* JADX INFO: renamed from: e */
    static File m248e(JSONObject jSONObject) {
        if (m255j()) {
            C0377f0.m159a(C0377f0.e.INFO, "Dropped CrashData due to Event full");
            return null;
        }
        m259n();
        return m242c(jSONObject, k.Crash.m272b());
    }

    /* JADX INFO: renamed from: e */
    static void m249e() {
        if (C0382j.f234h0 == null && m263r()) {
            m264s();
        }
    }

    /* JADX INFO: renamed from: f */
    static void m250f() {
        synchronized (f262e) {
            new File(k.AbortFootprint.m272b()).delete();
        }
    }

    /* JADX INFO: renamed from: f */
    private static void m251f(JSONObject jSONObject) {
        k kVar = k.Exception;
        if (kVar.m271a() >= C0382j.f212T) {
            C0377f0.m159a(C0377f0.e.INFO, "Dropped ExceptionData due to Event full");
        } else {
            m238b(jSONObject, kVar.m272b());
        }
    }

    /* JADX INFO: renamed from: g */
    static void m252g() {
        File[] fileArrListFiles = new File(k.NativeCrashTmp.m273c()).listFiles();
        if (fileArrListFiles != null) {
            for (File file : fileArrListFiles) {
                m236b(file);
            }
        }
    }

    /* JADX INFO: renamed from: h */
    static void m253h() {
        m236b(new File(k.CrashId.m272b()));
    }

    /* JADX INFO: renamed from: i */
    static JSONObject m254i() {
        JSONObject jSONObject;
        synchronized (f262e) {
            String strM243c = m243c(new File(k.AbortFootprint.m272b()));
            if (strM243c.length() > 0) {
                try {
                    jSONObject = new JSONObject(strM243c);
                } catch (JSONException unused) {
                    jSONObject = null;
                }
            } else {
                jSONObject = null;
            }
        }
        return jSONObject;
    }

    /* JADX INFO: renamed from: j */
    private static boolean m255j() {
        return k.Crash.m271a() + k.NativeCrash.m271a() >= C0382j.f212T;
    }

    /* JADX INFO: renamed from: k */
    static void m256k() {
        if (C0382j.f210R) {
            try {
                ReentrantLock reentrantLock = f267j;
                reentrantLock.lock();
                if (!f265h) {
                    f266i = true;
                    reentrantLock.unlock();
                    return;
                }
                reentrantLock.unlock();
                Context contextM217a = C0382j.m217a();
                if (contextM217a == null) {
                    return;
                }
                SharedPreferences sharedPreferencesM188f = C0377f0.m188f(contextM217a);
                if (m239b(sharedPreferencesM188f)) {
                    new Thread(new b().m265a(sharedPreferencesM188f)).start();
                }
            } catch (Throwable th) {
                f267j.unlock();
                throw th;
            }
        }
    }

    /* JADX INFO: renamed from: l */
    static void m257l() {
        try {
            ReentrantLock reentrantLock = f267j;
            reentrantLock.lock();
            boolean z = f266i;
            f265h = true;
            reentrantLock.unlock();
            if (z) {
                m256k();
            }
        } catch (Throwable th) {
            f267j.unlock();
            throw th;
        }
    }

    /* JADX INFO: renamed from: m */
    private static void m258m() {
        new Thread(new g()).start();
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: n */
    public static void m259n() {
        k kVar = k.CrashId;
        if (kVar.m271a() >= C0382j.f212T) {
            C0377f0.m159a(C0377f0.e.INFO, "Dropped Captured Images due to Event full");
            return;
        }
        File file = new File(kVar.m272b());
        file.getParentFile().mkdirs();
        try {
            file.createNewFile();
        } catch (IOException unused) {
        }
    }

    /* JADX INFO: renamed from: o */
    private static void m260o() throws Throwable {
        File[] fileArrListFiles = new File(k.Abort.m273c()).listFiles();
        if (fileArrListFiles == null) {
            return;
        }
        for (File file : fileArrListFiles) {
            if (file != null && file.isFile()) {
                boolean z = true;
                try {
                    JSONObject jSONObject = new JSONObject(m243c(file));
                    if (!C0366a.m71b(jSONObject)) {
                        int i2 = a.f269a[m233b("https://abort-count.smbeat.jp/api/abort", jSONObject, false).m93a().ordinal()];
                        if (i2 != 1 && i2 != 2) {
                            z = false;
                        }
                    }
                } catch (JSONException unused) {
                }
                if (z) {
                    file.delete();
                }
            }
        }
    }

    /* JADX INFO: renamed from: p */
    static void m261p() {
        new Thread(new j()).start();
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Code duplicated, block: B:36:0x00dd  */
    /* JADX WARN: Code duplicated, block: B:64:0x0158  */
    /* JADX INFO: renamed from: q */
    public static void m262q() throws Throwable {
        boolean z;
        boolean zM228a;
        m236b(new File(k.Start.m273c()));
        if (C0377f0.m199k()) {
            m224a(k.Crash);
            m224a(k.Exception);
            m260o();
            File[] fileArrListFiles = new File(k.NativeCrash.m273c()).listFiles();
            if (fileArrListFiles != null) {
                for (File file : fileArrListFiles) {
                    File[] fileArrListFiles2 = file.listFiles();
                    if (fileArrListFiles2 == null) {
                        zM228a = true;
                    } else {
                        File file2 = null;
                        File file3 = null;
                        for (File file4 : fileArrListFiles2) {
                            if (file4.getName().endsWith(k.NativeCrashDump.f293c)) {
                                file2 = file4;
                            } else if (file4.getName().endsWith(k.NativeCrash.f293c)) {
                                file3 = file4;
                            }
                        }
                        if (file2 != null && file3 != null) {
                            try {
                                ArrayList arrayList = new ArrayList(2);
                                arrayList.add(new C0386n.a("errors", "json.txt", file3));
                                arrayList.add(new C0386n.a("minidump", C0377f0.m150a(file2), file2));
                                int i2 = a.f269a[new C0386n("https://minidumps.smbeat.jp/api/errors/multi", arrayList).m284a(2000, true).m93a().ordinal()];
                                if (i2 != 1) {
                                    zM228a = (i2 == 2 || i2 == 3) ? m228a(file2) : false;
                                } else {
                                    zM228a = true;
                                }
                            } catch (Exception e2) {
                                C0377f0.m159a(C0377f0.e.INFO, String.format("failed to send dump: %s", e2.toString()));
                            }
                        } else if (!file.getAbsolutePath().contains(C0382j.f196D)) {
                            zM228a = true;
                        }
                    }
                    if (zM228a) {
                        m236b(file);
                    }
                }
            }
            File[] fileArrListFiles3 = new File(C0382j.f195C).listFiles(new i());
            File[] fileArrListFiles4 = new File(k.Capture.m273c()).listFiles();
            if (fileArrListFiles4 != null) {
                for (File file5 : fileArrListFiles4) {
                    if (!file5.getName().equals(C0382j.f196D)) {
                        if (m229a(file5, fileArrListFiles3)) {
                            File[] fileArrListFiles5 = file5.listFiles();
                            if (fileArrListFiles5 != null) {
                                z = false;
                                for (File file6 : fileArrListFiles5) {
                                    int i3 = a.f269a[m219a(file6, 0L).m94a(file6.getName()).ordinal()];
                                    if (i3 == 1) {
                                        m236b(file6);
                                    } else if (i3 != 2 && i3 != 3) {
                                        z = true;
                                    } else if (!m228a(file6)) {
                                        z = true;
                                    }
                                }
                            } else {
                                z = false;
                            }
                            if (!z) {
                                m236b(new File(C0382j.f195C + "/" + file5.getName() + f261d));
                            }
                        }
                        m236b(file5);
                    }
                }
            }
            if (fileArrListFiles3 != null) {
                for (File file7 : fileArrListFiles3) {
                    String strSubstring = file7.getName().substring(0, file7.getName().lastIndexOf(46));
                    if (!strSubstring.equals(C0382j.f196D)) {
                        if (!new File(k.Capture.m273c() + strSubstring).exists()) {
                            m236b(file7);
                        }
                    }
                }
            }
        }
    }

    /* JADX INFO: renamed from: r */
    private static boolean m263r() {
        Context contextM217a = C0382j.m217a();
        if (contextM217a == null) {
            C0377f0.m159a(C0377f0.e.ERROR, "failed to check remote control due to context is null");
            return false;
        }
        SharedPreferences sharedPreferencesM188f = C0377f0.m188f(contextM217a);
        long jM169b = C0377f0.m169b(sharedPreferencesM188f);
        long jM176c = C0377f0.m176c(sharedPreferencesM188f);
        long jCurrentTimeMillis = System.currentTimeMillis();
        return (jCurrentTimeMillis > jM169b && jCurrentTimeMillis - jM176c > jM169b) || jCurrentTimeMillis < jM169b - f268k;
    }

    /* JADX INFO: renamed from: s */
    private static synchronized void m264s() {
        if (C0382j.f234h0 != null) {
            return;
        }
        Thread thread = new Thread(new c());
        C0382j.f234h0 = thread;
        thread.start();
    }
}

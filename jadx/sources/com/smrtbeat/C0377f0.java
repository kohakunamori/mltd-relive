package com.smrtbeat;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Application;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.os.Build;
import android.os.SystemClock;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.WindowManager;
import com.adjust.sdk.Constants;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.UUID;
import org.apache.commons.net.ftp.FTPReply;

/* JADX INFO: renamed from: com.smrtbeat.f0 */
/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"CommitPrefEdits"})
class C0377f0 {

    /* JADX INFO: renamed from: a */
    static final String f147a = "no permission";

    /* JADX INFO: renamed from: b */
    private static final String f148b = "unknown";

    /* JADX INFO: renamed from: c */
    private static final List<String> f149c = m203o();

    /* JADX INFO: renamed from: d */
    private static final String f150d = "com.smrtbeat.pref1";

    /* JADX INFO: renamed from: e */
    private static final String f151e = "com.smrtbeat.pref3";

    /* JADX INFO: renamed from: f */
    private static final String f152f = "com.smrtbeat.pref4";

    /* JADX INFO: renamed from: g */
    private static final String f153g = "com.smrtbeat.pref5";

    /* JADX INFO: renamed from: h */
    private static final String f154h = "com.smrtbeat.pref6";

    /* JADX INFO: renamed from: i */
    private static final long f155i = 86400000;

    /* JADX INFO: renamed from: com.smrtbeat.f0$a */
    static class a implements Runnable {

        /* JADX INFO: renamed from: a */
        final /* synthetic */ Context f156a;

        a(Context context) {
            this.f156a = context;
        }

        @Override // java.lang.Runnable
        public void run() {
            String str;
            try {
                String strM345a = C0377f0.m166a() ? C0391t.m345a(this.f156a) : null;
                if (strM345a == null) {
                    C0377f0.m173b(this.f156a);
                    return;
                }
                byte[] bArrM281b = C0385m.m281b(strM345a.getBytes());
                if (bArrM281b == null) {
                    C0377f0.m173b(this.f156a);
                    return;
                }
                String strM113b = C0370c.m113b(bArrM281b);
                if (strM113b == null) {
                    C0377f0.m173b(this.f156a);
                    return;
                }
                SharedPreferences.Editor editorEdit = this.f156a.getSharedPreferences("SmartBeat", 0).edit();
                String str2 = C0382j.f248u;
                if (str2 != null) {
                    if (!str2.equals(strM113b)) {
                        String string = UUID.randomUUID().toString();
                        C0382j.f247t = "android:" + string + ":" + C0382j.f246s;
                        C0382j.f248u = strM113b;
                        editorEdit.putString("uuid", string);
                        str = "idv2";
                    }
                }
                C0382j.f248u = strM113b;
                str = "idv2";
                editorEdit.putString(str, strM113b);
                C0377f0.m156a(editorEdit);
            } finally {
                C0383k.m257l();
            }
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.f0$b */
    static class b extends BroadcastReceiver {
        b() {
        }

        @Override // android.content.BroadcastReceiver
        public void onReceive(Context context, Intent intent) {
            HashMap map = new HashMap();
            if (intent.getExtras() != null) {
                for (String str : intent.getExtras().keySet()) {
                    if (intent.getExtras().get(str) != null) {
                        map.put(str, intent.getExtras().get(str).toString());
                    }
                }
            }
            C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_AUTO_BREADCRUMB, intent.getAction(), map));
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.f0$c */
    static class c implements Runnable {

        /* JADX INFO: renamed from: a */
        SharedPreferences.Editor f157a;

        c() {
        }

        /* JADX INFO: renamed from: a */
        Runnable m207a(SharedPreferences.Editor editor) {
            this.f157a = editor;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            this.f157a.commit();
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.f0$d */
    static /* synthetic */ class d {

        /* JADX INFO: renamed from: a */
        static final /* synthetic */ int[] f158a;

        /* JADX INFO: renamed from: b */
        static final /* synthetic */ int[] f159b;

        static {
            int[] iArr = new int[C0382j.a.values().length];
            f159b = iArr;
            try {
                iArr[C0382j.a.EGles.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f159b[C0382j.a.ENative.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            int[] iArr2 = new int[e.values().length];
            f158a = iArr2;
            try {
                iArr2[e.ERROR.ordinal()] = 1;
            } catch (NoSuchFieldError unused3) {
            }
            try {
                f158a[e.WARN.ordinal()] = 2;
            } catch (NoSuchFieldError unused4) {
            }
            try {
                f158a[e.INFO.ordinal()] = 3;
            } catch (NoSuchFieldError unused5) {
            }
            try {
                f158a[e.DEBUG.ordinal()] = 4;
            } catch (NoSuchFieldError unused6) {
            }
            try {
                f158a[e.VERBOSE.ordinal()] = 5;
            } catch (NoSuchFieldError unused7) {
            }
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.f0$e */
    enum e {
        ERROR,
        WARN,
        INFO,
        DEBUG,
        VERBOSE
    }

    C0377f0() {
    }

    /* JADX INFO: renamed from: a */
    static long m146a(SharedPreferences sharedPreferences) {
        return m147a(sharedPreferences, f154h, 0L);
    }

    /* JADX INFO: renamed from: a */
    private static long m147a(SharedPreferences sharedPreferences, String str, long j) {
        try {
            return sharedPreferences.getLong(str, j);
        } catch (Exception unused) {
            m156a(sharedPreferences.edit().remove(str));
            return j;
        }
    }

    /* JADX INFO: renamed from: a */
    static String m148a(int i) {
        if (Build.VERSION.SDK_INT >= 21) {
            String[] strArrM349a = C0394w.m349a();
            if (strArrM349a.length <= i) {
                return null;
            }
            return strArrM349a[i];
        }
        if (i == 0) {
            return C0367a0.m80a();
        }
        if (i != 1) {
            return null;
        }
        return C0367a0.m81b();
    }

    /* JADX INFO: renamed from: a */
    static String m149a(Context context, String str) {
        try {
            Class<?> clsLoadClass = context.getClassLoader().loadClass("android.os.SystemProperties");
            return (String) clsLoadClass.getMethod("get", String.class).invoke(clsLoadClass, new String(str));
        } catch (Exception unused) {
            return "unknown";
        }
    }

    /* JADX INFO: renamed from: a */
    static String m150a(File file) {
        String name = file.getName();
        int iLastIndexOf = name.lastIndexOf(".");
        int iLastIndexOf2 = name.lastIndexOf(".", iLastIndexOf - 1);
        if (iLastIndexOf < 0 || iLastIndexOf2 < 0) {
            return file.getName();
        }
        return name.substring(0, iLastIndexOf2) + name.substring(iLastIndexOf);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r7v0, types: [java.net.HttpURLConnection] */
    /* JADX WARN: Type inference failed for: r7v10, types: [java.io.InputStream] */
    /* JADX WARN: Type inference failed for: r7v18, types: [java.io.InputStream] */
    /* JADX WARN: Type inference failed for: r7v2 */
    /* JADX WARN: Type inference failed for: r7v4 */
    /* JADX WARN: Type inference failed for: r7v5, types: [java.io.InputStream] */
    /* JADX INFO: renamed from: a */
    static String m151a(HttpURLConnection httpURLConnection) throws Throwable {
        Throwable th;
        Exception e2;
        BufferedReader bufferedReader = null;
        try {
            httpURLConnection = httpURLConnection.getInputStream();
            try {
                BufferedReader bufferedReader2 = new BufferedReader(new InputStreamReader((InputStream) httpURLConnection, Constants.ENCODING), 1024);
                try {
                    StringBuilder sb = new StringBuilder();
                    while (true) {
                        String line = bufferedReader2.readLine();
                        if (line == null) {
                            break;
                        }
                        sb.append(line);
                        sb.append("\n");
                    }
                    String string = sb.toString();
                    try {
                        httpURLConnection.close();
                        bufferedReader2.close();
                    } catch (IOException e3) {
                        m159a(e.ERROR, String.format("readResponse :%s", e3.getMessage()));
                    }
                    return string;
                } catch (Exception e4) {
                    e2 = e4;
                    bufferedReader = bufferedReader2;
                    m159a(e.ERROR, String.format("readResponse :%s", e2.getMessage()));
                    try {
                        httpURLConnection.close();
                        if (bufferedReader == null) {
                            return "";
                        }
                        bufferedReader.close();
                        return "";
                    } catch (IOException e5) {
                        m159a(e.ERROR, String.format("readResponse :%s", e5.getMessage()));
                        return "";
                    }
                } catch (Throwable th2) {
                    th = th2;
                    bufferedReader = bufferedReader2;
                    try {
                        httpURLConnection.close();
                        if (bufferedReader != null) {
                            bufferedReader.close();
                        }
                    } catch (IOException e6) {
                        m159a(e.ERROR, String.format("readResponse :%s", e6.getMessage()));
                    }
                    throw th;
                }
            } catch (Exception e7) {
                e2 = e7;
            }
        } catch (Exception e8) {
            e2 = e8;
            httpURLConnection = 0;
        } catch (Throwable th3) {
            th = th3;
            httpURLConnection = 0;
        }
    }

    /* JADX INFO: renamed from: a */
    static void m152a(Activity activity) {
        m153a(activity, false);
    }

    /* JADX INFO: renamed from: a */
    private static synchronized void m153a(Activity activity, boolean z) {
        Thread thread;
        String name = activity.getClass().getName();
        if (z) {
            C0382j.f213U = name;
            m206r();
        } else if (C0382j.f213U.equals(name)) {
            C0382j.f213U = "";
        }
        if (m193h()) {
            if (C0382j.f207O == null || (thread = C0382j.f208P) == null || thread.getState() == Thread.State.TERMINATED) {
                C0382j.f207O = new RunnableC0378g();
                Thread thread2 = new Thread(C0382j.f207O);
                C0382j.f208P = thread2;
                thread2.start();
            }
            if (z) {
                C0382j.f207O.m210b(activity);
            } else {
                C0382j.f207O.m209a(activity);
            }
        }
    }

    /* JADX INFO: renamed from: a */
    static void m154a(Application application) {
        IntentFilter intentFilter = new IntentFilter();
        Iterator<String> it = f149c.iterator();
        while (it.hasNext()) {
            intentFilter.addAction(it.next());
        }
        application.getApplicationContext().registerReceiver(new b(), intentFilter);
    }

    /* JADX INFO: renamed from: a */
    static void m156a(SharedPreferences.Editor editor) {
        if (Build.VERSION.SDK_INT >= 9) {
            C0396y.m354a(editor);
            return;
        }
        Thread thread = new Thread(new c().m207a(editor));
        thread.start();
        try {
            thread.join(1000L);
        } catch (InterruptedException unused) {
        }
    }

    /* JADX INFO: renamed from: a */
    static void m157a(SharedPreferences.Editor editor, boolean z) {
        editor.putBoolean(f153g, z);
        C0382j.f232g0 = z;
    }

    /* JADX INFO: renamed from: a */
    static void m158a(C0372d c0372d) {
        if (c0372d == null || c0372d.m135e() == null || c0372d.m135e().length() == 0) {
            return;
        }
        List<C0372d> list = C0382j.f200H;
        synchronized (list) {
            if (list.size() >= 128) {
                list.remove(0);
            }
            list.add(c0372d);
        }
    }

    /* JADX INFO: renamed from: a */
    static void m159a(e eVar, String str) {
        C0389q c0389qM312a;
        StringBuilder sb;
        String str2;
        String str3 = C0382j.f202J;
        if (str3 == null || str3.length() <= 0) {
            return;
        }
        switch (d.f158a[eVar.ordinal()]) {
            case 1:
                Log.e(C0382j.f202J, str);
                c0389qM312a = C0389q.m312a();
                sb = new StringBuilder();
                str2 = "[E/";
                break;
            case 2:
                Log.w(C0382j.f202J, str);
                c0389qM312a = C0389q.m312a();
                sb = new StringBuilder();
                str2 = "[W/";
                break;
            case 3:
                Log.i(C0382j.f202J, str);
                c0389qM312a = C0389q.m312a();
                sb = new StringBuilder();
                str2 = "[I/";
                break;
            case 4:
                Log.d(C0382j.f202J, str);
                c0389qM312a = C0389q.m312a();
                sb = new StringBuilder();
                str2 = "[D/";
                break;
            case 5:
                Log.v(C0382j.f202J, str);
                c0389qM312a = C0389q.m312a();
                sb = new StringBuilder();
                str2 = "[V/";
                break;
            default:
                return;
        }
        sb.append(str2);
        sb.append(C0382j.f202J);
        sb.append("]");
        sb.append(str);
        c0389qM312a.m314a(sb.toString());
    }

    /* JADX INFO: renamed from: a */
    static void m160a(e eVar, String str, Throwable th) {
        C0389q c0389qM312a;
        StringBuilder sb;
        String str2;
        String str3 = C0382j.f202J;
        if (str3 == null || str3.length() <= 0) {
            return;
        }
        String stackTraceString = Log.getStackTraceString(th);
        switch (d.f158a[eVar.ordinal()]) {
            case 1:
                Log.e(C0382j.f202J, str, th);
                c0389qM312a = C0389q.m312a();
                sb = new StringBuilder();
                str2 = "[E/";
                break;
            case 2:
                Log.w(C0382j.f202J, str, th);
                c0389qM312a = C0389q.m312a();
                sb = new StringBuilder();
                str2 = "[W/";
                break;
            case 3:
                Log.i(C0382j.f202J, str, th);
                c0389qM312a = C0389q.m312a();
                sb = new StringBuilder();
                str2 = "[I/";
                break;
            case 4:
                Log.d(C0382j.f202J, str, th);
                c0389qM312a = C0389q.m312a();
                sb = new StringBuilder();
                str2 = "[D/";
                break;
            case 5:
                Log.v(C0382j.f202J, str, th);
                c0389qM312a = C0389q.m312a();
                sb = new StringBuilder();
                str2 = "[V/";
                break;
            default:
                return;
        }
        sb.append(str2);
        sb.append(C0382j.f202J);
        sb.append("]");
        sb.append(str);
        sb.append("\n");
        sb.append(stackTraceString);
        c0389qM312a.m314a(sb.toString());
    }

    /* JADX INFO: renamed from: a */
    static void m161a(C0382j.a aVar, Bitmap bitmap) {
        int i = d.f159b[aVar.ordinal()];
        if (i != 1) {
            if (i != 2 || C0382j.f214V == bitmap || bitmap == null) {
                return;
            }
        } else if (C0382j.f215W == bitmap || bitmap == null) {
            return;
        }
        bitmap.recycle();
    }

    /* JADX INFO: renamed from: a */
    static synchronized void m162a(C0382j.a aVar, Bitmap bitmap, long j) {
        e eVar;
        String str;
        if (C0382j.f226d0) {
            return;
        }
        if (bitmap != null && !bitmap.isRecycled()) {
            int i = d.f159b[aVar.ordinal()];
            if (i != 1) {
                if (i == 2) {
                    Bitmap bitmap2 = C0382j.f214V;
                    if (bitmap2 != bitmap) {
                        if (bitmap2 != null) {
                            bitmap2.recycle();
                        }
                        C0382j.f214V = bitmap;
                    }
                    C0382j.f216X = j;
                    eVar = e.DEBUG;
                    str = "save screen capture";
                }
                C0382j.f217Y = aVar;
            } else {
                Bitmap bitmap3 = C0382j.f215W;
                if (bitmap3 != bitmap) {
                    if (bitmap3 != null) {
                        bitmap3.recycle();
                    }
                    C0382j.f215W = bitmap;
                }
                C0382j.f216X = j;
                eVar = e.DEBUG;
                str = "save screen capture (gl)";
            }
            m159a(eVar, str);
            C0382j.f217Y = aVar;
        }
    }

    /* JADX INFO: renamed from: a */
    static void m163a(String str) {
        m158a(new C0372d(str));
    }

    /* JADX INFO: renamed from: a */
    static void m164a(String str, String str2) {
        C0382j.f201I.put(str, str2);
    }

    /* JADX INFO: renamed from: a */
    static void m165a(boolean z) {
        C0382j.f228e0 = z;
    }

    /* JADX INFO: renamed from: a */
    static boolean m166a() {
        try {
            Class.forName("com.google.android.gms.ads.identifier.AdvertisingIdClient");
            return true;
        } catch (ClassNotFoundException unused) {
            return false;
        }
    }

    /* JADX INFO: renamed from: a */
    private static boolean m167a(SharedPreferences sharedPreferences, String str, boolean z) {
        try {
            return sharedPreferences.getBoolean(str, z);
        } catch (Exception unused) {
            m156a(sharedPreferences.edit().remove(str));
            return z;
        }
    }

    /* JADX WARN: Code duplicated, block: B:101:0x0065 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:105:0x0060 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:119:? A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:61:0x008d  */
    /* JADX WARN: Code duplicated, block: B:81:0x0075 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:83:0x006a A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:85:0x0084 A[EXC_TOP_SPLITTER, PHI: r9
      0x0084: PHI (r9v6 java.io.FileOutputStream) = 
      (r9v4 java.io.FileOutputStream)
      (r9v5 java.io.FileOutputStream)
      (r9v10 java.io.FileOutputStream)
      (r9v10 java.io.FileOutputStream)
     binds: [B:48:0x006d, B:57:0x0082, B:65:0x0084, B:13:0x0028] A[DONT_GENERATE, DONT_INLINE], SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:89:0x007f A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:91:0x007a A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:93:0x0057 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:95:0x0052 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:97:0x004d A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:99:0x0048 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX INFO: renamed from: a */
    static boolean m168a(File file, File file2) throws Throwable {
        FileInputStream fileInputStream;
        FileChannel channel;
        FileOutputStream fileOutputStream;
        boolean zExists;
        FileChannel fileChannel = null;
        try {
            fileInputStream = new FileInputStream(file);
            try {
                channel = fileInputStream.getChannel();
                try {
                    fileOutputStream = new FileOutputStream(file2);
                    try {
                        FileChannel channel2 = fileOutputStream.getChannel();
                        try {
                            channel.transferTo(0L, channel.size(), channel2);
                            if (channel != null) {
                                try {
                                    channel.close();
                                } catch (IOException unused) {
                                }
                            }
                            if (channel2 != null) {
                                try {
                                    channel2.close();
                                } catch (IOException unused2) {
                                }
                            }
                            try {
                                fileInputStream.close();
                            } catch (IOException unused3) {
                            }
                        } catch (FileNotFoundException unused4) {
                            fileChannel = channel2;
                            if (channel != null) {
                                try {
                                    channel.close();
                                } catch (IOException unused5) {
                                }
                            }
                            if (fileChannel != null) {
                                try {
                                    fileChannel.close();
                                } catch (IOException unused6) {
                                }
                            }
                            if (fileInputStream != null) {
                                try {
                                    fileInputStream.close();
                                } catch (IOException unused7) {
                                }
                            }
                            if (fileOutputStream != null) {
                            }
                            zExists = file2.exists();
                            if (zExists) {
                                file.delete();
                            }
                            return zExists;
                        } catch (IOException unused8) {
                            fileChannel = channel2;
                            if (channel != null) {
                                try {
                                    channel.close();
                                } catch (IOException unused9) {
                                }
                            }
                            if (fileChannel != null) {
                                try {
                                    fileChannel.close();
                                } catch (IOException unused10) {
                                }
                            }
                            if (fileInputStream != null) {
                                try {
                                    fileInputStream.close();
                                } catch (IOException unused11) {
                                }
                            }
                            if (fileOutputStream != null) {
                            }
                            zExists = file2.exists();
                            if (zExists) {
                                file.delete();
                            }
                            return zExists;
                        } catch (Throwable th) {
                            th = th;
                            fileChannel = channel2;
                            if (channel != null) {
                                try {
                                    channel.close();
                                } catch (IOException unused12) {
                                }
                            }
                            if (fileChannel != null) {
                                try {
                                    fileChannel.close();
                                } catch (IOException unused13) {
                                }
                            }
                            if (fileInputStream != null) {
                                try {
                                    fileInputStream.close();
                                } catch (IOException unused14) {
                                }
                            }
                            if (fileOutputStream != null) {
                                throw th;
                            }
                            try {
                                fileOutputStream.close();
                                throw th;
                            } catch (IOException unused15) {
                                throw th;
                            }
                        }
                    } catch (FileNotFoundException unused16) {
                    } catch (IOException unused17) {
                    } catch (Throwable th2) {
                        th = th2;
                    }
                } catch (FileNotFoundException unused18) {
                    fileOutputStream = null;
                    if (channel != null) {
                        channel.close();
                    }
                    if (fileChannel != null) {
                        fileChannel.close();
                    }
                    if (fileInputStream != null) {
                        fileInputStream.close();
                    }
                    if (fileOutputStream != null) {
                        fileOutputStream.close();
                    }
                    zExists = file2.exists();
                    if (zExists) {
                        file.delete();
                    }
                    return zExists;
                } catch (IOException unused19) {
                    fileOutputStream = null;
                    if (channel != null) {
                        channel.close();
                    }
                    if (fileChannel != null) {
                        fileChannel.close();
                    }
                    if (fileInputStream != null) {
                        fileInputStream.close();
                    }
                    if (fileOutputStream != null) {
                        fileOutputStream.close();
                    }
                    zExists = file2.exists();
                    if (zExists) {
                        file.delete();
                    }
                    return zExists;
                } catch (Throwable th3) {
                    th = th3;
                    fileOutputStream = null;
                    if (channel != null) {
                        channel.close();
                    }
                    if (fileChannel != null) {
                        fileChannel.close();
                    }
                    if (fileInputStream != null) {
                        fileInputStream.close();
                    }
                    if (fileOutputStream != null) {
                        throw th;
                    }
                    fileOutputStream.close();
                    throw th;
                }
            } catch (FileNotFoundException unused20) {
                channel = null;
            } catch (IOException unused21) {
                channel = null;
            } catch (Throwable th4) {
                th = th4;
                channel = null;
            }
        } catch (FileNotFoundException unused22) {
            fileInputStream = null;
            channel = null;
            fileOutputStream = null;
        } catch (IOException unused23) {
            fileInputStream = null;
            channel = null;
            fileOutputStream = null;
        } catch (Throwable th5) {
            th = th5;
            fileInputStream = null;
            channel = null;
            fileOutputStream = null;
        }
        try {
            fileOutputStream.close();
        } catch (IOException unused24) {
        }
        zExists = file2.exists();
        if (zExists) {
            file.delete();
        }
        return zExists;
    }

    /* JADX INFO: renamed from: b */
    static long m169b(SharedPreferences sharedPreferences) {
        return m147a(sharedPreferences, f151e, 0L);
    }

    /* JADX INFO: renamed from: b */
    static File m170b(String str) {
        File fileM141b;
        Bitmap bitmap;
        int i = d.f159b[C0382j.f217Y.ordinal()];
        if (i == 1) {
            if (C0382j.f215W != null) {
                fileM141b = C0373d0.m141b(str, C0382j.f216X, ".jpg");
                bitmap = C0382j.f215W;
                C0373d0.m140a(fileM141b, bitmap);
                return fileM141b;
            }
            return null;
        }
        if (i == 2 && C0382j.f214V != null) {
            fileM141b = C0373d0.m141b(str, C0382j.f216X, ".jpg");
            bitmap = C0382j.f214V;
            C0373d0.m140a(fileM141b, bitmap);
            return fileM141b;
        }
        return null;
    }

    /* JADX INFO: renamed from: b */
    static String m171b() {
        return UUID.randomUUID().toString();
    }

    /* JADX INFO: renamed from: b */
    static void m172b(Activity activity) {
        m153a(activity, true);
        C0383k.m256k();
        C0383k.m261p();
        C0383k.m249e();
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: b */
    public static void m173b(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences("SmartBeat", 0);
        SharedPreferences.Editor editorEdit = sharedPreferences.edit();
        if (sharedPreferences.getString("idv2", "").length() > 0) {
            editorEdit.remove("uuid");
        }
        editorEdit.remove("idv2");
        m156a(editorEdit);
    }

    /* JADX INFO: renamed from: b */
    static void m174b(SharedPreferences.Editor editor) {
        editor.putLong(f152f, f155i);
    }

    /* JADX INFO: renamed from: b */
    static void m175b(SharedPreferences.Editor editor, boolean z) {
        editor.putBoolean(f150d, z);
        C0382j.f230f0 = z;
    }

    /* JADX INFO: renamed from: c */
    static long m176c(SharedPreferences sharedPreferences) {
        long j = f155i;
        long jM147a = m147a(sharedPreferences, f152f, f155i);
        if (jM147a >= f155i) {
            j = jM147a;
        }
        if (j > 691200000) {
            return 691200000L;
        }
        return j;
    }

    /* JADX INFO: renamed from: c */
    static String m177c() {
        return Build.BOARD;
    }

    /* JADX INFO: renamed from: c */
    private static String m178c(Context context) {
        String string = context.getSharedPreferences("SmartBeat", 0).getString("idv2", "");
        if (string.length() <= 0) {
            return null;
        }
        return string;
    }

    /* JADX INFO: renamed from: c */
    static void m179c(Activity activity) {
        if (C0382j.f213U.length() > 0) {
            return;
        }
        m172b(activity);
    }

    /* JADX INFO: renamed from: c */
    static void m180c(SharedPreferences.Editor editor) {
        editor.putLong(f154h, SystemClock.elapsedRealtime());
    }

    /* JADX INFO: renamed from: d */
    static String m181d() {
        return Locale.getDefault().getDisplayLanguage(Locale.US);
    }

    /* JADX INFO: renamed from: d */
    static String m182d(Context context) {
        return Build.VERSION.SDK_INT < 23 ? C0397z.m355a(context) : C0395x.m351a(context);
    }

    /* JADX INFO: renamed from: d */
    static void m183d(SharedPreferences.Editor editor) {
        editor.putLong(f151e, System.currentTimeMillis());
    }

    /* JADX INFO: renamed from: d */
    static void m184d(SharedPreferences sharedPreferences) {
        long jM176c = m176c(sharedPreferences) * 2;
        if (jM176c < f155i) {
            jM176c = 86400000;
        }
        if (jM176c > 691200000) {
            jM176c = 691200000;
        }
        SharedPreferences.Editor editorEdit = sharedPreferences.edit();
        editorEdit.putLong(f152f, jM176c);
        m156a(editorEdit);
    }

    /* JADX INFO: renamed from: e */
    static String m185e() {
        return m149a(C0382j.m217a(), "ro.board.platform");
    }

    /* JADX INFO: renamed from: e */
    static String m186e(Context context) {
        Display defaultDisplay = ((WindowManager) context.getSystemService("window")).getDefaultDisplay();
        switch (defaultDisplay.getRotation()) {
            case 0:
                return "ROTATION_0";
            case 1:
                return "ROTATION_90";
            case 2:
                return "ROTATION_180";
            case 3:
                return "ROTATION_270";
            default:
                return "unknown:" + String.valueOf(defaultDisplay.getRotation());
        }
    }

    /* JADX INFO: renamed from: e */
    static void m187e(SharedPreferences sharedPreferences) {
        C0382j.f230f0 = m167a(sharedPreferences, f150d, false);
        C0382j.f232g0 = m167a(sharedPreferences, f153g, false);
    }

    /* JADX INFO: renamed from: f */
    static SharedPreferences m188f(Context context) {
        return context.getSharedPreferences(C0376f.f144b, 0);
    }

    /* JADX INFO: renamed from: f */
    static String m189f() {
        StringBuilder sb = new StringBuilder();
        if (Build.VERSION.SDK_INT >= 21) {
            for (String str : C0394w.m349a()) {
                if (str.length() > 0) {
                    if (sb.length() > 0) {
                        sb.append(" / ");
                    }
                    sb.append(str);
                }
            }
        } else {
            sb.append(C0367a0.m80a());
            String strM81b = C0367a0.m81b();
            if (strM81b != null && strM81b.length() > 0) {
                sb.append(" / ");
                sb.append(strM81b);
            }
        }
        return sb.toString();
    }

    /* JADX INFO: renamed from: g */
    private static String m190g(Context context) {
        return context.getDir("SmartBeat", 0).getAbsolutePath();
    }

    /* JADX INFO: renamed from: g */
    static boolean m191g() {
        return m195i();
    }

    @SuppressLint({"NewApi"})
    /* JADX INFO: renamed from: h */
    private static String m192h(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences("SmartBeat", 0);
        String string = sharedPreferences.getString("uuid", "");
        if (string.length() <= 0) {
            string = UUID.randomUUID().toString();
            SharedPreferences.Editor editorEdit = sharedPreferences.edit();
            editorEdit.putString("uuid", string);
            m156a(editorEdit);
        }
        return "android:" + string + ":" + C0382j.f246s;
    }

    /* JADX INFO: renamed from: h */
    static boolean m193h() {
        return m199k() && !C0382j.f232g0 && C0382j.f209Q;
    }

    /* JADX INFO: renamed from: i */
    static String m194i(Context context) {
        return Build.VERSION.SDK_INT < 23 ? C0397z.m357b(context) : C0395x.m353b(context);
    }

    /* JADX INFO: renamed from: i */
    static boolean m195i() {
        return m199k() && !C0382j.f232g0;
    }

    /* JADX INFO: renamed from: j */
    private static void m196j(Context context) {
        new Thread(new a(context)).start();
    }

    /* JADX INFO: renamed from: j */
    static boolean m197j() {
        return !C0382j.f230f0;
    }

    /* JADX INFO: renamed from: k */
    static void m198k(Context context) {
        C0382j.f243p = context.getPackageName();
        C0382j.f246s = Build.MODEL;
        C0382j.f245r = Build.BRAND;
        C0382j.f196D = m171b();
        C0382j.f244q = "unknown";
        C0382j.f249v = "unknown";
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(C0382j.f243p, 0);
            C0382j.f244q = packageInfo.versionName;
            C0382j.f249v = String.valueOf(packageInfo.versionCode);
        } catch (PackageManager.NameNotFoundException unused) {
        }
        C0382j.f250w = Build.VERSION.RELEASE;
        C0382j.f251x = m202n();
        C0382j.f247t = m192h(context);
        C0382j.f248u = m178c(context);
        m196j(context);
        DisplayMetrics displayMetrics = new DisplayMetrics();
        ((WindowManager) context.getSystemService("window")).getDefaultDisplay().getMetrics(displayMetrics);
        C0382j.f252y = displayMetrics.densityDpi;
        C0382j.f253z = displayMetrics.widthPixels;
        C0382j.f193A = displayMetrics.heightPixels;
        C0382j.f195C = m190g(context);
    }

    /* JADX INFO: renamed from: k */
    static boolean m199k() {
        return (C0382j.f228e0 || C0382j.f230f0) ? false : true;
    }

    /* JADX INFO: renamed from: l */
    static boolean m200l() {
        return C0382j.f242o.length() > 0;
    }

    /* JADX INFO: renamed from: m */
    static boolean m201m() {
        return (Build.VERSION.SDK_INT >= 23 ? C0395x.m350a() : 0) > 0;
    }

    /* JADX INFO: renamed from: n */
    private static boolean m202n() {
        String[] strArr = {"/sbin/", "/system/bin/", "/system/xbin/", "/data/local/xbin/", "/data/local/bin/", "/system/sd/xbin/", "/system/bin/failsafe/", "/data/local/"};
        for (int i = 0; i < 8; i++) {
            if (new File(strArr[i] + "su").exists()) {
                return true;
            }
        }
        return false;
    }

    /* JADX INFO: renamed from: o */
    private static List<String> m203o() {
        LinkedList linkedList = new LinkedList(Arrays.asList("android.intent.action.ACTION_POWER_CONNECTED", "android.intent.action.ACTION_POWER_DISCONNECTED", "android.intent.action.ACTION_SHUTDOWN", "android.intent.action.AIRPLANE_MODE", "android.intent.action.BATTERY_LOW", "android.intent.action.BATTERY_OKAY", "android.intent.action.CAMERA_BUTTON", "android.intent.action.CLOSE_SYSTEM_DIALOGS", "android.intent.action.CONFIGURATION_CHANGED", "android.intent.action.DATE_CHANGED", "android.intent.action.DOCK_EVENT", "android.intent.action.INPUT_METHOD_CHANGED", "android.intent.action.LOCALE_CHANGED", "android.intent.action.REBOOT", "android.intent.action.SCREEN_OFF", "android.intent.action.SCREEN_ON", "android.intent.action.TIMEZONE_CHANGED", "android.intent.action.TIME_SET"));
        int i = Build.VERSION.SDK_INT;
        if (i >= 17) {
            linkedList.addAll(Arrays.asList("android.intent.action.DREAMING_STARTED", "android.intent.action.DREAMING_STOPPED"));
        }
        if (i >= 21) {
            linkedList.add("android.os.action.POWER_SAVE_MODE_CHANGED");
        }
        if (i >= 23) {
            linkedList.add("android.os.action.DEVICE_IDLE_MODE_CHANGED");
        }
        return Collections.unmodifiableList(linkedList);
    }

    /* JADX WARN: Code duplicated, block: B:105:0x01c0 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:106:0x01c2 A[Catch: all -> 0x01be, IOException -> 0x020c, TryCatch #12 {IOException -> 0x020c, all -> 0x01be, blocks: (B:102:0x01ba, B:106:0x01c2, B:108:0x01c7, B:110:0x01cd, B:111:0x01d4, B:113:0x01da, B:114:0x01e1, B:116:0x01e7, B:117:0x01ee), top: B:137:0x01ba }] */
    /* JADX WARN: Code duplicated, block: B:108:0x01c7 A[Catch: all -> 0x01be, IOException -> 0x020c, TryCatch #12 {IOException -> 0x020c, all -> 0x01be, blocks: (B:102:0x01ba, B:106:0x01c2, B:108:0x01c7, B:110:0x01cd, B:111:0x01d4, B:113:0x01da, B:114:0x01e1, B:116:0x01e7, B:117:0x01ee), top: B:137:0x01ba }] */
    /* JADX WARN: Code duplicated, block: B:110:0x01cd A[Catch: all -> 0x01be, IOException -> 0x020c, TryCatch #12 {IOException -> 0x020c, all -> 0x01be, blocks: (B:102:0x01ba, B:106:0x01c2, B:108:0x01c7, B:110:0x01cd, B:111:0x01d4, B:113:0x01da, B:114:0x01e1, B:116:0x01e7, B:117:0x01ee), top: B:137:0x01ba }] */
    /* JADX WARN: Code duplicated, block: B:113:0x01da A[Catch: all -> 0x01be, IOException -> 0x020c, TryCatch #12 {IOException -> 0x020c, all -> 0x01be, blocks: (B:102:0x01ba, B:106:0x01c2, B:108:0x01c7, B:110:0x01cd, B:111:0x01d4, B:113:0x01da, B:114:0x01e1, B:116:0x01e7, B:117:0x01ee), top: B:137:0x01ba }] */
    /* JADX WARN: Code duplicated, block: B:116:0x01e7 A[Catch: all -> 0x01be, IOException -> 0x020c, TryCatch #12 {IOException -> 0x020c, all -> 0x01be, blocks: (B:102:0x01ba, B:106:0x01c2, B:108:0x01c7, B:110:0x01cd, B:111:0x01d4, B:113:0x01da, B:114:0x01e1, B:116:0x01e7, B:117:0x01ee), top: B:137:0x01ba }] */
    /* JADX WARN: Code duplicated, block: B:131:0x0160 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:137:0x01ba A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:82:0x0166 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:83:0x0168 A[Catch: all -> 0x0164, IOException -> 0x01b2, TryCatch #15 {IOException -> 0x01b2, all -> 0x0164, blocks: (B:79:0x0160, B:83:0x0168, B:85:0x016d, B:87:0x0173, B:88:0x017a, B:90:0x0180, B:91:0x0187, B:93:0x018d, B:94:0x0194), top: B:131:0x0160 }] */
    /* JADX WARN: Code duplicated, block: B:85:0x016d A[Catch: all -> 0x0164, IOException -> 0x01b2, TryCatch #15 {IOException -> 0x01b2, all -> 0x0164, blocks: (B:79:0x0160, B:83:0x0168, B:85:0x016d, B:87:0x0173, B:88:0x017a, B:90:0x0180, B:91:0x0187, B:93:0x018d, B:94:0x0194), top: B:131:0x0160 }] */
    /* JADX WARN: Code duplicated, block: B:87:0x0173 A[Catch: all -> 0x0164, IOException -> 0x01b2, TryCatch #15 {IOException -> 0x01b2, all -> 0x0164, blocks: (B:79:0x0160, B:83:0x0168, B:85:0x016d, B:87:0x0173, B:88:0x017a, B:90:0x0180, B:91:0x0187, B:93:0x018d, B:94:0x0194), top: B:131:0x0160 }] */
    /* JADX WARN: Code duplicated, block: B:90:0x0180 A[Catch: all -> 0x0164, IOException -> 0x01b2, TryCatch #15 {IOException -> 0x01b2, all -> 0x0164, blocks: (B:79:0x0160, B:83:0x0168, B:85:0x016d, B:87:0x0173, B:88:0x017a, B:90:0x0180, B:91:0x0187, B:93:0x018d, B:94:0x0194), top: B:131:0x0160 }] */
    /* JADX WARN: Code duplicated, block: B:93:0x018d A[Catch: all -> 0x0164, IOException -> 0x01b2, TryCatch #15 {IOException -> 0x01b2, all -> 0x0164, blocks: (B:79:0x0160, B:83:0x0168, B:85:0x016d, B:87:0x0173, B:88:0x017a, B:90:0x0180, B:91:0x0187, B:93:0x018d, B:94:0x0194), top: B:131:0x0160 }] */
    /* JADX INFO: renamed from: p */
    static String m204p() throws Throwable {
        Throwable th;
        Process processExec;
        Exception e2;
        InputStreamReader inputStreamReader;
        String line;
        String str = C0382j.f204L;
        StringBuilder sb = new StringBuilder();
        BufferedReader bufferedReader = null;
        try {
            processExec = Runtime.getRuntime().exec("logcat -t " + FTPReply.UNRECOGNIZED_COMMAND + " " + str);
            try {
                inputStreamReader = new InputStreamReader(processExec.getInputStream());
                try {
                    BufferedReader bufferedReader2 = new BufferedReader(inputStreamReader, 8192);
                    try {
                        ArrayList arrayList = new ArrayList();
                        for (int i = 0; i < 1000 && (line = bufferedReader2.readLine()) != null; i++) {
                            arrayList.add(line);
                        }
                        if (arrayList.size() == 0) {
                            try {
                                bufferedReader2.close();
                                inputStreamReader.close();
                                if (processExec != null) {
                                    if (processExec.getInputStream() != null) {
                                        processExec.getInputStream().close();
                                    }
                                    if (processExec.getOutputStream() != null) {
                                        processExec.getOutputStream().close();
                                    }
                                    if (processExec.getErrorStream() != null) {
                                        processExec.getErrorStream().close();
                                    }
                                    processExec.destroy();
                                }
                            } catch (IOException unused) {
                            } catch (Throwable th2) {
                                m159a(e.ERROR, "logcat stream close failed " + th2.getMessage());
                            }
                            return "no permission (android.permission.READ_LOGS)";
                        }
                        try {
                            bufferedReader2.close();
                            inputStreamReader.close();
                            if (processExec != null) {
                                if (processExec.getInputStream() != null) {
                                    processExec.getInputStream().close();
                                }
                                if (processExec.getOutputStream() != null) {
                                    processExec.getOutputStream().close();
                                }
                                if (processExec.getErrorStream() != null) {
                                    processExec.getErrorStream().close();
                                }
                                processExec.destroy();
                            }
                        } catch (IOException unused2) {
                        } catch (Throwable th3) {
                            m159a(e.ERROR, "logcat stream close failed " + th3.getMessage());
                        }
                        int size = arrayList.size() - FTPReply.UNRECOGNIZED_COMMAND;
                        if (size < 0) {
                            size = 0;
                        }
                        int length = 0;
                        for (int size2 = arrayList.size() - 1; size2 >= 0 && size2 >= size; size2--) {
                            String str2 = ((String) arrayList.get(size2)) + "\n";
                            length += str2.getBytes().length;
                            if (length > 65536) {
                                break;
                            }
                            sb.insert(0, str2);
                        }
                        return sb.toString();
                    } catch (Exception e3) {
                        e2 = e3;
                        bufferedReader = bufferedReader2;
                        try {
                            String str3 = String.format("error to read logcat(%s)", e2.getMessage());
                            if (bufferedReader != null) {
                                try {
                                    bufferedReader.close();
                                    if (inputStreamReader != null) {
                                        inputStreamReader.close();
                                    }
                                    if (processExec != null) {
                                        if (processExec.getInputStream() != null) {
                                            processExec.getInputStream().close();
                                        }
                                        if (processExec.getOutputStream() != null) {
                                            processExec.getOutputStream().close();
                                        }
                                        if (processExec.getErrorStream() != null) {
                                            processExec.getErrorStream().close();
                                        }
                                        processExec.destroy();
                                    }
                                } catch (IOException unused3) {
                                    return str3;
                                } catch (Throwable th4) {
                                    m159a(e.ERROR, "logcat stream close failed " + th4.getMessage());
                                    return str3;
                                }
                            } else {
                                if (inputStreamReader != null) {
                                    inputStreamReader.close();
                                }
                                if (processExec != null) {
                                    if (processExec.getInputStream() != null) {
                                        processExec.getInputStream().close();
                                    }
                                    if (processExec.getOutputStream() != null) {
                                        processExec.getOutputStream().close();
                                    }
                                    if (processExec.getErrorStream() != null) {
                                        processExec.getErrorStream().close();
                                    }
                                    processExec.destroy();
                                }
                            }
                            return str3;
                        } catch (Throwable th5) {
                            th = th5;
                            bufferedReader2 = bufferedReader;
                            inputStreamReader = inputStreamReader;
                            bufferedReader = bufferedReader2;
                            if (bufferedReader != null) {
                                try {
                                    bufferedReader.close();
                                    if (inputStreamReader != null) {
                                        inputStreamReader.close();
                                    }
                                    if (processExec != null) {
                                        if (processExec.getInputStream() != null) {
                                            processExec.getInputStream().close();
                                        }
                                        if (processExec.getOutputStream() != null) {
                                            processExec.getOutputStream().close();
                                        }
                                        if (processExec.getErrorStream() != null) {
                                            processExec.getErrorStream().close();
                                        }
                                        processExec.destroy();
                                    }
                                } catch (IOException unused4) {
                                    throw th;
                                } catch (Throwable th6) {
                                    m159a(e.ERROR, "logcat stream close failed " + th6.getMessage());
                                    throw th;
                                }
                            } else {
                                if (inputStreamReader != null) {
                                    inputStreamReader.close();
                                }
                                if (processExec != null) {
                                    if (processExec.getInputStream() != null) {
                                        processExec.getInputStream().close();
                                    }
                                    if (processExec.getOutputStream() != null) {
                                        processExec.getOutputStream().close();
                                    }
                                    if (processExec.getErrorStream() != null) {
                                        processExec.getErrorStream().close();
                                    }
                                    processExec.destroy();
                                }
                            }
                            throw th;
                        }
                    } catch (Throwable th7) {
                        th = th7;
                        inputStreamReader = inputStreamReader;
                        bufferedReader = bufferedReader2;
                        if (bufferedReader != null) {
                            bufferedReader.close();
                            if (inputStreamReader != null) {
                                inputStreamReader.close();
                            }
                            if (processExec != null) {
                                if (processExec.getInputStream() != null) {
                                    processExec.getInputStream().close();
                                }
                                if (processExec.getOutputStream() != null) {
                                    processExec.getOutputStream().close();
                                }
                                if (processExec.getErrorStream() != null) {
                                    processExec.getErrorStream().close();
                                }
                                processExec.destroy();
                            }
                        } else {
                            if (inputStreamReader != null) {
                                inputStreamReader.close();
                            }
                            if (processExec != null) {
                                if (processExec.getInputStream() != null) {
                                    processExec.getInputStream().close();
                                }
                                if (processExec.getOutputStream() != null) {
                                    processExec.getOutputStream().close();
                                }
                                if (processExec.getErrorStream() != null) {
                                    processExec.getErrorStream().close();
                                }
                                processExec.destroy();
                            }
                        }
                        throw th;
                    }
                } catch (Exception e4) {
                    e2 = e4;
                } catch (Throwable th8) {
                    th = th8;
                    if (bufferedReader != null) {
                        bufferedReader.close();
                        if (inputStreamReader != null) {
                            inputStreamReader.close();
                        }
                        if (processExec != null) {
                            if (processExec.getInputStream() != null) {
                                processExec.getInputStream().close();
                            }
                            if (processExec.getOutputStream() != null) {
                                processExec.getOutputStream().close();
                            }
                            if (processExec.getErrorStream() != null) {
                                processExec.getErrorStream().close();
                            }
                            processExec.destroy();
                        }
                    } else {
                        if (inputStreamReader != null) {
                            inputStreamReader.close();
                        }
                        if (processExec != null) {
                            if (processExec.getInputStream() != null) {
                                processExec.getInputStream().close();
                            }
                            if (processExec.getOutputStream() != null) {
                                processExec.getOutputStream().close();
                            }
                            if (processExec.getErrorStream() != null) {
                                processExec.getErrorStream().close();
                            }
                            processExec.destroy();
                        }
                    }
                    throw th;
                }
            } catch (Exception e5) {
                e2 = e5;
                inputStreamReader = null;
                String str4 = String.format("error to read logcat(%s)", e2.getMessage());
                if (bufferedReader != null) {
                    bufferedReader.close();
                    if (inputStreamReader != null) {
                        inputStreamReader.close();
                    }
                    if (processExec != null) {
                        if (processExec.getInputStream() != null) {
                            processExec.getInputStream().close();
                        }
                        if (processExec.getOutputStream() != null) {
                            processExec.getOutputStream().close();
                        }
                        if (processExec.getErrorStream() != null) {
                            processExec.getErrorStream().close();
                        }
                        processExec.destroy();
                    }
                } else {
                    if (inputStreamReader != null) {
                        inputStreamReader.close();
                    }
                    if (processExec != null) {
                        if (processExec.getInputStream() != null) {
                            processExec.getInputStream().close();
                        }
                        if (processExec.getOutputStream() != null) {
                            processExec.getOutputStream().close();
                        }
                        if (processExec.getErrorStream() != null) {
                            processExec.getErrorStream().close();
                        }
                        processExec.destroy();
                    }
                }
                return str4;
            } catch (Throwable th9) {
                th = th9;
                inputStreamReader = null;
                if (bufferedReader != null) {
                    bufferedReader.close();
                    if (inputStreamReader != null) {
                        inputStreamReader.close();
                    }
                    if (processExec != null) {
                        if (processExec.getInputStream() != null) {
                            processExec.getInputStream().close();
                        }
                        if (processExec.getOutputStream() != null) {
                            processExec.getOutputStream().close();
                        }
                        if (processExec.getErrorStream() != null) {
                            processExec.getErrorStream().close();
                        }
                        processExec.destroy();
                    }
                } else {
                    if (inputStreamReader != null) {
                        inputStreamReader.close();
                    }
                    if (processExec != null) {
                        if (processExec.getInputStream() != null) {
                            processExec.getInputStream().close();
                        }
                        if (processExec.getOutputStream() != null) {
                            processExec.getOutputStream().close();
                        }
                        if (processExec.getErrorStream() != null) {
                            processExec.getErrorStream().close();
                        }
                        processExec.destroy();
                    }
                }
                throw th;
            }
        } catch (Exception e6) {
            e2 = e6;
            processExec = null;
        } catch (Throwable th10) {
            th = th10;
            processExec = null;
        }
    }

    /* JADX INFO: renamed from: q */
    static File m205q() {
        return m170b(C0382j.f196D);
    }

    /* JADX INFO: renamed from: r */
    private static void m206r() {
        String str = C0382j.f213U;
        List<String> list = C0382j.f211S;
        synchronized (list) {
            Iterator<String> it = list.iterator();
            while (it.hasNext()) {
                if (str.equals(it.next())) {
                    C0382j.f218Z = true;
                    return;
                }
            }
            C0382j.f218Z = false;
        }
    }
}

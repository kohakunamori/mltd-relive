package com.smrtbeat;

import android.content.Context;
import android.content.res.AssetManager;
import android.os.Build;
import android.os.SystemClock;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.ByteBuffer;
import java.nio.IntBuffer;
import java.util.Collection;
import java.util.Iterator;
import java.util.concurrent.Callable;

/* JADX INFO: loaded from: classes.dex */
class SmartBeatJni {

    /* JADX INFO: renamed from: a */
    private static final String f37a = "SmartBeatNdk";

    /* JADX INFO: renamed from: b */
    private static final String f38b = "SmartBeatOpenGLNdk";

    /* JADX INFO: renamed from: c */
    private static final String f39c = "libSmartBeatNdk.so.bin";

    /* JADX INFO: renamed from: d */
    private static final String f40d = "libSmartBeatOpenGLNdk.so.bin";

    /* JADX INFO: renamed from: e */
    private static final String f41e = "com.smrtbeat";

    /* JADX INFO: renamed from: f */
    private static final int f42f = 8192;

    /* JADX INFO: renamed from: com.smrtbeat.SmartBeatJni$a */
    static class RunnableC0362a implements Runnable {

        /* JADX INFO: renamed from: a */
        File f43a;

        RunnableC0362a() {
        }

        /* JADX INFO: renamed from: a */
        Runnable m67a(File file) {
            this.f43a = file;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            long jElapsedRealtime = SystemClock.elapsedRealtime();
            C0383k.m226a(C0387o.m291a(C0382j.m217a()), this.f43a, 5000L);
            File fileM205q = C0377f0.m205q();
            long jElapsedRealtime2 = SystemClock.elapsedRealtime() - jElapsedRealtime;
            if (fileM205q == null || 5000 <= jElapsedRealtime2 || C0383k.m219a(fileM205q, 5000 - jElapsedRealtime2).m94a(fileM205q.getName()) != C0369b0.a.OK) {
                return;
            }
            C0383k.m236b(fileM205q);
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.SmartBeatJni$b */
    static class CallableC0363b implements Callable<Integer> {
        CallableC0363b() {
        }

        @Override // java.util.concurrent.Callable
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public Integer call() throws Exception {
            return Integer.valueOf(SmartBeatJni.getVersion());
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.SmartBeatJni$c */
    static class CallableC0364c implements Callable<Integer> {
        CallableC0364c() {
        }

        @Override // java.util.concurrent.Callable
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public Integer call() throws Exception {
            return Integer.valueOf(SmartBeatJni.getGlLibVersion());
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.SmartBeatJni$d */
    static class C0365d implements FilenameFilter {

        /* JADX INFO: renamed from: a */
        final /* synthetic */ String f44a;

        C0365d(String str) {
            this.f44a = str;
        }

        @Override // java.io.FilenameFilter
        public boolean accept(File file, String str) {
            return str.startsWith(this.f44a);
        }
    }

    SmartBeatJni() {
    }

    /* JADX INFO: renamed from: a */
    private static void m57a(String str, String str2) {
        File[] fileArrListFiles;
        File file = new File(str);
        if (file.exists() && file.isDirectory() && (fileArrListFiles = file.listFiles(new C0365d(str2))) != null) {
            for (File file2 : fileArrListFiles) {
                file2.delete();
            }
        }
    }

    /* JADX INFO: renamed from: a */
    static boolean m58a(Context context) {
        if (Build.VERSION.SDK_INT > 23 || C0377f0.m201m()) {
            return false;
        }
        return m60a(context, f38b, f40d, 3, new CallableC0364c());
    }

    /* JADX INFO: renamed from: a */
    private static boolean m59a(Context context, String str, String str2, int i) {
        m57a(str, str2);
        C0377f0.m159a(C0377f0.e.DEBUG, "Install NDK Library from assets");
        AssetManager assets = context.getAssets();
        int i2 = 0;
        boolean z = false;
        while (true) {
            String strM148a = C0377f0.m148a(i2);
            if (strM148a == null) {
                break;
            }
            m57a(str + "/" + strM148a, str2);
            try {
                if (m63a(assets.open("com.smrtbeat/" + strM148a + "/" + str2), new File(str + "/" + strM148a + "/" + str2 + "." + String.valueOf(i)))) {
                    z = true;
                }
            } catch (IOException unused) {
            }
            i2++;
        }
        if (!z) {
            C0377f0.m159a(C0377f0.e.WARN, String.format("Failed to install NDK Library SUPPORTED_ABIS:%s", C0377f0.m189f()));
        }
        return z;
    }

    /* JADX INFO: renamed from: a */
    private static boolean m60a(Context context, String str, String str2, int i, Callable<Integer> callable) {
        boolean zM64a = m64a(str, i, callable);
        if (zM64a) {
            return zM64a;
        }
        String str3 = context.getFilesDir() + "/com.smrtbeat";
        boolean zM65a = m65a(str3, str2, i, callable);
        if (zM65a) {
            return zM65a;
        }
        m59a(context, str3, str2, i);
        return m65a(str3, str2, i, callable);
    }

    /* JADX INFO: renamed from: a */
    static boolean m61a(Context context, Collection<Integer> collection, boolean z) {
        boolean zM60a = m60a(context, f37a, f39c, 12, new CallableC0363b());
        if (zM60a) {
            File file = new File(C0382j.f195C + "/dump_tmp");
            file.mkdirs();
            int[] iArrArray = null;
            if (collection != null && collection.size() > 0) {
                IntBuffer intBufferAllocate = IntBuffer.allocate(collection.size());
                Iterator<Integer> it = collection.iterator();
                while (it.hasNext()) {
                    intBufferAllocate.put(it.next().intValue());
                }
                iArrArray = intBufferAllocate.array();
            }
            initNdk(file.getAbsolutePath(), iArrArray, z);
            C0377f0.m159a(C0377f0.e.DEBUG, "NDK is initialized");
        }
        return zM60a;
    }

    /* JADX INFO: renamed from: a */
    private static boolean m62a(File file, int i, Callable<Integer> callable) {
        if (file != null && file.exists()) {
            try {
                System.load(file.getAbsolutePath());
                int iIntValue = -1;
                try {
                    iIntValue = callable.call().intValue();
                } catch (Exception unused) {
                }
                if (iIntValue != i) {
                    C0377f0.m159a(C0377f0.e.WARN, String.format("Library might be old. The file shall be updated. Installed:%d, Current:%d", Integer.valueOf(iIntValue), Integer.valueOf(i)));
                    return false;
                }
                C0377f0.m159a(C0377f0.e.DEBUG, "Success to load NDK Lib (file) ver = " + String.valueOf(i));
                return true;
            } catch (UnsatisfiedLinkError unused2) {
                C0377f0.m159a(C0377f0.e.WARN, "NDK Libarry(file) Link Error");
            }
        }
        return false;
    }

    /* JADX WARN: Code duplicated, block: B:56:0x0077 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:60:0x0072 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:72:? A[SYNTHETIC] */
    /* JADX WARN: Not initialized variable reg: 3, insn: 0x006f: MOVE (r1 I:??[OBJECT, ARRAY]) = (r3 I:??[OBJECT, ARRAY]), block:B:42:0x006f */
    /* JADX INFO: renamed from: a */
    private static boolean m63a(InputStream inputStream, File file) throws Throwable {
        FileOutputStream fileOutputStream;
        OutputStream outputStream;
        boolean z = false;
        if (inputStream == null) {
            return false;
        }
        OutputStream outputStream2 = null;
        try {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
                fileOutputStream = new FileOutputStream(file);
                try {
                    byte[] bArr = new byte[8192];
                    while (true) {
                        int i = inputStream.read(bArr);
                        if (-1 == i) {
                            break;
                        }
                        fileOutputStream.write(bArr, 0, i);
                    }
                    if (inputStream != null) {
                        try {
                            inputStream.close();
                        } catch (IOException unused) {
                        }
                    }
                    z = true;
                } catch (FileNotFoundException e) {
                    e = e;
                    C0377f0.m159a(C0377f0.e.WARN, String.format("Failed to install NDK Library err:%s", e.toString()));
                    if (inputStream != null) {
                        try {
                            inputStream.close();
                        } catch (IOException unused2) {
                        }
                    }
                    if (fileOutputStream != null) {
                    }
                    return z;
                } catch (IOException e2) {
                    e = e2;
                    C0377f0.m159a(C0377f0.e.WARN, String.format("Failed to install NDK Library err:%s", e.toString()));
                    if (inputStream != null) {
                        try {
                            inputStream.close();
                        } catch (IOException unused3) {
                        }
                    }
                    if (fileOutputStream != null) {
                    }
                    return z;
                }
            } catch (Throwable th) {
                th = th;
                outputStream2 = outputStream;
                if (inputStream != null) {
                    try {
                        inputStream.close();
                    } catch (IOException unused4) {
                    }
                }
                if (outputStream2 != null) {
                    throw th;
                }
                try {
                    outputStream2.close();
                    throw th;
                } catch (IOException unused5) {
                    throw th;
                }
            }
        } catch (FileNotFoundException e3) {
            e = e3;
            fileOutputStream = null;
        } catch (IOException e4) {
            e = e4;
            fileOutputStream = null;
        } catch (Throwable th2) {
            th = th2;
            if (inputStream != null) {
                inputStream.close();
            }
            if (outputStream2 != null) {
                throw th;
            }
            outputStream2.close();
            throw th;
        }
        try {
            fileOutputStream.close();
        } catch (IOException unused6) {
        }
        return z;
    }

    /* JADX INFO: renamed from: a */
    private static boolean m64a(String str, int i, Callable<Integer> callable) {
        int iIntValue;
        boolean z;
        String str2;
        C0377f0.e eVar;
        try {
            System.loadLibrary(str);
            try {
                iIntValue = callable.call().intValue();
            } catch (Exception unused) {
                iIntValue = -1;
            }
            if (iIntValue != i) {
                eVar = C0377f0.e.WARN;
                str2 = "Loaded ndk from libs folder but incompatible version. version must be " + i;
                z = false;
            } else {
                z = true;
                str2 = "Success to load NDK Lib (" + str + ")";
                eVar = C0377f0.e.DEBUG;
            }
            C0377f0.m159a(eVar, str2);
            return z;
        } catch (UnsatisfiedLinkError unused2) {
            return false;
        }
    }

    /* JADX INFO: renamed from: a */
    private static boolean m65a(String str, String str2, int i, Callable<Integer> callable) {
        int i2 = 0;
        while (true) {
            String strM148a = C0377f0.m148a(i2);
            if (strM148a == null) {
                return false;
            }
            if (m62a(new File(str + "/" + strM148a + "/" + str2 + "." + String.valueOf(i)), i, callable)) {
                return true;
            }
            i2++;
        }
    }

    static native boolean copyTextureBuffer(ByteBuffer byteBuffer);

    /* JADX INFO: Access modifiers changed from: private */
    public static native int getGlLibVersion();

    static native int getTextureLongerSideLength();

    /* JADX INFO: Access modifiers changed from: private */
    public static native int getVersion();

    private static native void initNdk(String str, int[] iArr, boolean z);

    static native int newImageTargetTexture(int i, int i2, int i3, int i4);

    public static void notifyDump(String str) {
        C0366a.m72c();
        File file = new File(str);
        if (!C0377f0.m199k()) {
            file.delete();
            return;
        }
        Thread thread = new Thread(new RunnableC0362a().m67a(file));
        thread.start();
        try {
            thread.join(5000L);
        } catch (InterruptedException unused) {
        }
    }

    public static void notifyExit() {
        C0366a.m76g();
    }
}

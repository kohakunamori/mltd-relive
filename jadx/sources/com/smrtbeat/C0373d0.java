package com.smrtbeat;

import android.app.ActivityManager;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.os.Handler;
import android.os.Process;
import android.view.View;
import android.view.Window;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

/* JADX INFO: renamed from: com.smrtbeat.d0 */
/* JADX INFO: loaded from: classes.dex */
class C0373d0 {

    /* JADX INFO: renamed from: a */
    private static final long f127a = 10240;

    /* JADX INFO: renamed from: com.smrtbeat.d0$a */
    static class a implements Runnable {

        /* JADX INFO: renamed from: a */
        View f128a;

        /* JADX INFO: renamed from: b */
        Canvas f129b;

        /* JADX INFO: renamed from: c */
        long f130c;

        /* JADX INFO: renamed from: d */
        Bitmap f131d;

        a() {
        }

        /* JADX INFO: renamed from: a */
        Runnable m142a(View view, Canvas canvas, long j, Bitmap bitmap) {
            this.f128a = view;
            this.f129b = canvas;
            this.f130c = j;
            this.f131d = bitmap;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            try {
                this.f128a.draw(this.f129b);
                C0377f0.m162a(C0382j.a.ENative, this.f131d, this.f130c);
            } catch (Throwable unused) {
            }
            this.f128a = null;
            this.f129b = null;
            this.f131d = null;
        }
    }

    C0373d0() {
    }

    /* JADX INFO: renamed from: a */
    static String m136a(String str, long j, String str2) {
        return str + "_" + String.valueOf(j) + str2;
    }

    /* JADX INFO: renamed from: a */
    static void m137a(Window window, Context context, RunnableC0378g runnableC0378g, Handler handler) {
        if (m139a((ActivityManager) context.getSystemService("activity"))) {
            C0377f0.m159a(C0377f0.e.INFO, "Skip Capturing ScreenShot due to low memory");
        } else {
            m138a(window, runnableC0378g, handler);
        }
    }

    /* JADX INFO: renamed from: a */
    private static void m138a(Window window, RunnableC0378g runnableC0378g, Handler handler) {
        View decorView;
        if (!C0382j.f226d0 && C0382j.f196D.length() > 0) {
            long jCurrentTimeMillis = System.currentTimeMillis();
            if (window != null && (decorView = window.getDecorView()) != null && decorView.getHeight() > 0 && decorView.getWidth() > 0) {
                Canvas canvas = runnableC0378g.f172e;
                if (canvas == null || canvas.getWidth() != decorView.getWidth() || runnableC0378g.f172e.getHeight() != decorView.getHeight()) {
                    Bitmap bitmap = runnableC0378g.f173f;
                    if (bitmap != null) {
                        C0377f0.m161a(C0382j.a.ENative, bitmap);
                    }
                    runnableC0378g.f173f = Bitmap.createBitmap(decorView.getWidth(), decorView.getHeight(), Bitmap.Config.RGB_565);
                    Canvas canvas2 = new Canvas();
                    runnableC0378g.f172e = canvas2;
                    canvas2.setBitmap(runnableC0378g.f173f);
                    Canvas canvas3 = runnableC0378g.f172e;
                    canvas3.setDensity(canvas3.getDensity());
                }
                handler.post(new a().m142a(decorView, runnableC0378g.f172e, jCurrentTimeMillis, runnableC0378g.f173f));
            }
        }
    }

    /* JADX INFO: renamed from: a */
    private static boolean m139a(ActivityManager activityManager) {
        return Runtime.getRuntime().maxMemory() - ((long) (activityManager.getProcessMemoryInfo(new int[]{Process.myPid()})[0].getTotalPss() * 1024)) < f127a;
    }

    /* JADX WARN: Code restructure failed: missing block: B:21:0x003c, code lost:
    
        if (r1 != null) goto L22;
     */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r3v10 */
    /* JADX WARN: Type inference failed for: r3v15 */
    /* JADX WARN: Type inference failed for: r3v16 */
    /* JADX WARN: Type inference failed for: r3v7 */
    /* JADX INFO: renamed from: a */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    static boolean m140a(File file, Bitmap bitmap) {
        boolean z = false;
        FileOutputStream fileOutputStream = null;
        try {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
                FileOutputStream fileOutputStream2 = new FileOutputStream(file);
                try {
                    bitmap.compress(Bitmap.CompressFormat.JPEG, 80, fileOutputStream2);
                    file = 1;
                    try {
                        C0377f0.m159a(C0377f0.e.VERBOSE, "saved Screenshot to file");
                        fileOutputStream2.close();
                    } catch (FileNotFoundException unused) {
                        z = true;
                        file = z;
                        fileOutputStream = fileOutputStream2;
                    } catch (IOException unused2) {
                        z = true;
                        file = z;
                        fileOutputStream = fileOutputStream2;
                        if (fileOutputStream != null) {
                            fileOutputStream.close();
                            file = file;
                        }
                        return file;
                    } catch (Throwable unused3) {
                        z = true;
                        file = z;
                        fileOutputStream = fileOutputStream2;
                        if (fileOutputStream != null) {
                            fileOutputStream.close();
                            file = file;
                        }
                        return file;
                    }
                } catch (FileNotFoundException unused4) {
                } catch (IOException unused5) {
                } catch (Throwable unused6) {
                }
            } catch (IOException unused7) {
            }
        } catch (FileNotFoundException unused8) {
            file = 0;
        } catch (IOException unused9) {
            file = 0;
        } catch (Throwable unused10) {
            file = 0;
        }
        return file;
    }

    /* JADX INFO: renamed from: b */
    static File m141b(String str, long j, String str2) {
        return new File(C0382j.f195C + "/capture/" + str + "/" + m136a(str, j, str2));
    }
}

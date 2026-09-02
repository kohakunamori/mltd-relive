package com.smrtbeat;

import android.annotation.SuppressLint;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Point;
import android.opengl.GLES20;
import android.os.Build;
import androidx.core.view.InputDeviceCompat;
import java.nio.Buffer;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGLContext;
import javax.microedition.khronos.egl.EGLDisplay;
import javax.microedition.khronos.egl.EGLSurface;

/* JADX INFO: renamed from: com.smrtbeat.s */
/* JADX INFO: loaded from: classes.dex */
class C0390s {

    /* JADX INFO: renamed from: A */
    private static final int f396A = 4;

    /* JADX INFO: renamed from: B */
    private static final int f397B = 8;

    /* JADX INFO: renamed from: C */
    private static C0390s f398C;

    /* JADX INFO: renamed from: a */
    private int f399a;

    /* JADX INFO: renamed from: b */
    private int f400b;

    /* JADX INFO: renamed from: c */
    private int f401c;

    /* JADX INFO: renamed from: d */
    private int f402d = 0;

    /* JADX INFO: renamed from: e */
    private boolean f403e = false;

    /* JADX INFO: renamed from: f */
    private int f404f = -1;

    /* JADX INFO: renamed from: g */
    private int f405g = 0;

    /* JADX INFO: renamed from: h */
    private int f406h = 0;

    /* JADX INFO: renamed from: i */
    private int f407i = 0;

    /* JADX INFO: renamed from: j */
    private int f408j = 0;

    /* JADX INFO: renamed from: k */
    private int f409k = 0;

    /* JADX INFO: renamed from: l */
    private int f410l = 0;

    /* JADX INFO: renamed from: m */
    private ByteBuffer f411m = null;

    /* JADX INFO: renamed from: n */
    private Bitmap f412n = null;

    /* JADX INFO: renamed from: o */
    private Bitmap f413o = null;

    /* JADX INFO: renamed from: p */
    private Canvas f414p = null;

    /* JADX INFO: renamed from: q */
    private Thread f415q = null;

    /* JADX INFO: renamed from: r */
    private boolean f416r = true;

    /* JADX INFO: renamed from: s */
    private boolean f417s = false;

    /* JADX INFO: renamed from: t */
    private long f418t = 0;

    /* JADX INFO: renamed from: u */
    private boolean f419u = false;

    /* JADX INFO: renamed from: v */
    private FloatBuffer f420v = null;

    /* JADX INFO: renamed from: w */
    private FloatBuffer f421w = null;

    /* JADX INFO: renamed from: x */
    private final List<String> f422x = Collections.synchronizedList(new ArrayList());

    /* JADX INFO: renamed from: y */
    private final String f423y = "attribute vec2 aPosition;\nattribute vec2 aTextureCoord;\nvarying vec2 vTextureCoord;\nvoid main() {\n  gl_Position = vec4(aPosition, 0.0, 1.0);\n  vTextureCoord = aTextureCoord;\n}\n";

    /* JADX INFO: renamed from: z */
    private final String f424z = "precision mediump float;\nvarying vec2 vTextureCoord;\nuniform sampler2D sTexture;\nvoid main() {\n  gl_FragColor = texture2D(sTexture, vTextureCoord);\n}\n";

    /* JADX INFO: renamed from: com.smrtbeat.s$a */
    class a implements Runnable {

        /* JADX INFO: renamed from: a */
        ByteBuffer f425a;

        a() {
        }

        /* JADX INFO: renamed from: a */
        Runnable m342a(ByteBuffer byteBuffer) {
            this.f425a = byteBuffer;
            return this;
        }

        @Override // java.lang.Runnable
        public void run() {
            try {
                if (C0382j.f213U.length() > 0) {
                    this.f425a.order(ByteOrder.nativeOrder()).position(0);
                    if (SmartBeatJni.copyTextureBuffer(this.f425a)) {
                        C0390s.this.f412n.copyPixelsFromBuffer(this.f425a);
                        this.f425a = null;
                        C0390s.this.f414p.drawBitmap(C0390s.this.f412n, 0.0f, 0.0f, new Paint());
                        C0377f0.m162a(C0382j.a.EGles, C0390s.this.f413o, System.currentTimeMillis());
                    }
                }
            } catch (Exception unused) {
            } finally {
                C0390s.this.f415q = null;
            }
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.s$b */
    class b {

        /* JADX INFO: renamed from: a */
        private int f427a;

        /* JADX INFO: renamed from: b */
        private int f428b;

        /* JADX INFO: renamed from: c */
        private int f429c;

        /* JADX INFO: renamed from: d */
        private int f430d;

        /* JADX INFO: renamed from: e */
        private int f431e;

        /* JADX INFO: renamed from: f */
        private boolean f432f;

        /* JADX INFO: renamed from: g */
        private boolean f433g;

        /* JADX INFO: renamed from: h */
        private boolean f434h;

        /* JADX INFO: renamed from: i */
        private int f435i;

        /* JADX INFO: renamed from: j */
        private int f436j;

        /* JADX INFO: renamed from: k */
        private int f437k;

        /* JADX INFO: renamed from: l */
        private int f438l;

        /* JADX INFO: renamed from: m */
        private int f439m;

        /* JADX INFO: renamed from: n */
        private int f440n;

        /* JADX INFO: renamed from: o */
        private int[] f441o = new int[4];

        b() {
        }

        /* JADX INFO: renamed from: a */
        void m343a(int i, boolean z) {
            int[] iArr = new int[1];
            GLES20.glGetIntegerv(34016, iArr, 0);
            this.f427a = iArr[0];
            GLES20.glActiveTexture(33984);
            GLES20.glGetIntegerv(32873, iArr, 0);
            this.f428b = iArr[0];
            GLES20.glGetIntegerv(35725, iArr, 0);
            this.f429c = iArr[0];
            GLES20.glGetIntegerv(34965, iArr, 0);
            this.f430d = iArr[0];
            GLES20.glGetIntegerv(34964, iArr, 0);
            this.f431e = iArr[0];
            boolean zGlIsEnabled = GLES20.glIsEnabled(3042);
            this.f432f = zGlIsEnabled;
            if (zGlIsEnabled) {
                GLES20.glDisable(3042);
            }
            boolean zGlIsEnabled2 = GLES20.glIsEnabled(2884);
            this.f433g = zGlIsEnabled2;
            if (zGlIsEnabled2) {
                GLES20.glDisable(2884);
            }
            boolean zGlIsEnabled3 = GLES20.glIsEnabled(2929);
            this.f434h = zGlIsEnabled3;
            if (zGlIsEnabled3) {
                GLES20.glDisable(2929);
            }
            GLES20.glGetIntegerv(2932, iArr, 0);
            int i2 = iArr[0];
            this.f435i = i2;
            if (i2 != 513) {
                GLES20.glDepthFunc(InputDeviceCompat.SOURCE_DPAD);
            }
            if (i > 0) {
                GLES20.glBindTexture(3553, i);
            }
            if (z) {
                GLES20.glGetTexParameteriv(3553, 10240, iArr, 0);
                int i3 = iArr[0];
                this.f436j = i3;
                if (i3 != 9728) {
                    GLES20.glTexParameteri(3553, 10240, 9728);
                }
                GLES20.glGetTexParameteriv(3553, 10241, iArr, 0);
                int i4 = iArr[0];
                this.f437k = i4;
                if (i4 != 9728) {
                    GLES20.glTexParameteri(3553, 10241, 9728);
                }
                GLES20.glGetTexParameteriv(3553, 10242, iArr, 0);
                int i5 = iArr[0];
                this.f438l = i5;
                if (i5 != 33071) {
                    GLES20.glTexParameteri(3553, 10242, 33071);
                }
                GLES20.glGetTexParameteriv(3553, 10243, iArr, 0);
                int i6 = iArr[0];
                this.f439m = i6;
                if (i6 != 33071) {
                    GLES20.glTexParameteri(3553, 10243, 33071);
                }
            }
            GLES20.glGetIntegerv(36006, iArr, 0);
            this.f440n = iArr[0];
            GLES20.glGetIntegerv(2978, this.f441o, 0);
        }

        /* JADX INFO: renamed from: a */
        void m344a(boolean z, boolean z2) {
            if (z2) {
                GLES20.glBindFramebuffer(36160, this.f440n);
                GLES20.glClear(16640);
            }
            int[] iArr = this.f441o;
            GLES20.glViewport(iArr[0], iArr[1], iArr[2], iArr[3]);
            if (z) {
                int i = this.f436j;
                if (i != 9728) {
                    GLES20.glTexParameteri(3553, 10240, i);
                }
                int i2 = this.f437k;
                if (i2 != 9728) {
                    GLES20.glTexParameteri(3553, 10241, i2);
                }
                int i3 = this.f438l;
                if (i3 != 33071) {
                    GLES20.glTexParameteri(3553, 10242, i3);
                }
                int i4 = this.f439m;
                if (i4 != 33071) {
                    GLES20.glTexParameteri(3553, 10243, i4);
                }
            }
            int i5 = this.f435i;
            if (i5 != 513) {
                GLES20.glDepthFunc(i5);
            }
            if (this.f434h) {
                GLES20.glEnable(2929);
            }
            if (this.f433g) {
                GLES20.glEnable(2884);
            }
            if (this.f432f) {
                GLES20.glEnable(3042);
            }
            GLES20.glUseProgram(this.f429c);
            GLES20.glBindBuffer(34963, this.f430d);
            GLES20.glBindBuffer(34962, this.f431e);
            GLES20.glBindTexture(3553, this.f428b);
            int i6 = this.f427a;
            if (i6 != 33984) {
                GLES20.glActiveTexture(i6);
            }
            C0390s.m331c("restoreParams");
        }
    }

    C0390s() {
    }

    @SuppressLint({"InlinedApi"})
    /* JADX INFO: renamed from: a */
    private static int m315a() {
        return 35056;
    }

    /* JADX INFO: renamed from: a */
    private int m316a(int i, int i2) {
        int iMax = Math.max(i, i2);
        int i3 = i * i2;
        int i4 = 128;
        while (i4 < iMax && i4 > 0 && i4 * i4 <= i3) {
            i4 <<= 1;
        }
        int i5 = i4 >> 1;
        if (i5 > 512) {
            return 512;
        }
        return i5;
    }

    /* JADX INFO: renamed from: a */
    private int m317a(int i, String str) {
        int iGlCreateShader = GLES20.glCreateShader(i);
        if (iGlCreateShader == 0) {
            return iGlCreateShader;
        }
        GLES20.glShaderSource(iGlCreateShader, str);
        GLES20.glCompileShader(iGlCreateShader);
        int[] iArr = new int[1];
        GLES20.glGetShaderiv(iGlCreateShader, 35713, iArr, 0);
        if (iArr[0] != 0) {
            return iGlCreateShader;
        }
        GLES20.glDeleteShader(iGlCreateShader);
        return 0;
    }

    /* JADX INFO: renamed from: a */
    private int m318a(String str, String str2) {
        int iM317a;
        int iM317a2 = m317a(35633, str);
        if (iM317a2 == 0 || (iM317a = m317a(35632, str2)) == 0) {
            return 0;
        }
        int iGlCreateProgram = GLES20.glCreateProgram();
        if (iGlCreateProgram != 0) {
            GLES20.glAttachShader(iGlCreateProgram, iM317a2);
            m331c("glAttachShader");
            GLES20.glAttachShader(iGlCreateProgram, iM317a);
            m331c("glAttachShader");
            GLES20.glLinkProgram(iGlCreateProgram);
            int[] iArr = new int[1];
            GLES20.glGetProgramiv(iGlCreateProgram, 35714, iArr, 0);
            if (iArr[0] != 1) {
                GLES20.glDeleteShader(iM317a2);
                GLES20.glDeleteShader(iM317a);
                GLES20.glDeleteProgram(iGlCreateProgram);
                return 0;
            }
        }
        return iGlCreateProgram;
    }

    /* JADX INFO: renamed from: a */
    private void m321a(int i, int i2, int i3, int i4, int i5, boolean z, float f, boolean z2) {
        float[] fArr = {-1.0f, -1.0f, 1.0f, -1.0f, -1.0f, 1.0f, 1.0f, 1.0f};
        int i6 = this.f399a;
        int i7 = this.f400b;
        int i8 = this.f401c;
        float f2 = i3;
        float f3 = (i4 / f2) / f;
        float f4 = (i5 / f2) / f;
        float[] fArr2 = new float[8];
        if (z2) {
            fArr2[0] = 0.0f;
            fArr2[1] = f4;
            fArr2[2] = 1.0f;
            fArr2[3] = f4;
            fArr2[4] = 0.0f;
            float f5 = f4 - 1.0f;
            fArr2[5] = f5;
            fArr2[6] = 1.0f;
            fArr2[7] = f5;
        } else {
            fArr2[0] = 0.0f;
            fArr2[1] = 0.0f;
            fArr2[2] = f3;
            fArr2[3] = 0.0f;
            fArr2[4] = 0.0f;
            fArr2[5] = f4;
            fArr2[6] = f3;
            fArr2[7] = f4;
        }
        GLES20.glUseProgram(i2);
        this.f420v.position(0);
        this.f420v.put(fArr).position(0);
        GLES20.glEnableVertexAttribArray(i6);
        GLES20.glVertexAttribPointer(i6, 2, 5126, false, 0, (Buffer) this.f420v);
        this.f421w.position(0);
        this.f421w.put(fArr2).position(0);
        GLES20.glEnableVertexAttribArray(i7);
        GLES20.glVertexAttribPointer(i7, 2, 5126, false, 0, (Buffer) this.f421w);
        GLES20.glActiveTexture(33984);
        GLES20.glBindTexture(3553, i);
        GLES20.glUniform1i(i8, 0);
        GLES20.glDrawArrays(5, 0, 4);
        GLES20.glBindTexture(3553, 0);
    }

    /* JADX INFO: renamed from: a */
    static void m323a(boolean z) {
        m337g().m332d();
        m337g().f419u = z;
    }

    /* JADX INFO: renamed from: b */
    static void m325b(String str) {
        List<String> list = m337g().f422x;
        synchronized (list) {
            list.add(str);
        }
    }

    /* JADX INFO: renamed from: b */
    static boolean m326b() {
        m337g().m330c();
        m331c("beginOnDrawFrame");
        return m337g().f416r && !m337g().f417s;
    }

    /* JADX INFO: renamed from: b */
    private boolean m327b(int i, int i2) {
        int[] iArr = new int[1];
        int iM328c = m328c(i, i2);
        GLES20.glGenFramebuffers(1, iArr, 0);
        int i3 = iArr[0];
        this.f405g = i3;
        GLES20.glBindFramebuffer(36160, i3);
        int i4 = Build.VERSION.SDK_INT;
        int iNewImageTargetTexture = SmartBeatJni.newImageTargetTexture(i, i2, this.f410l, i4 >= 18 ? 1 : 0);
        this.f407i = iNewImageTargetTexture;
        if (iNewImageTargetTexture <= 0) {
            GLES20.glDeleteFramebuffers(1, iArr, 0);
            this.f405g = 0;
            return false;
        }
        GLES20.glBindTexture(3553, iNewImageTargetTexture);
        GLES20.glTexParameteri(3553, 10241, 9728);
        GLES20.glTexParameteri(3553, 10240, 9728);
        GLES20.glFramebufferTexture2D(36160, 36064, 3553, this.f407i, 0);
        int iGlCheckFramebufferStatus = GLES20.glCheckFramebufferStatus(36160);
        if (iGlCheckFramebufferStatus != 36053) {
            C0377f0.m159a(C0377f0.e.ERROR, String.format("failed to init fbo1 : %d", Integer.valueOf(iGlCheckFramebufferStatus)));
            return false;
        }
        GLES20.glGenFramebuffers(1, iArr, 0);
        int i5 = iArr[0];
        this.f404f = i5;
        GLES20.glBindFramebuffer(36160, i5);
        GLES20.glGenRenderbuffers(1, iArr, 0);
        GLES20.glBindRenderbuffer(36161, iArr[0]);
        if (i4 >= 18) {
            GLES20.glRenderbufferStorage(36161, m315a(), iM328c, iM328c);
            if (GLES20.glGetError() != 0) {
                GLES20.glBindRenderbuffer(36161, 0);
                GLES20.glDeleteRenderbuffers(1, iArr, 0);
            } else {
                GLES20.glFramebufferRenderbuffer(36160, 36128, 36161, iArr[0]);
            }
        }
        GLES20.glGenTextures(1, iArr, 0);
        int i6 = iArr[0];
        this.f406h = i6;
        GLES20.glBindTexture(3553, i6);
        GLES20.glTexImage2D(3553, 0, 6408, iM328c, iM328c, 0, 6408, 5121, null);
        GLES20.glTexParameteri(3553, 10241, 9728);
        GLES20.glTexParameteri(3553, 10240, 9728);
        GLES20.glTexParameteri(3553, 10242, 33071);
        GLES20.glTexParameteri(3553, 10243, 33071);
        GLES20.glFramebufferTexture2D(36160, 36064, 3553, this.f406h, 0);
        int iGlCheckFramebufferStatus2 = GLES20.glCheckFramebufferStatus(36160);
        if (iGlCheckFramebufferStatus2 != 36053) {
            C0377f0.m159a(C0377f0.e.ERROR, String.format("failed to init fbo2 : %d", Integer.valueOf(iGlCheckFramebufferStatus2)));
            return false;
        }
        this.f420v = ByteBuffer.allocateDirect(32).order(ByteOrder.nativeOrder()).asFloatBuffer();
        this.f421w = ByteBuffer.allocateDirect(32).order(ByteOrder.nativeOrder()).asFloatBuffer();
        return true;
    }

    /* JADX INFO: renamed from: c */
    private int m328c(int i, int i2) {
        int iMax = Math.max(i, i2);
        int i3 = 256;
        while (i3 < iMax && i3 > 0) {
            i3 <<= 1;
        }
        return i3;
    }

    /* JADX INFO: renamed from: c */
    private void m330c() {
        m339i();
        if (!this.f416r || this.f417s || this.f404f <= 0 || !m341k()) {
            return;
        }
        GLES20.glBindFramebuffer(36160, this.f404f);
        GLES20.glClear(16640);
        this.f403e = true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: c */
    public static void m331c(String str) {
        while (true) {
            int iGlGetError = GLES20.glGetError();
            if (iGlGetError == 0) {
                return;
            } else {
                C0377f0.m159a(C0377f0.e.ERROR, String.format("%s:glErrro %d", str, Integer.valueOf(iGlGetError)));
            }
        }
    }

    /* JADX INFO: renamed from: d */
    private void m332d() {
        m331c("cleanup");
        this.f402d = 0;
        this.f404f = -1;
        this.f405g = 0;
        this.f408j = 0;
        this.f409k = 0;
        Bitmap bitmap = this.f412n;
        if (bitmap != null) {
            bitmap.recycle();
            this.f412n = null;
        }
        Bitmap bitmap2 = this.f413o;
        if (bitmap2 != null) {
            C0377f0.m161a(C0382j.a.EGles, bitmap2);
            this.f413o = null;
        }
        if (this.f414p != null) {
            this.f414p = null;
        }
        this.f418t = System.currentTimeMillis();
        this.f416r = true;
    }

    /* JADX INFO: renamed from: d */
    private boolean m333d(String str) {
        if (str == null) {
            return false;
        }
        synchronized (this.f422x) {
            Iterator<String> it = this.f422x.iterator();
            while (it.hasNext()) {
                if (it.next().equals(str)) {
                    C0377f0.m159a(C0377f0.e.DEBUG, String.format("this model(%s) is allowd by custmer whitelist", str));
                    return true;
                }
            }
            return false;
        }
    }

    /* JADX INFO: renamed from: e */
    static void m334e() {
        m337g().m336f();
        m331c("endOnDrawFrame");
    }

    /* JADX INFO: renamed from: e */
    static boolean m335e(String str) {
        if (str == null || str.length() <= 0) {
            return false;
        }
        if (C0384l.m274a(str)) {
            return true;
        }
        return m337g().m333d(str);
    }

    /* JADX INFO: renamed from: f */
    private void m336f() {
        if (this.f416r && !this.f417s && this.f403e) {
            int[] iArr = new int[1];
            GLES20.glGetIntegerv(36006, iArr, 0);
            if (iArr[0] == this.f404f) {
                int iM328c = m328c(this.f408j, this.f409k);
                b bVar = new b();
                bVar.m343a(this.f406h, true);
                GLES20.glBindFramebuffer(36160, this.f405g);
                GLES20.glClear(16640);
                int i = this.f410l;
                GLES20.glViewport(0, 0, i, i);
                m321a(this.f406h, this.f402d, iM328c, this.f408j, this.f409k, false, 1.0f, true);
                bVar.m344a(true, false);
                Thread thread = new Thread(new a().m342a(this.f411m));
                this.f415q = thread;
                thread.start();
                b bVar2 = new b();
                bVar2.m343a(this.f406h, true);
                GLES20.glBindFramebuffer(36160, 0);
                GLES20.glClear(16640);
                GLES20.glViewport(0, 0, this.f408j, this.f409k);
                m321a(this.f406h, this.f402d, iM328c, this.f408j, this.f409k, false, 1.0f, false);
                bVar2.m344a(true, false);
            }
            this.f403e = false;
        }
    }

    /* JADX INFO: renamed from: g */
    private static C0390s m337g() {
        if (f398C == null) {
            synchronized (C0390s.class) {
                if (f398C == null) {
                    f398C = new C0390s();
                }
            }
        }
        return f398C;
    }

    /* JADX INFO: renamed from: h */
    private boolean m338h() {
        C0377f0.e eVar;
        String str;
        int iM318a = m318a("attribute vec2 aPosition;\nattribute vec2 aTextureCoord;\nvarying vec2 vTextureCoord;\nvoid main() {\n  gl_Position = vec4(aPosition, 0.0, 1.0);\n  vTextureCoord = aTextureCoord;\n}\n", "precision mediump float;\nvarying vec2 vTextureCoord;\nuniform sampler2D sTexture;\nvoid main() {\n  gl_FragColor = texture2D(sTexture, vTextureCoord);\n}\n");
        this.f402d = iM318a;
        this.f399a = GLES20.glGetAttribLocation(iM318a, "aPosition");
        m331c("glGetAttribLocation aPosition");
        if (this.f399a == -1) {
            eVar = C0377f0.e.ERROR;
            str = "Could not get attrib location for aPosition";
        } else {
            this.f400b = GLES20.glGetAttribLocation(this.f402d, "aTextureCoord");
            m331c("glGetAttribLocation aTextureCoord");
            if (this.f400b == -1) {
                eVar = C0377f0.e.ERROR;
                str = "Could not get attrib location for aTextureCoord";
            } else {
                this.f401c = GLES20.glGetUniformLocation(this.f402d, "sTexture");
                m331c("glGetAttribLocation sTexture");
                if (this.f401c != -1) {
                    return true;
                }
                eVar = C0377f0.e.ERROR;
                str = "Could not get attrib location for sTexture";
            }
        }
        C0377f0.m159a(eVar, str);
        return false;
    }

    /* JADX INFO: renamed from: i */
    private void m339i() {
        if (this.f416r && this.f404f <= 0) {
            EGL10 egl10 = (EGL10) EGLContext.getEGL();
            boolean z = !C0377f0.m191g();
            this.f417s = z;
            if (z) {
                return;
            }
            int i = Build.VERSION.SDK_INT;
            if (i < 14) {
                C0377f0.m159a(C0377f0.e.DEBUG, "Not support ScreenCapture(GLES) (supports from Android 4.0)");
                this.f416r = false;
                return;
            }
            int i2 = C0382j.f199G;
            if (i2 < 2) {
                if (i2 == 0) {
                    C0377f0.m159a(C0377f0.e.WARN, "OpenGLES version may not be set. Please set version!");
                }
                C0377f0.m159a(C0377f0.e.DEBUG, "Not support ScreenCapture(GLES) (supports from ES2.0)");
                this.f416r = false;
                return;
            }
            if (!m340j()) {
                C0377f0.m159a(C0377f0.e.DEBUG, String.format("Not supported ScreenCapture(GLES) (NDK load failed arch=%s)", C0377f0.m148a(0)));
                this.f416r = false;
                return;
            }
            String str = Build.MODEL;
            if (str == null || str.length() <= 0) {
                C0377f0.m159a(C0377f0.e.DEBUG, "Not supported ScreenCapture(GLES) (model name is missing)");
                this.f416r = false;
                return;
            }
            if (!C0384l.m274a(str) && !m333d(str)) {
                this.f416r = false;
                C0377f0.m159a(C0377f0.e.DEBUG, String.format("Not support ScreenCapture(GLES) (unsupport model:%s)", str));
                return;
            }
            if (this.f419u && i < 18) {
                C0377f0.m159a(C0377f0.e.INFO, "Android version must be JBMR2 or more for screen capture with Stencil Buffer.");
                this.f416r = false;
                return;
            }
            EGLDisplay eGLDisplayEglGetCurrentDisplay = egl10.eglGetCurrentDisplay();
            EGLSurface eGLSurfaceEglGetCurrentSurface = egl10.eglGetCurrentSurface(12377);
            int[] iArr = new int[1];
            egl10.eglQuerySurface(eGLDisplayEglGetCurrentDisplay, eGLSurfaceEglGetCurrentSurface, 12375, iArr);
            this.f408j = iArr[0];
            egl10.eglQuerySurface(eGLDisplayEglGetCurrentDisplay, eGLSurfaceEglGetCurrentSurface, 12374, iArr);
            int i3 = iArr[0];
            this.f409k = i3;
            if (this.f408j <= 0 || i3 <= 0) {
                if (i >= 17) {
                    Point pointM348a = C0393v.m348a();
                    this.f408j = pointM348a.x;
                    this.f409k = pointM348a.y;
                }
                if (this.f408j <= 0 || this.f409k <= 0) {
                    this.f416r = false;
                    return;
                }
            }
            this.f410l = m316a(this.f408j, this.f409k);
            C0382j.f220a0 = GLES20.glGetString(7936);
            C0382j.f222b0 = GLES20.glGetString(7937);
            C0382j.f224c0 = GLES20.glGetString(7938);
            b bVar = new b();
            bVar.m343a(0, true);
            this.f416r = m327b(this.f408j, this.f409k);
            bVar.m344a(true, true);
            if (!this.f416r) {
                C0377f0.m159a(C0377f0.e.DEBUG, "Not support ScreenCapture(GLES) (failed to alloc memory)");
                m332d();
                this.f416r = false;
            } else if (!m338h()) {
                C0377f0.m159a(C0377f0.e.ERROR, "failed to init");
                m332d();
                this.f416r = false;
            } else {
                int textureLongerSideLength = SmartBeatJni.getTextureLongerSideLength();
                this.f411m = ByteBuffer.allocateDirect(textureLongerSideLength * textureLongerSideLength * 4);
                this.f412n = Bitmap.createBitmap(textureLongerSideLength, textureLongerSideLength, Bitmap.Config.ARGB_8888);
                int iM328c = m328c(this.f408j, this.f409k) / this.f410l;
                this.f413o = Bitmap.createBitmap(this.f408j / iM328c, this.f409k / iM328c, Bitmap.Config.ARGB_8888);
                this.f414p = new Canvas(this.f413o);
            }
        }
    }

    /* JADX INFO: renamed from: j */
    private boolean m340j() {
        return C0382j.f198F;
    }

    /* JADX INFO: renamed from: k */
    private boolean m341k() {
        if (this.f415q != null || this.f403e) {
            return false;
        }
        long jCurrentTimeMillis = System.currentTimeMillis();
        if (jCurrentTimeMillis - this.f418t < 1000 || C0382j.f218Z) {
            return false;
        }
        this.f418t = jCurrentTimeMillis;
        return true;
    }
}

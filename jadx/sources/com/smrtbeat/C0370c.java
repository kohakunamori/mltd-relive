package com.smrtbeat;

import androidx.core.view.MotionEventCompat;
import com.google.android.gms.games.Notifications;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FilterInputStream;
import java.io.FilterOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.ObjectStreamClass;
import java.io.OutputStream;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

/* JADX INFO: renamed from: com.smrtbeat.c */
/* JADX INFO: loaded from: classes.dex */
class C0370c {

    /* JADX INFO: renamed from: a */
    static final int f82a = 0;

    /* JADX INFO: renamed from: b */
    static final int f83b = 1;

    /* JADX INFO: renamed from: c */
    static final int f84c = 0;

    /* JADX INFO: renamed from: d */
    static final int f85d = 2;

    /* JADX INFO: renamed from: e */
    static final int f86e = 4;

    /* JADX INFO: renamed from: f */
    static final int f87f = 8;

    /* JADX INFO: renamed from: g */
    static final int f88g = 16;

    /* JADX INFO: renamed from: h */
    static final int f89h = 32;

    /* JADX INFO: renamed from: i */
    private static final int f90i = 76;

    /* JADX INFO: renamed from: l */
    private static final String f93l = "US-ASCII";

    /* JADX INFO: renamed from: u */
    static final /* synthetic */ boolean f102u = !C0370c.class.desiredAssertionStatus();

    /* JADX INFO: renamed from: o */
    private static final byte[] f96o = {65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 43, 47};

    /* JADX INFO: renamed from: m */
    private static final byte f94m = -5;

    /* JADX INFO: renamed from: j */
    private static final byte f91j = 61;

    /* JADX INFO: renamed from: n */
    private static final byte f95n = -1;

    /* JADX INFO: renamed from: k */
    private static final byte f92k = 10;

    /* JADX INFO: renamed from: p */
    private static final byte[] f97p = {-9, -9, -9, -9, -9, -9, -9, -9, -9, f94m, f94m, -9, -9, f94m, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, f94m, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, 62, -9, -9, -9, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, f91j, -9, -9, -9, f95n, -9, -9, -9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, f92k, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -9, -9, -9, -9, -9, -9, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9};

    /* JADX INFO: renamed from: q */
    private static final byte[] f98q = {65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 45, 95};

    /* JADX INFO: renamed from: r */
    private static final byte[] f99r = {-9, -9, -9, -9, -9, -9, -9, -9, -9, f94m, f94m, -9, -9, f94m, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, f94m, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, 62, -9, -9, 52, 53, 54, 55, 56, 57, 58, 59, 60, f91j, -9, -9, -9, f95n, -9, -9, -9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, f92k, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -9, -9, -9, -9, 63, -9, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9};

    /* JADX INFO: renamed from: s */
    private static final byte[] f100s = {45, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 95, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122};

    /* JADX INFO: renamed from: t */
    private static final byte[] f101t = {-9, -9, -9, -9, -9, -9, -9, -9, -9, f94m, f94m, -9, -9, f94m, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, f94m, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, 0, -9, -9, 1, 2, 3, 4, 5, 6, 7, 8, 9, f92k, -9, -9, -9, f95n, -9, -9, -9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, -9, -9, -9, -9, 37, -9, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, f91j, 62, 63, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9, -9};

    /* JADX INFO: renamed from: com.smrtbeat.c$a */
    static class a extends ObjectInputStream {

        /* JADX INFO: renamed from: a */
        final /* synthetic */ ClassLoader f103a;

        /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
        a(InputStream inputStream, ClassLoader classLoader) {
            super(inputStream);
            this.f103a = classLoader;
        }

        @Override // java.io.ObjectInputStream
        public Class<?> resolveClass(ObjectStreamClass objectStreamClass) throws ClassNotFoundException, IOException {
            Class<?> cls = Class.forName(objectStreamClass.getName(), false, this.f103a);
            return cls == null ? super.resolveClass(objectStreamClass) : cls;
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.c$b */
    static class b extends FilterInputStream {

        /* JADX INFO: renamed from: a */
        private boolean f104a;

        /* JADX INFO: renamed from: b */
        private int f105b;

        /* JADX INFO: renamed from: c */
        private byte[] f106c;

        /* JADX INFO: renamed from: d */
        private int f107d;

        /* JADX INFO: renamed from: e */
        private int f108e;

        /* JADX INFO: renamed from: f */
        private int f109f;

        /* JADX INFO: renamed from: g */
        private boolean f110g;

        /* JADX INFO: renamed from: h */
        private int f111h;

        /* JADX INFO: renamed from: i */
        private byte[] f112i;

        b(InputStream inputStream) {
            this(inputStream, 0);
        }

        b(InputStream inputStream, int i) {
            super(inputStream);
            this.f111h = i;
            this.f110g = (i & 8) > 0;
            boolean z = (i & 1) > 0;
            this.f104a = z;
            int i2 = z ? 4 : 3;
            this.f107d = i2;
            this.f106c = new byte[i2];
            this.f105b = -1;
            this.f109f = 0;
            this.f112i = C0370c.m122c(i);
        }

        @Override // java.io.FilterInputStream, java.io.InputStream
        public int read() throws IOException {
            int i;
            if (this.f105b < 0) {
                if (this.f104a) {
                    byte[] bArr = new byte[3];
                    int i2 = 0;
                    for (int i3 = 0; i3 < 3; i3++) {
                        int i4 = ((FilterInputStream) this).in.read();
                        if (i4 < 0) {
                            break;
                        }
                        bArr[i3] = (byte) i4;
                        i2++;
                    }
                    if (i2 <= 0) {
                        return -1;
                    }
                    C0370c.m118b(bArr, 0, i2, this.f106c, 0, this.f111h);
                    this.f105b = 0;
                    this.f108e = 4;
                } else {
                    byte[] bArr2 = new byte[4];
                    int i5 = 0;
                    while (i5 < 4) {
                        do {
                            i = ((FilterInputStream) this).in.read();
                            if (i < 0) {
                                break;
                            }
                        } while (this.f112i[i & Notifications.NOTIFICATION_TYPES_ALL] <= -5);
                        if (i < 0) {
                            break;
                        }
                        bArr2[i5] = (byte) i;
                        i5++;
                    }
                    if (i5 != 4) {
                        if (i5 == 0) {
                            return -1;
                        }
                        throw new IOException("Improperly padded Base64 input.");
                    }
                    this.f108e = C0370c.m112b(bArr2, 0, this.f106c, 0, this.f111h);
                    this.f105b = 0;
                }
            }
            int i6 = this.f105b;
            if (i6 < 0) {
                throw new IOException("Error in Base64 code reading stream.");
            }
            if (i6 >= this.f108e) {
                return -1;
            }
            if (this.f104a && this.f110g && this.f109f >= C0370c.f90i) {
                this.f109f = 0;
                return 10;
            }
            this.f109f++;
            byte[] bArr3 = this.f106c;
            int i7 = i6 + 1;
            this.f105b = i7;
            byte b = bArr3[i6];
            if (i7 >= this.f107d) {
                this.f105b = -1;
            }
            return b & C0370c.f95n;
        }

        @Override // java.io.FilterInputStream, java.io.InputStream
        public int read(byte[] bArr, int i, int i2) throws IOException {
            int i3 = 0;
            while (i3 < i2) {
                int i4 = read();
                if (i4 >= 0) {
                    bArr[i + i3] = (byte) i4;
                    i3++;
                } else if (i3 == 0) {
                    return -1;
                }
            }
            return i3;
        }
    }

    /* JADX INFO: renamed from: com.smrtbeat.c$c */
    static class c extends FilterOutputStream {

        /* JADX INFO: renamed from: a */
        private boolean f113a;

        /* JADX INFO: renamed from: b */
        private int f114b;

        /* JADX INFO: renamed from: c */
        private byte[] f115c;

        /* JADX INFO: renamed from: d */
        private int f116d;

        /* JADX INFO: renamed from: e */
        private int f117e;

        /* JADX INFO: renamed from: f */
        private boolean f118f;

        /* JADX INFO: renamed from: g */
        private byte[] f119g;

        /* JADX INFO: renamed from: h */
        private boolean f120h;

        /* JADX INFO: renamed from: i */
        private int f121i;

        /* JADX INFO: renamed from: j */
        private byte[] f122j;

        c(OutputStream outputStream) {
            this(outputStream, 1);
        }

        c(OutputStream outputStream, int i) {
            super(outputStream);
            this.f118f = (i & 8) != 0;
            boolean z = (i & 1) != 0;
            this.f113a = z;
            int i2 = z ? 3 : 4;
            this.f116d = i2;
            this.f115c = new byte[i2];
            this.f114b = 0;
            this.f117e = 0;
            this.f120h = false;
            this.f119g = new byte[4];
            this.f121i = i;
            this.f122j = C0370c.m122c(i);
        }

        /* JADX INFO: renamed from: a */
        void m126a() throws IOException {
            int i = this.f114b;
            if (i > 0) {
                if (!this.f113a) {
                    throw new IOException("Base64 input not properly padded.");
                }
                ((FilterOutputStream) this).out.write(C0370c.m119b(this.f119g, this.f115c, i, this.f121i));
                this.f114b = 0;
            }
        }

        /* JADX INFO: renamed from: b */
        void m127b() {
            this.f120h = false;
        }

        /* JADX INFO: renamed from: c */
        void m128c() throws IOException {
            m126a();
            this.f120h = true;
        }

        @Override // java.io.FilterOutputStream, java.io.OutputStream, java.io.Closeable, java.lang.AutoCloseable
        public void close() throws IOException {
            m126a();
            super.close();
            this.f115c = null;
            ((FilterOutputStream) this).out = null;
        }

        @Override // java.io.FilterOutputStream, java.io.OutputStream
        public void write(int i) throws IOException {
            if (this.f120h) {
                ((FilterOutputStream) this).out.write(i);
                return;
            }
            if (this.f113a) {
                byte[] bArr = this.f115c;
                int i2 = this.f114b;
                int i3 = i2 + 1;
                this.f114b = i3;
                bArr[i2] = (byte) i;
                int i4 = this.f116d;
                if (i3 < i4) {
                    return;
                }
                ((FilterOutputStream) this).out.write(C0370c.m119b(this.f119g, bArr, i4, this.f121i));
                int i5 = this.f117e + 4;
                this.f117e = i5;
                if (this.f118f && i5 >= C0370c.f90i) {
                    ((FilterOutputStream) this).out.write(10);
                    this.f117e = 0;
                }
            } else {
                byte[] bArr2 = this.f122j;
                int i6 = i & Notifications.NOTIFICATION_TYPES_ALL;
                if (bArr2[i6] <= -5) {
                    if (bArr2[i6] != -5) {
                        throw new IOException("Invalid character in Base64 data.");
                    }
                    return;
                }
                byte[] bArr3 = this.f115c;
                int i7 = this.f114b;
                int i8 = i7 + 1;
                this.f114b = i8;
                bArr3[i7] = (byte) i;
                if (i8 < this.f116d) {
                    return;
                }
                ((FilterOutputStream) this).out.write(this.f119g, 0, C0370c.m112b(bArr3, 0, this.f119g, 0, this.f121i));
            }
            this.f114b = 0;
        }

        @Override // java.io.FilterOutputStream, java.io.OutputStream
        public void write(byte[] bArr, int i, int i2) throws IOException {
            if (this.f120h) {
                ((FilterOutputStream) this).out.write(bArr, i, i2);
                return;
            }
            for (int i3 = 0; i3 < i2; i3++) {
                write(bArr[i + i3]);
            }
        }
    }

    private C0370c() {
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX INFO: renamed from: a */
    static Object m96a(String str, int i, ClassLoader classLoader) throws Throwable {
        byte[] bArrM107a = m107a(str, i);
        ObjectInputStream objectInputStream = null;
        Object[] objArr = 0;
        try {
            try {
                ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bArrM107a);
                try {
                    ObjectInputStream objectInputStream2 = classLoader == null ? new ObjectInputStream(byteArrayInputStream) : new a(byteArrayInputStream, classLoader);
                    Object object = objectInputStream2.readObject();
                    try {
                        byteArrayInputStream.close();
                    } catch (Exception unused) {
                    }
                    try {
                        objectInputStream2.close();
                    } catch (Exception unused2) {
                    }
                    return object;
                } catch (IOException e) {
                    throw e;
                } catch (ClassNotFoundException e2) {
                    throw e2;
                }
            } catch (Throwable th) {
                th = th;
                try {
                    (objArr == true ? 1 : 0).close();
                } catch (Exception unused3) {
                }
                try {
                    objectInputStream.close();
                    throw th;
                } catch (Exception unused4) {
                    throw th;
                }
            }
        } catch (IOException e3) {
            throw e3;
        } catch (ClassNotFoundException e4) {
            throw e4;
        } catch (Throwable th2) {
            th = th2;
            (objArr == true ? 1 : 0).close();
            objectInputStream.close();
            throw th;
        }
    }

    /* JADX INFO: renamed from: a */
    static String m97a(Serializable serializable) throws IOException {
        return m98a(serializable, 0);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v1 */
    /* JADX WARN: Type inference failed for: r0v11 */
    /* JADX WARN: Type inference failed for: r0v14 */
    /* JADX WARN: Type inference failed for: r0v16 */
    /* JADX WARN: Type inference failed for: r0v21 */
    /* JADX WARN: Type inference failed for: r0v3 */
    /* JADX WARN: Type inference failed for: r0v9 */
    /* JADX WARN: Type inference failed for: r4v0 */
    /* JADX WARN: Type inference failed for: r6v11 */
    /* JADX WARN: Type inference failed for: r6v14 */
    /* JADX WARN: Type inference failed for: r6v15 */
    /* JADX WARN: Type inference failed for: r6v17, types: [java.util.zip.GZIPOutputStream] */
    /* JADX WARN: Type inference failed for: r6v2 */
    /* JADX WARN: Type inference failed for: r6v21, types: [java.io.OutputStream, java.util.zip.GZIPOutputStream] */
    /* JADX WARN: Type inference failed for: r6v22 */
    /* JADX WARN: Type inference failed for: r6v5, types: [java.util.zip.GZIPOutputStream] */
    /* JADX WARN: Type inference failed for: r6v7 */
    /* JADX WARN: Type inference failed for: r6v8 */
    /* JADX INFO: renamed from: a */
    static String m98a(Serializable serializable, int i) throws Throwable {
        ?? gZIPOutputStream;
        ByteArrayOutputStream byteArrayOutputStream;
        c cVar;
        ObjectOutputStream objectOutputStream;
        if (serializable == null) {
            throw new NullPointerException("Cannot serialize a null object.");
        }
        ObjectOutputStream objectOutputStream2 = null;
        objectOutputStream2 = null;
        objectOutputStream2 = null;
        objectOutputStream2 = null;
        objectOutputStream2 = null;
         = 0;
        objectOutputStream2 = null;
        ?? r0 = 0;
        try {
            byteArrayOutputStream = new ByteArrayOutputStream();
            try {
                cVar = new c(byteArrayOutputStream, i | 1);
                try {
                    if ((i & 2) != 0) {
                        gZIPOutputStream = new GZIPOutputStream(cVar);
                        try {
                            try {
                                objectOutputStream2 = new ObjectOutputStream(gZIPOutputStream);
                                gZIPOutputStream = gZIPOutputStream;
                            } catch (IOException e) {
                                e = e;
                                ObjectOutputStream objectOutputStream3 = objectOutputStream2;
                                r0 = gZIPOutputStream;
                                objectOutputStream = objectOutputStream3;
                                try {
                                    throw e;
                                } catch (Throwable th) {
                                    th = th;
                                    ?? r4 = r0;
                                    objectOutputStream2 = objectOutputStream;
                                    gZIPOutputStream = r4;
                                    try {
                                        objectOutputStream2.close();
                                    } catch (Exception unused) {
                                    }
                                    try {
                                        gZIPOutputStream.close();
                                    } catch (Exception unused2) {
                                    }
                                    try {
                                        cVar.close();
                                    } catch (Exception unused3) {
                                    }
                                    try {
                                        byteArrayOutputStream.close();
                                        throw th;
                                    } catch (Exception unused4) {
                                        throw th;
                                    }
                                }
                            }
                        } catch (Throwable th2) {
                            th = th2;
                            objectOutputStream2.close();
                            gZIPOutputStream.close();
                            cVar.close();
                            byteArrayOutputStream.close();
                            throw th;
                        }
                    } else {
                        objectOutputStream2 = new ObjectOutputStream(cVar);
                        gZIPOutputStream = 0;
                    }
                    try {
                        objectOutputStream2.writeObject(serializable);
                        try {
                            objectOutputStream2.close();
                        } catch (Exception unused5) {
                        }
                        try {
                            gZIPOutputStream.close();
                        } catch (Exception unused6) {
                        }
                        try {
                            cVar.close();
                        } catch (Exception unused7) {
                        }
                        try {
                            byteArrayOutputStream.close();
                        } catch (Exception unused8) {
                        }
                        try {
                            return new String(byteArrayOutputStream.toByteArray(), f93l);
                        } catch (UnsupportedEncodingException unused9) {
                            return new String(byteArrayOutputStream.toByteArray());
                        }
                    } catch (Throwable th3) {
                        th = th3;
                        ObjectOutputStream objectOutputStream4 = objectOutputStream2;
                        r0 = gZIPOutputStream;
                        objectOutputStream = objectOutputStream4;
                        ?? r5 = r0;
                        objectOutputStream2 = objectOutputStream;
                        gZIPOutputStream = r5;
                        objectOutputStream2.close();
                        gZIPOutputStream.close();
                        cVar.close();
                        byteArrayOutputStream.close();
                        throw th;
                    }
                } catch (IOException e2) {
                    e = e2;
                    objectOutputStream = objectOutputStream2;
                    r0 = objectOutputStream2;
                } catch (Throwable th4) {
                    th = th4;
                    gZIPOutputStream = objectOutputStream2;
                }
            } catch (IOException e3) {
                e = e3;
                objectOutputStream = null;
                cVar = null;
            } catch (Throwable th5) {
                th = th5;
                gZIPOutputStream = 0;
                cVar = null;
            }
        } catch (IOException e4) {
            e = e4;
            objectOutputStream = null;
            byteArrayOutputStream = null;
            cVar = null;
        } catch (Throwable th6) {
            th = th6;
            gZIPOutputStream = 0;
            byteArrayOutputStream = null;
            cVar = null;
        }
    }

    /* JADX INFO: renamed from: a */
    static String m99a(byte[] bArr, int i) throws IOException {
        return m114b(bArr, 0, bArr.length, i);
    }

    /* JADX INFO: renamed from: a */
    static String m100a(byte[] bArr, int i, int i2) throws Throwable {
        String strM114b;
        try {
            strM114b = m114b(bArr, i, i2, 0);
        } catch (IOException unused) {
            strM114b = null;
        }
        if (f102u || strM114b != null) {
            return strM114b;
        }
        throw new AssertionError();
    }

    /* JADX INFO: renamed from: a */
    static void m101a(String str, String str2) throws Throwable {
        byte[] bArrM117b = m117b(str);
        BufferedOutputStream bufferedOutputStream = null;
        try {
            try {
                BufferedOutputStream bufferedOutputStream2 = new BufferedOutputStream(new FileOutputStream(str2));
                try {
                    bufferedOutputStream2.write(bArrM117b);
                    try {
                        bufferedOutputStream2.close();
                    } catch (Exception unused) {
                    }
                } catch (IOException e) {
                } catch (Throwable th) {
                    th = th;
                    bufferedOutputStream = bufferedOutputStream2;
                    try {
                        bufferedOutputStream.close();
                    } catch (Exception unused2) {
                    }
                    throw th;
                }
            } catch (Throwable th2) {
                th = th2;
            }
        } catch (IOException e2) {
            throw e2;
        }
    }

    /* JADX INFO: renamed from: a */
    static void m102a(ByteBuffer byteBuffer, ByteBuffer byteBuffer2) {
        byte[] bArr = new byte[3];
        byte[] bArr2 = new byte[4];
        while (byteBuffer.hasRemaining()) {
            int iMin = Math.min(3, byteBuffer.remaining());
            byteBuffer.get(bArr, 0, iMin);
            m119b(bArr2, bArr, iMin, 0);
            byteBuffer2.put(bArr2);
        }
    }

    /* JADX INFO: renamed from: a */
    static void m103a(ByteBuffer byteBuffer, CharBuffer charBuffer) {
        byte[] bArr = new byte[3];
        byte[] bArr2 = new byte[4];
        while (byteBuffer.hasRemaining()) {
            int iMin = Math.min(3, byteBuffer.remaining());
            byteBuffer.get(bArr, 0, iMin);
            m119b(bArr2, bArr, iMin, 0);
            for (int i = 0; i < 4; i++) {
                charBuffer.put((char) (bArr2[i] & f95n));
            }
        }
    }

    /* JADX INFO: renamed from: a */
    static void m104a(byte[] bArr, String str) throws Throwable {
        if (bArr == null) {
            throw new NullPointerException("Data to encode was null.");
        }
        c cVar = null;
        try {
            try {
                c cVar2 = new c(new FileOutputStream(str), 1);
                try {
                    cVar2.write(bArr);
                    try {
                        cVar2.close();
                    } catch (Exception unused) {
                    }
                } catch (IOException e) {
                } catch (Throwable th) {
                    th = th;
                    cVar = cVar2;
                    try {
                        cVar.close();
                    } catch (Exception unused2) {
                    }
                    throw th;
                }
            } catch (Throwable th2) {
                th = th2;
            }
        } catch (IOException e2) {
            throw e2;
        }
    }

    /* JADX INFO: renamed from: a */
    static byte[] m106a(String str) throws IOException {
        return m107a(str, 0);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v10, types: [java.util.zip.GZIPInputStream] */
    /* JADX WARN: Type inference failed for: r0v11 */
    /* JADX WARN: Type inference failed for: r0v12 */
    /* JADX WARN: Type inference failed for: r0v13 */
    /* JADX WARN: Type inference failed for: r0v14, types: [int] */
    /* JADX WARN: Type inference failed for: r0v17 */
    /* JADX WARN: Type inference failed for: r0v18 */
    /* JADX WARN: Type inference failed for: r0v19 */
    /* JADX WARN: Type inference failed for: r0v20 */
    /* JADX WARN: Type inference failed for: r0v21 */
    /* JADX WARN: Type inference failed for: r0v7 */
    /* JADX WARN: Type inference failed for: r0v8 */
    /* JADX WARN: Type inference failed for: r0v9, types: [java.util.zip.GZIPInputStream] */
    /* JADX WARN: Type inference failed for: r2v1 */
    /* JADX WARN: Type inference failed for: r2v2 */
    /* JADX WARN: Type inference failed for: r2v3 */
    /* JADX WARN: Type inference failed for: r2v4 */
    /* JADX WARN: Type inference failed for: r2v5, types: [java.io.ByteArrayOutputStream] */
    /* JADX WARN: Type inference failed for: r2v6, types: [java.io.ByteArrayOutputStream] */
    /* JADX WARN: Type inference failed for: r2v7 */
    /* JADX WARN: Type inference failed for: r2v8, types: [java.io.ByteArrayOutputStream] */
    /* JADX WARN: Type inference failed for: r3v0, types: [int] */
    /* JADX WARN: Type inference failed for: r3v1 */
    /* JADX WARN: Type inference failed for: r3v2 */
    /* JADX WARN: Type inference failed for: r3v3 */
    /* JADX WARN: Type inference failed for: r3v4, types: [java.io.ByteArrayInputStream] */
    /* JADX WARN: Type inference failed for: r3v5 */
    /* JADX WARN: Type inference failed for: r3v6, types: [java.io.ByteArrayInputStream] */
    /* JADX WARN: Type inference failed for: r3v7 */
    /* JADX WARN: Type inference failed for: r3v8 */
    /* JADX WARN: Type inference failed for: r3v9, types: [java.io.ByteArrayInputStream, java.io.InputStream] */
    /* JADX INFO: renamed from: a */
    static byte[] m107a(String str, int i) throws Throwable {
        byte[] bytes;
        ?? length;
        if (str == null) {
            throw new NullPointerException("Input string was null.");
        }
        try {
            bytes = str.getBytes(f93l);
        } catch (UnsupportedEncodingException unused) {
            bytes = str.getBytes();
        }
        byte[] bArrM109a = m109a(bytes, 0, bytes.length, i);
        boolean z = (i & 4) != 0;
        if (bArrM109a != null && (length = bArrM109a.length) >= 4 && !z) {
            ?? byteArrayOutputStream = 65280;
            if (35615 == ((bArrM109a[0] & f95n) | ((bArrM109a[1] << 8) & MotionEventCompat.ACTION_POINTER_INDEX_MASK))) {
                byte[] bArr = new byte[2048];
                ?? r0 = 0;
                r0 = 0;
                r0 = 0;
                r0 = 0;
                r0 = 0;
                r0 = 0;
                try {
                    byteArrayOutputStream = new ByteArrayOutputStream();
                    try {
                        length = new ByteArrayInputStream(bArrM109a);
                        try {
                            GZIPInputStream gZIPInputStream = new GZIPInputStream(length);
                            while (true) {
                                try {
                                    r0 = gZIPInputStream.read(bArr);
                                    if (r0 < 0) {
                                        break;
                                    }
                                    byteArrayOutputStream.write(bArr, 0, r0);
                                } catch (IOException e) {
                                    e = e;
                                    r0 = gZIPInputStream;
                                    e.printStackTrace();
                                    try {
                                        byteArrayOutputStream.close();
                                    } catch (Exception unused2) {
                                    }
                                    try {
                                        r0.close();
                                    } catch (Exception unused3) {
                                    }
                                } catch (Throwable th) {
                                    th = th;
                                    r0 = gZIPInputStream;
                                    try {
                                        byteArrayOutputStream.close();
                                    } catch (Exception unused4) {
                                    }
                                    try {
                                        r0.close();
                                    } catch (Exception unused5) {
                                    }
                                    try {
                                        length.close();
                                        throw th;
                                    } catch (Exception unused6) {
                                        throw th;
                                    }
                                }
                            }
                            byte[] byteArray = byteArrayOutputStream.toByteArray();
                            try {
                                byteArrayOutputStream.close();
                            } catch (Exception unused7) {
                            }
                            try {
                                gZIPInputStream.close();
                            } catch (Exception unused8) {
                            }
                            bArrM109a = byteArray;
                        } catch (IOException e2) {
                            e = e2;
                        }
                    } catch (IOException e3) {
                        e = e3;
                        length = 0;
                    } catch (Throwable th2) {
                        th = th2;
                        length = 0;
                    }
                } catch (IOException e4) {
                    e = e4;
                    byteArrayOutputStream = 0;
                    length = 0;
                } catch (Throwable th3) {
                    th = th3;
                    byteArrayOutputStream = 0;
                    length = 0;
                }
                try {
                    length.close();
                } catch (Exception unused9) {
                }
            }
        }
        return bArrM109a;
    }

    /* JADX INFO: renamed from: a */
    static byte[] m108a(byte[] bArr) throws IOException {
        return m109a(bArr, 0, bArr.length, 0);
    }

    /* JADX INFO: renamed from: a */
    static byte[] m109a(byte[] bArr, int i, int i2, int i3) throws IOException {
        int i4;
        if (bArr == null) {
            throw new NullPointerException("Cannot decode null source array.");
        }
        if (i < 0 || (i4 = i + i2) > bArr.length) {
            throw new IllegalArgumentException(String.format("Source array with length %d cannot have offset of %d and process %d bytes.", Integer.valueOf(bArr.length), Integer.valueOf(i), Integer.valueOf(i2)));
        }
        if (i2 == 0) {
            return new byte[0];
        }
        if (i2 < 4) {
            throw new IllegalArgumentException("Base64-encoded string must have at least four characters, but length specified was " + i2);
        }
        byte[] bArrM122c = m122c(i3);
        byte[] bArr2 = new byte[(i2 * 3) / 4];
        byte[] bArr3 = new byte[4];
        int i5 = 0;
        int iM112b = 0;
        while (i < i4) {
            byte b2 = bArrM122c[bArr[i] & f95n];
            if (b2 < -5) {
                throw new IOException(String.format("Bad Base64 input character decimal %d in array position %d", Integer.valueOf(bArr[i] & f95n), Integer.valueOf(i)));
            }
            if (b2 >= -1) {
                int i6 = i5 + 1;
                bArr3[i5] = bArr[i];
                if (i6 > 3) {
                    iM112b += m112b(bArr3, 0, bArr2, iM112b, i3);
                    if (bArr[i] == 61) {
                        break;
                    }
                    i5 = 0;
                } else {
                    i5 = i6;
                }
            }
            i++;
        }
        byte[] bArr4 = new byte[iM112b];
        System.arraycopy(bArr2, 0, bArr4, 0, iM112b);
        return bArr4;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: b */
    public static int m112b(byte[] bArr, int i, byte[] bArr2, int i2, int i3) {
        int i4;
        int i5;
        if (bArr == null) {
            throw new NullPointerException("Source array was null.");
        }
        if (bArr2 == null) {
            throw new NullPointerException("Destination array was null.");
        }
        if (i < 0 || (i4 = i + 3) >= bArr.length) {
            throw new IllegalArgumentException(String.format("Source array with length %d cannot have offset of %d and still process four bytes.", Integer.valueOf(bArr.length), Integer.valueOf(i)));
        }
        if (i2 < 0 || (i5 = i2 + 2) >= bArr2.length) {
            throw new IllegalArgumentException(String.format("Destination array with length %d cannot have offset of %d and still store three bytes.", Integer.valueOf(bArr2.length), Integer.valueOf(i2)));
        }
        byte[] bArrM122c = m122c(i3);
        int i6 = i + 2;
        if (bArr[i6] == 61) {
            bArr2[i2] = (byte) ((((bArrM122c[bArr[i + 1]] & f95n) << 12) | ((bArrM122c[bArr[i]] & f95n) << 18)) >>> 16);
            return 1;
        }
        if (bArr[i4] == 61) {
            int i7 = ((bArrM122c[bArr[i6]] & f95n) << 6) | ((bArrM122c[bArr[i + 1]] & f95n) << 12) | ((bArrM122c[bArr[i]] & f95n) << 18);
            bArr2[i2] = (byte) (i7 >>> 16);
            bArr2[i2 + 1] = (byte) (i7 >>> 8);
            return 2;
        }
        int i8 = (bArrM122c[bArr[i4]] & f95n) | ((bArrM122c[bArr[i + 1]] & f95n) << 12) | ((bArrM122c[bArr[i]] & f95n) << 18) | ((bArrM122c[bArr[i6]] & f95n) << 6);
        bArr2[i2] = (byte) (i8 >> 16);
        bArr2[i2 + 1] = (byte) (i8 >> 8);
        bArr2[i5] = (byte) i8;
        return 3;
    }

    /* JADX INFO: renamed from: b */
    static String m113b(byte[] bArr) throws Throwable {
        String strM114b;
        try {
            strM114b = m114b(bArr, 0, bArr.length, 0);
        } catch (IOException unused) {
            strM114b = null;
        }
        if (f102u || strM114b != null) {
            return strM114b;
        }
        throw new AssertionError();
    }

    /* JADX INFO: renamed from: b */
    static String m114b(byte[] bArr, int i, int i2, int i3) throws Throwable {
        byte[] bArrM124c = m124c(bArr, i, i2, i3);
        try {
            return new String(bArrM124c, f93l);
        } catch (UnsupportedEncodingException unused) {
            return new String(bArrM124c);
        }
    }

    /* JADX INFO: renamed from: b */
    static void m115b(String str, String str2) throws Throwable {
        c cVar = null;
        try {
            try {
                c cVar2 = new c(new FileOutputStream(str2), 0);
                try {
                    cVar2.write(str.getBytes(f93l));
                    try {
                        cVar2.close();
                    } catch (Exception unused) {
                    }
                } catch (IOException e) {
                } catch (Throwable th) {
                    th = th;
                    cVar = cVar2;
                    try {
                        cVar.close();
                    } catch (Exception unused2) {
                    }
                    throw th;
                }
            } catch (IOException e2) {
                throw e2;
            }
        } catch (Throwable th2) {
            th = th2;
        }
    }

    /* JADX INFO: renamed from: b */
    private static final byte[] m116b(int i) {
        if ((i & 16) == 16) {
            return f98q;
        }
        return (i & 32) == 32 ? f100s : f96o;
    }

    /* JADX INFO: renamed from: b */
    static byte[] m117b(String str) throws Throwable {
        b bVar = null;
        try {
            try {
                File file = new File(str);
                if (file.length() > 2147483647L) {
                    throw new IOException("File is too big for this convenience method (" + file.length() + " bytes).");
                }
                byte[] bArr = new byte[(int) file.length()];
                b bVar2 = new b(new BufferedInputStream(new FileInputStream(file)), 0);
                int i = 0;
                while (true) {
                    try {
                        int i2 = bVar2.read(bArr, i, 4096);
                        if (i2 < 0) {
                            break;
                        }
                        i += i2;
                    } catch (IOException e) {
                        throw e;
                    } catch (Throwable th) {
                        th = th;
                        bVar = bVar2;
                        try {
                            bVar.close();
                        } catch (Exception unused) {
                        }
                        throw th;
                    }
                }
                byte[] bArr2 = new byte[i];
                System.arraycopy(bArr, 0, bArr2, 0, i);
                try {
                    bVar2.close();
                } catch (Exception unused2) {
                }
                return bArr2;
            } catch (Throwable th2) {
                th = th2;
            }
        } catch (IOException e2) {
            throw e2;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: b */
    public static byte[] m118b(byte[] bArr, int i, int i2, byte[] bArr2, int i3, int i4) {
        byte[] bArrM116b = m116b(i4);
        int i5 = (i2 > 0 ? (bArr[i] << 24) >>> 8 : 0) | (i2 > 1 ? (bArr[i + 1] << 24) >>> 16 : 0) | (i2 > 2 ? (bArr[i + 2] << 24) >>> 24 : 0);
        if (i2 == 1) {
            bArr2[i3] = bArrM116b[i5 >>> 18];
            bArr2[i3 + 1] = bArrM116b[(i5 >>> 12) & 63];
            bArr2[i3 + 2] = f91j;
            bArr2[i3 + 3] = f91j;
            return bArr2;
        }
        if (i2 == 2) {
            bArr2[i3] = bArrM116b[i5 >>> 18];
            bArr2[i3 + 1] = bArrM116b[(i5 >>> 12) & 63];
            bArr2[i3 + 2] = bArrM116b[(i5 >>> 6) & 63];
            bArr2[i3 + 3] = f91j;
            return bArr2;
        }
        if (i2 != 3) {
            return bArr2;
        }
        bArr2[i3] = bArrM116b[i5 >>> 18];
        bArr2[i3 + 1] = bArrM116b[(i5 >>> 12) & 63];
        bArr2[i3 + 2] = bArrM116b[(i5 >>> 6) & 63];
        bArr2[i3 + 3] = bArrM116b[i5 & 63];
        return bArr2;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: b */
    public static byte[] m119b(byte[] bArr, byte[] bArr2, int i, int i2) {
        m118b(bArr2, 0, i, bArr, 0, i2);
        return bArr;
    }

    /* JADX INFO: renamed from: c */
    static Object m120c(String str) throws IOException, ClassNotFoundException {
        return m96a(str, 0, (ClassLoader) null);
    }

    /* JADX INFO: renamed from: c */
    static void m121c(String str, String str2) throws Throwable {
        String strM125d = m125d(str);
        BufferedOutputStream bufferedOutputStream = null;
        try {
            try {
                BufferedOutputStream bufferedOutputStream2 = new BufferedOutputStream(new FileOutputStream(str2));
                try {
                    bufferedOutputStream2.write(strM125d.getBytes(f93l));
                    try {
                        bufferedOutputStream2.close();
                    } catch (Exception unused) {
                    }
                } catch (IOException e) {
                } catch (Throwable th) {
                    th = th;
                    bufferedOutputStream = bufferedOutputStream2;
                    try {
                        bufferedOutputStream.close();
                    } catch (Exception unused2) {
                    }
                    throw th;
                }
            } catch (Throwable th2) {
                th = th2;
            }
        } catch (IOException e2) {
            throw e2;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: c */
    public static final byte[] m122c(int i) {
        if ((i & 16) == 16) {
            return f99r;
        }
        return (i & 32) == 32 ? f101t : f97p;
    }

    /* JADX INFO: renamed from: c */
    static byte[] m123c(byte[] bArr) {
        try {
            return m124c(bArr, 0, bArr.length, 0);
        } catch (IOException unused) {
            return null;
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v17 */
    /* JADX WARN: Type inference failed for: r2v2, types: [int] */
    /* JADX INFO: renamed from: c */
    static byte[] m124c(byte[] bArr, int i, int i2, int i3) throws Throwable {
        c cVar;
        if (bArr == null) {
            throw new NullPointerException("Cannot serialize a null array.");
        }
        if (i < 0) {
            throw new IllegalArgumentException("Cannot have negative offset: " + i);
        }
        if (i2 < 0) {
            throw new IllegalArgumentException("Cannot have length offset: " + i2);
        }
        int i4 = i + i2;
        ByteArrayOutputStream length = bArr.length;
        if (i4 > length) {
            throw new IllegalArgumentException(String.format("Cannot have offset of %d and length of %d with array of length %d", Integer.valueOf(i), Integer.valueOf(i2), Integer.valueOf(bArr.length)));
        }
        if ((i3 & 2) == 0) {
            boolean z = (i3 & 8) != 0;
            int i5 = ((i2 / 3) * 4) + (i2 % 3 > 0 ? 4 : 0);
            if (z) {
                i5 += i5 / f90i;
            }
            int i6 = i5;
            byte[] bArr2 = new byte[i6];
            int i7 = i2 - 2;
            int i8 = 0;
            int i9 = 0;
            int i10 = 0;
            while (i8 < i7) {
                int i11 = i8;
                int i12 = i7;
                m118b(bArr, i8 + i, 3, bArr2, i9, i3);
                int i13 = i10 + 4;
                if (!z || i13 < f90i) {
                    i10 = i13;
                } else {
                    bArr2[i9 + 4] = f92k;
                    i9++;
                    i10 = 0;
                }
                i8 = i11 + 3;
                i9 += 4;
                i7 = i12;
            }
            int i14 = i8;
            if (i14 < i2) {
                m118b(bArr, i14 + i, i2 - i14, bArr2, i9, i3);
                i9 += 4;
            }
            int i15 = i9;
            if (i15 > i6 - 1) {
                return bArr2;
            }
            byte[] bArr3 = new byte[i15];
            System.arraycopy(bArr2, 0, bArr3, 0, i15);
            return bArr3;
        }
        GZIPOutputStream gZIPOutputStream = null;
        try {
            try {
                length = new ByteArrayOutputStream();
                try {
                    cVar = new c(length, i3 | 1);
                    try {
                        GZIPOutputStream gZIPOutputStream2 = new GZIPOutputStream(cVar);
                        try {
                            gZIPOutputStream2.write(bArr, i, i2);
                            gZIPOutputStream2.close();
                            try {
                                gZIPOutputStream2.close();
                            } catch (Exception unused) {
                            }
                            try {
                                cVar.close();
                            } catch (Exception unused2) {
                            }
                            try {
                                length.close();
                            } catch (Exception unused3) {
                            }
                            return length.toByteArray();
                        } catch (IOException e) {
                            throw e;
                        } catch (Throwable th) {
                            th = th;
                            gZIPOutputStream = gZIPOutputStream2;
                            try {
                                gZIPOutputStream.close();
                            } catch (Exception unused4) {
                            }
                            try {
                                cVar.close();
                            } catch (Exception unused5) {
                            }
                            try {
                                length.close();
                                throw th;
                            } catch (Exception unused6) {
                                throw th;
                            }
                        }
                    } catch (IOException e2) {
                        throw e2;
                    }
                } catch (IOException e3) {
                    throw e3;
                } catch (Throwable th2) {
                    th = th2;
                    cVar = null;
                }
            } catch (Throwable th3) {
                th = th3;
            }
        } catch (IOException e4) {
            length = 0;
            cVar = null;
            throw e4;
        } catch (Throwable th4) {
            th = th4;
            length = 0;
            cVar = null;
        }
    }

    /* JADX INFO: renamed from: d */
    static String m125d(String str) throws Throwable {
        b bVar = null;
        try {
            try {
                File file = new File(str);
                double length = file.length();
                Double.isNaN(length);
                byte[] bArr = new byte[Math.max((int) ((length * 1.4d) + 1.0d), 40)];
                b bVar2 = new b(new BufferedInputStream(new FileInputStream(file)), 1);
                int i = 0;
                while (true) {
                    try {
                        int i2 = bVar2.read(bArr, i, 4096);
                        if (i2 < 0) {
                            break;
                        }
                        i += i2;
                    } catch (IOException e) {
                        throw e;
                    } catch (Throwable th) {
                        th = th;
                        bVar = bVar2;
                        try {
                            bVar.close();
                        } catch (Exception unused) {
                        }
                        throw th;
                    }
                }
                String str2 = new String(bArr, 0, i, f93l);
                try {
                    bVar2.close();
                } catch (Exception unused2) {
                }
                return str2;
            } catch (IOException e2) {
                throw e2;
            }
        } catch (Throwable th2) {
            th = th2;
        }
    }
}

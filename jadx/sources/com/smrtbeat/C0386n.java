package com.smrtbeat;

import com.adjust.sdk.Constants;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.zip.GZIPOutputStream;
import org.apache.commons.net.SocketClient;

/* JADX INFO: renamed from: com.smrtbeat.n */
/* JADX INFO: loaded from: classes.dex */
class C0386n {

    /* JADX INFO: renamed from: c */
    private static final String f298c = "----------V2ymHFg03ehbqgZCaKO6jy";

    /* JADX INFO: renamed from: a */
    private String f299a;

    /* JADX INFO: renamed from: b */
    private List<a> f300b;

    /* JADX INFO: renamed from: com.smrtbeat.n$a */
    static class a {

        /* JADX INFO: renamed from: a */
        private String f301a;

        /* JADX INFO: renamed from: b */
        private String f302b;

        /* JADX INFO: renamed from: c */
        private File f303c;

        a(String str, String str2, File file) {
            this.f301a = str;
            this.f302b = str2;
            this.f303c = file;
        }

        /* JADX INFO: renamed from: a */
        File m285a() {
            return this.f303c;
        }

        /* JADX INFO: renamed from: b */
        String m286b() {
            return this.f302b;
        }

        /* JADX INFO: renamed from: c */
        String m287c() {
            return this.f301a;
        }
    }

    public C0386n(String str, List<a> list) {
        this.f299a = str;
        this.f300b = list;
    }

    /* JADX INFO: renamed from: a */
    private String m282a(a aVar) {
        StringBuffer stringBuffer = new StringBuffer("--");
        stringBuffer.append(f298c);
        stringBuffer.append(SocketClient.NETASCII_EOL);
        stringBuffer.append("Content-Disposition: form-data; name=\"");
        stringBuffer.append(aVar.m287c());
        stringBuffer.append("\"; filename=\"");
        stringBuffer.append(aVar.m286b());
        stringBuffer.append("\"\r\n");
        stringBuffer.append("Content-Type: ");
        stringBuffer.append("application/octet-stream");
        stringBuffer.append("\r\n\r\n");
        return stringBuffer.toString();
    }

    /* JADX WARN: Code duplicated, block: B:57:0x0069 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:63:? A[SYNTHETIC] */
    /* JADX WARN: Not initialized variable reg: 5, insn: 0x0063: MOVE (r4 I:??[OBJECT, ARRAY]) = (r5 I:??[OBJECT, ARRAY]), block:B:35:0x0063 */
    /* JADX INFO: renamed from: a */
    private byte[] m283a(File file) throws Throwable {
        FileInputStream fileInputStream;
        FileInputStream fileInputStream2;
        byte[] bArr = new byte[10];
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        FileInputStream fileInputStream3 = null;
        try {
            try {
                fileInputStream = new FileInputStream(file);
                while (fileInputStream.read(bArr) > 0) {
                    try {
                        byteArrayOutputStream.write(bArr);
                    } catch (FileNotFoundException e) {
                        e = e;
                        C0377f0.m159a(C0377f0.e.ERROR, String.format("HttpMultipartRequest:%s", e.getMessage()));
                        try {
                            byteArrayOutputStream.close();
                        } catch (IOException unused) {
                        }
                        if (fileInputStream != null) {
                        }
                        return byteArrayOutputStream.toByteArray();
                    } catch (IOException e2) {
                        e = e2;
                        C0377f0.m159a(C0377f0.e.ERROR, String.format("HttpMultipartRequest:%s", e.getMessage()));
                        try {
                            byteArrayOutputStream.close();
                        } catch (IOException unused2) {
                        }
                        if (fileInputStream != null) {
                        }
                        return byteArrayOutputStream.toByteArray();
                    }
                }
                try {
                    byteArrayOutputStream.close();
                } catch (IOException unused3) {
                }
            } catch (Throwable th) {
                th = th;
                fileInputStream3 = fileInputStream2;
                try {
                    byteArrayOutputStream.close();
                } catch (IOException unused4) {
                }
                if (fileInputStream3 != null) {
                    throw th;
                }
                try {
                    fileInputStream3.close();
                    throw th;
                } catch (IOException unused5) {
                    throw th;
                }
            }
        } catch (FileNotFoundException e3) {
            e = e3;
            fileInputStream = null;
        } catch (IOException e4) {
            e = e4;
            fileInputStream = null;
        } catch (Throwable th2) {
            th = th2;
            byteArrayOutputStream.close();
            if (fileInputStream3 != null) {
                throw th;
            }
            fileInputStream3.close();
            throw th;
        }
        try {
            fileInputStream.close();
        } catch (IOException unused6) {
        }
        return byteArrayOutputStream.toByteArray();
    }

    /* JADX WARN: Code duplicated, block: B:49:0x00f5  */
    /* JADX WARN: Code duplicated, block: B:54:0x0100  */
    /* JADX WARN: Code duplicated, block: B:60:0x0105 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:67:0x00fa A[EXC_TOP_SPLITTER, PHI: r6
      0x00fa: PHI (r6v8 java.io.OutputStream) = (r6v7 java.io.OutputStream), (r6v18 java.io.OutputStream) binds: [B:50:0x00f8, B:34:0x00c8] A[DONT_GENERATE, DONT_INLINE], SYNTHETIC] */
    /* JADX INFO: renamed from: a */
    public C0369b0 m284a(int i, boolean z) throws Throwable {
        HttpURLConnection httpURLConnection;
        Exception e;
        C0369b0 c0369b0 = new C0369b0();
        if (C0382j.f242o.length() <= 0) {
            C0377f0.m159a(C0377f0.e.ERROR, "Data cannot send due to invalide api key.");
            return c0369b0;
        }
        OutputStream outputStream = null;
        try {
            httpURLConnection = (HttpURLConnection) new URL(this.f299a).openConnection();
            try {
                httpURLConnection.setReadTimeout(i);
                httpURLConnection.setConnectTimeout(i);
                httpURLConnection.addRequestProperty("X-SmartBeat-Api-Key", C0382j.f242o);
                httpURLConnection.addRequestProperty("X-SmartBeat-Device-Time", String.valueOf(System.currentTimeMillis()));
                httpURLConnection.setRequestProperty("Content-Type", "multipart/form-data; boundary=----------V2ymHFg03ehbqgZCaKO6jy");
                if (z) {
                    httpURLConnection.setRequestProperty("Content-Encoding", "gzip");
                }
                httpURLConnection.setDoOutput(true);
                httpURLConnection.setChunkedStreamingMode(0);
                httpURLConnection.connect();
                OutputStream outputStream2 = httpURLConnection.getOutputStream();
                if (z) {
                    try {
                        try {
                            outputStream2 = new GZIPOutputStream(outputStream2);
                        } catch (Throwable th) {
                            outputStream = outputStream2;
                            th = th;
                            if (httpURLConnection != null) {
                                httpURLConnection.disconnect();
                            }
                            if (outputStream != null) {
                                try {
                                    outputStream.close();
                                } catch (IOException unused) {
                                }
                            }
                            throw th;
                        }
                    } catch (Exception e2) {
                        e = e2;
                        outputStream = outputStream2;
                        outputStream2 = outputStream;
                        C0377f0.m159a(C0377f0.e.DEBUG, "failed to send data" + e.toString());
                        if (httpURLConnection != null) {
                            httpURLConnection.disconnect();
                        }
                        if (outputStream2 != null) {
                            try {
                                outputStream2.close();
                            } catch (IOException unused2) {
                            }
                        }
                        return c0369b0;
                    }
                }
                try {
                    List<a> list = this.f300b;
                    if (list != null) {
                        for (a aVar : list) {
                            outputStream2.write(m282a(aVar).getBytes(Constants.ENCODING));
                            outputStream2.write(m283a(aVar.m285a()));
                            outputStream2.write(SocketClient.NETASCII_EOL.getBytes());
                        }
                    }
                    outputStream2.write("------------V2ymHFg03ehbqgZCaKO6jy--\r\n".getBytes());
                    outputStream2.flush();
                    outputStream2.close();
                    int responseCode = httpURLConnection.getResponseCode();
                    c0369b0.f75a = responseCode;
                    if (responseCode == 200) {
                        c0369b0.f76b = C0377f0.m151a(httpURLConnection);
                    }
                    if (httpURLConnection != null) {
                        httpURLConnection.disconnect();
                    }
                    if (outputStream2 != null) {
                        outputStream2.close();
                    }
                } catch (Exception e3) {
                    e = e3;
                    C0377f0.m159a(C0377f0.e.DEBUG, "failed to send data" + e.toString());
                    if (httpURLConnection != null) {
                        httpURLConnection.disconnect();
                    }
                    if (outputStream2 != null) {
                        outputStream2.close();
                    }
                }
            } catch (Exception e4) {
                e = e4;
            } catch (Throwable th2) {
                th = th2;
                if (httpURLConnection != null) {
                    httpURLConnection.disconnect();
                }
                if (outputStream != null) {
                    outputStream.close();
                }
                throw th;
            }
        } catch (Exception e5) {
            e = e5;
            httpURLConnection = null;
        } catch (Throwable th3) {
            th = th3;
            httpURLConnection = null;
        }
        return c0369b0;
    }
}

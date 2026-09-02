package com.google.android.gms.measurement.internal;

import androidx.annotation.WorkerThread;
import com.google.android.gms.common.internal.Preconditions;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
@WorkerThread
final class zzhn implements Runnable {
    private final String packageName;
    private final URL url;
    private final byte[] zzlc;
    private final Map<String, String> zzle;
    private final zzhk zzqm;
    private final /* synthetic */ zzhl zzqn;

    public zzhn(zzhl zzhlVar, String str, URL url, byte[] bArr, Map<String, String> map, zzhk zzhkVar) {
        this.zzqn = zzhlVar;
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(url);
        Preconditions.checkNotNull(zzhkVar);
        this.url = url;
        this.zzlc = null;
        this.zzqm = zzhkVar;
        this.packageName = str;
        this.zzle = null;
    }

    @Override // java.lang.Runnable
    public final void run() throws Throwable {
        HttpURLConnection httpURLConnectionZza;
        Map<String, List<String>> map;
        Map<String, List<String>> map2;
        this.zzqn.zzn();
        int i = 0;
        try {
            httpURLConnectionZza = this.zzqn.zza(this.url);
            try {
                if (this.zzle != null) {
                    for (Map.Entry<String, String> entry : this.zzle.entrySet()) {
                        httpURLConnectionZza.addRequestProperty(entry.getKey(), entry.getValue());
                    }
                }
                int responseCode = httpURLConnectionZza.getResponseCode();
                try {
                    Map<String, List<String>> headerFields = httpURLConnectionZza.getHeaderFields();
                    try {
                        zzhl zzhlVar = this.zzqn;
                        byte[] bArrZza = zzhl.zza(httpURLConnectionZza);
                        if (httpURLConnectionZza != null) {
                            httpURLConnectionZza.disconnect();
                        }
                        zza(responseCode, null, bArrZza, headerFields);
                    } catch (IOException e) {
                        map2 = headerFields;
                        i = responseCode;
                        e = e;
                        if (httpURLConnectionZza != null) {
                            httpURLConnectionZza.disconnect();
                        }
                        zza(i, e, null, map2);
                    } catch (Throwable th) {
                        map = headerFields;
                        i = responseCode;
                        th = th;
                        if (httpURLConnectionZza != null) {
                            httpURLConnectionZza.disconnect();
                        }
                        zza(i, null, null, map);
                        throw th;
                    }
                } catch (IOException e2) {
                    map2 = null;
                    e = e2;
                    i = responseCode;
                } catch (Throwable th2) {
                    map = null;
                    th = th2;
                    i = responseCode;
                }
            } catch (IOException e3) {
                e = e3;
                map2 = null;
            } catch (Throwable th3) {
                th = th3;
                map = null;
            }
        } catch (IOException e4) {
            e = e4;
            httpURLConnectionZza = null;
            map2 = null;
        } catch (Throwable th4) {
            th = th4;
            httpURLConnectionZza = null;
            map = null;
        }
    }

    private final void zza(final int i, final Exception exc, final byte[] bArr, final Map<String, List<String>> map) {
        this.zzqn.zzaa().zza(new Runnable(this, i, exc, bArr, map) { // from class: com.google.android.gms.measurement.internal.zzhm
            private final zzhn zzqh;
            private final int zzqi;
            private final Exception zzqj;
            private final byte[] zzqk;
            private final Map zzql;

            {
                this.zzqh = this;
                this.zzqi = i;
                this.zzqj = exc;
                this.zzqk = bArr;
                this.zzql = map;
            }

            @Override // java.lang.Runnable
            public final void run() {
                this.zzqh.zzb(this.zzqi, this.zzqj, this.zzqk, this.zzql);
            }
        });
    }

    final /* synthetic */ void zzb(int i, Exception exc, byte[] bArr, Map map) {
        this.zzqm.zza(this.packageName, i, exc, bArr, map);
    }
}

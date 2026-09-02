package com.google.android.gms.common.util;

import android.os.Process;
import android.os.StrictMode;
import com.google.android.gms.common.annotation.KeepForSdk;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import javax.annotation.Nullable;

/* JADX INFO: loaded from: classes.dex */
@KeepForSdk
public class ProcessUtils {
    private static String zzhf;
    private static int zzhg;

    private ProcessUtils() {
    }

    @KeepForSdk
    @Nullable
    public static String getMyProcessName() {
        if (zzhf == null) {
            if (zzhg == 0) {
                zzhg = Process.myPid();
            }
            zzhf = zzd(zzhg);
        }
        return zzhf;
    }

    @Nullable
    private static String zzd(int i) throws Throwable {
        BufferedReader bufferedReaderZzk;
        BufferedReader bufferedReader = null;
        if (i <= 0) {
            return null;
        }
        try {
            StringBuilder sb = new StringBuilder(25);
            sb.append("/proc/");
            sb.append(i);
            sb.append("/cmdline");
            bufferedReaderZzk = zzk(sb.toString());
            try {
                String strTrim = bufferedReaderZzk.readLine().trim();
                IOUtils.closeQuietly(bufferedReaderZzk);
                return strTrim;
            } catch (IOException unused) {
                IOUtils.closeQuietly(bufferedReaderZzk);
                return null;
            } catch (Throwable th) {
                bufferedReader = bufferedReaderZzk;
                th = th;
                IOUtils.closeQuietly(bufferedReader);
                throw th;
            }
        } catch (IOException unused2) {
            bufferedReaderZzk = null;
        } catch (Throwable th2) {
            th = th2;
        }
    }

    private static BufferedReader zzk(String str) throws IOException {
        StrictMode.ThreadPolicy threadPolicyAllowThreadDiskReads = StrictMode.allowThreadDiskReads();
        try {
            return new BufferedReader(new FileReader(str));
        } finally {
            StrictMode.setThreadPolicy(threadPolicyAllowThreadDiskReads);
        }
    }
}

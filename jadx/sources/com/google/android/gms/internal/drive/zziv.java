package com.google.android.gms.internal.drive;

import com.adjust.sdk.Constants;
import java.nio.charset.Charset;
import org.apache.commons.net.ftp.FTP;

/* JADX INFO: loaded from: classes.dex */
public final class zziv {
    protected static final Charset UTF_8 = Charset.forName(Constants.ENCODING);
    private static final Charset ISO_8859_1 = Charset.forName(FTP.DEFAULT_CONTROL_ENCODING);
    private static final Object zzne = new Object();

    public static void zza(zzir zzirVar, zzir zzirVar2) {
        if (zzirVar.zzmw != null) {
            zzirVar2.zzmw = (zzit) zzirVar.zzmw.clone();
        }
    }
}

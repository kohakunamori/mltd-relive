package com.google.android.gms.internal.firebase_messaging;

import android.support.v4.media.session.PlaybackStateCompat;
import java.io.InputStream;
import java.io.OutputStream;

/* JADX INFO: compiled from: com.google.firebase:firebase-messaging@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
public final class zzj {
    private static final OutputStream zza = new zzi();

    public static InputStream zza(InputStream inputStream, long j) {
        return new zzl(inputStream, PlaybackStateCompat.ACTION_SET_CAPTIONING_ENABLED);
    }
}

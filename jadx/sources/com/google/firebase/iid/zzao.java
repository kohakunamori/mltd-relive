package com.google.firebase.iid;

import android.os.Looper;
import android.os.Message;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzao extends com.google.android.gms.internal.firebase_messaging.zze {
    private final /* synthetic */ zzal zza;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzao(zzal zzalVar, Looper looper) {
        super(looper);
        this.zza = zzalVar;
    }

    @Override // android.os.Handler
    public final void handleMessage(Message message) {
        this.zza.zza(message);
    }
}

package com.google.firebase.analytics;

import java.util.concurrent.Callable;
import java.util.concurrent.TimeoutException;

/* JADX INFO: loaded from: classes.dex */
final class zzb implements Callable<String> {
    private final /* synthetic */ FirebaseAnalytics zzaca;

    zzb(FirebaseAnalytics firebaseAnalytics) {
        this.zzaca = firebaseAnalytics;
    }

    @Override // java.util.concurrent.Callable
    public final /* synthetic */ String call() throws Exception {
        String strZzy;
        String strZzi = this.zzaca.zzi();
        if (strZzi != null) {
            return strZzi;
        }
        if (this.zzaca.zzl) {
            strZzy = this.zzaca.zzabu.getAppInstanceId();
        } else {
            strZzy = this.zzaca.zzj.zzq().zzy(120000L);
        }
        if (strZzy == null) {
            throw new TimeoutException();
        }
        this.zzaca.zzbg(strZzy);
        return strZzy;
    }
}

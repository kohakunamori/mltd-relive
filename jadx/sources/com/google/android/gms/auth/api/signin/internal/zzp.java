package com.google.android.gms.auth.api.signin.internal;

import android.content.Context;
import androidx.annotation.NonNull;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes.dex */
public final class zzp {
    private static zzp zzbn;

    @VisibleForTesting
    private Storage zzbo;

    @VisibleForTesting
    private GoogleSignInAccount zzbp;

    @VisibleForTesting
    private GoogleSignInOptions zzbq;

    private zzp(Context context) {
        this.zzbo = Storage.getInstance(context);
        this.zzbp = this.zzbo.getSavedDefaultGoogleSignInAccount();
        this.zzbq = this.zzbo.getSavedDefaultGoogleSignInOptions();
    }

    public static synchronized zzp zzd(@NonNull Context context) {
        return zze(context.getApplicationContext());
    }

    private static synchronized zzp zze(Context context) {
        if (zzbn == null) {
            zzbn = new zzp(context);
        }
        return zzbn;
    }

    public final synchronized void clear() {
        this.zzbo.clear();
        this.zzbp = null;
        this.zzbq = null;
    }

    public final synchronized void zzc(GoogleSignInOptions googleSignInOptions, GoogleSignInAccount googleSignInAccount) {
        this.zzbo.saveDefaultGoogleSignInAccount(googleSignInAccount, googleSignInOptions);
        this.zzbp = googleSignInAccount;
        this.zzbq = googleSignInOptions;
    }

    public final synchronized GoogleSignInAccount zzh() {
        return this.zzbp;
    }

    public final synchronized GoogleSignInOptions zzi() {
        return this.zzbq;
    }
}

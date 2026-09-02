package com.google.android.gms.common.api.internal;

import android.os.Looper;
import android.util.Log;
import androidx.annotation.NonNull;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.PendingResult;
import com.google.android.gms.common.api.Releasable;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.ResultCallback;
import com.google.android.gms.common.api.ResultCallbacks;
import com.google.android.gms.common.api.ResultTransform;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.TransformedResult;
import com.google.android.gms.common.internal.Preconditions;
import java.lang.ref.WeakReference;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes.dex */
public final class zacm<R extends Result> extends TransformedResult<R> implements ResultCallback<R> {
    private final WeakReference<GoogleApiClient> zadq;
    private final zaco zakt;
    private ResultTransform<? super R, ? extends Result> zako = null;
    private zacm<? extends Result> zakp = null;
    private volatile ResultCallbacks<? super R> zakq = null;
    private PendingResult<R> zakr = null;
    private final Object zado = new Object();
    private Status zaks = null;
    private boolean zaku = false;

    public zacm(WeakReference<GoogleApiClient> weakReference) {
        Preconditions.checkNotNull(weakReference, "GoogleApiClient reference must not be null");
        this.zadq = weakReference;
        GoogleApiClient googleApiClient = this.zadq.get();
        this.zakt = new zaco(this, googleApiClient != null ? googleApiClient.getLooper() : Looper.getMainLooper());
    }

    @Override // com.google.android.gms.common.api.TransformedResult
    @NonNull
    public final <S extends Result> TransformedResult<S> then(@NonNull ResultTransform<? super R, ? extends S> resultTransform) {
        zacm<? extends Result> zacmVar;
        synchronized (this.zado) {
            Preconditions.checkState(this.zako == null, "Cannot call then() twice.");
            Preconditions.checkState(this.zakq == null, "Cannot call then() and andFinally() on the same TransformedResult.");
            this.zako = resultTransform;
            zacmVar = new zacm<>(this.zadq);
            this.zakp = zacmVar;
            zabu();
        }
        return zacmVar;
    }

    @Override // com.google.android.gms.common.api.TransformedResult
    public final void andFinally(@NonNull ResultCallbacks<? super R> resultCallbacks) {
        synchronized (this.zado) {
            Preconditions.checkState(this.zakq == null, "Cannot call andFinally() twice.");
            Preconditions.checkState(this.zako == null, "Cannot call then() and andFinally() on the same TransformedResult.");
            this.zakq = resultCallbacks;
            zabu();
        }
    }

    @Override // com.google.android.gms.common.api.ResultCallback
    public final void onResult(R r) {
        synchronized (this.zado) {
            if (r.getStatus().isSuccess()) {
                if (this.zako != null) {
                    zacc.zabb().submit(new zacn(this, r));
                } else if (zabw()) {
                    this.zakq.onSuccess(r);
                }
            } else {
                zad(r.getStatus());
                zab(r);
            }
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    public final void zaa(PendingResult<?> pendingResult) {
        synchronized (this.zado) {
            this.zakr = pendingResult;
            zabu();
        }
    }

    @GuardedBy("mSyncToken")
    private final void zabu() {
        if (this.zako == null && this.zakq == null) {
            return;
        }
        GoogleApiClient googleApiClient = this.zadq.get();
        if (!this.zaku && this.zako != null && googleApiClient != null) {
            googleApiClient.zaa(this);
            this.zaku = true;
        }
        if (this.zaks != null) {
            zae(this.zaks);
        } else if (this.zakr != null) {
            this.zakr.setResultCallback(this);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zad(Status status) {
        synchronized (this.zado) {
            this.zaks = status;
            zae(this.zaks);
        }
    }

    private final void zae(Status status) {
        synchronized (this.zado) {
            if (this.zako != null) {
                Status statusOnFailure = this.zako.onFailure(status);
                Preconditions.checkNotNull(statusOnFailure, "onFailure must not return null");
                this.zakp.zad(statusOnFailure);
            } else if (zabw()) {
                this.zakq.onFailure(status);
            }
        }
    }

    final void zabv() {
        this.zakq = null;
    }

    @GuardedBy("mSyncToken")
    private final boolean zabw() {
        return (this.zakq == null || this.zadq.get() == null) ? false : true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void zab(Result result) {
        if (result instanceof Releasable) {
            try {
                ((Releasable) result).release();
            } catch (RuntimeException e) {
                String strValueOf = String.valueOf(result);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 18);
                sb.append("Unable to release ");
                sb.append(strValueOf);
                Log.w("TransformedResultImpl", sb.toString(), e);
            }
        }
    }
}

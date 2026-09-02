package com.google.android.gms.common.api.internal;

import androidx.annotation.WorkerThread;

/* JADX INFO: loaded from: classes.dex */
abstract class zaau implements Runnable {
    private final /* synthetic */ zaak zagj;

    private zaau(zaak zaakVar) {
        this.zagj = zaakVar;
    }

    @WorkerThread
    protected abstract void zaan();

    @Override // java.lang.Runnable
    @WorkerThread
    public void run() {
        this.zagj.zaeo.lock();
        try {
            if (Thread.interrupted()) {
                return;
            }
            zaan();
            return;
        } catch (RuntimeException e) {
            this.zagj.zaft.zab(e);
            return;
        } finally {
            this.zagj.zaeo.unlock();
        }
        this.zagj.zaeo.unlock();
    }

    /* synthetic */ zaau(zaak zaakVar, zaal zaalVar) {
        this(zaakVar);
    }
}

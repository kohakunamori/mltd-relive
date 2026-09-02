package com.google.android.gms.measurement.internal;

/* JADX INFO: loaded from: classes.dex */
abstract class zzge extends zzgf {
    private boolean zzdh;

    zzge(zzfj zzfjVar) {
        super(zzfjVar);
        this.zzj.zzb(this);
    }

    protected abstract boolean zzbk();

    protected void zzbl() {
    }

    final boolean isInitialized() {
        return this.zzdh;
    }

    protected final void zzbi() {
        if (!isInitialized()) {
            throw new IllegalStateException("Not initialized");
        }
    }

    public final void initialize() {
        if (this.zzdh) {
            throw new IllegalStateException("Can't initialize twice");
        }
        if (zzbk()) {
            return;
        }
        this.zzj.zzid();
        this.zzdh = true;
    }

    public final void zzbj() {
        if (this.zzdh) {
            throw new IllegalStateException("Can't initialize twice");
        }
        zzbl();
        this.zzj.zzid();
        this.zzdh = true;
    }
}

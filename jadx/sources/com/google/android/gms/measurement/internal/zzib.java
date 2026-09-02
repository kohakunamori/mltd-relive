package com.google.android.gms.measurement.internal;

import android.os.RemoteException;

/* JADX INFO: loaded from: classes.dex */
final class zzib implements Runnable {
    private final /* synthetic */ com.google.android.gms.internal.measurement.zzp zzdi;
    private final /* synthetic */ zzn zzpg;
    private final /* synthetic */ zzhv zzrd;

    zzib(zzhv zzhvVar, zzn zznVar, com.google.android.gms.internal.measurement.zzp zzpVar) {
        this.zzrd = zzhvVar;
        this.zzpg = zznVar;
        this.zzdi = zzpVar;
    }

    @Override // java.lang.Runnable
    public final void run() throws Throwable {
        String strZzc;
        Throwable th;
        RemoteException e;
        try {
            zzdx zzdxVar = this.zzrd.zzrf;
            if (zzdxVar == null) {
                this.zzrd.zzab().zzgk().zzao("Failed to get app instance id");
                this.zzrd.zzz().zzb(this.zzdi, (String) null);
                return;
            }
            strZzc = zzdxVar.zzc(this.zzpg);
            if (strZzc != null) {
                try {
                    try {
                        this.zzrd.zzq().zzbg(strZzc);
                        this.zzrd.zzac().zzlq.zzau(strZzc);
                    } catch (RemoteException e2) {
                        e = e2;
                        this.zzrd.zzab().zzgk().zza("Failed to get app instance id", e);
                        this.zzrd.zzz().zzb(this.zzdi, strZzc);
                        return;
                    }
                } catch (Throwable th2) {
                    th = th2;
                    this.zzrd.zzz().zzb(this.zzdi, strZzc);
                    throw th;
                }
            }
            this.zzrd.zzir();
            this.zzrd.zzz().zzb(this.zzdi, strZzc);
        } catch (RemoteException e3) {
            strZzc = null;
            e = e3;
        } catch (Throwable th3) {
            strZzc = null;
            th = th3;
            this.zzrd.zzz().zzb(this.zzdi, strZzc);
            throw th;
        }
    }
}

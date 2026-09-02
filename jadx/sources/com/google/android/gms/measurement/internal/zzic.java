package com.google.android.gms.measurement.internal;

import android.os.RemoteException;

/* JADX INFO: loaded from: classes.dex */
final class zzic implements Runnable {
    private final /* synthetic */ com.google.android.gms.internal.measurement.zzp zzdi;
    private final /* synthetic */ zzai zzdm;
    private final /* synthetic */ String zzdn;
    private final /* synthetic */ zzhv zzrd;

    zzic(zzhv zzhvVar, zzai zzaiVar, String str, com.google.android.gms.internal.measurement.zzp zzpVar) {
        this.zzrd = zzhvVar;
        this.zzdm = zzaiVar;
        this.zzdn = str;
        this.zzdi = zzpVar;
    }

    @Override // java.lang.Runnable
    public final void run() throws Throwable {
        byte[] bArr = null;
        try {
            try {
                zzdx zzdxVar = this.zzrd.zzrf;
                if (zzdxVar == null) {
                    this.zzrd.zzab().zzgk().zzao("Discarding data. Failed to send event to service to bundle");
                    this.zzrd.zzz().zza(this.zzdi, (byte[]) null);
                    return;
                }
                byte[] bArrZza = zzdxVar.zza(this.zzdm, this.zzdn);
                try {
                    this.zzrd.zzir();
                    this.zzrd.zzz().zza(this.zzdi, bArrZza);
                } catch (RemoteException e) {
                    e = e;
                    bArr = bArrZza;
                    this.zzrd.zzab().zzgk().zza("Failed to send event to the service to bundle", e);
                    this.zzrd.zzz().zza(this.zzdi, bArr);
                } catch (Throwable th) {
                    th = th;
                    bArr = bArrZza;
                    this.zzrd.zzz().zza(this.zzdi, bArr);
                    throw th;
                }
            } catch (Throwable th2) {
                th = th2;
            }
        } catch (RemoteException e2) {
            e = e2;
        }
    }
}

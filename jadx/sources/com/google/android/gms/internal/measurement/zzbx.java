package com.google.android.gms.internal.measurement;

import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public final class zzbx extends zziq<zzbx> {
    private static volatile zzbx[] zzzr;
    public String name = null;
    public Boolean zzzs = null;
    public Boolean zzzt = null;
    public Integer zzzu = null;

    public static zzbx[] zzrc() {
        if (zzzr == null) {
            synchronized (zziu.zzaov) {
                if (zzzr == null) {
                    zzzr = new zzbx[0];
                }
            }
        }
        return zzzr;
    }

    public zzbx() {
        this.zzaoo = null;
        this.zzaow = -1;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzbx)) {
            return false;
        }
        zzbx zzbxVar = (zzbx) obj;
        if (this.name == null) {
            if (zzbxVar.name != null) {
                return false;
            }
        } else if (!this.name.equals(zzbxVar.name)) {
            return false;
        }
        if (this.zzzs == null) {
            if (zzbxVar.zzzs != null) {
                return false;
            }
        } else if (!this.zzzs.equals(zzbxVar.zzzs)) {
            return false;
        }
        if (this.zzzt == null) {
            if (zzbxVar.zzzt != null) {
                return false;
            }
        } else if (!this.zzzt.equals(zzbxVar.zzzt)) {
            return false;
        }
        if (this.zzzu == null) {
            if (zzbxVar.zzzu != null) {
                return false;
            }
        } else if (!this.zzzu.equals(zzbxVar.zzzu)) {
            return false;
        }
        if (this.zzaoo == null || this.zzaoo.isEmpty()) {
            return zzbxVar.zzaoo == null || zzbxVar.zzaoo.isEmpty();
        }
        return this.zzaoo.equals(zzbxVar.zzaoo);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((getClass().getName().hashCode() + 527) * 31) + (this.name == null ? 0 : this.name.hashCode())) * 31) + (this.zzzs == null ? 0 : this.zzzs.hashCode())) * 31) + (this.zzzt == null ? 0 : this.zzzt.hashCode())) * 31) + (this.zzzu == null ? 0 : this.zzzu.hashCode())) * 31;
        if (this.zzaoo != null && !this.zzaoo.isEmpty()) {
            iHashCode = this.zzaoo.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zziq, com.google.android.gms.internal.measurement.zziw
    public final void zza(zzio zzioVar) throws IOException {
        if (this.name != null) {
            zzioVar.zzb(1, this.name);
        }
        if (this.zzzs != null) {
            zzioVar.zzb(2, this.zzzs.booleanValue());
        }
        if (this.zzzt != null) {
            zzioVar.zzb(3, this.zzzt.booleanValue());
        }
        if (this.zzzu != null) {
            zzioVar.zzc(4, this.zzzu.intValue());
        }
        super.zza(zzioVar);
    }

    @Override // com.google.android.gms.internal.measurement.zziq, com.google.android.gms.internal.measurement.zziw
    protected final int zzqy() {
        int iZzqy = super.zzqy();
        if (this.name != null) {
            iZzqy += zzio.zzc(1, this.name);
        }
        if (this.zzzs != null) {
            this.zzzs.booleanValue();
            iZzqy += zzio.zzbi(2) + 1;
        }
        if (this.zzzt != null) {
            this.zzzt.booleanValue();
            iZzqy += zzio.zzbi(3) + 1;
        }
        return this.zzzu != null ? iZzqy + zzio.zzg(4, this.zzzu.intValue()) : iZzqy;
    }

    @Override // com.google.android.gms.internal.measurement.zziw
    public final /* synthetic */ zziw zza(zzil zzilVar) throws IOException {
        while (true) {
            int iZzsg = zzilVar.zzsg();
            if (iZzsg == 0) {
                return this;
            }
            if (iZzsg == 10) {
                this.name = zzilVar.readString();
            } else if (iZzsg == 16) {
                this.zzzs = Boolean.valueOf(zzilVar.zzsm());
            } else if (iZzsg == 24) {
                this.zzzt = Boolean.valueOf(zzilVar.zzsm());
            } else if (iZzsg != 32) {
                if (!super.zza(zzilVar, iZzsg)) {
                    return this;
                }
            } else {
                this.zzzu = Integer.valueOf(zzilVar.zzta());
            }
        }
    }
}

package com.google.android.gms.internal.measurement;

import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public final class zzbv extends zziq<zzbv> {
    private static volatile zzbv[] zzze;
    public Integer zzzf = null;
    public zzbk.zzd[] zzzg = new zzbk.zzd[0];
    public zzbk.zza[] zzzh = new zzbk.zza[0];
    private Boolean zzzi = null;
    private Boolean zzzj = null;

    public static zzbv[] zzqx() {
        if (zzze == null) {
            synchronized (zziu.zzaov) {
                if (zzze == null) {
                    zzze = new zzbv[0];
                }
            }
        }
        return zzze;
    }

    public zzbv() {
        this.zzaoo = null;
        this.zzaow = -1;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzbv)) {
            return false;
        }
        zzbv zzbvVar = (zzbv) obj;
        if (this.zzzf == null) {
            if (zzbvVar.zzzf != null) {
                return false;
            }
        } else if (!this.zzzf.equals(zzbvVar.zzzf)) {
            return false;
        }
        if (!zziu.equals(this.zzzg, zzbvVar.zzzg) || !zziu.equals(this.zzzh, zzbvVar.zzzh)) {
            return false;
        }
        if (this.zzzi == null) {
            if (zzbvVar.zzzi != null) {
                return false;
            }
        } else if (!this.zzzi.equals(zzbvVar.zzzi)) {
            return false;
        }
        if (this.zzzj == null) {
            if (zzbvVar.zzzj != null) {
                return false;
            }
        } else if (!this.zzzj.equals(zzbvVar.zzzj)) {
            return false;
        }
        if (this.zzaoo == null || this.zzaoo.isEmpty()) {
            return zzbvVar.zzaoo == null || zzbvVar.zzaoo.isEmpty();
        }
        return this.zzaoo.equals(zzbvVar.zzaoo);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((((getClass().getName().hashCode() + 527) * 31) + (this.zzzf == null ? 0 : this.zzzf.hashCode())) * 31) + zziu.hashCode(this.zzzg)) * 31) + zziu.hashCode(this.zzzh)) * 31) + (this.zzzi == null ? 0 : this.zzzi.hashCode())) * 31) + (this.zzzj == null ? 0 : this.zzzj.hashCode())) * 31;
        if (this.zzaoo != null && !this.zzaoo.isEmpty()) {
            iHashCode = this.zzaoo.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zziq, com.google.android.gms.internal.measurement.zziw
    public final void zza(zzio zzioVar) throws IOException {
        if (this.zzzf != null) {
            zzioVar.zzc(1, this.zzzf.intValue());
        }
        if (this.zzzg != null && this.zzzg.length > 0) {
            for (int i = 0; i < this.zzzg.length; i++) {
                zzbk.zzd zzdVar = this.zzzg[i];
                if (zzdVar != null) {
                    zzioVar.zze(2, zzdVar);
                }
            }
        }
        if (this.zzzh != null && this.zzzh.length > 0) {
            for (int i2 = 0; i2 < this.zzzh.length; i2++) {
                zzbk.zza zzaVar = this.zzzh[i2];
                if (zzaVar != null) {
                    zzioVar.zze(3, zzaVar);
                }
            }
        }
        if (this.zzzi != null) {
            zzioVar.zzb(4, this.zzzi.booleanValue());
        }
        if (this.zzzj != null) {
            zzioVar.zzb(5, this.zzzj.booleanValue());
        }
        super.zza(zzioVar);
    }

    @Override // com.google.android.gms.internal.measurement.zziq, com.google.android.gms.internal.measurement.zziw
    protected final int zzqy() {
        int iZzqy = super.zzqy();
        if (this.zzzf != null) {
            iZzqy += zzio.zzg(1, this.zzzf.intValue());
        }
        if (this.zzzg != null && this.zzzg.length > 0) {
            int iZzc = iZzqy;
            for (int i = 0; i < this.zzzg.length; i++) {
                zzbk.zzd zzdVar = this.zzzg[i];
                if (zzdVar != null) {
                    iZzc += zzee.zzc(2, zzdVar);
                }
            }
            iZzqy = iZzc;
        }
        if (this.zzzh != null && this.zzzh.length > 0) {
            for (int i2 = 0; i2 < this.zzzh.length; i2++) {
                zzbk.zza zzaVar = this.zzzh[i2];
                if (zzaVar != null) {
                    iZzqy += zzee.zzc(3, zzaVar);
                }
            }
        }
        if (this.zzzi != null) {
            this.zzzi.booleanValue();
            iZzqy += zzio.zzbi(4) + 1;
        }
        if (this.zzzj == null) {
            return iZzqy;
        }
        this.zzzj.booleanValue();
        return iZzqy + zzio.zzbi(5) + 1;
    }

    @Override // com.google.android.gms.internal.measurement.zziw
    public final /* synthetic */ zziw zza(zzil zzilVar) throws IOException {
        while (true) {
            int iZzsg = zzilVar.zzsg();
            if (iZzsg == 0) {
                return this;
            }
            if (iZzsg == 8) {
                this.zzzf = Integer.valueOf(zzilVar.zzta());
            } else if (iZzsg == 18) {
                int iZzb = zzix.zzb(zzilVar, 18);
                int length = this.zzzg == null ? 0 : this.zzzg.length;
                zzbk.zzd[] zzdVarArr = new zzbk.zzd[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzzg, 0, zzdVarArr, 0, length);
                }
                while (length < zzdVarArr.length - 1) {
                    zzdVarArr[length] = (zzbk.zzd) zzilVar.zza(zzbk.zzd.zzkj());
                    zzilVar.zzsg();
                    length++;
                }
                zzdVarArr[length] = (zzbk.zzd) zzilVar.zza(zzbk.zzd.zzkj());
                this.zzzg = zzdVarArr;
            } else if (iZzsg == 26) {
                int iZzb2 = zzix.zzb(zzilVar, 26);
                int length2 = this.zzzh == null ? 0 : this.zzzh.length;
                zzbk.zza[] zzaVarArr = new zzbk.zza[iZzb2 + length2];
                if (length2 != 0) {
                    System.arraycopy(this.zzzh, 0, zzaVarArr, 0, length2);
                }
                while (length2 < zzaVarArr.length - 1) {
                    zzaVarArr[length2] = (zzbk.zza) zzilVar.zza(zzbk.zza.zzkj());
                    zzilVar.zzsg();
                    length2++;
                }
                zzaVarArr[length2] = (zzbk.zza) zzilVar.zza(zzbk.zza.zzkj());
                this.zzzh = zzaVarArr;
            } else if (iZzsg == 32) {
                this.zzzi = Boolean.valueOf(zzilVar.zzsm());
            } else if (iZzsg != 40) {
                if (!super.zza(zzilVar, iZzsg)) {
                    return this;
                }
            } else {
                this.zzzj = Boolean.valueOf(zzilVar.zzsm());
            }
        }
    }
}

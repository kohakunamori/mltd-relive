package com.google.android.gms.internal.measurement;

import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public final class zzbw extends zziq<zzbw> {
    public Long zzzk = null;
    public String zzcg = null;
    private Integer zzzl = null;
    public zzbq.zza[] zzzm = new zzbq.zza[0];
    public zzbx[] zzzn = zzbx.zzrc();
    public zzbv[] zzzo = zzbv.zzqx();
    private String zzzp = null;
    public Boolean zzzq = null;

    public zzbw() {
        this.zzaoo = null;
        this.zzaow = -1;
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzbw)) {
            return false;
        }
        zzbw zzbwVar = (zzbw) obj;
        if (this.zzzk == null) {
            if (zzbwVar.zzzk != null) {
                return false;
            }
        } else if (!this.zzzk.equals(zzbwVar.zzzk)) {
            return false;
        }
        if (this.zzcg == null) {
            if (zzbwVar.zzcg != null) {
                return false;
            }
        } else if (!this.zzcg.equals(zzbwVar.zzcg)) {
            return false;
        }
        if (this.zzzl == null) {
            if (zzbwVar.zzzl != null) {
                return false;
            }
        } else if (!this.zzzl.equals(zzbwVar.zzzl)) {
            return false;
        }
        if (!zziu.equals(this.zzzm, zzbwVar.zzzm) || !zziu.equals(this.zzzn, zzbwVar.zzzn) || !zziu.equals(this.zzzo, zzbwVar.zzzo)) {
            return false;
        }
        if (this.zzzp == null) {
            if (zzbwVar.zzzp != null) {
                return false;
            }
        } else if (!this.zzzp.equals(zzbwVar.zzzp)) {
            return false;
        }
        if (this.zzzq == null) {
            if (zzbwVar.zzzq != null) {
                return false;
            }
        } else if (!this.zzzq.equals(zzbwVar.zzzq)) {
            return false;
        }
        if (this.zzaoo == null || this.zzaoo.isEmpty()) {
            return zzbwVar.zzaoo == null || zzbwVar.zzaoo.isEmpty();
        }
        return this.zzaoo.equals(zzbwVar.zzaoo);
    }

    public final int hashCode() {
        int iHashCode = 0;
        int iHashCode2 = (((((((((((((((((getClass().getName().hashCode() + 527) * 31) + (this.zzzk == null ? 0 : this.zzzk.hashCode())) * 31) + (this.zzcg == null ? 0 : this.zzcg.hashCode())) * 31) + (this.zzzl == null ? 0 : this.zzzl.hashCode())) * 31) + zziu.hashCode(this.zzzm)) * 31) + zziu.hashCode(this.zzzn)) * 31) + zziu.hashCode(this.zzzo)) * 31) + (this.zzzp == null ? 0 : this.zzzp.hashCode())) * 31) + (this.zzzq == null ? 0 : this.zzzq.hashCode())) * 31;
        if (this.zzaoo != null && !this.zzaoo.isEmpty()) {
            iHashCode = this.zzaoo.hashCode();
        }
        return iHashCode2 + iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zziq, com.google.android.gms.internal.measurement.zziw
    public final void zza(zzio zzioVar) throws IOException {
        if (this.zzzk != null) {
            long jLongValue = this.zzzk.longValue();
            zzioVar.zzb(1, 0);
            zzioVar.zzbz(jLongValue);
        }
        if (this.zzcg != null) {
            zzioVar.zzb(2, this.zzcg);
        }
        if (this.zzzl != null) {
            zzioVar.zzc(3, this.zzzl.intValue());
        }
        if (this.zzzm != null && this.zzzm.length > 0) {
            for (int i = 0; i < this.zzzm.length; i++) {
                zzbq.zza zzaVar = this.zzzm[i];
                if (zzaVar != null) {
                    zzioVar.zze(4, zzaVar);
                }
            }
        }
        if (this.zzzn != null && this.zzzn.length > 0) {
            for (int i2 = 0; i2 < this.zzzn.length; i2++) {
                zzbx zzbxVar = this.zzzn[i2];
                if (zzbxVar != null) {
                    zzioVar.zza(5, zzbxVar);
                }
            }
        }
        if (this.zzzo != null && this.zzzo.length > 0) {
            for (int i3 = 0; i3 < this.zzzo.length; i3++) {
                zzbv zzbvVar = this.zzzo[i3];
                if (zzbvVar != null) {
                    zzioVar.zza(6, zzbvVar);
                }
            }
        }
        if (this.zzzp != null) {
            zzioVar.zzb(7, this.zzzp);
        }
        if (this.zzzq != null) {
            zzioVar.zzb(8, this.zzzq.booleanValue());
        }
        super.zza(zzioVar);
    }

    @Override // com.google.android.gms.internal.measurement.zziq, com.google.android.gms.internal.measurement.zziw
    protected final int zzqy() {
        int i;
        int iZzqy = super.zzqy();
        if (this.zzzk != null) {
            long jLongValue = this.zzzk.longValue();
            int iZzbi = zzio.zzbi(1);
            if (((-128) & jLongValue) == 0) {
                i = 1;
            } else if (((-16384) & jLongValue) == 0) {
                i = 2;
            } else if (((-2097152) & jLongValue) == 0) {
                i = 3;
            } else if (((-268435456) & jLongValue) == 0) {
                i = 4;
            } else if (((-34359738368L) & jLongValue) == 0) {
                i = 5;
            } else if (((-4398046511104L) & jLongValue) == 0) {
                i = 6;
            } else if (((-562949953421312L) & jLongValue) == 0) {
                i = 7;
            } else if (((-72057594037927936L) & jLongValue) == 0) {
                i = 8;
            } else {
                i = (jLongValue & Long.MIN_VALUE) == 0 ? 9 : 10;
            }
            iZzqy += iZzbi + i;
        }
        if (this.zzcg != null) {
            iZzqy += zzio.zzc(2, this.zzcg);
        }
        if (this.zzzl != null) {
            iZzqy += zzio.zzg(3, this.zzzl.intValue());
        }
        if (this.zzzm != null && this.zzzm.length > 0) {
            int iZzc = iZzqy;
            for (int i2 = 0; i2 < this.zzzm.length; i2++) {
                zzbq.zza zzaVar = this.zzzm[i2];
                if (zzaVar != null) {
                    iZzc += zzee.zzc(4, zzaVar);
                }
            }
            iZzqy = iZzc;
        }
        if (this.zzzn != null && this.zzzn.length > 0) {
            int iZzb = iZzqy;
            for (int i3 = 0; i3 < this.zzzn.length; i3++) {
                zzbx zzbxVar = this.zzzn[i3];
                if (zzbxVar != null) {
                    iZzb += zzio.zzb(5, zzbxVar);
                }
            }
            iZzqy = iZzb;
        }
        if (this.zzzo != null && this.zzzo.length > 0) {
            for (int i4 = 0; i4 < this.zzzo.length; i4++) {
                zzbv zzbvVar = this.zzzo[i4];
                if (zzbvVar != null) {
                    iZzqy += zzio.zzb(6, zzbvVar);
                }
            }
        }
        if (this.zzzp != null) {
            iZzqy += zzio.zzc(7, this.zzzp);
        }
        if (this.zzzq == null) {
            return iZzqy;
        }
        this.zzzq.booleanValue();
        return iZzqy + zzio.zzbi(8) + 1;
    }

    @Override // com.google.android.gms.internal.measurement.zziw
    public final /* synthetic */ zziw zza(zzil zzilVar) throws IOException {
        while (true) {
            int iZzsg = zzilVar.zzsg();
            if (iZzsg == 0) {
                return this;
            }
            if (iZzsg == 8) {
                this.zzzk = Long.valueOf(zzilVar.zztb());
            } else if (iZzsg == 18) {
                this.zzcg = zzilVar.readString();
            } else if (iZzsg == 24) {
                this.zzzl = Integer.valueOf(zzilVar.zzta());
            } else if (iZzsg == 34) {
                int iZzb = zzix.zzb(zzilVar, 34);
                int length = this.zzzm == null ? 0 : this.zzzm.length;
                zzbq.zza[] zzaVarArr = new zzbq.zza[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzzm, 0, zzaVarArr, 0, length);
                }
                while (length < zzaVarArr.length - 1) {
                    zzaVarArr[length] = (zzbq.zza) zzilVar.zza(zzbq.zza.zzkj());
                    zzilVar.zzsg();
                    length++;
                }
                zzaVarArr[length] = (zzbq.zza) zzilVar.zza(zzbq.zza.zzkj());
                this.zzzm = zzaVarArr;
            } else if (iZzsg == 42) {
                int iZzb2 = zzix.zzb(zzilVar, 42);
                int length2 = this.zzzn == null ? 0 : this.zzzn.length;
                zzbx[] zzbxVarArr = new zzbx[iZzb2 + length2];
                if (length2 != 0) {
                    System.arraycopy(this.zzzn, 0, zzbxVarArr, 0, length2);
                }
                while (length2 < zzbxVarArr.length - 1) {
                    zzbxVarArr[length2] = new zzbx();
                    zzilVar.zza(zzbxVarArr[length2]);
                    zzilVar.zzsg();
                    length2++;
                }
                zzbxVarArr[length2] = new zzbx();
                zzilVar.zza(zzbxVarArr[length2]);
                this.zzzn = zzbxVarArr;
            } else if (iZzsg == 50) {
                int iZzb3 = zzix.zzb(zzilVar, 50);
                int length3 = this.zzzo == null ? 0 : this.zzzo.length;
                zzbv[] zzbvVarArr = new zzbv[iZzb3 + length3];
                if (length3 != 0) {
                    System.arraycopy(this.zzzo, 0, zzbvVarArr, 0, length3);
                }
                while (length3 < zzbvVarArr.length - 1) {
                    zzbvVarArr[length3] = new zzbv();
                    zzilVar.zza(zzbvVarArr[length3]);
                    zzilVar.zzsg();
                    length3++;
                }
                zzbvVarArr[length3] = new zzbv();
                zzilVar.zza(zzbvVarArr[length3]);
                this.zzzo = zzbvVarArr;
            } else if (iZzsg == 58) {
                this.zzzp = zzilVar.readString();
            } else if (iZzsg != 64) {
                if (!super.zza(zzilVar, iZzsg)) {
                    return this;
                }
            } else {
                this.zzzq = Boolean.valueOf(zzilVar.zzsm());
            }
        }
    }
}

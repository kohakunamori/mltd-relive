package com.google.android.gms.internal.measurement;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class zzec implements zzgy {
    private int tag;
    private final zzeb zzadu;
    private int zzadv;
    private int zzadw = 0;

    public static zzec zza(zzeb zzebVar) {
        return zzebVar.zzads != null ? zzebVar.zzads : new zzec(zzebVar);
    }

    private zzec(zzeb zzebVar) {
        this.zzadu = (zzeb) zzez.zza(zzebVar, "input");
        this.zzadu.zzads = this;
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final int zzsy() throws IOException {
        if (this.zzadw != 0) {
            this.tag = this.zzadw;
            this.zzadw = 0;
        } else {
            this.tag = this.zzadu.zzsg();
        }
        if (this.tag == 0 || this.tag == this.zzadv) {
            return Integer.MAX_VALUE;
        }
        return this.tag >>> 3;
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final int getTag() {
        return this.tag;
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final boolean zzsz() throws IOException {
        if (this.zzadu.zzsw() || this.tag == this.zzadv) {
            return false;
        }
        return this.zzadu.zzau(this.tag);
    }

    private final void zzba(int i) throws IOException {
        if ((this.tag & 7) != i) {
            throw zzfi.zzuy();
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final double readDouble() throws IOException {
        zzba(1);
        return this.zzadu.readDouble();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final float readFloat() throws IOException {
        zzba(5);
        return this.zzadu.readFloat();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final long zzsh() throws IOException {
        zzba(0);
        return this.zzadu.zzsh();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final long zzsi() throws IOException {
        zzba(0);
        return this.zzadu.zzsi();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final int zzsj() throws IOException {
        zzba(0);
        return this.zzadu.zzsj();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final long zzsk() throws IOException {
        zzba(1);
        return this.zzadu.zzsk();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final int zzsl() throws IOException {
        zzba(5);
        return this.zzadu.zzsl();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final boolean zzsm() throws IOException {
        zzba(0);
        return this.zzadu.zzsm();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final String readString() throws IOException {
        zzba(2);
        return this.zzadu.readString();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final String zzsn() throws IOException {
        zzba(2);
        return this.zzadu.zzsn();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final <T> T zza(zzgx<T> zzgxVar, zzel zzelVar) throws IOException {
        zzba(2);
        return (T) zzc(zzgxVar, zzelVar);
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final <T> T zzb(zzgx<T> zzgxVar, zzel zzelVar) throws IOException {
        zzba(3);
        return (T) zzd(zzgxVar, zzelVar);
    }

    private final <T> T zzc(zzgx<T> zzgxVar, zzel zzelVar) throws IOException {
        int iZzsp = this.zzadu.zzsp();
        if (this.zzadu.zzadp >= this.zzadu.zzadq) {
            throw zzfi.zzuz();
        }
        int iZzaw = this.zzadu.zzaw(iZzsp);
        T tNewInstance = zzgxVar.newInstance();
        this.zzadu.zzadp++;
        zzgxVar.zza(tNewInstance, this, zzelVar);
        zzgxVar.zzj(tNewInstance);
        this.zzadu.zzat(0);
        this.zzadu.zzadp--;
        this.zzadu.zzax(iZzaw);
        return tNewInstance;
    }

    private final <T> T zzd(zzgx<T> zzgxVar, zzel zzelVar) throws IOException {
        int i = this.zzadv;
        this.zzadv = ((this.tag >>> 3) << 3) | 4;
        try {
            T tNewInstance = zzgxVar.newInstance();
            zzgxVar.zza(tNewInstance, this, zzelVar);
            zzgxVar.zzj(tNewInstance);
            if (this.tag != this.zzadv) {
                throw zzfi.zzva();
            }
            this.zzadv = i;
            return tNewInstance;
        } catch (Throwable th) {
            this.zzadv = i;
            throw th;
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final zzdp zzso() throws IOException {
        zzba(2);
        return this.zzadu.zzso();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final int zzsp() throws IOException {
        zzba(0);
        return this.zzadu.zzsp();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final int zzsq() throws IOException {
        zzba(0);
        return this.zzadu.zzsq();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final int zzsr() throws IOException {
        zzba(5);
        return this.zzadu.zzsr();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final long zzss() throws IOException {
        zzba(1);
        return this.zzadu.zzss();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final int zzst() throws IOException {
        zzba(0);
        return this.zzadu.zzst();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final long zzsu() throws IOException {
        zzba(0);
        return this.zzadu.zzsu();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zze(List<Double> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzeh) {
            zzeh zzehVar = (zzeh) list;
            switch (this.tag & 7) {
                case 1:
                    break;
                case 2:
                    int iZzsp = this.zzadu.zzsp();
                    zzbb(iZzsp);
                    int iZzsx = this.zzadu.zzsx() + iZzsp;
                    do {
                        zzehVar.zzf(this.zzadu.readDouble());
                    } while (this.zzadu.zzsx() < iZzsx);
                    return;
                default:
                    throw zzfi.zzuy();
            }
            do {
                zzehVar.zzf(this.zzadu.readDouble());
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg2 = this.zzadu.zzsg();
                }
            } while (iZzsg2 == this.tag);
            this.zzadw = iZzsg2;
            return;
        }
        switch (this.tag & 7) {
            case 1:
                break;
            case 2:
                int iZzsp2 = this.zzadu.zzsp();
                zzbb(iZzsp2);
                int iZzsx2 = this.zzadu.zzsx() + iZzsp2;
                do {
                    list.add(Double.valueOf(this.zzadu.readDouble()));
                } while (this.zzadu.zzsx() < iZzsx2);
                return;
            default:
                throw zzfi.zzuy();
        }
        do {
            list.add(Double.valueOf(this.zzadu.readDouble()));
            if (this.zzadu.zzsw()) {
                return;
            } else {
                iZzsg = this.zzadu.zzsg();
            }
        } while (iZzsg == this.tag);
        this.zzadw = iZzsg;
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzf(List<Float> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzeu) {
            zzeu zzeuVar = (zzeu) list;
            int i = this.tag & 7;
            if (i == 2) {
                int iZzsp = this.zzadu.zzsp();
                zzbc(iZzsp);
                int iZzsx = this.zzadu.zzsx() + iZzsp;
                do {
                    zzeuVar.zzc(this.zzadu.readFloat());
                } while (this.zzadu.zzsx() < iZzsx);
                return;
            }
            if (i == 5) {
                do {
                    zzeuVar.zzc(this.zzadu.readFloat());
                    if (this.zzadu.zzsw()) {
                        return;
                    } else {
                        iZzsg2 = this.zzadu.zzsg();
                    }
                } while (iZzsg2 == this.tag);
                this.zzadw = iZzsg2;
                return;
            }
            throw zzfi.zzuy();
        }
        int i2 = this.tag & 7;
        if (i2 == 2) {
            int iZzsp2 = this.zzadu.zzsp();
            zzbc(iZzsp2);
            int iZzsx2 = this.zzadu.zzsx() + iZzsp2;
            do {
                list.add(Float.valueOf(this.zzadu.readFloat()));
            } while (this.zzadu.zzsx() < iZzsx2);
            return;
        }
        if (i2 == 5) {
            do {
                list.add(Float.valueOf(this.zzadu.readFloat()));
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg = this.zzadu.zzsg();
                }
            } while (iZzsg == this.tag);
            this.zzadw = iZzsg;
            return;
        }
        throw zzfi.zzuy();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzg(List<Long> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzfw) {
            zzfw zzfwVar = (zzfw) list;
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    zzfwVar.zzby(this.zzadu.zzsh());
                    if (this.zzadu.zzsw()) {
                        return;
                    } else {
                        iZzsg2 = this.zzadu.zzsg();
                    }
                } while (iZzsg2 == this.tag);
                this.zzadw = iZzsg2;
                return;
            }
            if (i == 2) {
                int iZzsx = this.zzadu.zzsx() + this.zzadu.zzsp();
                do {
                    zzfwVar.zzby(this.zzadu.zzsh());
                } while (this.zzadu.zzsx() < iZzsx);
                zzbd(iZzsx);
                return;
            }
            throw zzfi.zzuy();
        }
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                list.add(Long.valueOf(this.zzadu.zzsh()));
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg = this.zzadu.zzsg();
                }
            } while (iZzsg == this.tag);
            this.zzadw = iZzsg;
            return;
        }
        if (i2 == 2) {
            int iZzsx2 = this.zzadu.zzsx() + this.zzadu.zzsp();
            do {
                list.add(Long.valueOf(this.zzadu.zzsh()));
            } while (this.zzadu.zzsx() < iZzsx2);
            zzbd(iZzsx2);
            return;
        }
        throw zzfi.zzuy();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzh(List<Long> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzfw) {
            zzfw zzfwVar = (zzfw) list;
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    zzfwVar.zzby(this.zzadu.zzsi());
                    if (this.zzadu.zzsw()) {
                        return;
                    } else {
                        iZzsg2 = this.zzadu.zzsg();
                    }
                } while (iZzsg2 == this.tag);
                this.zzadw = iZzsg2;
                return;
            }
            if (i == 2) {
                int iZzsx = this.zzadu.zzsx() + this.zzadu.zzsp();
                do {
                    zzfwVar.zzby(this.zzadu.zzsi());
                } while (this.zzadu.zzsx() < iZzsx);
                zzbd(iZzsx);
                return;
            }
            throw zzfi.zzuy();
        }
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                list.add(Long.valueOf(this.zzadu.zzsi()));
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg = this.zzadu.zzsg();
                }
            } while (iZzsg == this.tag);
            this.zzadw = iZzsg;
            return;
        }
        if (i2 == 2) {
            int iZzsx2 = this.zzadu.zzsx() + this.zzadu.zzsp();
            do {
                list.add(Long.valueOf(this.zzadu.zzsi()));
            } while (this.zzadu.zzsx() < iZzsx2);
            zzbd(iZzsx2);
            return;
        }
        throw zzfi.zzuy();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzi(List<Integer> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzfa) {
            zzfa zzfaVar = (zzfa) list;
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    zzfaVar.zzbu(this.zzadu.zzsj());
                    if (this.zzadu.zzsw()) {
                        return;
                    } else {
                        iZzsg2 = this.zzadu.zzsg();
                    }
                } while (iZzsg2 == this.tag);
                this.zzadw = iZzsg2;
                return;
            }
            if (i == 2) {
                int iZzsx = this.zzadu.zzsx() + this.zzadu.zzsp();
                do {
                    zzfaVar.zzbu(this.zzadu.zzsj());
                } while (this.zzadu.zzsx() < iZzsx);
                zzbd(iZzsx);
                return;
            }
            throw zzfi.zzuy();
        }
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                list.add(Integer.valueOf(this.zzadu.zzsj()));
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg = this.zzadu.zzsg();
                }
            } while (iZzsg == this.tag);
            this.zzadw = iZzsg;
            return;
        }
        if (i2 == 2) {
            int iZzsx2 = this.zzadu.zzsx() + this.zzadu.zzsp();
            do {
                list.add(Integer.valueOf(this.zzadu.zzsj()));
            } while (this.zzadu.zzsx() < iZzsx2);
            zzbd(iZzsx2);
            return;
        }
        throw zzfi.zzuy();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzj(List<Long> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzfw) {
            zzfw zzfwVar = (zzfw) list;
            switch (this.tag & 7) {
                case 1:
                    break;
                case 2:
                    int iZzsp = this.zzadu.zzsp();
                    zzbb(iZzsp);
                    int iZzsx = this.zzadu.zzsx() + iZzsp;
                    do {
                        zzfwVar.zzby(this.zzadu.zzsk());
                    } while (this.zzadu.zzsx() < iZzsx);
                    return;
                default:
                    throw zzfi.zzuy();
            }
            do {
                zzfwVar.zzby(this.zzadu.zzsk());
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg2 = this.zzadu.zzsg();
                }
            } while (iZzsg2 == this.tag);
            this.zzadw = iZzsg2;
            return;
        }
        switch (this.tag & 7) {
            case 1:
                break;
            case 2:
                int iZzsp2 = this.zzadu.zzsp();
                zzbb(iZzsp2);
                int iZzsx2 = this.zzadu.zzsx() + iZzsp2;
                do {
                    list.add(Long.valueOf(this.zzadu.zzsk()));
                } while (this.zzadu.zzsx() < iZzsx2);
                return;
            default:
                throw zzfi.zzuy();
        }
        do {
            list.add(Long.valueOf(this.zzadu.zzsk()));
            if (this.zzadu.zzsw()) {
                return;
            } else {
                iZzsg = this.zzadu.zzsg();
            }
        } while (iZzsg == this.tag);
        this.zzadw = iZzsg;
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzk(List<Integer> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzfa) {
            zzfa zzfaVar = (zzfa) list;
            int i = this.tag & 7;
            if (i == 2) {
                int iZzsp = this.zzadu.zzsp();
                zzbc(iZzsp);
                int iZzsx = this.zzadu.zzsx() + iZzsp;
                do {
                    zzfaVar.zzbu(this.zzadu.zzsl());
                } while (this.zzadu.zzsx() < iZzsx);
                return;
            }
            if (i == 5) {
                do {
                    zzfaVar.zzbu(this.zzadu.zzsl());
                    if (this.zzadu.zzsw()) {
                        return;
                    } else {
                        iZzsg2 = this.zzadu.zzsg();
                    }
                } while (iZzsg2 == this.tag);
                this.zzadw = iZzsg2;
                return;
            }
            throw zzfi.zzuy();
        }
        int i2 = this.tag & 7;
        if (i2 == 2) {
            int iZzsp2 = this.zzadu.zzsp();
            zzbc(iZzsp2);
            int iZzsx2 = this.zzadu.zzsx() + iZzsp2;
            do {
                list.add(Integer.valueOf(this.zzadu.zzsl()));
            } while (this.zzadu.zzsx() < iZzsx2);
            return;
        }
        if (i2 == 5) {
            do {
                list.add(Integer.valueOf(this.zzadu.zzsl()));
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg = this.zzadu.zzsg();
                }
            } while (iZzsg == this.tag);
            this.zzadw = iZzsg;
            return;
        }
        throw zzfi.zzuy();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzl(List<Boolean> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzdn) {
            zzdn zzdnVar = (zzdn) list;
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    zzdnVar.addBoolean(this.zzadu.zzsm());
                    if (this.zzadu.zzsw()) {
                        return;
                    } else {
                        iZzsg2 = this.zzadu.zzsg();
                    }
                } while (iZzsg2 == this.tag);
                this.zzadw = iZzsg2;
                return;
            }
            if (i == 2) {
                int iZzsx = this.zzadu.zzsx() + this.zzadu.zzsp();
                do {
                    zzdnVar.addBoolean(this.zzadu.zzsm());
                } while (this.zzadu.zzsx() < iZzsx);
                zzbd(iZzsx);
                return;
            }
            throw zzfi.zzuy();
        }
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                list.add(Boolean.valueOf(this.zzadu.zzsm()));
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg = this.zzadu.zzsg();
                }
            } while (iZzsg == this.tag);
            this.zzadw = iZzsg;
            return;
        }
        if (i2 == 2) {
            int iZzsx2 = this.zzadu.zzsx() + this.zzadu.zzsp();
            do {
                list.add(Boolean.valueOf(this.zzadu.zzsm()));
            } while (this.zzadu.zzsx() < iZzsx2);
            zzbd(iZzsx2);
            return;
        }
        throw zzfi.zzuy();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void readStringList(List<String> list) throws IOException {
        zza(list, false);
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzm(List<String> list) throws IOException {
        zza(list, true);
    }

    private final void zza(List<String> list, boolean z) throws IOException {
        int iZzsg;
        int iZzsg2;
        if ((this.tag & 7) != 2) {
            throw zzfi.zzuy();
        }
        if ((list instanceof zzfp) && !z) {
            zzfp zzfpVar = (zzfp) list;
            do {
                zzfpVar.zzc(zzso());
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg2 = this.zzadu.zzsg();
                }
            } while (iZzsg2 == this.tag);
            this.zzadw = iZzsg2;
            return;
        }
        do {
            list.add(z ? zzsn() : readString());
            if (this.zzadu.zzsw()) {
                return;
            } else {
                iZzsg = this.zzadu.zzsg();
            }
        } while (iZzsg == this.tag);
        this.zzadw = iZzsg;
    }

    /* JADX WARN: Multi-variable type inference failed */
    @Override // com.google.android.gms.internal.measurement.zzgy
    public final <T> void zza(List<T> list, zzgx<T> zzgxVar, zzel zzelVar) throws IOException {
        int iZzsg;
        if ((this.tag & 7) != 2) {
            throw zzfi.zzuy();
        }
        int i = this.tag;
        do {
            list.add(zzc(zzgxVar, zzelVar));
            if (this.zzadu.zzsw() || this.zzadw != 0) {
                return;
            } else {
                iZzsg = this.zzadu.zzsg();
            }
        } while (iZzsg == i);
        this.zzadw = iZzsg;
    }

    /* JADX WARN: Multi-variable type inference failed */
    @Override // com.google.android.gms.internal.measurement.zzgy
    public final <T> void zzb(List<T> list, zzgx<T> zzgxVar, zzel zzelVar) throws IOException {
        int iZzsg;
        if ((this.tag & 7) != 3) {
            throw zzfi.zzuy();
        }
        int i = this.tag;
        do {
            list.add(zzd(zzgxVar, zzelVar));
            if (this.zzadu.zzsw() || this.zzadw != 0) {
                return;
            } else {
                iZzsg = this.zzadu.zzsg();
            }
        } while (iZzsg == i);
        this.zzadw = iZzsg;
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzn(List<zzdp> list) throws IOException {
        int iZzsg;
        if ((this.tag & 7) != 2) {
            throw zzfi.zzuy();
        }
        do {
            list.add(zzso());
            if (this.zzadu.zzsw()) {
                return;
            } else {
                iZzsg = this.zzadu.zzsg();
            }
        } while (iZzsg == this.tag);
        this.zzadw = iZzsg;
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzo(List<Integer> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzfa) {
            zzfa zzfaVar = (zzfa) list;
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    zzfaVar.zzbu(this.zzadu.zzsp());
                    if (this.zzadu.zzsw()) {
                        return;
                    } else {
                        iZzsg2 = this.zzadu.zzsg();
                    }
                } while (iZzsg2 == this.tag);
                this.zzadw = iZzsg2;
                return;
            }
            if (i == 2) {
                int iZzsx = this.zzadu.zzsx() + this.zzadu.zzsp();
                do {
                    zzfaVar.zzbu(this.zzadu.zzsp());
                } while (this.zzadu.zzsx() < iZzsx);
                zzbd(iZzsx);
                return;
            }
            throw zzfi.zzuy();
        }
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                list.add(Integer.valueOf(this.zzadu.zzsp()));
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg = this.zzadu.zzsg();
                }
            } while (iZzsg == this.tag);
            this.zzadw = iZzsg;
            return;
        }
        if (i2 == 2) {
            int iZzsx2 = this.zzadu.zzsx() + this.zzadu.zzsp();
            do {
                list.add(Integer.valueOf(this.zzadu.zzsp()));
            } while (this.zzadu.zzsx() < iZzsx2);
            zzbd(iZzsx2);
            return;
        }
        throw zzfi.zzuy();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzp(List<Integer> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzfa) {
            zzfa zzfaVar = (zzfa) list;
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    zzfaVar.zzbu(this.zzadu.zzsq());
                    if (this.zzadu.zzsw()) {
                        return;
                    } else {
                        iZzsg2 = this.zzadu.zzsg();
                    }
                } while (iZzsg2 == this.tag);
                this.zzadw = iZzsg2;
                return;
            }
            if (i == 2) {
                int iZzsx = this.zzadu.zzsx() + this.zzadu.zzsp();
                do {
                    zzfaVar.zzbu(this.zzadu.zzsq());
                } while (this.zzadu.zzsx() < iZzsx);
                zzbd(iZzsx);
                return;
            }
            throw zzfi.zzuy();
        }
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                list.add(Integer.valueOf(this.zzadu.zzsq()));
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg = this.zzadu.zzsg();
                }
            } while (iZzsg == this.tag);
            this.zzadw = iZzsg;
            return;
        }
        if (i2 == 2) {
            int iZzsx2 = this.zzadu.zzsx() + this.zzadu.zzsp();
            do {
                list.add(Integer.valueOf(this.zzadu.zzsq()));
            } while (this.zzadu.zzsx() < iZzsx2);
            zzbd(iZzsx2);
            return;
        }
        throw zzfi.zzuy();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzq(List<Integer> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzfa) {
            zzfa zzfaVar = (zzfa) list;
            int i = this.tag & 7;
            if (i == 2) {
                int iZzsp = this.zzadu.zzsp();
                zzbc(iZzsp);
                int iZzsx = this.zzadu.zzsx() + iZzsp;
                do {
                    zzfaVar.zzbu(this.zzadu.zzsr());
                } while (this.zzadu.zzsx() < iZzsx);
                return;
            }
            if (i == 5) {
                do {
                    zzfaVar.zzbu(this.zzadu.zzsr());
                    if (this.zzadu.zzsw()) {
                        return;
                    } else {
                        iZzsg2 = this.zzadu.zzsg();
                    }
                } while (iZzsg2 == this.tag);
                this.zzadw = iZzsg2;
                return;
            }
            throw zzfi.zzuy();
        }
        int i2 = this.tag & 7;
        if (i2 == 2) {
            int iZzsp2 = this.zzadu.zzsp();
            zzbc(iZzsp2);
            int iZzsx2 = this.zzadu.zzsx() + iZzsp2;
            do {
                list.add(Integer.valueOf(this.zzadu.zzsr()));
            } while (this.zzadu.zzsx() < iZzsx2);
            return;
        }
        if (i2 == 5) {
            do {
                list.add(Integer.valueOf(this.zzadu.zzsr()));
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg = this.zzadu.zzsg();
                }
            } while (iZzsg == this.tag);
            this.zzadw = iZzsg;
            return;
        }
        throw zzfi.zzuy();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzr(List<Long> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzfw) {
            zzfw zzfwVar = (zzfw) list;
            switch (this.tag & 7) {
                case 1:
                    break;
                case 2:
                    int iZzsp = this.zzadu.zzsp();
                    zzbb(iZzsp);
                    int iZzsx = this.zzadu.zzsx() + iZzsp;
                    do {
                        zzfwVar.zzby(this.zzadu.zzss());
                    } while (this.zzadu.zzsx() < iZzsx);
                    return;
                default:
                    throw zzfi.zzuy();
            }
            do {
                zzfwVar.zzby(this.zzadu.zzss());
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg2 = this.zzadu.zzsg();
                }
            } while (iZzsg2 == this.tag);
            this.zzadw = iZzsg2;
            return;
        }
        switch (this.tag & 7) {
            case 1:
                break;
            case 2:
                int iZzsp2 = this.zzadu.zzsp();
                zzbb(iZzsp2);
                int iZzsx2 = this.zzadu.zzsx() + iZzsp2;
                do {
                    list.add(Long.valueOf(this.zzadu.zzss()));
                } while (this.zzadu.zzsx() < iZzsx2);
                return;
            default:
                throw zzfi.zzuy();
        }
        do {
            list.add(Long.valueOf(this.zzadu.zzss()));
            if (this.zzadu.zzsw()) {
                return;
            } else {
                iZzsg = this.zzadu.zzsg();
            }
        } while (iZzsg == this.tag);
        this.zzadw = iZzsg;
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzs(List<Integer> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzfa) {
            zzfa zzfaVar = (zzfa) list;
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    zzfaVar.zzbu(this.zzadu.zzst());
                    if (this.zzadu.zzsw()) {
                        return;
                    } else {
                        iZzsg2 = this.zzadu.zzsg();
                    }
                } while (iZzsg2 == this.tag);
                this.zzadw = iZzsg2;
                return;
            }
            if (i == 2) {
                int iZzsx = this.zzadu.zzsx() + this.zzadu.zzsp();
                do {
                    zzfaVar.zzbu(this.zzadu.zzst());
                } while (this.zzadu.zzsx() < iZzsx);
                zzbd(iZzsx);
                return;
            }
            throw zzfi.zzuy();
        }
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                list.add(Integer.valueOf(this.zzadu.zzst()));
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg = this.zzadu.zzsg();
                }
            } while (iZzsg == this.tag);
            this.zzadw = iZzsg;
            return;
        }
        if (i2 == 2) {
            int iZzsx2 = this.zzadu.zzsx() + this.zzadu.zzsp();
            do {
                list.add(Integer.valueOf(this.zzadu.zzst()));
            } while (this.zzadu.zzsx() < iZzsx2);
            zzbd(iZzsx2);
            return;
        }
        throw zzfi.zzuy();
    }

    @Override // com.google.android.gms.internal.measurement.zzgy
    public final void zzt(List<Long> list) throws IOException {
        int iZzsg;
        int iZzsg2;
        if (list instanceof zzfw) {
            zzfw zzfwVar = (zzfw) list;
            int i = this.tag & 7;
            if (i == 0) {
                do {
                    zzfwVar.zzby(this.zzadu.zzsu());
                    if (this.zzadu.zzsw()) {
                        return;
                    } else {
                        iZzsg2 = this.zzadu.zzsg();
                    }
                } while (iZzsg2 == this.tag);
                this.zzadw = iZzsg2;
                return;
            }
            if (i == 2) {
                int iZzsx = this.zzadu.zzsx() + this.zzadu.zzsp();
                do {
                    zzfwVar.zzby(this.zzadu.zzsu());
                } while (this.zzadu.zzsx() < iZzsx);
                zzbd(iZzsx);
                return;
            }
            throw zzfi.zzuy();
        }
        int i2 = this.tag & 7;
        if (i2 == 0) {
            do {
                list.add(Long.valueOf(this.zzadu.zzsu()));
                if (this.zzadu.zzsw()) {
                    return;
                } else {
                    iZzsg = this.zzadu.zzsg();
                }
            } while (iZzsg == this.tag);
            this.zzadw = iZzsg;
            return;
        }
        if (i2 == 2) {
            int iZzsx2 = this.zzadu.zzsx() + this.zzadu.zzsp();
            do {
                list.add(Long.valueOf(this.zzadu.zzsu()));
            } while (this.zzadu.zzsx() < iZzsx2);
            zzbd(iZzsx2);
            return;
        }
        throw zzfi.zzuy();
    }

    private static void zzbb(int i) throws IOException {
        if ((i & 7) != 0) {
            throw zzfi.zzva();
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    @Override // com.google.android.gms.internal.measurement.zzgy
    public final <K, V> void zza(Map<K, V> map, zzfz<K, V> zzfzVar, zzel zzelVar) throws IOException {
        zzba(2);
        int iZzaw = this.zzadu.zzaw(this.zzadu.zzsp());
        Object objZza = zzfzVar.zzakc;
        Object objZza2 = zzfzVar.zzaba;
        while (true) {
            try {
                int iZzsy = zzsy();
                if (iZzsy != Integer.MAX_VALUE && !this.zzadu.zzsw()) {
                    switch (iZzsy) {
                        case 1:
                            objZza = zza(zzfzVar.zzakb, (Class<?>) null, (zzel) null);
                            continue;
                        case 2:
                            objZza2 = zza(zzfzVar.zzakd, zzfzVar.zzaba.getClass(), zzelVar);
                            continue;
                        default:
                            try {
                                if (!zzsz()) {
                                    throw new zzfi("Unable to parse map entry.");
                                }
                                continue;
                            } catch (zzfh unused) {
                                if (!zzsz()) {
                                    throw new zzfi("Unable to parse map entry.");
                                }
                            }
                    }
                    this.zzadu.zzax(iZzaw);
                    throw th;
                }
            } catch (Throwable th) {
                this.zzadu.zzax(iZzaw);
                throw th;
            }
        }
        map.put(objZza, objZza2);
        this.zzadu.zzax(iZzaw);
    }

    private final Object zza(zzig zzigVar, Class<?> cls, zzel zzelVar) throws IOException {
        switch (zzef.zzaee[zzigVar.ordinal()]) {
            case 1:
                return Boolean.valueOf(zzsm());
            case 2:
                return zzso();
            case 3:
                return Double.valueOf(readDouble());
            case 4:
                return Integer.valueOf(zzsq());
            case 5:
                return Integer.valueOf(zzsl());
            case 6:
                return Long.valueOf(zzsk());
            case 7:
                return Float.valueOf(readFloat());
            case 8:
                return Integer.valueOf(zzsj());
            case 9:
                return Long.valueOf(zzsi());
            case 10:
                zzba(2);
                return zzc(zzgt.zzvy().zzf(cls), zzelVar);
            case 11:
                return Integer.valueOf(zzsr());
            case 12:
                return Long.valueOf(zzss());
            case 13:
                return Integer.valueOf(zzst());
            case 14:
                return Long.valueOf(zzsu());
            case 15:
                return zzsn();
            case 16:
                return Integer.valueOf(zzsp());
            case 17:
                return Long.valueOf(zzsh());
            default:
                throw new RuntimeException("unsupported field type.");
        }
    }

    private static void zzbc(int i) throws IOException {
        if ((i & 3) != 0) {
            throw zzfi.zzva();
        }
    }

    private final void zzbd(int i) throws IOException {
        if (this.zzadu.zzsx() != i) {
            throw zzfi.zzut();
        }
    }
}

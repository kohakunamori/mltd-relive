package com.google.android.gms.internal.measurement;

import java.io.IOException;
import java.util.Arrays;

/* JADX INFO: loaded from: classes.dex */
final class zzed extends zzeb {
    private final byte[] buffer;
    private int limit;
    private int pos;
    private final boolean zzadx;
    private int zzady;
    private int zzadz;
    private int zzaea;
    private int zzaeb;

    private zzed(byte[] bArr, int i, int i2, boolean z) {
        super();
        this.zzaeb = Integer.MAX_VALUE;
        this.buffer = bArr;
        this.limit = i2 + i;
        this.pos = i;
        this.zzadz = this.pos;
        this.zzadx = z;
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final int zzsg() throws IOException {
        if (zzsw()) {
            this.zzaea = 0;
            return 0;
        }
        this.zzaea = zzta();
        if ((this.zzaea >>> 3) == 0) {
            throw zzfi.zzuw();
        }
        return this.zzaea;
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final void zzat(int i) throws zzfi {
        if (this.zzaea != i) {
            throw zzfi.zzux();
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final boolean zzau(int i) throws IOException {
        int iZzsg;
        int i2 = 0;
        switch (i & 7) {
            case 0:
                if (this.limit - this.pos >= 10) {
                    while (i2 < 10) {
                        byte[] bArr = this.buffer;
                        int i3 = this.pos;
                        this.pos = i3 + 1;
                        if (bArr[i3] < 0) {
                            i2++;
                        }
                    }
                    throw zzfi.zzuv();
                }
                while (i2 < 10) {
                    if (zztf() < 0) {
                        i2++;
                    }
                }
                throw zzfi.zzuv();
                return true;
            case 1:
                zzay(8);
                return true;
            case 2:
                zzay(zzta());
                return true;
            case 3:
                break;
            case 4:
                return false;
            case 5:
                zzay(4);
                return true;
            default:
                throw zzfi.zzuy();
        }
        do {
            iZzsg = zzsg();
            if (iZzsg != 0) {
            }
            zzat(((i >>> 3) << 3) | 4);
            return true;
        } while (zzau(iZzsg));
        zzat(((i >>> 3) << 3) | 4);
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final double readDouble() throws IOException {
        return Double.longBitsToDouble(zztd());
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final float readFloat() throws IOException {
        return Float.intBitsToFloat(zztc());
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final long zzsh() throws IOException {
        return zztb();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final long zzsi() throws IOException {
        return zztb();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final int zzsj() throws IOException {
        return zzta();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final long zzsk() throws IOException {
        return zztd();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final int zzsl() throws IOException {
        return zztc();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final boolean zzsm() throws IOException {
        return zztb() != 0;
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final String readString() throws IOException {
        int iZzta = zzta();
        if (iZzta > 0 && iZzta <= this.limit - this.pos) {
            String str = new String(this.buffer, this.pos, iZzta, zzez.UTF_8);
            this.pos += iZzta;
            return str;
        }
        if (iZzta == 0) {
            return "";
        }
        if (iZzta < 0) {
            throw zzfi.zzuu();
        }
        throw zzfi.zzut();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final String zzsn() throws IOException {
        int iZzta = zzta();
        if (iZzta > 0 && iZzta <= this.limit - this.pos) {
            String strZzh = zzhy.zzh(this.buffer, this.pos, iZzta);
            this.pos += iZzta;
            return strZzh;
        }
        if (iZzta == 0) {
            return "";
        }
        if (iZzta <= 0) {
            throw zzfi.zzuu();
        }
        throw zzfi.zzut();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final <T extends zzgi> T zza(zzgr<T> zzgrVar, zzel zzelVar) throws IOException {
        int iZzta = zzta();
        if (this.zzadp >= this.zzadq) {
            throw zzfi.zzuz();
        }
        int iZzaw = zzaw(iZzta);
        this.zzadp++;
        T tZzc = zzgrVar.zzc(this, zzelVar);
        zzat(0);
        this.zzadp--;
        zzax(iZzaw);
        return tZzc;
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final zzdp zzso() throws IOException {
        byte[] bArrCopyOfRange;
        int iZzta = zzta();
        if (iZzta > 0 && iZzta <= this.limit - this.pos) {
            zzdp zzdpVarZzb = zzdp.zzb(this.buffer, this.pos, iZzta);
            this.pos += iZzta;
            return zzdpVarZzb;
        }
        if (iZzta == 0) {
            return zzdp.zzadh;
        }
        if (iZzta > 0 && iZzta <= this.limit - this.pos) {
            int i = this.pos;
            this.pos += iZzta;
            bArrCopyOfRange = Arrays.copyOfRange(this.buffer, i, this.pos);
        } else {
            if (iZzta > 0) {
                throw zzfi.zzut();
            }
            if (iZzta == 0) {
                bArrCopyOfRange = zzez.zzair;
            } else {
                throw zzfi.zzuu();
            }
        }
        return zzdp.zze(bArrCopyOfRange);
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final int zzsp() throws IOException {
        return zzta();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final int zzsq() throws IOException {
        return zzta();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final int zzsr() throws IOException {
        return zztc();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final long zzss() throws IOException {
        return zztd();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final int zzst() throws IOException {
        return zzaz(zzta());
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final long zzsu() throws IOException {
        return zzbm(zztb());
    }

    /* JADX WARN: Code restructure failed: missing block: B:31:0x0068, code lost:
    
        if (r1[r2] >= 0) goto L32;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    private final int zzta() throws IOException {
        int i;
        int i2 = this.pos;
        if (this.limit != i2) {
            byte[] bArr = this.buffer;
            int i3 = i2 + 1;
            byte b = bArr[i2];
            if (b >= 0) {
                this.pos = i3;
                return b;
            }
            if (this.limit - i3 >= 9) {
                int i4 = i3 + 1;
                int i5 = b ^ (bArr[i3] << 7);
                if (i5 < 0) {
                    i = i5 ^ (-128);
                } else {
                    int i6 = i4 + 1;
                    int i7 = i5 ^ (bArr[i4] << 14);
                    if (i7 >= 0) {
                        i = i7 ^ 16256;
                    } else {
                        i4 = i6 + 1;
                        int i8 = i7 ^ (bArr[i6] << 21);
                        if (i8 < 0) {
                            i = i8 ^ (-2080896);
                        } else {
                            i6 = i4 + 1;
                            byte b2 = bArr[i4];
                            i = (i8 ^ (b2 << 28)) ^ 266354560;
                            if (b2 < 0) {
                                i4 = i6 + 1;
                                if (bArr[i6] < 0) {
                                    i6 = i4 + 1;
                                    if (bArr[i4] < 0) {
                                        i4 = i6 + 1;
                                        if (bArr[i6] < 0) {
                                            i6 = i4 + 1;
                                            if (bArr[i4] < 0) {
                                                i4 = i6 + 1;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    i4 = i6;
                }
                this.pos = i4;
                return i;
            }
        }
        return (int) zzsv();
    }

    /* JADX WARN: Code restructure failed: missing block: B:38:0x00b5, code lost:
    
        if (r1[r0] >= 0) goto L28;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    private final long zztb() throws IOException {
        int i;
        long j;
        long j2;
        long j3;
        long j4;
        int i2 = this.pos;
        if (this.limit != i2) {
            byte[] bArr = this.buffer;
            int i3 = i2 + 1;
            byte b = bArr[i2];
            if (b >= 0) {
                this.pos = i3;
                return b;
            }
            if (this.limit - i3 >= 9) {
                int i4 = i3 + 1;
                int i5 = b ^ (bArr[i3] << 7);
                if (i5 >= 0) {
                    int i6 = i4 + 1;
                    int i7 = i5 ^ (bArr[i4] << 14);
                    if (i7 >= 0) {
                        j4 = i7 ^ 16256;
                        i = i6;
                        j = j4;
                    } else {
                        i4 = i6 + 1;
                        int i8 = i7 ^ (bArr[i6] << 21);
                        if (i8 < 0) {
                            j3 = i8 ^ (-2080896);
                        } else {
                            long j5 = i8;
                            i = i4 + 1;
                            long j6 = (((long) bArr[i4]) << 28) ^ j5;
                            if (j6 >= 0) {
                                j = j6 ^ 266354560;
                            } else {
                                int i9 = i + 1;
                                long j7 = j6 ^ (((long) bArr[i]) << 35);
                                if (j7 < 0) {
                                    j2 = (-34093383808L) ^ j7;
                                } else {
                                    i = i9 + 1;
                                    long j8 = j7 ^ (((long) bArr[i9]) << 42);
                                    if (j8 >= 0) {
                                        j = j8 ^ 4363953127296L;
                                    } else {
                                        i9 = i + 1;
                                        long j9 = j8 ^ (((long) bArr[i]) << 49);
                                        if (j9 < 0) {
                                            j2 = (-558586000294016L) ^ j9;
                                        } else {
                                            i = i9 + 1;
                                            j = (j9 ^ (((long) bArr[i9]) << 56)) ^ 71499008037633920L;
                                            if (j < 0) {
                                                i9 = i + 1;
                                            }
                                        }
                                    }
                                }
                                j = j2;
                                i = i9;
                            }
                        }
                    }
                    this.pos = i;
                    return j;
                }
                j3 = i5 ^ (-128);
                j4 = j3;
                i = i4;
                j = j4;
                this.pos = i;
                return j;
            }
        }
        return zzsv();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    final long zzsv() throws IOException {
        long j = 0;
        for (int i = 0; i < 64; i += 7) {
            byte bZztf = zztf();
            j |= ((long) (bZztf & 127)) << i;
            if ((bZztf & 128) == 0) {
                return j;
            }
        }
        throw zzfi.zzuv();
    }

    private final int zztc() throws IOException {
        int i = this.pos;
        if (this.limit - i < 4) {
            throw zzfi.zzut();
        }
        byte[] bArr = this.buffer;
        this.pos = i + 4;
        return ((bArr[i + 3] & 255) << 24) | (bArr[i] & 255) | ((bArr[i + 1] & 255) << 8) | ((bArr[i + 2] & 255) << 16);
    }

    private final long zztd() throws IOException {
        int i = this.pos;
        if (this.limit - i < 8) {
            throw zzfi.zzut();
        }
        byte[] bArr = this.buffer;
        this.pos = i + 8;
        return ((((long) bArr[i + 7]) & 255) << 56) | (((long) bArr[i]) & 255) | ((((long) bArr[i + 1]) & 255) << 8) | ((((long) bArr[i + 2]) & 255) << 16) | ((((long) bArr[i + 3]) & 255) << 24) | ((((long) bArr[i + 4]) & 255) << 32) | ((((long) bArr[i + 5]) & 255) << 40) | ((((long) bArr[i + 6]) & 255) << 48);
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final int zzaw(int i) throws zzfi {
        if (i < 0) {
            throw zzfi.zzuu();
        }
        int iZzsx = i + zzsx();
        int i2 = this.zzaeb;
        if (iZzsx > i2) {
            throw zzfi.zzut();
        }
        this.zzaeb = iZzsx;
        zzte();
        return i2;
    }

    private final void zzte() {
        this.limit += this.zzady;
        int i = this.limit - this.zzadz;
        if (i > this.zzaeb) {
            this.zzady = i - this.zzaeb;
            this.limit -= this.zzady;
        } else {
            this.zzady = 0;
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final void zzax(int i) {
        this.zzaeb = i;
        zzte();
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final boolean zzsw() throws IOException {
        return this.pos == this.limit;
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final int zzsx() {
        return this.pos - this.zzadz;
    }

    private final byte zztf() throws IOException {
        if (this.pos == this.limit) {
            throw zzfi.zzut();
        }
        byte[] bArr = this.buffer;
        int i = this.pos;
        this.pos = i + 1;
        return bArr[i];
    }

    @Override // com.google.android.gms.internal.measurement.zzeb
    public final void zzay(int i) throws IOException {
        if (i >= 0 && i <= this.limit - this.pos) {
            this.pos += i;
        } else {
            if (i < 0) {
                throw zzfi.zzuu();
            }
            throw zzfi.zzut();
        }
    }
}

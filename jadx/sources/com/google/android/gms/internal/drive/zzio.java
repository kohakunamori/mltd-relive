package com.google.android.gms.internal.drive;

import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public final class zzio {
    private final byte[] buffer;
    private final int zzmn;
    private final int zzmo;
    private int zzmp;
    private int zzmq;
    private int zzmr;
    private int zzms = Integer.MAX_VALUE;
    private int zzmt = 64;
    private int zzmu = 67108864;

    private zzio(byte[] bArr, int i, int i2) {
        this.buffer = bArr;
        this.zzmn = i;
        int i3 = i2 + i;
        this.zzmp = i3;
        this.zzmo = i3;
        this.zzmq = i;
    }

    public static zzio zza(byte[] bArr, int i, int i2) {
        return new zzio(bArr, 0, i2);
    }

    private final byte zzbg() throws IOException {
        if (this.zzmq == this.zzmp) {
            throw zziw.zzbk();
        }
        byte[] bArr = this.buffer;
        int i = this.zzmq;
        this.zzmq = i + 1;
        return bArr[i];
    }

    private final void zzl(int i) throws IOException {
        if (i < 0) {
            throw zziw.zzbl();
        }
        if (this.zzmq + i > this.zzms) {
            zzl(this.zzms - this.zzmq);
            throw zziw.zzbk();
        }
        if (i > this.zzmp - this.zzmq) {
            throw zziw.zzbk();
        }
        this.zzmq += i;
    }

    public final int getPosition() {
        return this.zzmq - this.zzmn;
    }

    public final String readString() throws IOException {
        int iZzbe = zzbe();
        if (iZzbe < 0) {
            throw zziw.zzbl();
        }
        if (iZzbe > this.zzmp - this.zzmq) {
            throw zziw.zzbk();
        }
        String str = new String(this.buffer, this.zzmq, iZzbe, zziv.UTF_8);
        this.zzmq += iZzbe;
        return str;
    }

    public final byte[] zza(int i, int i2) {
        if (i2 == 0) {
            return zzja.zzns;
        }
        byte[] bArr = new byte[i2];
        System.arraycopy(this.buffer, this.zzmn + i, bArr, 0, i2);
        return bArr;
    }

    public final int zzbd() throws IOException {
        if (this.zzmq == this.zzmp) {
            this.zzmr = 0;
            return 0;
        }
        this.zzmr = zzbe();
        if (this.zzmr != 0) {
            return this.zzmr;
        }
        throw new zziw("Protocol message contained an invalid tag (zero).");
    }

    public final int zzbe() throws IOException {
        int i;
        byte bZzbg = zzbg();
        if (bZzbg >= 0) {
            return bZzbg;
        }
        int i2 = bZzbg & 127;
        byte bZzbg2 = zzbg();
        if (bZzbg2 >= 0) {
            i = bZzbg2 << 7;
        } else {
            i2 |= (bZzbg2 & 127) << 7;
            byte bZzbg3 = zzbg();
            if (bZzbg3 >= 0) {
                i = bZzbg3 << 14;
            } else {
                i2 |= (bZzbg3 & 127) << 14;
                byte bZzbg4 = zzbg();
                if (bZzbg4 < 0) {
                    int i3 = i2 | ((bZzbg4 & 127) << 21);
                    byte bZzbg5 = zzbg();
                    int i4 = i3 | (bZzbg5 << 28);
                    if (bZzbg5 >= 0) {
                        return i4;
                    }
                    for (int i5 = 0; i5 < 5; i5++) {
                        if (zzbg() >= 0) {
                            return i4;
                        }
                    }
                    throw zziw.zzbm();
                }
                i = bZzbg4 << 21;
            }
        }
        return i2 | i;
    }

    public final long zzbf() throws IOException {
        long j = 0;
        for (int i = 0; i < 64; i += 7) {
            byte bZzbg = zzbg();
            j |= ((long) (bZzbg & 127)) << i;
            if ((bZzbg & 128) == 0) {
                return j;
            }
        }
        throw zziw.zzbm();
    }

    public final void zzj(int i) throws zziw {
        if (this.zzmr != i) {
            throw new zziw("Protocol message end-group tag did not match expected tag.");
        }
    }

    public final boolean zzk(int i) throws IOException {
        int iZzbd;
        switch (i & 7) {
            case 0:
                zzbe();
                return true;
            case 1:
                zzbg();
                zzbg();
                zzbg();
                zzbg();
                zzbg();
                zzbg();
                zzbg();
                zzbg();
                return true;
            case 2:
                zzl(zzbe());
                return true;
            case 3:
                break;
            case 4:
                return false;
            case 5:
                zzbg();
                zzbg();
                zzbg();
                zzbg();
                return true;
            default:
                throw new zziw("Protocol message tag had invalid wire type.");
        }
        do {
            iZzbd = zzbd();
            if (iZzbd != 0) {
            }
            zzj(((i >>> 3) << 3) | 4);
            return true;
        } while (zzk(iZzbd));
        zzj(((i >>> 3) << 3) | 4);
        return true;
    }
}

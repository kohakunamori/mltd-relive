package com.google.android.gms.internal.measurement;

import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public final class zzil {
    private final byte[] buffer;
    private int zzadp;
    private int zzady;
    private int zzaea;
    private final int zzaoh;
    private int zzaoi;
    private zzeb zzaok;
    private int zzaeb = Integer.MAX_VALUE;
    private int zzadq = 64;
    private int zzadr = 67108864;
    private final int zzaog = 0;
    private int zzaoj = 0;

    public static zzil zzj(byte[] bArr, int i, int i2) {
        return new zzil(bArr, 0, i2);
    }

    public final int zzsg() throws IOException {
        if (this.zzaoj == this.zzaoi) {
            this.zzaea = 0;
            return 0;
        }
        this.zzaea = zzta();
        if (this.zzaea == 0) {
            throw new zzit("Protocol message contained an invalid tag (zero).");
        }
        return this.zzaea;
    }

    private final void zzat(int i) throws zzit {
        if (this.zzaea != i) {
            throw new zzit("Protocol message end-group tag did not match expected tag.");
        }
    }

    public final boolean zzau(int i) throws IOException {
        int iZzsg;
        switch (i & 7) {
            case 0:
                zzta();
                return true;
            case 1:
                zztf();
                zztf();
                zztf();
                zztf();
                zztf();
                zztf();
                zztf();
                zztf();
                return true;
            case 2:
                zzay(zzta());
                return true;
            case 3:
                break;
            case 4:
                return false;
            case 5:
                zztf();
                zztf();
                zztf();
                zztf();
                return true;
            default:
                throw new zzit("Protocol message tag had invalid wire type.");
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

    public final boolean zzsm() throws IOException {
        return zzta() != 0;
    }

    public final String readString() throws IOException {
        int iZzta = zzta();
        if (iZzta < 0) {
            throw zzit.zzxe();
        }
        if (iZzta > this.zzaoi - this.zzaoj) {
            throw zzit.zzxd();
        }
        String str = new String(this.buffer, this.zzaoj, iZzta, zziu.UTF_8);
        this.zzaoj += iZzta;
        return str;
    }

    public final void zza(zziw zziwVar) throws IOException {
        int iZzta = zzta();
        if (this.zzadp >= this.zzadq) {
            throw new zzit("Protocol message had too many levels of nesting.  May be malicious.  Use CodedInputStream.setRecursionLimit() to increase the depth limit.");
        }
        if (iZzta < 0) {
            throw zzit.zzxe();
        }
        int i = iZzta + this.zzaoj;
        int i2 = this.zzaeb;
        if (i > i2) {
            throw zzit.zzxd();
        }
        this.zzaeb = i;
        zzte();
        this.zzadp++;
        zziwVar.zza(this);
        zzat(0);
        this.zzadp--;
        this.zzaeb = i2;
        zzte();
    }

    public final int zzta() throws IOException {
        byte bZztf = zztf();
        if (bZztf >= 0) {
            return bZztf;
        }
        int i = bZztf & 127;
        byte bZztf2 = zztf();
        if (bZztf2 >= 0) {
            return i | (bZztf2 << 7);
        }
        int i2 = i | ((bZztf2 & 127) << 7);
        byte bZztf3 = zztf();
        if (bZztf3 >= 0) {
            return i2 | (bZztf3 << 14);
        }
        int i3 = i2 | ((bZztf3 & 127) << 14);
        byte bZztf4 = zztf();
        if (bZztf4 >= 0) {
            return i3 | (bZztf4 << 21);
        }
        int i4 = i3 | ((bZztf4 & 127) << 21);
        byte bZztf5 = zztf();
        int i5 = i4 | (bZztf5 << 28);
        if (bZztf5 >= 0) {
            return i5;
        }
        for (int i6 = 0; i6 < 5; i6++) {
            if (zztf() >= 0) {
                return i5;
            }
        }
        throw zzit.zzxf();
    }

    public final long zztb() throws IOException {
        long j = 0;
        for (int i = 0; i < 64; i += 7) {
            byte bZztf = zztf();
            j |= ((long) (bZztf & 127)) << i;
            if ((bZztf & 128) == 0) {
                return j;
            }
        }
        throw zzit.zzxf();
    }

    private zzil(byte[] bArr, int i, int i2) {
        this.buffer = bArr;
        int i3 = i2 + 0;
        this.zzaoi = i3;
        this.zzaoh = i3;
    }

    public final <T extends zzey<T, ?>> T zza(zzgr<T> zzgrVar) throws IOException {
        try {
            if (this.zzaok == null) {
                this.zzaok = zzeb.zzd(this.buffer, this.zzaog, this.zzaoh);
            }
            int iZzsx = this.zzaok.zzsx();
            int i = this.zzaoj - this.zzaog;
            if (iZzsx > i) {
                throw new IOException(String.format("CodedInputStream read ahead of CodedInputByteBufferNano: %s > %s", Integer.valueOf(iZzsx), Integer.valueOf(i)));
            }
            this.zzaok.zzay(i - iZzsx);
            this.zzaok.zzav(this.zzadq - this.zzadp);
            T t = (T) this.zzaok.zza(zzgrVar, zzel.zztq());
            zzau(this.zzaea);
            return t;
        } catch (zzfi e) {
            throw new zzit("", e);
        }
    }

    private final void zzte() {
        this.zzaoi += this.zzady;
        int i = this.zzaoi;
        if (i > this.zzaeb) {
            this.zzady = i - this.zzaeb;
            this.zzaoi -= this.zzady;
        } else {
            this.zzady = 0;
        }
    }

    public final int getPosition() {
        return this.zzaoj - this.zzaog;
    }

    public final byte[] zzt(int i, int i2) {
        if (i2 == 0) {
            return zzix.zzaph;
        }
        byte[] bArr = new byte[i2];
        System.arraycopy(this.buffer, this.zzaog + i, bArr, 0, i2);
        return bArr;
    }

    final void zzu(int i, int i2) {
        if (i > this.zzaoj - this.zzaog) {
            int i3 = this.zzaoj - this.zzaog;
            StringBuilder sb = new StringBuilder(50);
            sb.append("Position ");
            sb.append(i);
            sb.append(" is beyond current ");
            sb.append(i3);
            throw new IllegalArgumentException(sb.toString());
        }
        if (i < 0) {
            StringBuilder sb2 = new StringBuilder(24);
            sb2.append("Bad position ");
            sb2.append(i);
            throw new IllegalArgumentException(sb2.toString());
        }
        this.zzaoj = this.zzaog + i;
        this.zzaea = i2;
    }

    private final byte zztf() throws IOException {
        if (this.zzaoj == this.zzaoi) {
            throw zzit.zzxd();
        }
        byte[] bArr = this.buffer;
        int i = this.zzaoj;
        this.zzaoj = i + 1;
        return bArr[i];
    }

    private final void zzay(int i) throws IOException {
        if (i < 0) {
            throw zzit.zzxe();
        }
        if (this.zzaoj + i > this.zzaeb) {
            zzay(this.zzaeb - this.zzaoj);
            throw zzit.zzxd();
        }
        if (i <= this.zzaoi - this.zzaoj) {
            this.zzaoj += i;
            return;
        }
        throw zzit.zzxd();
    }
}

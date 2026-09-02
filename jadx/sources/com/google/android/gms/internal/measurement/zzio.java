package com.google.android.gms.internal.measurement;

import com.google.android.gms.games.Notifications;
import java.io.IOException;
import java.nio.BufferOverflowException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.ReadOnlyBufferException;

/* JADX INFO: loaded from: classes.dex */
public final class zzio {
    private final ByteBuffer zzaei;
    private zzee zzaol;
    private int zzaom;

    private zzio(byte[] bArr, int i, int i2) {
        this(ByteBuffer.wrap(bArr, 0, i2));
    }

    public static int zzbq(int i) {
        if ((i & (-128)) == 0) {
            return 1;
        }
        if ((i & (-16384)) == 0) {
            return 2;
        }
        if (((-2097152) & i) == 0) {
            return 3;
        }
        return (i & (-268435456)) == 0 ? 4 : 5;
    }

    private zzio(ByteBuffer byteBuffer) {
        this.zzaei = byteBuffer;
        this.zzaei.order(ByteOrder.LITTLE_ENDIAN);
    }

    public static zzio zzj(byte[] bArr) {
        return new zzio(bArr, 0, bArr.length);
    }

    public static zzio zzk(byte[] bArr, int i, int i2) {
        return new zzio(bArr, 0, i2);
    }

    public final void zzc(int i, int i2) throws IOException {
        zzb(i, 0);
        if (i2 >= 0) {
            zzck(i2);
        } else {
            zzbz(i2);
        }
    }

    public final void zzb(int i, boolean z) throws IOException {
        zzb(i, 0);
        byte b = z ? (byte) 1 : (byte) 0;
        if (!this.zzaei.hasRemaining()) {
            throw new zzin(this.zzaei.position(), this.zzaei.limit());
        }
        this.zzaei.put(b);
    }

    public final void zzb(int i, String str) throws IOException {
        zzb(i, 2);
        try {
            int iZzbq = zzbq(str.length());
            if (iZzbq == zzbq(str.length() * 3)) {
                int iPosition = this.zzaei.position();
                if (this.zzaei.remaining() < iZzbq) {
                    throw new zzin(iPosition + iZzbq, this.zzaei.limit());
                }
                this.zzaei.position(iPosition + iZzbq);
                zzd(str, this.zzaei);
                int iPosition2 = this.zzaei.position();
                this.zzaei.position(iPosition);
                zzck((iPosition2 - iPosition) - iZzbq);
                this.zzaei.position(iPosition2);
                return;
            }
            zzck(zza(str));
            zzd(str, this.zzaei);
        } catch (BufferOverflowException e) {
            zzin zzinVar = new zzin(this.zzaei.position(), this.zzaei.limit());
            zzinVar.initCause(e);
            throw zzinVar;
        }
    }

    public final void zza(int i, zziw zziwVar) throws IOException {
        zzb(i, 2);
        if (zziwVar.zzaow < 0) {
            zziwVar.zzuk();
        }
        zzck(zziwVar.zzaow);
        zziwVar.zza(this);
    }

    public final void zze(int i, zzgi zzgiVar) throws IOException {
        if (this.zzaol == null) {
            this.zzaol = zzee.zza(this.zzaei);
            this.zzaom = this.zzaei.position();
        } else if (this.zzaom != this.zzaei.position()) {
            this.zzaol.write(this.zzaei.array(), this.zzaom, this.zzaei.position() - this.zzaom);
            this.zzaom = this.zzaei.position();
        }
        zzee zzeeVar = this.zzaol;
        zzeeVar.zza(i, zzgiVar);
        zzeeVar.flush();
        this.zzaom = this.zzaei.position();
    }

    private static int zza(CharSequence charSequence) {
        int length = charSequence.length();
        int i = 0;
        int i2 = 0;
        while (i2 < length && charSequence.charAt(i2) < 128) {
            i2++;
        }
        int i3 = length;
        while (i2 < length) {
            char cCharAt = charSequence.charAt(i2);
            if (cCharAt >= 2048) {
                int length2 = charSequence.length();
                while (i2 < length2) {
                    char cCharAt2 = charSequence.charAt(i2);
                    if (cCharAt2 < 2048) {
                        i += (127 - cCharAt2) >>> 31;
                    } else {
                        i += 2;
                        if (55296 <= cCharAt2 && cCharAt2 <= 57343) {
                            if (Character.codePointAt(charSequence, i2) < 65536) {
                                StringBuilder sb = new StringBuilder(39);
                                sb.append("Unpaired surrogate at index ");
                                sb.append(i2);
                                throw new IllegalArgumentException(sb.toString());
                            }
                            i2++;
                        }
                    }
                    i2++;
                }
                i3 += i;
                break;
            }
            i3 += (127 - cCharAt) >>> 31;
            i2++;
        }
        if (i3 >= length) {
            return i3;
        }
        long j = ((long) i3) + 4294967296L;
        StringBuilder sb2 = new StringBuilder(54);
        sb2.append("UTF-8 length does not fit in int: ");
        sb2.append(j);
        throw new IllegalArgumentException(sb2.toString());
    }

    private static void zzd(CharSequence charSequence, ByteBuffer byteBuffer) {
        int i;
        int i2;
        char cCharAt;
        if (byteBuffer.isReadOnly()) {
            throw new ReadOnlyBufferException();
        }
        int i3 = 0;
        if (byteBuffer.hasArray()) {
            try {
                byte[] bArrArray = byteBuffer.array();
                int iArrayOffset = byteBuffer.arrayOffset() + byteBuffer.position();
                int iRemaining = byteBuffer.remaining();
                int length = charSequence.length();
                int i4 = iRemaining + iArrayOffset;
                while (i3 < length) {
                    int i5 = i3 + iArrayOffset;
                    if (i5 >= i4 || (cCharAt = charSequence.charAt(i3)) >= 128) {
                        break;
                    }
                    bArrArray[i5] = (byte) cCharAt;
                    i3++;
                }
                if (i3 == length) {
                    i = iArrayOffset + length;
                } else {
                    i = iArrayOffset + i3;
                    while (i3 < length) {
                        char cCharAt2 = charSequence.charAt(i3);
                        if (cCharAt2 >= 128 || i >= i4) {
                            if (cCharAt2 < 2048 && i <= i4 - 2) {
                                int i6 = i + 1;
                                bArrArray[i] = (byte) ((cCharAt2 >>> 6) | 960);
                                i = i6 + 1;
                                bArrArray[i6] = (byte) ((cCharAt2 & '?') | 128);
                            } else {
                                if ((cCharAt2 >= 55296 && 57343 >= cCharAt2) || i > i4 - 3) {
                                    if (i <= i4 - 4) {
                                        int i7 = i3 + 1;
                                        if (i7 != charSequence.length()) {
                                            char cCharAt3 = charSequence.charAt(i7);
                                            if (Character.isSurrogatePair(cCharAt2, cCharAt3)) {
                                                int codePoint = Character.toCodePoint(cCharAt2, cCharAt3);
                                                int i8 = i + 1;
                                                bArrArray[i] = (byte) ((codePoint >>> 18) | 240);
                                                int i9 = i8 + 1;
                                                bArrArray[i8] = (byte) (((codePoint >>> 12) & 63) | 128);
                                                int i10 = i9 + 1;
                                                bArrArray[i9] = (byte) (((codePoint >>> 6) & 63) | 128);
                                                i = i10 + 1;
                                                bArrArray[i10] = (byte) ((codePoint & 63) | 128);
                                                i3 = i7;
                                            } else {
                                                i3 = i7;
                                            }
                                        }
                                        StringBuilder sb = new StringBuilder(39);
                                        sb.append("Unpaired surrogate at index ");
                                        sb.append(i3 - 1);
                                        throw new IllegalArgumentException(sb.toString());
                                    }
                                    StringBuilder sb2 = new StringBuilder(37);
                                    sb2.append("Failed writing ");
                                    sb2.append(cCharAt2);
                                    sb2.append(" at index ");
                                    sb2.append(i);
                                    throw new ArrayIndexOutOfBoundsException(sb2.toString());
                                }
                                int i11 = i + 1;
                                bArrArray[i] = (byte) ((cCharAt2 >>> '\f') | 480);
                                int i12 = i11 + 1;
                                bArrArray[i11] = (byte) (((cCharAt2 >>> 6) & 63) | 128);
                                i2 = i12 + 1;
                                bArrArray[i12] = (byte) ((cCharAt2 & '?') | 128);
                            }
                            i3++;
                        } else {
                            i2 = i + 1;
                            bArrArray[i] = (byte) cCharAt2;
                        }
                        i = i2;
                        i3++;
                    }
                }
                byteBuffer.position(i - byteBuffer.arrayOffset());
                return;
            } catch (ArrayIndexOutOfBoundsException e) {
                BufferOverflowException bufferOverflowException = new BufferOverflowException();
                bufferOverflowException.initCause(e);
                throw bufferOverflowException;
            }
        }
        int length2 = charSequence.length();
        while (i3 < length2) {
            char cCharAt4 = charSequence.charAt(i3);
            if (cCharAt4 < 128) {
                byteBuffer.put((byte) cCharAt4);
            } else if (cCharAt4 < 2048) {
                byteBuffer.put((byte) ((cCharAt4 >>> 6) | 960));
                byteBuffer.put((byte) ((cCharAt4 & '?') | 128));
            } else if (cCharAt4 < 55296 || 57343 < cCharAt4) {
                byteBuffer.put((byte) ((cCharAt4 >>> '\f') | 480));
                byteBuffer.put((byte) (((cCharAt4 >>> 6) & 63) | 128));
                byteBuffer.put((byte) ((cCharAt4 & '?') | 128));
            } else {
                int i13 = i3 + 1;
                if (i13 != charSequence.length()) {
                    char cCharAt5 = charSequence.charAt(i13);
                    if (Character.isSurrogatePair(cCharAt4, cCharAt5)) {
                        int codePoint2 = Character.toCodePoint(cCharAt4, cCharAt5);
                        byteBuffer.put((byte) ((codePoint2 >>> 18) | 240));
                        byteBuffer.put((byte) (((codePoint2 >>> 12) & 63) | 128));
                        byteBuffer.put((byte) (((codePoint2 >>> 6) & 63) | 128));
                        byteBuffer.put((byte) ((codePoint2 & 63) | 128));
                        i3 = i13;
                    } else {
                        i3 = i13;
                    }
                }
                StringBuilder sb3 = new StringBuilder(39);
                sb3.append("Unpaired surrogate at index ");
                sb3.append(i3 - 1);
                throw new IllegalArgumentException(sb3.toString());
            }
            i3++;
        }
    }

    public static int zzg(int i, int i2) {
        return zzbi(i) + zzbj(i2);
    }

    public static int zzc(int i, String str) {
        int iZzbi = zzbi(i);
        int iZza = zza(str);
        return iZzbi + zzbq(iZza) + iZza;
    }

    public static int zzb(int i, zziw zziwVar) {
        int iZzbi = zzbi(i);
        int iZzuk = zziwVar.zzuk();
        return iZzbi + zzbq(iZzuk) + iZzuk;
    }

    public static int zzbj(int i) {
        if (i >= 0) {
            return zzbq(i);
        }
        return 10;
    }

    private final void zzcj(int i) throws IOException {
        byte b = (byte) i;
        if (!this.zzaei.hasRemaining()) {
            throw new zzin(this.zzaei.position(), this.zzaei.limit());
        }
        this.zzaei.put(b);
    }

    public final void zzk(byte[] bArr) throws IOException {
        int length = bArr.length;
        if (this.zzaei.remaining() >= length) {
            this.zzaei.put(bArr, 0, length);
            return;
        }
        throw new zzin(this.zzaei.position(), this.zzaei.limit());
    }

    public final void zzb(int i, int i2) throws IOException {
        zzck((i << 3) | i2);
    }

    public static int zzbi(int i) {
        return zzbq(i << 3);
    }

    public final void zzck(int i) throws IOException {
        while ((i & (-128)) != 0) {
            zzcj((i & Notifications.NOTIFICATION_TYPES_ALL) | 128);
            i >>>= 7;
        }
        zzcj(i);
    }

    public final void zzbz(long j) throws IOException {
        while (((-128) & j) != 0) {
            zzcj((((int) j) & Notifications.NOTIFICATION_TYPES_ALL) | 128);
            j >>>= 7;
        }
        zzcj((int) j);
    }
}

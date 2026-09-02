package com.google.android.gms.internal.measurement;

import java.nio.ByteBuffer;

/* JADX INFO: loaded from: classes.dex */
final class zzie extends zzhz {
    zzie() {
    }

    @Override // com.google.android.gms.internal.measurement.zzhz
    final int zzb(int i, byte[] bArr, int i2, int i3) {
        int i4;
        if ((i2 | i3 | (bArr.length - i3)) < 0) {
            throw new ArrayIndexOutOfBoundsException(String.format("Array length=%d, index=%d, limit=%d", Integer.valueOf(bArr.length), Integer.valueOf(i2), Integer.valueOf(i3)));
        }
        long j = i2;
        int i5 = (int) (((long) i3) - j);
        if (i5 >= 16) {
            long j2 = j;
            i4 = 0;
            while (true) {
                if (i4 >= i5) {
                    i4 = i5;
                    break;
                }
                long j3 = j2 + 1;
                if (zzhv.zza(bArr, j2) < 0) {
                    break;
                }
                i4++;
                j2 = j3;
            }
        } else {
            i4 = 0;
        }
        int i6 = i5 - i4;
        long j4 = j + ((long) i4);
        while (true) {
            byte b = 0;
            while (i6 > 0) {
                long j5 = j4 + 1;
                byte bZza = zzhv.zza(bArr, j4);
                if (bZza < 0) {
                    b = bZza;
                    j4 = j5;
                    break;
                }
                i6--;
                b = bZza;
                j4 = j5;
            }
            if (i6 == 0) {
                return 0;
            }
            int i7 = i6 - 1;
            if (b < -32) {
                if (i7 == 0) {
                    return b;
                }
                i6 = i7 - 1;
                if (b >= -62) {
                    long j6 = j4 + 1;
                    if (zzhv.zza(bArr, j4) <= -65) {
                        j4 = j6;
                    }
                }
                return -1;
            }
            if (b >= -16) {
                if (i7 < 3) {
                    return zza(bArr, b, j4, i7);
                }
                i6 = i7 - 3;
                long j7 = j4 + 1;
                byte bZza2 = zzhv.zza(bArr, j4);
                if (bZza2 <= -65 && (((b << 28) + (bZza2 + 112)) >> 30) == 0) {
                    long j8 = j7 + 1;
                    if (zzhv.zza(bArr, j7) <= -65) {
                        j4 = j8 + 1;
                        if (zzhv.zza(bArr, j8) > -65) {
                        }
                    }
                }
                return -1;
            }
            if (i7 < 2) {
                return zza(bArr, b, j4, i7);
            }
            i6 = i7 - 2;
            long j9 = j4 + 1;
            byte bZza3 = zzhv.zza(bArr, j4);
            if (bZza3 <= -65 && ((b != -32 || bZza3 >= -96) && (b != -19 || bZza3 < -96))) {
                j4 = j9 + 1;
                if (zzhv.zza(bArr, j9) > -65) {
                }
            }
            return -1;
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzhz
    final String zzh(byte[] bArr, int i, int i2) throws zzfi {
        if ((i | i2 | ((bArr.length - i) - i2)) < 0) {
            throw new ArrayIndexOutOfBoundsException(String.format("buffer length=%d, index=%d, size=%d", Integer.valueOf(bArr.length), Integer.valueOf(i), Integer.valueOf(i2)));
        }
        int i3 = i + i2;
        char[] cArr = new char[i2];
        int i4 = 0;
        while (i < i3) {
            byte bZza = zzhv.zza(bArr, i);
            if (!zzia.zzd(bZza)) {
                break;
            }
            i++;
            zzia.zza(bZza, cArr, i4);
            i4++;
        }
        int i5 = i4;
        while (i < i3) {
            int i6 = i + 1;
            byte bZza2 = zzhv.zza(bArr, i);
            if (zzia.zzd(bZza2)) {
                int i7 = i5 + 1;
                zzia.zza(bZza2, cArr, i5);
                while (i6 < i3) {
                    byte bZza3 = zzhv.zza(bArr, i6);
                    if (!zzia.zzd(bZza3)) {
                        break;
                    }
                    i6++;
                    zzia.zza(bZza3, cArr, i7);
                    i7++;
                }
                i = i6;
                i5 = i7;
            } else if (zzia.zze(bZza2)) {
                if (i6 < i3) {
                    zzia.zza(bZza2, zzhv.zza(bArr, i6), cArr, i5);
                    i = i6 + 1;
                    i5++;
                } else {
                    throw zzfi.zzvb();
                }
            } else if (zzia.zzf(bZza2)) {
                if (i6 < i3 - 1) {
                    int i8 = i6 + 1;
                    zzia.zza(bZza2, zzhv.zza(bArr, i6), zzhv.zza(bArr, i8), cArr, i5);
                    i = i8 + 1;
                    i5++;
                } else {
                    throw zzfi.zzvb();
                }
            } else {
                if (i6 >= i3 - 2) {
                    throw zzfi.zzvb();
                }
                int i9 = i6 + 1;
                byte bZza4 = zzhv.zza(bArr, i6);
                int i10 = i9 + 1;
                zzia.zza(bZza2, bZza4, zzhv.zza(bArr, i9), zzhv.zza(bArr, i10), cArr, i5);
                i = i10 + 1;
                i5 = i5 + 1 + 1;
            }
        }
        return new String(cArr, 0, i5);
    }

    @Override // com.google.android.gms.internal.measurement.zzhz
    final int zzb(CharSequence charSequence, byte[] bArr, int i, int i2) {
        long j;
        int i3;
        char cCharAt;
        long j2 = i;
        long j3 = ((long) i2) + j2;
        int length = charSequence.length();
        if (length > i2 || bArr.length - i2 < i) {
            char cCharAt2 = charSequence.charAt(length - 1);
            StringBuilder sb = new StringBuilder(37);
            sb.append("Failed writing ");
            sb.append(cCharAt2);
            sb.append(" at index ");
            sb.append(i + i2);
            throw new ArrayIndexOutOfBoundsException(sb.toString());
        }
        int i4 = 0;
        while (i4 < length && (cCharAt = charSequence.charAt(i4)) < 128) {
            zzhv.zza(bArr, j2, (byte) cCharAt);
            i4++;
            j2 = 1 + j2;
        }
        if (i4 == length) {
            return (int) j2;
        }
        while (i4 < length) {
            char cCharAt3 = charSequence.charAt(i4);
            if (cCharAt3 >= 128 || j2 >= j3) {
                if (cCharAt3 < 2048 && j2 <= j3 - 2) {
                    long j4 = j2 + 1;
                    zzhv.zza(bArr, j2, (byte) ((cCharAt3 >>> 6) | 960));
                    j2 = j4 + 1;
                    zzhv.zza(bArr, j4, (byte) ((cCharAt3 & '?') | 128));
                } else {
                    if ((cCharAt3 >= 55296 && 57343 >= cCharAt3) || j2 > j3 - 3) {
                        if (j2 <= j3 - 4) {
                            int i5 = i4 + 1;
                            if (i5 != length) {
                                char cCharAt4 = charSequence.charAt(i5);
                                if (Character.isSurrogatePair(cCharAt3, cCharAt4)) {
                                    int codePoint = Character.toCodePoint(cCharAt3, cCharAt4);
                                    long j5 = j2 + 1;
                                    zzhv.zza(bArr, j2, (byte) ((codePoint >>> 18) | 240));
                                    long j6 = j5 + 1;
                                    zzhv.zza(bArr, j5, (byte) (((codePoint >>> 12) & 63) | 128));
                                    long j7 = j6 + 1;
                                    zzhv.zza(bArr, j6, (byte) (((codePoint >>> 6) & 63) | 128));
                                    j2 = j7 + 1;
                                    zzhv.zza(bArr, j7, (byte) ((codePoint & 63) | 128));
                                    i4 = i5;
                                }
                            } else {
                                i5 = i4;
                            }
                            throw new zzib(i5 - 1, length);
                        }
                        if (55296 <= cCharAt3 && cCharAt3 <= 57343 && ((i3 = i4 + 1) == length || !Character.isSurrogatePair(cCharAt3, charSequence.charAt(i3)))) {
                            throw new zzib(i4, length);
                        }
                        StringBuilder sb2 = new StringBuilder(46);
                        sb2.append("Failed writing ");
                        sb2.append(cCharAt3);
                        sb2.append(" at index ");
                        sb2.append(j2);
                        throw new ArrayIndexOutOfBoundsException(sb2.toString());
                    }
                    long j8 = j2 + 1;
                    zzhv.zza(bArr, j2, (byte) ((cCharAt3 >>> '\f') | 480));
                    long j9 = j8 + 1;
                    zzhv.zza(bArr, j8, (byte) (((cCharAt3 >>> 6) & 63) | 128));
                    j = j9 + 1;
                    zzhv.zza(bArr, j9, (byte) ((cCharAt3 & '?') | 128));
                }
                i4++;
            } else {
                j = j2 + 1;
                zzhv.zza(bArr, j2, (byte) cCharAt3);
            }
            j2 = j;
            i4++;
        }
        return (int) j2;
    }

    @Override // com.google.android.gms.internal.measurement.zzhz
    final void zzb(CharSequence charSequence, ByteBuffer byteBuffer) {
        char c;
        long j;
        long j2;
        long j3;
        int i;
        char cCharAt;
        long jZzb = zzhv.zzb(byteBuffer);
        long jPosition = ((long) byteBuffer.position()) + jZzb;
        long jLimit = ((long) byteBuffer.limit()) + jZzb;
        int length = charSequence.length();
        if (length > jLimit - jPosition) {
            char cCharAt2 = charSequence.charAt(length - 1);
            int iLimit = byteBuffer.limit();
            StringBuilder sb = new StringBuilder(37);
            sb.append("Failed writing ");
            sb.append(cCharAt2);
            sb.append(" at index ");
            sb.append(iLimit);
            throw new ArrayIndexOutOfBoundsException(sb.toString());
        }
        int i2 = 0;
        while (true) {
            c = 128;
            j = 1;
            if (i2 >= length || (cCharAt = charSequence.charAt(i2)) >= 128) {
                break;
            }
            zzhv.zza(jPosition, (byte) cCharAt);
            i2++;
            jPosition = 1 + jPosition;
        }
        if (i2 == length) {
            byteBuffer.position((int) (jPosition - jZzb));
            return;
        }
        while (i2 < length) {
            char cCharAt3 = charSequence.charAt(i2);
            if (cCharAt3 >= c || jPosition >= jLimit) {
                if (cCharAt3 < 2048 && jPosition <= jLimit - 2) {
                    long j4 = jPosition + j;
                    zzhv.zza(jPosition, (byte) ((cCharAt3 >>> 6) | 960));
                    zzhv.zza(j4, (byte) ((cCharAt3 & '?') | 128));
                    j2 = j4 + j;
                } else {
                    if ((cCharAt3 >= 55296 && 57343 >= cCharAt3) || jPosition > jLimit - 3) {
                        if (jPosition <= jLimit - 4) {
                            int i3 = i2 + 1;
                            if (i3 != length) {
                                char cCharAt4 = charSequence.charAt(i3);
                                if (Character.isSurrogatePair(cCharAt3, cCharAt4)) {
                                    int codePoint = Character.toCodePoint(cCharAt3, cCharAt4);
                                    long j5 = jPosition + 1;
                                    zzhv.zza(jPosition, (byte) ((codePoint >>> 18) | 240));
                                    long j6 = j5 + 1;
                                    zzhv.zza(j5, (byte) (((codePoint >>> 12) & 63) | 128));
                                    long j7 = j6 + 1;
                                    zzhv.zza(j6, (byte) (((codePoint >>> 6) & 63) | 128));
                                    j3 = 1;
                                    zzhv.zza(j7, (byte) ((codePoint & 63) | 128));
                                    i2 = i3;
                                    j2 = j7 + 1;
                                } else {
                                    i2 = i3;
                                }
                            }
                            throw new zzib(i2 - 1, length);
                        }
                        if (55296 <= cCharAt3 && cCharAt3 <= 57343 && ((i = i2 + 1) == length || !Character.isSurrogatePair(cCharAt3, charSequence.charAt(i)))) {
                            throw new zzib(i2, length);
                        }
                        StringBuilder sb2 = new StringBuilder(46);
                        sb2.append("Failed writing ");
                        sb2.append(cCharAt3);
                        sb2.append(" at index ");
                        sb2.append(jPosition);
                        throw new ArrayIndexOutOfBoundsException(sb2.toString());
                    }
                    long j8 = jPosition + j;
                    zzhv.zza(jPosition, (byte) ((cCharAt3 >>> '\f') | 480));
                    long j9 = j8 + j;
                    zzhv.zza(j8, (byte) (((cCharAt3 >>> 6) & 63) | 128));
                    zzhv.zza(j9, (byte) ((cCharAt3 & '?') | 128));
                    j2 = j9 + 1;
                    j3 = 1;
                }
                i2++;
                j = j3;
                jPosition = j2;
                c = 128;
            } else {
                j2 = jPosition + j;
                zzhv.zza(jPosition, (byte) cCharAt3);
            }
            j3 = j;
            i2++;
            j = j3;
            jPosition = j2;
            c = 128;
        }
        byteBuffer.position((int) (jPosition - jZzb));
    }

    private static int zza(byte[] bArr, int i, long j, int i2) {
        switch (i2) {
            case 0:
                return zzhy.zzch(i);
            case 1:
                return zzhy.zzr(i, zzhv.zza(bArr, j));
            case 2:
                return zzhy.zzc(i, zzhv.zza(bArr, j), zzhv.zza(bArr, j + 1));
            default:
                throw new AssertionError();
        }
    }
}

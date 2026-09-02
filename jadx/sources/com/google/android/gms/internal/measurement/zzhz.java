package com.google.android.gms.internal.measurement;

import java.nio.ByteBuffer;

/* JADX INFO: loaded from: classes.dex */
abstract class zzhz {
    zzhz() {
    }

    abstract int zzb(int i, byte[] bArr, int i2, int i3);

    abstract int zzb(CharSequence charSequence, byte[] bArr, int i, int i2);

    abstract void zzb(CharSequence charSequence, ByteBuffer byteBuffer);

    abstract String zzh(byte[] bArr, int i, int i2) throws zzfi;

    final boolean zzf(byte[] bArr, int i, int i2) {
        return zzb(0, bArr, i, i2) == 0;
    }

    static void zzc(CharSequence charSequence, ByteBuffer byteBuffer) {
        int length = charSequence.length();
        int iPosition = byteBuffer.position();
        int i = 0;
        while (i < length) {
            try {
                char cCharAt = charSequence.charAt(i);
                if (cCharAt >= 128) {
                    break;
                }
                byteBuffer.put(iPosition + i, (byte) cCharAt);
                i++;
            } catch (IndexOutOfBoundsException unused) {
            }
        }
        if (i == length) {
            byteBuffer.position(iPosition + i);
            return;
        }
        iPosition += i;
        while (i < length) {
            char cCharAt2 = charSequence.charAt(i);
            if (cCharAt2 < 128) {
                byteBuffer.put(iPosition, (byte) cCharAt2);
            } else if (cCharAt2 < 2048) {
                int i2 = iPosition + 1;
                try {
                    byteBuffer.put(iPosition, (byte) ((cCharAt2 >>> 6) | 192));
                    byteBuffer.put(i2, (byte) ((cCharAt2 & '?') | 128));
                    iPosition = i2;
                } catch (IndexOutOfBoundsException unused2) {
                    iPosition = i2;
                }
            } else if (cCharAt2 < 55296 || 57343 < cCharAt2) {
                int i3 = iPosition + 1;
                byteBuffer.put(iPosition, (byte) ((cCharAt2 >>> '\f') | 224));
                iPosition = i3 + 1;
                byteBuffer.put(i3, (byte) (((cCharAt2 >>> 6) & 63) | 128));
                byteBuffer.put(iPosition, (byte) ((cCharAt2 & '?') | 128));
            } else {
                int i4 = i + 1;
                if (i4 != length) {
                    try {
                        char cCharAt3 = charSequence.charAt(i4);
                        if (Character.isSurrogatePair(cCharAt2, cCharAt3)) {
                            int codePoint = Character.toCodePoint(cCharAt2, cCharAt3);
                            int i5 = iPosition + 1;
                            try {
                                byteBuffer.put(iPosition, (byte) ((codePoint >>> 18) | 240));
                                iPosition = i5 + 1;
                                byteBuffer.put(i5, (byte) (((codePoint >>> 12) & 63) | 128));
                                i5 = iPosition + 1;
                                byteBuffer.put(iPosition, (byte) (((codePoint >>> 6) & 63) | 128));
                                byteBuffer.put(i5, (byte) ((codePoint & 63) | 128));
                                iPosition = i5;
                                i = i4;
                            } catch (IndexOutOfBoundsException unused3) {
                                iPosition = i5;
                            }
                        } else {
                            i = i4;
                        }
                    } catch (IndexOutOfBoundsException unused4) {
                    }
                    i = i4;
                    int iPosition2 = byteBuffer.position() + Math.max(i, (iPosition - byteBuffer.position()) + 1);
                    char cCharAt4 = charSequence.charAt(i);
                    StringBuilder sb = new StringBuilder(37);
                    sb.append("Failed writing ");
                    sb.append(cCharAt4);
                    sb.append(" at index ");
                    sb.append(iPosition2);
                    throw new ArrayIndexOutOfBoundsException(sb.toString());
                }
                throw new zzib(i, length);
            }
            i++;
            iPosition++;
        }
        byteBuffer.position(iPosition);
    }
}

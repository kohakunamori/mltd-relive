package com.google.android.gms.internal.nearby;

import android.os.ParcelUuid;
import android.util.Log;
import android.util.SparseArray;
import androidx.annotation.Nullable;
import com.google.android.gms.common.util.Hex;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.messaging.cpp.SerializedEventUnion;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/* JADX INFO: loaded from: classes.dex */
public final class zzgr {
    private static final ParcelUuid zzgm = ParcelUuid.fromString("00000000-0000-1000-8000-00805F9B34FB");
    private final int zzgn;

    @Nullable
    private final List<ParcelUuid> zzgo;

    @Nullable
    private final SparseArray<byte[]> zzgp;

    @Nullable
    private final Map<ParcelUuid, byte[]> zzgq;
    private final int zzgr;

    @Nullable
    private final String zzgs;
    private final byte[] zzgt;

    private zzgr(@Nullable List<ParcelUuid> list, @Nullable SparseArray<byte[]> sparseArray, @Nullable Map<ParcelUuid, byte[]> map, int i, int i2, @Nullable String str, byte[] bArr) {
        this.zzgo = list;
        this.zzgp = sparseArray;
        this.zzgq = map;
        this.zzgs = str;
        this.zzgn = i;
        this.zzgr = i2;
        this.zzgt = bArr;
    }

    private static int zza(byte[] bArr, int i, int i2, int i3, List<ParcelUuid> list) {
        while (i2 > 0) {
            list.add(zze(zza(bArr, i, i3)));
            i2 -= i3;
            i += i3;
        }
        return i;
    }

    private static byte[] zza(byte[] bArr, int i, int i2) {
        byte[] bArr2 = new byte[i2];
        System.arraycopy(bArr, i, bArr2, 0, i2);
        return bArr2;
    }

    /* JADX WARN: Code duplicated, block: B:26:0x008e  */
    /* JADX WARN: Code duplicated, block: B:27:0x0090  */
    @VisibleForTesting
    public static zzgr zzd(@Nullable byte[] bArr) {
        ArrayList arrayList;
        if (bArr == null) {
            return null;
        }
        int i = 0;
        ArrayList arrayList2 = new ArrayList();
        SparseArray sparseArray = new SparseArray();
        HashMap map = new HashMap();
        String str = null;
        int i2 = -1;
        byte b = SerializedEventUnion.NONE;
        while (i < bArr.length) {
            try {
                int i3 = i + 1;
                int i4 = bArr[i] & 255;
                if (i4 == 0) {
                    if (arrayList2.isEmpty()) {
                        arrayList = null;
                    } else {
                        arrayList = arrayList2;
                    }
                    return new zzgr(arrayList, sparseArray, map, i2, b, str, bArr);
                }
                int i5 = i4 - 1;
                int i6 = i3 + 1;
                int i7 = bArr[i3] & 255;
                if (i7 == 22) {
                    map.put(zze(zza(bArr, i6, 2)), zza(bArr, i6 + 2, i5 - 2));
                } else if (i7 != 255) {
                    switch (i7) {
                        case 1:
                            i2 = bArr[i6] & 255;
                            break;
                        case 2:
                        case 3:
                            zza(bArr, i6, i5, 2, arrayList2);
                            break;
                        case 4:
                        case 5:
                            zza(bArr, i6, i5, 4, arrayList2);
                            break;
                        case 6:
                        case 7:
                            zza(bArr, i6, i5, 16, arrayList2);
                            break;
                        case 8:
                        case 9:
                            str = new String(zza(bArr, i6, i5));
                            break;
                        case 10:
                            b = bArr[i6];
                            break;
                    }
                } else {
                    sparseArray.put(((bArr[i6 + 1] & 255) << 8) + (255 & bArr[i6]), zza(bArr, i6 + 2, i5 - 2));
                }
                i = i5 + i6;
            } catch (Exception e) {
                String strValueOf = String.valueOf(Arrays.toString(bArr));
                Log.w("BleRecord", strValueOf.length() != 0 ? "Unable to parse scan record: ".concat(strValueOf) : new String("Unable to parse scan record: "), e);
                return null;
            }
        }
        if (arrayList2.isEmpty()) {
            arrayList = null;
        } else {
            arrayList = arrayList2;
        }
        return new zzgr(arrayList, sparseArray, map, i2, b, str, bArr);
    }

    private static ParcelUuid zze(byte[] bArr) {
        long j;
        if (bArr == null) {
            throw new IllegalArgumentException("uuidBytes cannot be null");
        }
        int length = bArr.length;
        if (length != 2 && length != 4 && length != 16) {
            StringBuilder sb = new StringBuilder(38);
            sb.append("uuidBytes length invalid - ");
            sb.append(length);
            throw new IllegalArgumentException(sb.toString());
        }
        if (length == 16) {
            ByteBuffer byteBufferOrder = ByteBuffer.wrap(bArr).order(ByteOrder.LITTLE_ENDIAN);
            return new ParcelUuid(new UUID(byteBufferOrder.getLong(8), byteBufferOrder.getLong(0)));
        }
        if (length == 2) {
            j = ((long) (bArr[0] & 255)) + ((long) ((bArr[1] & 255) << 8));
        } else {
            j = ((long) ((bArr[3] & 255) << 24)) + ((long) (bArr[0] & 255)) + ((long) ((bArr[1] & 255) << 8)) + ((long) ((bArr[2] & 255) << 16));
        }
        return new ParcelUuid(new UUID(zzgm.getUuid().getMostSignificantBits() + (j << 32), zzgm.getUuid().getLeastSignificantBits()));
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof zzgr) {
            return Arrays.equals(this.zzgt, ((zzgr) obj).zzgt);
        }
        return false;
    }

    public final int hashCode() {
        return Arrays.hashCode(this.zzgt);
    }

    public final String toString() {
        String string;
        String string2;
        int i = this.zzgn;
        String strValueOf = String.valueOf(this.zzgo);
        SparseArray<byte[]> sparseArray = this.zzgp;
        StringBuilder sb = new StringBuilder();
        int i2 = 0;
        if (sparseArray.size() <= 0) {
            string = "{}";
        } else {
            sb.append('{');
            for (int i3 = 0; i3 < sparseArray.size(); i3++) {
                if (i3 > 0) {
                    sb.append(", ");
                }
                int iKeyAt = sparseArray.keyAt(i3);
                byte[] bArrValueAt = sparseArray.valueAt(i3);
                sb.append(iKeyAt);
                sb.append('=');
                sb.append(bArrValueAt == null ? null : Hex.bytesToStringUppercase(bArrValueAt));
            }
            sb.append('}');
            string = sb.toString();
        }
        Map<ParcelUuid, byte[]> map = this.zzgq;
        StringBuilder sb2 = new StringBuilder();
        if (map.keySet().size() <= 0) {
            string2 = "{}";
        } else {
            sb2.append('{');
            for (Map.Entry<ParcelUuid, byte[]> entry : map.entrySet()) {
                if (i2 > 0) {
                    sb2.append(", ");
                }
                sb2.append(entry.getKey());
                sb2.append('=');
                byte[] value = entry.getValue();
                sb2.append(value == null ? null : Hex.bytesToStringUppercase(value));
                i2++;
            }
            sb2.append('}');
            string2 = sb2.toString();
        }
        int i4 = this.zzgr;
        String str = this.zzgs;
        StringBuilder sb3 = new StringBuilder(String.valueOf(strValueOf).length() + 139 + String.valueOf(string).length() + String.valueOf(string2).length() + String.valueOf(str).length());
        sb3.append("BleRecord [mAdvertiseFlags=");
        sb3.append(i);
        sb3.append(", mServiceUuids=");
        sb3.append(strValueOf);
        sb3.append(", mManufacturerSpecificData=");
        sb3.append(string);
        sb3.append(", mServiceData=");
        sb3.append(string2);
        sb3.append(", mTxPowerLevel=");
        sb3.append(i4);
        sb3.append(", mDeviceName=");
        sb3.append(str);
        sb3.append("]");
        return sb3.toString();
    }
}

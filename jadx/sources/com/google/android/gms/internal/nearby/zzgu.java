package com.google.android.gms.internal.nearby;

import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.UUID;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "NearbyDeviceFilterCreator")
public final class zzgu extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzgu> CREATOR = new zzgv();

    @SafeParcelable.VersionField(m24id = 1000)
    private final int zzex;

    @SafeParcelable.Field(m22id = 1)
    private final int zzgy;

    @SafeParcelable.Field(m22id = 2)
    private final byte[] zzgz;

    @SafeParcelable.Field(m22id = 3)
    private final boolean zzha;

    @SafeParcelable.Constructor
    zzgu(@SafeParcelable.Param(m23id = 1000) int i, @SafeParcelable.Param(m23id = 1) int i2, @SafeParcelable.Param(m23id = 2) byte[] bArr, @SafeParcelable.Param(m23id = 3) boolean z) {
        this.zzex = i;
        this.zzgy = i2;
        this.zzgz = bArr;
        this.zzha = z;
    }

    private zzgu(int i, byte[] bArr) {
        this(1, i, bArr, false);
    }

    public static zzgu zza(UUID uuid, @Nullable Short sh, @Nullable Short sh2) {
        return new zzgu(3, new com.google.android.gms.nearby.messages.internal.zzl(uuid, sh, sh2).getBytes());
    }

    public static zzgu zzb(String str, @Nullable String str2) {
        String strValueOf = String.valueOf(str);
        if (str2 == null) {
            str2 = "";
        }
        String strValueOf2 = String.valueOf(str2);
        return new zzgu(2, new com.google.android.gms.nearby.messages.internal.zzg(strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf)).getBytes());
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zzgy);
        SafeParcelWriter.writeByteArray(parcel, 2, this.zzgz, false);
        SafeParcelWriter.writeBoolean(parcel, 3, this.zzha);
        SafeParcelWriter.writeInt(parcel, 1000, this.zzex);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

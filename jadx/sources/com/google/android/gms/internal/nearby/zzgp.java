package com.google.android.gms.internal.nearby;

import android.os.Parcel;
import android.os.ParcelUuid;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.Arrays;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "BleFilterCreator")
public final class zzgp extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzgp> CREATOR = new zzgq();

    @SafeParcelable.VersionField(getter = "getVersionCode", m24id = 1)
    private final int zzex;

    @Nullable
    @SafeParcelable.Field(getter = "getServiceUuid", m22id = 4)
    private final ParcelUuid zzge;

    @Nullable
    @SafeParcelable.Field(getter = "getServiceUuidMask", m22id = 5)
    private final ParcelUuid zzgf;

    @Nullable
    @SafeParcelable.Field(getter = "getServiceDataUuid", m22id = 6)
    private final ParcelUuid zzgg;

    @Nullable
    @SafeParcelable.Field(getter = "getServiceData", m22id = 7)
    private final byte[] zzgh;

    @Nullable
    @SafeParcelable.Field(getter = "getServiceDataMask", m22id = 8)
    private final byte[] zzgi;

    @SafeParcelable.Field(getter = "getManufacturerId", m22id = 9)
    private final int zzgj;

    @Nullable
    @SafeParcelable.Field(getter = "getManufacturerData", m22id = 10)
    private final byte[] zzgk;

    @Nullable
    @SafeParcelable.Field(getter = "getManufacturerDataMask", m22id = 11)
    private final byte[] zzgl;

    @SafeParcelable.Constructor
    zzgp(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 4) ParcelUuid parcelUuid, @SafeParcelable.Param(m23id = 5) ParcelUuid parcelUuid2, @SafeParcelable.Param(m23id = 6) ParcelUuid parcelUuid3, @SafeParcelable.Param(m23id = 7) byte[] bArr, @SafeParcelable.Param(m23id = 8) byte[] bArr2, @SafeParcelable.Param(m23id = 9) int i2, @SafeParcelable.Param(m23id = 10) byte[] bArr3, @SafeParcelable.Param(m23id = 11) byte[] bArr4) {
        this.zzex = i;
        this.zzge = parcelUuid;
        this.zzgf = parcelUuid2;
        this.zzgg = parcelUuid3;
        this.zzgh = bArr;
        this.zzgi = bArr2;
        this.zzgj = i2;
        this.zzgk = bArr3;
        this.zzgl = bArr4;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj != null && getClass() == obj.getClass()) {
            zzgp zzgpVar = (zzgp) obj;
            if (this.zzgj == zzgpVar.zzgj && Arrays.equals(this.zzgk, zzgpVar.zzgk) && Arrays.equals(this.zzgl, zzgpVar.zzgl) && Objects.equal(this.zzgg, zzgpVar.zzgg) && Arrays.equals(this.zzgh, zzgpVar.zzgh) && Arrays.equals(this.zzgi, zzgpVar.zzgi) && Objects.equal(this.zzge, zzgpVar.zzge) && Objects.equal(this.zzgf, zzgpVar.zzgf)) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(Integer.valueOf(this.zzgj), Integer.valueOf(Arrays.hashCode(this.zzgk)), Integer.valueOf(Arrays.hashCode(this.zzgl)), this.zzgg, Integer.valueOf(Arrays.hashCode(this.zzgh)), Integer.valueOf(Arrays.hashCode(this.zzgi)), this.zzge, this.zzgf);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zzex);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzge, i, false);
        SafeParcelWriter.writeParcelable(parcel, 5, this.zzgf, i, false);
        SafeParcelWriter.writeParcelable(parcel, 6, this.zzgg, i, false);
        SafeParcelWriter.writeByteArray(parcel, 7, this.zzgh, false);
        SafeParcelWriter.writeByteArray(parcel, 8, this.zzgi, false);
        SafeParcelWriter.writeInt(parcel, 9, this.zzgj);
        SafeParcelWriter.writeByteArray(parcel, 10, this.zzgk, false);
        SafeParcelWriter.writeByteArray(parcel, 11, this.zzgl, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

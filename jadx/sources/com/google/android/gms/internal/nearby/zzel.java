package com.google.android.gms.internal.nearby;

import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.Arrays;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OnConnectionResponseParamsCreator")
@SafeParcelable.Reserved({1000})
public final class zzel extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzel> CREATOR = new zzem();

    @SafeParcelable.Field(getter = "getStatusCode", m22id = 2)
    private int statusCode;

    @SafeParcelable.Field(getter = "getRemoteEndpointId", m22id = 1)
    private String zzat;

    @Nullable
    @SafeParcelable.Field(getter = "getHandshakeData", m22id = 3)
    private byte[] zzau;

    private zzel() {
    }

    @SafeParcelable.Constructor
    zzel(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) int i, @Nullable @SafeParcelable.Param(m23id = 3) byte[] bArr) {
        this.zzat = str;
        this.statusCode = i;
        this.zzau = bArr;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzel) {
            zzel zzelVar = (zzel) obj;
            if (Objects.equal(this.zzat, zzelVar.zzat) && Objects.equal(Integer.valueOf(this.statusCode), Integer.valueOf(zzelVar.statusCode)) && Arrays.equals(this.zzau, zzelVar.zzau)) {
                return true;
            }
        }
        return false;
    }

    public final int getStatusCode() {
        return this.statusCode;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzat, Integer.valueOf(this.statusCode), Integer.valueOf(Arrays.hashCode(this.zzau)));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzat, false);
        SafeParcelWriter.writeInt(parcel, 2, this.statusCode);
        SafeParcelWriter.writeByteArray(parcel, 3, this.zzau, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final String zzg() {
        return this.zzat;
    }

    @Nullable
    public final byte[] zzj() {
        return this.zzau;
    }
}

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
@SafeParcelable.Class(creator = "OnConnectionRequestParamsCreator")
@SafeParcelable.Reserved({1000})
public final class zzej extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzej> CREATOR = new zzek();

    @SafeParcelable.Field(getter = "getRemoteEndpointId", m22id = 1)
    private String zzat;

    @Nullable
    @SafeParcelable.Field(getter = "getHandshakeData", m22id = 3)
    private byte[] zzau;

    @SafeParcelable.Field(getter = "getRemoteEndpointName", m22id = 2)
    private String zzdj;

    private zzej() {
    }

    @SafeParcelable.Constructor
    zzej(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) String str2, @Nullable @SafeParcelable.Param(m23id = 3) byte[] bArr) {
        this.zzat = str;
        this.zzdj = str2;
        this.zzau = bArr;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzej) {
            zzej zzejVar = (zzej) obj;
            if (Objects.equal(this.zzat, zzejVar.zzat) && Objects.equal(this.zzdj, zzejVar.zzdj) && Arrays.equals(this.zzau, zzejVar.zzau)) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzat, this.zzdj, Integer.valueOf(Arrays.hashCode(this.zzau)));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzat, false);
        SafeParcelWriter.writeString(parcel, 2, this.zzdj, false);
        SafeParcelWriter.writeByteArray(parcel, 3, this.zzau, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final String zzg() {
        return this.zzat;
    }

    public final String zzh() {
        return this.zzdj;
    }

    @Nullable
    public final byte[] zzj() {
        return this.zzau;
    }
}

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
@SafeParcelable.Class(creator = "OnConnectionInitiatedParamsCreator")
public final class zzeh extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzeh> CREATOR = new zzei();

    @SafeParcelable.Field(getter = "getRemoteEndpointId", m22id = 1)
    private String zzat;

    @Nullable
    @SafeParcelable.Field(getter = "getHandshakeData", m22id = 5)
    private byte[] zzau;

    @SafeParcelable.Field(getter = "getRemoteEndpointName", m22id = 2)
    private String zzdj;

    @SafeParcelable.Field(getter = "getAuthenticationToken", m22id = 3)
    private String zzr;

    @SafeParcelable.Field(getter = "getIsIncomingConnection", m22id = 4)
    private boolean zzs;

    private zzeh() {
    }

    @SafeParcelable.Constructor
    zzeh(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) String str2, @SafeParcelable.Param(m23id = 3) String str3, @SafeParcelable.Param(m23id = 4) boolean z, @Nullable @SafeParcelable.Param(m23id = 5) byte[] bArr) {
        this.zzat = str;
        this.zzdj = str2;
        this.zzr = str3;
        this.zzs = z;
        this.zzau = bArr;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzeh) {
            zzeh zzehVar = (zzeh) obj;
            if (Objects.equal(this.zzat, zzehVar.zzat) && Objects.equal(this.zzdj, zzehVar.zzdj) && Objects.equal(this.zzr, zzehVar.zzr) && Objects.equal(Boolean.valueOf(this.zzs), Boolean.valueOf(zzehVar.zzs)) && Arrays.equals(this.zzau, zzehVar.zzau)) {
                return true;
            }
        }
        return false;
    }

    public final String getAuthenticationToken() {
        return this.zzr;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzat, this.zzdj, this.zzr, Boolean.valueOf(this.zzs), Integer.valueOf(Arrays.hashCode(this.zzau)));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzat, false);
        SafeParcelWriter.writeString(parcel, 2, this.zzdj, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzr, false);
        SafeParcelWriter.writeBoolean(parcel, 4, this.zzs);
        SafeParcelWriter.writeByteArray(parcel, 5, this.zzau, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final String zzg() {
        return this.zzat;
    }

    public final String zzh() {
        return this.zzdj;
    }

    public final boolean zzi() {
        return this.zzs;
    }
}

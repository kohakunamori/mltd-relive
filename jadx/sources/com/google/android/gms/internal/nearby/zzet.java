package com.google.android.gms.internal.nearby;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OnEndpointLostParamsCreator")
@SafeParcelable.Reserved({1000})
public final class zzet extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzet> CREATOR = new zzeu();

    @SafeParcelable.Field(getter = "getEndpointId", m22id = 1)
    private String zzca;

    private zzet() {
    }

    @SafeParcelable.Constructor
    zzet(@SafeParcelable.Param(m23id = 1) String str) {
        this.zzca = str;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzet) {
            return Objects.equal(this.zzca, ((zzet) obj).zzca);
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzca);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzca, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final String zze() {
        return this.zzca;
    }
}

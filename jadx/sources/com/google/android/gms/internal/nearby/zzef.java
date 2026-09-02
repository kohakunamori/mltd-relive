package com.google.android.gms.internal.nearby;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OnBandwidthChangedParamsCreator")
public final class zzef extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzef> CREATOR = new zzeg();

    @SafeParcelable.Field(getter = "getQuality", m22id = 2)
    private int quality;

    @SafeParcelable.Field(getter = "getRemoteEndpointId", m22id = 1)
    private String zzat;

    private zzef() {
    }

    @SafeParcelable.Constructor
    zzef(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) int i) {
        this.zzat = str;
        this.quality = i;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzef) {
            zzef zzefVar = (zzef) obj;
            if (Objects.equal(this.zzat, zzefVar.zzat) && Objects.equal(Integer.valueOf(this.quality), Integer.valueOf(zzefVar.quality))) {
                return true;
            }
        }
        return false;
    }

    public final int getQuality() {
        return this.quality;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzat, Integer.valueOf(this.quality));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzat, false);
        SafeParcelWriter.writeInt(parcel, 2, this.quality);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final String zzg() {
        return this.zzat;
    }
}

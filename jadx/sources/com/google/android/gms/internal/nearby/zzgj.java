package com.google.android.gms.internal.nearby;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "StopAllEndpointsParamsCreator")
@SafeParcelable.Reserved({1000})
public final class zzgj extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzgj> CREATOR = new zzgl();

    @SafeParcelable.Constructor
    zzgj() {
    }

    public final boolean equals(Object obj) {
        return this == obj || (obj instanceof zzgj);
    }

    public final int hashCode() {
        return 0;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        SafeParcelWriter.finishObjectHeader(parcel, SafeParcelWriter.beginObjectHeader(parcel));
    }
}

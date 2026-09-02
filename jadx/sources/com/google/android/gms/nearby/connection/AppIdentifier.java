package com.google.android.gms.nearby.connection;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "AppIdentifierCreator")
@SafeParcelable.Reserved({1000})
@Deprecated
public final class AppIdentifier extends AbstractSafeParcelable {
    public static final Parcelable.Creator<AppIdentifier> CREATOR = new zzc();

    @SafeParcelable.Field(getter = "getIdentifier", m22id = 1)
    private final String zzo;

    @SafeParcelable.Constructor
    public AppIdentifier(@SafeParcelable.Param(m23id = 1) String str) {
        this.zzo = Preconditions.checkNotEmpty(str, "Missing application identifier value");
    }

    public final String getIdentifier() {
        return this.zzo;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getIdentifier(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

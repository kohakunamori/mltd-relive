package com.google.android.gms.nearby.connection;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "AppMetadataCreator")
@SafeParcelable.Reserved({1000})
@Deprecated
public final class AppMetadata extends AbstractSafeParcelable {
    public static final Parcelable.Creator<AppMetadata> CREATOR = new zzd();

    @SafeParcelable.Field(getter = "getAppIdentifiers", m22id = 1)
    private final List<AppIdentifier> zzp;

    @SafeParcelable.Constructor
    public AppMetadata(@SafeParcelable.Param(m23id = 1) List<AppIdentifier> list) {
        this.zzp = (List) Preconditions.checkNotNull(list, "Must specify application identifiers");
        Preconditions.checkNotZero(list.size(), (Object) "Application identifiers cannot be empty");
    }

    public final List<AppIdentifier> getAppIdentifiers() {
        return this.zzp;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeTypedList(parcel, 1, getAppIdentifiers(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

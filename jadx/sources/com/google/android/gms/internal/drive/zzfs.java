package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.drive.metadata.internal.MetadataBundle;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OnMetadataResponseCreator")
@SafeParcelable.Reserved({1})
public final class zzfs extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzfs> CREATOR = new zzft();

    @SafeParcelable.Field(m22id = 2)
    final MetadataBundle zzdl;

    @SafeParcelable.Constructor
    public zzfs(@SafeParcelable.Param(m23id = 2) MetadataBundle metadataBundle) {
        this.zzdl = metadataBundle;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzdl, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final MetadataBundle zzan() {
        return this.zzdl;
    }
}

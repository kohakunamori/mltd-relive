package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.drive.query.Query;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "QueryRequestCreator")
@SafeParcelable.Reserved({1})
public final class zzgk extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzgk> CREATOR = new zzgl();

    @SafeParcelable.Field(m22id = 2)
    private final Query zzib;

    @SafeParcelable.Constructor
    @VisibleForTesting
    public zzgk(@SafeParcelable.Param(m23id = 2) Query query) {
        this.zzib = query;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzib, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

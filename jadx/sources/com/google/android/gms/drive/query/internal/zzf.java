package com.google.android.gms.drive.query.internal;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "FieldWithSortOrderCreator")
@SafeParcelable.Reserved({1000})
public final class zzf extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzf> CREATOR = new zzg();

    @SafeParcelable.Field(m22id = 1)
    private final String fieldName;

    @SafeParcelable.Field(m22id = 2)
    private final boolean zzlm;

    @SafeParcelable.Constructor
    public zzf(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) boolean z) {
        this.fieldName = str;
        this.zzlm = z;
    }

    public final String toString() {
        Locale locale = Locale.US;
        Object[] objArr = new Object[2];
        objArr[0] = this.fieldName;
        objArr[1] = this.zzlm ? "ASC" : "DESC";
        return String.format(locale, "FieldWithSortOrder[%s %s]", objArr);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.fieldName, false);
        SafeParcelWriter.writeBoolean(parcel, 2, this.zzlm);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

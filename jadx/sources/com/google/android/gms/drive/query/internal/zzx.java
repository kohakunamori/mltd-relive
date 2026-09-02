package com.google.android.gms.drive.query.internal;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OperatorCreator")
@SafeParcelable.Reserved({1000})
public final class zzx extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzx> CREATOR = new zzy();
    public static final zzx zzma = new zzx("=");
    public static final zzx zzmb = new zzx("<");
    public static final zzx zzmc = new zzx("<=");
    public static final zzx zzmd = new zzx(">");
    public static final zzx zzme = new zzx(">=");
    public static final zzx zzmf = new zzx("and");
    public static final zzx zzmg = new zzx("or");
    private static final zzx zzmh = new zzx("not");
    public static final zzx zzmi = new zzx("contains");

    @SafeParcelable.Field(m22id = 1)
    private final String tag;

    @SafeParcelable.Constructor
    zzx(@SafeParcelable.Param(m23id = 1) String str) {
        this.tag = str;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        zzx zzxVar = (zzx) obj;
        if (this.tag == null) {
            if (zzxVar.tag != null) {
                return false;
            }
        } else if (!this.tag.equals(zzxVar.tag)) {
            return false;
        }
        return true;
    }

    public final String getTag() {
        return this.tag;
    }

    public final int hashCode() {
        return (this.tag == null ? 0 : this.tag.hashCode()) + 31;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.tag, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

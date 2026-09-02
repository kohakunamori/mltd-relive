package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OnListEntriesResponseCreator")
@SafeParcelable.Reserved({1})
public final class zzfn extends com.google.android.gms.drive.zzu {
    public static final Parcelable.Creator<zzfn> CREATOR = new zzfo();

    @SafeParcelable.Field(m22id = 3)
    final boolean zzdy;

    @SafeParcelable.Field(m22id = 2)
    final DataHolder zzhs;

    @SafeParcelable.Constructor
    public zzfn(@SafeParcelable.Param(m23id = 2) DataHolder dataHolder, @SafeParcelable.Param(m23id = 3) boolean z) {
        this.zzhs = dataHolder;
        this.zzdy = z;
    }

    @Override // com.google.android.gms.drive.zzu
    protected final void zza(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzhs, i, false);
        SafeParcelWriter.writeBoolean(parcel, 3, this.zzdy);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final DataHolder zzal() {
        return this.zzhs;
    }
}

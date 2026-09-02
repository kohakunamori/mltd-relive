package com.google.android.gms.internal.drive;

import android.os.IBinder;
import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OnStartStreamSessionCreator")
@SafeParcelable.Reserved({1})
public final class zzfz extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzfz> CREATOR = new zzga();

    @SafeParcelable.Field(m22id = 2)
    private final ParcelFileDescriptor zzhx;

    @SafeParcelable.Field(m22id = 3)
    private final IBinder zzhy;

    @SafeParcelable.Field(m22id = 4)
    private final String zzm;

    @SafeParcelable.Constructor
    zzfz(@SafeParcelable.Param(m23id = 2) ParcelFileDescriptor parcelFileDescriptor, @SafeParcelable.Param(m23id = 3) IBinder iBinder, @SafeParcelable.Param(m23id = 4) String str) {
        this.zzhx = parcelFileDescriptor;
        this.zzhy = iBinder;
        this.zzm = str;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzhx, i | 1, false);
        SafeParcelWriter.writeIBinder(parcel, 3, this.zzhy, false);
        SafeParcelWriter.writeString(parcel, 4, this.zzm, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

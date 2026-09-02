package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.drive.DriveId;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OnChangesResponseCreator")
@SafeParcelable.Reserved({1})
public final class zzez extends com.google.android.gms.drive.zzu {
    public static final Parcelable.Creator<zzez> CREATOR = new zzfa();

    @SafeParcelable.Field(m22id = 2)
    private final DataHolder zzhb;

    @SafeParcelable.Field(m22id = 3)
    private final List<DriveId> zzhc;

    @SafeParcelable.Field(m22id = 4)
    private final com.google.android.gms.drive.zza zzhd;

    @SafeParcelable.Field(m22id = 5)
    private final boolean zzhe;

    @SafeParcelable.Constructor
    public zzez(@SafeParcelable.Param(m23id = 2) DataHolder dataHolder, @SafeParcelable.Param(m23id = 3) List<DriveId> list, @SafeParcelable.Param(m23id = 4) com.google.android.gms.drive.zza zzaVar, @SafeParcelable.Param(m23id = 5) boolean z) {
        this.zzhb = dataHolder;
        this.zzhc = list;
        this.zzhd = zzaVar;
        this.zzhe = z;
    }

    @Override // com.google.android.gms.drive.zzu
    protected final void zza(Parcel parcel, int i) {
        int i2 = i | 1;
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzhb, i2, false);
        SafeParcelWriter.writeTypedList(parcel, 3, this.zzhc, false);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzhd, i2, false);
        SafeParcelWriter.writeBoolean(parcel, 5, this.zzhe);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

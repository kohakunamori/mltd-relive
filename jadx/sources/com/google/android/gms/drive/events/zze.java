package com.google.android.gms.drive.events;

import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.drive.DriveSpace;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "ChangesAvailableOptionsCreator")
@SafeParcelable.Reserved({1})
public final class zze extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zze> CREATOR = new zzf();

    @SafeParcelable.Field(m22id = 2)
    private final int zzbu;

    @SafeParcelable.Field(m22id = 3)
    private final boolean zzbv;

    @SafeParcelable.Field(m22id = 4)
    private final List<DriveSpace> zzbw;

    @SafeParcelable.Constructor
    zze(@SafeParcelable.Param(m23id = 2) int i, @SafeParcelable.Param(m23id = 3) boolean z, @NonNull @SafeParcelable.Param(m23id = 4) List<DriveSpace> list) {
        this.zzbu = i;
        this.zzbv = z;
        this.zzbw = list;
    }

    public final boolean equals(Object obj) {
        if (obj != null && obj.getClass() == getClass()) {
            if (obj == this) {
                return true;
            }
            zze zzeVar = (zze) obj;
            if (Objects.equal(this.zzbw, zzeVar.zzbw) && this.zzbu == zzeVar.zzbu && this.zzbv == zzeVar.zzbv) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzbw, Integer.valueOf(this.zzbu), Boolean.valueOf(this.zzbv));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 2, this.zzbu);
        SafeParcelWriter.writeBoolean(parcel, 3, this.zzbv);
        SafeParcelWriter.writeTypedList(parcel, 4, this.zzbw, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

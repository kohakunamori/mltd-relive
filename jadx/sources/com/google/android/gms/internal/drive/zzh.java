package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.drive.DriveId;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "TransferProgressDataCreator")
@SafeParcelable.Reserved({1})
public final class zzh extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzh> CREATOR = new zzi();

    @SafeParcelable.Field(m22id = 4)
    final int status;

    @SafeParcelable.Field(m22id = 2)
    final int zzcr;

    @SafeParcelable.Field(m22id = 5)
    final long zzcu;

    @SafeParcelable.Field(m22id = 6)
    final long zzcv;

    @SafeParcelable.Field(m22id = 3)
    final DriveId zzk;

    @SafeParcelable.Constructor
    public zzh(@SafeParcelable.Param(m23id = 2) int i, @SafeParcelable.Param(m23id = 3) DriveId driveId, @SafeParcelable.Param(m23id = 4) int i2, @SafeParcelable.Param(m23id = 5) long j, @SafeParcelable.Param(m23id = 6) long j2) {
        this.zzcr = i;
        this.zzk = driveId;
        this.status = i2;
        this.zzcu = j;
        this.zzcv = j2;
    }

    public final boolean equals(Object obj) {
        if (obj != null && obj.getClass() == getClass()) {
            if (obj == this) {
                return true;
            }
            zzh zzhVar = (zzh) obj;
            if (this.zzcr == zzhVar.zzcr && Objects.equal(this.zzk, zzhVar.zzk) && this.status == zzhVar.status && this.zzcu == zzhVar.zzcu && this.zzcv == zzhVar.zzcv) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(Integer.valueOf(this.zzcr), this.zzk, Integer.valueOf(this.status), Long.valueOf(this.zzcu), Long.valueOf(this.zzcv));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 2, this.zzcr);
        SafeParcelWriter.writeParcelable(parcel, 3, this.zzk, i, false);
        SafeParcelWriter.writeInt(parcel, 4, this.status);
        SafeParcelWriter.writeLong(parcel, 5, this.zzcu);
        SafeParcelWriter.writeLong(parcel, 6, this.zzcv);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

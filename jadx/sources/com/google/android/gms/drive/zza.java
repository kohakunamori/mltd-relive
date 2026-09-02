package com.google.android.gms.drive;

import android.os.Parcel;
import android.os.Parcelable;
import android.util.Base64;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.internal.drive.zzhm;
import com.google.android.gms.internal.drive.zzix;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "ChangeSequenceNumberCreator")
@SafeParcelable.Reserved({1})
public class zza extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zza> CREATOR = new zzb();

    @SafeParcelable.Field(m22id = 2)
    private final long zze;

    @SafeParcelable.Field(m22id = 3)
    private final long zzf;

    @SafeParcelable.Field(m22id = 4)
    private final long zzg;
    private volatile String zzh = null;

    @SafeParcelable.Constructor
    public zza(@SafeParcelable.Param(m23id = 2) long j, @SafeParcelable.Param(m23id = 3) long j2, @SafeParcelable.Param(m23id = 4) long j3) {
        Preconditions.checkArgument(j != -1);
        Preconditions.checkArgument(j2 != -1);
        Preconditions.checkArgument(j3 != -1);
        this.zze = j;
        this.zzf = j2;
        this.zzg = j3;
    }

    public boolean equals(Object obj) {
        if (obj != null && obj.getClass() == zza.class) {
            zza zzaVar = (zza) obj;
            if (zzaVar.zzf == this.zzf && zzaVar.zzg == this.zzg && zzaVar.zze == this.zze) {
                return true;
            }
        }
        return false;
    }

    public int hashCode() {
        String strValueOf = String.valueOf(this.zze);
        String strValueOf2 = String.valueOf(this.zzf);
        String strValueOf3 = String.valueOf(this.zzg);
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + String.valueOf(strValueOf2).length() + String.valueOf(strValueOf3).length());
        sb.append(strValueOf);
        sb.append(strValueOf2);
        sb.append(strValueOf3);
        return sb.toString().hashCode();
    }

    public String toString() {
        if (this.zzh == null) {
            zzhm zzhmVar = new zzhm();
            zzhmVar.versionCode = 1;
            zzhmVar.zze = this.zze;
            zzhmVar.zzf = this.zzf;
            zzhmVar.zzg = this.zzg;
            String strEncodeToString = Base64.encodeToString(zzix.zza(zzhmVar), 10);
            String strValueOf = String.valueOf("ChangeSequenceNumber:");
            String strValueOf2 = String.valueOf(strEncodeToString);
            this.zzh = strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf);
        }
        return this.zzh;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeLong(parcel, 2, this.zze);
        SafeParcelWriter.writeLong(parcel, 3, this.zzf);
        SafeParcelWriter.writeLong(parcel, 4, this.zzg);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

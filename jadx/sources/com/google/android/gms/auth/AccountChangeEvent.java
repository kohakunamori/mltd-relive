package com.google.android.gms.auth;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "AccountChangeEventCreator")
public class AccountChangeEvent extends AbstractSafeParcelable {
    public static final Parcelable.Creator<AccountChangeEvent> CREATOR = new zza();

    @SafeParcelable.VersionField(m24id = 1)
    private final int zze;

    @SafeParcelable.Field(m22id = 2)
    private final long zzf;

    @SafeParcelable.Field(m22id = 3)
    private final String zzg;

    @SafeParcelable.Field(m22id = 4)
    private final int zzh;

    @SafeParcelable.Field(m22id = 5)
    private final int zzi;

    @SafeParcelable.Field(m22id = 6)
    private final String zzj;

    @SafeParcelable.Constructor
    AccountChangeEvent(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) long j, @SafeParcelable.Param(m23id = 3) String str, @SafeParcelable.Param(m23id = 4) int i2, @SafeParcelable.Param(m23id = 5) int i3, @SafeParcelable.Param(m23id = 6) String str2) {
        this.zze = i;
        this.zzf = j;
        this.zzg = (String) Preconditions.checkNotNull(str);
        this.zzh = i2;
        this.zzi = i3;
        this.zzj = str2;
    }

    public AccountChangeEvent(long j, String str, int i, int i2, String str2) {
        this.zze = 1;
        this.zzf = j;
        this.zzg = (String) Preconditions.checkNotNull(str);
        this.zzh = i;
        this.zzi = i2;
        this.zzj = str2;
    }

    public String getAccountName() {
        return this.zzg;
    }

    public int getChangeType() {
        return this.zzh;
    }

    public int getEventIndex() {
        return this.zzi;
    }

    public String getChangeData() {
        return this.zzj;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zze);
        SafeParcelWriter.writeLong(parcel, 2, this.zzf);
        SafeParcelWriter.writeString(parcel, 3, this.zzg, false);
        SafeParcelWriter.writeInt(parcel, 4, this.zzh);
        SafeParcelWriter.writeInt(parcel, 5, this.zzi);
        SafeParcelWriter.writeString(parcel, 6, this.zzj, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public String toString() {
        String str = "UNKNOWN";
        switch (this.zzh) {
            case 1:
                str = "ADDED";
                break;
            case 2:
                str = "REMOVED";
                break;
            case 3:
                str = "RENAMED_FROM";
                break;
            case 4:
                str = "RENAMED_TO";
                break;
        }
        String str2 = this.zzg;
        String str3 = this.zzj;
        int i = this.zzi;
        StringBuilder sb = new StringBuilder(String.valueOf(str2).length() + 91 + String.valueOf(str).length() + String.valueOf(str3).length());
        sb.append("AccountChangeEvent {accountName = ");
        sb.append(str2);
        sb.append(", changeType = ");
        sb.append(str);
        sb.append(", changeData = ");
        sb.append(str3);
        sb.append(", eventIndex = ");
        sb.append(i);
        sb.append("}");
        return sb.toString();
    }

    public int hashCode() {
        return Objects.hashCode(Integer.valueOf(this.zze), Long.valueOf(this.zzf), this.zzg, Integer.valueOf(this.zzh), Integer.valueOf(this.zzi), this.zzj);
    }

    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof AccountChangeEvent)) {
            return false;
        }
        AccountChangeEvent accountChangeEvent = (AccountChangeEvent) obj;
        return this.zze == accountChangeEvent.zze && this.zzf == accountChangeEvent.zzf && Objects.equal(this.zzg, accountChangeEvent.zzg) && this.zzh == accountChangeEvent.zzh && this.zzi == accountChangeEvent.zzi && Objects.equal(this.zzj, accountChangeEvent.zzj);
    }
}

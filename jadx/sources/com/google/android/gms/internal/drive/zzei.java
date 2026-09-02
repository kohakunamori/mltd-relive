package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.drive.FileUploadPreferences;
import com.google.android.gms.drive.TransferPreferences;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "FileUploadPreferencesImplCreator")
@SafeParcelable.Reserved({1})
@Deprecated
public final class zzei extends AbstractSafeParcelable implements FileUploadPreferences {
    public static final Parcelable.Creator<zzei> CREATOR = new zzej();

    @SafeParcelable.Field(m22id = 3)
    private int zzbl;

    @SafeParcelable.Field(m22id = 2)
    private int zzgw;

    @SafeParcelable.Field(m22id = 4)
    private boolean zzgx;

    @SafeParcelable.Constructor
    public zzei(@SafeParcelable.Param(m23id = 2) int i, @SafeParcelable.Param(m23id = 3) int i2, @SafeParcelable.Param(m23id = 4) boolean z) {
        this.zzgw = i;
        this.zzbl = i2;
        this.zzgx = z;
    }

    public zzei(TransferPreferences transferPreferences) {
        this(transferPreferences.getNetworkPreference(), transferPreferences.getBatteryUsagePreference(), transferPreferences.isRoamingAllowed());
    }

    private static boolean zzh(int i) {
        switch (i) {
            case 1:
            case 2:
                return true;
            default:
                return false;
        }
    }

    private static boolean zzi(int i) {
        switch (i) {
            case 256:
            case 257:
                return true;
            default:
                return false;
        }
    }

    @Override // com.google.android.gms.drive.FileUploadPreferences
    public final int getBatteryUsagePreference() {
        if (zzi(this.zzbl)) {
            return this.zzbl;
        }
        return 0;
    }

    @Override // com.google.android.gms.drive.FileUploadPreferences
    public final int getNetworkTypePreference() {
        if (zzh(this.zzgw)) {
            return this.zzgw;
        }
        return 0;
    }

    @Override // com.google.android.gms.drive.FileUploadPreferences
    public final boolean isRoamingAllowed() {
        return this.zzgx;
    }

    @Override // com.google.android.gms.drive.FileUploadPreferences
    public final void setBatteryUsagePreference(int i) {
        if (!zzi(i)) {
            throw new IllegalArgumentException("Invalid battery usage preference value.");
        }
        this.zzbl = i;
    }

    @Override // com.google.android.gms.drive.FileUploadPreferences
    public final void setNetworkTypePreference(int i) {
        if (!zzh(i)) {
            throw new IllegalArgumentException("Invalid data connection preference value.");
        }
        this.zzgw = i;
    }

    @Override // com.google.android.gms.drive.FileUploadPreferences
    public final void setRoamingAllowed(boolean z) {
        this.zzgx = z;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 2, this.zzgw);
        SafeParcelWriter.writeInt(parcel, 3, this.zzbl);
        SafeParcelWriter.writeBoolean(parcel, 4, this.zzgx);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

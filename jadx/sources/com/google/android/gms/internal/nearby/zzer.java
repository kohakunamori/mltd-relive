package com.google.android.gms.internal.nearby;

import android.bluetooth.BluetoothDevice;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OnEndpointFoundParamsCreator")
@SafeParcelable.Reserved({1000})
public final class zzer extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzer> CREATOR = new zzes();

    @SafeParcelable.Field(getter = "getEndpointId", m22id = 1)
    private String zzca;

    @SafeParcelable.Field(getter = "getEndpointName", m22id = 3)
    private String zzq;

    @SafeParcelable.Field(getter = "getServiceId", m22id = 2)
    private String zzu;

    @Nullable
    @SafeParcelable.Field(getter = "getBluetoothDevice", m22id = 4)
    private BluetoothDevice zzv;

    private zzer() {
    }

    @SafeParcelable.Constructor
    zzer(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) String str2, @SafeParcelable.Param(m23id = 3) String str3, @Nullable @SafeParcelable.Param(m23id = 4) BluetoothDevice bluetoothDevice) {
        this.zzca = str;
        this.zzu = str2;
        this.zzq = str3;
        this.zzv = bluetoothDevice;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzer) {
            zzer zzerVar = (zzer) obj;
            if (Objects.equal(this.zzca, zzerVar.zzca) && Objects.equal(this.zzu, zzerVar.zzu) && Objects.equal(this.zzq, zzerVar.zzq) && Objects.equal(this.zzv, zzerVar.zzv)) {
                return true;
            }
        }
        return false;
    }

    public final String getEndpointName() {
        return this.zzq;
    }

    public final String getServiceId() {
        return this.zzu;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzca, this.zzu, this.zzq, this.zzv);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzca, false);
        SafeParcelWriter.writeString(parcel, 2, this.zzu, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzq, false);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzv, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final String zze() {
        return this.zzca;
    }

    @Nullable
    public final BluetoothDevice zzk() {
        return this.zzv;
    }
}

package com.google.android.gms.internal.nearby;

import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "NearbyDeviceCreator")
public final class zzgs extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzgs> CREATOR = new zzgt();
    private static final String zzgu = null;
    public static final zzgs zzgv = new zzgs("", null);

    @SafeParcelable.VersionField(m24id = 1000)
    private final int zzex;

    @SafeParcelable.Field(getter = "getHandle", m22id = 3)
    private final String zzgw;

    @Nullable
    @SafeParcelable.Field(getter = "getBluetoothAddress", m22id = 6)
    private final String zzgx;

    @SafeParcelable.Constructor
    zzgs(@SafeParcelable.Param(m23id = 1000) int i, @Nullable @SafeParcelable.Param(m23id = 3) String str, @Nullable @SafeParcelable.Param(m23id = 6) String str2) {
        this.zzex = ((Integer) Preconditions.checkNotNull(Integer.valueOf(i))).intValue();
        this.zzgw = str == null ? "" : str;
        this.zzgx = str2;
    }

    private zzgs(String str, String str2) {
        this(1, str, null);
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzgs)) {
            return false;
        }
        zzgs zzgsVar = (zzgs) obj;
        return Objects.equal(this.zzgw, zzgsVar.zzgw) && Objects.equal(this.zzgx, zzgsVar.zzgx);
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzgw, this.zzgx);
    }

    public final String toString() {
        String str = this.zzgw;
        String str2 = this.zzgx;
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 40 + String.valueOf(str2).length());
        sb.append("NearbyDevice{handle=");
        sb.append(str);
        sb.append(", bluetoothAddress=");
        sb.append(str2);
        sb.append("}");
        return sb.toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 3, this.zzgw, false);
        SafeParcelWriter.writeString(parcel, 6, this.zzgx, false);
        SafeParcelWriter.writeInt(parcel, 1000, this.zzex);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

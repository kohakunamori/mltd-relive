package com.google.android.gms.internal.nearby;

import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.Arrays;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "ParcelablePayloadCreator")
@SafeParcelable.Reserved({1000})
public final class zzfh extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzfh> CREATOR = new zzfk();

    /* JADX INFO: renamed from: id */
    @SafeParcelable.Field(getter = "getId", m22id = 1)
    private long f15id;

    @SafeParcelable.Field(getter = "getType", m22id = 2)
    private int type;

    @Nullable
    @SafeParcelable.Field(getter = "getDataPfd", m22id = 4)
    private ParcelFileDescriptor zzdv;

    @Nullable
    @SafeParcelable.Field(getter = "getJavaFilePath", m22id = 5)
    private String zzdw;

    @SafeParcelable.Field(defaultValue = "-1", getter = "getJavaFileSize", m22id = 6)
    private long zzdx;

    @Nullable
    @SafeParcelable.Field(getter = "getStatusPfd", m22id = 7)
    private ParcelFileDescriptor zzdy;

    @Nullable
    @SafeParcelable.Field(getter = "getBytes", m22id = 3)
    private byte[] zzy;

    private zzfh() {
        this.zzdx = -1L;
    }

    @SafeParcelable.Constructor
    zzfh(@SafeParcelable.Param(m23id = 1) long j, @SafeParcelable.Param(m23id = 2) int i, @Nullable @SafeParcelable.Param(m23id = 3) byte[] bArr, @Nullable @SafeParcelable.Param(m23id = 4) ParcelFileDescriptor parcelFileDescriptor, @Nullable @SafeParcelable.Param(m23id = 5) String str, @SafeParcelable.Param(m23id = 6) long j2, @Nullable @SafeParcelable.Param(m23id = 7) ParcelFileDescriptor parcelFileDescriptor2) {
        this.zzdx = -1L;
        this.f15id = j;
        this.type = i;
        this.zzy = bArr;
        this.zzdv = parcelFileDescriptor;
        this.zzdw = str;
        this.zzdx = j2;
        this.zzdy = parcelFileDescriptor2;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzfh) {
            zzfh zzfhVar = (zzfh) obj;
            if (Objects.equal(Long.valueOf(this.f15id), Long.valueOf(zzfhVar.f15id)) && Objects.equal(Integer.valueOf(this.type), Integer.valueOf(zzfhVar.type)) && Arrays.equals(this.zzy, zzfhVar.zzy) && Objects.equal(this.zzdv, zzfhVar.zzdv) && Objects.equal(this.zzdw, zzfhVar.zzdw) && Objects.equal(Long.valueOf(this.zzdx), Long.valueOf(zzfhVar.zzdx)) && Objects.equal(this.zzdy, zzfhVar.zzdy)) {
                return true;
            }
        }
        return false;
    }

    @Nullable
    public final byte[] getBytes() {
        return this.zzy;
    }

    public final long getId() {
        return this.f15id;
    }

    public final int getType() {
        return this.type;
    }

    public final int hashCode() {
        return Objects.hashCode(Long.valueOf(this.f15id), Integer.valueOf(this.type), Integer.valueOf(Arrays.hashCode(this.zzy)), this.zzdv, this.zzdw, Long.valueOf(this.zzdx), this.zzdy);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeLong(parcel, 1, this.f15id);
        SafeParcelWriter.writeInt(parcel, 2, this.type);
        SafeParcelWriter.writeByteArray(parcel, 3, this.zzy, false);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzdv, i, false);
        SafeParcelWriter.writeString(parcel, 5, this.zzdw, false);
        SafeParcelWriter.writeLong(parcel, 6, this.zzdx);
        SafeParcelWriter.writeParcelable(parcel, 7, this.zzdy, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    @Nullable
    public final ParcelFileDescriptor zzo() {
        return this.zzdv;
    }

    @Nullable
    public final String zzp() {
        return this.zzdw;
    }

    public final long zzq() {
        return this.zzdx;
    }
}

package com.google.android.gms.nearby.connection;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "PayloadTransferUpdateCreator")
@SafeParcelable.Reserved({1000})
public final class PayloadTransferUpdate extends AbstractSafeParcelable {
    public static final Parcelable.Creator<PayloadTransferUpdate> CREATOR = new zzi();

    @SafeParcelable.Field(getter = "getStatus", m22id = 2)
    private int status;

    @SafeParcelable.Field(getter = "getPayloadId", m22id = 1)
    private long zzaf;

    @SafeParcelable.Field(getter = "getTotalBytes", m22id = 3)
    private long zzag;

    @SafeParcelable.Field(getter = "getBytesTransferred", m22id = 4)
    private long zzah;

    @Deprecated
    public static final class Builder {
        private final PayloadTransferUpdate zzai = new PayloadTransferUpdate();

        public Builder() {
        }

        public Builder(PayloadTransferUpdate payloadTransferUpdate) {
            this.zzai.zzaf = payloadTransferUpdate.zzaf;
            this.zzai.status = payloadTransferUpdate.status;
            this.zzai.zzag = payloadTransferUpdate.zzag;
            this.zzai.zzah = payloadTransferUpdate.zzah;
        }

        public final PayloadTransferUpdate build() {
            return this.zzai;
        }

        public final Builder setBytesTransferred(long j) {
            this.zzai.zzah = j;
            return this;
        }

        public final Builder setPayloadId(long j) {
            this.zzai.zzaf = j;
            return this;
        }

        public final Builder setStatus(int i) {
            this.zzai.status = i;
            return this;
        }

        public final Builder setTotalBytes(long j) {
            this.zzai.zzag = j;
            return this;
        }
    }

    @Retention(RetentionPolicy.SOURCE)
    public @interface Status {
        public static final int CANCELED = 4;
        public static final int FAILURE = 2;
        public static final int IN_PROGRESS = 3;
        public static final int SUCCESS = 1;
    }

    private PayloadTransferUpdate() {
    }

    @SafeParcelable.Constructor
    PayloadTransferUpdate(@SafeParcelable.Param(m23id = 1) long j, @SafeParcelable.Param(m23id = 2) int i, @SafeParcelable.Param(m23id = 3) long j2, @SafeParcelable.Param(m23id = 4) long j3) {
        this.zzaf = j;
        this.status = i;
        this.zzag = j2;
        this.zzah = j3;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof PayloadTransferUpdate) {
            PayloadTransferUpdate payloadTransferUpdate = (PayloadTransferUpdate) obj;
            if (Objects.equal(Long.valueOf(this.zzaf), Long.valueOf(payloadTransferUpdate.zzaf)) && Objects.equal(Integer.valueOf(this.status), Integer.valueOf(payloadTransferUpdate.status)) && Objects.equal(Long.valueOf(this.zzag), Long.valueOf(payloadTransferUpdate.zzag)) && Objects.equal(Long.valueOf(this.zzah), Long.valueOf(payloadTransferUpdate.zzah))) {
                return true;
            }
        }
        return false;
    }

    public final long getBytesTransferred() {
        return this.zzah;
    }

    public final long getPayloadId() {
        return this.zzaf;
    }

    public final int getStatus() {
        return this.status;
    }

    public final long getTotalBytes() {
        return this.zzag;
    }

    public final int hashCode() {
        return Objects.hashCode(Long.valueOf(this.zzaf), Integer.valueOf(this.status), Long.valueOf(this.zzag), Long.valueOf(this.zzah));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeLong(parcel, 1, getPayloadId());
        SafeParcelWriter.writeInt(parcel, 2, getStatus());
        SafeParcelWriter.writeLong(parcel, 3, getTotalBytes());
        SafeParcelWriter.writeLong(parcel, 4, getBytesTransferred());
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

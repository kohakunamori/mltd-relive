package com.google.android.gms.nearby.connection;

import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.Arrays;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "AdvertisingOptionsCreator")
@SafeParcelable.Reserved({1000})
public final class AdvertisingOptions extends AbstractSafeParcelable {
    public static final Parcelable.Creator<AdvertisingOptions> CREATOR = new zzb();

    @SafeParcelable.Field(getter = "getStrategy", m22id = 1)
    private Strategy zzh;

    @SafeParcelable.Field(defaultValue = "true", getter = "getAutoUpgradeBandwidth", m22id = 2)
    private boolean zzi;

    @SafeParcelable.Field(defaultValue = "true", getter = "getEnforceTopologyConstraints", m22id = 3)
    private boolean zzj;

    @SafeParcelable.Field(defaultValue = "true", getter = "getEnableBluetooth", m22id = 4)
    private boolean zzk;

    @SafeParcelable.Field(defaultValue = "true", getter = "getEnableBle", m22id = 5)
    private boolean zzl;

    @Nullable
    @SafeParcelable.Field(getter = "getNearbyNotificationsBeaconData", m22id = 6)
    private byte[] zzm;

    public static final class Builder {
        private final AdvertisingOptions zzn = new AdvertisingOptions();

        public Builder() {
        }

        public Builder(AdvertisingOptions advertisingOptions) {
            this.zzn.zzh = advertisingOptions.zzh;
            this.zzn.zzi = advertisingOptions.zzi;
            this.zzn.zzj = advertisingOptions.zzj;
            this.zzn.zzk = advertisingOptions.zzk;
            this.zzn.zzl = advertisingOptions.zzl;
            this.zzn.zzm = advertisingOptions.zzm;
        }

        public final AdvertisingOptions build() {
            return this.zzn;
        }

        public final Builder setStrategy(Strategy strategy) {
            this.zzn.zzh = strategy;
            return this;
        }
    }

    private AdvertisingOptions() {
        this.zzi = true;
        this.zzj = true;
        this.zzk = true;
        this.zzl = true;
    }

    @Deprecated
    public AdvertisingOptions(Strategy strategy) {
        this.zzi = true;
        this.zzj = true;
        this.zzk = true;
        this.zzl = true;
        this.zzh = strategy;
    }

    @SafeParcelable.Constructor
    AdvertisingOptions(@SafeParcelable.Param(m23id = 1) Strategy strategy, @SafeParcelable.Param(m23id = 2) boolean z, @SafeParcelable.Param(m23id = 3) boolean z2, @SafeParcelable.Param(m23id = 4) boolean z3, @SafeParcelable.Param(m23id = 5) boolean z4, @Nullable @SafeParcelable.Param(m23id = 6) byte[] bArr) {
        this.zzi = true;
        this.zzj = true;
        this.zzk = true;
        this.zzl = true;
        this.zzh = strategy;
        this.zzi = z;
        this.zzj = z2;
        this.zzk = z3;
        this.zzl = z4;
        this.zzm = bArr;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof AdvertisingOptions) {
            AdvertisingOptions advertisingOptions = (AdvertisingOptions) obj;
            if (Objects.equal(this.zzh, advertisingOptions.zzh) && Objects.equal(Boolean.valueOf(this.zzi), Boolean.valueOf(advertisingOptions.zzi)) && Objects.equal(Boolean.valueOf(this.zzj), Boolean.valueOf(advertisingOptions.zzj)) && Objects.equal(Boolean.valueOf(this.zzk), Boolean.valueOf(advertisingOptions.zzk)) && Objects.equal(Boolean.valueOf(this.zzl), Boolean.valueOf(advertisingOptions.zzl)) && Arrays.equals(this.zzm, advertisingOptions.zzm)) {
                return true;
            }
        }
        return false;
    }

    public final Strategy getStrategy() {
        return this.zzh;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzh, Boolean.valueOf(this.zzi), Boolean.valueOf(this.zzj), Boolean.valueOf(this.zzk), Boolean.valueOf(this.zzl), Integer.valueOf(Arrays.hashCode(this.zzm)));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, getStrategy(), i, false);
        SafeParcelWriter.writeBoolean(parcel, 2, this.zzi);
        SafeParcelWriter.writeBoolean(parcel, 3, this.zzj);
        SafeParcelWriter.writeBoolean(parcel, 4, this.zzk);
        SafeParcelWriter.writeBoolean(parcel, 5, this.zzl);
        SafeParcelWriter.writeByteArray(parcel, 6, this.zzm, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

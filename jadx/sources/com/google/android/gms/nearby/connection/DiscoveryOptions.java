package com.google.android.gms.nearby.connection;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "DiscoveryOptionsCreator")
@SafeParcelable.Reserved({1000})
public final class DiscoveryOptions extends AbstractSafeParcelable {
    public static final Parcelable.Creator<DiscoveryOptions> CREATOR = new zzg();

    @SafeParcelable.Field(getter = "getStrategy", m22id = 1)
    private Strategy zzh;

    @SafeParcelable.Field(defaultValue = "true", getter = "getEnableBluetooth", m22id = 3)
    private boolean zzk;

    @SafeParcelable.Field(defaultValue = "true", getter = "getEnableBle", m22id = 4)
    private boolean zzl;

    @SafeParcelable.Field(defaultValue = "false", getter = "getForwardUnrecognizedBluetoothDevices", m22id = 2)
    private boolean zzw;

    public static final class Builder {
        private final DiscoveryOptions zzx = new DiscoveryOptions();

        public Builder() {
        }

        public Builder(DiscoveryOptions discoveryOptions) {
            this.zzx.zzh = discoveryOptions.zzh;
            this.zzx.zzw = discoveryOptions.zzw;
            this.zzx.zzk = discoveryOptions.zzk;
            this.zzx.zzl = discoveryOptions.zzl;
        }

        public final DiscoveryOptions build() {
            return this.zzx;
        }

        public final Builder setStrategy(Strategy strategy) {
            this.zzx.zzh = strategy;
            return this;
        }
    }

    private DiscoveryOptions() {
        this.zzw = false;
        this.zzk = true;
        this.zzl = true;
    }

    @Deprecated
    public DiscoveryOptions(Strategy strategy) {
        this.zzw = false;
        this.zzk = true;
        this.zzl = true;
        this.zzh = strategy;
    }

    @SafeParcelable.Constructor
    DiscoveryOptions(@SafeParcelable.Param(m23id = 1) Strategy strategy, @SafeParcelable.Param(m23id = 2) boolean z, @SafeParcelable.Param(m23id = 3) boolean z2, @SafeParcelable.Param(m23id = 4) boolean z3) {
        this.zzw = false;
        this.zzk = true;
        this.zzl = true;
        this.zzh = strategy;
        this.zzw = z;
        this.zzk = z2;
        this.zzl = z3;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof DiscoveryOptions) {
            DiscoveryOptions discoveryOptions = (DiscoveryOptions) obj;
            if (Objects.equal(this.zzh, discoveryOptions.zzh) && Objects.equal(Boolean.valueOf(this.zzw), Boolean.valueOf(discoveryOptions.zzw)) && Objects.equal(Boolean.valueOf(this.zzk), Boolean.valueOf(discoveryOptions.zzk)) && Objects.equal(Boolean.valueOf(this.zzl), Boolean.valueOf(discoveryOptions.zzl))) {
                return true;
            }
        }
        return false;
    }

    public final Strategy getStrategy() {
        return this.zzh;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzh, Boolean.valueOf(this.zzw), Boolean.valueOf(this.zzk), Boolean.valueOf(this.zzl));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, getStrategy(), i, false);
        SafeParcelWriter.writeBoolean(parcel, 2, this.zzw);
        SafeParcelWriter.writeBoolean(parcel, 3, this.zzk);
        SafeParcelWriter.writeBoolean(parcel, 4, this.zzl);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

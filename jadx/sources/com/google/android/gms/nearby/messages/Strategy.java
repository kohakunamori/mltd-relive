package com.google.android.gms.nearby.messages;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.games.quest.Quests;
import java.util.ArrayList;
import javax.annotation.concurrent.Immutable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "StrategyCreator")
@Immutable
public class Strategy extends AbstractSafeParcelable {
    public static final Strategy BLE_ONLY;
    public static final Parcelable.Creator<Strategy> CREATOR = new zzg();
    public static final Strategy DEFAULT = new Builder().build();
    public static final int DISCOVERY_MODE_BROADCAST = 1;
    public static final int DISCOVERY_MODE_DEFAULT = 3;
    public static final int DISCOVERY_MODE_SCAN = 2;
    public static final int DISTANCE_TYPE_DEFAULT = 0;
    public static final int DISTANCE_TYPE_EARSHOT = 1;
    public static final int TTL_SECONDS_DEFAULT = 300;
    public static final int TTL_SECONDS_INFINITE = Integer.MAX_VALUE;
    public static final int TTL_SECONDS_MAX = 86400;

    @Deprecated
    private static final Strategy zzfm;

    @SafeParcelable.VersionField(m24id = 1000)
    private final int zzex;

    @SafeParcelable.Field(m22id = 1)
    @Deprecated
    private final int zzfn;

    @SafeParcelable.Field(m22id = 2)
    private final int zzfo;

    @SafeParcelable.Field(m22id = 3)
    private final int zzfp;

    @SafeParcelable.Field(m22id = 4)
    @Deprecated
    private final boolean zzfq;

    @SafeParcelable.Field(getter = "getDiscoveryMedium", m22id = 5)
    private final int zzfr;

    @SafeParcelable.Field(getter = "getDiscoveryMode", m22id = 6)
    private final int zzfs;

    @SafeParcelable.Field(getter = "getBackgroundScanMode", m22id = 7)
    private final int zzft;

    public static class Builder {
        private int zzfu = 3;
        private int zzfv = Strategy.TTL_SECONDS_DEFAULT;
        private int zzfw = 0;
        private int zzfx = -1;
        private int zzfy = 0;

        public Strategy build() {
            if (this.zzfx == 2 && this.zzfw == 1) {
                throw new IllegalStateException("Cannot set EARSHOT with BLE only mode.");
            }
            return new Strategy(2, 0, this.zzfv, this.zzfw, false, this.zzfx, this.zzfu, 0);
        }

        public Builder setDiscoveryMode(int i) {
            this.zzfu = i;
            return this;
        }

        public Builder setDistanceType(int i) {
            this.zzfw = i;
            return this;
        }

        public Builder setTtlSeconds(int i) {
            Preconditions.checkArgument(i == Integer.MAX_VALUE || (i > 0 && i <= 86400), "mTtlSeconds(%d) must either be TTL_SECONDS_INFINITE, or it must be between 1 and TTL_SECONDS_MAX(%d) inclusive", Integer.valueOf(i), Integer.valueOf(Strategy.TTL_SECONDS_MAX));
            this.zzfv = i;
            return this;
        }

        public final Builder zze(int i) {
            this.zzfx = 2;
            return this;
        }
    }

    static {
        Strategy strategyBuild = new Builder().zze(2).setTtlSeconds(Integer.MAX_VALUE).build();
        BLE_ONLY = strategyBuild;
        zzfm = strategyBuild;
    }

    /* JADX WARN: Code duplicated, block: B:17:0x0032  */
    @SafeParcelable.Constructor
    Strategy(@SafeParcelable.Param(m23id = 1000) int i, @SafeParcelable.Param(m23id = 1) int i2, @SafeParcelable.Param(m23id = 2) int i3, @SafeParcelable.Param(m23id = 3) int i4, @SafeParcelable.Param(m23id = 4) boolean z, @SafeParcelable.Param(m23id = 5) int i5, @SafeParcelable.Param(m23id = 6) int i6, @SafeParcelable.Param(m23id = 7) int i7) {
        int i8;
        this.zzex = i;
        this.zzfn = i2;
        if (i2 != 0) {
            switch (i2) {
                case 2:
                    i8 = 1;
                    this.zzfs = i8;
                    break;
                case 3:
                    this.zzfs = 2;
                    break;
                default:
                    i8 = 3;
                    this.zzfs = i8;
                    break;
            }
        } else {
            this.zzfs = i6;
        }
        this.zzfp = i4;
        this.zzfq = z;
        if (z) {
            this.zzfr = 2;
            this.zzfo = Integer.MAX_VALUE;
        } else {
            this.zzfo = i3;
            if (i5 != 6) {
                switch (i5) {
                    case -1:
                    case 0:
                    case 1:
                        this.zzfr = -1;
                        break;
                    default:
                        this.zzfr = i5;
                        break;
                }
            } else {
                this.zzfr = -1;
            }
        }
        this.zzft = i7;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof Strategy)) {
            return false;
        }
        Strategy strategy = (Strategy) obj;
        return this.zzex == strategy.zzex && this.zzfs == strategy.zzfs && this.zzfo == strategy.zzfo && this.zzfp == strategy.zzfp && this.zzfr == strategy.zzfr && this.zzft == strategy.zzft;
    }

    public int hashCode() {
        return (((((((((this.zzex * 31) + this.zzfs) * 31) + this.zzfo) * 31) + this.zzfp) * 31) + this.zzfr) * 31) + this.zzft;
    }

    public String toString() {
        String string;
        String string2;
        String string3;
        String string4;
        int i = this.zzfo;
        int i2 = this.zzfp;
        switch (i2) {
            case 0:
                string = "DEFAULT";
                break;
            case 1:
                string = "EARSHOT";
                break;
            default:
                StringBuilder sb = new StringBuilder(19);
                sb.append("UNKNOWN:");
                sb.append(i2);
                string = sb.toString();
                break;
        }
        int i3 = this.zzfr;
        if (i3 == -1) {
            string2 = "DEFAULT";
        } else {
            ArrayList arrayList = new ArrayList();
            if ((i3 & 4) > 0) {
                arrayList.add("ULTRASOUND");
            }
            if ((i3 & 2) > 0) {
                arrayList.add("BLE");
            }
            if (arrayList.isEmpty()) {
                StringBuilder sb2 = new StringBuilder(19);
                sb2.append("UNKNOWN:");
                sb2.append(i3);
                string2 = sb2.toString();
            } else {
                string2 = arrayList.toString();
            }
        }
        int i4 = this.zzfs;
        if (i4 == 3) {
            string3 = "DEFAULT";
        } else {
            ArrayList arrayList2 = new ArrayList();
            if ((i4 & 1) > 0) {
                arrayList2.add("BROADCAST");
            }
            if ((i4 & 2) > 0) {
                arrayList2.add("SCAN");
            }
            if (arrayList2.isEmpty()) {
                StringBuilder sb3 = new StringBuilder(19);
                sb3.append("UNKNOWN:");
                sb3.append(i4);
                string3 = sb3.toString();
            } else {
                string3 = arrayList2.toString();
            }
        }
        int i5 = this.zzft;
        switch (i5) {
            case 0:
                string4 = "DEFAULT";
                break;
            case 1:
                string4 = "ALWAYS_ON";
                break;
            default:
                StringBuilder sb4 = new StringBuilder(20);
                sb4.append("UNKNOWN: ");
                sb4.append(i5);
                string4 = sb4.toString();
                break;
        }
        StringBuilder sb5 = new StringBuilder(String.valueOf(string).length() + Quests.SELECT_ENDING_SOON + String.valueOf(string2).length() + String.valueOf(string3).length() + String.valueOf(string4).length());
        sb5.append("Strategy{ttlSeconds=");
        sb5.append(i);
        sb5.append(", distanceType=");
        sb5.append(string);
        sb5.append(", discoveryMedium=");
        sb5.append(string2);
        sb5.append(", discoveryMode=");
        sb5.append(string3);
        sb5.append(", backgroundScanMode=");
        sb5.append(string4);
        sb5.append('}');
        return sb5.toString();
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zzfn);
        SafeParcelWriter.writeInt(parcel, 2, this.zzfo);
        SafeParcelWriter.writeInt(parcel, 3, this.zzfp);
        SafeParcelWriter.writeBoolean(parcel, 4, this.zzfq);
        SafeParcelWriter.writeInt(parcel, 5, this.zzfr);
        SafeParcelWriter.writeInt(parcel, 6, this.zzfs);
        SafeParcelWriter.writeInt(parcel, 7, this.zzft);
        SafeParcelWriter.writeInt(parcel, 1000, this.zzex);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final int zzae() {
        return this.zzft;
    }
}

package com.google.android.gms.games;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "PlayerLevelCreator")
@SafeParcelable.Reserved({1000})
public final class PlayerLevel extends com.google.android.gms.games.internal.zzd {
    public static final Parcelable.Creator<PlayerLevel> CREATOR = new zzaq();

    @SafeParcelable.Field(getter = "getLevelNumber", m22id = 1)
    private final int zzcr;

    @SafeParcelable.Field(getter = "getMinXp", m22id = 2)
    private final long zzcs;

    @SafeParcelable.Field(getter = "getMaxXp", m22id = 3)
    private final long zzct;

    @SafeParcelable.Constructor
    public PlayerLevel(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) long j, @SafeParcelable.Param(m23id = 3) long j2) {
        Preconditions.checkState(j >= 0, "Min XP must be positive!");
        Preconditions.checkState(j2 > j, "Max XP must be more than min XP!");
        this.zzcr = i;
        this.zzcs = j;
        this.zzct = j2;
    }

    public final int getLevelNumber() {
        return this.zzcr;
    }

    public final long getMinXp() {
        return this.zzcs;
    }

    public final long getMaxXp() {
        return this.zzct;
    }

    public final int hashCode() {
        return Objects.hashCode(Integer.valueOf(this.zzcr), Long.valueOf(this.zzcs), Long.valueOf(this.zzct));
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof PlayerLevel)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        PlayerLevel playerLevel = (PlayerLevel) obj;
        return Objects.equal(Integer.valueOf(playerLevel.getLevelNumber()), Integer.valueOf(getLevelNumber())) && Objects.equal(Long.valueOf(playerLevel.getMinXp()), Long.valueOf(getMinXp())) && Objects.equal(Long.valueOf(playerLevel.getMaxXp()), Long.valueOf(getMaxXp()));
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("LevelNumber", Integer.valueOf(getLevelNumber())).add("MinXp", Long.valueOf(getMinXp())).add("MaxXp", Long.valueOf(getMaxXp())).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, getLevelNumber());
        SafeParcelWriter.writeLong(parcel, 2, getMinXp());
        SafeParcelWriter.writeLong(parcel, 3, getMaxXp());
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

package com.google.android.gms.games;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "PlayerLevelInfoCreator")
@SafeParcelable.Reserved({1000})
public final class PlayerLevelInfo extends com.google.android.gms.games.internal.zzd {
    public static final Parcelable.Creator<PlayerLevelInfo> CREATOR = new zzar();

    @SafeParcelable.Field(getter = "getCurrentXpTotal", m22id = 1)
    private final long zzcu;

    @SafeParcelable.Field(getter = "getLastLevelUpTimestamp", m22id = 2)
    private final long zzcv;

    @SafeParcelable.Field(getter = "getCurrentLevel", m22id = 3)
    private final PlayerLevel zzcw;

    @SafeParcelable.Field(getter = "getNextLevel", m22id = 4)
    private final PlayerLevel zzcx;

    @SafeParcelable.Constructor
    public PlayerLevelInfo(@SafeParcelable.Param(m23id = 1) long j, @SafeParcelable.Param(m23id = 2) long j2, @SafeParcelable.Param(m23id = 3) PlayerLevel playerLevel, @SafeParcelable.Param(m23id = 4) PlayerLevel playerLevel2) {
        Preconditions.checkState(j != -1);
        Preconditions.checkNotNull(playerLevel);
        Preconditions.checkNotNull(playerLevel2);
        this.zzcu = j;
        this.zzcv = j2;
        this.zzcw = playerLevel;
        this.zzcx = playerLevel2;
    }

    public final long getCurrentXpTotal() {
        return this.zzcu;
    }

    public final long getLastLevelUpTimestamp() {
        return this.zzcv;
    }

    public final PlayerLevel getCurrentLevel() {
        return this.zzcw;
    }

    public final PlayerLevel getNextLevel() {
        return this.zzcx;
    }

    public final boolean isMaxLevel() {
        return this.zzcw.equals(this.zzcx);
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof PlayerLevelInfo)) {
            return false;
        }
        if (obj == this) {
            return true;
        }
        PlayerLevelInfo playerLevelInfo = (PlayerLevelInfo) obj;
        return Objects.equal(Long.valueOf(this.zzcu), Long.valueOf(playerLevelInfo.zzcu)) && Objects.equal(Long.valueOf(this.zzcv), Long.valueOf(playerLevelInfo.zzcv)) && Objects.equal(this.zzcw, playerLevelInfo.zzcw) && Objects.equal(this.zzcx, playerLevelInfo.zzcx);
    }

    public final int hashCode() {
        return Objects.hashCode(Long.valueOf(this.zzcu), Long.valueOf(this.zzcv), this.zzcw, this.zzcx);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeLong(parcel, 1, getCurrentXpTotal());
        SafeParcelWriter.writeLong(parcel, 2, getLastLevelUpTimestamp());
        SafeParcelWriter.writeParcelable(parcel, 3, getCurrentLevel(), i, false);
        SafeParcelWriter.writeParcelable(parcel, 4, getNextLevel(), i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

package com.google.android.gms.games.stats;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.games.internal.zzd;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "PlayerStatsEntityCreator")
@SafeParcelable.Reserved({1000})
public class PlayerStatsEntity extends zzd implements PlayerStats {
    public static final Parcelable.Creator<PlayerStatsEntity> CREATOR = new zza();

    @SafeParcelable.Field(getter = "getAverageSessionLength", m22id = 1)
    private final float zzsi;

    @SafeParcelable.Field(getter = "getChurnProbability", m22id = 2)
    private final float zzsj;

    @SafeParcelable.Field(getter = "getDaysSinceLastPlayed", m22id = 3)
    private final int zzsk;

    @SafeParcelable.Field(getter = "getNumberOfPurchases", m22id = 4)
    private final int zzsl;

    @SafeParcelable.Field(getter = "getNumberOfSessions", m22id = 5)
    private final int zzsm;

    @SafeParcelable.Field(getter = "getSessionPercentile", m22id = 6)
    private final float zzsn;

    @SafeParcelable.Field(getter = "getSpendPercentile", m22id = 7)
    private final float zzso;

    @SafeParcelable.Field(getter = "getRawValues", m22id = 8)
    private final Bundle zzsp;

    @SafeParcelable.Field(getter = "getSpendProbability", m22id = 9)
    private final float zzsq;

    @SafeParcelable.Field(getter = "getHighSpenderProbability", m22id = 10)
    private final float zzsr;

    @SafeParcelable.Field(getter = "getTotalSpendNext28Days", m22id = 11)
    private final float zzss;

    public PlayerStatsEntity(PlayerStats playerStats) {
        this.zzsi = playerStats.getAverageSessionLength();
        this.zzsj = playerStats.getChurnProbability();
        this.zzsk = playerStats.getDaysSinceLastPlayed();
        this.zzsl = playerStats.getNumberOfPurchases();
        this.zzsm = playerStats.getNumberOfSessions();
        this.zzsn = playerStats.getSessionPercentile();
        this.zzso = playerStats.getSpendPercentile();
        this.zzsq = playerStats.getSpendProbability();
        this.zzsr = playerStats.getHighSpenderProbability();
        this.zzss = playerStats.getTotalSpendNext28Days();
        this.zzsp = playerStats.zzdu();
    }

    @Override // com.google.android.gms.common.data.Freezable
    public /* bridge */ /* synthetic */ PlayerStats freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public boolean isDataValid() {
        return true;
    }

    @SafeParcelable.Constructor
    PlayerStatsEntity(@SafeParcelable.Param(m23id = 1) float f, @SafeParcelable.Param(m23id = 2) float f2, @SafeParcelable.Param(m23id = 3) int i, @SafeParcelable.Param(m23id = 4) int i2, @SafeParcelable.Param(m23id = 5) int i3, @SafeParcelable.Param(m23id = 6) float f3, @SafeParcelable.Param(m23id = 7) float f4, @SafeParcelable.Param(m23id = 8) Bundle bundle, @SafeParcelable.Param(m23id = 9) float f5, @SafeParcelable.Param(m23id = 10) float f6, @SafeParcelable.Param(m23id = 11) float f7) {
        this.zzsi = f;
        this.zzsj = f2;
        this.zzsk = i;
        this.zzsl = i2;
        this.zzsm = i3;
        this.zzsn = f3;
        this.zzso = f4;
        this.zzsp = bundle;
        this.zzsq = f5;
        this.zzsr = f6;
        this.zzss = f7;
    }

    @Override // com.google.android.gms.games.stats.PlayerStats
    public float getAverageSessionLength() {
        return this.zzsi;
    }

    @Override // com.google.android.gms.games.stats.PlayerStats
    public float getChurnProbability() {
        return this.zzsj;
    }

    @Override // com.google.android.gms.games.stats.PlayerStats
    public int getDaysSinceLastPlayed() {
        return this.zzsk;
    }

    @Override // com.google.android.gms.games.stats.PlayerStats
    public int getNumberOfPurchases() {
        return this.zzsl;
    }

    @Override // com.google.android.gms.games.stats.PlayerStats
    public int getNumberOfSessions() {
        return this.zzsm;
    }

    @Override // com.google.android.gms.games.stats.PlayerStats
    public float getSessionPercentile() {
        return this.zzsn;
    }

    @Override // com.google.android.gms.games.stats.PlayerStats
    public float getSpendPercentile() {
        return this.zzso;
    }

    @Override // com.google.android.gms.games.stats.PlayerStats
    public final Bundle zzdu() {
        return this.zzsp;
    }

    @Override // com.google.android.gms.games.stats.PlayerStats
    public float getSpendProbability() {
        return this.zzsq;
    }

    @Override // com.google.android.gms.games.stats.PlayerStats
    public float getHighSpenderProbability() {
        return this.zzsr;
    }

    @Override // com.google.android.gms.games.stats.PlayerStats
    public float getTotalSpendNext28Days() {
        return this.zzss;
    }

    public int hashCode() {
        return zza(this);
    }

    static int zza(PlayerStats playerStats) {
        return Objects.hashCode(Float.valueOf(playerStats.getAverageSessionLength()), Float.valueOf(playerStats.getChurnProbability()), Integer.valueOf(playerStats.getDaysSinceLastPlayed()), Integer.valueOf(playerStats.getNumberOfPurchases()), Integer.valueOf(playerStats.getNumberOfSessions()), Float.valueOf(playerStats.getSessionPercentile()), Float.valueOf(playerStats.getSpendPercentile()), Float.valueOf(playerStats.getSpendProbability()), Float.valueOf(playerStats.getHighSpenderProbability()), Float.valueOf(playerStats.getTotalSpendNext28Days()));
    }

    public boolean equals(Object obj) {
        return zza(this, obj);
    }

    static boolean zza(PlayerStats playerStats, Object obj) {
        if (!(obj instanceof PlayerStats)) {
            return false;
        }
        if (playerStats == obj) {
            return true;
        }
        PlayerStats playerStats2 = (PlayerStats) obj;
        return Objects.equal(Float.valueOf(playerStats2.getAverageSessionLength()), Float.valueOf(playerStats.getAverageSessionLength())) && Objects.equal(Float.valueOf(playerStats2.getChurnProbability()), Float.valueOf(playerStats.getChurnProbability())) && Objects.equal(Integer.valueOf(playerStats2.getDaysSinceLastPlayed()), Integer.valueOf(playerStats.getDaysSinceLastPlayed())) && Objects.equal(Integer.valueOf(playerStats2.getNumberOfPurchases()), Integer.valueOf(playerStats.getNumberOfPurchases())) && Objects.equal(Integer.valueOf(playerStats2.getNumberOfSessions()), Integer.valueOf(playerStats.getNumberOfSessions())) && Objects.equal(Float.valueOf(playerStats2.getSessionPercentile()), Float.valueOf(playerStats.getSessionPercentile())) && Objects.equal(Float.valueOf(playerStats2.getSpendPercentile()), Float.valueOf(playerStats.getSpendPercentile())) && Objects.equal(Float.valueOf(playerStats2.getSpendProbability()), Float.valueOf(playerStats.getSpendProbability())) && Objects.equal(Float.valueOf(playerStats2.getHighSpenderProbability()), Float.valueOf(playerStats.getHighSpenderProbability())) && Objects.equal(Float.valueOf(playerStats2.getTotalSpendNext28Days()), Float.valueOf(playerStats.getTotalSpendNext28Days()));
    }

    public String toString() {
        return zzb(this);
    }

    static String zzb(PlayerStats playerStats) {
        return Objects.toStringHelper(playerStats).add("AverageSessionLength", Float.valueOf(playerStats.getAverageSessionLength())).add("ChurnProbability", Float.valueOf(playerStats.getChurnProbability())).add("DaysSinceLastPlayed", Integer.valueOf(playerStats.getDaysSinceLastPlayed())).add("NumberOfPurchases", Integer.valueOf(playerStats.getNumberOfPurchases())).add("NumberOfSessions", Integer.valueOf(playerStats.getNumberOfSessions())).add("SessionPercentile", Float.valueOf(playerStats.getSessionPercentile())).add("SpendPercentile", Float.valueOf(playerStats.getSpendPercentile())).add("SpendProbability", Float.valueOf(playerStats.getSpendProbability())).add("HighSpenderProbability", Float.valueOf(playerStats.getHighSpenderProbability())).add("TotalSpendNext28Days", Float.valueOf(playerStats.getTotalSpendNext28Days())).toString();
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeFloat(parcel, 1, getAverageSessionLength());
        SafeParcelWriter.writeFloat(parcel, 2, getChurnProbability());
        SafeParcelWriter.writeInt(parcel, 3, getDaysSinceLastPlayed());
        SafeParcelWriter.writeInt(parcel, 4, getNumberOfPurchases());
        SafeParcelWriter.writeInt(parcel, 5, getNumberOfSessions());
        SafeParcelWriter.writeFloat(parcel, 6, getSessionPercentile());
        SafeParcelWriter.writeFloat(parcel, 7, getSpendPercentile());
        SafeParcelWriter.writeBundle(parcel, 8, this.zzsp, false);
        SafeParcelWriter.writeFloat(parcel, 9, getSpendProbability());
        SafeParcelWriter.writeFloat(parcel, 10, getHighSpenderProbability());
        SafeParcelWriter.writeFloat(parcel, 11, getTotalSpendNext28Days());
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

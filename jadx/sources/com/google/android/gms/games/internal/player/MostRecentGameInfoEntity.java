package com.google.android.gms.games.internal.player;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "MostRecentGameInfoEntityCreator")
@SafeParcelable.Reserved({1000})
public final class MostRecentGameInfoEntity extends com.google.android.gms.games.internal.zzd implements zza {
    public static final Parcelable.Creator<MostRecentGameInfoEntity> CREATOR = new zzb();

    @SafeParcelable.Field(getter = "getGameId", m22id = 1)
    private final String zzlw;

    @SafeParcelable.Field(getter = "getGameName", m22id = 2)
    private final String zzlx;

    @SafeParcelable.Field(getter = "getActivityTimestampMillis", m22id = 3)
    private final long zzly;

    @SafeParcelable.Field(getter = "getGameIconImageUri", m22id = 4)
    private final Uri zzlz;

    @SafeParcelable.Field(getter = "getGameHiResImageUri", m22id = 5)
    private final Uri zzma;

    @SafeParcelable.Field(getter = "getGameFeaturedImageUri", m22id = 6)
    private final Uri zzmb;

    public MostRecentGameInfoEntity(zza zzaVar) {
        this.zzlw = zzaVar.zzdb();
        this.zzlx = zzaVar.zzdc();
        this.zzly = zzaVar.zzdd();
        this.zzlz = zzaVar.zzde();
        this.zzma = zzaVar.zzdf();
        this.zzmb = zzaVar.zzdg();
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ zza freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @SafeParcelable.Constructor
    MostRecentGameInfoEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) String str2, @SafeParcelable.Param(m23id = 3) long j, @SafeParcelable.Param(m23id = 4) Uri uri, @SafeParcelable.Param(m23id = 5) Uri uri2, @SafeParcelable.Param(m23id = 6) Uri uri3) {
        this.zzlw = str;
        this.zzlx = str2;
        this.zzly = j;
        this.zzlz = uri;
        this.zzma = uri2;
        this.zzmb = uri3;
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final String zzdb() {
        return this.zzlw;
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final String zzdc() {
        return this.zzlx;
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final long zzdd() {
        return this.zzly;
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final Uri zzde() {
        return this.zzlz;
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final Uri zzdf() {
        return this.zzma;
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final Uri zzdg() {
        return this.zzmb;
    }

    public final int hashCode() {
        return zza(this);
    }

    static int zza(zza zzaVar) {
        return Objects.hashCode(zzaVar.zzdb(), zzaVar.zzdc(), Long.valueOf(zzaVar.zzdd()), zzaVar.zzde(), zzaVar.zzdf(), zzaVar.zzdg());
    }

    public final boolean equals(Object obj) {
        return zza(this, obj);
    }

    static boolean zza(zza zzaVar, Object obj) {
        if (!(obj instanceof zza)) {
            return false;
        }
        if (zzaVar == obj) {
            return true;
        }
        zza zzaVar2 = (zza) obj;
        return Objects.equal(zzaVar2.zzdb(), zzaVar.zzdb()) && Objects.equal(zzaVar2.zzdc(), zzaVar.zzdc()) && Objects.equal(Long.valueOf(zzaVar2.zzdd()), Long.valueOf(zzaVar.zzdd())) && Objects.equal(zzaVar2.zzde(), zzaVar.zzde()) && Objects.equal(zzaVar2.zzdf(), zzaVar.zzdf()) && Objects.equal(zzaVar2.zzdg(), zzaVar.zzdg());
    }

    public final String toString() {
        return zzb(this);
    }

    static String zzb(zza zzaVar) {
        return Objects.toStringHelper(zzaVar).add("GameId", zzaVar.zzdb()).add("GameName", zzaVar.zzdc()).add("ActivityTimestampMillis", Long.valueOf(zzaVar.zzdd())).add("GameIconUri", zzaVar.zzde()).add("GameHiResUri", zzaVar.zzdf()).add("GameFeaturedUri", zzaVar.zzdg()).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzlw, false);
        SafeParcelWriter.writeString(parcel, 2, this.zzlx, false);
        SafeParcelWriter.writeLong(parcel, 3, this.zzly);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzlz, i, false);
        SafeParcelWriter.writeParcelable(parcel, 5, this.zzma, i, false);
        SafeParcelWriter.writeParcelable(parcel, 6, this.zzmb, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

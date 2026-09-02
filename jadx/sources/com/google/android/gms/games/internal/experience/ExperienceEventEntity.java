package com.google.android.gms.games.internal.experience;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.games.Game;
import com.google.android.gms.games.GameEntity;
import com.google.android.gms.games.internal.zzd;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "ExperienceEventEntityCreator")
@SafeParcelable.Reserved({1000})
public final class ExperienceEventEntity extends zzd implements ExperienceEvent {
    public static final Parcelable.Creator<ExperienceEventEntity> CREATOR = new zza();

    @SafeParcelable.Field(getter = "getType", m22id = 10)
    private final int type;

    @SafeParcelable.Field(getter = "getIconImageUrl", m22id = 5)
    private final String zzac;

    @SafeParcelable.Field(getter = "getExperienceId", m22id = 1)
    private final String zzlo;

    @SafeParcelable.Field(getter = "getGame", m22id = 2)
    private final GameEntity zzlp;

    @SafeParcelable.Field(getter = "getDisplayTitle", m22id = 3)
    private final String zzlq;

    @SafeParcelable.Field(getter = "getDisplayDescription", m22id = 4)
    private final String zzlr;

    @SafeParcelable.Field(getter = "getCreatedTimestamp", m22id = 7)
    private final long zzls;

    @SafeParcelable.Field(getter = "getXpEarned", m22id = 8)
    private final long zzlt;

    @SafeParcelable.Field(getter = "getCurrentXp", m22id = 9)
    private final long zzlu;

    @SafeParcelable.Field(getter = "getNewLevel", m22id = 11)
    private final int zzlv;

    @SafeParcelable.Field(getter = "getIconImageUri", m22id = 6)
    private final Uri zzr;

    @SafeParcelable.Constructor
    ExperienceEventEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) GameEntity gameEntity, @SafeParcelable.Param(m23id = 3) String str2, @SafeParcelable.Param(m23id = 4) String str3, @SafeParcelable.Param(m23id = 5) String str4, @SafeParcelable.Param(m23id = 6) Uri uri, @SafeParcelable.Param(m23id = 7) long j, @SafeParcelable.Param(m23id = 8) long j2, @SafeParcelable.Param(m23id = 9) long j3, @SafeParcelable.Param(m23id = 10) int i, @SafeParcelable.Param(m23id = 11) int i2) {
        this.zzlo = str;
        this.zzlp = gameEntity;
        this.zzlq = str2;
        this.zzlr = str3;
        this.zzac = str4;
        this.zzr = uri;
        this.zzls = j;
        this.zzlt = j2;
        this.zzlu = j3;
        this.type = i;
        this.zzlv = i2;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ ExperienceEvent freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @Override // com.google.android.gms.games.internal.experience.ExperienceEvent
    public final String zzcu() {
        return this.zzlo;
    }

    @Override // com.google.android.gms.games.internal.experience.ExperienceEvent
    public final Game getGame() {
        return this.zzlp;
    }

    @Override // com.google.android.gms.games.internal.experience.ExperienceEvent
    public final String zzcv() {
        return this.zzlq;
    }

    @Override // com.google.android.gms.games.internal.experience.ExperienceEvent
    public final String zzcw() {
        return this.zzlr;
    }

    @Override // com.google.android.gms.games.internal.experience.ExperienceEvent
    public final String getIconImageUrl() {
        return this.zzac;
    }

    @Override // com.google.android.gms.games.internal.experience.ExperienceEvent
    public final Uri getIconImageUri() {
        return this.zzr;
    }

    @Override // com.google.android.gms.games.internal.experience.ExperienceEvent
    public final long zzcx() {
        return this.zzls;
    }

    @Override // com.google.android.gms.games.internal.experience.ExperienceEvent
    public final long zzcy() {
        return this.zzlt;
    }

    @Override // com.google.android.gms.games.internal.experience.ExperienceEvent
    public final long zzcz() {
        return this.zzlu;
    }

    @Override // com.google.android.gms.games.internal.experience.ExperienceEvent
    public final int getType() {
        return this.type;
    }

    @Override // com.google.android.gms.games.internal.experience.ExperienceEvent
    public final int zzda() {
        return this.zzlv;
    }

    public final int hashCode() {
        return Objects.hashCode(zzcu(), getGame(), zzcv(), zzcw(), getIconImageUrl(), getIconImageUri(), Long.valueOf(zzcx()), Long.valueOf(zzcy()), Long.valueOf(zzcz()), Integer.valueOf(getType()), Integer.valueOf(zzda()));
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof ExperienceEvent)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        ExperienceEvent experienceEvent = (ExperienceEvent) obj;
        return Objects.equal(experienceEvent.zzcu(), zzcu()) && Objects.equal(experienceEvent.getGame(), getGame()) && Objects.equal(experienceEvent.zzcv(), zzcv()) && Objects.equal(experienceEvent.zzcw(), zzcw()) && Objects.equal(experienceEvent.getIconImageUrl(), getIconImageUrl()) && Objects.equal(experienceEvent.getIconImageUri(), getIconImageUri()) && Objects.equal(Long.valueOf(experienceEvent.zzcx()), Long.valueOf(zzcx())) && Objects.equal(Long.valueOf(experienceEvent.zzcy()), Long.valueOf(zzcy())) && Objects.equal(Long.valueOf(experienceEvent.zzcz()), Long.valueOf(zzcz())) && Objects.equal(Integer.valueOf(experienceEvent.getType()), Integer.valueOf(getType())) && Objects.equal(Integer.valueOf(experienceEvent.zzda()), Integer.valueOf(zzda()));
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("ExperienceId", zzcu()).add("Game", getGame()).add("DisplayTitle", zzcv()).add("DisplayDescription", zzcw()).add("IconImageUrl", getIconImageUrl()).add("IconImageUri", getIconImageUri()).add("CreatedTimestamp", Long.valueOf(zzcx())).add("XpEarned", Long.valueOf(zzcy())).add("CurrentXp", Long.valueOf(zzcz())).add("Type", Integer.valueOf(getType())).add("NewLevel", Integer.valueOf(zzda())).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzlo, false);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzlp, i, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzlq, false);
        SafeParcelWriter.writeString(parcel, 4, this.zzlr, false);
        SafeParcelWriter.writeString(parcel, 5, getIconImageUrl(), false);
        SafeParcelWriter.writeParcelable(parcel, 6, this.zzr, i, false);
        SafeParcelWriter.writeLong(parcel, 7, this.zzls);
        SafeParcelWriter.writeLong(parcel, 8, this.zzlt);
        SafeParcelWriter.writeLong(parcel, 9, this.zzlu);
        SafeParcelWriter.writeInt(parcel, 10, this.type);
        SafeParcelWriter.writeInt(parcel, 11, this.zzlv);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

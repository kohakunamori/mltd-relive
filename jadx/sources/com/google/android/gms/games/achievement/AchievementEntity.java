package com.google.android.gms.games.achievement;

import android.database.CharArrayBuffer;
import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Asserts;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.DataUtils;
import com.google.android.gms.games.Player;
import com.google.android.gms.games.PlayerEntity;
import com.google.android.gms.games.internal.zzd;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "AchievementEntityCreator")
@SafeParcelable.Reserved({1000})
public final class AchievementEntity extends zzd implements Achievement {
    public static final Parcelable.Creator<AchievementEntity> CREATOR = new zza();

    @SafeParcelable.Field(getter = "getDescription", m22id = 4)
    private final String description;

    @SafeParcelable.Field(getter = "getName", m22id = 3)
    private final String name;

    @SafeParcelable.Field(getter = "getState", m22id = 12)
    private final int state;

    @SafeParcelable.Field(getter = "getType", m22id = 2)
    private final int type;

    @SafeParcelable.Field(getter = "getAchievementId", m22id = 1)
    private final String zzfc;

    @SafeParcelable.Field(getter = "getUnlockedImageUri", m22id = 5)
    private final Uri zzfd;

    @SafeParcelable.Field(getter = "getUnlockedImageUrl", m22id = 6)
    private final String zzfe;

    @SafeParcelable.Field(getter = "getRevealedImageUri", m22id = 7)
    private final Uri zzff;

    @SafeParcelable.Field(getter = "getRevealedImageUrl", m22id = 8)
    private final String zzfg;

    @SafeParcelable.Field(getter = "getTotalStepsRaw", m22id = 9)
    private final int zzfh;

    @SafeParcelable.Field(getter = "getFormattedTotalStepsRaw", m22id = 10)
    private final String zzfi;

    @Nullable
    @SafeParcelable.Field(getter = "getPlayerInternal", m22id = 11)
    private final PlayerEntity zzfj;

    @SafeParcelable.Field(getter = "getCurrentStepsRaw", m22id = 13)
    private final int zzfk;

    @SafeParcelable.Field(getter = "getFormattedCurrentStepsRaw", m22id = 14)
    private final String zzfl;

    @SafeParcelable.Field(getter = "getLastUpdatedTimestamp", m22id = 15)
    private final long zzfm;

    @SafeParcelable.Field(getter = "getXpValue", m22id = 16)
    private final long zzfn;

    @SafeParcelable.Field(defaultValue = "-1.0f", getter = "getRarityPercent", m22id = 17)
    private final float zzfo;

    @SafeParcelable.Field(getter = "getApplicationId", m22id = 18)
    private final String zzm;

    public AchievementEntity(Achievement achievement) {
        this.zzfc = achievement.getAchievementId();
        this.type = achievement.getType();
        this.name = achievement.getName();
        this.description = achievement.getDescription();
        this.zzfd = achievement.getUnlockedImageUri();
        this.zzfe = achievement.getUnlockedImageUrl();
        this.zzff = achievement.getRevealedImageUri();
        this.zzfg = achievement.getRevealedImageUrl();
        if (achievement.zzw() != null) {
            this.zzfj = (PlayerEntity) achievement.zzw().freeze();
        } else {
            this.zzfj = null;
        }
        this.state = achievement.getState();
        this.zzfm = achievement.getLastUpdatedTimestamp();
        this.zzfn = achievement.getXpValue();
        this.zzfo = achievement.zzx();
        this.zzm = achievement.getApplicationId();
        if (achievement.getType() == 1) {
            this.zzfh = achievement.getTotalSteps();
            this.zzfi = achievement.getFormattedTotalSteps();
            this.zzfk = achievement.getCurrentSteps();
            this.zzfl = achievement.getFormattedCurrentSteps();
        } else {
            this.zzfh = 0;
            this.zzfi = null;
            this.zzfk = 0;
            this.zzfl = null;
        }
        Asserts.checkNotNull(this.zzfc);
        Asserts.checkNotNull(this.description);
    }

    /* JADX WARN: Can't rename method to resolve collision */
    @Override // com.google.android.gms.common.data.Freezable
    public final Achievement freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @SafeParcelable.Constructor
    AchievementEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) int i, @SafeParcelable.Param(m23id = 3) String str2, @SafeParcelable.Param(m23id = 4) String str3, @SafeParcelable.Param(m23id = 5) Uri uri, @SafeParcelable.Param(m23id = 6) String str4, @SafeParcelable.Param(m23id = 7) Uri uri2, @SafeParcelable.Param(m23id = 8) String str5, @SafeParcelable.Param(m23id = 9) int i2, @SafeParcelable.Param(m23id = 10) String str6, @Nullable @SafeParcelable.Param(m23id = 11) PlayerEntity playerEntity, @SafeParcelable.Param(m23id = 12) int i3, @SafeParcelable.Param(m23id = 13) int i4, @SafeParcelable.Param(m23id = 14) String str7, @SafeParcelable.Param(m23id = 15) long j, @SafeParcelable.Param(m23id = 16) long j2, @SafeParcelable.Param(m23id = 17) float f, @SafeParcelable.Param(m23id = 18) String str8) {
        this.zzfc = str;
        this.type = i;
        this.name = str2;
        this.description = str3;
        this.zzfd = uri;
        this.zzfe = str4;
        this.zzff = uri2;
        this.zzfg = str5;
        this.zzfh = i2;
        this.zzfi = str6;
        this.zzfj = playerEntity;
        this.state = i3;
        this.zzfk = i4;
        this.zzfl = str7;
        this.zzfm = j;
        this.zzfn = j2;
        this.zzfo = f;
        this.zzm = str8;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getAchievementId() {
        return this.zzfc;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getApplicationId() {
        return this.zzm;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final int getType() {
        return this.type;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getName() {
        return this.name;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final void getName(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.name, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getDescription() {
        return this.description;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final void getDescription(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.description, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final Uri getUnlockedImageUri() {
        return this.zzfd;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getUnlockedImageUrl() {
        return this.zzfe;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final Uri getRevealedImageUri() {
        return this.zzff;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getRevealedImageUrl() {
        return this.zzfg;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final int getTotalSteps() {
        Asserts.checkState(getType() == 1);
        return this.zzfh;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getFormattedTotalSteps() {
        Asserts.checkState(getType() == 1);
        return this.zzfi;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final void getFormattedTotalSteps(CharArrayBuffer charArrayBuffer) {
        Asserts.checkState(getType() == 1);
        DataUtils.copyStringToBuffer(this.zzfi, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final Player getPlayer() {
        return (Player) Preconditions.checkNotNull(this.zzfj);
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    @Nullable
    public final Player zzw() {
        return this.zzfj;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final int getState() {
        return this.state;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final int getCurrentSteps() {
        Asserts.checkState(getType() == 1);
        return this.zzfk;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getFormattedCurrentSteps() {
        Asserts.checkState(getType() == 1);
        return this.zzfl;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final void getFormattedCurrentSteps(CharArrayBuffer charArrayBuffer) {
        Asserts.checkState(getType() == 1);
        DataUtils.copyStringToBuffer(this.zzfl, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final long getLastUpdatedTimestamp() {
        return this.zzfm;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final long getXpValue() {
        return this.zzfn;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final float zzx() {
        return this.zzfo;
    }

    public final int hashCode() {
        int currentSteps;
        int totalSteps;
        if (getType() == 1) {
            currentSteps = getCurrentSteps();
            totalSteps = getTotalSteps();
        } else {
            currentSteps = 0;
            totalSteps = 0;
        }
        return Objects.hashCode(getAchievementId(), getApplicationId(), getName(), Integer.valueOf(getType()), getDescription(), Long.valueOf(getXpValue()), Integer.valueOf(getState()), Long.valueOf(getLastUpdatedTimestamp()), zzw(), Integer.valueOf(currentSteps), Integer.valueOf(totalSteps));
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof Achievement)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        Achievement achievement = (Achievement) obj;
        if (achievement.getType() == getType()) {
            return (getType() != 1 || (achievement.getCurrentSteps() == getCurrentSteps() && achievement.getTotalSteps() == getTotalSteps())) && achievement.getXpValue() == getXpValue() && achievement.getState() == getState() && achievement.getLastUpdatedTimestamp() == getLastUpdatedTimestamp() && Objects.equal(achievement.getAchievementId(), getAchievementId()) && Objects.equal(achievement.getApplicationId(), getApplicationId()) && Objects.equal(achievement.getName(), getName()) && Objects.equal(achievement.getDescription(), getDescription()) && Objects.equal(achievement.zzw(), zzw()) && achievement.zzx() == zzx();
        }
        return false;
    }

    public final String toString() {
        return zza(this);
    }

    static String zza(Achievement achievement) {
        Objects.ToStringHelper toStringHelperAdd = Objects.toStringHelper(achievement).add("Id", achievement.getAchievementId()).add("Game Id", achievement.getApplicationId()).add("Type", Integer.valueOf(achievement.getType())).add("Name", achievement.getName()).add("Description", achievement.getDescription()).add("Player", achievement.zzw()).add("State", Integer.valueOf(achievement.getState())).add("Rarity Percent", Float.valueOf(achievement.zzx()));
        if (achievement.getType() == 1) {
            toStringHelperAdd.add("CurrentSteps", Integer.valueOf(achievement.getCurrentSteps()));
            toStringHelperAdd.add("TotalSteps", Integer.valueOf(achievement.getTotalSteps()));
        }
        return toStringHelperAdd.toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getAchievementId(), false);
        SafeParcelWriter.writeInt(parcel, 2, getType());
        SafeParcelWriter.writeString(parcel, 3, getName(), false);
        SafeParcelWriter.writeString(parcel, 4, getDescription(), false);
        SafeParcelWriter.writeParcelable(parcel, 5, getUnlockedImageUri(), i, false);
        SafeParcelWriter.writeString(parcel, 6, getUnlockedImageUrl(), false);
        SafeParcelWriter.writeParcelable(parcel, 7, getRevealedImageUri(), i, false);
        SafeParcelWriter.writeString(parcel, 8, getRevealedImageUrl(), false);
        SafeParcelWriter.writeInt(parcel, 9, this.zzfh);
        SafeParcelWriter.writeString(parcel, 10, this.zzfi, false);
        SafeParcelWriter.writeParcelable(parcel, 11, this.zzfj, i, false);
        SafeParcelWriter.writeInt(parcel, 12, getState());
        SafeParcelWriter.writeInt(parcel, 13, this.zzfk);
        SafeParcelWriter.writeString(parcel, 14, this.zzfl, false);
        SafeParcelWriter.writeLong(parcel, 15, getLastUpdatedTimestamp());
        SafeParcelWriter.writeLong(parcel, 16, getXpValue());
        SafeParcelWriter.writeFloat(parcel, 17, this.zzfo);
        SafeParcelWriter.writeString(parcel, 18, this.zzm, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

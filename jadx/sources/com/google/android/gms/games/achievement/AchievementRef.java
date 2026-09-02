package com.google.android.gms.games.achievement;

import android.database.CharArrayBuffer;
import android.net.Uri;
import android.os.Parcel;
import androidx.annotation.Nullable;
import com.google.android.gms.common.data.DataBufferRef;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.common.internal.Asserts;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.games.Player;
import com.google.android.gms.games.PlayerRef;
import com.google.android.gms.measurement.api.AppMeasurementSdk;

/* JADX INFO: loaded from: classes.dex */
public final class AchievementRef extends DataBufferRef implements Achievement {
    AchievementRef(DataHolder dataHolder, int i) {
        super(dataHolder, i);
    }

    @Override // android.os.Parcelable
    public final int describeContents() {
        return 0;
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getAchievementId() {
        return getString("external_achievement_id");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getApplicationId() {
        return getString("external_game_id");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final int getType() {
        return getInteger("type");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getName() {
        return getString(AppMeasurementSdk.ConditionalUserProperty.NAME);
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final void getName(CharArrayBuffer charArrayBuffer) {
        copyToBuffer(AppMeasurementSdk.ConditionalUserProperty.NAME, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getDescription() {
        return getString("description");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final void getDescription(CharArrayBuffer charArrayBuffer) {
        copyToBuffer("description", charArrayBuffer);
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final Uri getUnlockedImageUri() {
        return parseUri("unlocked_icon_image_uri");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getUnlockedImageUrl() {
        return getString("unlocked_icon_image_url");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final Uri getRevealedImageUri() {
        return parseUri("revealed_icon_image_uri");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getRevealedImageUrl() {
        return getString("revealed_icon_image_url");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final int getTotalSteps() {
        Asserts.checkState(getType() == 1);
        return getInteger("total_steps");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getFormattedTotalSteps() {
        Asserts.checkState(getType() == 1);
        return getString("formatted_total_steps");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final void getFormattedTotalSteps(CharArrayBuffer charArrayBuffer) {
        Asserts.checkState(getType() == 1);
        copyToBuffer("formatted_total_steps", charArrayBuffer);
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final Player getPlayer() {
        return (Player) Preconditions.checkNotNull(zzw());
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    @Nullable
    public final Player zzw() {
        if (hasNull("external_player_id")) {
            return null;
        }
        return new PlayerRef(this.mDataHolder, this.mDataRow);
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final int getState() {
        return getInteger("state");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final int getCurrentSteps() {
        Asserts.checkState(getType() == 1);
        return getInteger("current_steps");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final String getFormattedCurrentSteps() {
        Asserts.checkState(getType() == 1);
        return getString("formatted_current_steps");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final void getFormattedCurrentSteps(CharArrayBuffer charArrayBuffer) {
        Asserts.checkState(getType() == 1);
        copyToBuffer("formatted_current_steps", charArrayBuffer);
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final long getLastUpdatedTimestamp() {
        return getLong("last_updated_timestamp");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final long getXpValue() {
        if (!hasColumn("instance_xp_value") || hasNull("instance_xp_value")) {
            return getLong("definition_xp_value");
        }
        return getLong("instance_xp_value");
    }

    @Override // com.google.android.gms.games.achievement.Achievement
    public final float zzx() {
        if (!hasColumn("rarity_percent") || hasNull("rarity_percent")) {
            return -1.0f;
        }
        return getFloat("rarity_percent");
    }

    public final String toString() {
        return AchievementEntity.zza(this);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        ((AchievementEntity) ((Achievement) freeze())).writeToParcel(parcel, i);
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* synthetic */ Achievement freeze() {
        return new AchievementEntity(this);
    }
}

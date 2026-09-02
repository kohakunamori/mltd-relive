package com.google.android.gms.games.snapshot;

import android.database.CharArrayBuffer;
import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.DataUtils;
import com.google.android.gms.games.Game;
import com.google.android.gms.games.GameEntity;
import com.google.android.gms.games.Player;
import com.google.android.gms.games.PlayerEntity;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "SnapshotMetadataEntityCreator")
@SafeParcelable.Reserved({1000})
public final class SnapshotMetadataEntity extends com.google.android.gms.games.internal.zzd implements SnapshotMetadata {
    public static final Parcelable.Creator<SnapshotMetadataEntity> CREATOR = new zzd();

    @SafeParcelable.Field(getter = "getDescription", m22id = 8)
    private final String description;

    @Nullable
    @SafeParcelable.Field(getter = "getDeviceName", m22id = 15)
    private final String deviceName;

    @SafeParcelable.Field(getter = "getTitle", m22id = 7)
    private final String zzcd;

    @SafeParcelable.Field(getter = "getSnapshotId", m22id = 3)
    private final String zzhs;

    @SafeParcelable.Field(getter = "getGame", m22id = 1)
    private final GameEntity zzlp;

    @Nullable
    @SafeParcelable.Field(getter = "getCoverImageUri", m22id = 5)
    private final Uri zzrw;

    @SafeParcelable.Field(getter = "getOwner", m22id = 2)
    private final PlayerEntity zzrz;

    @Nullable
    @SafeParcelable.Field(getter = "getCoverImageUrl", m22id = 6)
    private final String zzsa;

    @SafeParcelable.Field(getter = "getLastModifiedTimestamp", m22id = 9)
    private final long zzsb;

    @SafeParcelable.Field(getter = "getPlayedTime", m22id = 10)
    private final long zzsc;

    @SafeParcelable.Field(getter = "getCoverImageAspectRatio", m22id = 11)
    private final float zzsd;

    @SafeParcelable.Field(getter = "getUniqueName", m22id = 12)
    private final String zzse;

    @SafeParcelable.Field(getter = "hasChangePending", m22id = 13)
    private final boolean zzsf;

    @SafeParcelable.Field(getter = "getProgressValue", m22id = 14)
    private final long zzsg;

    public SnapshotMetadataEntity(SnapshotMetadata snapshotMetadata) {
        this(snapshotMetadata, new PlayerEntity(snapshotMetadata.getOwner()));
    }

    /* JADX WARN: Can't rename method to resolve collision */
    @Override // com.google.android.gms.common.data.Freezable
    public final SnapshotMetadata freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    private SnapshotMetadataEntity(SnapshotMetadata snapshotMetadata, PlayerEntity playerEntity) {
        this.zzlp = new GameEntity(snapshotMetadata.getGame());
        this.zzrz = playerEntity;
        this.zzhs = snapshotMetadata.getSnapshotId();
        this.zzrw = snapshotMetadata.getCoverImageUri();
        this.zzsa = snapshotMetadata.getCoverImageUrl();
        this.zzsd = snapshotMetadata.getCoverImageAspectRatio();
        this.zzcd = snapshotMetadata.getTitle();
        this.description = snapshotMetadata.getDescription();
        this.zzsb = snapshotMetadata.getLastModifiedTimestamp();
        this.zzsc = snapshotMetadata.getPlayedTime();
        this.zzse = snapshotMetadata.getUniqueName();
        this.zzsf = snapshotMetadata.hasChangePending();
        this.zzsg = snapshotMetadata.getProgressValue();
        this.deviceName = snapshotMetadata.getDeviceName();
    }

    @SafeParcelable.Constructor
    SnapshotMetadataEntity(@SafeParcelable.Param(m23id = 1) GameEntity gameEntity, @SafeParcelable.Param(m23id = 2) PlayerEntity playerEntity, @SafeParcelable.Param(m23id = 3) String str, @Nullable @SafeParcelable.Param(m23id = 5) Uri uri, @Nullable @SafeParcelable.Param(m23id = 6) String str2, @SafeParcelable.Param(m23id = 7) String str3, @SafeParcelable.Param(m23id = 8) String str4, @SafeParcelable.Param(m23id = 9) long j, @SafeParcelable.Param(m23id = 10) long j2, @SafeParcelable.Param(m23id = 11) float f, @SafeParcelable.Param(m23id = 12) String str5, @SafeParcelable.Param(m23id = 13) boolean z, @SafeParcelable.Param(m23id = 14) long j3, @Nullable @SafeParcelable.Param(m23id = 15) String str6) {
        this.zzlp = gameEntity;
        this.zzrz = playerEntity;
        this.zzhs = str;
        this.zzrw = uri;
        this.zzsa = str2;
        this.zzsd = f;
        this.zzcd = str3;
        this.description = str4;
        this.zzsb = j;
        this.zzsc = j2;
        this.zzse = str5;
        this.zzsf = z;
        this.zzsg = j3;
        this.deviceName = str6;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final Game getGame() {
        return this.zzlp;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final Player getOwner() {
        return this.zzrz;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final String getSnapshotId() {
        return this.zzhs;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    @Nullable
    public final Uri getCoverImageUri() {
        return this.zzrw;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    @Nullable
    public final String getCoverImageUrl() {
        return this.zzsa;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final float getCoverImageAspectRatio() {
        return this.zzsd;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final String getUniqueName() {
        return this.zzse;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final String getTitle() {
        return this.zzcd;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final String getDescription() {
        return this.description;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final void getDescription(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.description, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final long getLastModifiedTimestamp() {
        return this.zzsb;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final long getPlayedTime() {
        return this.zzsc;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final boolean hasChangePending() {
        return this.zzsf;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final long getProgressValue() {
        return this.zzsg;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadata
    public final String getDeviceName() {
        return this.deviceName;
    }

    public final int hashCode() {
        return zza(this);
    }

    static int zza(SnapshotMetadata snapshotMetadata) {
        return Objects.hashCode(snapshotMetadata.getGame(), snapshotMetadata.getOwner(), snapshotMetadata.getSnapshotId(), snapshotMetadata.getCoverImageUri(), Float.valueOf(snapshotMetadata.getCoverImageAspectRatio()), snapshotMetadata.getTitle(), snapshotMetadata.getDescription(), Long.valueOf(snapshotMetadata.getLastModifiedTimestamp()), Long.valueOf(snapshotMetadata.getPlayedTime()), snapshotMetadata.getUniqueName(), Boolean.valueOf(snapshotMetadata.hasChangePending()), Long.valueOf(snapshotMetadata.getProgressValue()), snapshotMetadata.getDeviceName());
    }

    public final boolean equals(Object obj) {
        return zza(this, obj);
    }

    static boolean zza(SnapshotMetadata snapshotMetadata, Object obj) {
        if (!(obj instanceof SnapshotMetadata)) {
            return false;
        }
        if (snapshotMetadata == obj) {
            return true;
        }
        SnapshotMetadata snapshotMetadata2 = (SnapshotMetadata) obj;
        return Objects.equal(snapshotMetadata2.getGame(), snapshotMetadata.getGame()) && Objects.equal(snapshotMetadata2.getOwner(), snapshotMetadata.getOwner()) && Objects.equal(snapshotMetadata2.getSnapshotId(), snapshotMetadata.getSnapshotId()) && Objects.equal(snapshotMetadata2.getCoverImageUri(), snapshotMetadata.getCoverImageUri()) && Objects.equal(Float.valueOf(snapshotMetadata2.getCoverImageAspectRatio()), Float.valueOf(snapshotMetadata.getCoverImageAspectRatio())) && Objects.equal(snapshotMetadata2.getTitle(), snapshotMetadata.getTitle()) && Objects.equal(snapshotMetadata2.getDescription(), snapshotMetadata.getDescription()) && Objects.equal(Long.valueOf(snapshotMetadata2.getLastModifiedTimestamp()), Long.valueOf(snapshotMetadata.getLastModifiedTimestamp())) && Objects.equal(Long.valueOf(snapshotMetadata2.getPlayedTime()), Long.valueOf(snapshotMetadata.getPlayedTime())) && Objects.equal(snapshotMetadata2.getUniqueName(), snapshotMetadata.getUniqueName()) && Objects.equal(Boolean.valueOf(snapshotMetadata2.hasChangePending()), Boolean.valueOf(snapshotMetadata.hasChangePending())) && Objects.equal(Long.valueOf(snapshotMetadata2.getProgressValue()), Long.valueOf(snapshotMetadata.getProgressValue())) && Objects.equal(snapshotMetadata2.getDeviceName(), snapshotMetadata.getDeviceName());
    }

    public final String toString() {
        return zzb(this);
    }

    static String zzb(SnapshotMetadata snapshotMetadata) {
        return Objects.toStringHelper(snapshotMetadata).add("Game", snapshotMetadata.getGame()).add("Owner", snapshotMetadata.getOwner()).add("SnapshotId", snapshotMetadata.getSnapshotId()).add("CoverImageUri", snapshotMetadata.getCoverImageUri()).add("CoverImageUrl", snapshotMetadata.getCoverImageUrl()).add("CoverImageAspectRatio", Float.valueOf(snapshotMetadata.getCoverImageAspectRatio())).add("Description", snapshotMetadata.getDescription()).add("LastModifiedTimestamp", Long.valueOf(snapshotMetadata.getLastModifiedTimestamp())).add("PlayedTime", Long.valueOf(snapshotMetadata.getPlayedTime())).add("UniqueName", snapshotMetadata.getUniqueName()).add("ChangePending", Boolean.valueOf(snapshotMetadata.hasChangePending())).add("ProgressValue", Long.valueOf(snapshotMetadata.getProgressValue())).add("DeviceName", snapshotMetadata.getDeviceName()).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, getGame(), i, false);
        SafeParcelWriter.writeParcelable(parcel, 2, getOwner(), i, false);
        SafeParcelWriter.writeString(parcel, 3, getSnapshotId(), false);
        SafeParcelWriter.writeParcelable(parcel, 5, getCoverImageUri(), i, false);
        SafeParcelWriter.writeString(parcel, 6, getCoverImageUrl(), false);
        SafeParcelWriter.writeString(parcel, 7, this.zzcd, false);
        SafeParcelWriter.writeString(parcel, 8, getDescription(), false);
        SafeParcelWriter.writeLong(parcel, 9, getLastModifiedTimestamp());
        SafeParcelWriter.writeLong(parcel, 10, getPlayedTime());
        SafeParcelWriter.writeFloat(parcel, 11, getCoverImageAspectRatio());
        SafeParcelWriter.writeString(parcel, 12, getUniqueName(), false);
        SafeParcelWriter.writeBoolean(parcel, 13, hasChangePending());
        SafeParcelWriter.writeLong(parcel, 14, getProgressValue());
        SafeParcelWriter.writeString(parcel, 15, getDeviceName(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

package com.google.android.gms.games;

import android.database.CharArrayBuffer;
import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Asserts;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.DataUtils;
import com.google.android.gms.common.util.RetainForClient;
import com.google.android.gms.games.internal.GamesDowngradeableSafeParcel;
import com.google.android.gms.games.internal.player.MostRecentGameInfoEntity;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@RetainForClient
@SafeParcelable.Class(creator = "PlayerEntityCreator")
@SafeParcelable.Reserved({1000})
public final class PlayerEntity extends GamesDowngradeableSafeParcel implements Player {
    public static final Parcelable.Creator<PlayerEntity> CREATOR = new zza();

    @SafeParcelable.Field(getter = "getName", m22id = 21)
    private final String name;

    @Nullable
    @SafeParcelable.Field(getter = "getIconImageUrl", m22id = 8)
    private final String zzac;

    @Nullable
    @SafeParcelable.Field(getter = "getHiResImageUrl", m22id = 9)
    private final String zzad;

    @SafeParcelable.Field(getter = "getPlayerId", m22id = 1)
    private String zzbz;

    @SafeParcelable.Field(getter = "getRetrievedTimestamp", m22id = 5)
    private final long zzca;

    @SafeParcelable.Field(getter = "isInCircles", m22id = 6)
    private final int zzcb;

    @SafeParcelable.Field(getter = "getLastPlayedWithTimestamp", m22id = 7)
    private final long zzcc;

    @Nullable
    @SafeParcelable.Field(getter = "getTitle", m22id = 14)
    private final String zzcd;

    @Nullable
    @SafeParcelable.Field(getter = "getMostRecentGameInfo", m22id = 15)
    private final MostRecentGameInfoEntity zzce;

    @Nullable
    @SafeParcelable.Field(getter = "getLevelInfo", m22id = 16)
    private final PlayerLevelInfo zzcf;

    @SafeParcelable.Field(getter = "isProfileVisible", m22id = 18)
    private final boolean zzcg;

    @SafeParcelable.Field(getter = "hasDebugAccess", m22id = 19)
    private final boolean zzch;

    @Nullable
    @SafeParcelable.Field(getter = "getGamerTag", m22id = 20)
    private final String zzci;

    @Nullable
    @SafeParcelable.Field(getter = "getBannerImageLandscapeUri", m22id = 22)
    private final Uri zzcj;

    @Nullable
    @SafeParcelable.Field(getter = "getBannerImageLandscapeUrl", m22id = 23)
    private final String zzck;

    @Nullable
    @SafeParcelable.Field(getter = "getBannerImagePortraitUri", m22id = 24)
    private final Uri zzcl;

    @Nullable
    @SafeParcelable.Field(getter = "getBannerImagePortraitUrl", m22id = 25)
    private final String zzcm;

    @SafeParcelable.Field(getter = "getGamerFriendStatus", m22id = 26)
    private final int zzcn;

    @SafeParcelable.Field(getter = "getGamerFriendUpdateTimestamp", m22id = 27)
    private final long zzco;

    @SafeParcelable.Field(getter = "isMuted", m22id = 28)
    private final boolean zzcp;

    @SafeParcelable.Field(defaultValue = "-1", getter = "getTotalUnlockedAchievement", m22id = 29)
    private final long zzcq;

    @SafeParcelable.Field(getter = "getDisplayName", m22id = 2)
    private String zzn;

    @Nullable
    @SafeParcelable.Field(getter = "getIconImageUri", m22id = 3)
    private final Uri zzr;

    @Nullable
    @SafeParcelable.Field(getter = "getHiResImageUri", m22id = 4)
    private final Uri zzs;

    static final class zza extends zzap {
        zza() {
        }

        @Override // com.google.android.gms.games.zzap
        /* JADX INFO: renamed from: zzc */
        public final PlayerEntity createFromParcel(Parcel parcel) {
            if (PlayerEntity.zzb(PlayerEntity.getUnparcelClientVersion()) || PlayerEntity.canUnparcelSafely(PlayerEntity.class.getCanonicalName())) {
                return super.createFromParcel(parcel);
            }
            String string = parcel.readString();
            String string2 = parcel.readString();
            String string3 = parcel.readString();
            String string4 = parcel.readString();
            return new PlayerEntity(string, string2, string3 == null ? null : Uri.parse(string3), string4 == null ? null : Uri.parse(string4), parcel.readLong(), -1, -1L, null, null, null, null, null, true, false, parcel.readString(), parcel.readString(), null, null, null, null, -1, -1L, false, -1L);
        }

        @Override // com.google.android.gms.games.zzap, android.os.Parcelable.Creator
        public final /* synthetic */ PlayerEntity createFromParcel(Parcel parcel) {
            return createFromParcel(parcel);
        }
    }

    public PlayerEntity(Player player) {
        this(player, true);
    }

    /* JADX WARN: Can't rename method to resolve collision */
    @Override // com.google.android.gms.common.data.Freezable
    public final Player freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    private PlayerEntity(Player player, boolean z) {
        this.zzbz = player.getPlayerId();
        this.zzn = player.getDisplayName();
        this.zzr = player.getIconImageUri();
        this.zzac = player.getIconImageUrl();
        this.zzs = player.getHiResImageUri();
        this.zzad = player.getHiResImageUrl();
        this.zzca = player.getRetrievedTimestamp();
        this.zzcb = player.zzj();
        this.zzcc = player.getLastPlayedWithTimestamp();
        this.zzcd = player.getTitle();
        this.zzcg = player.zzk();
        com.google.android.gms.games.internal.player.zza zzaVarZzl = player.zzl();
        this.zzce = zzaVarZzl == null ? null : new MostRecentGameInfoEntity(zzaVarZzl);
        this.zzcf = player.getLevelInfo();
        this.zzch = player.zzi();
        this.zzci = player.zzh();
        this.name = player.getName();
        this.zzcj = player.getBannerImageLandscapeUri();
        this.zzck = player.getBannerImageLandscapeUrl();
        this.zzcl = player.getBannerImagePortraitUri();
        this.zzcm = player.getBannerImagePortraitUrl();
        this.zzcn = player.zzm();
        this.zzco = player.zzn();
        this.zzcp = player.isMuted();
        this.zzcq = player.zzo();
        Asserts.checkNotNull(this.zzbz);
        Asserts.checkNotNull(this.zzn);
        Asserts.checkState(this.zzca > 0);
    }

    @SafeParcelable.Constructor
    PlayerEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) String str2, @Nullable @SafeParcelable.Param(m23id = 3) Uri uri, @Nullable @SafeParcelable.Param(m23id = 4) Uri uri2, @SafeParcelable.Param(m23id = 5) long j, @SafeParcelable.Param(m23id = 6) int i, @SafeParcelable.Param(m23id = 7) long j2, @Nullable @SafeParcelable.Param(m23id = 8) String str3, @Nullable @SafeParcelable.Param(m23id = 9) String str4, @Nullable @SafeParcelable.Param(m23id = 14) String str5, @Nullable @SafeParcelable.Param(m23id = 15) MostRecentGameInfoEntity mostRecentGameInfoEntity, @Nullable @SafeParcelable.Param(m23id = 16) PlayerLevelInfo playerLevelInfo, @SafeParcelable.Param(m23id = 18) boolean z, @SafeParcelable.Param(m23id = 19) boolean z2, @Nullable @SafeParcelable.Param(m23id = 20) String str6, @SafeParcelable.Param(m23id = 21) String str7, @Nullable @SafeParcelable.Param(m23id = 22) Uri uri3, @Nullable @SafeParcelable.Param(m23id = 23) String str8, @Nullable @SafeParcelable.Param(m23id = 24) Uri uri4, @Nullable @SafeParcelable.Param(m23id = 25) String str9, @SafeParcelable.Param(m23id = 26) int i2, @SafeParcelable.Param(m23id = 27) long j3, @SafeParcelable.Param(m23id = 28) boolean z3, @SafeParcelable.Param(m23id = 29) long j4) {
        this.zzbz = str;
        this.zzn = str2;
        this.zzr = uri;
        this.zzac = str3;
        this.zzs = uri2;
        this.zzad = str4;
        this.zzca = j;
        this.zzcb = i;
        this.zzcc = j2;
        this.zzcd = str5;
        this.zzcg = z;
        this.zzce = mostRecentGameInfoEntity;
        this.zzcf = playerLevelInfo;
        this.zzch = z2;
        this.zzci = str6;
        this.name = str7;
        this.zzcj = uri3;
        this.zzck = str8;
        this.zzcl = uri4;
        this.zzcm = str9;
        this.zzcn = i2;
        this.zzco = j3;
        this.zzcp = z3;
        this.zzcq = j4;
    }

    @Override // com.google.android.gms.games.Player
    public final String getPlayerId() {
        return this.zzbz;
    }

    @Override // com.google.android.gms.games.Player
    public final String getDisplayName() {
        return this.zzn;
    }

    @Override // com.google.android.gms.games.Player
    public final void getDisplayName(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.zzn, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final String zzh() {
        return this.zzci;
    }

    @Override // com.google.android.gms.games.Player
    public final String getName() {
        return this.name;
    }

    @Override // com.google.android.gms.games.Player
    public final boolean zzi() {
        return this.zzch;
    }

    @Override // com.google.android.gms.games.Player
    public final boolean hasIconImage() {
        return getIconImageUri() != null;
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final Uri getIconImageUri() {
        return this.zzr;
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final String getIconImageUrl() {
        return this.zzac;
    }

    @Override // com.google.android.gms.games.Player
    public final boolean hasHiResImage() {
        return getHiResImageUri() != null;
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final Uri getHiResImageUri() {
        return this.zzs;
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final String getHiResImageUrl() {
        return this.zzad;
    }

    @Override // com.google.android.gms.games.Player
    public final long getRetrievedTimestamp() {
        return this.zzca;
    }

    @Override // com.google.android.gms.games.Player
    public final long getLastPlayedWithTimestamp() {
        return this.zzcc;
    }

    @Override // com.google.android.gms.games.Player
    public final int zzj() {
        return this.zzcb;
    }

    @Override // com.google.android.gms.games.Player
    public final boolean zzk() {
        return this.zzcg;
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final String getTitle() {
        return this.zzcd;
    }

    @Override // com.google.android.gms.games.Player
    public final void getTitle(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.zzcd, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final PlayerLevelInfo getLevelInfo() {
        return this.zzcf;
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final com.google.android.gms.games.internal.player.zza zzl() {
        return this.zzce;
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final Uri getBannerImageLandscapeUri() {
        return this.zzcj;
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final String getBannerImageLandscapeUrl() {
        return this.zzck;
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final Uri getBannerImagePortraitUri() {
        return this.zzcl;
    }

    @Override // com.google.android.gms.games.Player
    @Nullable
    public final String getBannerImagePortraitUrl() {
        return this.zzcm;
    }

    @Override // com.google.android.gms.games.Player
    public final int zzm() {
        return this.zzcn;
    }

    @Override // com.google.android.gms.games.Player
    public final long zzn() {
        return this.zzco;
    }

    @Override // com.google.android.gms.games.Player
    public final boolean isMuted() {
        return this.zzcp;
    }

    @Override // com.google.android.gms.games.Player
    public final long zzo() {
        return this.zzcq;
    }

    public final int hashCode() {
        return zza(this);
    }

    static int zza(Player player) {
        return Objects.hashCode(player.getPlayerId(), player.getDisplayName(), Boolean.valueOf(player.zzi()), player.getIconImageUri(), player.getHiResImageUri(), Long.valueOf(player.getRetrievedTimestamp()), player.getTitle(), player.getLevelInfo(), player.zzh(), player.getName(), player.getBannerImageLandscapeUri(), player.getBannerImagePortraitUri(), Integer.valueOf(player.zzm()), Long.valueOf(player.zzn()), Boolean.valueOf(player.isMuted()), Long.valueOf(player.zzo()));
    }

    public final boolean equals(Object obj) {
        return zza(this, obj);
    }

    static boolean zza(Player player, Object obj) {
        if (!(obj instanceof Player)) {
            return false;
        }
        if (player == obj) {
            return true;
        }
        Player player2 = (Player) obj;
        return Objects.equal(player2.getPlayerId(), player.getPlayerId()) && Objects.equal(player2.getDisplayName(), player.getDisplayName()) && Objects.equal(Boolean.valueOf(player2.zzi()), Boolean.valueOf(player.zzi())) && Objects.equal(player2.getIconImageUri(), player.getIconImageUri()) && Objects.equal(player2.getHiResImageUri(), player.getHiResImageUri()) && Objects.equal(Long.valueOf(player2.getRetrievedTimestamp()), Long.valueOf(player.getRetrievedTimestamp())) && Objects.equal(player2.getTitle(), player.getTitle()) && Objects.equal(player2.getLevelInfo(), player.getLevelInfo()) && Objects.equal(player2.zzh(), player.zzh()) && Objects.equal(player2.getName(), player.getName()) && Objects.equal(player2.getBannerImageLandscapeUri(), player.getBannerImageLandscapeUri()) && Objects.equal(player2.getBannerImagePortraitUri(), player.getBannerImagePortraitUri()) && Objects.equal(Integer.valueOf(player2.zzm()), Integer.valueOf(player.zzm())) && Objects.equal(Long.valueOf(player2.zzn()), Long.valueOf(player.zzn())) && Objects.equal(Boolean.valueOf(player2.isMuted()), Boolean.valueOf(player.isMuted())) && Objects.equal(Long.valueOf(player2.zzo()), Long.valueOf(player.zzo()));
    }

    public final String toString() {
        return zzb(this);
    }

    static String zzb(Player player) {
        return Objects.toStringHelper(player).add("PlayerId", player.getPlayerId()).add("DisplayName", player.getDisplayName()).add("HasDebugAccess", Boolean.valueOf(player.zzi())).add("IconImageUri", player.getIconImageUri()).add("IconImageUrl", player.getIconImageUrl()).add("HiResImageUri", player.getHiResImageUri()).add("HiResImageUrl", player.getHiResImageUrl()).add("RetrievedTimestamp", Long.valueOf(player.getRetrievedTimestamp())).add("Title", player.getTitle()).add("LevelInfo", player.getLevelInfo()).add("GamerTag", player.zzh()).add("Name", player.getName()).add("BannerImageLandscapeUri", player.getBannerImageLandscapeUri()).add("BannerImageLandscapeUrl", player.getBannerImageLandscapeUrl()).add("BannerImagePortraitUri", player.getBannerImagePortraitUri()).add("BannerImagePortraitUrl", player.getBannerImagePortraitUrl()).add("GamerFriendStatus", Integer.valueOf(player.zzm())).add("GamerFriendUpdateTimestamp", Long.valueOf(player.zzn())).add("IsMuted", Boolean.valueOf(player.isMuted())).add("totalUnlockedAchievement", Long.valueOf(player.zzo())).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        if (!shouldDowngrade()) {
            int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
            SafeParcelWriter.writeString(parcel, 1, getPlayerId(), false);
            SafeParcelWriter.writeString(parcel, 2, getDisplayName(), false);
            SafeParcelWriter.writeParcelable(parcel, 3, getIconImageUri(), i, false);
            SafeParcelWriter.writeParcelable(parcel, 4, getHiResImageUri(), i, false);
            SafeParcelWriter.writeLong(parcel, 5, getRetrievedTimestamp());
            SafeParcelWriter.writeInt(parcel, 6, this.zzcb);
            SafeParcelWriter.writeLong(parcel, 7, getLastPlayedWithTimestamp());
            SafeParcelWriter.writeString(parcel, 8, getIconImageUrl(), false);
            SafeParcelWriter.writeString(parcel, 9, getHiResImageUrl(), false);
            SafeParcelWriter.writeString(parcel, 14, getTitle(), false);
            SafeParcelWriter.writeParcelable(parcel, 15, this.zzce, i, false);
            SafeParcelWriter.writeParcelable(parcel, 16, getLevelInfo(), i, false);
            SafeParcelWriter.writeBoolean(parcel, 18, this.zzcg);
            SafeParcelWriter.writeBoolean(parcel, 19, this.zzch);
            SafeParcelWriter.writeString(parcel, 20, this.zzci, false);
            SafeParcelWriter.writeString(parcel, 21, this.name, false);
            SafeParcelWriter.writeParcelable(parcel, 22, getBannerImageLandscapeUri(), i, false);
            SafeParcelWriter.writeString(parcel, 23, getBannerImageLandscapeUrl(), false);
            SafeParcelWriter.writeParcelable(parcel, 24, getBannerImagePortraitUri(), i, false);
            SafeParcelWriter.writeString(parcel, 25, getBannerImagePortraitUrl(), false);
            SafeParcelWriter.writeInt(parcel, 26, this.zzcn);
            SafeParcelWriter.writeLong(parcel, 27, this.zzco);
            SafeParcelWriter.writeBoolean(parcel, 28, this.zzcp);
            SafeParcelWriter.writeLong(parcel, 29, this.zzcq);
            SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
            return;
        }
        parcel.writeString(this.zzbz);
        parcel.writeString(this.zzn);
        parcel.writeString(this.zzr == null ? null : this.zzr.toString());
        parcel.writeString(this.zzs != null ? this.zzs.toString() : null);
        parcel.writeLong(this.zzca);
    }
}

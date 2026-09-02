package com.google.android.gms.games;

import android.database.CharArrayBuffer;
import android.net.Uri;
import android.os.Parcel;
import com.google.android.gms.common.data.DataBufferRef;
import com.google.android.gms.common.data.DataHolder;

/* JADX INFO: loaded from: classes.dex */
public final class PlayerRef extends DataBufferRef implements Player {
    private final PlayerLevelInfo zzcf;
    private final com.google.android.gms.games.internal.player.zzd zzcy;
    private final com.google.android.gms.games.internal.player.zzc zzcz;

    public PlayerRef(DataHolder dataHolder, int i) {
        this(dataHolder, i, null);
    }

    @Override // android.os.Parcelable
    public final int describeContents() {
        return 0;
    }

    public PlayerRef(DataHolder dataHolder, int i, String str) {
        super(dataHolder, i);
        this.zzcy = new com.google.android.gms.games.internal.player.zzd(str);
        this.zzcz = new com.google.android.gms.games.internal.player.zzc(dataHolder, i, this.zzcy);
        if ((hasNull(this.zzcy.zzml) || getLong(this.zzcy.zzml) == -1) ? false : true) {
            int integer = getInteger(this.zzcy.zzmm);
            int integer2 = getInteger(this.zzcy.zzmp);
            PlayerLevel playerLevel = new PlayerLevel(integer, getLong(this.zzcy.zzmn), getLong(this.zzcy.zzmo));
            this.zzcf = new PlayerLevelInfo(getLong(this.zzcy.zzml), getLong(this.zzcy.zzmr), playerLevel, integer != integer2 ? new PlayerLevel(integer2, getLong(this.zzcy.zzmo), getLong(this.zzcy.zzmq)) : playerLevel);
            return;
        }
        this.zzcf = null;
    }

    @Override // com.google.android.gms.games.Player
    public final String getPlayerId() {
        return getString(this.zzcy.zzmc);
    }

    @Override // com.google.android.gms.games.Player
    public final String getDisplayName() {
        return getString(this.zzcy.zzmd);
    }

    @Override // com.google.android.gms.games.Player
    public final void getDisplayName(CharArrayBuffer charArrayBuffer) {
        copyToBuffer(this.zzcy.zzmd, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.Player
    public final String zzh() {
        return getString(this.zzcy.zzci);
    }

    @Override // com.google.android.gms.games.Player
    public final String getName() {
        return getString(this.zzcy.name);
    }

    @Override // com.google.android.gms.games.Player
    public final boolean zzi() {
        return getBoolean(this.zzcy.zzna);
    }

    @Override // com.google.android.gms.games.Player
    public final boolean hasIconImage() {
        return getIconImageUri() != null;
    }

    @Override // com.google.android.gms.games.Player
    public final Uri getIconImageUri() {
        return parseUri(this.zzcy.zzme);
    }

    @Override // com.google.android.gms.games.Player
    public final String getIconImageUrl() {
        return getString(this.zzcy.zzmf);
    }

    @Override // com.google.android.gms.games.Player
    public final boolean hasHiResImage() {
        return getHiResImageUri() != null;
    }

    @Override // com.google.android.gms.games.Player
    public final Uri getHiResImageUri() {
        return parseUri(this.zzcy.zzmg);
    }

    @Override // com.google.android.gms.games.Player
    public final String getHiResImageUrl() {
        return getString(this.zzcy.zzmh);
    }

    @Override // com.google.android.gms.games.Player
    public final long getRetrievedTimestamp() {
        return getLong(this.zzcy.zzmi);
    }

    @Override // com.google.android.gms.games.Player
    public final long getLastPlayedWithTimestamp() {
        if (!hasColumn(this.zzcy.zzmk) || hasNull(this.zzcy.zzmk)) {
            return -1L;
        }
        return getLong(this.zzcy.zzmk);
    }

    @Override // com.google.android.gms.games.Player
    public final int zzj() {
        return getInteger(this.zzcy.zzmj);
    }

    @Override // com.google.android.gms.games.Player
    public final boolean zzk() {
        return getBoolean(this.zzcy.zzmt);
    }

    @Override // com.google.android.gms.games.Player
    public final String getTitle() {
        return getString(this.zzcy.zzcd);
    }

    @Override // com.google.android.gms.games.Player
    public final void getTitle(CharArrayBuffer charArrayBuffer) {
        copyToBuffer(this.zzcy.zzcd, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.Player
    public final PlayerLevelInfo getLevelInfo() {
        return this.zzcf;
    }

    @Override // com.google.android.gms.games.Player
    public final com.google.android.gms.games.internal.player.zza zzl() {
        if (hasNull(this.zzcy.zzmu)) {
            return null;
        }
        return this.zzcz;
    }

    @Override // com.google.android.gms.games.Player
    public final Uri getBannerImageLandscapeUri() {
        return parseUri(this.zzcy.zznb);
    }

    @Override // com.google.android.gms.games.Player
    public final String getBannerImageLandscapeUrl() {
        return getString(this.zzcy.zznc);
    }

    @Override // com.google.android.gms.games.Player
    public final Uri getBannerImagePortraitUri() {
        return parseUri(this.zzcy.zznd);
    }

    @Override // com.google.android.gms.games.Player
    public final String getBannerImagePortraitUrl() {
        return getString(this.zzcy.zzne);
    }

    @Override // com.google.android.gms.games.Player
    public final int zzm() {
        return getInteger(this.zzcy.zznf);
    }

    @Override // com.google.android.gms.games.Player
    public final long zzn() {
        return getLong(this.zzcy.zzng);
    }

    @Override // com.google.android.gms.games.Player
    public final boolean isMuted() {
        return getBoolean(this.zzcy.zznh);
    }

    @Override // com.google.android.gms.games.Player
    public final long zzo() {
        return getLong(this.zzcy.zzni);
    }

    @Override // com.google.android.gms.common.data.DataBufferRef
    public final int hashCode() {
        return PlayerEntity.zza(this);
    }

    @Override // com.google.android.gms.common.data.DataBufferRef
    public final boolean equals(Object obj) {
        return PlayerEntity.zza(this, obj);
    }

    public final String toString() {
        return PlayerEntity.zzb(this);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        ((PlayerEntity) ((Player) freeze())).writeToParcel(parcel, i);
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* synthetic */ Player freeze() {
        return new PlayerEntity(this);
    }
}

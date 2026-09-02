package com.google.android.gms.games.internal.game;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.games.internal.GamesDowngradeableSafeParcel;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "GameBadgeEntityCreator")
@SafeParcelable.Reserved({1000})
public final class GameBadgeEntity extends GamesDowngradeableSafeParcel implements com.google.android.gms.games.internal.game.zza {
    public static final Parcelable.Creator<GameBadgeEntity> CREATOR = new zza();

    @SafeParcelable.Field(getter = "getDescription", m22id = 3)
    private String description;

    @SafeParcelable.Field(getter = "getType", m22id = 1)
    private int type;

    @SafeParcelable.Field(getter = "getTitle", m22id = 2)
    private String zzcd;

    @SafeParcelable.Field(getter = "getIconImageUri", m22id = 4)
    private Uri zzr;

    static final class zza extends zzb {
        zza() {
        }

        @Override // com.google.android.gms.games.internal.game.zzb
        /* JADX INFO: renamed from: zzd */
        public final GameBadgeEntity createFromParcel(Parcel parcel) {
            if (GameBadgeEntity.zzb(GameBadgeEntity.getUnparcelClientVersion()) || GameBadgeEntity.canUnparcelSafely(GameBadgeEntity.class.getCanonicalName())) {
                return super.createFromParcel(parcel);
            }
            int i = parcel.readInt();
            String string = parcel.readString();
            String string2 = parcel.readString();
            String string3 = parcel.readString();
            return new GameBadgeEntity(i, string, string2, string3 == null ? null : Uri.parse(string3));
        }

        @Override // com.google.android.gms.games.internal.game.zzb, android.os.Parcelable.Creator
        public final /* synthetic */ GameBadgeEntity createFromParcel(Parcel parcel) {
            return createFromParcel(parcel);
        }
    }

    @SafeParcelable.Constructor
    GameBadgeEntity(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) String str, @SafeParcelable.Param(m23id = 3) String str2, @SafeParcelable.Param(m23id = 4) Uri uri) {
        this.type = i;
        this.zzcd = str;
        this.description = str2;
        this.zzr = uri;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ com.google.android.gms.games.internal.game.zza freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @Override // com.google.android.gms.games.internal.game.zza
    public final int getType() {
        return this.type;
    }

    @Override // com.google.android.gms.games.internal.game.zza
    public final String getTitle() {
        return this.zzcd;
    }

    @Override // com.google.android.gms.games.internal.game.zza
    public final String getDescription() {
        return this.description;
    }

    @Override // com.google.android.gms.games.internal.game.zza
    public final Uri getIconImageUri() {
        return this.zzr;
    }

    public final int hashCode() {
        return Objects.hashCode(Integer.valueOf(getType()), getTitle(), getDescription(), getIconImageUri());
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof com.google.android.gms.games.internal.game.zza)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        com.google.android.gms.games.internal.game.zza zzaVar = (com.google.android.gms.games.internal.game.zza) obj;
        return Objects.equal(Integer.valueOf(zzaVar.getType()), getTitle()) && Objects.equal(zzaVar.getDescription(), getIconImageUri());
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("Type", Integer.valueOf(getType())).add("Title", getTitle()).add("Description", getDescription()).add("IconImageUri", getIconImageUri()).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        if (!shouldDowngrade()) {
            int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
            SafeParcelWriter.writeInt(parcel, 1, this.type);
            SafeParcelWriter.writeString(parcel, 2, this.zzcd, false);
            SafeParcelWriter.writeString(parcel, 3, this.description, false);
            SafeParcelWriter.writeParcelable(parcel, 4, this.zzr, i, false);
            SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
            return;
        }
        parcel.writeInt(this.type);
        parcel.writeString(this.zzcd);
        parcel.writeString(this.description);
        parcel.writeString(this.zzr == null ? null : this.zzr.toString());
    }
}

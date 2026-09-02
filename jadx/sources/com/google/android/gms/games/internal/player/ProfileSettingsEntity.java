package com.google.android.gms.games.internal.player;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.games.Players;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "ProfileSettingsEntityCreator")
@SafeParcelable.Reserved({1000})
public class ProfileSettingsEntity extends com.google.android.gms.games.internal.zzd implements Players.zza {
    public static final Parcelable.Creator<ProfileSettingsEntity> CREATOR = new zze();

    @SafeParcelable.Field(getter = "isProfileVisible", m22id = 4)
    private final boolean zzcg;

    @SafeParcelable.Field(getter = "getGamerTag", m22id = 2)
    private final String zzci;

    @SafeParcelable.Field(getter = "getStatus", m22id = 1)
    private final Status zzhl;

    @SafeParcelable.Field(getter = "isGamerTagExplicitlySet", m22id = 3)
    private final boolean zznj;

    @SafeParcelable.Field(getter = "isVisibilityExplicitlySet", m22id = 5)
    private final boolean zznk;

    @SafeParcelable.Field(getter = "getStockProfileImage", m22id = 6)
    private final StockProfileImageEntity zznl;

    @SafeParcelable.Field(getter = "isProfileDiscoverable", m22id = 7)
    private final boolean zznm;

    @SafeParcelable.Field(getter = "isAutoSignInEnabled", m22id = 8)
    private final boolean zznn;

    @SafeParcelable.Field(getter = "getHttpErrorCode", m22id = 9)
    private final int zzno;

    @SafeParcelable.Field(getter = "isSettingsChangesProhibited", m22id = 10)
    private final boolean zznp;

    @SafeParcelable.Constructor
    ProfileSettingsEntity(@SafeParcelable.Param(m23id = 1) Status status, @SafeParcelable.Param(m23id = 2) String str, @SafeParcelable.Param(m23id = 3) boolean z, @SafeParcelable.Param(m23id = 4) boolean z2, @SafeParcelable.Param(m23id = 5) boolean z3, @SafeParcelable.Param(m23id = 6) StockProfileImageEntity stockProfileImageEntity, @SafeParcelable.Param(m23id = 7) boolean z4, @SafeParcelable.Param(m23id = 8) boolean z5, @SafeParcelable.Param(m23id = 9) int i, @SafeParcelable.Param(m23id = 10) boolean z6) {
        this.zzhl = status;
        this.zzci = str;
        this.zznj = z;
        this.zzcg = z2;
        this.zznk = z3;
        this.zznl = stockProfileImageEntity;
        this.zznm = z4;
        this.zznn = z5;
        this.zzno = i;
        this.zznp = z6;
    }

    @Override // com.google.android.gms.games.Players.zza
    public final String zzh() {
        return this.zzci;
    }

    @Override // com.google.android.gms.games.Players.zza
    public final boolean zzr() {
        return this.zznj;
    }

    @Override // com.google.android.gms.games.Players.zza
    public final boolean zzk() {
        return this.zzcg;
    }

    @Override // com.google.android.gms.games.Players.zza
    public final boolean zzp() {
        return this.zznk;
    }

    @Override // com.google.android.gms.games.Players.zza
    public final StockProfileImage zzq() {
        return this.zznl;
    }

    @Override // com.google.android.gms.games.Players.zza
    public final boolean zzs() {
        return this.zznm;
    }

    @Override // com.google.android.gms.games.Players.zza
    public final boolean zzt() {
        return this.zznn;
    }

    @Override // com.google.android.gms.games.Players.zza
    public final boolean zzu() {
        return this.zznp;
    }

    @Override // com.google.android.gms.common.api.Result
    public Status getStatus() {
        return this.zzhl;
    }

    @Override // com.google.android.gms.games.Players.zza
    public final int zzv() {
        return this.zzno;
    }

    public int hashCode() {
        return Objects.hashCode(this.zzci, Boolean.valueOf(this.zznj), Boolean.valueOf(this.zzcg), Boolean.valueOf(this.zznk), this.zzhl, this.zznl, Boolean.valueOf(this.zznm), Boolean.valueOf(this.zznn), Integer.valueOf(this.zzno), Boolean.valueOf(this.zznp));
    }

    public boolean equals(Object obj) {
        if (!(obj instanceof Players.zza)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        Players.zza zzaVar = (Players.zza) obj;
        return Objects.equal(this.zzci, zzaVar.zzh()) && Objects.equal(Boolean.valueOf(this.zznj), Boolean.valueOf(zzaVar.zzr())) && Objects.equal(Boolean.valueOf(this.zzcg), Boolean.valueOf(zzaVar.zzk())) && Objects.equal(Boolean.valueOf(this.zznk), Boolean.valueOf(zzaVar.zzp())) && Objects.equal(this.zzhl, zzaVar.getStatus()) && Objects.equal(this.zznl, zzaVar.zzq()) && Objects.equal(Boolean.valueOf(this.zznm), Boolean.valueOf(zzaVar.zzs())) && Objects.equal(Boolean.valueOf(this.zznn), Boolean.valueOf(zzaVar.zzt())) && this.zzno == zzaVar.zzv() && this.zznp == zzaVar.zzu();
    }

    public String toString() {
        return Objects.toStringHelper(this).add("GamerTag", this.zzci).add("IsGamerTagExplicitlySet", Boolean.valueOf(this.zznj)).add("IsProfileVisible", Boolean.valueOf(this.zzcg)).add("IsVisibilityExplicitlySet", Boolean.valueOf(this.zznk)).add("Status", this.zzhl).add("StockProfileImage", this.zznl).add("IsProfileDiscoverable", Boolean.valueOf(this.zznm)).add("AutoSignIn", Boolean.valueOf(this.zznn)).add("httpErrorCode", Integer.valueOf(this.zzno)).add("IsSettingsChangesProhibited", Boolean.valueOf(this.zznp)).toString();
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, getStatus(), i, false);
        SafeParcelWriter.writeString(parcel, 2, this.zzci, false);
        SafeParcelWriter.writeBoolean(parcel, 3, this.zznj);
        SafeParcelWriter.writeBoolean(parcel, 4, this.zzcg);
        SafeParcelWriter.writeBoolean(parcel, 5, this.zznk);
        SafeParcelWriter.writeParcelable(parcel, 6, this.zznl, i, false);
        SafeParcelWriter.writeBoolean(parcel, 7, this.zznm);
        SafeParcelWriter.writeBoolean(parcel, 8, this.zznn);
        SafeParcelWriter.writeInt(parcel, 9, this.zzno);
        SafeParcelWriter.writeBoolean(parcel, 10, this.zznp);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

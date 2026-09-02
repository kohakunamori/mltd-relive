package com.google.android.gms.games.internal.player;

import android.net.Uri;
import android.os.Parcel;
import com.google.android.gms.common.data.DataBufferRef;
import com.google.android.gms.common.data.DataHolder;

/* JADX INFO: loaded from: classes.dex */
public final class zzc extends DataBufferRef implements zza {
    private final zzd zzcy;

    public zzc(DataHolder dataHolder, int i, zzd zzdVar) {
        super(dataHolder, i);
        this.zzcy = zzdVar;
    }

    @Override // android.os.Parcelable
    public final int describeContents() {
        return 0;
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final String zzdb() {
        return getString(this.zzcy.zzmu);
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final String zzdc() {
        return getString(this.zzcy.zzmv);
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final long zzdd() {
        return getLong(this.zzcy.zzmw);
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final Uri zzde() {
        return parseUri(this.zzcy.zzmx);
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final Uri zzdf() {
        return parseUri(this.zzcy.zzmy);
    }

    @Override // com.google.android.gms.games.internal.player.zza
    public final Uri zzdg() {
        return parseUri(this.zzcy.zzmz);
    }

    @Override // com.google.android.gms.common.data.DataBufferRef
    public final int hashCode() {
        return MostRecentGameInfoEntity.zza(this);
    }

    @Override // com.google.android.gms.common.data.DataBufferRef
    public final boolean equals(Object obj) {
        return MostRecentGameInfoEntity.zza(this, obj);
    }

    public final String toString() {
        return MostRecentGameInfoEntity.zzb(this);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        ((MostRecentGameInfoEntity) ((zza) freeze())).writeToParcel(parcel, i);
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* synthetic */ zza freeze() {
        return new MostRecentGameInfoEntity(this);
    }
}

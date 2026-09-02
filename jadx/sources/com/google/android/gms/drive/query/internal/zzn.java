package com.google.android.gms.drive.query.internal;

import android.os.Parcel;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.drive.metadata.MetadataField;
import com.google.android.gms.drive.metadata.SearchableMetadataField;
import com.google.android.gms.drive.metadata.internal.MetadataBundle;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "HasFilterCreator")
@SafeParcelable.Reserved({1000})
public final class zzn<T> extends zza {
    public static final zzo CREATOR = new zzo();

    @SafeParcelable.Field(m22id = 1)
    private final MetadataBundle zzlk;
    private final MetadataField<T> zzll;

    public zzn(SearchableMetadataField<T> searchableMetadataField, T t) {
        this(MetadataBundle.zza(searchableMetadataField, t));
    }

    @SafeParcelable.Constructor
    zzn(@SafeParcelable.Param(m23id = 1) MetadataBundle metadataBundle) {
        this.zzlk = metadataBundle;
        this.zzll = (MetadataField<T>) zzi.zza(metadataBundle);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, this.zzlk, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    @Override // com.google.android.gms.drive.query.Filter
    public final <F> F zza(zzj<F> zzjVar) {
        return zzjVar.zzc(this.zzll, this.zzlk.zza(this.zzll));
    }
}

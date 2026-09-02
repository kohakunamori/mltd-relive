package com.google.android.gms.drive.query.internal;

import android.os.Parcel;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.drive.metadata.SearchableCollectionMetadataField;
import com.google.android.gms.drive.metadata.internal.MetadataBundle;
import java.util.Collection;
import java.util.Collections;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "InFilterCreator")
@SafeParcelable.Reserved({1000})
public final class zzp<T> extends zza {
    public static final zzq CREATOR = new zzq();

    @SafeParcelable.Field(m22id = 1)
    private final MetadataBundle zzlk;
    private final com.google.android.gms.drive.metadata.zzb<T> zzlx;

    public zzp(SearchableCollectionMetadataField<T> searchableCollectionMetadataField, T t) {
        this(MetadataBundle.zza(searchableCollectionMetadataField, Collections.singleton(t)));
    }

    @SafeParcelable.Constructor
    zzp(@SafeParcelable.Param(m23id = 1) MetadataBundle metadataBundle) {
        this.zzlk = metadataBundle;
        this.zzlx = (com.google.android.gms.drive.metadata.zzb) zzi.zza(metadataBundle);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, this.zzlk, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    @Override // com.google.android.gms.drive.query.Filter
    public final <F> F zza(zzj<F> zzjVar) {
        return zzjVar.zza(this.zzlx, ((Collection) this.zzlk.zza(this.zzlx)).iterator().next());
    }
}

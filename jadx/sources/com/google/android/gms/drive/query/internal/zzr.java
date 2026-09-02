package com.google.android.gms.drive.query.internal;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.drive.query.Filter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "LogicalFilterCreator")
@SafeParcelable.Reserved({1000})
public final class zzr extends zza {
    public static final Parcelable.Creator<zzr> CREATOR = new zzs();
    private List<Filter> zzlc;

    @SafeParcelable.Field(m22id = 1)
    private final zzx zzlj;

    @SafeParcelable.Field(m22id = 2)
    private final List<FilterHolder> zzly;

    public zzr(zzx zzxVar, Filter filter, Filter... filterArr) {
        this.zzlj = zzxVar;
        this.zzly = new ArrayList(filterArr.length + 1);
        this.zzly.add(new FilterHolder(filter));
        this.zzlc = new ArrayList(filterArr.length + 1);
        this.zzlc.add(filter);
        for (Filter filter2 : filterArr) {
            this.zzly.add(new FilterHolder(filter2));
            this.zzlc.add(filter2);
        }
    }

    public zzr(zzx zzxVar, Iterable<Filter> iterable) {
        this.zzlj = zzxVar;
        this.zzlc = new ArrayList();
        this.zzly = new ArrayList();
        for (Filter filter : iterable) {
            this.zzlc.add(filter);
            this.zzly.add(new FilterHolder(filter));
        }
    }

    @SafeParcelable.Constructor
    zzr(@SafeParcelable.Param(m23id = 1) zzx zzxVar, @SafeParcelable.Param(m23id = 2) List<FilterHolder> list) {
        this.zzlj = zzxVar;
        this.zzly = list;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, this.zzlj, i, false);
        SafeParcelWriter.writeTypedList(parcel, 2, this.zzly, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    @Override // com.google.android.gms.drive.query.Filter
    public final <T> T zza(zzj<T> zzjVar) {
        ArrayList arrayList = new ArrayList();
        Iterator<FilterHolder> it = this.zzly.iterator();
        while (it.hasNext()) {
            arrayList.add(it.next().getFilter().zza(zzjVar));
        }
        return zzjVar.zza(this.zzlj, arrayList);
    }
}

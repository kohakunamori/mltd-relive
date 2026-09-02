package com.google.android.gms.internal.measurement;

import java.util.Iterator;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class zzhd extends zzhj {
    private final /* synthetic */ zzhc zzalq;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    private zzhd(zzhc zzhcVar) {
        super(zzhcVar, null);
        this.zzalq = zzhcVar;
    }

    @Override // com.google.android.gms.internal.measurement.zzhj, java.util.AbstractCollection, java.util.Collection, java.lang.Iterable, java.util.Set
    public final Iterator<Map.Entry<K, V>> iterator() {
        return new zzhe(this.zzalq, null);
    }

    /* synthetic */ zzhd(zzhc zzhcVar, zzhb zzhbVar) {
        this(zzhcVar);
    }
}

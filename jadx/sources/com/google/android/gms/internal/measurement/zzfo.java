package com.google.android.gms.internal.measurement;

import java.util.Iterator;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class zzfo<K> implements Iterator<Map.Entry<K, Object>> {
    private Iterator<Map.Entry<K, Object>> zzajp;

    public zzfo(Iterator<Map.Entry<K, Object>> it) {
        this.zzajp = it;
    }

    @Override // java.util.Iterator
    public final boolean hasNext() {
        return this.zzajp.hasNext();
    }

    @Override // java.util.Iterator
    public final void remove() {
        this.zzajp.remove();
    }

    @Override // java.util.Iterator
    public final /* synthetic */ Object next() {
        Map.Entry<K, Object> next = this.zzajp.next();
        return next.getValue() instanceof zzfj ? new zzfl(next) : next;
    }
}

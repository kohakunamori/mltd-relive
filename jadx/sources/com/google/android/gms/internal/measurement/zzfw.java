package com.google.android.gms.internal.measurement;

import java.util.Arrays;
import java.util.Collection;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes.dex */
final class zzfw extends zzdj<Long> implements zzfg, zzgu, RandomAccess {
    private static final zzfw zzajy;
    private int size;
    private long[] zzajz;

    public static zzfw zzvk() {
        return zzajy;
    }

    zzfw() {
        this(new long[10], 0);
    }

    private zzfw(long[] jArr, int i) {
        this.zzajz = jArr;
        this.size = i;
    }

    @Override // java.util.AbstractList
    protected final void removeRange(int i, int i2) {
        zzrz();
        if (i2 < i) {
            throw new IndexOutOfBoundsException("toIndex < fromIndex");
        }
        System.arraycopy(this.zzajz, i2, this.zzajz, i, this.size - i2);
        this.size -= i2 - i;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.Collection, java.util.List
    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzfw)) {
            return super.equals(obj);
        }
        zzfw zzfwVar = (zzfw) obj;
        if (this.size != zzfwVar.size) {
            return false;
        }
        long[] jArr = zzfwVar.zzajz;
        for (int i = 0; i < this.size; i++) {
            if (this.zzajz[i] != jArr[i]) {
                return false;
            }
        }
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.Collection, java.util.List
    public final int hashCode() {
        int iZzbx = 1;
        for (int i = 0; i < this.size; i++) {
            iZzbx = (iZzbx * 31) + zzez.zzbx(this.zzajz[i]);
        }
        return iZzbx;
    }

    @Override // com.google.android.gms.internal.measurement.zzff
    /* JADX INFO: renamed from: zzbv, reason: merged with bridge method [inline-methods] */
    public final zzfg zzap(int i) {
        if (i < this.size) {
            throw new IllegalArgumentException();
        }
        return new zzfw(Arrays.copyOf(this.zzajz, i), this.size);
    }

    @Override // com.google.android.gms.internal.measurement.zzfg
    public final long getLong(int i) {
        zzan(i);
        return this.zzajz[i];
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.size;
    }

    @Override // com.google.android.gms.internal.measurement.zzfg
    public final void zzby(long j) {
        zzk(this.size, j);
    }

    private final void zzk(int i, long j) {
        zzrz();
        if (i < 0 || i > this.size) {
            throw new IndexOutOfBoundsException(zzao(i));
        }
        if (this.size < this.zzajz.length) {
            System.arraycopy(this.zzajz, i, this.zzajz, i + 1, this.size - i);
        } else {
            long[] jArr = new long[((this.size * 3) / 2) + 1];
            System.arraycopy(this.zzajz, 0, jArr, 0, i);
            System.arraycopy(this.zzajz, i, jArr, i + 1, this.size - i);
            this.zzajz = jArr;
        }
        this.zzajz[i] = j;
        this.size++;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean addAll(Collection<? extends Long> collection) {
        zzrz();
        zzez.checkNotNull(collection);
        if (!(collection instanceof zzfw)) {
            return super.addAll(collection);
        }
        zzfw zzfwVar = (zzfw) collection;
        if (zzfwVar.size == 0) {
            return false;
        }
        if (Integer.MAX_VALUE - this.size < zzfwVar.size) {
            throw new OutOfMemoryError();
        }
        int i = this.size + zzfwVar.size;
        if (i > this.zzajz.length) {
            this.zzajz = Arrays.copyOf(this.zzajz, i);
        }
        System.arraycopy(zzfwVar.zzajz, 0, this.zzajz, this.size, zzfwVar.size);
        this.size = i;
        this.modCount++;
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean remove(Object obj) {
        zzrz();
        for (int i = 0; i < this.size; i++) {
            if (obj.equals(Long.valueOf(this.zzajz[i]))) {
                System.arraycopy(this.zzajz, i + 1, this.zzajz, i, (this.size - i) - 1);
                this.size--;
                this.modCount++;
                return true;
            }
        }
        return false;
    }

    private final void zzan(int i) {
        if (i < 0 || i >= this.size) {
            throw new IndexOutOfBoundsException(zzao(i));
        }
    }

    private final String zzao(int i) {
        int i2 = this.size;
        StringBuilder sb = new StringBuilder(35);
        sb.append("Index:");
        sb.append(i);
        sb.append(", Size:");
        sb.append(i2);
        return sb.toString();
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object set(int i, Object obj) {
        long jLongValue = ((Long) obj).longValue();
        zzrz();
        zzan(i);
        long j = this.zzajz[i];
        this.zzajz[i] = jLongValue;
        return Long.valueOf(j);
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object remove(int i) {
        zzrz();
        zzan(i);
        long j = this.zzajz[i];
        if (i < this.size - 1) {
            System.arraycopy(this.zzajz, i + 1, this.zzajz, i, (this.size - i) - 1);
        }
        this.size--;
        this.modCount++;
        return Long.valueOf(j);
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.List
    public final /* synthetic */ void add(int i, Object obj) {
        zzk(i, ((Long) obj).longValue());
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        return Long.valueOf(getLong(i));
    }

    static {
        zzfw zzfwVar = new zzfw(new long[0], 0);
        zzajy = zzfwVar;
        zzfwVar.zzry();
    }
}

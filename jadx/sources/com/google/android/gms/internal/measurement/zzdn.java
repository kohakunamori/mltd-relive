package com.google.android.gms.internal.measurement;

import java.util.Arrays;
import java.util.Collection;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes.dex */
final class zzdn extends zzdj<Boolean> implements zzff<Boolean>, zzgu, RandomAccess {
    private static final zzdn zzade;
    private int size;
    private boolean[] zzadf;

    zzdn() {
        this(new boolean[10], 0);
    }

    private zzdn(boolean[] zArr, int i) {
        this.zzadf = zArr;
        this.size = i;
    }

    @Override // java.util.AbstractList
    protected final void removeRange(int i, int i2) {
        zzrz();
        if (i2 < i) {
            throw new IndexOutOfBoundsException("toIndex < fromIndex");
        }
        System.arraycopy(this.zzadf, i2, this.zzadf, i, this.size - i2);
        this.size -= i2 - i;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.Collection, java.util.List
    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzdn)) {
            return super.equals(obj);
        }
        zzdn zzdnVar = (zzdn) obj;
        if (this.size != zzdnVar.size) {
            return false;
        }
        boolean[] zArr = zzdnVar.zzadf;
        for (int i = 0; i < this.size; i++) {
            if (this.zzadf[i] != zArr[i]) {
                return false;
            }
        }
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.Collection, java.util.List
    public final int hashCode() {
        int iZzs = 1;
        for (int i = 0; i < this.size; i++) {
            iZzs = (iZzs * 31) + zzez.zzs(this.zzadf[i]);
        }
        return iZzs;
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.size;
    }

    public final void addBoolean(boolean z) {
        zza(this.size, z);
    }

    private final void zza(int i, boolean z) {
        zzrz();
        if (i < 0 || i > this.size) {
            throw new IndexOutOfBoundsException(zzao(i));
        }
        if (this.size < this.zzadf.length) {
            System.arraycopy(this.zzadf, i, this.zzadf, i + 1, this.size - i);
        } else {
            boolean[] zArr = new boolean[((this.size * 3) / 2) + 1];
            System.arraycopy(this.zzadf, 0, zArr, 0, i);
            System.arraycopy(this.zzadf, i, zArr, i + 1, this.size - i);
            this.zzadf = zArr;
        }
        this.zzadf[i] = z;
        this.size++;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean addAll(Collection<? extends Boolean> collection) {
        zzrz();
        zzez.checkNotNull(collection);
        if (!(collection instanceof zzdn)) {
            return super.addAll(collection);
        }
        zzdn zzdnVar = (zzdn) collection;
        if (zzdnVar.size == 0) {
            return false;
        }
        if (Integer.MAX_VALUE - this.size < zzdnVar.size) {
            throw new OutOfMemoryError();
        }
        int i = this.size + zzdnVar.size;
        if (i > this.zzadf.length) {
            this.zzadf = Arrays.copyOf(this.zzadf, i);
        }
        System.arraycopy(zzdnVar.zzadf, 0, this.zzadf, this.size, zzdnVar.size);
        this.size = i;
        this.modCount++;
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean remove(Object obj) {
        zzrz();
        for (int i = 0; i < this.size; i++) {
            if (obj.equals(Boolean.valueOf(this.zzadf[i]))) {
                System.arraycopy(this.zzadf, i + 1, this.zzadf, i, (this.size - i) - 1);
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
        boolean zBooleanValue = ((Boolean) obj).booleanValue();
        zzrz();
        zzan(i);
        boolean z = this.zzadf[i];
        this.zzadf[i] = zBooleanValue;
        return Boolean.valueOf(z);
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object remove(int i) {
        zzrz();
        zzan(i);
        boolean z = this.zzadf[i];
        if (i < this.size - 1) {
            System.arraycopy(this.zzadf, i + 1, this.zzadf, i, (this.size - i) - 1);
        }
        this.size--;
        this.modCount++;
        return Boolean.valueOf(z);
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.List
    public final /* synthetic */ void add(int i, Object obj) {
        zza(i, ((Boolean) obj).booleanValue());
    }

    @Override // com.google.android.gms.internal.measurement.zzff
    public final /* synthetic */ zzff<Boolean> zzap(int i) {
        if (i < this.size) {
            throw new IllegalArgumentException();
        }
        return new zzdn(Arrays.copyOf(this.zzadf, i), this.size);
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        zzan(i);
        return Boolean.valueOf(this.zzadf[i]);
    }

    static {
        zzdn zzdnVar = new zzdn(new boolean[0], 0);
        zzade = zzdnVar;
        zzdnVar.zzry();
    }
}

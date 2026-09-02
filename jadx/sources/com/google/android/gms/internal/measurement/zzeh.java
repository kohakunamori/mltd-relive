package com.google.android.gms.internal.measurement;

import java.util.Arrays;
import java.util.Collection;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes.dex */
final class zzeh extends zzdj<Double> implements zzff<Double>, zzgu, RandomAccess {
    private static final zzeh zzaeo;
    private int size;
    private double[] zzaep;

    zzeh() {
        this(new double[10], 0);
    }

    private zzeh(double[] dArr, int i) {
        this.zzaep = dArr;
        this.size = i;
    }

    @Override // java.util.AbstractList
    protected final void removeRange(int i, int i2) {
        zzrz();
        if (i2 < i) {
            throw new IndexOutOfBoundsException("toIndex < fromIndex");
        }
        System.arraycopy(this.zzaep, i2, this.zzaep, i, this.size - i2);
        this.size -= i2 - i;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.Collection, java.util.List
    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzeh)) {
            return super.equals(obj);
        }
        zzeh zzehVar = (zzeh) obj;
        if (this.size != zzehVar.size) {
            return false;
        }
        double[] dArr = zzehVar.zzaep;
        for (int i = 0; i < this.size; i++) {
            if (Double.doubleToLongBits(this.zzaep[i]) != Double.doubleToLongBits(dArr[i])) {
                return false;
            }
        }
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.Collection, java.util.List
    public final int hashCode() {
        int iZzbx = 1;
        for (int i = 0; i < this.size; i++) {
            iZzbx = (iZzbx * 31) + zzez.zzbx(Double.doubleToLongBits(this.zzaep[i]));
        }
        return iZzbx;
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.size;
    }

    public final void zzf(double d) {
        zzc(this.size, d);
    }

    private final void zzc(int i, double d) {
        zzrz();
        if (i < 0 || i > this.size) {
            throw new IndexOutOfBoundsException(zzao(i));
        }
        if (this.size < this.zzaep.length) {
            System.arraycopy(this.zzaep, i, this.zzaep, i + 1, this.size - i);
        } else {
            double[] dArr = new double[((this.size * 3) / 2) + 1];
            System.arraycopy(this.zzaep, 0, dArr, 0, i);
            System.arraycopy(this.zzaep, i, dArr, i + 1, this.size - i);
            this.zzaep = dArr;
        }
        this.zzaep[i] = d;
        this.size++;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean addAll(Collection<? extends Double> collection) {
        zzrz();
        zzez.checkNotNull(collection);
        if (!(collection instanceof zzeh)) {
            return super.addAll(collection);
        }
        zzeh zzehVar = (zzeh) collection;
        if (zzehVar.size == 0) {
            return false;
        }
        if (Integer.MAX_VALUE - this.size < zzehVar.size) {
            throw new OutOfMemoryError();
        }
        int i = this.size + zzehVar.size;
        if (i > this.zzaep.length) {
            this.zzaep = Arrays.copyOf(this.zzaep, i);
        }
        System.arraycopy(zzehVar.zzaep, 0, this.zzaep, this.size, zzehVar.size);
        this.size = i;
        this.modCount++;
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean remove(Object obj) {
        zzrz();
        for (int i = 0; i < this.size; i++) {
            if (obj.equals(Double.valueOf(this.zzaep[i]))) {
                System.arraycopy(this.zzaep, i + 1, this.zzaep, i, (this.size - i) - 1);
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
        double dDoubleValue = ((Double) obj).doubleValue();
        zzrz();
        zzan(i);
        double d = this.zzaep[i];
        this.zzaep[i] = dDoubleValue;
        return Double.valueOf(d);
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object remove(int i) {
        zzrz();
        zzan(i);
        double d = this.zzaep[i];
        if (i < this.size - 1) {
            System.arraycopy(this.zzaep, i + 1, this.zzaep, i, (this.size - i) - 1);
        }
        this.size--;
        this.modCount++;
        return Double.valueOf(d);
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.List
    public final /* synthetic */ void add(int i, Object obj) {
        zzc(i, ((Double) obj).doubleValue());
    }

    @Override // com.google.android.gms.internal.measurement.zzff
    public final /* synthetic */ zzff<Double> zzap(int i) {
        if (i < this.size) {
            throw new IllegalArgumentException();
        }
        return new zzeh(Arrays.copyOf(this.zzaep, i), this.size);
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        zzan(i);
        return Double.valueOf(this.zzaep[i]);
    }

    static {
        zzeh zzehVar = new zzeh(new double[0], 0);
        zzaeo = zzehVar;
        zzehVar.zzry();
    }
}

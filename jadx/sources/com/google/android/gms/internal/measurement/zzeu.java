package com.google.android.gms.internal.measurement;

import java.util.Arrays;
import java.util.Collection;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes.dex */
final class zzeu extends zzdj<Float> implements zzff<Float>, zzgu, RandomAccess {
    private static final zzeu zzahm;
    private int size;
    private float[] zzahn;

    zzeu() {
        this(new float[10], 0);
    }

    private zzeu(float[] fArr, int i) {
        this.zzahn = fArr;
        this.size = i;
    }

    @Override // java.util.AbstractList
    protected final void removeRange(int i, int i2) {
        zzrz();
        if (i2 < i) {
            throw new IndexOutOfBoundsException("toIndex < fromIndex");
        }
        System.arraycopy(this.zzahn, i2, this.zzahn, i, this.size - i2);
        this.size -= i2 - i;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.Collection, java.util.List
    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzeu)) {
            return super.equals(obj);
        }
        zzeu zzeuVar = (zzeu) obj;
        if (this.size != zzeuVar.size) {
            return false;
        }
        float[] fArr = zzeuVar.zzahn;
        for (int i = 0; i < this.size; i++) {
            if (Float.floatToIntBits(this.zzahn[i]) != Float.floatToIntBits(fArr[i])) {
                return false;
            }
        }
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.Collection, java.util.List
    public final int hashCode() {
        int iFloatToIntBits = 1;
        for (int i = 0; i < this.size; i++) {
            iFloatToIntBits = (iFloatToIntBits * 31) + Float.floatToIntBits(this.zzahn[i]);
        }
        return iFloatToIntBits;
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.size;
    }

    public final void zzc(float f) {
        zzc(this.size, f);
    }

    private final void zzc(int i, float f) {
        zzrz();
        if (i < 0 || i > this.size) {
            throw new IndexOutOfBoundsException(zzao(i));
        }
        if (this.size < this.zzahn.length) {
            System.arraycopy(this.zzahn, i, this.zzahn, i + 1, this.size - i);
        } else {
            float[] fArr = new float[((this.size * 3) / 2) + 1];
            System.arraycopy(this.zzahn, 0, fArr, 0, i);
            System.arraycopy(this.zzahn, i, fArr, i + 1, this.size - i);
            this.zzahn = fArr;
        }
        this.zzahn[i] = f;
        this.size++;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean addAll(Collection<? extends Float> collection) {
        zzrz();
        zzez.checkNotNull(collection);
        if (!(collection instanceof zzeu)) {
            return super.addAll(collection);
        }
        zzeu zzeuVar = (zzeu) collection;
        if (zzeuVar.size == 0) {
            return false;
        }
        if (Integer.MAX_VALUE - this.size < zzeuVar.size) {
            throw new OutOfMemoryError();
        }
        int i = this.size + zzeuVar.size;
        if (i > this.zzahn.length) {
            this.zzahn = Arrays.copyOf(this.zzahn, i);
        }
        System.arraycopy(zzeuVar.zzahn, 0, this.zzahn, this.size, zzeuVar.size);
        this.size = i;
        this.modCount++;
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean remove(Object obj) {
        zzrz();
        for (int i = 0; i < this.size; i++) {
            if (obj.equals(Float.valueOf(this.zzahn[i]))) {
                System.arraycopy(this.zzahn, i + 1, this.zzahn, i, (this.size - i) - 1);
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
        float fFloatValue = ((Float) obj).floatValue();
        zzrz();
        zzan(i);
        float f = this.zzahn[i];
        this.zzahn[i] = fFloatValue;
        return Float.valueOf(f);
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object remove(int i) {
        zzrz();
        zzan(i);
        float f = this.zzahn[i];
        if (i < this.size - 1) {
            System.arraycopy(this.zzahn, i + 1, this.zzahn, i, (this.size - i) - 1);
        }
        this.size--;
        this.modCount++;
        return Float.valueOf(f);
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.List
    public final /* synthetic */ void add(int i, Object obj) {
        zzc(i, ((Float) obj).floatValue());
    }

    @Override // com.google.android.gms.internal.measurement.zzff
    public final /* synthetic */ zzff<Float> zzap(int i) {
        if (i < this.size) {
            throw new IllegalArgumentException();
        }
        return new zzeu(Arrays.copyOf(this.zzahn, i), this.size);
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        zzan(i);
        return Float.valueOf(this.zzahn[i]);
    }

    static {
        zzeu zzeuVar = new zzeu(new float[0], 0);
        zzahm = zzeuVar;
        zzeuVar.zzry();
    }
}

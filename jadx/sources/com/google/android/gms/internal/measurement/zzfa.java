package com.google.android.gms.internal.measurement;

import java.util.Arrays;
import java.util.Collection;
import java.util.RandomAccess;

/* JADX INFO: loaded from: classes.dex */
final class zzfa extends zzdj<Integer> implements zzfd, zzgu, RandomAccess {
    private static final zzfa zzaiu;
    private int size;
    private int[] zzaiv;

    public static zzfa zzus() {
        return zzaiu;
    }

    zzfa() {
        this(new int[10], 0);
    }

    private zzfa(int[] iArr, int i) {
        this.zzaiv = iArr;
        this.size = i;
    }

    @Override // java.util.AbstractList
    protected final void removeRange(int i, int i2) {
        zzrz();
        if (i2 < i) {
            throw new IndexOutOfBoundsException("toIndex < fromIndex");
        }
        System.arraycopy(this.zzaiv, i2, this.zzaiv, i, this.size - i2);
        this.size -= i2 - i;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.Collection, java.util.List
    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof zzfa)) {
            return super.equals(obj);
        }
        zzfa zzfaVar = (zzfa) obj;
        if (this.size != zzfaVar.size) {
            return false;
        }
        int[] iArr = zzfaVar.zzaiv;
        for (int i = 0; i < this.size; i++) {
            if (this.zzaiv[i] != iArr[i]) {
                return false;
            }
        }
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.Collection, java.util.List
    public final int hashCode() {
        int i = 1;
        for (int i2 = 0; i2 < this.size; i2++) {
            i = (i * 31) + this.zzaiv[i2];
        }
        return i;
    }

    @Override // com.google.android.gms.internal.measurement.zzff
    /* JADX INFO: renamed from: zzbt, reason: merged with bridge method [inline-methods] */
    public final zzfd zzap(int i) {
        if (i < this.size) {
            throw new IllegalArgumentException();
        }
        return new zzfa(Arrays.copyOf(this.zzaiv, i), this.size);
    }

    public final int getInt(int i) {
        zzan(i);
        return this.zzaiv[i];
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public final int size() {
        return this.size;
    }

    public final void zzbu(int i) {
        zzo(this.size, i);
    }

    private final void zzo(int i, int i2) {
        zzrz();
        if (i < 0 || i > this.size) {
            throw new IndexOutOfBoundsException(zzao(i));
        }
        if (this.size < this.zzaiv.length) {
            System.arraycopy(this.zzaiv, i, this.zzaiv, i + 1, this.size - i);
        } else {
            int[] iArr = new int[((this.size * 3) / 2) + 1];
            System.arraycopy(this.zzaiv, 0, iArr, 0, i);
            System.arraycopy(this.zzaiv, i, iArr, i + 1, this.size - i);
            this.zzaiv = iArr;
        }
        this.zzaiv[i] = i2;
        this.size++;
        this.modCount++;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean addAll(Collection<? extends Integer> collection) {
        zzrz();
        zzez.checkNotNull(collection);
        if (!(collection instanceof zzfa)) {
            return super.addAll(collection);
        }
        zzfa zzfaVar = (zzfa) collection;
        if (zzfaVar.size == 0) {
            return false;
        }
        if (Integer.MAX_VALUE - this.size < zzfaVar.size) {
            throw new OutOfMemoryError();
        }
        int i = this.size + zzfaVar.size;
        if (i > this.zzaiv.length) {
            this.zzaiv = Arrays.copyOf(this.zzaiv, i);
        }
        System.arraycopy(zzfaVar.zzaiv, 0, this.zzaiv, this.size, zzfaVar.size);
        this.size = i;
        this.modCount++;
        return true;
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractCollection, java.util.Collection, java.util.List
    public final boolean remove(Object obj) {
        zzrz();
        for (int i = 0; i < this.size; i++) {
            if (obj.equals(Integer.valueOf(this.zzaiv[i]))) {
                System.arraycopy(this.zzaiv, i + 1, this.zzaiv, i, (this.size - i) - 1);
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
        int iIntValue = ((Integer) obj).intValue();
        zzrz();
        zzan(i);
        int i2 = this.zzaiv[i];
        this.zzaiv[i] = iIntValue;
        return Integer.valueOf(i2);
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.List
    public final /* synthetic */ Object remove(int i) {
        zzrz();
        zzan(i);
        int i2 = this.zzaiv[i];
        if (i < this.size - 1) {
            System.arraycopy(this.zzaiv, i + 1, this.zzaiv, i, (this.size - i) - 1);
        }
        this.size--;
        this.modCount++;
        return Integer.valueOf(i2);
    }

    @Override // com.google.android.gms.internal.measurement.zzdj, java.util.AbstractList, java.util.List
    public final /* synthetic */ void add(int i, Object obj) {
        zzo(i, ((Integer) obj).intValue());
    }

    @Override // java.util.AbstractList, java.util.List
    public final /* synthetic */ Object get(int i) {
        return Integer.valueOf(getInt(i));
    }

    static {
        zzfa zzfaVar = new zzfa(new int[0], 0);
        zzaiu = zzfaVar;
        zzfaVar.zzry();
    }
}

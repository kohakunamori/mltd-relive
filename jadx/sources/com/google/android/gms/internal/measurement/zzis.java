package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzis implements Cloneable {
    private static final zzir zzaor = new zzir();
    private int mSize;
    private boolean zzaos;
    private int[] zzaot;
    private zzir[] zzaou;

    zzis() {
        this(10);
    }

    private zzis(int i) {
        this.zzaos = false;
        int iIdealIntArraySize = idealIntArraySize(i);
        this.zzaot = new int[iIdealIntArraySize];
        this.zzaou = new zzir[iIdealIntArraySize];
        this.mSize = 0;
    }

    final zzir zzcl(int i) {
        int iZzcn = zzcn(i);
        if (iZzcn < 0 || this.zzaou[iZzcn] == zzaor) {
            return null;
        }
        return this.zzaou[iZzcn];
    }

    final void zza(int i, zzir zzirVar) {
        int iZzcn = zzcn(i);
        if (iZzcn >= 0) {
            this.zzaou[iZzcn] = zzirVar;
            return;
        }
        int i2 = iZzcn ^ (-1);
        if (i2 < this.mSize && this.zzaou[i2] == zzaor) {
            this.zzaot[i2] = i;
            this.zzaou[i2] = zzirVar;
            return;
        }
        if (this.mSize >= this.zzaot.length) {
            int iIdealIntArraySize = idealIntArraySize(this.mSize + 1);
            int[] iArr = new int[iIdealIntArraySize];
            zzir[] zzirVarArr = new zzir[iIdealIntArraySize];
            System.arraycopy(this.zzaot, 0, iArr, 0, this.zzaot.length);
            System.arraycopy(this.zzaou, 0, zzirVarArr, 0, this.zzaou.length);
            this.zzaot = iArr;
            this.zzaou = zzirVarArr;
        }
        if (this.mSize - i2 != 0) {
            int i3 = i2 + 1;
            System.arraycopy(this.zzaot, i2, this.zzaot, i3, this.mSize - i2);
            System.arraycopy(this.zzaou, i2, this.zzaou, i3, this.mSize - i2);
        }
        this.zzaot[i2] = i;
        this.zzaou[i2] = zzirVar;
        this.mSize++;
    }

    final int size() {
        return this.mSize;
    }

    public final boolean isEmpty() {
        return this.mSize == 0;
    }

    final zzir zzcm(int i) {
        return this.zzaou[i];
    }

    /* JADX WARN: Code duplicated, block: B:27:0x0045 A[RETURN] */
    public final boolean equals(Object obj) {
        boolean z;
        boolean z2;
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzis)) {
            return false;
        }
        zzis zzisVar = (zzis) obj;
        if (this.mSize != zzisVar.mSize) {
            return false;
        }
        int[] iArr = this.zzaot;
        int[] iArr2 = zzisVar.zzaot;
        int i = this.mSize;
        int i2 = 0;
        while (true) {
            if (i2 >= i) {
                z = true;
                break;
            }
            if (iArr[i2] != iArr2[i2]) {
                z = false;
                break;
            }
            i2++;
        }
        if (z) {
            zzir[] zzirVarArr = this.zzaou;
            zzir[] zzirVarArr2 = zzisVar.zzaou;
            int i3 = this.mSize;
            for (int i4 = 0; i4 < i3; i4++) {
                if (!zzirVarArr[i4].equals(zzirVarArr2[i4])) {
                    z2 = false;
                    if (z2) {
                        return true;
                    }
                }
            }
            z2 = true;
            if (z2) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        int iHashCode = 17;
        for (int i = 0; i < this.mSize; i++) {
            iHashCode = (((iHashCode * 31) + this.zzaot[i]) * 31) + this.zzaou[i].hashCode();
        }
        return iHashCode;
    }

    private static int idealIntArraySize(int i) {
        int i2 = i << 2;
        for (int i3 = 4; i3 < 32; i3++) {
            int i4 = (1 << i3) - 12;
            if (i2 <= i4) {
                i2 = i4;
                break;
            }
        }
        return i2 / 4;
    }

    private final int zzcn(int i) {
        int i2 = this.mSize - 1;
        int i3 = 0;
        while (i3 <= i2) {
            int i4 = (i3 + i2) >>> 1;
            int i5 = this.zzaot[i4];
            if (i5 < i) {
                i3 = i4 + 1;
            } else {
                if (i5 <= i) {
                    return i4;
                }
                i2 = i4 - 1;
            }
        }
        return i3 ^ (-1);
    }

    public final /* synthetic */ Object clone() throws CloneNotSupportedException {
        int i = this.mSize;
        zzis zzisVar = new zzis(i);
        System.arraycopy(this.zzaot, 0, zzisVar.zzaot, 0, i);
        for (int i2 = 0; i2 < i; i2++) {
            if (this.zzaou[i2] != null) {
                zzisVar.zzaou[i2] = (zzir) this.zzaou[i2].clone();
            }
        }
        zzisVar.mSize = i;
        return zzisVar;
    }
}

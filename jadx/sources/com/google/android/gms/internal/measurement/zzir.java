package com.google.android.gms.internal.measurement;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
final class zzir implements Cloneable {
    private Object value;
    private zzip<?, ?> zzaop;
    private List<zziy> zzaoq = new ArrayList();

    zzir() {
    }

    final void zza(zziy zziyVar) throws IOException {
        if (this.zzaoq != null) {
            this.zzaoq.add(zziyVar);
            return;
        }
        if (this.value instanceof zziw) {
            byte[] bArr = zziyVar.zzado;
            zzil zzilVarZzj = zzil.zzj(bArr, 0, bArr.length);
            int iZzta = zzilVarZzj.zzta();
            if (iZzta != bArr.length - zzio.zzbj(iZzta)) {
                throw zzit.zzxd();
            }
            zziw zziwVarZza = ((zziw) this.value).zza(zzilVarZzj);
            this.zzaop = this.zzaop;
            this.value = zziwVarZza;
            this.zzaoq = null;
            return;
        }
        if (this.value instanceof zziw[]) {
            Collections.singletonList(zziyVar);
            throw new NoSuchMethodError();
        }
        if (this.value instanceof zzgi) {
            Collections.singletonList(zziyVar);
            throw new NoSuchMethodError();
        }
        if (this.value instanceof zzgi[]) {
            Collections.singletonList(zziyVar);
            throw new NoSuchMethodError();
        }
        Collections.singletonList(zziyVar);
        throw new NoSuchMethodError();
    }

    final int zzqy() {
        if (this.value != null) {
            throw new NoSuchMethodError();
        }
        int iZzbq = 0;
        for (zziy zziyVar : this.zzaoq) {
            iZzbq += zzio.zzbq(zziyVar.tag) + 0 + zziyVar.zzado.length;
        }
        return iZzbq;
    }

    final void zza(zzio zzioVar) throws IOException {
        if (this.value != null) {
            throw new NoSuchMethodError();
        }
        for (zziy zziyVar : this.zzaoq) {
            zzioVar.zzck(zziyVar.tag);
            zzioVar.zzk(zziyVar.zzado);
        }
    }

    public final boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof zzir)) {
            return false;
        }
        zzir zzirVar = (zzir) obj;
        if (this.value != null && zzirVar.value != null) {
            if (this.zzaop != zzirVar.zzaop) {
                return false;
            }
            if (!this.zzaop.zzaon.isArray()) {
                return this.value.equals(zzirVar.value);
            }
            if (this.value instanceof byte[]) {
                return Arrays.equals((byte[]) this.value, (byte[]) zzirVar.value);
            }
            if (this.value instanceof int[]) {
                return Arrays.equals((int[]) this.value, (int[]) zzirVar.value);
            }
            if (this.value instanceof long[]) {
                return Arrays.equals((long[]) this.value, (long[]) zzirVar.value);
            }
            if (this.value instanceof float[]) {
                return Arrays.equals((float[]) this.value, (float[]) zzirVar.value);
            }
            if (this.value instanceof double[]) {
                return Arrays.equals((double[]) this.value, (double[]) zzirVar.value);
            }
            if (this.value instanceof boolean[]) {
                return Arrays.equals((boolean[]) this.value, (boolean[]) zzirVar.value);
            }
            return Arrays.deepEquals((Object[]) this.value, (Object[]) zzirVar.value);
        }
        if (this.zzaoq != null && zzirVar.zzaoq != null) {
            return this.zzaoq.equals(zzirVar.zzaoq);
        }
        try {
            return Arrays.equals(toByteArray(), zzirVar.toByteArray());
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    public final int hashCode() {
        try {
            return Arrays.hashCode(toByteArray()) + 527;
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    private final byte[] toByteArray() throws IOException {
        byte[] bArr = new byte[zzqy()];
        zza(zzio.zzj(bArr));
        return bArr;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: zzxc, reason: merged with bridge method [inline-methods] */
    public final zzir clone() {
        zzir zzirVar = new zzir();
        try {
            zzirVar.zzaop = this.zzaop;
            if (this.zzaoq == null) {
                zzirVar.zzaoq = null;
            } else {
                zzirVar.zzaoq.addAll(this.zzaoq);
            }
            if (this.value != null) {
                if (this.value instanceof zziw) {
                    zzirVar.value = (zziw) ((zziw) this.value).clone();
                } else if (this.value instanceof byte[]) {
                    zzirVar.value = ((byte[]) this.value).clone();
                } else {
                    int i = 0;
                    if (this.value instanceof byte[][]) {
                        byte[][] bArr = (byte[][]) this.value;
                        byte[][] bArr2 = new byte[bArr.length][];
                        zzirVar.value = bArr2;
                        while (i < bArr.length) {
                            bArr2[i] = (byte[]) bArr[i].clone();
                            i++;
                        }
                    } else if (this.value instanceof boolean[]) {
                        zzirVar.value = ((boolean[]) this.value).clone();
                    } else if (this.value instanceof int[]) {
                        zzirVar.value = ((int[]) this.value).clone();
                    } else if (this.value instanceof long[]) {
                        zzirVar.value = ((long[]) this.value).clone();
                    } else if (this.value instanceof float[]) {
                        zzirVar.value = ((float[]) this.value).clone();
                    } else if (this.value instanceof double[]) {
                        zzirVar.value = ((double[]) this.value).clone();
                    } else if (this.value instanceof zziw[]) {
                        zziw[] zziwVarArr = (zziw[]) this.value;
                        zziw[] zziwVarArr2 = new zziw[zziwVarArr.length];
                        zzirVar.value = zziwVarArr2;
                        while (i < zziwVarArr.length) {
                            zziwVarArr2[i] = (zziw) zziwVarArr[i].clone();
                            i++;
                        }
                    }
                }
            }
            return zzirVar;
        } catch (CloneNotSupportedException e) {
            throw new AssertionError(e);
        }
    }
}

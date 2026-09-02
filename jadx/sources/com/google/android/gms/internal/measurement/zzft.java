package com.google.android.gms.internal.measurement;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
final class zzft extends zzfs {
    private zzft() {
        super();
    }

    @Override // com.google.android.gms.internal.measurement.zzfs
    final <L> List<L> zza(Object obj, long j) {
        zzff zzffVarZzc = zzc(obj, j);
        if (zzffVarZzc.zzrx()) {
            return zzffVarZzc;
        }
        int size = zzffVarZzc.size();
        zzff zzffVarZzap = zzffVarZzc.zzap(size == 0 ? 10 : size << 1);
        zzhv.zza(obj, j, zzffVarZzap);
        return zzffVarZzap;
    }

    @Override // com.google.android.gms.internal.measurement.zzfs
    final void zzb(Object obj, long j) {
        zzc(obj, j).zzry();
    }

    @Override // com.google.android.gms.internal.measurement.zzfs
    final <E> void zza(Object obj, Object obj2, long j) {
        zzff zzffVarZzc = zzc(obj, j);
        zzff zzffVarZzc2 = zzc(obj2, j);
        int size = zzffVarZzc.size();
        int size2 = zzffVarZzc2.size();
        if (size > 0 && size2 > 0) {
            if (!zzffVarZzc.zzrx()) {
                zzffVarZzc = zzffVarZzc.zzap(size2 + size);
            }
            zzffVarZzc.addAll(zzffVarZzc2);
        }
        if (size > 0) {
            zzffVarZzc2 = zzffVarZzc;
        }
        zzhv.zza(obj, j, zzffVarZzc2);
    }

    private static <E> zzff<E> zzc(Object obj, long j) {
        return (zzff) zzhv.zzp(obj, j);
    }
}

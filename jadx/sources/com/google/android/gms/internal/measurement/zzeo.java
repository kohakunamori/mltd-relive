package com.google.android.gms.internal.measurement;

import com.google.android.gms.internal.measurement.zzeq;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class zzeo<FieldDescriptorType extends zzeq<FieldDescriptorType>> {
    private static final zzeo zzafa = new zzeo(true);
    private boolean zzaey;
    private boolean zzaez = false;
    final zzhc<FieldDescriptorType, Object> zzaex = zzhc.zzce(16);

    private zzeo() {
    }

    private zzeo(boolean z) {
        zzry();
    }

    public static <T extends zzeq<T>> zzeo<T> zztr() {
        return zzafa;
    }

    public final void zzry() {
        if (this.zzaey) {
            return;
        }
        this.zzaex.zzry();
        this.zzaey = true;
    }

    public final boolean isImmutable() {
        return this.zzaey;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzeo) {
            return this.zzaex.equals(((zzeo) obj).zzaex);
        }
        return false;
    }

    public final int hashCode() {
        return this.zzaex.hashCode();
    }

    public final Iterator<Map.Entry<FieldDescriptorType, Object>> iterator() {
        if (this.zzaez) {
            return new zzfo(this.zzaex.entrySet().iterator());
        }
        return this.zzaex.entrySet().iterator();
    }

    final Iterator<Map.Entry<FieldDescriptorType, Object>> descendingIterator() {
        if (this.zzaez) {
            return new zzfo(this.zzaex.zzwj().iterator());
        }
        return this.zzaex.zzwj().iterator();
    }

    private final Object zza(FieldDescriptorType fielddescriptortype) {
        Object obj = this.zzaex.get(fielddescriptortype);
        return obj instanceof zzfj ? zzfj.zzvc() : obj;
    }

    private final void zza(FieldDescriptorType fielddescriptortype, Object obj) {
        if (fielddescriptortype.zzty()) {
            if (!(obj instanceof List)) {
                throw new IllegalArgumentException("Wrong object type used with protocol message reflection.");
            }
            ArrayList arrayList = new ArrayList();
            arrayList.addAll((List) obj);
            ArrayList arrayList2 = arrayList;
            int size = arrayList2.size();
            int i = 0;
            while (i < size) {
                Object obj2 = arrayList2.get(i);
                i++;
                zza(fielddescriptortype.zztw(), obj2);
            }
            obj = arrayList;
        } else {
            zza(fielddescriptortype.zztw(), obj);
        }
        if (obj instanceof zzfj) {
            this.zzaez = true;
        }
        this.zzaex.put(fielddescriptortype, obj);
    }

    /* JADX WARN: Code duplicated, block: B:14:0x0026  */
    private static void zza(zzig zzigVar, Object obj) {
        boolean z;
        zzez.checkNotNull(obj);
        boolean z2 = false;
        switch (zzer.zzafd[zzigVar.zzwz().ordinal()]) {
            case 1:
                z = obj instanceof Integer;
                z2 = z;
                break;
            case 2:
                z = obj instanceof Long;
                z2 = z;
                break;
            case 3:
                z = obj instanceof Float;
                z2 = z;
                break;
            case 4:
                z = obj instanceof Double;
                z2 = z;
                break;
            case 5:
                z = obj instanceof Boolean;
                z2 = z;
                break;
            case 6:
                z = obj instanceof String;
                z2 = z;
                break;
            case 7:
                if ((obj instanceof zzdp) || (obj instanceof byte[])) {
                    z2 = true;
                }
                break;
            case 8:
                if ((obj instanceof Integer) || (obj instanceof zzfc)) {
                    z2 = true;
                }
                break;
            case 9:
                if ((obj instanceof zzgi) || (obj instanceof zzfj)) {
                    z2 = true;
                }
                break;
        }
        if (!z2) {
            throw new IllegalArgumentException("Wrong object type used with protocol message reflection.");
        }
    }

    public final boolean isInitialized() {
        for (int i = 0; i < this.zzaex.zzwh(); i++) {
            if (!zzb(this.zzaex.zzcf(i))) {
                return false;
            }
        }
        Iterator it = this.zzaex.zzwi().iterator();
        while (it.hasNext()) {
            if (!zzb((Map.Entry) it.next())) {
                return false;
            }
        }
        return true;
    }

    private static boolean zzb(Map.Entry<FieldDescriptorType, Object> entry) {
        FieldDescriptorType key = entry.getKey();
        if (key.zztx() == zzij.MESSAGE) {
            if (key.zzty()) {
                Iterator it = ((List) entry.getValue()).iterator();
                while (it.hasNext()) {
                    if (!((zzgi) it.next()).isInitialized()) {
                        return false;
                    }
                }
            } else {
                Object value = entry.getValue();
                if (value instanceof zzgi) {
                    if (!((zzgi) value).isInitialized()) {
                        return false;
                    }
                } else {
                    if (value instanceof zzfj) {
                        return true;
                    }
                    throw new IllegalArgumentException("Wrong object type used with protocol message reflection.");
                }
            }
        }
        return true;
    }

    public final void zza(zzeo<FieldDescriptorType> zzeoVar) {
        for (int i = 0; i < zzeoVar.zzaex.zzwh(); i++) {
            zzc(zzeoVar.zzaex.zzcf(i));
        }
        Iterator it = zzeoVar.zzaex.zzwi().iterator();
        while (it.hasNext()) {
            zzc((Map.Entry) it.next());
        }
    }

    private static Object zzk(Object obj) {
        if (obj instanceof zzgn) {
            return ((zzgn) obj).zzvu();
        }
        if (!(obj instanceof byte[])) {
            return obj;
        }
        byte[] bArr = (byte[]) obj;
        byte[] bArr2 = new byte[bArr.length];
        System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
        return bArr2;
    }

    private final void zzc(Map.Entry<FieldDescriptorType, Object> entry) {
        zzgi zzgiVarZzug;
        FieldDescriptorType key = entry.getKey();
        Object value = entry.getValue();
        if (value instanceof zzfj) {
            value = zzfj.zzvc();
        }
        if (key.zzty()) {
            Object objZza = zza(key);
            if (objZza == null) {
                objZza = new ArrayList();
            }
            Iterator it = ((List) value).iterator();
            while (it.hasNext()) {
                ((List) objZza).add(zzk(it.next()));
            }
            this.zzaex.put(key, objZza);
            return;
        }
        if (key.zztx() == zzij.MESSAGE) {
            Object objZza2 = zza(key);
            if (objZza2 == null) {
                this.zzaex.put(key, zzk(value));
                return;
            }
            if (objZza2 instanceof zzgn) {
                zzgiVarZzug = key.zza((zzgn) objZza2, (zzgn) value);
            } else {
                zzgiVarZzug = key.zza(((zzgi) objZza2).zzuo(), (zzgi) value).zzug();
            }
            this.zzaex.put(key, zzgiVarZzug);
            return;
        }
        this.zzaex.put(key, zzk(value));
    }

    static void zza(zzee zzeeVar, zzig zzigVar, int i, Object obj) throws IOException {
        if (zzigVar == zzig.zzank) {
            zzgi zzgiVar = (zzgi) obj;
            zzez.zzf(zzgiVar);
            zzeeVar.zzb(i, 3);
            zzgiVar.zzb(zzeeVar);
            zzeeVar.zzb(i, 4);
        }
        zzeeVar.zzb(i, zzigVar.zzxa());
        switch (zzer.zzaee[zzigVar.ordinal()]) {
            case 1:
                zzeeVar.zzd(((Double) obj).doubleValue());
                break;
            case 2:
                zzeeVar.zza(((Float) obj).floatValue());
                break;
            case 3:
                zzeeVar.zzbn(((Long) obj).longValue());
                break;
            case 4:
                zzeeVar.zzbn(((Long) obj).longValue());
                break;
            case 5:
                zzeeVar.zzbe(((Integer) obj).intValue());
                break;
            case 6:
                zzeeVar.zzbp(((Long) obj).longValue());
                break;
            case 7:
                zzeeVar.zzbh(((Integer) obj).intValue());
                break;
            case 8:
                zzeeVar.zzq(((Boolean) obj).booleanValue());
                break;
            case 9:
                ((zzgi) obj).zzb(zzeeVar);
                break;
            case 10:
                zzeeVar.zzb((zzgi) obj);
                break;
            case 11:
                if (obj instanceof zzdp) {
                    zzeeVar.zza((zzdp) obj);
                } else {
                    zzeeVar.zzdr((String) obj);
                }
                break;
            case 12:
                if (obj instanceof zzdp) {
                    zzeeVar.zza((zzdp) obj);
                } else {
                    byte[] bArr = (byte[]) obj;
                    zzeeVar.zze(bArr, 0, bArr.length);
                }
                break;
            case 13:
                zzeeVar.zzbf(((Integer) obj).intValue());
                break;
            case 14:
                zzeeVar.zzbh(((Integer) obj).intValue());
                break;
            case 15:
                zzeeVar.zzbp(((Long) obj).longValue());
                break;
            case 16:
                zzeeVar.zzbg(((Integer) obj).intValue());
                break;
            case 17:
                zzeeVar.zzbo(((Long) obj).longValue());
                break;
            case 18:
                if (obj instanceof zzfc) {
                    zzeeVar.zzbe(((zzfc) obj).zzlg());
                } else {
                    zzeeVar.zzbe(((Integer) obj).intValue());
                }
                break;
        }
    }

    public final int zzts() {
        int iZzd = 0;
        for (int i = 0; i < this.zzaex.zzwh(); i++) {
            iZzd += zzd(this.zzaex.zzcf(i));
        }
        Iterator it = this.zzaex.zzwi().iterator();
        while (it.hasNext()) {
            iZzd += zzd((Map.Entry) it.next());
        }
        return iZzd;
    }

    private static int zzd(Map.Entry<FieldDescriptorType, Object> entry) {
        FieldDescriptorType key = entry.getKey();
        Object value = entry.getValue();
        if (key.zztx() == zzij.MESSAGE && !key.zzty() && !key.zztz()) {
            if (value instanceof zzfj) {
                return zzee.zzb(entry.getKey().zzlg(), (zzfj) value);
            }
            return zzee.zzd(entry.getKey().zzlg(), (zzgi) value);
        }
        return zzb((zzeq<?>) key, value);
    }

    static int zza(zzig zzigVar, int i, Object obj) {
        int iZzbi = zzee.zzbi(i);
        if (zzigVar == zzig.zzank) {
            zzez.zzf((zzgi) obj);
            iZzbi <<= 1;
        }
        return iZzbi + zzb(zzigVar, obj);
    }

    private static int zzb(zzig zzigVar, Object obj) {
        switch (zzer.zzaee[zzigVar.ordinal()]) {
            case 1:
                return zzee.zze(((Double) obj).doubleValue());
            case 2:
                return zzee.zzb(((Float) obj).floatValue());
            case 3:
                return zzee.zzbq(((Long) obj).longValue());
            case 4:
                return zzee.zzbr(((Long) obj).longValue());
            case 5:
                return zzee.zzbj(((Integer) obj).intValue());
            case 6:
                return zzee.zzbt(((Long) obj).longValue());
            case 7:
                return zzee.zzbm(((Integer) obj).intValue());
            case 8:
                return zzee.zzr(((Boolean) obj).booleanValue());
            case 9:
                return zzee.zzd((zzgi) obj);
            case 10:
                if (obj instanceof zzfj) {
                    return zzee.zza((zzfj) obj);
                }
                return zzee.zzc((zzgi) obj);
            case 11:
                if (obj instanceof zzdp) {
                    return zzee.zzb((zzdp) obj);
                }
                return zzee.zzds((String) obj);
            case 12:
                if (obj instanceof zzdp) {
                    return zzee.zzb((zzdp) obj);
                }
                return zzee.zzg((byte[]) obj);
            case 13:
                return zzee.zzbk(((Integer) obj).intValue());
            case 14:
                return zzee.zzbn(((Integer) obj).intValue());
            case 15:
                return zzee.zzbu(((Long) obj).longValue());
            case 16:
                return zzee.zzbl(((Integer) obj).intValue());
            case 17:
                return zzee.zzbs(((Long) obj).longValue());
            case 18:
                if (obj instanceof zzfc) {
                    return zzee.zzbo(((zzfc) obj).zzlg());
                }
                return zzee.zzbo(((Integer) obj).intValue());
            default:
                throw new RuntimeException("There is no way to get here, but the compiler thinks otherwise.");
        }
    }

    public static int zzb(zzeq<?> zzeqVar, Object obj) {
        zzig zzigVarZztw = zzeqVar.zztw();
        int iZzlg = zzeqVar.zzlg();
        if (zzeqVar.zzty()) {
            int iZza = 0;
            if (zzeqVar.zztz()) {
                Iterator it = ((List) obj).iterator();
                while (it.hasNext()) {
                    iZza += zzb(zzigVarZztw, it.next());
                }
                return zzee.zzbi(iZzlg) + iZza + zzee.zzbq(iZza);
            }
            Iterator it2 = ((List) obj).iterator();
            while (it2.hasNext()) {
                iZza += zza(zzigVarZztw, iZzlg, it2.next());
            }
            return iZza;
        }
        return zza(zzigVarZztw, iZzlg, obj);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public final /* synthetic */ Object clone() throws CloneNotSupportedException {
        zzeo zzeoVar = new zzeo();
        for (int i = 0; i < this.zzaex.zzwh(); i++) {
            Map.Entry<K, Object> entryZzcf = this.zzaex.zzcf(i);
            zzeoVar.zza((zzeq) entryZzcf.getKey(), entryZzcf.getValue());
        }
        Iterator it = this.zzaex.zzwi().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            zzeoVar.zza((zzeq) entry.getKey(), entry.getValue());
        }
        zzeoVar.zzaez = this.zzaez;
        return zzeoVar;
    }
}

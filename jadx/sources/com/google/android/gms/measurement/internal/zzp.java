package com.google.android.gms.measurement.internal;

import android.content.ContentValues;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.text.TextUtils;
import android.util.Pair;
import androidx.annotation.WorkerThread;
import androidx.collection.ArrayMap;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.BitSet;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

/* JADX INFO: loaded from: classes.dex */
final class zzp extends zzjh {
    zzp(zzjg zzjgVar) {
        super(zzjgVar);
    }

    @Override // com.google.android.gms.measurement.internal.zzjh
    protected final boolean zzbk() {
        return false;
    }

    /* JADX WARN: Code duplicated, block: B:161:0x0473  */
    /* JADX WARN: Code duplicated, block: B:166:0x0490  */
    /* JADX WARN: Code duplicated, block: B:169:0x049a A[LOOP:8: B:167:0x0494->B:169:0x049a, LOOP_END] */
    /* JADX WARN: Code duplicated, block: B:171:0x04aa  */
    /* JADX WARN: Code duplicated, block: B:188:0x0535  */
    /* JADX WARN: Code duplicated, block: B:190:0x0550  */
    /* JADX WARN: Code duplicated, block: B:191:0x0583  */
    /* JADX WARN: Code duplicated, block: B:192:0x05b4  */
    /* JADX WARN: Code duplicated, block: B:194:0x05c7  */
    /* JADX WARN: Code duplicated, block: B:196:0x05fc  */
    /* JADX WARN: Code duplicated, block: B:199:0x0643  */
    /* JADX WARN: Code duplicated, block: B:201:0x064d  */
    /* JADX WARN: Code duplicated, block: B:206:0x0664  */
    /* JADX WARN: Code duplicated, block: B:211:0x06a6  */
    /* JADX WARN: Code duplicated, block: B:212:0x06c3  */
    /* JADX WARN: Code duplicated, block: B:215:0x06dc  */
    /* JADX WARN: Code duplicated, block: B:217:0x0710  */
    /* JADX WARN: Code duplicated, block: B:218:0x0730  */
    /* JADX WARN: Code duplicated, block: B:220:0x073b  */
    /* JADX WARN: Code duplicated, block: B:224:0x0759  */
    /* JADX WARN: Code duplicated, block: B:230:0x0770  */
    /* JADX WARN: Code duplicated, block: B:233:0x077f  */
    /* JADX WARN: Code duplicated, block: B:235:0x0795  */
    /* JADX WARN: Code duplicated, block: B:236:0x07a4  */
    /* JADX WARN: Code duplicated, block: B:238:0x07d0  */
    /* JADX WARN: Code duplicated, block: B:300:0x0973  */
    /* JADX WARN: Code duplicated, block: B:301:0x097c  */
    /* JADX WARN: Code duplicated, block: B:458:0x0e62  */
    /* JADX WARN: Code duplicated, block: B:547:0x0486 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:549:0x046d A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:553:0x068e A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:554:0x067a A[SYNTHETIC] */
    /* JADX WARN: Multi-variable type inference failed */
    @WorkerThread
    final List<com.google.android.gms.internal.measurement.zzbs.zza> zza(String str, List<com.google.android.gms.internal.measurement.zzbs.zzc> list, List<com.google.android.gms.internal.measurement.zzbs.zzk> list2) {
        Long lValueOf;
        com.google.android.gms.internal.measurement.zzbs.zza.C0530zza c0530zzaZzuj;
        Iterator it;
        ArrayMap arrayMap;
        ArrayMap arrayMap2;
        ArrayMap arrayMap3;
        List listEmptyList;
        ArrayMap arrayMap4;
        ArrayMap arrayMap5;
        Map arrayMap6;
        Map arrayMap7;
        ArrayMap arrayMap8;
        ArrayMap arrayMap9;
        Long l;
        long j;
        String str2;
        List<com.google.android.gms.internal.measurement.zzbs.zze> list3;
        zzae zzaeVarZzc;
        com.google.android.gms.internal.measurement.zzbs.zzc zzcVar;
        zzae zzaeVar;
        zzae zzaeVar2;
        long j2;
        ArrayMap arrayMap10;
        Map<Integer, List<com.google.android.gms.internal.measurement.zzbk.zza>> mapZzh;
        Map<Integer, List<com.google.android.gms.internal.measurement.zzbk.zza>> map;
        Iterator<Integer> it2;
        int iIntValue;
        ArrayMap arrayMap11;
        BitSet bitSet;
        BitSet bitSet2;
        ArrayMap arrayMap12;
        Map map2;
        Map map3;
        Map map4;
        ArrayMap arrayMap13;
        BitSet bitSet3;
        Map map5;
        Map map6;
        long j3;
        ArrayMap arrayMap14;
        ArrayMap arrayMap15;
        Map<Integer, List<com.google.android.gms.internal.measurement.zzbk.zza>> map7;
        Iterator<Integer> it3;
        ArrayMap arrayMap16;
        Map map8;
        Map map9;
        ArrayMap arrayMap17;
        BitSet bitSet4;
        ArrayMap arrayMap18;
        String str3;
        Integer numValueOf;
        Integer numValueOf2;
        Long l2;
        ArrayList arrayList;
        Iterator<com.google.android.gms.internal.measurement.zzbs.zze> it4;
        Map<Integer, com.google.android.gms.internal.measurement.zzbs.zzi> arrayMap19;
        Iterator it5;
        Map<Integer, com.google.android.gms.internal.measurement.zzbs.zzi> map10;
        ArrayMap arrayMap20;
        ArrayMap arrayMap21;
        ArrayMap arrayMap22;
        ArrayMap arrayMap23;
        boolean z;
        Map<Integer, List<Integer>> map11;
        Iterator<Integer> it6;
        String str4 = str;
        Preconditions.checkNotEmpty(str);
        Preconditions.checkNotNull(list);
        Preconditions.checkNotNull(list2);
        HashSet hashSet = new HashSet();
        ArrayMap arrayMap24 = new ArrayMap();
        ArrayMap arrayMap25 = new ArrayMap();
        ArrayMap arrayMap26 = new ArrayMap();
        ArrayMap arrayMap27 = new ArrayMap();
        ArrayMap arrayMap28 = new ArrayMap();
        boolean zZzq = zzad().zzq(str4);
        boolean zZzd = zzad().zzd(str4, zzak.zziq);
        boolean zZzd2 = zzad().zzd(str4, zzak.zziy);
        boolean zZzd3 = zzad().zzd(str4, zzak.zziz);
        if (!zZzd2 && !zZzd3) {
            lValueOf = null;
            break;
        }
        Iterator<com.google.android.gms.internal.measurement.zzbs.zzc> it7 = list.iterator();
        while (true) {
            if (!it7.hasNext()) {
                lValueOf = null;
                break;
            }
            com.google.android.gms.internal.measurement.zzbs.zzc next = it7.next();
            if ("_s".equals(next.getName())) {
                lValueOf = Long.valueOf(next.getTimestampMillis());
                break;
            }
        }
        if (lValueOf != null && zZzd3) {
            zzx zzxVarZzgy = zzgy();
            zzxVarZzgy.zzbi();
            zzxVarZzgy.zzo();
            Preconditions.checkNotEmpty(str);
            ContentValues contentValues = new ContentValues();
            contentValues.put("current_session_count", (Integer) 0);
            try {
                zzxVarZzgy.getWritableDatabase().update("events", contentValues, "app_id = ?", new String[]{str4});
            } catch (SQLiteException e) {
                zzxVarZzgy.zzab().zzgk().zza("Error resetting session-scoped event counts. appId", zzef.zzam(str), e);
            }
        }
        Map<Integer, com.google.android.gms.internal.measurement.zzbs.zzi> mapZzaf = zzgy().zzaf(str4);
        if (mapZzaf != null && !mapZzaf.isEmpty()) {
            HashSet hashSet2 = new HashSet(mapZzaf.keySet());
            if (!zZzd2 || lValueOf == null) {
                arrayMap19 = mapZzaf;
            } else {
                zzp zzpVarZzgx = zzgx();
                Preconditions.checkNotEmpty(str);
                Preconditions.checkNotNull(mapZzaf);
                arrayMap19 = new ArrayMap<>();
                if (!mapZzaf.isEmpty()) {
                    Map<Integer, List<Integer>> mapZzae = zzpVarZzgx.zzgy().zzae(str4);
                    Iterator<Integer> it8 = mapZzaf.keySet().iterator();
                    while (it8.hasNext()) {
                        int iIntValue2 = it8.next().intValue();
                        com.google.android.gms.internal.measurement.zzbs.zzi zziVar = mapZzaf.get(Integer.valueOf(iIntValue2));
                        List<Integer> list4 = mapZzae.get(Integer.valueOf(iIntValue2));
                        if (list4 == null || list4.isEmpty()) {
                            map11 = mapZzae;
                            it6 = it8;
                            arrayMap19.put(Integer.valueOf(iIntValue2), zziVar);
                        } else {
                            map11 = mapZzae;
                            it6 = it8;
                            List<Long> listZza = zzpVarZzgx.zzgw().zza(zziVar.zzpy(), list4);
                            if (listZza.isEmpty()) {
                                mapZzae = map11;
                                it8 = it6;
                            } else {
                                com.google.android.gms.internal.measurement.zzbs.zzi.zza zzaVarZzo = zziVar.zzuj().zzqr().zzo(listZza);
                                zzaVarZzo.zzqq().zzn(zzpVarZzgx.zzgw().zza(zziVar.zzpv(), list4));
                                for (int i = 0; i < zziVar.zzqc(); i++) {
                                    if (list4.contains(Integer.valueOf(zziVar.zzae(i).getIndex()))) {
                                        zzaVarZzo.zzaj(i);
                                    }
                                }
                                for (int i2 = 0; i2 < zziVar.zzqf(); i2++) {
                                    if (list4.contains(Integer.valueOf(zziVar.zzag(i2).getIndex()))) {
                                        zzaVarZzo.zzak(i2);
                                    }
                                }
                                arrayMap19.put(Integer.valueOf(iIntValue2), (com.google.android.gms.internal.measurement.zzbs.zzi) ((com.google.android.gms.internal.measurement.zzey) zzaVarZzo.zzug()));
                            }
                        }
                        mapZzae = map11;
                        it8 = it6;
                        zzpVarZzgx = zzpVarZzgx;
                    }
                }
            }
            Iterator it9 = hashSet2.iterator();
            while (it9.hasNext()) {
                int iIntValue3 = ((Integer) it9.next()).intValue();
                com.google.android.gms.internal.measurement.zzbs.zzi zziVar2 = arrayMap19.get(Integer.valueOf(iIntValue3));
                BitSet bitSet5 = (BitSet) arrayMap25.get(Integer.valueOf(iIntValue3));
                BitSet bitSet6 = (BitSet) arrayMap26.get(Integer.valueOf(iIntValue3));
                if (zZzq) {
                    arrayMap20 = new ArrayMap();
                    if (zziVar2 != null && zziVar2.zzqc() != 0) {
                        for (com.google.android.gms.internal.measurement.zzbs.zzb zzbVar : zziVar2.zzqb()) {
                            if (zzbVar.zzme()) {
                                arrayMap20.put(Integer.valueOf(zzbVar.getIndex()), zzbVar.zzmf() ? Long.valueOf(zzbVar.zzmg()) : null);
                            } else {
                                arrayMap19 = arrayMap19;
                            }
                            it9 = it9;
                            arrayMap19 = arrayMap19;
                        }
                    }
                    it5 = it9;
                    map10 = arrayMap19;
                    arrayMap27.put(Integer.valueOf(iIntValue3), arrayMap20);
                } else {
                    it5 = it9;
                    map10 = arrayMap19;
                    arrayMap20 = null;
                }
                if (bitSet5 == null) {
                    bitSet5 = new BitSet();
                    arrayMap25.put(Integer.valueOf(iIntValue3), bitSet5);
                    bitSet6 = new BitSet();
                    arrayMap26.put(Integer.valueOf(iIntValue3), bitSet6);
                }
                if (zziVar2 != null) {
                    int i3 = 0;
                    while (i3 < (zziVar2.zzpw() << 6)) {
                        if (zzjo.zza(zziVar2.zzpv(), i3)) {
                            arrayMap21 = arrayMap26;
                            arrayMap22 = arrayMap27;
                            arrayMap23 = arrayMap25;
                            zzab().zzgs().zza("Filter already evaluated. audience ID, filter ID", Integer.valueOf(iIntValue3), Integer.valueOf(i3));
                            bitSet6.set(i3);
                            if (zzjo.zza(zziVar2.zzpy(), i3)) {
                                bitSet5.set(i3);
                                z = true;
                            }
                            if (arrayMap20 == null && !z) {
                                arrayMap20.remove(Integer.valueOf(i3));
                            }
                            i3++;
                            arrayMap26 = arrayMap21;
                            arrayMap27 = arrayMap22;
                            arrayMap25 = arrayMap23;
                        } else {
                            arrayMap21 = arrayMap26;
                            arrayMap22 = arrayMap27;
                            arrayMap23 = arrayMap25;
                        }
                        z = false;
                        if (arrayMap20 == null) {
                        }
                        i3++;
                        arrayMap26 = arrayMap21;
                        arrayMap27 = arrayMap22;
                        arrayMap25 = arrayMap23;
                    }
                }
                ArrayMap arrayMap29 = arrayMap26;
                ArrayMap arrayMap30 = arrayMap27;
                ArrayMap arrayMap31 = arrayMap25;
                com.google.android.gms.internal.measurement.zzbs.zza.C0530zza c0530zzaZzk = com.google.android.gms.internal.measurement.zzbs.zza.zzmc().zzk(false);
                if (zZzd2) {
                    c0530zzaZzk.zza(mapZzaf.get(Integer.valueOf(iIntValue3)));
                } else {
                    c0530zzaZzk.zza(zziVar2);
                }
                com.google.android.gms.internal.measurement.zzbs.zzi.zza zzaVarZzn = com.google.android.gms.internal.measurement.zzbs.zzi.zzqh().zzo(zzjo.zza(bitSet5)).zzn(zzjo.zza(bitSet6));
                if (zZzq) {
                    zzaVarZzn.zzp(zza(arrayMap20));
                    arrayMap28.put(Integer.valueOf(iIntValue3), new ArrayMap());
                }
                c0530zzaZzk.zza(zzaVarZzn);
                arrayMap24.put(Integer.valueOf(iIntValue3), (com.google.android.gms.internal.measurement.zzbs.zza) ((com.google.android.gms.internal.measurement.zzey) c0530zzaZzk.zzug()));
                it9 = it5;
                arrayMap19 = map10;
                arrayMap26 = arrayMap29;
                arrayMap27 = arrayMap30;
                arrayMap25 = arrayMap31;
            }
        }
        ArrayMap arrayMap32 = arrayMap26;
        ArrayMap arrayMap33 = arrayMap27;
        ArrayMap arrayMap34 = arrayMap25;
        if (!list.isEmpty()) {
            ArrayMap arrayMap35 = new ArrayMap();
            long jLongValue = 0;
            Long l3 = null;
            com.google.android.gms.internal.measurement.zzbs.zzc zzcVar2 = null;
            for (com.google.android.gms.internal.measurement.zzbs.zzc zzcVar3 : list) {
                String name = zzcVar3.getName();
                List<com.google.android.gms.internal.measurement.zzbs.zze> listZzmj = zzcVar3.zzmj();
                zzgw();
                Long l4 = (Long) zzjo.zzb(zzcVar3, "_eid");
                boolean z2 = l4 != null;
                if (z2 && name.equals("_ep")) {
                    zzgw();
                    str2 = (String) zzjo.zzb(zzcVar3, "_en");
                    if (TextUtils.isEmpty(str2)) {
                        zzab().zzgk().zza("Extra parameter without an event name. eventId", l4);
                    } else {
                        if (zzcVar2 == null || l3 == null || l4.longValue() != l3.longValue()) {
                            Pair<com.google.android.gms.internal.measurement.zzbs.zzc, Long> pairZza = zzgy().zza(str4, l4);
                            if (pairZza == null || pairZza.first == null) {
                                zzab().zzgk().zza("Extra parameter without existing main event. eventName, eventId", str2, l4);
                            } else {
                                com.google.android.gms.internal.measurement.zzbs.zzc zzcVar4 = (com.google.android.gms.internal.measurement.zzbs.zzc) pairZza.first;
                                jLongValue = ((Long) pairZza.second).longValue();
                                zzgw();
                                zzcVar2 = zzcVar4;
                                l2 = (Long) zzjo.zzb(zzcVar4, "_eid");
                            }
                        } else {
                            l2 = l3;
                        }
                        long j4 = jLongValue - 1;
                        if (j4 <= 0) {
                            zzx zzxVarZzgy2 = zzgy();
                            zzxVarZzgy2.zzo();
                            zzxVarZzgy2.zzab().zzgs().zza("Clearing complex main event info. appId", str4);
                            try {
                                SQLiteDatabase writableDatabase = zzxVarZzgy2.getWritableDatabase();
                                try {
                                    String[] strArr = new String[1];
                                    try {
                                        strArr[0] = str4;
                                        writableDatabase.execSQL("delete from main_event_params where app_id=?", strArr);
                                    } catch (SQLiteException e2) {
                                        e = e2;
                                        zzxVarZzgy2.zzab().zzgk().zza("Error clearing complex main event", e);
                                    }
                                } catch (SQLiteException e3) {
                                    e = e3;
                                    zzxVarZzgy2.zzab().zzgk().zza("Error clearing complex main event", e);
                                    arrayList = new ArrayList();
                                    for (com.google.android.gms.internal.measurement.zzbs.zze zzeVar : zzcVar2.zzmj()) {
                                        zzgw();
                                        if (zzjo.zza(zzcVar3, zzeVar.getName()) == null) {
                                            arrayList.add(zzeVar);
                                        }
                                    }
                                    if (!arrayList.isEmpty()) {
                                        it4 = listZzmj.iterator();
                                        while (it4.hasNext()) {
                                            arrayList.add(it4.next());
                                        }
                                        list3 = arrayList;
                                    } else {
                                        zzab().zzgn().zza("No unique parameters in main event. eventName", str2);
                                        list3 = listZzmj;
                                    }
                                    l = l2;
                                    j = j4;
                                    zzaeVarZzc = zzgy().zzc(str4, zzcVar3.getName());
                                    if (zzaeVarZzc == null) {
                                        zzab().zzgn().zza("Event aggregate wasn't created during raw event logging. appId, event", zzef.zzam(str), zzy().zzaj(str2));
                                        if (zZzd3) {
                                            zzcVar = zzcVar3;
                                            zzaeVar2 = new zzae(str, zzcVar3.getName(), 1L, 1L, 1L, zzcVar.getTimestampMillis(), 0L, null, null, null, null);
                                        } else {
                                            zzcVar = zzcVar3;
                                            zzaeVar2 = new zzae(str, zzcVar.getName(), 1L, 1L, zzcVar.getTimestampMillis(), 0L, null, null, null, null);
                                        }
                                    } else {
                                        zzcVar = zzcVar3;
                                        if (zZzd3) {
                                            zzaeVar = new zzae(zzaeVarZzc.zzce, zzaeVarZzc.name, zzaeVarZzc.zzfg + 1, zzaeVarZzc.zzfh + 1, zzaeVarZzc.zzfi + 1, zzaeVarZzc.zzfj, zzaeVarZzc.zzfk, zzaeVarZzc.zzfl, zzaeVarZzc.zzfm, zzaeVarZzc.zzfn, zzaeVarZzc.zzfo);
                                        } else {
                                            zzaeVar = new zzae(zzaeVarZzc.zzce, zzaeVarZzc.name, zzaeVarZzc.zzfg + 1, zzaeVarZzc.zzfh + 1, zzaeVarZzc.zzfi, zzaeVarZzc.zzfj, zzaeVarZzc.zzfk, zzaeVarZzc.zzfl, zzaeVarZzc.zzfm, zzaeVarZzc.zzfn, zzaeVarZzc.zzfo);
                                        }
                                        zzaeVar2 = zzaeVar;
                                    }
                                    zzgy().zza(zzaeVar2);
                                    j2 = zzaeVar2.zzfg;
                                    arrayMap10 = arrayMap35;
                                    mapZzh = (Map) arrayMap10.get(str2);
                                    if (mapZzh == null) {
                                        mapZzh = zzgy().zzh(str4, str2);
                                        if (mapZzh == null) {
                                            mapZzh = new ArrayMap<>();
                                        }
                                        arrayMap10.put(str2, mapZzh);
                                    }
                                    map = mapZzh;
                                    it2 = map.keySet().iterator();
                                    while (it2.hasNext()) {
                                        iIntValue = it2.next().intValue();
                                        hashSet = hashSet;
                                        if (hashSet.contains(Integer.valueOf(iIntValue))) {
                                            zzab().zzgs().zza("Skipping failed audience ID", Integer.valueOf(iIntValue));
                                        } else {
                                            arrayMap11 = arrayMap34;
                                            bitSet = (BitSet) arrayMap11.get(Integer.valueOf(iIntValue));
                                            bitSet2 = (BitSet) arrayMap32.get(Integer.valueOf(iIntValue));
                                            if (zZzq) {
                                                arrayMap12 = arrayMap33;
                                                Map map12 = (Map) arrayMap12.get(Integer.valueOf(iIntValue));
                                                map2 = (Map) arrayMap28.get(Integer.valueOf(iIntValue));
                                                map3 = map12;
                                            } else {
                                                arrayMap12 = arrayMap33;
                                                map2 = null;
                                                map3 = null;
                                            }
                                            map4 = map2;
                                            arrayMap13 = arrayMap24;
                                            if (((com.google.android.gms.internal.measurement.zzbs.zza) arrayMap13.get(Integer.valueOf(iIntValue))) == null) {
                                                arrayMap13.put(Integer.valueOf(iIntValue), (com.google.android.gms.internal.measurement.zzbs.zza) ((com.google.android.gms.internal.measurement.zzey) com.google.android.gms.internal.measurement.zzbs.zza.zzmc().zzk(true).zzug()));
                                                BitSet bitSet7 = new BitSet();
                                                arrayMap11.put(Integer.valueOf(iIntValue), bitSet7);
                                                bitSet2 = new BitSet();
                                                arrayMap32.put(Integer.valueOf(iIntValue), bitSet2);
                                                if (zZzq) {
                                                    ArrayMap arrayMap36 = new ArrayMap();
                                                    arrayMap12.put(Integer.valueOf(iIntValue), arrayMap36);
                                                    ArrayMap arrayMap37 = new ArrayMap();
                                                    arrayMap28.put(Integer.valueOf(iIntValue), arrayMap37);
                                                    map6 = arrayMap37;
                                                    map5 = arrayMap36;
                                                } else {
                                                    map5 = map3;
                                                    map6 = map4;
                                                }
                                                bitSet3 = bitSet7;
                                            } else {
                                                arrayMap11 = arrayMap11;
                                                bitSet3 = bitSet;
                                                map5 = map3;
                                                map6 = map4;
                                            }
                                            while (r16.hasNext()) {
                                                if (!zZzd3) {
                                                    j3 = j2;
                                                } else {
                                                    j3 = j2;
                                                }
                                                if (zzab().isLoggable(2)) {
                                                    zzeh zzehVarZzgs = zzab().zzgs();
                                                    Integer numValueOf3 = Integer.valueOf(iIntValue);
                                                    if (zzaVar.zzkb()) {
                                                        numValueOf2 = Integer.valueOf(zzaVar.getId());
                                                    } else {
                                                        numValueOf2 = null;
                                                    }
                                                    zzehVarZzgs.zza("Evaluating filter. audience, filter, event", numValueOf3, numValueOf2, zzy().zzaj(zzaVar.zzjz()));
                                                    zzab().zzgs().zza("Filter definition", zzgw().zza(zzaVar));
                                                } else {
                                                    bitSet2 = bitSet2;
                                                    arrayMap28 = arrayMap28;
                                                }
                                                if (zzaVar.zzkb()) {
                                                }
                                                arrayMap14 = arrayMap12;
                                                arrayMap15 = arrayMap13;
                                                map7 = map;
                                                it3 = it2;
                                                arrayMap16 = arrayMap11;
                                                map8 = map6;
                                                map9 = map5;
                                                arrayMap17 = arrayMap32;
                                                bitSet4 = bitSet2;
                                                arrayMap18 = arrayMap28;
                                                str3 = str;
                                                zzeh zzehVarZzgn = zzab().zzgn();
                                                Object objZzam = zzef.zzam(str);
                                                if (zzaVar.zzkb()) {
                                                    numValueOf = Integer.valueOf(zzaVar.getId());
                                                } else {
                                                    numValueOf = null;
                                                }
                                                zzehVarZzgn.zza("Invalid event filter ID. appId, id", objZzam, String.valueOf(numValueOf));
                                                arrayMap11 = arrayMap16;
                                                str4 = str3;
                                                map6 = map8;
                                                bitSet2 = bitSet4;
                                                arrayMap32 = arrayMap17;
                                                map5 = map9;
                                                map = map7;
                                                it2 = it3;
                                                arrayMap13 = arrayMap15;
                                                arrayMap28 = arrayMap18;
                                                arrayMap12 = arrayMap14;
                                            }
                                            arrayMap33 = arrayMap12;
                                            arrayMap24 = arrayMap13;
                                            j2 = j2;
                                            arrayMap10 = arrayMap10;
                                            arrayMap34 = arrayMap11;
                                        }
                                    }
                                    str4 = str4;
                                    arrayMap32 = arrayMap32;
                                    arrayMap28 = arrayMap28;
                                    arrayMap35 = arrayMap10;
                                    jLongValue = j;
                                    zzcVar2 = zzcVar2;
                                    l3 = l;
                                    arrayMap33 = arrayMap33;
                                    arrayMap24 = arrayMap24;
                                    arrayMap34 = arrayMap34;
                                    hashSet = hashSet;
                                }
                            } catch (SQLiteException e4) {
                                e = e4;
                            }
                        } else {
                            zzgy().zza(str, l4, j4, zzcVar2);
                        }
                        arrayList = new ArrayList();
                        while (r1.hasNext()) {
                            zzgw();
                            if (zzjo.zza(zzcVar3, zzeVar.getName()) == null) {
                                arrayList.add(zzeVar);
                            }
                        }
                        if (!arrayList.isEmpty()) {
                            it4 = listZzmj.iterator();
                            while (it4.hasNext()) {
                                arrayList.add(it4.next());
                            }
                            list3 = arrayList;
                        } else {
                            zzab().zzgn().zza("No unique parameters in main event. eventName", str2);
                            list3 = listZzmj;
                        }
                        l = l2;
                        j = j4;
                    }
                    hashSet = hashSet;
                } else {
                    hashSet = hashSet;
                    zzcVar3 = zzcVar3;
                    if (z2) {
                        zzgw();
                        Object objZzb = zzjo.zzb(zzcVar3, "_epc");
                        if (objZzb == null) {
                            objZzb = 0L;
                        }
                        long jLongValue2 = ((Long) objZzb).longValue();
                        if (jLongValue2 <= 0) {
                            zzab().zzgn().zza("Complex event with zero extra param count. eventName", name);
                        } else {
                            zzgy().zza(str, l4, jLongValue2, zzcVar3);
                        }
                        l = l4;
                        str2 = name;
                        zzcVar2 = zzcVar3;
                        list3 = listZzmj;
                        j = jLongValue2;
                    } else {
                        l = l3;
                        j = jLongValue;
                        zzcVar2 = zzcVar2;
                        str2 = name;
                        list3 = listZzmj;
                    }
                }
                zzaeVarZzc = zzgy().zzc(str4, zzcVar3.getName());
                if (zzaeVarZzc == null) {
                    zzab().zzgn().zza("Event aggregate wasn't created during raw event logging. appId, event", zzef.zzam(str), zzy().zzaj(str2));
                    if (zZzd3) {
                        zzcVar = zzcVar3;
                        zzaeVar2 = new zzae(str, zzcVar3.getName(), 1L, 1L, 1L, zzcVar.getTimestampMillis(), 0L, null, null, null, null);
                    } else {
                        zzcVar = zzcVar3;
                        zzaeVar2 = new zzae(str, zzcVar.getName(), 1L, 1L, zzcVar.getTimestampMillis(), 0L, null, null, null, null);
                    }
                } else {
                    zzcVar = zzcVar3;
                    if (zZzd3) {
                        zzaeVar = new zzae(zzaeVarZzc.zzce, zzaeVarZzc.name, zzaeVarZzc.zzfg + 1, zzaeVarZzc.zzfh + 1, zzaeVarZzc.zzfi + 1, zzaeVarZzc.zzfj, zzaeVarZzc.zzfk, zzaeVarZzc.zzfl, zzaeVarZzc.zzfm, zzaeVarZzc.zzfn, zzaeVarZzc.zzfo);
                    } else {
                        zzaeVar = new zzae(zzaeVarZzc.zzce, zzaeVarZzc.name, zzaeVarZzc.zzfg + 1, zzaeVarZzc.zzfh + 1, zzaeVarZzc.zzfi, zzaeVarZzc.zzfj, zzaeVarZzc.zzfk, zzaeVarZzc.zzfl, zzaeVarZzc.zzfm, zzaeVarZzc.zzfn, zzaeVarZzc.zzfo);
                    }
                    zzaeVar2 = zzaeVar;
                }
                zzgy().zza(zzaeVar2);
                j2 = zzaeVar2.zzfg;
                arrayMap10 = arrayMap35;
                mapZzh = (Map) arrayMap10.get(str2);
                if (mapZzh == null) {
                    mapZzh = zzgy().zzh(str4, str2);
                    if (mapZzh == null) {
                        mapZzh = new ArrayMap<>();
                    }
                    arrayMap10.put(str2, mapZzh);
                }
                map = mapZzh;
                it2 = map.keySet().iterator();
                while (it2.hasNext()) {
                    iIntValue = it2.next().intValue();
                    hashSet = hashSet;
                    if (hashSet.contains(Integer.valueOf(iIntValue))) {
                        zzab().zzgs().zza("Skipping failed audience ID", Integer.valueOf(iIntValue));
                    } else {
                        arrayMap11 = arrayMap34;
                        bitSet = (BitSet) arrayMap11.get(Integer.valueOf(iIntValue));
                        bitSet2 = (BitSet) arrayMap32.get(Integer.valueOf(iIntValue));
                        if (zZzq) {
                            arrayMap12 = arrayMap33;
                            Map map13 = (Map) arrayMap12.get(Integer.valueOf(iIntValue));
                            map2 = (Map) arrayMap28.get(Integer.valueOf(iIntValue));
                            map3 = map13;
                        } else {
                            arrayMap12 = arrayMap33;
                            map2 = null;
                            map3 = null;
                        }
                        map4 = map2;
                        arrayMap13 = arrayMap24;
                        if (((com.google.android.gms.internal.measurement.zzbs.zza) arrayMap13.get(Integer.valueOf(iIntValue))) == null) {
                            arrayMap13.put(Integer.valueOf(iIntValue), (com.google.android.gms.internal.measurement.zzbs.zza) ((com.google.android.gms.internal.measurement.zzey) com.google.android.gms.internal.measurement.zzbs.zza.zzmc().zzk(true).zzug()));
                            BitSet bitSet8 = new BitSet();
                            arrayMap11.put(Integer.valueOf(iIntValue), bitSet8);
                            bitSet2 = new BitSet();
                            arrayMap32.put(Integer.valueOf(iIntValue), bitSet2);
                            if (zZzq) {
                                ArrayMap arrayMap38 = new ArrayMap();
                                arrayMap12.put(Integer.valueOf(iIntValue), arrayMap38);
                                ArrayMap arrayMap39 = new ArrayMap();
                                arrayMap28.put(Integer.valueOf(iIntValue), arrayMap39);
                                map6 = arrayMap39;
                                map5 = arrayMap38;
                            } else {
                                map5 = map3;
                                map6 = map4;
                            }
                            bitSet3 = bitSet8;
                        } else {
                            arrayMap11 = arrayMap11;
                            bitSet3 = bitSet;
                            map5 = map3;
                            map6 = map4;
                        }
                        for (com.google.android.gms.internal.measurement.zzbk.zza zzaVar : map.get(Integer.valueOf(iIntValue))) {
                            if (!zZzd3 && zZzd2 && zzaVar.zzki()) {
                                j3 = zzaeVar2.zzfi;
                            } else {
                                j3 = j2;
                            }
                            if (zzab().isLoggable(2)) {
                                zzeh zzehVarZzgs2 = zzab().zzgs();
                                Integer numValueOf4 = Integer.valueOf(iIntValue);
                                if (zzaVar.zzkb()) {
                                    numValueOf2 = Integer.valueOf(zzaVar.getId());
                                } else {
                                    numValueOf2 = null;
                                }
                                zzehVarZzgs2.zza("Evaluating filter. audience, filter, event", numValueOf4, numValueOf2, zzy().zzaj(zzaVar.zzjz()));
                                zzab().zzgs().zza("Filter definition", zzgw().zza(zzaVar));
                            } else {
                                bitSet2 = bitSet2;
                                arrayMap28 = arrayMap28;
                            }
                            if (zzaVar.zzkb() || zzaVar.getId() > 256) {
                                arrayMap14 = arrayMap12;
                                arrayMap15 = arrayMap13;
                                map7 = map;
                                it3 = it2;
                                arrayMap16 = arrayMap11;
                                map8 = map6;
                                map9 = map5;
                                arrayMap17 = arrayMap32;
                                bitSet4 = bitSet2;
                                arrayMap18 = arrayMap28;
                                str3 = str;
                                zzeh zzehVarZzgn2 = zzab().zzgn();
                                Object objZzam2 = zzef.zzam(str);
                                if (zzaVar.zzkb()) {
                                    numValueOf = Integer.valueOf(zzaVar.getId());
                                } else {
                                    numValueOf = null;
                                }
                                zzehVarZzgn2.zza("Invalid event filter ID. appId, id", objZzam2, String.valueOf(numValueOf));
                                arrayMap11 = arrayMap16;
                                str4 = str3;
                                map6 = map8;
                                bitSet2 = bitSet4;
                                arrayMap32 = arrayMap17;
                                map5 = map9;
                                map = map7;
                                it2 = it3;
                                arrayMap13 = arrayMap15;
                                arrayMap28 = arrayMap18;
                                arrayMap12 = arrayMap14;
                            } else {
                                if (zZzq) {
                                    boolean zZzkf = zzaVar.zzkf();
                                    boolean zZzkg = zzaVar.zzkg();
                                    boolean z3 = zZzkf || zZzkg || (zZzd2 && zzaVar.zzki());
                                    if (bitSet3.get(zzaVar.getId()) && !z3) {
                                        zzab().zzgs().zza("Event filter already evaluated true and it is not associated with an enhanced audience. audience ID, filter ID", Integer.valueOf(iIntValue), zzaVar.zzkb() ? Integer.valueOf(zzaVar.getId()) : null);
                                        map5 = map5;
                                        arrayMap32 = arrayMap32;
                                        bitSet2 = bitSet2;
                                        arrayMap28 = arrayMap28;
                                        str4 = str;
                                    } else {
                                        map7 = map;
                                        str3 = str;
                                        it3 = it2;
                                        arrayMap17 = arrayMap32;
                                        map9 = map5;
                                        arrayMap16 = arrayMap11;
                                        arrayMap14 = arrayMap12;
                                        arrayMap15 = arrayMap13;
                                        bitSet4 = bitSet2;
                                        arrayMap18 = arrayMap28;
                                        map8 = map6;
                                        Boolean boolZza = zza(zzaVar, str2, list3, j3);
                                        zzab().zzgs().zza("Event filter result", boolZza == null ? "null" : boolZza);
                                        if (boolZza == null) {
                                            hashSet.add(Integer.valueOf(iIntValue));
                                        } else {
                                            bitSet4.set(zzaVar.getId());
                                            if (boolZza.booleanValue()) {
                                                bitSet3.set(zzaVar.getId());
                                                if (z3 && zzcVar.zzml()) {
                                                    if (zZzkg) {
                                                        zzb(map8, zzaVar.getId(), zzcVar.getTimestampMillis());
                                                    } else {
                                                        zza((Map<Integer, Long>) map9, zzaVar.getId(), zzcVar.getTimestampMillis());
                                                    }
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    arrayMap14 = arrayMap12;
                                    arrayMap15 = arrayMap13;
                                    map7 = map;
                                    it3 = it2;
                                    arrayMap16 = arrayMap11;
                                    map8 = map6;
                                    map9 = map5;
                                    arrayMap17 = arrayMap32;
                                    bitSet4 = bitSet2;
                                    arrayMap18 = arrayMap28;
                                    str3 = str;
                                    if (bitSet3.get(zzaVar.getId())) {
                                        zzab().zzgs().zza("Event filter already evaluated true. audience ID, filter ID", Integer.valueOf(iIntValue), zzaVar.zzkb() ? Integer.valueOf(zzaVar.getId()) : null);
                                    } else {
                                        Boolean boolZza2 = zza(zzaVar, str2, list3, j3);
                                        zzab().zzgs().zza("Event filter result", boolZza2 == null ? "null" : boolZza2);
                                        if (boolZza2 == null) {
                                            hashSet.add(Integer.valueOf(iIntValue));
                                        } else {
                                            bitSet4.set(zzaVar.getId());
                                            if (boolZza2.booleanValue()) {
                                                bitSet3.set(zzaVar.getId());
                                            }
                                        }
                                    }
                                }
                                arrayMap11 = arrayMap16;
                                str4 = str3;
                                map6 = map8;
                                bitSet2 = bitSet4;
                                arrayMap32 = arrayMap17;
                                map5 = map9;
                                map = map7;
                                it2 = it3;
                                arrayMap13 = arrayMap15;
                                arrayMap28 = arrayMap18;
                                arrayMap12 = arrayMap14;
                            }
                        }
                        arrayMap33 = arrayMap12;
                        arrayMap24 = arrayMap13;
                        j2 = j2;
                        arrayMap10 = arrayMap10;
                        arrayMap34 = arrayMap11;
                    }
                }
                str4 = str4;
                arrayMap32 = arrayMap32;
                arrayMap28 = arrayMap28;
                arrayMap35 = arrayMap10;
                jLongValue = j;
                zzcVar2 = zzcVar2;
                l3 = l;
                arrayMap33 = arrayMap33;
                arrayMap24 = arrayMap24;
                arrayMap34 = arrayMap34;
                hashSet = hashSet;
            }
        }
        String str5 = str4;
        ArrayMap arrayMap40 = arrayMap28;
        ArrayMap arrayMap41 = arrayMap24;
        ArrayMap arrayMap42 = arrayMap32;
        ArrayMap arrayMap43 = arrayMap33;
        ArrayMap arrayMap44 = arrayMap34;
        if (!list2.isEmpty()) {
            ArrayMap arrayMap45 = new ArrayMap();
            Iterator<com.google.android.gms.internal.measurement.zzbs.zzk> it10 = list2.iterator();
            while (it10.hasNext()) {
                com.google.android.gms.internal.measurement.zzbs.zzk next2 = it10.next();
                Map<Integer, List<com.google.android.gms.internal.measurement.zzbk.zzd>> mapZzi = (Map) arrayMap45.get(next2.getName());
                if (mapZzi == null) {
                    mapZzi = zzgy().zzi(str5, next2.getName());
                    if (mapZzi == null) {
                        mapZzi = new ArrayMap<>();
                    }
                    arrayMap45.put(next2.getName(), mapZzi);
                }
                Iterator<Integer> it11 = mapZzi.keySet().iterator();
                while (it11.hasNext()) {
                    int iIntValue4 = it11.next().intValue();
                    if (hashSet.contains(Integer.valueOf(iIntValue4))) {
                        zzab().zzgs().zza("Skipping failed audience ID", Integer.valueOf(iIntValue4));
                    } else {
                        BitSet bitSet9 = (BitSet) arrayMap44.get(Integer.valueOf(iIntValue4));
                        BitSet bitSet10 = (BitSet) arrayMap42.get(Integer.valueOf(iIntValue4));
                        if (zZzq) {
                            arrayMap5 = arrayMap43;
                            arrayMap6 = (Map) arrayMap5.get(Integer.valueOf(iIntValue4));
                            arrayMap4 = arrayMap40;
                            arrayMap7 = (Map) arrayMap4.get(Integer.valueOf(iIntValue4));
                        } else {
                            arrayMap4 = arrayMap40;
                            arrayMap5 = arrayMap43;
                            arrayMap6 = null;
                            arrayMap7 = null;
                        }
                        it10 = it10;
                        ArrayMap arrayMap46 = arrayMap41;
                        if (((com.google.android.gms.internal.measurement.zzbs.zza) arrayMap46.get(Integer.valueOf(iIntValue4))) == null) {
                            arrayMap46.put(Integer.valueOf(iIntValue4), (com.google.android.gms.internal.measurement.zzbs.zza) ((com.google.android.gms.internal.measurement.zzey) com.google.android.gms.internal.measurement.zzbs.zza.zzmc().zzk(true).zzug()));
                            bitSet9 = new BitSet();
                            arrayMap44.put(Integer.valueOf(iIntValue4), bitSet9);
                            bitSet10 = new BitSet();
                            arrayMap42.put(Integer.valueOf(iIntValue4), bitSet10);
                            if (zZzq) {
                                arrayMap6 = new ArrayMap();
                                arrayMap5.put(Integer.valueOf(iIntValue4), arrayMap6);
                                arrayMap7 = new ArrayMap();
                                arrayMap4.put(Integer.valueOf(iIntValue4), arrayMap7);
                            }
                        }
                        Iterator<com.google.android.gms.internal.measurement.zzbk.zzd> it12 = mapZzi.get(Integer.valueOf(iIntValue4)).iterator();
                        while (true) {
                            if (!it12.hasNext()) {
                                arrayMap41 = arrayMap46;
                                arrayMap40 = arrayMap4;
                                arrayMap43 = arrayMap5;
                                break;
                            }
                            it12 = it12;
                            com.google.android.gms.internal.measurement.zzbk.zzd next3 = it12.next();
                            mapZzi = mapZzi;
                            it11 = it11;
                            if (zzab().isLoggable(2)) {
                                zzab().zzgs().zza("Evaluating filter. audience, filter, property", Integer.valueOf(iIntValue4), next3.zzkb() ? Integer.valueOf(next3.getId()) : null, zzy().zzal(next3.getPropertyName()));
                                zzab().zzgs().zza("Filter definition", zzgw().zza(next3));
                            } else {
                                arrayMap4 = arrayMap4;
                            }
                            if (!next3.zzkb() || next3.getId() > 256) {
                                ArrayMap arrayMap47 = arrayMap46;
                                ArrayMap arrayMap48 = arrayMap42;
                                ArrayMap arrayMap49 = arrayMap44;
                                zzab().zzgn().zza("Invalid property filter ID. appId, id", zzef.zzam(str), String.valueOf(next3.zzkb() ? Integer.valueOf(next3.getId()) : null));
                                hashSet.add(Integer.valueOf(iIntValue4));
                                arrayMap44 = arrayMap49;
                                mapZzi = mapZzi;
                                it11 = it11;
                                arrayMap40 = arrayMap4;
                                arrayMap43 = arrayMap5;
                                arrayMap42 = arrayMap48;
                                arrayMap41 = arrayMap47;
                                break;
                            }
                            if (zZzq) {
                                boolean zZzkf2 = next3.zzkf();
                                boolean zZzkg2 = next3.zzkg();
                                boolean z4 = zZzd2 && next3.zzki();
                                boolean z5 = zZzkf2 || zZzkg2 || z4;
                                if (bitSet9.get(next3.getId()) && !z5) {
                                    zzab().zzgs().zza("Property filter already evaluated true and it is not associated with an enhanced audience. audience ID, filter ID", Integer.valueOf(iIntValue4), next3.zzkb() ? Integer.valueOf(next3.getId()) : null);
                                    arrayMap44 = arrayMap44;
                                } else {
                                    arrayMap9 = arrayMap44;
                                    Boolean boolZza3 = zza(next3, next2);
                                    arrayMap8 = arrayMap42;
                                    zzab().zzgs().zza("Property filter result", boolZza3 == null ? "null" : boolZza3);
                                    if (boolZza3 == null) {
                                        hashSet.add(Integer.valueOf(iIntValue4));
                                    } else {
                                        bitSet10.set(next3.getId());
                                        if (!zZzd2 || !z4 || boolZza3.booleanValue()) {
                                            if (!zZzd || !bitSet9.get(next3.getId()) || next3.zzkf()) {
                                                bitSet9.set(next3.getId(), boolZza3.booleanValue());
                                            }
                                            if (boolZza3.booleanValue() && z5 && next2.zzqs()) {
                                                long jZzqt = next2.zzqt();
                                                if (zZzd2 && z4 && lValueOf != null) {
                                                    jZzqt = lValueOf.longValue();
                                                }
                                                if (zZzkg2) {
                                                    zzb(arrayMap7, next3.getId(), jZzqt);
                                                } else {
                                                    zza((Map<Integer, Long>) arrayMap6, next3.getId(), jZzqt);
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                arrayMap46 = arrayMap46;
                                arrayMap8 = arrayMap42;
                                arrayMap9 = arrayMap44;
                                if (bitSet9.get(next3.getId())) {
                                    zzab().zzgs().zza("Property filter already evaluated true. audience ID, filter ID", Integer.valueOf(iIntValue4), next3.zzkb() ? Integer.valueOf(next3.getId()) : null);
                                } else {
                                    Boolean boolZza4 = zza(next3, next2);
                                    zzab().zzgs().zza("Property filter result", boolZza4 == null ? "null" : boolZza4);
                                    if (boolZza4 == null) {
                                        hashSet.add(Integer.valueOf(iIntValue4));
                                    } else {
                                        bitSet10.set(next3.getId());
                                        if (boolZza4.booleanValue()) {
                                            bitSet9.set(next3.getId());
                                        }
                                    }
                                }
                            }
                            arrayMap44 = arrayMap9;
                            arrayMap42 = arrayMap8;
                            arrayMap46 = arrayMap46;
                        }
                    }
                }
                str5 = str;
            }
        }
        ArrayMap arrayMap50 = arrayMap44;
        ArrayMap arrayMap51 = arrayMap42;
        ArrayMap arrayMap52 = arrayMap41;
        ArrayMap arrayMap53 = arrayMap40;
        ArrayMap arrayMap54 = arrayMap43;
        ArrayList arrayList2 = new ArrayList();
        Iterator it13 = arrayMap50.keySet().iterator();
        while (it13.hasNext()) {
            int iIntValue5 = ((Integer) it13.next()).intValue();
            if (!hashSet.contains(Integer.valueOf(iIntValue5))) {
                ArrayMap arrayMap55 = arrayMap52;
                com.google.android.gms.internal.measurement.zzbs.zza zzaVar2 = (com.google.android.gms.internal.measurement.zzbs.zza) arrayMap55.get(Integer.valueOf(iIntValue5));
                if (zzaVar2 == null) {
                    c0530zzaZzuj = com.google.android.gms.internal.measurement.zzbs.zza.zzmc();
                } else {
                    c0530zzaZzuj = zzaVar2.zzuj();
                }
                c0530zzaZzuj.zzi(iIntValue5);
                ArrayMap arrayMap56 = arrayMap51;
                com.google.android.gms.internal.measurement.zzbs.zzi.zza zzaVarZzn2 = com.google.android.gms.internal.measurement.zzbs.zzi.zzqh().zzo(zzjo.zza((BitSet) arrayMap50.get(Integer.valueOf(iIntValue5)))).zzn(zzjo.zza((BitSet) arrayMap56.get(Integer.valueOf(iIntValue5))));
                if (zZzq) {
                    ArrayMap arrayMap57 = arrayMap54;
                    zzaVarZzn2.zzp(zza((Map) arrayMap57.get(Integer.valueOf(iIntValue5))));
                    ArrayMap arrayMap58 = arrayMap53;
                    Map map14 = (Map) arrayMap58.get(Integer.valueOf(iIntValue5));
                    if (map14 == null) {
                        listEmptyList = Collections.emptyList();
                        it = it13;
                        arrayMap = arrayMap56;
                    } else {
                        ArrayList arrayList3 = new ArrayList(map14.size());
                        for (Integer num : map14.keySet()) {
                            Iterator it14 = it13;
                            ArrayMap arrayMap59 = arrayMap56;
                            com.google.android.gms.internal.measurement.zzbs.zzj.zza zzaVarZzal = com.google.android.gms.internal.measurement.zzbs.zzj.zzqo().zzal(num.intValue());
                            List list5 = (List) map14.get(num);
                            if (list5 != null) {
                                Collections.sort(list5);
                                for (Iterator it15 = list5.iterator(); it15.hasNext(); it15 = it15) {
                                    zzaVarZzal.zzbj(((Long) it15.next()).longValue());
                                    map14 = map14;
                                }
                            }
                            arrayList3.add((com.google.android.gms.internal.measurement.zzbs.zzj) ((com.google.android.gms.internal.measurement.zzey) zzaVarZzal.zzug()));
                            it13 = it14;
                            arrayMap56 = arrayMap59;
                            map14 = map14;
                        }
                        it = it13;
                        arrayMap = arrayMap56;
                        listEmptyList = arrayList3;
                    }
                    if (zZzd && c0530zzaZzuj.zzlw()) {
                        List<com.google.android.gms.internal.measurement.zzbs.zzj> listZzqe = c0530zzaZzuj.zzlx().zzqe();
                        if (listZzqe.isEmpty()) {
                            arrayMap3 = arrayMap57;
                            arrayMap2 = arrayMap58;
                        } else {
                            ArrayList arrayList4 = new ArrayList(listEmptyList);
                            ArrayMap arrayMap60 = new ArrayMap();
                            for (com.google.android.gms.internal.measurement.zzbs.zzj zzjVar : listZzqe) {
                                if (zzjVar.zzme() && zzjVar.zzql() > 0) {
                                    arrayMap60.put(Integer.valueOf(zzjVar.getIndex()), Long.valueOf(zzjVar.zzai(zzjVar.zzql() - 1)));
                                }
                            }
                            int i4 = 0;
                            while (i4 < arrayList4.size()) {
                                com.google.android.gms.internal.measurement.zzbs.zzj zzjVar2 = (com.google.android.gms.internal.measurement.zzbs.zzj) arrayList4.get(i4);
                                Long l5 = (Long) arrayMap60.remove(zzjVar2.zzme() ? Integer.valueOf(zzjVar2.getIndex()) : null);
                                if (l5 != null) {
                                    ArrayList arrayList5 = new ArrayList();
                                    if (l5.longValue() < zzjVar2.zzai(0)) {
                                        arrayList5.add(l5);
                                    }
                                    arrayList5.addAll(zzjVar2.zzqk());
                                    arrayList4.set(i4, (com.google.android.gms.internal.measurement.zzbs.zzj) ((com.google.android.gms.internal.measurement.zzey) zzjVar2.zzuj().zzqw().zzr(arrayList5).zzug()));
                                }
                                i4++;
                                arrayMap57 = arrayMap57;
                            }
                            arrayMap3 = arrayMap57;
                            for (Integer num2 : arrayMap60.keySet()) {
                                arrayList4.add((com.google.android.gms.internal.measurement.zzbs.zzj) ((com.google.android.gms.internal.measurement.zzey) com.google.android.gms.internal.measurement.zzbs.zzj.zzqo().zzal(num2.intValue()).zzbj(((Long) arrayMap60.get(num2)).longValue()).zzug()));
                                arrayMap58 = arrayMap58;
                            }
                            arrayMap2 = arrayMap58;
                            listEmptyList = arrayList4;
                        }
                    } else {
                        arrayMap3 = arrayMap57;
                        arrayMap2 = arrayMap58;
                    }
                    zzaVarZzn2.zzq(listEmptyList);
                } else {
                    it = it13;
                    arrayMap = arrayMap56;
                    arrayMap2 = arrayMap53;
                    arrayMap3 = arrayMap54;
                }
                c0530zzaZzuj.zza(zzaVarZzn2);
                arrayMap55.put(Integer.valueOf(iIntValue5), (com.google.android.gms.internal.measurement.zzbs.zza) ((com.google.android.gms.internal.measurement.zzey) c0530zzaZzuj.zzug()));
                arrayList2.add((com.google.android.gms.internal.measurement.zzbs.zza) ((com.google.android.gms.internal.measurement.zzey) c0530zzaZzuj.zzug()));
                zzx zzxVarZzgy3 = zzgy();
                com.google.android.gms.internal.measurement.zzbs.zzi zziVarZzlv = c0530zzaZzuj.zzlv();
                zzxVarZzgy3.zzbi();
                zzxVarZzgy3.zzo();
                Preconditions.checkNotEmpty(str);
                Preconditions.checkNotNull(zziVarZzlv);
                byte[] byteArray = zziVarZzlv.toByteArray();
                ContentValues contentValues2 = new ContentValues();
                contentValues2.put("app_id", str);
                contentValues2.put("audience_id", Integer.valueOf(iIntValue5));
                contentValues2.put("current_results", byteArray);
                try {
                    try {
                        if (zzxVarZzgy3.getWritableDatabase().insertWithOnConflict("audience_filter_values", null, contentValues2, 5) == -1) {
                            zzxVarZzgy3.zzab().zzgk().zza("Failed to insert filter results (got -1). appId", zzef.zzam(str));
                        }
                    } catch (SQLiteException e5) {
                        e = e5;
                        zzxVarZzgy3.zzab().zzgk().zza("Error storing filter results. appId", zzef.zzam(str), e);
                    }
                } catch (SQLiteException e6) {
                    e = e6;
                }
                arrayMap52 = arrayMap55;
                it13 = it;
                arrayMap51 = arrayMap;
                arrayMap54 = arrayMap3;
                arrayMap53 = arrayMap2;
            }
        }
        return arrayList2;
    }

    /* JADX WARN: Multi-variable type inference failed */
    private final Boolean zza(com.google.android.gms.internal.measurement.zzbk.zza zzaVar, String str, List<com.google.android.gms.internal.measurement.zzbs.zze> list, long j) {
        Boolean boolZza;
        if (zzaVar.zzkd()) {
            Boolean boolZza2 = zza(j, zzaVar.zzke());
            if (boolZza2 == null) {
                return null;
            }
            if (!boolZza2.booleanValue()) {
                return false;
            }
        }
        HashSet hashSet = new HashSet();
        for (com.google.android.gms.internal.measurement.zzbk.zzb zzbVar : zzaVar.zzkc()) {
            if (zzbVar.zzkr().isEmpty()) {
                zzab().zzgn().zza("null or empty param name in filter. event", zzy().zzaj(str));
                return null;
            }
            hashSet.add(zzbVar.zzkr());
        }
        ArrayMap arrayMap = new ArrayMap();
        for (com.google.android.gms.internal.measurement.zzbs.zze zzeVar : list) {
            if (hashSet.contains(zzeVar.getName())) {
                if (zzeVar.zzna()) {
                    arrayMap.put(zzeVar.getName(), zzeVar.zzna() ? Long.valueOf(zzeVar.zznb()) : null);
                } else if (zzeVar.zznd()) {
                    arrayMap.put(zzeVar.getName(), zzeVar.zznd() ? Double.valueOf(zzeVar.zzne()) : null);
                } else if (zzeVar.zzmx()) {
                    arrayMap.put(zzeVar.getName(), zzeVar.zzmy());
                } else {
                    zzab().zzgn().zza("Unknown value for param. event, param", zzy().zzaj(str), zzy().zzak(zzeVar.getName()));
                    return null;
                }
            }
        }
        Iterator<com.google.android.gms.internal.measurement.zzbk.zzb> it = zzaVar.zzkc().iterator();
        while (true) {
            if (it.hasNext()) {
                com.google.android.gms.internal.measurement.zzbk.zzb next = it.next();
                boolean z = next.zzkp() && next.zzkq();
                String strZzkr = next.zzkr();
                if (strZzkr.isEmpty()) {
                    zzab().zzgn().zza("Event has empty param name. event", zzy().zzaj(str));
                    return null;
                }
                V v = arrayMap.get(strZzkr);
                if (v instanceof Long) {
                    if (!next.zzkn()) {
                        zzab().zzgn().zza("No number filter for long param. event, param", zzy().zzaj(str), zzy().zzak(strZzkr));
                        return null;
                    }
                    Boolean boolZza3 = zza(((Long) v).longValue(), next.zzko());
                    if (boolZza3 == null) {
                        return null;
                    }
                    if (boolZza3.booleanValue() == z) {
                        return false;
                    }
                } else if (v instanceof Double) {
                    if (!next.zzkn()) {
                        zzab().zzgn().zza("No number filter for double param. event, param", zzy().zzaj(str), zzy().zzak(strZzkr));
                        return null;
                    }
                    Boolean boolZza4 = zza(((Double) v).doubleValue(), next.zzko());
                    if (boolZza4 == null) {
                        return null;
                    }
                    if (boolZza4.booleanValue() == z) {
                        return false;
                    }
                } else {
                    if (!(v instanceof String)) {
                        if (v == 0) {
                            zzab().zzgs().zza("Missing param for filter. event, param", zzy().zzaj(str), zzy().zzak(strZzkr));
                            return false;
                        }
                        zzab().zzgn().zza("Unknown param type. event, param", zzy().zzaj(str), zzy().zzak(strZzkr));
                        return null;
                    }
                    if (next.zzkl()) {
                        boolZza = zza((String) v, next.zzkm());
                    } else if (next.zzkn()) {
                        String str2 = (String) v;
                        if (zzjo.zzbj(str2)) {
                            boolZza = zza(str2, next.zzko());
                        } else {
                            zzab().zzgn().zza("Invalid param value for number filter. event, param", zzy().zzaj(str), zzy().zzak(strZzkr));
                            return null;
                        }
                    } else {
                        zzab().zzgn().zza("No filter for String param. event, param", zzy().zzaj(str), zzy().zzak(strZzkr));
                        return null;
                    }
                    if (boolZza == null) {
                        return null;
                    }
                    if (boolZza.booleanValue() == z) {
                        return false;
                    }
                }
            } else {
                return true;
            }
        }
    }

    private final Boolean zza(com.google.android.gms.internal.measurement.zzbk.zzd zzdVar, com.google.android.gms.internal.measurement.zzbs.zzk zzkVar) {
        com.google.android.gms.internal.measurement.zzbk.zzb zzbVarZzli = zzdVar.zzli();
        boolean zZzkq = zzbVarZzli.zzkq();
        if (zzkVar.zzna()) {
            if (!zzbVarZzli.zzkn()) {
                zzab().zzgn().zza("No number filter for long property. property", zzy().zzal(zzkVar.getName()));
                return null;
            }
            return zza(zza(zzkVar.zznb(), zzbVarZzli.zzko()), zZzkq);
        }
        if (zzkVar.zznd()) {
            if (!zzbVarZzli.zzkn()) {
                zzab().zzgn().zza("No number filter for double property. property", zzy().zzal(zzkVar.getName()));
                return null;
            }
            return zza(zza(zzkVar.zzne(), zzbVarZzli.zzko()), zZzkq);
        }
        if (zzkVar.zzmx()) {
            if (!zzbVarZzli.zzkl()) {
                if (!zzbVarZzli.zzkn()) {
                    zzab().zzgn().zza("No string or number filter defined. property", zzy().zzal(zzkVar.getName()));
                } else {
                    if (zzjo.zzbj(zzkVar.zzmy())) {
                        return zza(zza(zzkVar.zzmy(), zzbVarZzli.zzko()), zZzkq);
                    }
                    zzab().zzgn().zza("Invalid user property value for Numeric number filter. property, value", zzy().zzal(zzkVar.getName()), zzkVar.zzmy());
                }
                return null;
            }
            return zza(zza(zzkVar.zzmy(), zzbVarZzli.zzkm()), zZzkq);
        }
        zzab().zzgn().zza("User property has no value, property", zzy().zzal(zzkVar.getName()));
        return null;
    }

    @VisibleForTesting
    private static Boolean zza(Boolean bool, boolean z) {
        if (bool == null) {
            return null;
        }
        return Boolean.valueOf(bool.booleanValue() != z);
    }

    @VisibleForTesting
    private final Boolean zza(String str, com.google.android.gms.internal.measurement.zzbk.zze zzeVar) {
        String strZzln;
        List<String> list;
        Preconditions.checkNotNull(zzeVar);
        if (str == null || !zzeVar.zzlk() || zzeVar.zzll() == com.google.android.gms.internal.measurement.zzbk.zze.zza.UNKNOWN_MATCH_TYPE) {
            return null;
        }
        if (zzeVar.zzll() == com.google.android.gms.internal.measurement.zzbk.zze.zza.IN_LIST) {
            if (zzeVar.zzlr() == 0) {
                return null;
            }
        } else if (!zzeVar.zzlm()) {
            return null;
        }
        com.google.android.gms.internal.measurement.zzbk.zze.zza zzaVarZzll = zzeVar.zzll();
        boolean zZzlp = zzeVar.zzlp();
        if (zZzlp || zzaVarZzll == com.google.android.gms.internal.measurement.zzbk.zze.zza.REGEXP || zzaVarZzll == com.google.android.gms.internal.measurement.zzbk.zze.zza.IN_LIST) {
            strZzln = zzeVar.zzln();
        } else {
            strZzln = zzeVar.zzln().toUpperCase(Locale.ENGLISH);
        }
        String str2 = strZzln;
        if (zzeVar.zzlr() == 0) {
            list = null;
        } else {
            List<String> listZzlq = zzeVar.zzlq();
            if (!zZzlp) {
                ArrayList arrayList = new ArrayList(listZzlq.size());
                Iterator<String> it = listZzlq.iterator();
                while (it.hasNext()) {
                    arrayList.add(it.next().toUpperCase(Locale.ENGLISH));
                }
                listZzlq = Collections.unmodifiableList(arrayList);
            }
            list = listZzlq;
        }
        return zza(str, zzaVarZzll, zZzlp, str2, list, zzaVarZzll == com.google.android.gms.internal.measurement.zzbk.zze.zza.REGEXP ? str2 : null);
    }

    private final Boolean zza(String str, com.google.android.gms.internal.measurement.zzbk.zze.zza zzaVar, boolean z, String str2, List<String> list, String str3) {
        if (str == null) {
            return null;
        }
        if (zzaVar == com.google.android.gms.internal.measurement.zzbk.zze.zza.IN_LIST) {
            if (list == null || list.size() == 0) {
                return null;
            }
        } else if (str2 == null) {
            return null;
        }
        if (!z && zzaVar != com.google.android.gms.internal.measurement.zzbk.zze.zza.REGEXP) {
            str = str.toUpperCase(Locale.ENGLISH);
        }
        switch (zzo.zzdu[zzaVar.ordinal()]) {
            case 1:
                try {
                    return Boolean.valueOf(Pattern.compile(str3, z ? 0 : 66).matcher(str).matches());
                } catch (PatternSyntaxException unused) {
                    zzab().zzgn().zza("Invalid regular expression in REGEXP audience filter. expression", str3);
                    return null;
                }
            case 2:
                return Boolean.valueOf(str.startsWith(str2));
            case 3:
                return Boolean.valueOf(str.endsWith(str2));
            case 4:
                return Boolean.valueOf(str.contains(str2));
            case 5:
                return Boolean.valueOf(str.equals(str2));
            case 6:
                return Boolean.valueOf(list.contains(str));
            default:
                return null;
        }
    }

    private final Boolean zza(long j, com.google.android.gms.internal.measurement.zzbk.zzc zzcVar) {
        try {
            return zza(new BigDecimal(j), zzcVar, 0.0d);
        } catch (NumberFormatException unused) {
            return null;
        }
    }

    private final Boolean zza(double d, com.google.android.gms.internal.measurement.zzbk.zzc zzcVar) {
        try {
            return zza(new BigDecimal(d), zzcVar, Math.ulp(d));
        } catch (NumberFormatException unused) {
            return null;
        }
    }

    private final Boolean zza(String str, com.google.android.gms.internal.measurement.zzbk.zzc zzcVar) {
        if (!zzjo.zzbj(str)) {
            return null;
        }
        try {
            return zza(new BigDecimal(str), zzcVar, 0.0d);
        } catch (NumberFormatException unused) {
            return null;
        }
    }

    @VisibleForTesting
    private static Boolean zza(BigDecimal bigDecimal, com.google.android.gms.internal.measurement.zzbk.zzc zzcVar, double d) {
        BigDecimal bigDecimal2;
        BigDecimal bigDecimal3;
        BigDecimal bigDecimal4;
        Preconditions.checkNotNull(zzcVar);
        if (!zzcVar.zzku() || zzcVar.zzkv() == com.google.android.gms.internal.measurement.zzbk.zzc.zzb.UNKNOWN_COMPARISON_TYPE) {
            return null;
        }
        if (zzcVar.zzkv() == com.google.android.gms.internal.measurement.zzbk.zzc.zzb.BETWEEN) {
            if (!zzcVar.zzla() || !zzcVar.zzlc()) {
                return null;
            }
        } else if (!zzcVar.zzky()) {
            return null;
        }
        com.google.android.gms.internal.measurement.zzbk.zzc.zzb zzbVarZzkv = zzcVar.zzkv();
        if (zzcVar.zzkv() == com.google.android.gms.internal.measurement.zzbk.zzc.zzb.BETWEEN) {
            if (!zzjo.zzbj(zzcVar.zzlb()) || !zzjo.zzbj(zzcVar.zzld())) {
                return null;
            }
            try {
                BigDecimal bigDecimal5 = new BigDecimal(zzcVar.zzlb());
                bigDecimal4 = new BigDecimal(zzcVar.zzld());
                bigDecimal3 = bigDecimal5;
                bigDecimal2 = null;
            } catch (NumberFormatException unused) {
                return null;
            }
        } else {
            if (!zzjo.zzbj(zzcVar.zzkz())) {
                return null;
            }
            try {
                bigDecimal2 = new BigDecimal(zzcVar.zzkz());
                bigDecimal3 = null;
                bigDecimal4 = null;
            } catch (NumberFormatException unused2) {
                return null;
            }
        }
        if (zzbVarZzkv != com.google.android.gms.internal.measurement.zzbk.zzc.zzb.BETWEEN) {
            if (bigDecimal2 != null) {
            }
            return null;
        }
        if (bigDecimal3 == null) {
            return null;
        }
        boolean z = false;
        switch (zzo.zzdv[zzbVarZzkv.ordinal()]) {
            case 1:
                return Boolean.valueOf(bigDecimal.compareTo(bigDecimal2) == -1);
            case 2:
                return Boolean.valueOf(bigDecimal.compareTo(bigDecimal2) == 1);
            case 3:
                if (d == 0.0d) {
                    return Boolean.valueOf(bigDecimal.compareTo(bigDecimal2) == 0);
                }
                if (bigDecimal.compareTo(bigDecimal2.subtract(new BigDecimal(d).multiply(new BigDecimal(2)))) == 1 && bigDecimal.compareTo(bigDecimal2.add(new BigDecimal(d).multiply(new BigDecimal(2)))) == -1) {
                    z = true;
                }
                return Boolean.valueOf(z);
            case 4:
                if (bigDecimal.compareTo(bigDecimal3) != -1 && bigDecimal.compareTo(bigDecimal4) != 1) {
                    z = true;
                }
                return Boolean.valueOf(z);
            default:
                return null;
        }
    }

    private static List<com.google.android.gms.internal.measurement.zzbs.zzb> zza(Map<Integer, Long> map) {
        if (map == null) {
            return null;
        }
        ArrayList arrayList = new ArrayList(map.size());
        Iterator<Integer> it = map.keySet().iterator();
        while (it.hasNext()) {
            int iIntValue = it.next().intValue();
            arrayList.add((com.google.android.gms.internal.measurement.zzbs.zzb) ((com.google.android.gms.internal.measurement.zzey) com.google.android.gms.internal.measurement.zzbs.zzb.zzmh().zzk(iIntValue).zzae(map.get(Integer.valueOf(iIntValue)).longValue()).zzug()));
        }
        return arrayList;
    }

    private static void zza(Map<Integer, Long> map, int i, long j) {
        Long l = map.get(Integer.valueOf(i));
        long j2 = j / 1000;
        if (l == null || j2 > l.longValue()) {
            map.put(Integer.valueOf(i), Long.valueOf(j2));
        }
    }

    private static void zzb(Map<Integer, List<Long>> map, int i, long j) {
        List<Long> arrayList = map.get(Integer.valueOf(i));
        if (arrayList == null) {
            arrayList = new ArrayList<>();
            map.put(Integer.valueOf(i), arrayList);
        }
        arrayList.add(Long.valueOf(j / 1000));
    }
}

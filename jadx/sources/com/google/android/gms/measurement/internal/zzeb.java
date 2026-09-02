package com.google.android.gms.measurement.internal;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabaseLockedException;
import android.database.sqlite.SQLiteException;
import android.database.sqlite.SQLiteFullException;
import android.os.Parcel;
import android.os.SystemClock;
import androidx.annotation.WorkerThread;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.util.VisibleForTesting;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class zzeb extends zzg {
    private final zzea zzjv;
    private boolean zzjw;

    zzeb(zzfj zzfjVar) {
        super(zzfjVar);
        this.zzjv = new zzea(this, getContext(), "google_app_measurement_local.db");
    }

    @Override // com.google.android.gms.measurement.internal.zzg
    protected final boolean zzbk() {
        return false;
    }

    @WorkerThread
    public final void resetAnalyticsData() {
        zzm();
        zzo();
        try {
            int iDelete = getWritableDatabase().delete("messages", null, null) + 0;
            if (iDelete > 0) {
                zzab().zzgs().zza("Reset local analytics data. records", Integer.valueOf(iDelete));
            }
        } catch (SQLiteException e) {
            zzab().zzgk().zza("Error resetting local analytics data. error", e);
        }
    }

    /* JADX WARN: Code duplicated, block: B:76:0x0129  */
    /* JADX WARN: Code duplicated, block: B:78:0x012e  */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r12v0 */
    /* JADX WARN: Type inference failed for: r12v1 */
    /* JADX WARN: Type inference failed for: r12v10 */
    /* JADX WARN: Type inference failed for: r12v11 */
    /* JADX WARN: Type inference failed for: r12v2, types: [android.database.Cursor] */
    /* JADX WARN: Type inference failed for: r12v3, types: [android.database.Cursor] */
    /* JADX WARN: Type inference failed for: r12v4 */
    /* JADX WARN: Type inference failed for: r12v5 */
    /* JADX WARN: Type inference failed for: r12v6 */
    /* JADX WARN: Type inference failed for: r12v7, types: [android.database.Cursor] */
    /* JADX WARN: Type inference failed for: r12v8 */
    /* JADX WARN: Type inference failed for: r12v9 */
    /* JADX WARN: Type inference failed for: r2v0 */
    /* JADX WARN: Type inference failed for: r2v1, types: [boolean, int] */
    /* JADX WARN: Type inference failed for: r2v9 */
    /* JADX WARN: Type inference failed for: r7v10 */
    /* JADX WARN: Type inference failed for: r7v2, types: [android.database.Cursor] */
    /* JADX WARN: Type inference failed for: r7v3, types: [android.database.Cursor] */
    /* JADX WARN: Type inference failed for: r7v5 */
    /* JADX WARN: Type inference failed for: r7v6 */
    /* JADX WARN: Type inference failed for: r7v7 */
    /* JADX WARN: Type inference failed for: r7v8 */
    /* JADX WARN: Type inference failed for: r7v9 */
    @WorkerThread
    private final boolean zza(int i, byte[] bArr) throws Throwable {
        SQLiteDatabase writableDatabase;
        ?? r12;
        ?? r13;
        ?? r14;
        zzm();
        zzo();
        ?? r2 = 0;
        if (this.zzjw) {
            return false;
        }
        ContentValues contentValues = new ContentValues();
        contentValues.put("type", Integer.valueOf(i));
        contentValues.put("entry", bArr);
        int i2 = 0;
        int i3 = 5;
        for (int i4 = 5; i2 < i4; i4 = 5) {
            SQLiteDatabase sQLiteDatabase = null;
             = 0;
             = 0;
            ?? r7 = 0;
            ?? r8 = 0;
            try {
                writableDatabase = getWritableDatabase();
                try {
                    if (writableDatabase == null) {
                        this.zzjw = true;
                        if (writableDatabase != null) {
                            writableDatabase.close();
                        }
                        return r2;
                    }
                    writableDatabase.beginTransaction();
                    long j = 0;
                    ?? RawQuery = writableDatabase.rawQuery("select count(1) from messages", null);
                    if (RawQuery != 0) {
                        try {
                            if (RawQuery.moveToFirst()) {
                                j = RawQuery.getLong(r2);
                            }
                        } catch (SQLiteDatabaseLockedException unused) {
                            r7 = RawQuery;
                            SystemClock.sleep(i3);
                            i3 += 20;
                            if (r7 != 0) {
                                r7.close();
                            }
                            if (writableDatabase != null) {
                                writableDatabase.close();
                            }
                            i2++;
                            r2 = 0;
                        } catch (SQLiteFullException e) {
                            e = e;
                            r8 = RawQuery;
                            try {
                                zzab().zzgk().zza("Error writing entry to local database", e);
                                this.zzjw = true;
                                if (r8 != 0) {
                                    r8.close();
                                }
                                if (writableDatabase != null) {
                                    writableDatabase.close();
                                }
                                i2++;
                                r2 = 0;
                            } catch (Throwable th) {
                                th = th;
                                r12 = r8;
                                if (r12 != 0) {
                                    r12.close();
                                }
                                if (writableDatabase != null) {
                                    writableDatabase.close();
                                }
                                throw th;
                            }
                        } catch (SQLiteException e2) {
                            e = e2;
                            r14 = RawQuery;
                            sQLiteDatabase = writableDatabase;
                            r13 = r14;
                            if (sQLiteDatabase != null) {
                                try {
                                    if (sQLiteDatabase.inTransaction()) {
                                        sQLiteDatabase.endTransaction();
                                    }
                                } catch (Throwable th2) {
                                    th = th2;
                                    writableDatabase = sQLiteDatabase;
                                    r12 = r13;
                                    if (r12 != 0) {
                                        r12.close();
                                    }
                                    if (writableDatabase != null) {
                                        writableDatabase.close();
                                    }
                                    throw th;
                                }
                            }
                            zzab().zzgk().zza("Error writing entry to local database", e);
                            this.zzjw = true;
                            if (r13 != 0) {
                                r13.close();
                            }
                            if (sQLiteDatabase != null) {
                                sQLiteDatabase.close();
                            }
                            i2++;
                            r2 = 0;
                        } catch (Throwable th3) {
                            th = th3;
                            r12 = RawQuery;
                            if (r12 != 0) {
                                r12.close();
                            }
                            if (writableDatabase != null) {
                                writableDatabase.close();
                            }
                            throw th;
                        }
                    }
                    if (j >= 100000) {
                        zzab().zzgk().zzao("Data loss, local db full");
                        long j2 = (100000 - j) + 1;
                        String[] strArr = new String[1];
                        strArr[r2] = Long.toString(j2);
                        long jDelete = writableDatabase.delete("messages", "rowid in (select rowid from messages order by rowid asc limit ?)", strArr);
                        if (jDelete != j2) {
                            zzab().zzgk().zza("Different delete count than expected in local db. expected, received, difference", Long.valueOf(j2), Long.valueOf(jDelete), Long.valueOf(j2 - jDelete));
                        }
                    }
                    writableDatabase.insertOrThrow("messages", null, contentValues);
                    writableDatabase.setTransactionSuccessful();
                    writableDatabase.endTransaction();
                    if (RawQuery != 0) {
                        RawQuery.close();
                    }
                    if (writableDatabase != null) {
                        writableDatabase.close();
                    }
                    return true;
                } catch (SQLiteDatabaseLockedException unused2) {
                } catch (SQLiteFullException e3) {
                    e = e3;
                } catch (SQLiteException e4) {
                    e = e4;
                    r14 = 0;
                }
            } catch (SQLiteDatabaseLockedException unused3) {
                writableDatabase = null;
            } catch (SQLiteFullException e5) {
                e = e5;
                writableDatabase = null;
            } catch (SQLiteException e6) {
                e = e6;
                r13 = 0;
            } catch (Throwable th4) {
                th = th4;
                writableDatabase = null;
                r12 = 0;
            }
        }
        zzab().zzgn().zzao("Failed to write entry to local database");
        return false;
    }

    public final boolean zza(zzai zzaiVar) {
        Parcel parcelObtain = Parcel.obtain();
        zzaiVar.writeToParcel(parcelObtain, 0);
        byte[] bArrMarshall = parcelObtain.marshall();
        parcelObtain.recycle();
        if (bArrMarshall.length > 131072) {
            zzab().zzgn().zzao("Event is too long for local database. Sending event directly to service");
            return false;
        }
        return zza(0, bArrMarshall);
    }

    public final boolean zza(zzjn zzjnVar) {
        Parcel parcelObtain = Parcel.obtain();
        zzjnVar.writeToParcel(parcelObtain, 0);
        byte[] bArrMarshall = parcelObtain.marshall();
        parcelObtain.recycle();
        if (bArrMarshall.length > 131072) {
            zzab().zzgn().zzao("User property too long for local database. Sending directly to service");
            return false;
        }
        return zza(1, bArrMarshall);
    }

    public final boolean zzc(zzq zzqVar) {
        zzz();
        byte[] bArrZza = zzjs.zza(zzqVar);
        if (bArrZza.length > 131072) {
            zzab().zzgn().zzao("Conditional user property too long for local database. Sending directly to service");
            return false;
        }
        return zza(2, bArrZza);
    }

    /* JADX WARN: Code duplicated, block: B:110:0x01b6 A[Catch: SQLiteException -> 0x01d4, SQLiteFullException -> 0x01d6, SQLiteDatabaseLockedException -> 0x023e, all -> 0x024f, TryCatch #25 {all -> 0x024f, blocks: (B:108:0x01ac, B:110:0x01b6, B:111:0x01c3, B:159:0x023f), top: B:192:0x023f }] */
    /* JADX WARN: Code duplicated, block: B:113:0x01cb  */
    /* JADX WARN: Code duplicated, block: B:115:0x01d0  */
    /* JADX WARN: Code duplicated, block: B:149:0x0219 A[Catch: all -> 0x0274, TRY_ENTER, TryCatch #13 {all -> 0x0274, blocks: (B:57:0x00c8, B:59:0x00d7, B:61:0x00ea, B:63:0x00ef, B:69:0x0106, B:70:0x0109, B:68:0x0102, B:72:0x010c, B:74:0x011f, B:81:0x0138, B:82:0x013c, B:83:0x013f, B:79:0x0132, B:85:0x0142, B:87:0x0155, B:94:0x016e, B:95:0x0173, B:96:0x0176, B:92:0x0168, B:99:0x017a, B:100:0x0189, B:149:0x0219, B:151:0x021f, B:152:0x0222, B:169:0x0257), top: B:189:0x00c8 }] */
    /* JADX WARN: Code duplicated, block: B:154:0x0233  */
    /* JADX WARN: Code duplicated, block: B:156:0x0238  */
    /* JADX WARN: Code duplicated, block: B:162:0x0246  */
    /* JADX WARN: Code duplicated, block: B:164:0x024b  */
    /* JADX WARN: Code duplicated, block: B:171:0x0268  */
    /* JADX WARN: Code duplicated, block: B:173:0x026d  */
    /* JADX WARN: Code duplicated, block: B:177:0x0277  */
    /* JADX WARN: Code duplicated, block: B:179:0x027c  */
    /* JADX WARN: Code duplicated, block: B:189:0x00c8 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:212:0x0270 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:214:0x0270 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:216:0x0270 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:218:0x010a A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:219:0x00ef A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:221:0x0140 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:222:0x0138 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:223:0x00d7 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:224:0x010c A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:225:0x0177 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:226:0x016e A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:227:0x0189 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:228:0x0142 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:229:0x017a A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:233:0x00c2 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:235:0x00c2 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:237:0x00c2 A[SYNTHETIC] */
    public final List<AbstractSafeParcelable> zzc(int i) throws Throwable {
        Cursor cursor;
        SQLiteDatabase sQLiteDatabase;
        SQLiteDatabase sQLiteDatabase2;
        String str;
        String[] strArr;
        Cursor cursorQuery;
        int i2;
        byte[] blob;
        Parcel parcelObtain;
        zzai zzaiVarCreateFromParcel;
        Parcel parcelObtain2;
        zzjn zzjnVarCreateFromParcel;
        Parcel parcelObtain3;
        zzq zzqVarCreateFromParcel;
        zzo();
        zzm();
        if (this.zzjw) {
            return null;
        }
        ArrayList arrayList = new ArrayList();
        if (!zzcg()) {
            return arrayList;
        }
        int i3 = 5;
        for (int i4 = 0; i4 < 5; i4++) {
            try {
                try {
                    SQLiteDatabase writableDatabase = getWritableDatabase();
                    if (writableDatabase == null) {
                        try {
                            this.zzjw = true;
                            if (writableDatabase != null) {
                                writableDatabase.close();
                            }
                            return null;
                        } catch (SQLiteFullException e) {
                            e = e;
                            cursor = null;
                            sQLiteDatabase = writableDatabase;
                            zzab().zzgk().zza("Error reading entries from local database", e);
                            this.zzjw = true;
                            if (cursor != null) {
                                cursor.close();
                            }
                            if (sQLiteDatabase != null) {
                                sQLiteDatabase.close();
                            }
                        } catch (SQLiteException e2) {
                            e = e2;
                            cursor = null;
                            sQLiteDatabase = writableDatabase;
                            if (sQLiteDatabase != null) {
                                sQLiteDatabase.endTransaction();
                            }
                            zzab().zzgk().zza("Error reading entries from local database", e);
                            this.zzjw = true;
                            if (cursor != null) {
                                cursor.close();
                            }
                            if (sQLiteDatabase != null) {
                                sQLiteDatabase.close();
                            }
                        } catch (Throwable th) {
                            th = th;
                            cursor = null;
                            sQLiteDatabase = writableDatabase;
                            if (cursor != null) {
                                cursor.close();
                            }
                            if (sQLiteDatabase != null) {
                                sQLiteDatabase.close();
                            }
                            throw th;
                        }
                    } else {
                        try {
                            try {
                                writableDatabase.beginTransaction();
                                long j = -1;
                                if (zzad().zza(zzak.zzjd)) {
                                    try {
                                        long jZza = zza(writableDatabase);
                                        if (jZza != -1) {
                                            strArr = new String[]{String.valueOf(jZza)};
                                            str = "rowid<?";
                                        } else {
                                            str = null;
                                            strArr = null;
                                        }
                                        sQLiteDatabase = writableDatabase;
                                        try {
                                            try {
                                                cursorQuery = writableDatabase.query("messages", new String[]{"rowid", "type", "entry"}, str, strArr, null, null, "rowid asc", Integer.toString(100));
                                                cursor = cursorQuery;
                                                while (cursor.moveToNext()) {
                                                    try {
                                                        try {
                                                            try {
                                                                try {
                                                                    j = cursor.getLong(0);
                                                                    i2 = cursor.getInt(1);
                                                                    blob = cursor.getBlob(2);
                                                                    if (i2 == 0) {
                                                                        parcelObtain = Parcel.obtain();
                                                                        try {
                                                                            try {
                                                                                parcelObtain.unmarshall(blob, 0, blob.length);
                                                                                parcelObtain.setDataPosition(0);
                                                                                zzaiVarCreateFromParcel = zzai.CREATOR.createFromParcel(parcelObtain);
                                                                                parcelObtain.recycle();
                                                                                if (zzaiVarCreateFromParcel != null) {
                                                                                    arrayList.add(zzaiVarCreateFromParcel);
                                                                                }
                                                                            } catch (Throwable th2) {
                                                                                parcelObtain.recycle();
                                                                                throw th2;
                                                                            }
                                                                        } catch (SafeParcelReader.ParseException unused) {
                                                                            zzab().zzgk().zzao("Failed to load event from local database");
                                                                            parcelObtain.recycle();
                                                                        }
                                                                    } else if (i2 == 1) {
                                                                        parcelObtain2 = Parcel.obtain();
                                                                        try {
                                                                            try {
                                                                                parcelObtain2.unmarshall(blob, 0, blob.length);
                                                                                parcelObtain2.setDataPosition(0);
                                                                                zzjnVarCreateFromParcel = zzjn.CREATOR.createFromParcel(parcelObtain2);
                                                                                parcelObtain2.recycle();
                                                                            } catch (Throwable th3) {
                                                                                parcelObtain2.recycle();
                                                                                throw th3;
                                                                            }
                                                                        } catch (SafeParcelReader.ParseException unused2) {
                                                                            zzab().zzgk().zzao("Failed to load user property from local database");
                                                                            parcelObtain2.recycle();
                                                                            zzjnVarCreateFromParcel = null;
                                                                        }
                                                                        if (zzjnVarCreateFromParcel != null) {
                                                                            arrayList.add(zzjnVarCreateFromParcel);
                                                                        }
                                                                    } else if (i2 == 2) {
                                                                        parcelObtain3 = Parcel.obtain();
                                                                        try {
                                                                            try {
                                                                                parcelObtain3.unmarshall(blob, 0, blob.length);
                                                                                parcelObtain3.setDataPosition(0);
                                                                                zzqVarCreateFromParcel = zzq.CREATOR.createFromParcel(parcelObtain3);
                                                                                parcelObtain3.recycle();
                                                                            } catch (SafeParcelReader.ParseException unused3) {
                                                                                zzab().zzgk().zzao("Failed to load user property from local database");
                                                                                parcelObtain3.recycle();
                                                                                zzqVarCreateFromParcel = null;
                                                                            }
                                                                            if (zzqVarCreateFromParcel != null) {
                                                                                arrayList.add(zzqVarCreateFromParcel);
                                                                            }
                                                                        } catch (Throwable th4) {
                                                                            parcelObtain3.recycle();
                                                                            throw th4;
                                                                        }
                                                                    } else if (i2 == 3) {
                                                                        zzab().zzgn().zzao("Skipping app launch break");
                                                                    } else {
                                                                        zzab().zzgk().zzao("Unknown record type in local database");
                                                                    }
                                                                } catch (Throwable th5) {
                                                                    th = th5;
                                                                    if (cursor != null) {
                                                                        cursor.close();
                                                                    }
                                                                    if (sQLiteDatabase != null) {
                                                                        sQLiteDatabase.close();
                                                                    }
                                                                    throw th;
                                                                }
                                                            } catch (SQLiteFullException e3) {
                                                                e = e3;
                                                                zzab().zzgk().zza("Error reading entries from local database", e);
                                                                this.zzjw = true;
                                                                if (cursor != null) {
                                                                    cursor.close();
                                                                }
                                                                if (sQLiteDatabase != null) {
                                                                    sQLiteDatabase.close();
                                                                }
                                                            } catch (SQLiteException e4) {
                                                                e = e4;
                                                                if (sQLiteDatabase != null && sQLiteDatabase.inTransaction()) {
                                                                    sQLiteDatabase.endTransaction();
                                                                }
                                                                zzab().zzgk().zza("Error reading entries from local database", e);
                                                                this.zzjw = true;
                                                                if (cursor != null) {
                                                                    cursor.close();
                                                                }
                                                                if (sQLiteDatabase != null) {
                                                                    sQLiteDatabase.close();
                                                                }
                                                            }
                                                        } catch (SQLiteDatabaseLockedException unused4) {
                                                            sQLiteDatabase2 = sQLiteDatabase;
                                                        }
                                                    } catch (SQLiteFullException e5) {
                                                        e = e5;
                                                    } catch (SQLiteException e6) {
                                                        e = e6;
                                                    } catch (Throwable th6) {
                                                        th = th6;
                                                    }
                                                }
                                                sQLiteDatabase2 = sQLiteDatabase;
                                                try {
                                                    if (sQLiteDatabase2.delete("messages", "rowid <= ?", new String[]{Long.toString(j)}) < arrayList.size()) {
                                                        zzab().zzgk().zzao("Fewer entries removed from local database than expected");
                                                    }
                                                    sQLiteDatabase2.setTransactionSuccessful();
                                                    sQLiteDatabase2.endTransaction();
                                                    if (cursor != null) {
                                                        cursor.close();
                                                    }
                                                    if (sQLiteDatabase2 != null) {
                                                        sQLiteDatabase2.close();
                                                    }
                                                    return arrayList;
                                                } catch (SQLiteDatabaseLockedException unused5) {
                                                    SystemClock.sleep(i3);
                                                    i3 += 20;
                                                    if (cursor != null) {
                                                        cursor.close();
                                                    }
                                                    if (sQLiteDatabase2 != null) {
                                                        sQLiteDatabase2.close();
                                                    }
                                                } catch (SQLiteFullException e7) {
                                                    e = e7;
                                                    sQLiteDatabase = sQLiteDatabase2;
                                                    zzab().zzgk().zza("Error reading entries from local database", e);
                                                    this.zzjw = true;
                                                    if (cursor != null) {
                                                        cursor.close();
                                                    }
                                                    if (sQLiteDatabase != null) {
                                                        sQLiteDatabase.close();
                                                    }
                                                } catch (SQLiteException e8) {
                                                    e = e8;
                                                    sQLiteDatabase = sQLiteDatabase2;
                                                    if (sQLiteDatabase != null) {
                                                        sQLiteDatabase.endTransaction();
                                                    }
                                                    zzab().zzgk().zza("Error reading entries from local database", e);
                                                    this.zzjw = true;
                                                    if (cursor != null) {
                                                        cursor.close();
                                                    }
                                                    if (sQLiteDatabase != null) {
                                                        sQLiteDatabase.close();
                                                    }
                                                }
                                            } catch (SQLiteDatabaseLockedException unused6) {
                                                sQLiteDatabase2 = sQLiteDatabase;
                                                cursor = null;
                                            }
                                        } catch (SQLiteFullException e9) {
                                            e = e9;
                                            cursor = null;
                                            zzab().zzgk().zza("Error reading entries from local database", e);
                                            this.zzjw = true;
                                            if (cursor != null) {
                                                cursor.close();
                                            }
                                            if (sQLiteDatabase != null) {
                                                sQLiteDatabase.close();
                                            }
                                        } catch (SQLiteException e10) {
                                            e = e10;
                                            cursor = null;
                                            if (sQLiteDatabase != null) {
                                                sQLiteDatabase.endTransaction();
                                            }
                                            zzab().zzgk().zza("Error reading entries from local database", e);
                                            this.zzjw = true;
                                            if (cursor != null) {
                                                cursor.close();
                                            }
                                            if (sQLiteDatabase != null) {
                                                sQLiteDatabase.close();
                                            }
                                        } catch (Throwable th7) {
                                            th = th7;
                                            cursor = null;
                                            if (cursor != null) {
                                                cursor.close();
                                            }
                                            if (sQLiteDatabase != null) {
                                                sQLiteDatabase.close();
                                            }
                                            throw th;
                                        }
                                    } catch (SQLiteFullException e11) {
                                        e = e11;
                                        sQLiteDatabase = writableDatabase;
                                    } catch (SQLiteException e12) {
                                        e = e12;
                                        sQLiteDatabase = writableDatabase;
                                    } catch (Throwable th8) {
                                        th = th8;
                                        sQLiteDatabase = writableDatabase;
                                    }
                                } else {
                                    sQLiteDatabase = writableDatabase;
                                    try {
                                        cursorQuery = sQLiteDatabase.query("messages", new String[]{"rowid", "type", "entry"}, null, null, null, null, "rowid asc", Integer.toString(100));
                                        cursor = cursorQuery;
                                        while (cursor.moveToNext()) {
                                            j = cursor.getLong(0);
                                            i2 = cursor.getInt(1);
                                            blob = cursor.getBlob(2);
                                            if (i2 == 0) {
                                                parcelObtain = Parcel.obtain();
                                                parcelObtain.unmarshall(blob, 0, blob.length);
                                                parcelObtain.setDataPosition(0);
                                                zzaiVarCreateFromParcel = zzai.CREATOR.createFromParcel(parcelObtain);
                                                parcelObtain.recycle();
                                                if (zzaiVarCreateFromParcel != null) {
                                                    arrayList.add(zzaiVarCreateFromParcel);
                                                }
                                            } else if (i2 == 1) {
                                                parcelObtain2 = Parcel.obtain();
                                                parcelObtain2.unmarshall(blob, 0, blob.length);
                                                parcelObtain2.setDataPosition(0);
                                                zzjnVarCreateFromParcel = zzjn.CREATOR.createFromParcel(parcelObtain2);
                                                parcelObtain2.recycle();
                                                if (zzjnVarCreateFromParcel != null) {
                                                    arrayList.add(zzjnVarCreateFromParcel);
                                                }
                                            } else if (i2 == 2) {
                                                parcelObtain3 = Parcel.obtain();
                                                parcelObtain3.unmarshall(blob, 0, blob.length);
                                                parcelObtain3.setDataPosition(0);
                                                zzqVarCreateFromParcel = zzq.CREATOR.createFromParcel(parcelObtain3);
                                                parcelObtain3.recycle();
                                                if (zzqVarCreateFromParcel != null) {
                                                    arrayList.add(zzqVarCreateFromParcel);
                                                }
                                            } else if (i2 == 3) {
                                                zzab().zzgn().zzao("Skipping app launch break");
                                            } else {
                                                zzab().zzgk().zzao("Unknown record type in local database");
                                            }
                                        }
                                        sQLiteDatabase2 = sQLiteDatabase;
                                        if (sQLiteDatabase2.delete("messages", "rowid <= ?", new String[]{Long.toString(j)}) < arrayList.size()) {
                                            zzab().zzgk().zzao("Fewer entries removed from local database than expected");
                                        }
                                        sQLiteDatabase2.setTransactionSuccessful();
                                        sQLiteDatabase2.endTransaction();
                                        if (cursor != null) {
                                            cursor.close();
                                        }
                                        if (sQLiteDatabase2 != null) {
                                            sQLiteDatabase2.close();
                                        }
                                        return arrayList;
                                    } catch (SQLiteFullException e13) {
                                        e = e13;
                                        cursor = null;
                                        zzab().zzgk().zza("Error reading entries from local database", e);
                                        this.zzjw = true;
                                        if (cursor != null) {
                                            cursor.close();
                                        }
                                        if (sQLiteDatabase != null) {
                                            sQLiteDatabase.close();
                                        }
                                    } catch (SQLiteException e14) {
                                        e = e14;
                                        cursor = null;
                                        if (sQLiteDatabase != null) {
                                            sQLiteDatabase.endTransaction();
                                        }
                                        zzab().zzgk().zza("Error reading entries from local database", e);
                                        this.zzjw = true;
                                        if (cursor != null) {
                                            cursor.close();
                                        }
                                        if (sQLiteDatabase != null) {
                                            sQLiteDatabase.close();
                                        }
                                    } catch (Throwable th9) {
                                        th = th9;
                                        cursor = null;
                                        if (cursor != null) {
                                            cursor.close();
                                        }
                                        if (sQLiteDatabase != null) {
                                            sQLiteDatabase.close();
                                        }
                                        throw th;
                                    }
                                }
                            } catch (SQLiteDatabaseLockedException unused7) {
                                sQLiteDatabase2 = writableDatabase;
                            }
                        } catch (SQLiteFullException e15) {
                            e = e15;
                            sQLiteDatabase2 = writableDatabase;
                            cursor = null;
                        } catch (SQLiteException e16) {
                            e = e16;
                            sQLiteDatabase2 = writableDatabase;
                            cursor = null;
                        } catch (Throwable th10) {
                            th = th10;
                            sQLiteDatabase2 = writableDatabase;
                            cursor = null;
                            sQLiteDatabase = sQLiteDatabase2;
                            if (cursor != null) {
                                cursor.close();
                            }
                            if (sQLiteDatabase != null) {
                                sQLiteDatabase.close();
                            }
                            throw th;
                        }
                    }
                    sQLiteDatabase2 = writableDatabase;
                    cursor = null;
                } catch (SQLiteDatabaseLockedException unused8) {
                    cursor = null;
                    sQLiteDatabase2 = null;
                } catch (SQLiteFullException e17) {
                    e = e17;
                    cursor = null;
                    sQLiteDatabase = null;
                } catch (SQLiteException e18) {
                    e = e18;
                    cursor = null;
                    sQLiteDatabase = null;
                } catch (Throwable th11) {
                    th = th11;
                    cursor = null;
                    sQLiteDatabase = null;
                }
                SystemClock.sleep(i3);
                i3 += 20;
                if (cursor != null) {
                    cursor.close();
                }
                if (sQLiteDatabase2 != null) {
                    sQLiteDatabase2.close();
                }
            } catch (Throwable th12) {
                th = th12;
                sQLiteDatabase = sQLiteDatabase2;
                if (cursor != null) {
                    cursor.close();
                }
                if (sQLiteDatabase != null) {
                    sQLiteDatabase.close();
                }
                throw th;
            }
        }
        zzab().zzgn().zzao("Failed to read events from database in reasonable time");
        return null;
    }

    @WorkerThread
    public final boolean zzgh() {
        return zza(3, new byte[0]);
    }

    /* JADX WARN: Code duplicated, block: B:50:0x009f  */
    @WorkerThread
    public final boolean zzgi() throws Throwable {
        SQLiteDatabase writableDatabase;
        SQLiteException e;
        SQLiteFullException e2;
        zzo();
        zzm();
        if (this.zzjw || !zzcg()) {
            return false;
        }
        int i = 5;
        for (int i2 = 0; i2 < 5; i2++) {
            SQLiteDatabase sQLiteDatabase = null;
            try {
                writableDatabase = getWritableDatabase();
                try {
                    if (writableDatabase == null) {
                        this.zzjw = true;
                        if (writableDatabase != null) {
                            writableDatabase.close();
                        }
                        return false;
                    }
                    writableDatabase.beginTransaction();
                    writableDatabase.delete("messages", "type == ?", new String[]{Integer.toString(3)});
                    writableDatabase.setTransactionSuccessful();
                    writableDatabase.endTransaction();
                    if (writableDatabase != null) {
                        writableDatabase.close();
                    }
                    return true;
                } catch (SQLiteDatabaseLockedException unused) {
                    sQLiteDatabase = writableDatabase;
                    try {
                        SystemClock.sleep(i);
                        i += 20;
                        if (sQLiteDatabase != null) {
                            sQLiteDatabase.close();
                        }
                    } catch (Throwable th) {
                        th = th;
                        writableDatabase = sQLiteDatabase;
                        if (writableDatabase != null) {
                            writableDatabase.close();
                        }
                        throw th;
                    }
                } catch (SQLiteFullException e3) {
                    e2 = e3;
                    zzab().zzgk().zza("Error deleting app launch break from local database", e2);
                    this.zzjw = true;
                    if (writableDatabase != null) {
                        writableDatabase.close();
                    }
                } catch (SQLiteException e4) {
                    e = e4;
                    if (writableDatabase != null) {
                        try {
                            if (writableDatabase.inTransaction()) {
                                writableDatabase.endTransaction();
                            }
                        } catch (Throwable th2) {
                            th = th2;
                            if (writableDatabase != null) {
                                writableDatabase.close();
                            }
                            throw th;
                        }
                    }
                    zzab().zzgk().zza("Error deleting app launch break from local database", e);
                    this.zzjw = true;
                    if (writableDatabase != null) {
                        writableDatabase.close();
                    }
                }
            } catch (SQLiteDatabaseLockedException unused2) {
            } catch (SQLiteFullException e5) {
                writableDatabase = null;
                e2 = e5;
            } catch (SQLiteException e6) {
                writableDatabase = null;
                e = e6;
            }
        }
        zzab().zzgn().zzao("Error deleting app launch break from local database in reasonable time");
        return false;
    }

    private static long zza(SQLiteDatabase sQLiteDatabase) throws Throwable {
        Cursor cursor = null;
        try {
            Cursor cursorQuery = sQLiteDatabase.query("messages", new String[]{"rowid"}, "type=?", new String[]{"3"}, null, null, "rowid desc", "1");
            try {
                if (cursorQuery.moveToFirst()) {
                    long j = cursorQuery.getLong(0);
                    if (cursorQuery != null) {
                        cursorQuery.close();
                    }
                    return j;
                }
                if (cursorQuery == null) {
                    return -1L;
                }
                cursorQuery.close();
                return -1L;
            } catch (Throwable th) {
                cursor = cursorQuery;
                th = th;
                if (cursor != null) {
                    cursor.close();
                }
                throw th;
            }
        } catch (Throwable th2) {
            th = th2;
        }
    }

    @VisibleForTesting
    @WorkerThread
    private final SQLiteDatabase getWritableDatabase() throws SQLiteException {
        if (this.zzjw) {
            return null;
        }
        SQLiteDatabase writableDatabase = this.zzjv.getWritableDatabase();
        if (writableDatabase != null) {
            return writableDatabase;
        }
        this.zzjw = true;
        return null;
    }

    @VisibleForTesting
    private final boolean zzcg() {
        return getContext().getDatabasePath("google_app_measurement_local.db").exists();
    }

    @Override // com.google.android.gms.measurement.internal.zzd, com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzl() {
        super.zzl();
    }

    @Override // com.google.android.gms.measurement.internal.zzd, com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzm() {
        super.zzm();
    }

    @Override // com.google.android.gms.measurement.internal.zzd, com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzn() {
        super.zzn();
    }

    @Override // com.google.android.gms.measurement.internal.zzd, com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzo() {
        super.zzo();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zza zzp() {
        return super.zzp();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zzgp zzq() {
        return super.zzq();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zzdy zzr() {
        return super.zzr();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zzhv zzs() {
        return super.zzs();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zzhq zzt() {
        return super.zzt();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zzeb zzu() {
        return super.zzu();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zziw zzv() {
        return super.zzv();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ zzac zzw() {
        return super.zzw();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf, com.google.android.gms.measurement.internal.zzgh
    public final /* bridge */ /* synthetic */ Clock zzx() {
        return super.zzx();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf, com.google.android.gms.measurement.internal.zzgh
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ zzed zzy() {
        return super.zzy();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ zzjs zzz() {
        return super.zzz();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf, com.google.android.gms.measurement.internal.zzgh
    public final /* bridge */ /* synthetic */ zzfc zzaa() {
        return super.zzaa();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf, com.google.android.gms.measurement.internal.zzgh
    public final /* bridge */ /* synthetic */ zzef zzab() {
        return super.zzab();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ zzeo zzac() {
        return super.zzac();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ zzs zzad() {
        return super.zzad();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf, com.google.android.gms.measurement.internal.zzgh
    public final /* bridge */ /* synthetic */ zzr zzae() {
        return super.zzae();
    }
}

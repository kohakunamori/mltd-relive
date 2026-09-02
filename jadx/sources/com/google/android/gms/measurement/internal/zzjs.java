package com.google.android.gms.measurement.internal;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ServiceInfo;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.RemoteException;
import android.text.TextUtils;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.WorkerThread;
import androidx.core.app.NotificationCompat;
import com.adjust.sdk.Constants;
import com.android.vending.expansion.zipfile.APEZProvider;
import com.google.android.gms.common.GoogleApiAvailabilityLight;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.util.CollectionUtils;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.common.wrappers.Wrappers;
import com.google.android.gms.measurement.api.AppMeasurementSdk;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.io.ByteArrayInputStream;
import java.math.BigInteger;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import java.util.Set;
import java.util.TreeSet;
import java.util.concurrent.atomic.AtomicLong;
import javax.security.auth.x500.X500Principal;

/* JADX INFO: loaded from: classes.dex */
public final class zzjs extends zzge {
    private static final String[] zztw = {"firebase_", "google_", "ga_"};
    private static final List<String> zzua = Collections.unmodifiableList(Arrays.asList(FirebaseAnalytics.Param.SOURCE, "medium", FirebaseAnalytics.Param.CAMPAIGN, FirebaseAnalytics.Param.TERM, FirebaseAnalytics.Param.CONTENT));
    private int zzag;
    private SecureRandom zztx;
    private final AtomicLong zzty;
    private Integer zztz;

    zzjs(zzfj zzfjVar) {
        super(zzfjVar);
        this.zztz = null;
        this.zzty = new AtomicLong(0L);
    }

    @Override // com.google.android.gms.measurement.internal.zzge
    protected final boolean zzbk() {
        return true;
    }

    @Override // com.google.android.gms.measurement.internal.zzge
    @WorkerThread
    protected final void zzbl() {
        zzo();
        SecureRandom secureRandom = new SecureRandom();
        long jNextLong = secureRandom.nextLong();
        if (jNextLong == 0) {
            jNextLong = secureRandom.nextLong();
            if (jNextLong == 0) {
                zzab().zzgn().zzao("Utils falling back to Random for random id");
            }
        }
        this.zzty.set(jNextLong);
    }

    public final long zzjv() {
        long andIncrement;
        long j;
        if (this.zzty.get() == 0) {
            synchronized (this.zzty) {
                long jNextLong = new Random(System.nanoTime() ^ zzx().currentTimeMillis()).nextLong();
                int i = this.zzag + 1;
                this.zzag = i;
                j = jNextLong + ((long) i);
            }
            return j;
        }
        synchronized (this.zzty) {
            this.zzty.compareAndSet(-1L, 1L);
            andIncrement = this.zzty.getAndIncrement();
        }
        return andIncrement;
    }

    @WorkerThread
    final SecureRandom zzjw() {
        zzo();
        if (this.zztx == null) {
            this.zztx = new SecureRandom();
        }
        return this.zztx;
    }

    static boolean zzbk(String str) {
        Preconditions.checkNotEmpty(str);
        return str.charAt(0) != '_' || str.equals("_ep");
    }

    final Bundle zza(@NonNull Uri uri) {
        String queryParameter;
        String queryParameter2;
        String queryParameter3;
        String queryParameter4;
        if (uri == null) {
            return null;
        }
        try {
            if (uri.isHierarchical()) {
                queryParameter = uri.getQueryParameter("utm_campaign");
                queryParameter2 = uri.getQueryParameter("utm_source");
                queryParameter3 = uri.getQueryParameter("utm_medium");
                queryParameter4 = uri.getQueryParameter("gclid");
            } else {
                queryParameter = null;
                queryParameter2 = null;
                queryParameter3 = null;
                queryParameter4 = null;
            }
            if (TextUtils.isEmpty(queryParameter) && TextUtils.isEmpty(queryParameter2) && TextUtils.isEmpty(queryParameter3) && TextUtils.isEmpty(queryParameter4)) {
                return null;
            }
            Bundle bundle = new Bundle();
            if (!TextUtils.isEmpty(queryParameter)) {
                bundle.putString(FirebaseAnalytics.Param.CAMPAIGN, queryParameter);
            }
            if (!TextUtils.isEmpty(queryParameter2)) {
                bundle.putString(FirebaseAnalytics.Param.SOURCE, queryParameter2);
            }
            if (!TextUtils.isEmpty(queryParameter3)) {
                bundle.putString("medium", queryParameter3);
            }
            if (!TextUtils.isEmpty(queryParameter4)) {
                bundle.putString("gclid", queryParameter4);
            }
            String queryParameter5 = uri.getQueryParameter("utm_term");
            if (!TextUtils.isEmpty(queryParameter5)) {
                bundle.putString(FirebaseAnalytics.Param.TERM, queryParameter5);
            }
            String queryParameter6 = uri.getQueryParameter("utm_content");
            if (!TextUtils.isEmpty(queryParameter6)) {
                bundle.putString(FirebaseAnalytics.Param.CONTENT, queryParameter6);
            }
            String queryParameter7 = uri.getQueryParameter(FirebaseAnalytics.Param.ACLID);
            if (!TextUtils.isEmpty(queryParameter7)) {
                bundle.putString(FirebaseAnalytics.Param.ACLID, queryParameter7);
            }
            String queryParameter8 = uri.getQueryParameter(FirebaseAnalytics.Param.CP1);
            if (!TextUtils.isEmpty(queryParameter8)) {
                bundle.putString(FirebaseAnalytics.Param.CP1, queryParameter8);
            }
            String queryParameter9 = uri.getQueryParameter("anid");
            if (!TextUtils.isEmpty(queryParameter9)) {
                bundle.putString("anid", queryParameter9);
            }
            return bundle;
        } catch (UnsupportedOperationException e) {
            zzab().zzgn().zza("Install referrer url isn't a hierarchical URI", e);
            return null;
        }
    }

    static boolean zzc(Intent intent) {
        String stringExtra = intent.getStringExtra("android.intent.extra.REFERRER_NAME");
        return "android-app://com.google.android.googlequicksearchbox/https/www.google.com".equals(stringExtra) || "https://www.google.com".equals(stringExtra) || "android-app://com.google.appcrawler".equals(stringExtra);
    }

    final boolean zzp(String str, String str2) {
        if (str2 == null) {
            zzab().zzgm().zza("Name is required and can't be null. Type", str);
            return false;
        }
        if (str2.length() == 0) {
            zzab().zzgm().zza("Name is required and can't be empty. Type", str);
            return false;
        }
        int iCodePointAt = str2.codePointAt(0);
        if (!Character.isLetter(iCodePointAt)) {
            zzab().zzgm().zza("Name must start with a letter. Type, name", str, str2);
            return false;
        }
        int length = str2.length();
        int iCharCount = Character.charCount(iCodePointAt);
        while (iCharCount < length) {
            int iCodePointAt2 = str2.codePointAt(iCharCount);
            if (iCodePointAt2 != 95 && !Character.isLetterOrDigit(iCodePointAt2)) {
                zzab().zzgm().zza("Name must consist of letters, digits or _ (underscores). Type, name", str, str2);
                return false;
            }
            iCharCount += Character.charCount(iCodePointAt2);
        }
        return true;
    }

    final boolean zzq(String str, String str2) {
        if (str2 == null) {
            zzab().zzgm().zza("Name is required and can't be null. Type", str);
            return false;
        }
        if (str2.length() == 0) {
            zzab().zzgm().zza("Name is required and can't be empty. Type", str);
            return false;
        }
        int iCodePointAt = str2.codePointAt(0);
        if (!Character.isLetter(iCodePointAt) && iCodePointAt != 95) {
            zzab().zzgm().zza("Name must start with a letter or _ (underscore). Type, name", str, str2);
            return false;
        }
        int length = str2.length();
        int iCharCount = Character.charCount(iCodePointAt);
        while (iCharCount < length) {
            int iCodePointAt2 = str2.codePointAt(iCharCount);
            if (iCodePointAt2 != 95 && !Character.isLetterOrDigit(iCodePointAt2)) {
                zzab().zzgm().zza("Name must consist of letters, digits or _ (underscores). Type, name", str, str2);
                return false;
            }
            iCharCount += Character.charCount(iCodePointAt2);
        }
        return true;
    }

    final boolean zza(String str, String[] strArr, String str2) {
        boolean z;
        boolean z2;
        if (str2 == null) {
            zzab().zzgm().zza("Name is required and can't be null. Type", str);
            return false;
        }
        Preconditions.checkNotNull(str2);
        String[] strArr2 = zztw;
        int length = strArr2.length;
        int i = 0;
        while (true) {
            if (i >= length) {
                z = false;
                break;
            }
            if (str2.startsWith(strArr2[i])) {
                z = true;
                break;
            }
            i++;
        }
        if (z) {
            zzab().zzgm().zza("Name starts with reserved prefix. Type, name", str, str2);
            return false;
        }
        if (strArr != null) {
            Preconditions.checkNotNull(strArr);
            int length2 = strArr.length;
            int i2 = 0;
            while (true) {
                if (i2 >= length2) {
                    z2 = false;
                    break;
                }
                if (zzs(str2, strArr[i2])) {
                    z2 = true;
                    break;
                }
                i2++;
            }
            if (z2) {
                zzab().zzgm().zza("Name is reserved. Type, name", str, str2);
                return false;
            }
        }
        return true;
    }

    final boolean zza(String str, int i, String str2) {
        if (str2 == null) {
            zzab().zzgm().zza("Name is required and can't be null. Type", str);
            return false;
        }
        if (str2.codePointCount(0, str2.length()) <= i) {
            return true;
        }
        zzab().zzgm().zza("Name is too long. Type, maximum supported length, name", str, Integer.valueOf(i), str2);
        return false;
    }

    final int zzbl(String str) {
        if (!zzq(NotificationCompat.CATEGORY_EVENT, str)) {
            return 2;
        }
        if (zza(NotificationCompat.CATEGORY_EVENT, zzgj.zzpn, str)) {
            return !zza(NotificationCompat.CATEGORY_EVENT, 40, str) ? 2 : 0;
        }
        return 13;
    }

    final int zzbm(String str) {
        if (!zzq("user property", str)) {
            return 6;
        }
        if (zza("user property", zzgl.zzpp, str)) {
            return !zza("user property", 24, str) ? 6 : 0;
        }
        return 15;
    }

    private final boolean zza(String str, String str2, int i, Object obj, boolean z) {
        if (obj == null || (obj instanceof Long) || (obj instanceof Float) || (obj instanceof Integer) || (obj instanceof Byte) || (obj instanceof Short) || (obj instanceof Boolean) || (obj instanceof Double)) {
            return true;
        }
        if ((obj instanceof String) || (obj instanceof Character) || (obj instanceof CharSequence)) {
            String strValueOf = String.valueOf(obj);
            if (strValueOf.codePointCount(0, strValueOf.length()) <= i) {
                return true;
            }
            zzab().zzgp().zza("Value is too long; discarded. Value kind, name, value length", str, str2, Integer.valueOf(strValueOf.length()));
            return false;
        }
        if ((obj instanceof Bundle) && z) {
            return true;
        }
        if ((obj instanceof Parcelable[]) && z) {
            for (Parcelable parcelable : (Parcelable[]) obj) {
                if (!(parcelable instanceof Bundle)) {
                    zzab().zzgp().zza("All Parcelable[] elements must be of type Bundle. Value type, name", parcelable.getClass(), str2);
                    return false;
                }
            }
            return true;
        }
        if (!(obj instanceof ArrayList) || !z) {
            return false;
        }
        ArrayList arrayList = (ArrayList) obj;
        int size = arrayList.size();
        int i2 = 0;
        while (i2 < size) {
            Object obj2 = arrayList.get(i2);
            i2++;
            if (!(obj2 instanceof Bundle)) {
                zzab().zzgp().zza("All ArrayList elements must be of type Bundle. Value type, name", obj2.getClass(), str2);
                return false;
            }
        }
        return true;
    }

    final boolean zzr(String str, String str2) {
        if (!TextUtils.isEmpty(str)) {
            if (zzbn(str)) {
                return true;
            }
            if (this.zzj.zzhw()) {
                zzab().zzgm().zza("Invalid google_app_id. Firebase Analytics disabled. See https://goo.gl/NAOOOI. provided id", zzef.zzam(str));
            }
            return false;
        }
        if (!TextUtils.isEmpty(str2)) {
            if (zzbn(str2)) {
                return true;
            }
            zzab().zzgm().zza("Invalid admob_app_id. Analytics disabled.", zzef.zzam(str2));
            return false;
        }
        if (this.zzj.zzhw()) {
            zzab().zzgm().zzao("Missing google_app_id. Firebase Analytics disabled. See https://goo.gl/NAOOOI");
        }
        return false;
    }

    static boolean zza(String str, String str2, String str3, String str4) {
        boolean zIsEmpty = TextUtils.isEmpty(str);
        boolean zIsEmpty2 = TextUtils.isEmpty(str2);
        if (!zIsEmpty && !zIsEmpty2) {
            return !str.equals(str2);
        }
        if (zIsEmpty && zIsEmpty2) {
            if (TextUtils.isEmpty(str3) || TextUtils.isEmpty(str4)) {
                return !TextUtils.isEmpty(str4);
            }
            return !str3.equals(str4);
        }
        if (zIsEmpty || !zIsEmpty2) {
            return TextUtils.isEmpty(str3) || !str3.equals(str4);
        }
        if (TextUtils.isEmpty(str4)) {
            return false;
        }
        return TextUtils.isEmpty(str3) || !str3.equals(str4);
    }

    @VisibleForTesting
    private static boolean zzbn(String str) {
        Preconditions.checkNotNull(str);
        return str.matches("^(1:\\d+:android:[a-f0-9]+|ca-app-pub-.*)$");
    }

    private static Object zza(int i, Object obj, boolean z) {
        if (obj == null) {
            return null;
        }
        if ((obj instanceof Long) || (obj instanceof Double)) {
            return obj;
        }
        if (obj instanceof Integer) {
            return Long.valueOf(((Integer) obj).intValue());
        }
        if (obj instanceof Byte) {
            return Long.valueOf(((Byte) obj).byteValue());
        }
        if (obj instanceof Short) {
            return Long.valueOf(((Short) obj).shortValue());
        }
        if (obj instanceof Boolean) {
            return Long.valueOf(((Boolean) obj).booleanValue() ? 1L : 0L);
        }
        if (obj instanceof Float) {
            return Double.valueOf(((Float) obj).doubleValue());
        }
        if ((obj instanceof String) || (obj instanceof Character) || (obj instanceof CharSequence)) {
            return zza(String.valueOf(obj), i, z);
        }
        return null;
    }

    public static String zza(String str, int i, boolean z) {
        if (str == null) {
            return null;
        }
        if (str.codePointCount(0, str.length()) <= i) {
            return str;
        }
        if (z) {
            return String.valueOf(str.substring(0, str.offsetByCodePoints(0, i))).concat("...");
        }
        return null;
    }

    final Object zzb(String str, Object obj) {
        if ("_ev".equals(str)) {
            return zza(256, obj, true);
        }
        return zza(zzbq(str) ? 256 : 100, obj, false);
    }

    static Bundle[] zzb(Object obj) {
        if (obj instanceof Bundle) {
            return new Bundle[]{(Bundle) obj};
        }
        if (obj instanceof Parcelable[]) {
            Parcelable[] parcelableArr = (Parcelable[]) obj;
            return (Bundle[]) Arrays.copyOf(parcelableArr, parcelableArr.length, Bundle[].class);
        }
        if (!(obj instanceof ArrayList)) {
            return null;
        }
        ArrayList arrayList = (ArrayList) obj;
        return (Bundle[]) arrayList.toArray(new Bundle[arrayList.size()]);
    }

    /* JADX WARN: Code duplicated, block: B:16:0x0048  */
    /* JADX WARN: Code duplicated, block: B:21:0x0056  */
    /* JADX WARN: Code duplicated, block: B:28:0x006c  */
    /* JADX WARN: Code duplicated, block: B:32:0x0077  */
    /* JADX WARN: Code duplicated, block: B:59:0x00de  */
    /* JADX WARN: Code duplicated, block: B:61:0x00e1  */
    /* JADX WARN: Code duplicated, block: B:62:0x00e7  */
    /* JADX WARN: Code duplicated, block: B:64:0x00f1  */
    /* JADX WARN: Code duplicated, block: B:66:0x00f7  */
    /* JADX WARN: Code duplicated, block: B:71:0x0129  */
    /* JADX WARN: Code duplicated, block: B:72:0x012b  */
    final Bundle zza(String str, String str2, Bundle bundle, @Nullable List<String> list, boolean z, boolean z2) {
        Set<String> setKeySet;
        int i;
        int i2;
        boolean z3;
        int i3;
        boolean zZza;
        int i4;
        int size;
        boolean z4;
        String[] strArr = null;
        if (bundle == null) {
            return null;
        }
        Bundle bundle2 = new Bundle(bundle);
        if (zzad().zze(str, zzak.zziw)) {
            setKeySet = new TreeSet<>(bundle.keySet());
        } else {
            setKeySet = bundle.keySet();
        }
        int i5 = 0;
        for (String str3 : setKeySet) {
            if (list == null || !list.contains(str3)) {
                i = 14;
                if (!z) {
                    i2 = 0;
                } else if (!zzp("event param", str3)) {
                    i2 = 3;
                } else if (!zza("event param", strArr, str3)) {
                    i2 = 14;
                } else if (zza("event param", 40, str3)) {
                    i2 = 0;
                } else {
                    i2 = 3;
                }
                if (i2 != 0) {
                    i = i2;
                } else if (!zzq("event param", str3)) {
                    i = 3;
                } else if (zza("event param", strArr, str3)) {
                    if (zza("event param", 40, str3)) {
                        i = 0;
                    } else {
                        i = 3;
                    }
                }
            } else {
                i = 0;
            }
            if (i != 0) {
                if (zza(bundle2, i)) {
                    bundle2.putString("_ev", zza(str3, 40, true));
                    if (i == 3) {
                        zzb(bundle2, str3);
                    }
                }
                bundle2.remove(str3);
            } else {
                Object obj = bundle.get(str3);
                zzo();
                if (z2) {
                    if (obj instanceof Parcelable[]) {
                        size = ((Parcelable[]) obj).length;
                    } else {
                        if (obj instanceof ArrayList) {
                            size = ((ArrayList) obj).size();
                        } else {
                            z4 = true;
                        }
                        if (z4) {
                            if (!zzad().zzn(str)) {
                                z3 = true;
                                i3 = 40;
                                zZza = zza("param", str3, 100, obj, z2);
                            } else {
                                z3 = true;
                                i3 = 40;
                                zZza = zza("param", str3, 100, obj, z2);
                            }
                            if (zZza) {
                                i4 = 0;
                            } else {
                                i4 = 4;
                            }
                        } else {
                            i4 = 17;
                            z3 = true;
                            i3 = 40;
                        }
                    }
                    if (size > 1000) {
                        zzab().zzgp().zza("Parameter array is too long; discarded. Value kind, name, array length", "param", str3, Integer.valueOf(size));
                        z4 = false;
                    } else {
                        z4 = true;
                    }
                    if (z4) {
                        i4 = 17;
                        z3 = true;
                        i3 = 40;
                    } else {
                        if (!zzad().zzn(str)) {
                            z3 = true;
                            i3 = 40;
                            zZza = zza("param", str3, 100, obj, z2);
                        } else {
                            z3 = true;
                            i3 = 40;
                            zZza = zza("param", str3, 100, obj, z2);
                        }
                        if (zZza) {
                            i4 = 0;
                        } else {
                            i4 = 4;
                        }
                    }
                } else {
                    if ((!zzad().zzn(str) && zzbq(str2)) || zzbq(str3)) {
                        z3 = true;
                        i3 = 40;
                        zZza = zza("param", str3, 256, obj, z2);
                    } else {
                        z3 = true;
                        i3 = 40;
                        zZza = zza("param", str3, 100, obj, z2);
                    }
                    if (zZza) {
                        i4 = 0;
                    } else {
                        i4 = 4;
                    }
                }
                if (i4 != 0 && !"_ev".equals(str3)) {
                    if (zza(bundle2, i4)) {
                        bundle2.putString("_ev", zza(str3, i3, z3));
                        zzb(bundle2, bundle.get(str3));
                    }
                    bundle2.remove(str3);
                } else if (zzbk(str3) && (i5 = i5 + 1) > 25) {
                    StringBuilder sb = new StringBuilder(48);
                    sb.append("Event can't contain more than 25 params");
                    zzab().zzgm().zza(sb.toString(), zzy().zzaj(str2), zzy().zzc(bundle));
                    zza(bundle2, 5);
                    bundle2.remove(str3);
                }
            }
            strArr = null;
        }
        return bundle2;
    }

    private static boolean zza(Bundle bundle, int i) {
        if (bundle.getLong("_err") != 0) {
            return false;
        }
        bundle.putLong("_err", i);
        return true;
    }

    private static void zzb(Bundle bundle, Object obj) {
        Preconditions.checkNotNull(bundle);
        if (obj != null) {
            if ((obj instanceof String) || (obj instanceof CharSequence)) {
                bundle.putLong("_el", String.valueOf(obj).length());
            }
        }
    }

    private static int zzbo(String str) {
        if ("_ldl".equals(str)) {
            return 2048;
        }
        return APEZProvider.FILEID.equals(str) ? 256 : 36;
    }

    final int zzc(String str, Object obj) {
        boolean zZza;
        if ("_ldl".equals(str)) {
            zZza = zza("user property referrer", str, zzbo(str), obj, false);
        } else {
            zZza = zza("user property", str, zzbo(str), obj, false);
        }
        return zZza ? 0 : 7;
    }

    final Object zzd(String str, Object obj) {
        if ("_ldl".equals(str)) {
            return zza(zzbo(str), obj, true);
        }
        return zza(zzbo(str), obj, false);
    }

    final void zza(Bundle bundle, String str, Object obj) {
        if (bundle == null) {
            return;
        }
        if (obj instanceof Long) {
            bundle.putLong(str, ((Long) obj).longValue());
            return;
        }
        if (obj instanceof String) {
            bundle.putString(str, String.valueOf(obj));
        } else if (obj instanceof Double) {
            bundle.putDouble(str, ((Double) obj).doubleValue());
        } else if (str != null) {
            zzab().zzgp().zza("Not putting event parameter. Invalid value type. name, type", zzy().zzak(str), obj != null ? obj.getClass().getSimpleName() : null);
        }
    }

    public final void zza(int i, String str, String str2, int i2) {
        zza((String) null, i, str, str2, i2);
    }

    final void zza(String str, int i, String str2, String str3, int i2) {
        Bundle bundle = new Bundle();
        zza(bundle, i);
        if (zzad().zze(str, zzak.zzip)) {
            if (!TextUtils.isEmpty(str2) && !TextUtils.isEmpty(str3)) {
                bundle.putString(str2, str3);
            }
        } else if (!TextUtils.isEmpty(str2)) {
            bundle.putString(str2, str3);
        }
        if (i == 6 || i == 7 || i == 2) {
            bundle.putLong("_el", i2);
        }
        this.zzj.zzae();
        this.zzj.zzq().logEvent("auto", "_err", bundle);
    }

    static MessageDigest getMessageDigest() {
        for (int i = 0; i < 2; i++) {
            try {
                MessageDigest messageDigest = MessageDigest.getInstance(Constants.MD5);
                if (messageDigest != null) {
                    return messageDigest;
                }
            } catch (NoSuchAlgorithmException unused) {
            }
        }
        return null;
    }

    @VisibleForTesting
    static long zzd(byte[] bArr) {
        Preconditions.checkNotNull(bArr);
        int i = 0;
        Preconditions.checkState(bArr.length > 0);
        long j = 0;
        for (int length = bArr.length - 1; length >= 0 && length >= bArr.length - 8; length--) {
            j += (((long) bArr[length]) & 255) << i;
            i += 8;
        }
        return j;
    }

    static boolean zzb(Context context, boolean z) {
        Preconditions.checkNotNull(context);
        if (Build.VERSION.SDK_INT >= 24) {
            return zzb(context, "com.google.android.gms.measurement.AppMeasurementJobService");
        }
        return zzb(context, "com.google.android.gms.measurement.AppMeasurementService");
    }

    private static boolean zzb(Context context, String str) {
        ServiceInfo serviceInfo;
        try {
            PackageManager packageManager = context.getPackageManager();
            return (packageManager == null || (serviceInfo = packageManager.getServiceInfo(new ComponentName(context, str), 0)) == null || !serviceInfo.enabled) ? false : true;
        } catch (PackageManager.NameNotFoundException unused) {
        }
    }

    @WorkerThread
    final boolean zzbp(String str) {
        zzo();
        if (Wrappers.packageManager(getContext()).checkCallingOrSelfPermission(str) == 0) {
            return true;
        }
        zzab().zzgr().zza("Permission not granted", str);
        return false;
    }

    static boolean zzbq(String str) {
        return !TextUtils.isEmpty(str) && str.startsWith("_");
    }

    static boolean zzs(String str, String str2) {
        if (str == null && str2 == null) {
            return true;
        }
        if (str == null) {
            return false;
        }
        return str.equals(str2);
    }

    static boolean zza(Boolean bool, Boolean bool2) {
        if (bool == null && bool2 == null) {
            return true;
        }
        if (bool == null) {
            return false;
        }
        return bool.equals(bool2);
    }

    static boolean zzb(@Nullable List<String> list, @Nullable List<String> list2) {
        if (list == null && list2 == null) {
            return true;
        }
        if (list == null) {
            return false;
        }
        return list.equals(list2);
    }

    final boolean zzbr(String str) {
        if (TextUtils.isEmpty(str)) {
            return false;
        }
        String strZzbu = zzad().zzbu();
        zzae();
        return strZzbu.equals(str);
    }

    final Bundle zzg(Bundle bundle) {
        Bundle bundle2 = new Bundle();
        if (bundle != null) {
            for (String str : bundle.keySet()) {
                Object objZzb = zzb(str, bundle.get(str));
                if (objZzb == null) {
                    zzab().zzgp().zza("Param value can't be null", zzy().zzak(str));
                } else {
                    zza(bundle2, str, objZzb);
                }
            }
        }
        return bundle2;
    }

    final zzai zza(String str, String str2, Bundle bundle, String str3, long j, boolean z, boolean z2) {
        if (TextUtils.isEmpty(str2)) {
            return null;
        }
        if (zzbl(str2) != 0) {
            zzab().zzgk().zza("Invalid conditional property event name", zzy().zzal(str2));
            throw new IllegalArgumentException();
        }
        Bundle bundle2 = bundle != null ? new Bundle(bundle) : new Bundle();
        bundle2.putString("_o", str3);
        return new zzai(str2, new zzah(zzg(zza(str, str2, bundle2, CollectionUtils.listOf("_o"), false, false))), str3, j);
    }

    @WorkerThread
    final long zzc(Context context, String str) {
        zzo();
        Preconditions.checkNotNull(context);
        Preconditions.checkNotEmpty(str);
        PackageManager packageManager = context.getPackageManager();
        MessageDigest messageDigest = getMessageDigest();
        long jZzd = -1;
        if (messageDigest == null) {
            zzab().zzgk().zzao("Could not get MD5 instance");
            return -1L;
        }
        if (packageManager != null) {
            try {
                if (!zzd(context, str)) {
                    PackageInfo packageInfo = Wrappers.packageManager(context).getPackageInfo(getContext().getPackageName(), 64);
                    if (packageInfo.signatures != null && packageInfo.signatures.length > 0) {
                        jZzd = zzd(messageDigest.digest(packageInfo.signatures[0].toByteArray()));
                    } else {
                        zzab().zzgn().zzao("Could not get signatures");
                    }
                    return jZzd;
                }
            } catch (PackageManager.NameNotFoundException e) {
                zzab().zzgk().zza("Package name not found", e);
            }
        }
        return 0L;
    }

    @VisibleForTesting
    private final boolean zzd(Context context, String str) {
        X500Principal x500Principal = new X500Principal("CN=Android Debug,O=Android,C=US");
        try {
            PackageInfo packageInfo = Wrappers.packageManager(context).getPackageInfo(str, 64);
            if (packageInfo == null || packageInfo.signatures == null || packageInfo.signatures.length <= 0) {
                return true;
            }
            return ((X509Certificate) CertificateFactory.getInstance("X.509").generateCertificate(new ByteArrayInputStream(packageInfo.signatures[0].toByteArray()))).getSubjectX500Principal().equals(x500Principal);
        } catch (PackageManager.NameNotFoundException e) {
            zzab().zzgk().zza("Package name not found", e);
            return true;
        } catch (CertificateException e2) {
            zzab().zzgk().zza("Error obtaining certificate", e2);
            return true;
        }
    }

    static byte[] zza(Parcelable parcelable) {
        if (parcelable == null) {
            return null;
        }
        Parcel parcelObtain = Parcel.obtain();
        try {
            parcelable.writeToParcel(parcelObtain, 0);
            return parcelObtain.marshall();
        } finally {
            parcelObtain.recycle();
        }
    }

    public static Bundle zzh(Bundle bundle) {
        if (bundle == null) {
            return new Bundle();
        }
        Bundle bundle2 = new Bundle(bundle);
        for (String str : bundle2.keySet()) {
            Object obj = bundle2.get(str);
            if (obj instanceof Bundle) {
                bundle2.putBundle(str, new Bundle((Bundle) obj));
            } else {
                int i = 0;
                if (obj instanceof Parcelable[]) {
                    Parcelable[] parcelableArr = (Parcelable[]) obj;
                    while (i < parcelableArr.length) {
                        if (parcelableArr[i] instanceof Bundle) {
                            parcelableArr[i] = new Bundle((Bundle) parcelableArr[i]);
                        }
                        i++;
                    }
                } else if (obj instanceof List) {
                    List list = (List) obj;
                    while (i < list.size()) {
                        Object obj2 = list.get(i);
                        if (obj2 instanceof Bundle) {
                            list.set(i, new Bundle((Bundle) obj2));
                        }
                        i++;
                    }
                }
            }
        }
        return bundle2;
    }

    public final int zzjx() {
        if (this.zztz == null) {
            this.zztz = Integer.valueOf(GoogleApiAvailabilityLight.getInstance().getApkVersion(getContext()) / 1000);
        }
        return this.zztz.intValue();
    }

    public final int zzd(int i) {
        return GoogleApiAvailabilityLight.getInstance().isGooglePlayServicesAvailable(getContext(), 12451000);
    }

    public static long zzc(long j, long j2) {
        return (j + (j2 * 60000)) / 86400000;
    }

    @WorkerThread
    final String zzjy() {
        byte[] bArr = new byte[16];
        zzjw().nextBytes(bArr);
        return String.format(Locale.US, "%032x", new BigInteger(1, bArr));
    }

    @WorkerThread
    final void zzb(Bundle bundle, long j) {
        long j2 = bundle.getLong("_et");
        if (j2 != 0) {
            zzab().zzgn().zza("Params already contained engagement", Long.valueOf(j2));
        }
        bundle.putLong("_et", j + j2);
    }

    public final void zzb(com.google.android.gms.internal.measurement.zzp zzpVar, String str) {
        Bundle bundle = new Bundle();
        bundle.putString("r", str);
        try {
            zzpVar.zzb(bundle);
        } catch (RemoteException e) {
            this.zzj.zzab().zzgn().zza("Error returning string value to wrapper", e);
        }
    }

    public final void zza(com.google.android.gms.internal.measurement.zzp zzpVar, long j) {
        Bundle bundle = new Bundle();
        bundle.putLong("r", j);
        try {
            zzpVar.zzb(bundle);
        } catch (RemoteException e) {
            this.zzj.zzab().zzgn().zza("Error returning long value to wrapper", e);
        }
    }

    public final void zza(com.google.android.gms.internal.measurement.zzp zzpVar, int i) {
        Bundle bundle = new Bundle();
        bundle.putInt("r", i);
        try {
            zzpVar.zzb(bundle);
        } catch (RemoteException e) {
            this.zzj.zzab().zzgn().zza("Error returning int value to wrapper", e);
        }
    }

    public final void zza(com.google.android.gms.internal.measurement.zzp zzpVar, byte[] bArr) {
        Bundle bundle = new Bundle();
        bundle.putByteArray("r", bArr);
        try {
            zzpVar.zzb(bundle);
        } catch (RemoteException e) {
            this.zzj.zzab().zzgn().zza("Error returning byte array to wrapper", e);
        }
    }

    public final void zza(com.google.android.gms.internal.measurement.zzp zzpVar, boolean z) {
        Bundle bundle = new Bundle();
        bundle.putBoolean("r", z);
        try {
            zzpVar.zzb(bundle);
        } catch (RemoteException e) {
            this.zzj.zzab().zzgn().zza("Error returning boolean value to wrapper", e);
        }
    }

    public final void zza(com.google.android.gms.internal.measurement.zzp zzpVar, Bundle bundle) {
        try {
            zzpVar.zzb(bundle);
        } catch (RemoteException e) {
            this.zzj.zzab().zzgn().zza("Error returning bundle value to wrapper", e);
        }
    }

    public static Bundle zzc(List<zzjn> list) {
        Bundle bundle = new Bundle();
        if (list == null) {
            return bundle;
        }
        for (zzjn zzjnVar : list) {
            if (zzjnVar.zzkr != null) {
                bundle.putString(zzjnVar.name, zzjnVar.zzkr);
            } else if (zzjnVar.zzts != null) {
                bundle.putLong(zzjnVar.name, zzjnVar.zzts.longValue());
            } else if (zzjnVar.zztu != null) {
                bundle.putDouble(zzjnVar.name, zzjnVar.zztu.doubleValue());
            }
        }
        return bundle;
    }

    public final void zza(com.google.android.gms.internal.measurement.zzp zzpVar, ArrayList<Bundle> arrayList) {
        Bundle bundle = new Bundle();
        bundle.putParcelableArrayList("r", arrayList);
        try {
            zzpVar.zzb(bundle);
        } catch (RemoteException e) {
            this.zzj.zzab().zzgn().zza("Error returning bundle list to wrapper", e);
        }
    }

    public static ArrayList<Bundle> zzd(List<zzq> list) {
        if (list == null) {
            return new ArrayList<>(0);
        }
        ArrayList<Bundle> arrayList = new ArrayList<>(list.size());
        for (zzq zzqVar : list) {
            Bundle bundle = new Bundle();
            bundle.putString("app_id", zzqVar.packageName);
            bundle.putString("origin", zzqVar.origin);
            bundle.putLong(AppMeasurementSdk.ConditionalUserProperty.CREATION_TIMESTAMP, zzqVar.creationTimestamp);
            bundle.putString(AppMeasurementSdk.ConditionalUserProperty.NAME, zzqVar.zzdw.name);
            zzgg.zza(bundle, zzqVar.zzdw.getValue());
            bundle.putBoolean(AppMeasurementSdk.ConditionalUserProperty.ACTIVE, zzqVar.active);
            if (zzqVar.triggerEventName != null) {
                bundle.putString(AppMeasurementSdk.ConditionalUserProperty.TRIGGER_EVENT_NAME, zzqVar.triggerEventName);
            }
            if (zzqVar.zzdx != null) {
                bundle.putString(AppMeasurementSdk.ConditionalUserProperty.TIMED_OUT_EVENT_NAME, zzqVar.zzdx.name);
                if (zzqVar.zzdx.zzfq != null) {
                    bundle.putBundle(AppMeasurementSdk.ConditionalUserProperty.TIMED_OUT_EVENT_PARAMS, zzqVar.zzdx.zzfq.zzcv());
                }
            }
            bundle.putLong(AppMeasurementSdk.ConditionalUserProperty.TRIGGER_TIMEOUT, zzqVar.triggerTimeout);
            if (zzqVar.zzdy != null) {
                bundle.putString(AppMeasurementSdk.ConditionalUserProperty.TRIGGERED_EVENT_NAME, zzqVar.zzdy.name);
                if (zzqVar.zzdy.zzfq != null) {
                    bundle.putBundle(AppMeasurementSdk.ConditionalUserProperty.TRIGGERED_EVENT_PARAMS, zzqVar.zzdy.zzfq.zzcv());
                }
            }
            bundle.putLong(AppMeasurementSdk.ConditionalUserProperty.TRIGGERED_TIMESTAMP, zzqVar.zzdw.zztr);
            bundle.putLong(AppMeasurementSdk.ConditionalUserProperty.TIME_TO_LIVE, zzqVar.timeToLive);
            if (zzqVar.zzdz != null) {
                bundle.putString(AppMeasurementSdk.ConditionalUserProperty.EXPIRED_EVENT_NAME, zzqVar.zzdz.name);
                if (zzqVar.zzdz.zzfq != null) {
                    bundle.putBundle(AppMeasurementSdk.ConditionalUserProperty.EXPIRED_EVENT_PARAMS, zzqVar.zzdz.zzfq.zzcv());
                }
            }
            arrayList.add(bundle);
        }
        return arrayList;
    }

    public final URL zza(long j, @NonNull String str, @NonNull String str2) {
        try {
            Preconditions.checkNotEmpty(str2);
            Preconditions.checkNotEmpty(str);
            return new URL(String.format("https://www.googleadservices.com/pagead/conversion/app/deeplink?id_type=adid&sdk_version=%s&rdid=%s&bundleid=%s", String.format("v%s.%s", Long.valueOf(j), Integer.valueOf(zzjx())), str2, str));
        } catch (IllegalArgumentException | MalformedURLException e) {
            zzab().zzgk().zza("Failed to create BOW URL for Deferred Deep Link. exception", e.getMessage());
            return null;
        }
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzl() {
        super.zzl();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzm() {
        super.zzm();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzn() {
        super.zzn();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzo() {
        super.zzo();
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

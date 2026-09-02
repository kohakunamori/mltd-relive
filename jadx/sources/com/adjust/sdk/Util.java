package com.adjust.sdk;

import android.content.ContentResolver;
import android.content.Context;
import android.content.res.Configuration;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.LocaleList;
import android.os.Looper;
import android.provider.Settings;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import com.adjust.sdk.scheduler.SingleThreadFutureScheduler;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileNotFoundException;
import java.io.NotSerializableException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.regex.Pattern;

/* JADX INFO: loaded from: classes.dex */
public class Util {
    private static final String fieldReadErrorMessage = "Unable to read '%s' field in migration device with message (%s)";
    public static final DecimalFormat SecondsDisplayFormat = newLocalDecimalFormat();
    private static final String DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'Z";
    public static final SimpleDateFormat dateFormatter = new SimpleDateFormat(DATE_FORMAT, Locale.US);
    private static volatile SingleThreadFutureScheduler playAdIdScheduler = null;

    public static String getSdkVersion() {
        return Constants.CLIENT_SDK;
    }

    private static ILogger getLogger() {
        return AdjustFactory.getLogger();
    }

    protected static String createUuid() {
        return UUID.randomUUID().toString();
    }

    private static DecimalFormat newLocalDecimalFormat() {
        return new DecimalFormat("0.0", new DecimalFormatSymbols(Locale.US));
    }

    public static String quote(String str) {
        if (str == null) {
            return null;
        }
        return !Pattern.compile("\\s").matcher(str).find() ? str : formatString("'%s'", str);
    }

    public static Object getAdvertisingInfoObject(final Context context, long j) {
        return runSyncInPlayAdIdSchedulerWithTimeout(context, new Callable<Object>() { // from class: com.adjust.sdk.Util.1
            @Override // java.util.concurrent.Callable
            public Object call() {
                try {
                    return Reflection.getAdvertisingInfoObject(context);
                } catch (Exception unused) {
                    return null;
                }
            }
        }, j);
    }

    public static String getPlayAdId(final Context context, final Object obj, long j) {
        return (String) runSyncInPlayAdIdSchedulerWithTimeout(context, new Callable<String>() { // from class: com.adjust.sdk.Util.2
            @Override // java.util.concurrent.Callable
            public String call() {
                return Reflection.getPlayAdId(context, obj);
            }
        }, j);
    }

    public static Boolean isPlayTrackingEnabled(final Context context, final Object obj, long j) {
        return (Boolean) runSyncInPlayAdIdSchedulerWithTimeout(context, new Callable<Boolean>() { // from class: com.adjust.sdk.Util.3
            /* JADX WARN: Can't rename method to resolve collision */
            @Override // java.util.concurrent.Callable
            public Boolean call() {
                return Reflection.isPlayTrackingEnabled(context, obj);
            }
        }, j);
    }

    private static <R> R runSyncInPlayAdIdSchedulerWithTimeout(Context context, Callable<R> callable, long j) {
        if (playAdIdScheduler == null) {
            synchronized (Util.class) {
                if (playAdIdScheduler == null) {
                    playAdIdScheduler = new SingleThreadFutureScheduler("PlayAdIdLibrary", true);
                }
            }
        }
        try {
            return (R) playAdIdScheduler.scheduleFutureWithReturn(callable, 0L).get(j, TimeUnit.MILLISECONDS);
        } catch (InterruptedException | ExecutionException | TimeoutException unused) {
            return null;
        }
    }

    /* JADX WARN: Type inference failed for: r0v1, types: [com.adjust.sdk.Util$4] */
    public static void runInBackground(Runnable runnable) {
        if (Looper.myLooper() != Looper.getMainLooper()) {
            runnable.run();
        } else {
            new AsyncTask<Object, Void, Void>() { // from class: com.adjust.sdk.Util.4
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                public Void doInBackground(Object... objArr) {
                    ((Runnable) objArr[0]).run();
                    return null;
                }
            }.execute(runnable);
        }
    }

    /* JADX WARN: Type inference failed for: r0v1, types: [com.adjust.sdk.Util$5] */
    public static void getGoogleAdId(Context context, final OnDeviceIdsRead onDeviceIdsRead) {
        ILogger logger = AdjustFactory.getLogger();
        if (Looper.myLooper() != Looper.getMainLooper()) {
            logger.debug("GoogleAdId being read in the background", new Object[0]);
            String googleAdId = getGoogleAdId(context);
            logger.debug("GoogleAdId read " + googleAdId, new Object[0]);
            onDeviceIdsRead.onGoogleAdIdRead(googleAdId);
            return;
        }
        logger.debug("GoogleAdId being read in the foreground", new Object[0]);
        new AsyncTask<Context, Void, String>() { // from class: com.adjust.sdk.Util.5
            /* JADX INFO: Access modifiers changed from: protected */
            @Override // android.os.AsyncTask
            public String doInBackground(Context... contextArr) {
                ILogger logger2 = AdjustFactory.getLogger();
                String googleAdId2 = Util.getGoogleAdId(contextArr[0]);
                logger2.debug("GoogleAdId read " + googleAdId2, new Object[0]);
                return googleAdId2;
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // android.os.AsyncTask
            public void onPostExecute(String str) {
                AdjustFactory.getLogger();
                onDeviceIdsRead.onGoogleAdIdRead(str);
            }
        }.execute(context);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String getGoogleAdId(Context context) {
        Object advertisingInfoObject;
        String gpsAdid = null;
        try {
            GooglePlayServicesClient.GooglePlayServicesInfo googlePlayServicesInfo = GooglePlayServicesClient.getGooglePlayServicesInfo(context, 11000L);
            if (googlePlayServicesInfo != null) {
                gpsAdid = googlePlayServicesInfo.getGpsAdid();
            }
        } catch (Exception unused) {
        }
        return (gpsAdid != null || (advertisingInfoObject = getAdvertisingInfoObject(context, 11000L)) == null) ? gpsAdid : getPlayAdId(context, advertisingInfoObject, 1000L);
    }

    public static String getMacAddress(Context context) {
        return MacAddressUtil.getMacAddress(context);
    }

    public static String getAndroidId(Context context) {
        return AndroidIdUtil.getAndroidId(context);
    }

    /* JADX WARN: Code duplicated, block: B:45:0x00a2 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r7v1 */
    /* JADX WARN: Type inference failed for: r7v11 */
    /* JADX WARN: Type inference failed for: r7v12 */
    /* JADX WARN: Type inference failed for: r7v13, types: [java.io.ObjectInputStream] */
    /* JADX WARN: Type inference failed for: r7v2 */
    /* JADX WARN: Type inference failed for: r7v3 */
    /* JADX WARN: Type inference failed for: r7v4 */
    /* JADX WARN: Type inference failed for: r7v5, types: [java.io.Closeable] */
    /* JADX WARN: Type inference failed for: r7v7, types: [java.io.FileInputStream, java.io.InputStream] */
    /* JADX WARN: Type inference failed for: r7v8 */
    /* JADX WARN: Type inference failed for: r7v9 */
    public static <T> T readObject(Context context, String str, String str2, Class<T> cls) {
        ?? OpenFileInput;
        T t = null;
        try {
            OpenFileInput = context.openFileInput(str);
            try {
                try {
                    BufferedInputStream bufferedInputStream = new BufferedInputStream(OpenFileInput);
                    try {
                        OpenFileInput = new ObjectInputStream(bufferedInputStream);
                        try {
                            T tCast = cls.cast(OpenFileInput.readObject());
                            try {
                                getLogger().debug("Read %s: %s", str2, tCast);
                                t = tCast;
                            } catch (FileNotFoundException unused) {
                                t = tCast;
                                getLogger().debug("%s file not found", str2);
                                if (OpenFileInput != 0) {
                                    try {
                                        OpenFileInput.close();
                                    } catch (Exception e) {
                                        getLogger().error("Failed to close %s file for reading (%s)", str2, e);
                                    }
                                }
                                return t;
                            } catch (ClassCastException e2) {
                                e = e2;
                                t = tCast;
                                getLogger().error("Failed to cast %s object (%s)", str2, e.getMessage());
                            } catch (ClassNotFoundException e3) {
                                e = e3;
                                t = tCast;
                                getLogger().error("Failed to find %s class (%s)", str2, e.getMessage());
                            } catch (Exception e4) {
                                e = e4;
                                t = tCast;
                                getLogger().error("Failed to read %s object (%s)", str2, e.getMessage());
                            }
                        } catch (ClassCastException e5) {
                            e = e5;
                        } catch (ClassNotFoundException e6) {
                            e = e6;
                        } catch (Exception e7) {
                            e = e7;
                        }
                    } catch (FileNotFoundException unused2) {
                        OpenFileInput = bufferedInputStream;
                    } catch (Exception e8) {
                        e = e8;
                        OpenFileInput = bufferedInputStream;
                        getLogger().error("Failed to open %s file for reading (%s)", str2, e);
                    }
                } catch (Exception e9) {
                    e = e9;
                }
            } catch (FileNotFoundException unused3) {
            }
        } catch (FileNotFoundException unused4) {
            OpenFileInput = 0;
        } catch (Exception e10) {
            e = e10;
            OpenFileInput = 0;
        }
        if (OpenFileInput != 0) {
            OpenFileInput.close();
        }
        return t;
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r6v1 */
    /* JADX WARN: Type inference failed for: r6v10 */
    /* JADX WARN: Type inference failed for: r6v11 */
    /* JADX WARN: Type inference failed for: r6v2 */
    /* JADX WARN: Type inference failed for: r6v3, types: [java.io.Closeable] */
    /* JADX WARN: Type inference failed for: r6v5, types: [java.io.FileOutputStream, java.io.OutputStream] */
    /* JADX WARN: Type inference failed for: r6v6 */
    /* JADX WARN: Type inference failed for: r6v7 */
    /* JADX WARN: Type inference failed for: r6v8, types: [java.io.ObjectOutputStream] */
    /* JADX WARN: Type inference failed for: r6v9 */
    public static <T> void writeObject(T t, Context context, String str, String str2) {
        ?? OpenFileOutput;
        ?? r6;
        try {
            OpenFileOutput = context.openFileOutput(str, 0);
            try {
                BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(OpenFileOutput);
                try {
                    OpenFileOutput = new ObjectOutputStream(bufferedOutputStream);
                    try {
                        OpenFileOutput.writeObject(t);
                        getLogger().debug("Wrote %s: %s", str2, t);
                        r6 = OpenFileOutput;
                    } catch (NotSerializableException unused) {
                        getLogger().error("Failed to serialize %s", str2);
                        r6 = OpenFileOutput;
                    }
                } catch (Exception e) {
                    e = e;
                    OpenFileOutput = bufferedOutputStream;
                    getLogger().error("Failed to open %s for writing (%s)", str2, e);
                    r6 = OpenFileOutput;
                }
            } catch (Exception e2) {
                e = e2;
                getLogger().error("Failed to open %s for writing (%s)", str2, e);
                r6 = OpenFileOutput;
            }
        } catch (Exception e3) {
            e = e3;
            OpenFileOutput = 0;
        }
        if (r6 != 0) {
            try {
                r6.close();
            } catch (Exception e4) {
                getLogger().error("Failed to close %s file for writing (%s)", str2, e4);
            }
        }
    }

    public static boolean checkPermission(Context context, String str) {
        try {
            return context.checkCallingOrSelfPermission(str) == 0;
        } catch (Exception e) {
            getLogger().debug("Unable to check permission '%s' with message (%s)", str, e.getMessage());
            return false;
        }
    }

    public static String readStringField(ObjectInputStream.GetField getField, String str, String str2) {
        return (String) readObjectField(getField, str, str2);
    }

    public static <T> T readObjectField(ObjectInputStream.GetField getField, String str, T t) {
        try {
            return (T) getField.get(str, t);
        } catch (Exception e) {
            getLogger().debug(fieldReadErrorMessage, str, e.getMessage());
            return t;
        }
    }

    public static boolean readBooleanField(ObjectInputStream.GetField getField, String str, boolean z) {
        try {
            return getField.get(str, z);
        } catch (Exception e) {
            getLogger().debug(fieldReadErrorMessage, str, e.getMessage());
            return z;
        }
    }

    public static int readIntField(ObjectInputStream.GetField getField, String str, int i) {
        try {
            return getField.get(str, i);
        } catch (Exception e) {
            getLogger().debug(fieldReadErrorMessage, str, e.getMessage());
            return i;
        }
    }

    public static long readLongField(ObjectInputStream.GetField getField, String str, long j) {
        try {
            return getField.get(str, j);
        } catch (Exception e) {
            getLogger().debug(fieldReadErrorMessage, str, e.getMessage());
            return j;
        }
    }

    public static boolean equalObject(Object obj, Object obj2) {
        if (obj == null || obj2 == null) {
            return obj == null && obj2 == null;
        }
        return obj.equals(obj2);
    }

    public static boolean equalsDouble(Double d, Double d2) {
        if (d == null || d2 == null) {
            return d == null && d2 == null;
        }
        return Double.doubleToLongBits(d.doubleValue()) == Double.doubleToLongBits(d2.doubleValue());
    }

    public static boolean equalString(String str, String str2) {
        return equalObject(str, str2);
    }

    public static boolean equalEnum(Enum r0, Enum r1) {
        return equalObject(r0, r1);
    }

    public static boolean equalLong(Long l, Long l2) {
        return equalObject(l, l2);
    }

    public static boolean equalInt(Integer num, Integer num2) {
        return equalObject(num, num2);
    }

    public static boolean equalBoolean(Boolean bool, Boolean bool2) {
        return equalObject(bool, bool2);
    }

    public static int hashBoolean(Boolean bool) {
        if (bool == null) {
            return 0;
        }
        return bool.hashCode();
    }

    public static int hashLong(Long l) {
        if (l == null) {
            return 0;
        }
        return l.hashCode();
    }

    public static int hashDouble(Double d) {
        if (d == null) {
            return 0;
        }
        return d.hashCode();
    }

    public static int hashString(String str) {
        if (str == null) {
            return 0;
        }
        return str.hashCode();
    }

    public static int hashEnum(Enum r0) {
        if (r0 == null) {
            return 0;
        }
        return r0.hashCode();
    }

    public static int hashObject(Object obj) {
        if (obj == null) {
            return 0;
        }
        return obj.hashCode();
    }

    public static String sha1(String str) {
        return hash(str, Constants.SHA1);
    }

    public static String sha256(String str) {
        return hash(str, Constants.SHA256);
    }

    public static String md5(String str) {
        return hash(str, Constants.MD5);
    }

    public static String hash(String str, String str2) {
        try {
            byte[] bytes = str.getBytes(Constants.ENCODING);
            MessageDigest messageDigest = MessageDigest.getInstance(str2);
            messageDigest.update(bytes, 0, bytes.length);
            return convertToHex(messageDigest.digest());
        } catch (Exception unused) {
            return null;
        }
    }

    public static String convertToHex(byte[] bArr) {
        return formatString("%0" + (bArr.length << 1) + "x", new BigInteger(1, bArr));
    }

    public static String[] getSupportedAbis() {
        if (Build.VERSION.SDK_INT >= 21) {
            return Build.SUPPORTED_ABIS;
        }
        return null;
    }

    public static String getCpuAbi() {
        if (Build.VERSION.SDK_INT < 21) {
            return Build.CPU_ABI;
        }
        return null;
    }

    public static String getReasonString(String str, Throwable th) {
        return th != null ? formatString("%s: %s", str, th) : formatString("%s", str);
    }

    public static long getWaitingTime(int i, BackoffStrategy backoffStrategy) {
        if (i < backoffStrategy.minRetries) {
            return 0L;
        }
        long jMin = Math.min(((long) Math.pow(2.0d, i - backoffStrategy.minRetries)) * backoffStrategy.milliSecondMultiplier, backoffStrategy.maxWait);
        double dRandomInRange = randomInRange(backoffStrategy.minRange, backoffStrategy.maxRange);
        double d = jMin;
        Double.isNaN(d);
        return (long) (d * dRandomInRange);
    }

    private static double randomInRange(double d, double d2) {
        return (new Random().nextDouble() * (d2 - d)) + d;
    }

    public static boolean isValidParameter(String str, String str2, String str3) {
        if (str == null) {
            getLogger().error("%s parameter %s is missing", str3, str2);
            return false;
        }
        if (!str.equals("")) {
            return true;
        }
        getLogger().error("%s parameter %s is empty", str3, str2);
        return false;
    }

    public static Map<String, String> mergeParameters(Map<String, String> map, Map<String, String> map2, String str) {
        if (map == null) {
            return map2;
        }
        if (map2 == null) {
            return map;
        }
        HashMap map3 = new HashMap(map);
        ILogger logger = getLogger();
        for (Map.Entry<String, String> entry : map2.entrySet()) {
            String str2 = (String) map3.put(entry.getKey(), entry.getValue());
            if (str2 != null) {
                logger.warn("Key %s with value %s from %s parameter was replaced by value %s", entry.getKey(), str2, str, entry.getValue());
            }
        }
        return map3;
    }

    public static Locale getLocale(Configuration configuration) {
        LocaleList locales;
        if (Build.VERSION.SDK_INT >= 24 && (locales = configuration.getLocales()) != null && !locales.isEmpty()) {
            return locales.get(0);
        }
        if (Build.VERSION.SDK_INT < 24) {
            return configuration.locale;
        }
        return null;
    }

    public static String getFireAdvertisingId(ContentResolver contentResolver) {
        if (contentResolver == null) {
            return null;
        }
        try {
            return Settings.Secure.getString(contentResolver, "advertising_id");
        } catch (Exception unused) {
            return null;
        }
    }

    public static Boolean getFireTrackingEnabled(ContentResolver contentResolver) {
        try {
            return Boolean.valueOf(Settings.Secure.getInt(contentResolver, "limit_ad_tracking") == 0);
        } catch (Exception unused) {
            return null;
        }
    }

    public static int getConnectivityType(Context context) {
        NetworkCapabilities networkCapabilities;
        try {
            ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService("connectivity");
            if (connectivityManager == null) {
                return -1;
            }
            if (Build.VERSION.SDK_INT < 23) {
                return connectivityManager.getActiveNetworkInfo().getType();
            }
            Network activeNetwork = connectivityManager.getActiveNetwork();
            if (activeNetwork == null || (networkCapabilities = connectivityManager.getNetworkCapabilities(activeNetwork)) == null) {
                return -1;
            }
            if (networkCapabilities.hasTransport(1)) {
                return 1;
            }
            if (networkCapabilities.hasTransport(0)) {
                return 0;
            }
            if (networkCapabilities.hasTransport(3)) {
                return 3;
            }
            if (networkCapabilities.hasTransport(4)) {
                return 4;
            }
            if (networkCapabilities.hasTransport(2)) {
                return 2;
            }
            if (Build.VERSION.SDK_INT < 26) {
                return -1;
            }
            if (networkCapabilities.hasTransport(5)) {
                return 5;
            }
            return (Build.VERSION.SDK_INT >= 27 && networkCapabilities.hasTransport(6)) ? 6 : -1;
        } catch (Exception e) {
            getLogger().warn("Couldn't read connectivity type (%s)", e.getMessage());
        }
    }

    public static int getNetworkType(Context context) {
        int networkType;
        try {
            TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService("phone");
            if (Build.VERSION.SDK_INT >= 30) {
                networkType = telephonyManager.getDataNetworkType();
            } else {
                networkType = telephonyManager.getNetworkType();
            }
            return networkType;
        } catch (Exception e) {
            getLogger().warn("Couldn't read network type (%s)", e.getMessage());
            return -1;
        }
    }

    public static String getMcc(Context context) {
        try {
            String networkOperator = ((TelephonyManager) context.getSystemService("phone")).getNetworkOperator();
            if (TextUtils.isEmpty(networkOperator)) {
                AdjustFactory.getLogger().warn("Couldn't receive networkOperator string to read MCC", new Object[0]);
                return null;
            }
            return networkOperator.substring(0, 3);
        } catch (Exception unused) {
            AdjustFactory.getLogger().warn("Couldn't return mcc", new Object[0]);
            return null;
        }
    }

    public static String getMnc(Context context) {
        try {
            String networkOperator = ((TelephonyManager) context.getSystemService("phone")).getNetworkOperator();
            if (TextUtils.isEmpty(networkOperator)) {
                AdjustFactory.getLogger().warn("Couldn't receive networkOperator string to read MNC", new Object[0]);
                return null;
            }
            return networkOperator.substring(3);
        } catch (Exception unused) {
            AdjustFactory.getLogger().warn("Couldn't return mnc", new Object[0]);
            return null;
        }
    }

    public static String formatString(String str, Object... objArr) {
        return String.format(Locale.US, str, objArr);
    }

    public static boolean hasRootCause(Exception exc) {
        StringWriter stringWriter = new StringWriter();
        exc.printStackTrace(new PrintWriter(stringWriter));
        return stringWriter.toString().contains("Caused by:");
    }

    public static String getRootCause(Exception exc) {
        if (!hasRootCause(exc)) {
            return null;
        }
        StringWriter stringWriter = new StringWriter();
        exc.printStackTrace(new PrintWriter(stringWriter));
        String string = stringWriter.toString();
        int iIndexOf = string.indexOf("Caused by:");
        return string.substring(iIndexOf, string.indexOf("\n", iIndexOf));
    }

    private static String getSdkPrefix(String str) {
        String[] strArrSplit;
        if (str != null && str.contains("@") && (strArrSplit = str.split("@")) != null && strArrSplit.length == 2) {
            return strArrSplit[0];
        }
        return null;
    }

    public static String getSdkPrefixPlatform(String str) {
        String[] strArrSplit;
        String sdkPrefix = getSdkPrefix(str);
        if (sdkPrefix == null || (strArrSplit = sdkPrefix.split("\\d+", 2)) == null || strArrSplit.length == 0) {
            return null;
        }
        return strArrSplit[0];
    }

    public static boolean isUrlFilteredOut(Uri uri) {
        String string;
        return uri == null || (string = uri.toString()) == null || string.length() == 0 || string.matches(Constants.FB_AUTH_REGEX);
    }

    public static boolean resolveContentProvider(Context context, String str) {
        try {
            return context.getPackageManager().resolveContentProvider(str, 0) != null;
        } catch (Exception unused) {
            return false;
        }
    }

    public static boolean isEqualReferrerDetails(ReferrerDetails referrerDetails, String str, ActivityState activityState) {
        if (str.equals(Constants.REFERRER_API_GOOGLE)) {
            return isEqualGoogleReferrerDetails(referrerDetails, activityState);
        }
        if (str.equals(Constants.REFERRER_API_HUAWEI)) {
            return isEqualHuaweiReferrerDetails(referrerDetails, activityState);
        }
        return false;
    }

    private static boolean isEqualGoogleReferrerDetails(ReferrerDetails referrerDetails, ActivityState activityState) {
        return referrerDetails.referrerClickTimestampSeconds == activityState.clickTime && referrerDetails.installBeginTimestampSeconds == activityState.installBegin && referrerDetails.referrerClickTimestampServerSeconds == activityState.clickTimeServer && referrerDetails.installBeginTimestampServerSeconds == activityState.installBeginServer && equalString(referrerDetails.installReferrer, activityState.installReferrer) && equalString(referrerDetails.installVersion, activityState.installVersion) && equalBoolean(referrerDetails.googlePlayInstant, activityState.googlePlayInstant);
    }

    private static boolean isEqualHuaweiReferrerDetails(ReferrerDetails referrerDetails, ActivityState activityState) {
        return referrerDetails.referrerClickTimestampSeconds == activityState.clickTimeHuawei && referrerDetails.installBeginTimestampSeconds == activityState.installBeginHuawei && equalString(referrerDetails.installReferrer, activityState.installReferrerHuawei);
    }
}

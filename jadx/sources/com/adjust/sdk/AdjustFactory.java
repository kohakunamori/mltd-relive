package com.adjust.sdk;

import android.content.Context;
import com.adjust.sdk.network.IActivityPackageSender;
import com.adjust.sdk.network.UtilNetworking;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;

/* JADX INFO: loaded from: classes.dex */
public class AdjustFactory {
    private static IActivityHandler activityHandler = null;
    private static IAttributionHandler attributionHandler = null;
    private static String baseUrl = null;
    private static UtilNetworking.IConnectionOptions connectionOptions = null;
    private static String gdprUrl = null;
    private static UtilNetworking.IHttpsURLConnectionProvider httpsURLConnectionProvider = null;
    private static BackoffStrategy installSessionBackoffStrategy = null;
    private static ILogger logger = null;
    private static long maxDelayStart = -1;
    private static IPackageHandler packageHandler = null;
    private static BackoffStrategy packageHandlerBackoffStrategy = null;
    private static BackoffStrategy sdkClickBackoffStrategy = null;
    private static ISdkClickHandler sdkClickHandler = null;
    private static long sessionInterval = -1;
    private static String subscriptionUrl = null;
    private static long subsessionInterval = -1;
    private static long timerInterval = -1;
    private static long timerStart = -1;
    private static boolean tryInstallReferrer = true;

    public static class URLGetConnection {
        HttpsURLConnection httpsURLConnection;
        URL url;

        URLGetConnection(HttpsURLConnection httpsURLConnection, URL url) {
            this.httpsURLConnection = httpsURLConnection;
            this.url = url;
        }
    }

    public static IPackageHandler getPackageHandler(IActivityHandler iActivityHandler, Context context, boolean z, IActivityPackageSender iActivityPackageSender) {
        if (packageHandler == null) {
            return new PackageHandler(iActivityHandler, context, z, iActivityPackageSender);
        }
        packageHandler.init(iActivityHandler, context, z, iActivityPackageSender);
        return packageHandler;
    }

    public static ILogger getLogger() {
        if (logger == null) {
            logger = new Logger();
        }
        return logger;
    }

    public static long getTimerInterval() {
        if (timerInterval == -1) {
            return 60000L;
        }
        return timerInterval;
    }

    public static long getTimerStart() {
        if (timerStart == -1) {
            return 60000L;
        }
        return timerStart;
    }

    public static long getSessionInterval() {
        if (sessionInterval == -1) {
            return 1800000L;
        }
        return sessionInterval;
    }

    public static long getSubsessionInterval() {
        if (subsessionInterval == -1) {
            return 1000L;
        }
        return subsessionInterval;
    }

    public static BackoffStrategy getSdkClickBackoffStrategy() {
        if (sdkClickBackoffStrategy == null) {
            return BackoffStrategy.SHORT_WAIT;
        }
        return sdkClickBackoffStrategy;
    }

    public static BackoffStrategy getPackageHandlerBackoffStrategy() {
        if (packageHandlerBackoffStrategy == null) {
            return BackoffStrategy.LONG_WAIT;
        }
        return packageHandlerBackoffStrategy;
    }

    public static BackoffStrategy getInstallSessionBackoffStrategy() {
        if (installSessionBackoffStrategy == null) {
            return BackoffStrategy.SHORT_WAIT;
        }
        return installSessionBackoffStrategy;
    }

    public static IActivityHandler getActivityHandler(AdjustConfig adjustConfig) {
        if (activityHandler == null) {
            return ActivityHandler.getInstance(adjustConfig);
        }
        activityHandler.init(adjustConfig);
        return activityHandler;
    }

    public static IAttributionHandler getAttributionHandler(IActivityHandler iActivityHandler, boolean z, IActivityPackageSender iActivityPackageSender) {
        if (attributionHandler == null) {
            return new AttributionHandler(iActivityHandler, z, iActivityPackageSender);
        }
        attributionHandler.init(iActivityHandler, z, iActivityPackageSender);
        return attributionHandler;
    }

    public static ISdkClickHandler getSdkClickHandler(IActivityHandler iActivityHandler, boolean z, IActivityPackageSender iActivityPackageSender) {
        if (sdkClickHandler == null) {
            return new SdkClickHandler(iActivityHandler, z, iActivityPackageSender);
        }
        sdkClickHandler.init(iActivityHandler, z, iActivityPackageSender);
        return sdkClickHandler;
    }

    public static long getMaxDelayStart() {
        if (maxDelayStart == -1) {
            return 10000L;
        }
        return maxDelayStart;
    }

    public static String getBaseUrl() {
        return baseUrl;
    }

    public static String getGdprUrl() {
        return gdprUrl;
    }

    public static String getSubscriptionUrl() {
        return subscriptionUrl;
    }

    public static UtilNetworking.IConnectionOptions getConnectionOptions() {
        if (connectionOptions == null) {
            return UtilNetworking.createDefaultConnectionOptions();
        }
        return connectionOptions;
    }

    public static UtilNetworking.IHttpsURLConnectionProvider getHttpsURLConnectionProvider() {
        if (httpsURLConnectionProvider == null) {
            return UtilNetworking.createDefaultHttpsURLConnectionProvider();
        }
        return httpsURLConnectionProvider;
    }

    public static boolean getTryInstallReferrer() {
        return tryInstallReferrer;
    }

    public static void setPackageHandler(IPackageHandler iPackageHandler) {
        packageHandler = iPackageHandler;
    }

    public static void setLogger(ILogger iLogger) {
        logger = iLogger;
    }

    public static void setTimerInterval(long j) {
        timerInterval = j;
    }

    public static void setTimerStart(long j) {
        timerStart = j;
    }

    public static void setSessionInterval(long j) {
        sessionInterval = j;
    }

    public static void setSubsessionInterval(long j) {
        subsessionInterval = j;
    }

    public static void setSdkClickBackoffStrategy(BackoffStrategy backoffStrategy) {
        sdkClickBackoffStrategy = backoffStrategy;
    }

    public static void setPackageHandlerBackoffStrategy(BackoffStrategy backoffStrategy) {
        packageHandlerBackoffStrategy = backoffStrategy;
    }

    public static void setActivityHandler(IActivityHandler iActivityHandler) {
        activityHandler = iActivityHandler;
    }

    public static void setAttributionHandler(IAttributionHandler iAttributionHandler) {
        attributionHandler = iAttributionHandler;
    }

    public static void setSdkClickHandler(ISdkClickHandler iSdkClickHandler) {
        sdkClickHandler = iSdkClickHandler;
    }

    public static void setBaseUrl(String str) {
        baseUrl = str;
    }

    public static void setGdprUrl(String str) {
        gdprUrl = str;
    }

    public static void setSubscriptionUrl(String str) {
        subscriptionUrl = str;
    }

    public static void setConnectionOptions(UtilNetworking.IConnectionOptions iConnectionOptions) {
        connectionOptions = iConnectionOptions;
    }

    public static void setHttpsURLConnectionProvider(UtilNetworking.IHttpsURLConnectionProvider iHttpsURLConnectionProvider) {
        httpsURLConnectionProvider = iHttpsURLConnectionProvider;
    }

    public static void setTryInstallReferrer(boolean z) {
        tryInstallReferrer = z;
    }

    public static void enableSigning() {
        AdjustSigner.enableSigning(getLogger());
    }

    public static void disableSigning() {
        AdjustSigner.disableSigning(getLogger());
    }

    private static String byte2HexFormatted(byte[] bArr) {
        StringBuilder sb = new StringBuilder(bArr.length * 2);
        for (byte b : bArr) {
            String hexString = Integer.toHexString(b);
            int length = hexString.length();
            if (length == 1) {
                hexString = "0" + hexString;
            }
            if (length > 2) {
                hexString = hexString.substring(length - 2, length);
            }
            sb.append(hexString.toUpperCase());
        }
        return sb.toString();
    }

    public static void teardown(Context context) {
        if (context != null) {
            ActivityHandler.deleteState(context);
            PackageHandler.deleteState(context);
        }
        packageHandler = null;
        attributionHandler = null;
        activityHandler = null;
        logger = null;
        sdkClickHandler = null;
        timerInterval = -1L;
        timerStart = -1L;
        sessionInterval = -1L;
        subsessionInterval = -1L;
        sdkClickBackoffStrategy = null;
        packageHandlerBackoffStrategy = null;
        maxDelayStart = -1L;
        baseUrl = Constants.BASE_URL;
        gdprUrl = Constants.GDPR_URL;
        subscriptionUrl = Constants.SUBSCRIPTION_URL;
        connectionOptions = null;
        httpsURLConnectionProvider = null;
        tryInstallReferrer = true;
    }
}

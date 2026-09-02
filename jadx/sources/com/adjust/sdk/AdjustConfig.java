package com.adjust.sdk;

import android.content.Context;

/* JADX INFO: loaded from: classes.dex */
public class AdjustConfig {
    public static final String AD_REVENUE_ADDAPTR = "addapptr";
    public static final String AD_REVENUE_ADINCUBE = "adincube";
    public static final String AD_REVENUE_ADMOB = "admob";
    public static final String AD_REVENUE_ADMOST = "admost";
    public static final String AD_REVENUE_ADTOAPP = "adtoapp";
    public static final String AD_REVENUE_AERSERV = "aerserv";
    public static final String AD_REVENUE_APPODEAL = "appodeal";
    public static final String AD_REVENUE_DELTADNA = "deltadna";
    public static final String AD_REVENUE_FB_AUDIENCE_NETWORK = "facebook_audience_network";
    public static final String AD_REVENUE_FB_NATIVE_AD = "facebook_native_ad";
    public static final String AD_REVENUE_FLURRY = "flurry";
    public static final String AD_REVENUE_FUSE_POWERED = "fusepowered";
    public static final String AD_REVENUE_FYBER = "fyber";
    public static final String AD_REVENUE_IRONSOURCE = "ironsource";
    public static final String AD_REVENUE_MILLENNIAL_MEDITATION = "millennial_mediation";
    public static final String AD_REVENUE_MOPUB = "mopub";
    public static final String AD_REVENUE_TAPDAQ = "tapdaq";
    public static final String AD_REVENUE_UNITYADS = "unityads";
    public static final String AD_REVENUE_UPSIGHT = "upsight";
    public static final String DATA_RESIDENCY_EU = "data_residency_eu";
    public static final String ENVIRONMENT_PRODUCTION = "production";
    public static final String ENVIRONMENT_SANDBOX = "sandbox";
    public static final String URL_STRATEGY_CHINA = "url_strategy_china";
    public static final String URL_STRATEGY_INDIA = "url_strategy_india";
    String appSecret;
    String appToken;
    String basePath;
    Context context;
    Class deepLinkComponent;
    String defaultTracker;
    Double delayStart;
    Boolean deviceKnown;
    String environment;
    boolean eventBufferingEnabled;
    String externalDeviceId;
    String gdprPath;
    ILogger logger;
    Boolean needsCost;
    OnAttributionChangedListener onAttributionChangedListener;
    OnDeeplinkResponseListener onDeeplinkResponseListener;
    OnEventTrackingFailedListener onEventTrackingFailedListener;
    OnEventTrackingSucceededListener onEventTrackingSucceededListener;
    OnSessionTrackingFailedListener onSessionTrackingFailedListener;
    OnSessionTrackingSucceededListener onSessionTrackingSucceededListener;
    AdjustInstance.PreLaunchActions preLaunchActions;
    boolean preinstallTrackingEnabled;
    String processName;
    String pushToken;
    String sdkPrefix;
    String secretId;
    boolean sendInBackground;
    Boolean startEnabled;
    boolean startOffline;
    String subscriptionPath;
    String urlStrategy;
    String userAgent;

    public AdjustConfig(Context context, String str, String str2) {
        init(context, str, str2, false);
    }

    public AdjustConfig(Context context, String str, String str2, boolean z) {
        init(context, str, str2, z);
    }

    private void init(Context context, String str, String str2, boolean z) {
        this.logger = AdjustFactory.getLogger();
        if (z && ENVIRONMENT_PRODUCTION.equals(str2)) {
            setLogLevel(LogLevel.SUPRESS, str2);
        } else {
            setLogLevel(LogLevel.INFO, str2);
        }
        if (context != null) {
            context = context.getApplicationContext();
        }
        this.context = context;
        this.appToken = str;
        this.environment = str2;
        this.eventBufferingEnabled = false;
        this.sendInBackground = false;
        this.preinstallTrackingEnabled = false;
    }

    public void setEventBufferingEnabled(Boolean bool) {
        if (bool == null) {
            this.eventBufferingEnabled = false;
        } else {
            this.eventBufferingEnabled = bool.booleanValue();
        }
    }

    public void setSendInBackground(boolean z) {
        this.sendInBackground = z;
    }

    public void setLogLevel(LogLevel logLevel) {
        setLogLevel(logLevel, this.environment);
    }

    public void setSdkPrefix(String str) {
        this.sdkPrefix = str;
    }

    public void setProcessName(String str) {
        this.processName = str;
    }

    public void setDefaultTracker(String str) {
        this.defaultTracker = str;
    }

    public void setOnAttributionChangedListener(OnAttributionChangedListener onAttributionChangedListener) {
        this.onAttributionChangedListener = onAttributionChangedListener;
    }

    public void setDeviceKnown(boolean z) {
        this.deviceKnown = Boolean.valueOf(z);
    }

    public void setDeepLinkComponent(Class cls) {
        this.deepLinkComponent = cls;
    }

    public void setOnEventTrackingSucceededListener(OnEventTrackingSucceededListener onEventTrackingSucceededListener) {
        this.onEventTrackingSucceededListener = onEventTrackingSucceededListener;
    }

    public void setOnEventTrackingFailedListener(OnEventTrackingFailedListener onEventTrackingFailedListener) {
        this.onEventTrackingFailedListener = onEventTrackingFailedListener;
    }

    public void setOnSessionTrackingSucceededListener(OnSessionTrackingSucceededListener onSessionTrackingSucceededListener) {
        this.onSessionTrackingSucceededListener = onSessionTrackingSucceededListener;
    }

    public void setOnSessionTrackingFailedListener(OnSessionTrackingFailedListener onSessionTrackingFailedListener) {
        this.onSessionTrackingFailedListener = onSessionTrackingFailedListener;
    }

    public void setOnDeeplinkResponseListener(OnDeeplinkResponseListener onDeeplinkResponseListener) {
        this.onDeeplinkResponseListener = onDeeplinkResponseListener;
    }

    public void setDelayStart(double d) {
        this.delayStart = Double.valueOf(d);
    }

    public void setUserAgent(String str) {
        this.userAgent = str;
    }

    public void setAppSecret(long j, long j2, long j3, long j4, long j5) {
        this.secretId = Util.formatString("%d", Long.valueOf(j));
        this.appSecret = Util.formatString("%d%d%d%d", Long.valueOf(j2), Long.valueOf(j3), Long.valueOf(j4), Long.valueOf(j5));
    }

    @Deprecated
    public void setReadMobileEquipmentIdentity(boolean z) {
        this.logger.warn("This method has been deprecated and shouldn't be used anymore", new Object[0]);
    }

    public void setExternalDeviceId(String str) {
        this.externalDeviceId = str;
    }

    public void setPreinstallTrackingEnabled(boolean z) {
        this.preinstallTrackingEnabled = z;
    }

    public void setNeedsCost(boolean z) {
        this.needsCost = Boolean.valueOf(z);
    }

    public boolean isValid() {
        return checkAppToken(this.appToken) && checkEnvironment(this.environment) && checkContext(this.context);
    }

    public void setUrlStrategy(String str) {
        if (str == null || str.isEmpty()) {
            this.logger.error("Invalid url strategy", new Object[0]);
            return;
        }
        if (!str.equals(URL_STRATEGY_INDIA) && !str.equals(URL_STRATEGY_CHINA) && !str.equals(DATA_RESIDENCY_EU)) {
            this.logger.warn("Unrecognised url strategy %s", str);
        }
        this.urlStrategy = str;
    }

    private void setLogLevel(LogLevel logLevel, String str) {
        this.logger.setLogLevel(logLevel, ENVIRONMENT_PRODUCTION.equals(str));
    }

    private boolean checkContext(Context context) {
        if (context == null) {
            this.logger.error("Missing context", new Object[0]);
            return false;
        }
        if (Util.checkPermission(context, "android.permission.INTERNET")) {
            return true;
        }
        this.logger.error("Missing permission: INTERNET", new Object[0]);
        return false;
    }

    private boolean checkAppToken(String str) {
        if (str == null) {
            this.logger.error("Missing App Token", new Object[0]);
            return false;
        }
        if (str.length() == 12) {
            return true;
        }
        this.logger.error("Malformed App Token '%s'", str);
        return false;
    }

    private boolean checkEnvironment(String str) {
        if (str == null) {
            this.logger.error("Missing environment", new Object[0]);
            return false;
        }
        if (str.equals(ENVIRONMENT_SANDBOX)) {
            this.logger.warnInProduction("SANDBOX: Adjust is running in Sandbox mode. Use this setting for testing. Don't forget to set the environment to `production` before publishing!", new Object[0]);
            return true;
        }
        if (str.equals(ENVIRONMENT_PRODUCTION)) {
            this.logger.warnInProduction("PRODUCTION: Adjust is running in Production mode. Use this setting only for the build that you want to publish. Set the environment to `sandbox` if you want to test your app!", new Object[0]);
            return true;
        }
        this.logger.error("Unknown environment '%s'", str);
        return false;
    }
}

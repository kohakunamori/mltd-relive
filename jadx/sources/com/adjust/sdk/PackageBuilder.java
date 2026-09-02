package com.adjust.sdk;

import android.content.ContentResolver;
import android.text.TextUtils;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class PackageBuilder {
    private static ILogger logger = AdjustFactory.getLogger();
    private ActivityStateCopy activityStateCopy;
    private AdjustConfig adjustConfig;
    AdjustAttribution attribution;
    private long createdAt;
    String deeplink;
    private DeviceInfo deviceInfo;
    Map<String, String> extraParameters;
    Boolean googlePlayInstant;
    String installVersion;
    String preinstallLocation;
    String preinstallPayload;
    String rawReferrer;
    String referrer;
    String referrerApi;
    String reftag;
    private SessionParameters sessionParameters;
    long clickTimeInSeconds = -1;
    long clickTimeInMilliseconds = -1;
    long installBeginTimeInSeconds = -1;
    long clickTimeServerInSeconds = -1;
    long installBeginTimeServerInSeconds = -1;

    private class ActivityStateCopy {
        int eventCount;
        long lastInterval;
        String pushToken;
        int sessionCount;
        long sessionLength;
        int subsessionCount;
        long timeSpent;
        String uuid;

        ActivityStateCopy(ActivityState activityState) {
            this.eventCount = -1;
            this.sessionCount = -1;
            this.subsessionCount = -1;
            this.timeSpent = -1L;
            this.lastInterval = -1L;
            this.sessionLength = -1L;
            this.uuid = null;
            this.pushToken = null;
            if (activityState == null) {
                return;
            }
            this.eventCount = activityState.eventCount;
            this.sessionCount = activityState.sessionCount;
            this.subsessionCount = activityState.subsessionCount;
            this.timeSpent = activityState.timeSpent;
            this.lastInterval = activityState.lastInterval;
            this.sessionLength = activityState.sessionLength;
            this.uuid = activityState.uuid;
            this.pushToken = activityState.pushToken;
        }
    }

    PackageBuilder(AdjustConfig adjustConfig, DeviceInfo deviceInfo, ActivityState activityState, SessionParameters sessionParameters, long j) {
        this.createdAt = j;
        this.deviceInfo = deviceInfo;
        this.adjustConfig = adjustConfig;
        this.activityStateCopy = new ActivityStateCopy(activityState);
        this.sessionParameters = sessionParameters;
    }

    ActivityPackage buildSessionPackage(boolean z) {
        Map<String, String> sessionParameters = getSessionParameters(z);
        ActivityPackage defaultActivityPackage = getDefaultActivityPackage(ActivityKind.SESSION);
        defaultActivityPackage.setPath("/session");
        defaultActivityPackage.setSuffix("");
        AdjustSigner.sign(sessionParameters, ActivityKind.SESSION.toString(), defaultActivityPackage.getClientSdk(), this.adjustConfig.context, this.adjustConfig.logger);
        defaultActivityPackage.setParameters(sessionParameters);
        return defaultActivityPackage;
    }

    ActivityPackage buildEventPackage(AdjustEvent adjustEvent, boolean z) {
        Map<String, String> eventParameters = getEventParameters(adjustEvent, z);
        ActivityPackage defaultActivityPackage = getDefaultActivityPackage(ActivityKind.EVENT);
        defaultActivityPackage.setPath("/event");
        defaultActivityPackage.setSuffix(getEventSuffix(adjustEvent));
        AdjustSigner.sign(eventParameters, ActivityKind.EVENT.toString(), defaultActivityPackage.getClientSdk(), this.adjustConfig.context, this.adjustConfig.logger);
        defaultActivityPackage.setParameters(eventParameters);
        if (z) {
            defaultActivityPackage.setCallbackParameters(adjustEvent.callbackParameters);
            defaultActivityPackage.setPartnerParameters(adjustEvent.partnerParameters);
        }
        return defaultActivityPackage;
    }

    ActivityPackage buildInfoPackage(String str) {
        Map<String, String> infoParameters = getInfoParameters(str);
        ActivityPackage defaultActivityPackage = getDefaultActivityPackage(ActivityKind.INFO);
        defaultActivityPackage.setPath("/sdk_info");
        defaultActivityPackage.setSuffix("");
        AdjustSigner.sign(infoParameters, ActivityKind.INFO.toString(), defaultActivityPackage.getClientSdk(), this.adjustConfig.context, this.adjustConfig.logger);
        defaultActivityPackage.setParameters(infoParameters);
        return defaultActivityPackage;
    }

    ActivityPackage buildClickPackage(String str) {
        Map<String, String> clickParameters = getClickParameters(str);
        ActivityPackage defaultActivityPackage = getDefaultActivityPackage(ActivityKind.CLICK);
        defaultActivityPackage.setPath("/sdk_click");
        defaultActivityPackage.setSuffix("");
        defaultActivityPackage.setClickTimeInMilliseconds(this.clickTimeInMilliseconds);
        defaultActivityPackage.setClickTimeInSeconds(this.clickTimeInSeconds);
        defaultActivityPackage.setInstallBeginTimeInSeconds(this.installBeginTimeInSeconds);
        defaultActivityPackage.setClickTimeServerInSeconds(this.clickTimeServerInSeconds);
        defaultActivityPackage.setInstallBeginTimeServerInSeconds(this.installBeginTimeServerInSeconds);
        defaultActivityPackage.setInstallVersion(this.installVersion);
        defaultActivityPackage.setGooglePlayInstant(this.googlePlayInstant);
        AdjustSigner.sign(clickParameters, ActivityKind.CLICK.toString(), defaultActivityPackage.getClientSdk(), this.adjustConfig.context, this.adjustConfig.logger);
        defaultActivityPackage.setParameters(clickParameters);
        return defaultActivityPackage;
    }

    ActivityPackage buildAttributionPackage(String str) {
        Map<String, String> attributionParameters = getAttributionParameters(str);
        ActivityPackage defaultActivityPackage = getDefaultActivityPackage(ActivityKind.ATTRIBUTION);
        defaultActivityPackage.setPath("attribution");
        defaultActivityPackage.setSuffix("");
        AdjustSigner.sign(attributionParameters, ActivityKind.ATTRIBUTION.toString(), defaultActivityPackage.getClientSdk(), this.adjustConfig.context, this.adjustConfig.logger);
        defaultActivityPackage.setParameters(attributionParameters);
        return defaultActivityPackage;
    }

    ActivityPackage buildGdprPackage() {
        Map<String, String> gdprParameters = getGdprParameters();
        ActivityPackage defaultActivityPackage = getDefaultActivityPackage(ActivityKind.GDPR);
        defaultActivityPackage.setPath("/gdpr_forget_device");
        defaultActivityPackage.setSuffix("");
        AdjustSigner.sign(gdprParameters, ActivityKind.GDPR.toString(), defaultActivityPackage.getClientSdk(), this.adjustConfig.context, this.adjustConfig.logger);
        defaultActivityPackage.setParameters(gdprParameters);
        return defaultActivityPackage;
    }

    ActivityPackage buildDisableThirdPartySharingPackage() {
        Map<String, String> disableThirdPartySharingParameters = getDisableThirdPartySharingParameters();
        ActivityPackage defaultActivityPackage = getDefaultActivityPackage(ActivityKind.DISABLE_THIRD_PARTY_SHARING);
        defaultActivityPackage.setPath("/disable_third_party_sharing");
        defaultActivityPackage.setSuffix("");
        AdjustSigner.sign(disableThirdPartySharingParameters, ActivityKind.DISABLE_THIRD_PARTY_SHARING.toString(), defaultActivityPackage.getClientSdk(), this.adjustConfig.context, this.adjustConfig.logger);
        defaultActivityPackage.setParameters(disableThirdPartySharingParameters);
        return defaultActivityPackage;
    }

    ActivityPackage buildThirdPartySharingPackage(AdjustThirdPartySharing adjustThirdPartySharing) {
        Map<String, String> thirdPartySharingParameters = getThirdPartySharingParameters(adjustThirdPartySharing);
        ActivityPackage defaultActivityPackage = getDefaultActivityPackage(ActivityKind.THIRD_PARTY_SHARING);
        defaultActivityPackage.setPath("/third_party_sharing");
        defaultActivityPackage.setSuffix("");
        AdjustSigner.sign(thirdPartySharingParameters, ActivityKind.THIRD_PARTY_SHARING.toString(), defaultActivityPackage.getClientSdk(), this.adjustConfig.context, this.adjustConfig.logger);
        defaultActivityPackage.setParameters(thirdPartySharingParameters);
        return defaultActivityPackage;
    }

    ActivityPackage buildMeasurementConsentPackage(boolean z) {
        Map<String, String> measurementConsentParameters = getMeasurementConsentParameters(z);
        ActivityPackage defaultActivityPackage = getDefaultActivityPackage(ActivityKind.MEASUREMENT_CONSENT);
        defaultActivityPackage.setPath("/measurement_consent");
        defaultActivityPackage.setSuffix("");
        AdjustSigner.sign(measurementConsentParameters, ActivityKind.MEASUREMENT_CONSENT.toString(), defaultActivityPackage.getClientSdk(), this.adjustConfig.context, this.adjustConfig.logger);
        defaultActivityPackage.setParameters(measurementConsentParameters);
        return defaultActivityPackage;
    }

    ActivityPackage buildAdRevenuePackage(String str, JSONObject jSONObject) {
        Map<String, String> adRevenueParameters = getAdRevenueParameters(str, jSONObject);
        ActivityPackage defaultActivityPackage = getDefaultActivityPackage(ActivityKind.AD_REVENUE);
        defaultActivityPackage.setPath("/ad_revenue");
        defaultActivityPackage.setSuffix("");
        AdjustSigner.sign(adRevenueParameters, ActivityKind.AD_REVENUE.toString(), defaultActivityPackage.getClientSdk(), this.adjustConfig.context, this.adjustConfig.logger);
        defaultActivityPackage.setParameters(adRevenueParameters);
        return defaultActivityPackage;
    }

    ActivityPackage buildSubscriptionPackage(AdjustPlayStoreSubscription adjustPlayStoreSubscription, boolean z) {
        Map<String, String> subscriptionParameters = getSubscriptionParameters(adjustPlayStoreSubscription, z);
        ActivityPackage defaultActivityPackage = getDefaultActivityPackage(ActivityKind.SUBSCRIPTION);
        defaultActivityPackage.setPath("/v2/purchase");
        defaultActivityPackage.setSuffix("");
        AdjustSigner.sign(subscriptionParameters, ActivityKind.SUBSCRIPTION.toString(), defaultActivityPackage.getClientSdk(), this.adjustConfig.context, this.adjustConfig.logger);
        defaultActivityPackage.setParameters(subscriptionParameters);
        return defaultActivityPackage;
    }

    private Map<String, String> getSessionParameters(boolean z) {
        ContentResolver contentResolver = this.adjustConfig.context.getContentResolver();
        HashMap map = new HashMap();
        Map<String, String> imeiParameters = Reflection.getImeiParameters(this.adjustConfig.context, logger);
        if (imeiParameters != null) {
            map.putAll(imeiParameters);
        }
        Map<String, String> oaidParameters = Reflection.getOaidParameters(this.adjustConfig.context, logger);
        if (oaidParameters != null) {
            map.putAll(oaidParameters);
        }
        if (!z) {
            addMapJson(map, Constants.CALLBACK_PARAMETERS, this.sessionParameters.callbackParameters);
            addMapJson(map, Constants.PARTNER_PARAMETERS, this.sessionParameters.partnerParameters);
        }
        this.deviceInfo.reloadPlayIds(this.adjustConfig.context);
        addString(map, "android_uuid", this.activityStateCopy.uuid);
        addString(map, "gps_adid", this.deviceInfo.playAdId);
        addLong(map, "gps_adid_attempt", this.deviceInfo.playAdIdAttempt);
        addString(map, "gps_adid_src", this.deviceInfo.playAdIdSource);
        addBoolean(map, "tracking_enabled", this.deviceInfo.isTrackingEnabled);
        addString(map, "fire_adid", Util.getFireAdvertisingId(contentResolver));
        addBoolean(map, "fire_tracking_enabled", Util.getFireTrackingEnabled(contentResolver));
        if (!containsPlayIds(map) && !containsFireIds(map)) {
            logger.warn("Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place", new Object[0]);
            this.deviceInfo.reloadNonPlayIds(this.adjustConfig.context);
            addString(map, "android_id", this.deviceInfo.androidId);
            addString(map, "mac_md5", this.deviceInfo.macShortMd5);
            addString(map, "mac_sha1", this.deviceInfo.macSha1);
        }
        addString(map, "api_level", this.deviceInfo.apiLevel);
        addString(map, "app_secret", this.adjustConfig.appSecret);
        addString(map, "app_token", this.adjustConfig.appToken);
        addString(map, "app_version", this.deviceInfo.appVersion);
        addBoolean(map, "attribution_deeplink", true);
        addLong(map, "connectivity_type", Util.getConnectivityType(this.adjustConfig.context));
        addString(map, "country", this.deviceInfo.country);
        addString(map, "cpu_type", this.deviceInfo.abi);
        addDateInMilliseconds(map, "created_at", this.createdAt);
        addString(map, "default_tracker", this.adjustConfig.defaultTracker);
        addBoolean(map, "device_known", this.adjustConfig.deviceKnown);
        addBoolean(map, "needs_cost", this.adjustConfig.needsCost);
        addString(map, "device_manufacturer", this.deviceInfo.deviceManufacturer);
        addString(map, "device_name", this.deviceInfo.deviceName);
        addString(map, "device_type", this.deviceInfo.deviceType);
        addString(map, "display_height", this.deviceInfo.displayHeight);
        addString(map, "display_width", this.deviceInfo.displayWidth);
        addString(map, "environment", this.adjustConfig.environment);
        addBoolean(map, "event_buffering_enabled", Boolean.valueOf(this.adjustConfig.eventBufferingEnabled));
        addString(map, "external_device_id", this.adjustConfig.externalDeviceId);
        addString(map, "fb_id", this.deviceInfo.fbAttributionId);
        addString(map, "hardware_name", this.deviceInfo.hardwareName);
        addString(map, "installed_at", this.deviceInfo.appInstallTime);
        addString(map, "language", this.deviceInfo.language);
        addDuration(map, "last_interval", this.activityStateCopy.lastInterval);
        addString(map, "mcc", Util.getMcc(this.adjustConfig.context));
        addString(map, "mnc", Util.getMnc(this.adjustConfig.context));
        addBoolean(map, "needs_response_details", true);
        addLong(map, "network_type", Util.getNetworkType(this.adjustConfig.context));
        addString(map, "os_build", this.deviceInfo.buildName);
        addString(map, "os_name", this.deviceInfo.osName);
        addString(map, "os_version", this.deviceInfo.osVersion);
        addString(map, "package_name", this.deviceInfo.packageName);
        addString(map, "push_token", this.activityStateCopy.pushToken);
        addString(map, "screen_density", this.deviceInfo.screenDensity);
        addString(map, "screen_format", this.deviceInfo.screenFormat);
        addString(map, "screen_size", this.deviceInfo.screenSize);
        addString(map, "secret_id", this.adjustConfig.secretId);
        addLong(map, "session_count", this.activityStateCopy.sessionCount);
        addDuration(map, "session_length", this.activityStateCopy.sessionLength);
        addLong(map, "subsession_count", this.activityStateCopy.subsessionCount);
        addDuration(map, "time_spent", this.activityStateCopy.timeSpent);
        addString(map, "updated_at", this.deviceInfo.appUpdateTime);
        checkDeviceIds(map);
        return map;
    }

    public Map<String, String> getEventParameters(AdjustEvent adjustEvent, boolean z) {
        ContentResolver contentResolver = this.adjustConfig.context.getContentResolver();
        HashMap map = new HashMap();
        Map<String, String> imeiParameters = Reflection.getImeiParameters(this.adjustConfig.context, logger);
        if (imeiParameters != null) {
            map.putAll(imeiParameters);
        }
        Map<String, String> oaidParameters = Reflection.getOaidParameters(this.adjustConfig.context, logger);
        if (oaidParameters != null) {
            map.putAll(oaidParameters);
        }
        if (!z) {
            addMapJson(map, Constants.CALLBACK_PARAMETERS, Util.mergeParameters(this.sessionParameters.callbackParameters, adjustEvent.callbackParameters, "Callback"));
            addMapJson(map, Constants.PARTNER_PARAMETERS, Util.mergeParameters(this.sessionParameters.partnerParameters, adjustEvent.partnerParameters, "Partner"));
        }
        this.deviceInfo.reloadPlayIds(this.adjustConfig.context);
        addString(map, "android_uuid", this.activityStateCopy.uuid);
        addString(map, "gps_adid", this.deviceInfo.playAdId);
        addLong(map, "gps_adid_attempt", this.deviceInfo.playAdIdAttempt);
        addString(map, "gps_adid_src", this.deviceInfo.playAdIdSource);
        addBoolean(map, "tracking_enabled", this.deviceInfo.isTrackingEnabled);
        addString(map, "fire_adid", Util.getFireAdvertisingId(contentResolver));
        addBoolean(map, "fire_tracking_enabled", Util.getFireTrackingEnabled(contentResolver));
        if (!containsPlayIds(map) && !containsFireIds(map)) {
            logger.warn("Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place", new Object[0]);
            this.deviceInfo.reloadNonPlayIds(this.adjustConfig.context);
            addString(map, "android_id", this.deviceInfo.androidId);
            addString(map, "mac_md5", this.deviceInfo.macShortMd5);
            addString(map, "mac_sha1", this.deviceInfo.macSha1);
        }
        addString(map, "api_level", this.deviceInfo.apiLevel);
        addString(map, "app_secret", this.adjustConfig.appSecret);
        addString(map, "app_token", this.adjustConfig.appToken);
        addString(map, "app_version", this.deviceInfo.appVersion);
        addBoolean(map, "attribution_deeplink", true);
        addLong(map, "connectivity_type", Util.getConnectivityType(this.adjustConfig.context));
        addString(map, "country", this.deviceInfo.country);
        addString(map, "cpu_type", this.deviceInfo.abi);
        addDateInMilliseconds(map, "created_at", this.createdAt);
        addString(map, FirebaseAnalytics.Param.CURRENCY, adjustEvent.currency);
        addBoolean(map, "device_known", this.adjustConfig.deviceKnown);
        addBoolean(map, "needs_cost", this.adjustConfig.needsCost);
        addString(map, "device_manufacturer", this.deviceInfo.deviceManufacturer);
        addString(map, "device_name", this.deviceInfo.deviceName);
        addString(map, "device_type", this.deviceInfo.deviceType);
        addString(map, "display_height", this.deviceInfo.displayHeight);
        addString(map, "display_width", this.deviceInfo.displayWidth);
        addString(map, "environment", this.adjustConfig.environment);
        addString(map, "event_callback_id", adjustEvent.callbackId);
        addLong(map, "event_count", this.activityStateCopy.eventCount);
        addBoolean(map, "event_buffering_enabled", Boolean.valueOf(this.adjustConfig.eventBufferingEnabled));
        addString(map, "event_token", adjustEvent.eventToken);
        addString(map, "external_device_id", this.adjustConfig.externalDeviceId);
        addString(map, "fb_id", this.deviceInfo.fbAttributionId);
        addString(map, "hardware_name", this.deviceInfo.hardwareName);
        addString(map, "language", this.deviceInfo.language);
        addString(map, "mcc", Util.getMcc(this.adjustConfig.context));
        addString(map, "mnc", Util.getMnc(this.adjustConfig.context));
        addBoolean(map, "needs_response_details", true);
        addLong(map, "network_type", Util.getNetworkType(this.adjustConfig.context));
        addString(map, "os_build", this.deviceInfo.buildName);
        addString(map, "os_name", this.deviceInfo.osName);
        addString(map, "os_version", this.deviceInfo.osVersion);
        addString(map, "package_name", this.deviceInfo.packageName);
        addString(map, "push_token", this.activityStateCopy.pushToken);
        addDouble(map, "revenue", adjustEvent.revenue);
        addString(map, "screen_density", this.deviceInfo.screenDensity);
        addString(map, "screen_format", this.deviceInfo.screenFormat);
        addString(map, "screen_size", this.deviceInfo.screenSize);
        addString(map, "secret_id", this.adjustConfig.secretId);
        addLong(map, "session_count", this.activityStateCopy.sessionCount);
        addDuration(map, "session_length", this.activityStateCopy.sessionLength);
        addLong(map, "subsession_count", this.activityStateCopy.subsessionCount);
        addDuration(map, "time_spent", this.activityStateCopy.timeSpent);
        checkDeviceIds(map);
        return map;
    }

    private Map<String, String> getInfoParameters(String str) {
        ContentResolver contentResolver = this.adjustConfig.context.getContentResolver();
        HashMap map = new HashMap();
        Map<String, String> imeiParameters = Reflection.getImeiParameters(this.adjustConfig.context, logger);
        if (imeiParameters != null) {
            map.putAll(imeiParameters);
        }
        Map<String, String> oaidParameters = Reflection.getOaidParameters(this.adjustConfig.context, logger);
        if (oaidParameters != null) {
            map.putAll(oaidParameters);
        }
        this.deviceInfo.reloadPlayIds(this.adjustConfig.context);
        addString(map, "android_uuid", this.activityStateCopy.uuid);
        addString(map, "gps_adid", this.deviceInfo.playAdId);
        addLong(map, "gps_adid_attempt", this.deviceInfo.playAdIdAttempt);
        addString(map, "gps_adid_src", this.deviceInfo.playAdIdSource);
        addBoolean(map, "tracking_enabled", this.deviceInfo.isTrackingEnabled);
        addString(map, "fire_adid", Util.getFireAdvertisingId(contentResolver));
        addBoolean(map, "fire_tracking_enabled", Util.getFireTrackingEnabled(contentResolver));
        if (!containsPlayIds(map) && !containsFireIds(map)) {
            logger.warn("Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place", new Object[0]);
            this.deviceInfo.reloadNonPlayIds(this.adjustConfig.context);
            addString(map, "android_id", this.deviceInfo.androidId);
            addString(map, "mac_md5", this.deviceInfo.macShortMd5);
            addString(map, "mac_sha1", this.deviceInfo.macSha1);
        }
        addString(map, "app_secret", this.adjustConfig.appSecret);
        addString(map, "app_token", this.adjustConfig.appToken);
        addBoolean(map, "attribution_deeplink", true);
        addDateInMilliseconds(map, "created_at", this.createdAt);
        addBoolean(map, "device_known", this.adjustConfig.deviceKnown);
        addBoolean(map, "needs_cost", this.adjustConfig.needsCost);
        addString(map, "environment", this.adjustConfig.environment);
        addBoolean(map, "event_buffering_enabled", Boolean.valueOf(this.adjustConfig.eventBufferingEnabled));
        addString(map, "external_device_id", this.adjustConfig.externalDeviceId);
        addBoolean(map, "needs_response_details", true);
        addString(map, "push_token", this.activityStateCopy.pushToken);
        addString(map, "secret_id", this.adjustConfig.secretId);
        addString(map, FirebaseAnalytics.Param.SOURCE, str);
        checkDeviceIds(map);
        return map;
    }

    private Map<String, String> getClickParameters(String str) {
        ContentResolver contentResolver = this.adjustConfig.context.getContentResolver();
        HashMap map = new HashMap();
        Map<String, String> imeiParameters = Reflection.getImeiParameters(this.adjustConfig.context, logger);
        if (imeiParameters != null) {
            map.putAll(imeiParameters);
        }
        Map<String, String> oaidParameters = Reflection.getOaidParameters(this.adjustConfig.context, logger);
        if (oaidParameters != null) {
            map.putAll(oaidParameters);
        }
        this.deviceInfo.reloadPlayIds(this.adjustConfig.context);
        addString(map, "android_uuid", this.activityStateCopy.uuid);
        addString(map, "gps_adid", this.deviceInfo.playAdId);
        addLong(map, "gps_adid_attempt", this.deviceInfo.playAdIdAttempt);
        addString(map, "gps_adid_src", this.deviceInfo.playAdIdSource);
        addBoolean(map, "tracking_enabled", this.deviceInfo.isTrackingEnabled);
        addString(map, "fire_adid", Util.getFireAdvertisingId(contentResolver));
        addBoolean(map, "fire_tracking_enabled", Util.getFireTrackingEnabled(contentResolver));
        if (!containsPlayIds(map) && !containsFireIds(map)) {
            logger.warn("Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place", new Object[0]);
            this.deviceInfo.reloadNonPlayIds(this.adjustConfig.context);
            addString(map, "android_id", this.deviceInfo.androidId);
            addString(map, "mac_md5", this.deviceInfo.macShortMd5);
            addString(map, "mac_sha1", this.deviceInfo.macSha1);
        }
        if (this.attribution != null) {
            addString(map, "tracker", this.attribution.trackerName);
            addString(map, FirebaseAnalytics.Param.CAMPAIGN, this.attribution.campaign);
            addString(map, "adgroup", this.attribution.adgroup);
            addString(map, "creative", this.attribution.creative);
        }
        addString(map, "api_level", this.deviceInfo.apiLevel);
        addString(map, "app_secret", this.adjustConfig.appSecret);
        addString(map, "app_token", this.adjustConfig.appToken);
        addString(map, "app_version", this.deviceInfo.appVersion);
        addBoolean(map, "attribution_deeplink", true);
        addMapJson(map, Constants.CALLBACK_PARAMETERS, this.sessionParameters.callbackParameters);
        addDateInMilliseconds(map, "click_time", this.clickTimeInMilliseconds);
        addDateInSeconds(map, "click_time", this.clickTimeInSeconds);
        addDateInSeconds(map, "click_time_server", this.clickTimeServerInSeconds);
        addLong(map, "connectivity_type", Util.getConnectivityType(this.adjustConfig.context));
        addString(map, "country", this.deviceInfo.country);
        addString(map, "cpu_type", this.deviceInfo.abi);
        addDateInMilliseconds(map, "created_at", this.createdAt);
        addString(map, Constants.DEEPLINK, this.deeplink);
        addBoolean(map, "device_known", this.adjustConfig.deviceKnown);
        addBoolean(map, "needs_cost", this.adjustConfig.needsCost);
        addString(map, "device_manufacturer", this.deviceInfo.deviceManufacturer);
        addString(map, "device_name", this.deviceInfo.deviceName);
        addString(map, "device_type", this.deviceInfo.deviceType);
        addString(map, "display_height", this.deviceInfo.displayHeight);
        addString(map, "display_width", this.deviceInfo.displayWidth);
        addString(map, "environment", this.adjustConfig.environment);
        addBoolean(map, "event_buffering_enabled", Boolean.valueOf(this.adjustConfig.eventBufferingEnabled));
        addString(map, "external_device_id", this.adjustConfig.externalDeviceId);
        addString(map, "fb_id", this.deviceInfo.fbAttributionId);
        addBoolean(map, "google_play_instant", this.googlePlayInstant);
        addString(map, "hardware_name", this.deviceInfo.hardwareName);
        addDateInSeconds(map, "install_begin_time", this.installBeginTimeInSeconds);
        addDateInSeconds(map, "install_begin_time_server", this.installBeginTimeServerInSeconds);
        addString(map, "install_version", this.installVersion);
        addString(map, "installed_at", this.deviceInfo.appInstallTime);
        addString(map, "language", this.deviceInfo.language);
        addDuration(map, "last_interval", this.activityStateCopy.lastInterval);
        addString(map, "mcc", Util.getMcc(this.adjustConfig.context));
        addString(map, "mnc", Util.getMnc(this.adjustConfig.context));
        addBoolean(map, "needs_response_details", true);
        addLong(map, "network_type", Util.getNetworkType(this.adjustConfig.context));
        addString(map, "os_build", this.deviceInfo.buildName);
        addString(map, "os_name", this.deviceInfo.osName);
        addString(map, "os_version", this.deviceInfo.osVersion);
        addString(map, "package_name", this.deviceInfo.packageName);
        addMapJson(map, "params", this.extraParameters);
        addMapJson(map, Constants.PARTNER_PARAMETERS, this.sessionParameters.partnerParameters);
        addString(map, "push_token", this.activityStateCopy.pushToken);
        addString(map, "raw_referrer", this.rawReferrer);
        addString(map, Constants.REFERRER, this.referrer);
        addString(map, "referrer_api", this.referrerApi);
        addString(map, Constants.REFTAG, this.reftag);
        addString(map, "screen_density", this.deviceInfo.screenDensity);
        addString(map, "screen_format", this.deviceInfo.screenFormat);
        addString(map, "screen_size", this.deviceInfo.screenSize);
        addString(map, "secret_id", this.adjustConfig.secretId);
        addLong(map, "session_count", this.activityStateCopy.sessionCount);
        addDuration(map, "session_length", this.activityStateCopy.sessionLength);
        addString(map, FirebaseAnalytics.Param.SOURCE, str);
        addLong(map, "subsession_count", this.activityStateCopy.subsessionCount);
        addDuration(map, "time_spent", this.activityStateCopy.timeSpent);
        addString(map, "updated_at", this.deviceInfo.appUpdateTime);
        addString(map, "payload", this.preinstallPayload);
        addString(map, "found_location", this.preinstallLocation);
        checkDeviceIds(map);
        return map;
    }

    private Map<String, String> getAttributionParameters(String str) {
        ContentResolver contentResolver = this.adjustConfig.context.getContentResolver();
        HashMap map = new HashMap();
        Map<String, String> imeiParameters = Reflection.getImeiParameters(this.adjustConfig.context, logger);
        if (imeiParameters != null) {
            map.putAll(imeiParameters);
        }
        Map<String, String> oaidParameters = Reflection.getOaidParameters(this.adjustConfig.context, logger);
        if (oaidParameters != null) {
            map.putAll(oaidParameters);
        }
        this.deviceInfo.reloadPlayIds(this.adjustConfig.context);
        addString(map, "android_uuid", this.activityStateCopy.uuid);
        addString(map, "gps_adid", this.deviceInfo.playAdId);
        addLong(map, "gps_adid_attempt", this.deviceInfo.playAdIdAttempt);
        addString(map, "gps_adid_src", this.deviceInfo.playAdIdSource);
        addBoolean(map, "tracking_enabled", this.deviceInfo.isTrackingEnabled);
        addString(map, "fire_adid", Util.getFireAdvertisingId(contentResolver));
        addBoolean(map, "fire_tracking_enabled", Util.getFireTrackingEnabled(contentResolver));
        if (!containsPlayIds(map) && !containsFireIds(map)) {
            logger.warn("Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place", new Object[0]);
            this.deviceInfo.reloadNonPlayIds(this.adjustConfig.context);
            addString(map, "android_id", this.deviceInfo.androidId);
            addString(map, "mac_md5", this.deviceInfo.macShortMd5);
            addString(map, "mac_sha1", this.deviceInfo.macSha1);
        }
        addString(map, "api_level", this.deviceInfo.apiLevel);
        addString(map, "app_secret", this.adjustConfig.appSecret);
        addString(map, "app_token", this.adjustConfig.appToken);
        addString(map, "app_version", this.deviceInfo.appVersion);
        addBoolean(map, "attribution_deeplink", true);
        addDateInMilliseconds(map, "created_at", this.createdAt);
        addBoolean(map, "device_known", this.adjustConfig.deviceKnown);
        addBoolean(map, "needs_cost", this.adjustConfig.needsCost);
        addString(map, "device_name", this.deviceInfo.deviceName);
        addString(map, "device_type", this.deviceInfo.deviceType);
        addString(map, "environment", this.adjustConfig.environment);
        addBoolean(map, "event_buffering_enabled", Boolean.valueOf(this.adjustConfig.eventBufferingEnabled));
        addString(map, "external_device_id", this.adjustConfig.externalDeviceId);
        addString(map, "initiated_by", str);
        addBoolean(map, "needs_response_details", true);
        addString(map, "os_name", this.deviceInfo.osName);
        addString(map, "os_version", this.deviceInfo.osVersion);
        addString(map, "package_name", this.deviceInfo.packageName);
        addString(map, "push_token", this.activityStateCopy.pushToken);
        addString(map, "secret_id", this.adjustConfig.secretId);
        checkDeviceIds(map);
        return map;
    }

    private Map<String, String> getGdprParameters() {
        ContentResolver contentResolver = this.adjustConfig.context.getContentResolver();
        HashMap map = new HashMap();
        Map<String, String> imeiParameters = Reflection.getImeiParameters(this.adjustConfig.context, logger);
        if (imeiParameters != null) {
            map.putAll(imeiParameters);
        }
        Map<String, String> oaidParameters = Reflection.getOaidParameters(this.adjustConfig.context, logger);
        if (oaidParameters != null) {
            map.putAll(oaidParameters);
        }
        this.deviceInfo.reloadPlayIds(this.adjustConfig.context);
        addString(map, "android_uuid", this.activityStateCopy.uuid);
        addString(map, "gps_adid", this.deviceInfo.playAdId);
        addLong(map, "gps_adid_attempt", this.deviceInfo.playAdIdAttempt);
        addString(map, "gps_adid_src", this.deviceInfo.playAdIdSource);
        addBoolean(map, "tracking_enabled", this.deviceInfo.isTrackingEnabled);
        addString(map, "fire_adid", Util.getFireAdvertisingId(contentResolver));
        addBoolean(map, "fire_tracking_enabled", Util.getFireTrackingEnabled(contentResolver));
        if (!containsPlayIds(map) && !containsFireIds(map)) {
            logger.warn("Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place", new Object[0]);
            this.deviceInfo.reloadNonPlayIds(this.adjustConfig.context);
            addString(map, "android_id", this.deviceInfo.androidId);
            addString(map, "mac_md5", this.deviceInfo.macShortMd5);
            addString(map, "mac_sha1", this.deviceInfo.macSha1);
        }
        addString(map, "api_level", this.deviceInfo.apiLevel);
        addString(map, "app_secret", this.adjustConfig.appSecret);
        addString(map, "app_token", this.adjustConfig.appToken);
        addString(map, "app_version", this.deviceInfo.appVersion);
        addBoolean(map, "attribution_deeplink", true);
        addDateInMilliseconds(map, "created_at", this.createdAt);
        addBoolean(map, "device_known", this.adjustConfig.deviceKnown);
        addBoolean(map, "needs_cost", this.adjustConfig.needsCost);
        addString(map, "device_name", this.deviceInfo.deviceName);
        addString(map, "device_type", this.deviceInfo.deviceType);
        addString(map, "environment", this.adjustConfig.environment);
        addBoolean(map, "event_buffering_enabled", Boolean.valueOf(this.adjustConfig.eventBufferingEnabled));
        addString(map, "external_device_id", this.adjustConfig.externalDeviceId);
        addBoolean(map, "needs_response_details", true);
        addString(map, "os_name", this.deviceInfo.osName);
        addString(map, "os_version", this.deviceInfo.osVersion);
        addString(map, "package_name", this.deviceInfo.packageName);
        addString(map, "push_token", this.activityStateCopy.pushToken);
        addString(map, "secret_id", this.adjustConfig.secretId);
        checkDeviceIds(map);
        return map;
    }

    private Map<String, String> getDisableThirdPartySharingParameters() {
        ContentResolver contentResolver = this.adjustConfig.context.getContentResolver();
        HashMap map = new HashMap();
        Map<String, String> imeiParameters = Reflection.getImeiParameters(this.adjustConfig.context, logger);
        if (imeiParameters != null) {
            map.putAll(imeiParameters);
        }
        Map<String, String> oaidParameters = Reflection.getOaidParameters(this.adjustConfig.context, logger);
        if (oaidParameters != null) {
            map.putAll(oaidParameters);
        }
        this.deviceInfo.reloadPlayIds(this.adjustConfig.context);
        addString(map, "android_uuid", this.activityStateCopy.uuid);
        addString(map, "gps_adid", this.deviceInfo.playAdId);
        addLong(map, "gps_adid_attempt", this.deviceInfo.playAdIdAttempt);
        addString(map, "gps_adid_src", this.deviceInfo.playAdIdSource);
        addBoolean(map, "tracking_enabled", this.deviceInfo.isTrackingEnabled);
        addString(map, "fire_adid", Util.getFireAdvertisingId(contentResolver));
        addBoolean(map, "fire_tracking_enabled", Util.getFireTrackingEnabled(contentResolver));
        if (!containsPlayIds(map) && !containsFireIds(map)) {
            logger.warn("Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place", new Object[0]);
            this.deviceInfo.reloadNonPlayIds(this.adjustConfig.context);
            addString(map, "android_id", this.deviceInfo.androidId);
            addString(map, "mac_md5", this.deviceInfo.macShortMd5);
            addString(map, "mac_sha1", this.deviceInfo.macSha1);
        }
        addString(map, "api_level", this.deviceInfo.apiLevel);
        addString(map, "app_secret", this.adjustConfig.appSecret);
        addString(map, "app_token", this.adjustConfig.appToken);
        addString(map, "app_version", this.deviceInfo.appVersion);
        addBoolean(map, "attribution_deeplink", true);
        addDateInMilliseconds(map, "created_at", this.createdAt);
        addBoolean(map, "device_known", this.adjustConfig.deviceKnown);
        addBoolean(map, "needs_cost", this.adjustConfig.needsCost);
        addString(map, "device_name", this.deviceInfo.deviceName);
        addString(map, "device_type", this.deviceInfo.deviceType);
        addString(map, "environment", this.adjustConfig.environment);
        addBoolean(map, "event_buffering_enabled", Boolean.valueOf(this.adjustConfig.eventBufferingEnabled));
        addString(map, "external_device_id", this.adjustConfig.externalDeviceId);
        addBoolean(map, "needs_response_details", true);
        addString(map, "os_name", this.deviceInfo.osName);
        addString(map, "os_version", this.deviceInfo.osVersion);
        addString(map, "package_name", this.deviceInfo.packageName);
        addString(map, "push_token", this.activityStateCopy.pushToken);
        addString(map, "secret_id", this.adjustConfig.secretId);
        checkDeviceIds(map);
        return map;
    }

    private Map<String, String> getThirdPartySharingParameters(AdjustThirdPartySharing adjustThirdPartySharing) {
        ContentResolver contentResolver = this.adjustConfig.context.getContentResolver();
        HashMap map = new HashMap();
        Map<String, String> imeiParameters = Reflection.getImeiParameters(this.adjustConfig.context, logger);
        if (imeiParameters != null) {
            map.putAll(imeiParameters);
        }
        Map<String, String> oaidParameters = Reflection.getOaidParameters(this.adjustConfig.context, logger);
        if (oaidParameters != null) {
            map.putAll(oaidParameters);
        }
        if (adjustThirdPartySharing.isEnabled != null) {
            addString(map, "sharing", adjustThirdPartySharing.isEnabled.booleanValue() ? "enable" : "disable");
        }
        addMapJson(map, "granular_third_party_sharing_options", adjustThirdPartySharing.granularOptions);
        this.deviceInfo.reloadPlayIds(this.adjustConfig.context);
        addString(map, "android_uuid", this.activityStateCopy.uuid);
        addString(map, "gps_adid", this.deviceInfo.playAdId);
        addLong(map, "gps_adid_attempt", this.deviceInfo.playAdIdAttempt);
        addString(map, "gps_adid_src", this.deviceInfo.playAdIdSource);
        addBoolean(map, "tracking_enabled", this.deviceInfo.isTrackingEnabled);
        addString(map, "fire_adid", Util.getFireAdvertisingId(contentResolver));
        addBoolean(map, "fire_tracking_enabled", Util.getFireTrackingEnabled(contentResolver));
        if (!containsPlayIds(map) && !containsFireIds(map)) {
            logger.warn("Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place", new Object[0]);
            this.deviceInfo.reloadNonPlayIds(this.adjustConfig.context);
            addString(map, "android_id", this.deviceInfo.androidId);
            addString(map, "mac_md5", this.deviceInfo.macShortMd5);
            addString(map, "mac_sha1", this.deviceInfo.macSha1);
        }
        addString(map, "api_level", this.deviceInfo.apiLevel);
        addString(map, "app_secret", this.adjustConfig.appSecret);
        addString(map, "app_token", this.adjustConfig.appToken);
        addString(map, "app_version", this.deviceInfo.appVersion);
        addBoolean(map, "attribution_deeplink", true);
        addDateInMilliseconds(map, "created_at", this.createdAt);
        addBoolean(map, "device_known", this.adjustConfig.deviceKnown);
        addString(map, "device_name", this.deviceInfo.deviceName);
        addString(map, "device_type", this.deviceInfo.deviceType);
        addString(map, "environment", this.adjustConfig.environment);
        addBoolean(map, "event_buffering_enabled", Boolean.valueOf(this.adjustConfig.eventBufferingEnabled));
        addString(map, "external_device_id", this.adjustConfig.externalDeviceId);
        addBoolean(map, "needs_response_details", true);
        addString(map, "os_name", this.deviceInfo.osName);
        addString(map, "os_version", this.deviceInfo.osVersion);
        addString(map, "package_name", this.deviceInfo.packageName);
        addString(map, "push_token", this.activityStateCopy.pushToken);
        addString(map, "secret_id", this.adjustConfig.secretId);
        checkDeviceIds(map);
        return map;
    }

    private Map<String, String> getMeasurementConsentParameters(boolean z) {
        ContentResolver contentResolver = this.adjustConfig.context.getContentResolver();
        HashMap map = new HashMap();
        Map<String, String> imeiParameters = Reflection.getImeiParameters(this.adjustConfig.context, logger);
        if (imeiParameters != null) {
            map.putAll(imeiParameters);
        }
        Map<String, String> oaidParameters = Reflection.getOaidParameters(this.adjustConfig.context, logger);
        if (oaidParameters != null) {
            map.putAll(oaidParameters);
        }
        addString(map, "measurement", z ? "enable" : "disable");
        this.deviceInfo.reloadPlayIds(this.adjustConfig.context);
        addString(map, "android_uuid", this.activityStateCopy.uuid);
        addString(map, "gps_adid", this.deviceInfo.playAdId);
        addLong(map, "gps_adid_attempt", this.deviceInfo.playAdIdAttempt);
        addString(map, "gps_adid_src", this.deviceInfo.playAdIdSource);
        addBoolean(map, "tracking_enabled", this.deviceInfo.isTrackingEnabled);
        addString(map, "fire_adid", Util.getFireAdvertisingId(contentResolver));
        addBoolean(map, "fire_tracking_enabled", Util.getFireTrackingEnabled(contentResolver));
        if (!containsPlayIds(map) && !containsFireIds(map)) {
            logger.warn("Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place", new Object[0]);
            this.deviceInfo.reloadNonPlayIds(this.adjustConfig.context);
            addString(map, "android_id", this.deviceInfo.androidId);
            addString(map, "mac_md5", this.deviceInfo.macShortMd5);
            addString(map, "mac_sha1", this.deviceInfo.macSha1);
        }
        addString(map, "api_level", this.deviceInfo.apiLevel);
        addString(map, "app_secret", this.adjustConfig.appSecret);
        addString(map, "app_token", this.adjustConfig.appToken);
        addString(map, "app_version", this.deviceInfo.appVersion);
        addBoolean(map, "attribution_deeplink", true);
        addDateInMilliseconds(map, "created_at", this.createdAt);
        addBoolean(map, "device_known", this.adjustConfig.deviceKnown);
        addString(map, "device_name", this.deviceInfo.deviceName);
        addString(map, "device_type", this.deviceInfo.deviceType);
        addString(map, "environment", this.adjustConfig.environment);
        addBoolean(map, "event_buffering_enabled", Boolean.valueOf(this.adjustConfig.eventBufferingEnabled));
        addString(map, "external_device_id", this.adjustConfig.externalDeviceId);
        addBoolean(map, "needs_response_details", true);
        addString(map, "os_name", this.deviceInfo.osName);
        addString(map, "os_version", this.deviceInfo.osVersion);
        addString(map, "package_name", this.deviceInfo.packageName);
        addString(map, "push_token", this.activityStateCopy.pushToken);
        addString(map, "secret_id", this.adjustConfig.secretId);
        checkDeviceIds(map);
        return map;
    }

    private Map<String, String> getAdRevenueParameters(String str, JSONObject jSONObject) {
        ContentResolver contentResolver = this.adjustConfig.context.getContentResolver();
        HashMap map = new HashMap();
        Map<String, String> imeiParameters = Reflection.getImeiParameters(this.adjustConfig.context, logger);
        if (imeiParameters != null) {
            map.putAll(imeiParameters);
        }
        Map<String, String> oaidParameters = Reflection.getOaidParameters(this.adjustConfig.context, logger);
        if (oaidParameters != null) {
            map.putAll(oaidParameters);
        }
        this.deviceInfo.reloadPlayIds(this.adjustConfig.context);
        addString(map, "android_uuid", this.activityStateCopy.uuid);
        addString(map, "gps_adid", this.deviceInfo.playAdId);
        addLong(map, "gps_adid_attempt", this.deviceInfo.playAdIdAttempt);
        addString(map, "gps_adid_src", this.deviceInfo.playAdIdSource);
        addBoolean(map, "tracking_enabled", this.deviceInfo.isTrackingEnabled);
        addString(map, "fire_adid", Util.getFireAdvertisingId(contentResolver));
        addBoolean(map, "fire_tracking_enabled", Util.getFireTrackingEnabled(contentResolver));
        if (!containsPlayIds(map) && !containsFireIds(map)) {
            logger.warn("Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place", new Object[0]);
            this.deviceInfo.reloadNonPlayIds(this.adjustConfig.context);
            addString(map, "android_id", this.deviceInfo.androidId);
            addString(map, "mac_md5", this.deviceInfo.macShortMd5);
            addString(map, "mac_sha1", this.deviceInfo.macSha1);
        }
        addString(map, "api_level", this.deviceInfo.apiLevel);
        addString(map, "app_secret", this.adjustConfig.appSecret);
        addString(map, "app_token", this.adjustConfig.appToken);
        addString(map, "app_version", this.deviceInfo.appVersion);
        addBoolean(map, "attribution_deeplink", true);
        addLong(map, "connectivity_type", Util.getConnectivityType(this.adjustConfig.context));
        addString(map, "country", this.deviceInfo.country);
        addString(map, "cpu_type", this.deviceInfo.abi);
        addDateInMilliseconds(map, "created_at", this.createdAt);
        addString(map, "default_tracker", this.adjustConfig.defaultTracker);
        addBoolean(map, "device_known", this.adjustConfig.deviceKnown);
        addBoolean(map, "needs_cost", this.adjustConfig.needsCost);
        addString(map, "device_manufacturer", this.deviceInfo.deviceManufacturer);
        addString(map, "device_name", this.deviceInfo.deviceName);
        addString(map, "device_type", this.deviceInfo.deviceType);
        addString(map, "display_height", this.deviceInfo.displayHeight);
        addString(map, "display_width", this.deviceInfo.displayWidth);
        addString(map, "environment", this.adjustConfig.environment);
        addBoolean(map, "event_buffering_enabled", Boolean.valueOf(this.adjustConfig.eventBufferingEnabled));
        addString(map, "external_device_id", this.adjustConfig.externalDeviceId);
        addString(map, "fb_id", this.deviceInfo.fbAttributionId);
        addString(map, "hardware_name", this.deviceInfo.hardwareName);
        addString(map, "installed_at", this.deviceInfo.appInstallTime);
        addString(map, "language", this.deviceInfo.language);
        addDuration(map, "last_interval", this.activityStateCopy.lastInterval);
        addString(map, "mcc", Util.getMcc(this.adjustConfig.context));
        addString(map, "mnc", Util.getMnc(this.adjustConfig.context));
        addBoolean(map, "needs_response_details", true);
        addLong(map, "network_type", Util.getNetworkType(this.adjustConfig.context));
        addString(map, "os_build", this.deviceInfo.buildName);
        addString(map, "os_name", this.deviceInfo.osName);
        addString(map, "os_version", this.deviceInfo.osVersion);
        addString(map, "package_name", this.deviceInfo.packageName);
        addString(map, "push_token", this.activityStateCopy.pushToken);
        addString(map, "screen_density", this.deviceInfo.screenDensity);
        addString(map, "screen_format", this.deviceInfo.screenFormat);
        addString(map, "screen_size", this.deviceInfo.screenSize);
        addString(map, "secret_id", this.adjustConfig.secretId);
        addString(map, FirebaseAnalytics.Param.SOURCE, str);
        addJsonObject(map, "payload", jSONObject);
        addLong(map, "session_count", this.activityStateCopy.sessionCount);
        addDuration(map, "session_length", this.activityStateCopy.sessionLength);
        addLong(map, "subsession_count", this.activityStateCopy.subsessionCount);
        addDuration(map, "time_spent", this.activityStateCopy.timeSpent);
        addString(map, "updated_at", this.deviceInfo.appUpdateTime);
        checkDeviceIds(map);
        return map;
    }

    private Map<String, String> getSubscriptionParameters(AdjustPlayStoreSubscription adjustPlayStoreSubscription, boolean z) {
        ContentResolver contentResolver = this.adjustConfig.context.getContentResolver();
        HashMap map = new HashMap();
        Map<String, String> imeiParameters = Reflection.getImeiParameters(this.adjustConfig.context, logger);
        if (imeiParameters != null) {
            map.putAll(imeiParameters);
        }
        Map<String, String> oaidParameters = Reflection.getOaidParameters(this.adjustConfig.context, logger);
        if (oaidParameters != null) {
            map.putAll(oaidParameters);
        }
        this.deviceInfo.reloadPlayIds(this.adjustConfig.context);
        addString(map, "android_uuid", this.activityStateCopy.uuid);
        addString(map, "gps_adid", this.deviceInfo.playAdId);
        addLong(map, "gps_adid_attempt", this.deviceInfo.playAdIdAttempt);
        addString(map, "gps_adid_src", this.deviceInfo.playAdIdSource);
        addBoolean(map, "tracking_enabled", this.deviceInfo.isTrackingEnabled);
        addString(map, "fire_adid", Util.getFireAdvertisingId(contentResolver));
        addBoolean(map, "fire_tracking_enabled", Util.getFireTrackingEnabled(contentResolver));
        if (!containsPlayIds(map) && !containsFireIds(map)) {
            logger.warn("Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place", new Object[0]);
            this.deviceInfo.reloadNonPlayIds(this.adjustConfig.context);
            addString(map, "android_id", this.deviceInfo.androidId);
            addString(map, "mac_md5", this.deviceInfo.macShortMd5);
            addString(map, "mac_sha1", this.deviceInfo.macSha1);
        }
        if (!z) {
            addMapJson(map, Constants.CALLBACK_PARAMETERS, Util.mergeParameters(this.sessionParameters.callbackParameters, adjustPlayStoreSubscription.getCallbackParameters(), "Callback"));
            addMapJson(map, Constants.PARTNER_PARAMETERS, Util.mergeParameters(this.sessionParameters.partnerParameters, adjustPlayStoreSubscription.getPartnerParameters(), "Partner"));
        }
        addString(map, "api_level", this.deviceInfo.apiLevel);
        addString(map, "app_secret", this.adjustConfig.appSecret);
        addString(map, "app_token", this.adjustConfig.appToken);
        addString(map, "app_version", this.deviceInfo.appVersion);
        addBoolean(map, "attribution_deeplink", true);
        addLong(map, "connectivity_type", Util.getConnectivityType(this.adjustConfig.context));
        addString(map, "country", this.deviceInfo.country);
        addString(map, "cpu_type", this.deviceInfo.abi);
        addDateInMilliseconds(map, "created_at", this.createdAt);
        addString(map, "default_tracker", this.adjustConfig.defaultTracker);
        addBoolean(map, "device_known", this.adjustConfig.deviceKnown);
        addBoolean(map, "needs_cost", this.adjustConfig.needsCost);
        addString(map, "device_manufacturer", this.deviceInfo.deviceManufacturer);
        addString(map, "device_name", this.deviceInfo.deviceName);
        addString(map, "device_type", this.deviceInfo.deviceType);
        addString(map, "display_height", this.deviceInfo.displayHeight);
        addString(map, "display_width", this.deviceInfo.displayWidth);
        addString(map, "environment", this.adjustConfig.environment);
        addBoolean(map, "event_buffering_enabled", Boolean.valueOf(this.adjustConfig.eventBufferingEnabled));
        addString(map, "external_device_id", this.adjustConfig.externalDeviceId);
        addString(map, "fb_id", this.deviceInfo.fbAttributionId);
        addString(map, "hardware_name", this.deviceInfo.hardwareName);
        addString(map, "installed_at", this.deviceInfo.appInstallTime);
        addString(map, "language", this.deviceInfo.language);
        addDuration(map, "last_interval", this.activityStateCopy.lastInterval);
        addString(map, "mcc", Util.getMcc(this.adjustConfig.context));
        addString(map, "mnc", Util.getMnc(this.adjustConfig.context));
        addBoolean(map, "needs_response_details", true);
        addLong(map, "network_type", Util.getNetworkType(this.adjustConfig.context));
        addString(map, "os_build", this.deviceInfo.buildName);
        addString(map, "os_name", this.deviceInfo.osName);
        addString(map, "os_version", this.deviceInfo.osVersion);
        addString(map, "package_name", this.deviceInfo.packageName);
        addString(map, "push_token", this.activityStateCopy.pushToken);
        addString(map, "screen_density", this.deviceInfo.screenDensity);
        addString(map, "screen_format", this.deviceInfo.screenFormat);
        addString(map, "screen_size", this.deviceInfo.screenSize);
        addString(map, "secret_id", this.adjustConfig.secretId);
        addLong(map, "session_count", this.activityStateCopy.sessionCount);
        addDuration(map, "session_length", this.activityStateCopy.sessionLength);
        addLong(map, "subsession_count", this.activityStateCopy.subsessionCount);
        addDuration(map, "time_spent", this.activityStateCopy.timeSpent);
        addString(map, "updated_at", this.deviceInfo.appUpdateTime);
        addString(map, "billing_store", adjustPlayStoreSubscription.getBillingStore());
        addString(map, FirebaseAnalytics.Param.CURRENCY, adjustPlayStoreSubscription.getCurrency());
        addString(map, "product_id", adjustPlayStoreSubscription.getSku());
        addString(map, "purchase_token", adjustPlayStoreSubscription.getPurchaseToken());
        addString(map, "receipt", adjustPlayStoreSubscription.getSignature());
        addLong(map, "revenue", adjustPlayStoreSubscription.getPrice());
        addDateInMilliseconds(map, "transaction_date", adjustPlayStoreSubscription.getPurchaseTime());
        addString(map, FirebaseAnalytics.Param.TRANSACTION_ID, adjustPlayStoreSubscription.getOrderId());
        checkDeviceIds(map);
        return map;
    }

    private ActivityPackage getDefaultActivityPackage(ActivityKind activityKind) {
        ActivityPackage activityPackage = new ActivityPackage(activityKind);
        activityPackage.setClientSdk(this.deviceInfo.clientSdk);
        return activityPackage;
    }

    public static void addString(Map<String, String> map, String str, String str2) {
        if (TextUtils.isEmpty(str2)) {
            return;
        }
        map.put(str, str2);
    }

    public static void addBoolean(Map<String, String> map, String str, Boolean bool) {
        if (bool == null) {
            return;
        }
        addLong(map, str, bool.booleanValue() ? 1L : 0L);
    }

    static void addJsonObject(Map<String, String> map, String str, JSONObject jSONObject) {
        if (jSONObject == null) {
            return;
        }
        addString(map, str, jSONObject.toString());
    }

    static void addMapJson(Map<String, String> map, String str, Map map2) {
        if (map2 == null || map2.size() == 0) {
            return;
        }
        addString(map, str, new JSONObject(map2).toString());
    }

    public static void addLong(Map<String, String> map, String str, long j) {
        if (j < 0) {
            return;
        }
        addString(map, str, Long.toString(j));
    }

    private static void addDateInMilliseconds(Map<String, String> map, String str, long j) {
        if (j <= 0) {
            return;
        }
        addDate(map, str, new Date(j));
    }

    private static void addDateInSeconds(Map<String, String> map, String str, long j) {
        if (j <= 0) {
            return;
        }
        addDate(map, str, new Date(j * 1000));
    }

    private static void addDate(Map<String, String> map, String str, Date date) {
        if (date == null) {
            return;
        }
        addString(map, str, Util.dateFormatter.format(date));
    }

    private static void addDuration(Map<String, String> map, String str, long j) {
        if (j < 0) {
            return;
        }
        addLong(map, str, (j + 500) / 1000);
    }

    private static void addDouble(Map<String, String> map, String str, Double d) {
        if (d == null) {
            return;
        }
        addString(map, str, Util.formatString("%.5f", d));
    }

    private boolean containsPlayIds(Map<String, String> map) {
        if (map == null) {
            return false;
        }
        return map.containsKey("gps_adid");
    }

    private boolean containsFireIds(Map<String, String> map) {
        if (map == null) {
            return false;
        }
        return map.containsKey("fire_adid");
    }

    private void checkDeviceIds(Map<String, String> map) {
        if (map == null || map.containsKey("mac_sha1") || map.containsKey("mac_md5") || map.containsKey("android_id") || map.containsKey("gps_adid") || map.containsKey("oaid") || map.containsKey("imei") || map.containsKey("meid") || map.containsKey("device_id") || map.containsKey("imeis") || map.containsKey("meids") || map.containsKey("device_ids")) {
            return;
        }
        logger.error("Missing device id's. Please check if Proguard is correctly set with Adjust SDK", new Object[0]);
    }

    private String getEventSuffix(AdjustEvent adjustEvent) {
        return adjustEvent.revenue == null ? Util.formatString("'%s'", adjustEvent.eventToken) : Util.formatString("(%.5f %s, '%s')", adjustEvent.revenue, adjustEvent.currency, adjustEvent.eventToken);
    }
}

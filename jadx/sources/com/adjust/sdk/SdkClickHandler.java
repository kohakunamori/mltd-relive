package com.adjust.sdk;

import com.adjust.sdk.network.IActivityPackageSender;
import com.adjust.sdk.scheduler.SingleThreadCachedScheduler;
import com.adjust.sdk.scheduler.ThreadScheduler;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONException;

/* JADX INFO: loaded from: classes.dex */
public class SdkClickHandler implements ISdkClickHandler {
    private static final double MILLISECONDS_TO_SECONDS_DIVISOR = 1000.0d;
    private static final String SCHEDULED_EXECUTOR_SOURCE = "SdkClickHandler";
    private static final String SOURCE_INSTALL_REFERRER = "install_referrer";
    private static final String SOURCE_REFTAG = "reftag";
    private WeakReference<IActivityHandler> activityHandlerWeakRef;
    private IActivityPackageSender activityPackageSender;
    private BackoffStrategy backoffStrategy;
    private ILogger logger;
    private List<ActivityPackage> packageQueue;
    private boolean paused;
    private ThreadScheduler scheduler;

    public SdkClickHandler(IActivityHandler iActivityHandler, boolean z, IActivityPackageSender iActivityPackageSender) {
        init(iActivityHandler, z, iActivityPackageSender);
        this.logger = AdjustFactory.getLogger();
        this.backoffStrategy = AdjustFactory.getSdkClickBackoffStrategy();
        this.scheduler = new SingleThreadCachedScheduler(SCHEDULED_EXECUTOR_SOURCE);
    }

    @Override // com.adjust.sdk.ISdkClickHandler
    public void init(IActivityHandler iActivityHandler, boolean z, IActivityPackageSender iActivityPackageSender) {
        this.paused = !z;
        this.packageQueue = new ArrayList();
        this.activityHandlerWeakRef = new WeakReference<>(iActivityHandler);
        this.activityPackageSender = iActivityPackageSender;
    }

    @Override // com.adjust.sdk.ISdkClickHandler
    public void pauseSending() {
        this.paused = true;
    }

    @Override // com.adjust.sdk.ISdkClickHandler
    public void resumeSending() {
        this.paused = false;
        sendNextSdkClick();
    }

    @Override // com.adjust.sdk.ISdkClickHandler
    public void sendSdkClick(final ActivityPackage activityPackage) {
        this.scheduler.submit(new Runnable() { // from class: com.adjust.sdk.SdkClickHandler.1
            @Override // java.lang.Runnable
            public void run() {
                SdkClickHandler.this.packageQueue.add(activityPackage);
                SdkClickHandler.this.logger.debug("Added sdk_click %d", Integer.valueOf(SdkClickHandler.this.packageQueue.size()));
                SdkClickHandler.this.logger.verbose("%s", activityPackage.getExtendedString());
                SdkClickHandler.this.sendNextSdkClick();
            }
        });
    }

    @Override // com.adjust.sdk.ISdkClickHandler
    public void sendReftagReferrers() {
        this.scheduler.submit(new Runnable() { // from class: com.adjust.sdk.SdkClickHandler.2
            @Override // java.lang.Runnable
            public void run() {
                IActivityHandler iActivityHandler = (IActivityHandler) SdkClickHandler.this.activityHandlerWeakRef.get();
                SharedPreferencesManager sharedPreferencesManager = new SharedPreferencesManager(iActivityHandler.getContext());
                try {
                    JSONArray rawReferrerArray = sharedPreferencesManager.getRawReferrerArray();
                    boolean z = false;
                    for (int i = 0; i < rawReferrerArray.length(); i++) {
                        JSONArray jSONArray = rawReferrerArray.getJSONArray(i);
                        if (jSONArray.optInt(2, -1) == 0) {
                            String strOptString = jSONArray.optString(0, null);
                            long jOptLong = jSONArray.optLong(1, -1L);
                            jSONArray.put(2, 1);
                            SdkClickHandler.this.sendSdkClick(PackageFactory.buildReftagSdkClickPackage(strOptString, jOptLong, iActivityHandler.getActivityState(), iActivityHandler.getAdjustConfig(), iActivityHandler.getDeviceInfo(), iActivityHandler.getSessionParameters()));
                            z = true;
                        }
                    }
                    if (z) {
                        sharedPreferencesManager.saveRawReferrerArray(rawReferrerArray);
                    }
                } catch (JSONException e) {
                    SdkClickHandler.this.logger.error("Send saved raw referrers error (%s)", e.getMessage());
                }
            }
        });
    }

    @Override // com.adjust.sdk.ISdkClickHandler
    public void sendPreinstallPayload(final String str, final String str2) {
        this.scheduler.submit(new Runnable() { // from class: com.adjust.sdk.SdkClickHandler.3
            @Override // java.lang.Runnable
            public void run() {
                IActivityHandler iActivityHandler = (IActivityHandler) SdkClickHandler.this.activityHandlerWeakRef.get();
                if (iActivityHandler == null) {
                    return;
                }
                SdkClickHandler.this.sendSdkClick(PackageFactory.buildPreinstallSdkClickPackage(str, str2, iActivityHandler.getActivityState(), iActivityHandler.getAdjustConfig(), iActivityHandler.getDeviceInfo(), iActivityHandler.getSessionParameters()));
            }
        });
    }

    @Override // com.adjust.sdk.ISdkClickHandler
    public void teardown() {
        this.logger.verbose("SdkClickHandler teardown", new Object[0]);
        if (this.scheduler != null) {
            this.scheduler.teardown();
        }
        if (this.packageQueue != null) {
            this.packageQueue.clear();
        }
        if (this.activityHandlerWeakRef != null) {
            this.activityHandlerWeakRef.clear();
        }
        this.logger = null;
        this.packageQueue = null;
        this.backoffStrategy = null;
        this.scheduler = null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void sendNextSdkClick() {
        this.scheduler.submit(new Runnable() { // from class: com.adjust.sdk.SdkClickHandler.4
            @Override // java.lang.Runnable
            public void run() {
                SdkClickHandler.this.sendNextSdkClickI();
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void sendNextSdkClickI() {
        IActivityHandler iActivityHandler = this.activityHandlerWeakRef.get();
        if (iActivityHandler.getActivityState() == null || iActivityHandler.getActivityState().isGdprForgotten || this.paused || this.packageQueue.isEmpty()) {
            return;
        }
        final ActivityPackage activityPackageRemove = this.packageQueue.remove(0);
        int retries = activityPackageRemove.getRetries();
        Runnable runnable = new Runnable() { // from class: com.adjust.sdk.SdkClickHandler.5
            @Override // java.lang.Runnable
            public void run() {
                SdkClickHandler.this.sendSdkClickI(activityPackageRemove);
                SdkClickHandler.this.sendNextSdkClick();
            }
        };
        if (retries <= 0) {
            runnable.run();
            return;
        }
        long waitingTime = Util.getWaitingTime(retries, this.backoffStrategy);
        double d = waitingTime;
        Double.isNaN(d);
        this.logger.verbose("Waiting for %s seconds before retrying sdk_click for the %d time", Util.SecondsDisplayFormat.format(d / MILLISECONDS_TO_SECONDS_DIVISOR), Integer.valueOf(retries));
        this.scheduler.schedule(runnable, waitingTime);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Code duplicated, block: B:30:0x00ba A[RETURN] */
    /* JADX WARN: Code duplicated, block: B:31:0x00bb  */
    /* JADX WARN: Code duplicated, block: B:33:0x00c1  */
    /* JADX WARN: Code duplicated, block: B:35:0x00c5 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:36:0x00c7 A[RETURN] */
    /* JADX WARN: Code duplicated, block: B:37:0x00c8  */
    /* JADX WARN: Code duplicated, block: B:39:0x00ce  */
    /* JADX WARN: Code duplicated, block: B:41:0x00d2 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:42:0x00d4  */
    /* JADX WARN: Code duplicated, block: B:43:0x00e7  */
    /* JADX WARN: Code duplicated, block: B:45:0x00eb  */
    /* JADX WARN: Code duplicated, block: B:53:0x012d  */
    /* JADX WARN: Code duplicated, block: B:54:0x0131  */
    public void sendSdkClickI(ActivityPackage activityPackage) {
        String str;
        Boolean bool;
        String str2;
        long j;
        long installBeginTimeInSeconds;
        long clickTimeServerInSeconds;
        String str3;
        boolean z;
        ResponseData responseDataSendActivityPackageSync;
        SdkClickResponseData sdkClickResponseData;
        String str4;
        SharedPreferencesManager sharedPreferencesManager;
        IActivityHandler iActivityHandler = this.activityHandlerWeakRef.get();
        String str5 = activityPackage.getParameters().get(FirebaseAnalytics.Param.SOURCE);
        boolean z2 = str5 != null && str5.equals("reftag");
        String str6 = activityPackage.getParameters().get("raw_referrer");
        if (z2 && new SharedPreferencesManager(iActivityHandler.getContext()).getRawReferrer(str6, activityPackage.getClickTimeInMilliseconds()) == null) {
            return;
        }
        boolean z3 = str5 != null && str5.equals("install_referrer");
        String str7 = null;
        long clickTimeInSeconds = -1;
        if (z3) {
            clickTimeInSeconds = activityPackage.getClickTimeInSeconds();
            installBeginTimeInSeconds = activityPackage.getInstallBeginTimeInSeconds();
            str7 = activityPackage.getParameters().get(Constants.REFERRER);
            clickTimeServerInSeconds = activityPackage.getClickTimeServerInSeconds();
            long installBeginTimeServerInSeconds = activityPackage.getInstallBeginTimeServerInSeconds();
            String installVersion = activityPackage.getInstallVersion();
            Boolean googlePlayInstant = activityPackage.getGooglePlayInstant();
            str2 = activityPackage.getParameters().get("referrer_api");
            j = installBeginTimeServerInSeconds;
            str = installVersion;
            bool = googlePlayInstant;
        } else {
            str = null;
            bool = null;
            str2 = null;
            j = -1;
            installBeginTimeInSeconds = -1;
            clickTimeServerInSeconds = -1;
        }
        if (str5 != null) {
            str3 = str;
            z = str5.equals(Constants.PREINSTALL);
            responseDataSendActivityPackageSync = this.activityPackageSender.sendActivityPackageSync(activityPackage, generateSendingParametersI());
            if (responseDataSendActivityPackageSync instanceof SdkClickResponseData) {
                sdkClickResponseData = (SdkClickResponseData) responseDataSendActivityPackageSync;
                if (sdkClickResponseData.willRetry) {
                    retrySendingI(activityPackage);
                    return;
                }
                if (iActivityHandler == null) {
                    return;
                }
                if (sdkClickResponseData.trackingState == TrackingState.OPTED_OUT) {
                    iActivityHandler.gotOptOutResponse();
                    return;
                }
                if (z2) {
                    new SharedPreferencesManager(iActivityHandler.getContext()).removeRawReferrer(str6, activityPackage.getClickTimeInMilliseconds());
                }
                if (z3) {
                    sdkClickResponseData.clickTime = clickTimeInSeconds;
                    sdkClickResponseData.installBegin = installBeginTimeInSeconds;
                    sdkClickResponseData.installReferrer = str7;
                    sdkClickResponseData.clickTimeServer = clickTimeServerInSeconds;
                    sdkClickResponseData.installBeginServer = j;
                    sdkClickResponseData.installVersion = str3;
                    sdkClickResponseData.googlePlayInstant = bool;
                    sdkClickResponseData.referrerApi = str2;
                    sdkClickResponseData.isInstallReferrer = true;
                }
                if (z && (str4 = activityPackage.getParameters().get("found_location")) != null && !str4.isEmpty()) {
                    sharedPreferencesManager = new SharedPreferencesManager(iActivityHandler.getContext());
                    if (Constants.SYSTEM_INSTALLER_REFERRER.equalsIgnoreCase(str4)) {
                        sharedPreferencesManager.removePreinstallReferrer();
                    } else {
                        sharedPreferencesManager.setPreinstallPayloadReadStatus(PreinstallUtil.markAsRead(str4, sharedPreferencesManager.getPreinstallPayloadReadStatus()));
                    }
                }
                iActivityHandler.finishedTrackingActivity(sdkClickResponseData);
            }
            return;
        }
        str3 = str;
        responseDataSendActivityPackageSync = this.activityPackageSender.sendActivityPackageSync(activityPackage, generateSendingParametersI());
        if (responseDataSendActivityPackageSync instanceof SdkClickResponseData) {
            return;
        }
        sdkClickResponseData = (SdkClickResponseData) responseDataSendActivityPackageSync;
        if (sdkClickResponseData.willRetry) {
            retrySendingI(activityPackage);
            return;
        }
        if (iActivityHandler == null) {
            return;
        }
        if (sdkClickResponseData.trackingState == TrackingState.OPTED_OUT) {
            iActivityHandler.gotOptOutResponse();
            return;
        }
        if (z2) {
            new SharedPreferencesManager(iActivityHandler.getContext()).removeRawReferrer(str6, activityPackage.getClickTimeInMilliseconds());
        }
        if (z3) {
            sdkClickResponseData.clickTime = clickTimeInSeconds;
            sdkClickResponseData.installBegin = installBeginTimeInSeconds;
            sdkClickResponseData.installReferrer = str7;
            sdkClickResponseData.clickTimeServer = clickTimeServerInSeconds;
            sdkClickResponseData.installBeginServer = j;
            sdkClickResponseData.installVersion = str3;
            sdkClickResponseData.googlePlayInstant = bool;
            sdkClickResponseData.referrerApi = str2;
            sdkClickResponseData.isInstallReferrer = true;
        }
        if (z) {
            sharedPreferencesManager = new SharedPreferencesManager(iActivityHandler.getContext());
            if (Constants.SYSTEM_INSTALLER_REFERRER.equalsIgnoreCase(str4)) {
                sharedPreferencesManager.removePreinstallReferrer();
            } else {
                sharedPreferencesManager.setPreinstallPayloadReadStatus(PreinstallUtil.markAsRead(str4, sharedPreferencesManager.getPreinstallPayloadReadStatus()));
            }
        }
        iActivityHandler.finishedTrackingActivity(sdkClickResponseData);
    }

    private Map<String, String> generateSendingParametersI() {
        HashMap map = new HashMap();
        PackageBuilder.addString(map, "sent_at", Util.dateFormatter.format(Long.valueOf(System.currentTimeMillis())));
        int size = this.packageQueue.size() - 1;
        if (size > 0) {
            PackageBuilder.addLong(map, "queue_size", size);
        }
        return map;
    }

    private void retrySendingI(ActivityPackage activityPackage) {
        this.logger.error("Retrying sdk_click package for the %d time", Integer.valueOf(activityPackage.increaseRetries()));
        sendSdkClick(activityPackage);
    }

    private void logErrorMessageI(ActivityPackage activityPackage, String str, Throwable th) {
        this.logger.error(Util.formatString("%s. (%s)", activityPackage.getFailureMessage(), Util.getReasonString(str, th)), new Object[0]);
    }
}

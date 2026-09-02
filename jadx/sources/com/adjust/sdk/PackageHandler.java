package com.adjust.sdk;

import android.content.Context;
import com.adjust.sdk.network.IActivityPackageSender;
import com.adjust.sdk.scheduler.SingleThreadCachedScheduler;
import com.adjust.sdk.scheduler.ThreadScheduler;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;

/* JADX INFO: loaded from: classes.dex */
public class PackageHandler implements IPackageHandler, IActivityPackageSender.ResponseDataCallbackSubscriber {
    private static final String PACKAGE_QUEUE_FILENAME = "AdjustIoPackageQueue";
    private static final String PACKAGE_QUEUE_NAME = "Package queue";
    private WeakReference<IActivityHandler> activityHandlerWeakRef;
    private IActivityPackageSender activityPackageSender;
    private Context context;
    private AtomicBoolean isSending;
    private List<ActivityPackage> packageQueue;
    private boolean paused;
    private ThreadScheduler scheduler = new SingleThreadCachedScheduler("PackageHandler");
    private ILogger logger = AdjustFactory.getLogger();
    private BackoffStrategy backoffStrategy = AdjustFactory.getPackageHandlerBackoffStrategy();
    private BackoffStrategy backoffStrategyForInstallSession = AdjustFactory.getInstallSessionBackoffStrategy();

    @Override // com.adjust.sdk.IPackageHandler
    public void teardown() {
        this.logger.verbose("PackageHandler teardown", new Object[0]);
        if (this.scheduler != null) {
            this.scheduler.teardown();
        }
        if (this.activityHandlerWeakRef != null) {
            this.activityHandlerWeakRef.clear();
        }
        if (this.packageQueue != null) {
            this.packageQueue.clear();
        }
        this.scheduler = null;
        this.activityHandlerWeakRef = null;
        this.packageQueue = null;
        this.isSending = null;
        this.context = null;
        this.logger = null;
        this.backoffStrategy = null;
    }

    static void deleteState(Context context) {
        deletePackageQueue(context);
    }

    public PackageHandler(IActivityHandler iActivityHandler, Context context, boolean z, IActivityPackageSender iActivityPackageSender) {
        init(iActivityHandler, context, z, iActivityPackageSender);
        this.scheduler.submit(new Runnable() { // from class: com.adjust.sdk.PackageHandler.1
            @Override // java.lang.Runnable
            public void run() {
                PackageHandler.this.initI();
            }
        });
    }

    @Override // com.adjust.sdk.IPackageHandler
    public void init(IActivityHandler iActivityHandler, Context context, boolean z, IActivityPackageSender iActivityPackageSender) {
        this.activityHandlerWeakRef = new WeakReference<>(iActivityHandler);
        this.context = context;
        this.paused = !z;
        this.activityPackageSender = iActivityPackageSender;
    }

    @Override // com.adjust.sdk.IPackageHandler
    public void addPackage(final ActivityPackage activityPackage) {
        this.scheduler.submit(new Runnable() { // from class: com.adjust.sdk.PackageHandler.2
            @Override // java.lang.Runnable
            public void run() {
                PackageHandler.this.addI(activityPackage);
            }
        });
    }

    @Override // com.adjust.sdk.IPackageHandler
    public void sendFirstPackage() {
        this.scheduler.submit(new Runnable() { // from class: com.adjust.sdk.PackageHandler.3
            @Override // java.lang.Runnable
            public void run() {
                PackageHandler.this.sendFirstI();
            }
        });
    }

    @Override // com.adjust.sdk.network.IActivityPackageSender.ResponseDataCallbackSubscriber
    public void onResponseDataCallback(ResponseData responseData) {
        long waitingTime;
        this.logger.debug("Got response in PackageHandler", new Object[0]);
        IActivityHandler iActivityHandler = this.activityHandlerWeakRef.get();
        if (iActivityHandler != null && responseData.trackingState == TrackingState.OPTED_OUT) {
            iActivityHandler.gotOptOutResponse();
        }
        if (!responseData.willRetry) {
            this.scheduler.submit(new Runnable() { // from class: com.adjust.sdk.PackageHandler.4
                @Override // java.lang.Runnable
                public void run() {
                    PackageHandler.this.sendNextI();
                }
            });
            if (iActivityHandler != null) {
                iActivityHandler.finishedTrackingActivity(responseData);
                return;
            }
            return;
        }
        if (iActivityHandler != null) {
            iActivityHandler.finishedTrackingActivity(responseData);
        }
        Runnable runnable = new Runnable() { // from class: com.adjust.sdk.PackageHandler.5
            @Override // java.lang.Runnable
            public void run() {
                PackageHandler.this.logger.verbose("Package handler can send", new Object[0]);
                PackageHandler.this.isSending.set(false);
                PackageHandler.this.sendFirstPackage();
            }
        };
        if (responseData.activityPackage == null) {
            runnable.run();
            return;
        }
        int iIncreaseRetries = responseData.activityPackage.increaseRetries();
        SharedPreferencesManager sharedPreferencesManager = new SharedPreferencesManager(this.context);
        if (responseData.activityPackage.getActivityKind() == ActivityKind.SESSION && !sharedPreferencesManager.getInstallTracked()) {
            waitingTime = Util.getWaitingTime(iIncreaseRetries, this.backoffStrategyForInstallSession);
        } else {
            waitingTime = Util.getWaitingTime(iIncreaseRetries, this.backoffStrategy);
        }
        double d = waitingTime;
        Double.isNaN(d);
        this.logger.verbose("Waiting for %s seconds before retrying the %d time", Util.SecondsDisplayFormat.format(d / 1000.0d), Integer.valueOf(iIncreaseRetries));
        this.scheduler.schedule(runnable, waitingTime);
    }

    @Override // com.adjust.sdk.IPackageHandler
    public void pauseSending() {
        this.paused = true;
    }

    @Override // com.adjust.sdk.IPackageHandler
    public void resumeSending() {
        this.paused = false;
    }

    @Override // com.adjust.sdk.IPackageHandler
    public void updatePackages(SessionParameters sessionParameters) {
        final SessionParameters sessionParametersDeepCopy = sessionParameters != null ? sessionParameters.deepCopy() : null;
        this.scheduler.submit(new Runnable() { // from class: com.adjust.sdk.PackageHandler.6
            @Override // java.lang.Runnable
            public void run() {
                PackageHandler.this.updatePackagesI(sessionParametersDeepCopy);
            }
        });
    }

    @Override // com.adjust.sdk.IPackageHandler
    public void flush() {
        this.scheduler.submit(new Runnable() { // from class: com.adjust.sdk.PackageHandler.7
            @Override // java.lang.Runnable
            public void run() {
                PackageHandler.this.flushI();
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void initI() {
        this.isSending = new AtomicBoolean();
        readPackageQueueI();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void addI(ActivityPackage activityPackage) {
        this.packageQueue.add(activityPackage);
        this.logger.debug("Added package %d (%s)", Integer.valueOf(this.packageQueue.size()), activityPackage);
        this.logger.verbose("%s", activityPackage.getExtendedString());
        writePackageQueueI();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void sendFirstI() {
        if (this.packageQueue.isEmpty()) {
            return;
        }
        if (this.paused) {
            this.logger.debug("Package handler is paused", new Object[0]);
        } else {
            if (this.isSending.getAndSet(true)) {
                this.logger.verbose("Package handler is already sending", new Object[0]);
                return;
            }
            Map<String, String> mapGenerateSendingParametersI = generateSendingParametersI();
            this.activityPackageSender.sendActivityPackage(this.packageQueue.get(0), mapGenerateSendingParametersI, this);
        }
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

    /* JADX INFO: Access modifiers changed from: private */
    public void sendNextI() {
        if (this.packageQueue.isEmpty()) {
            return;
        }
        this.packageQueue.remove(0);
        writePackageQueueI();
        this.isSending.set(false);
        this.logger.verbose("Package handler can send", new Object[0]);
        sendFirstI();
    }

    public void updatePackagesI(SessionParameters sessionParameters) {
        if (sessionParameters == null) {
            return;
        }
        this.logger.debug("Updating package handler queue", new Object[0]);
        this.logger.verbose("Session callback parameters: %s", sessionParameters.callbackParameters);
        this.logger.verbose("Session partner parameters: %s", sessionParameters.partnerParameters);
        for (ActivityPackage activityPackage : this.packageQueue) {
            Map<String, String> parameters = activityPackage.getParameters();
            PackageBuilder.addMapJson(parameters, Constants.CALLBACK_PARAMETERS, Util.mergeParameters(sessionParameters.callbackParameters, activityPackage.getCallbackParameters(), "Callback"));
            PackageBuilder.addMapJson(parameters, Constants.PARTNER_PARAMETERS, Util.mergeParameters(sessionParameters.partnerParameters, activityPackage.getPartnerParameters(), "Partner"));
        }
        writePackageQueueI();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void flushI() {
        this.packageQueue.clear();
        writePackageQueueI();
    }

    private void readPackageQueueI() {
        try {
            this.packageQueue = (List) Util.readObject(this.context, PACKAGE_QUEUE_FILENAME, PACKAGE_QUEUE_NAME, List.class);
        } catch (Exception e) {
            this.logger.error("Failed to read %s file (%s)", PACKAGE_QUEUE_NAME, e.getMessage());
            this.packageQueue = null;
        }
        if (this.packageQueue != null) {
            this.logger.debug("Package handler read %d packages", Integer.valueOf(this.packageQueue.size()));
        } else {
            this.packageQueue = new ArrayList();
        }
    }

    private void writePackageQueueI() {
        Util.writeObject(this.packageQueue, this.context, PACKAGE_QUEUE_FILENAME, PACKAGE_QUEUE_NAME);
        this.logger.debug("Package handler wrote %d packages", Integer.valueOf(this.packageQueue.size()));
    }

    public static Boolean deletePackageQueue(Context context) {
        return Boolean.valueOf(context.deleteFile(PACKAGE_QUEUE_FILENAME));
    }
}

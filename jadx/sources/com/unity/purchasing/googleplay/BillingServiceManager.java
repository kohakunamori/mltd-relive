package com.unity.purchasing.googleplay;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.pm.ResolveInfo;
import android.os.IBinder;
import android.util.Log;
import com.android.vending.billing.IInAppBillingService;
import java.util.List;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/* JADX INFO: loaded from: classes.dex */
public class BillingServiceManager implements IBillingServiceManager {
    private Context context;
    private Intent googlePlayBillingServiceIntent;
    private volatile IInAppBillingService mService;
    private volatile ServiceConnection mServiceConn;
    private ExecutorService executor = Executors.newSingleThreadExecutor();
    private final ConcurrentLinkedQueue<BillingServiceProcessor> callbacks = new ConcurrentLinkedQueue<>();

    public boolean billingAvailable() {
        return false;
    }

    public BillingServiceManager(final Context context) {
        this.context = context;
        this.mServiceConn = new ServiceConnection() { // from class: com.unity.purchasing.googleplay.BillingServiceManager.1
            @Override // android.content.ServiceConnection
            public void onServiceDisconnected(ComponentName componentName) {
                BillingServiceManager.this.logDebug("Billing service disconnected.");
                BillingServiceManager.this.executor.execute(new Runnable() { // from class: com.unity.purchasing.googleplay.BillingServiceManager.1.1
                    @Override // java.lang.Runnable
                    public void run() {
                        context.unbindService(BillingServiceManager.this.mServiceConn);
                        BillingServiceManager.this.mService = null;
                        if (BillingServiceManager.this.callbacks.size() == 0) {
                            BillingServiceManager.this.logDebug("Releasing billing service.");
                        } else {
                            BillingServiceManager.this.logDebug("Rebinding billing service.");
                            BillingServiceManager.this.bindToGooglePlayService();
                        }
                    }
                });
            }

            @Override // android.content.ServiceConnection
            public void onServiceConnected(ComponentName componentName, final IBinder iBinder) {
                BillingServiceManager.this.logDebug("Billing service connected.");
                BillingServiceManager.this.executor.execute(new Runnable() { // from class: com.unity.purchasing.googleplay.BillingServiceManager.1.2
                    @Override // java.lang.Runnable
                    public void run() {
                        BillingServiceManager.this.mService = IInAppBillingService.Stub.asInterface(iBinder);
                        BillingServiceManager.this.tryPumpCallbacks();
                    }
                });
            }
        };
    }

    @Override // com.unity.purchasing.googleplay.IBillingServiceManager
    public void initialise() throws GooglePlayBillingUnAvailableException {
        if (this.googlePlayBillingServiceIntent == null) {
            this.googlePlayBillingServiceIntent = getGooglePlayServiceIntent();
        }
    }

    private Intent getGooglePlayServiceIntent() throws GooglePlayBillingUnAvailableException {
        Intent intent = new Intent("com.android.vending.billing.InAppBillingService.BIND");
        intent.setPackage("com.android.vending");
        List<ResolveInfo> listQueryIntentServices = this.context.getPackageManager().queryIntentServices(intent, 0);
        if (listQueryIntentServices != null && listQueryIntentServices.size() == 1) {
            return intent;
        }
        StringBuilder sb = new StringBuilder();
        sb.append("Expected to find a single Google Play billing service but found ");
        sb.append(listQueryIntentServices == null ? "0" : Integer.valueOf(listQueryIntentServices.size()));
        String string = sb.toString();
        logDebug(string);
        throw new GooglePlayBillingUnAvailableException(string);
    }

    void bindToGooglePlayService() {
        this.context.bindService(this.googlePlayBillingServiceIntent, this.mServiceConn, 1);
    }

    @Override // com.unity.purchasing.googleplay.IBillingServiceManager
    public void workWith(BillingServiceProcessor billingServiceProcessor) {
        this.callbacks.add(billingServiceProcessor);
        tryPumpCallbacks();
    }

    @Override // com.unity.purchasing.googleplay.IBillingServiceManager
    public void dispose() {
        this.context.unbindService(this.mServiceConn);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void tryPumpCallbacks() {
        this.executor.execute(new Runnable() { // from class: com.unity.purchasing.googleplay.BillingServiceManager.2
            @Override // java.lang.Runnable
            public void run() {
                if (BillingServiceManager.this.mService != null) {
                    while (BillingServiceManager.this.callbacks.size() > 0) {
                        BillingServiceManager.this.logDebug("invoking callback");
                        ((BillingServiceProcessor) BillingServiceManager.this.callbacks.remove()).workWith(BillingServiceManager.this.mService);
                    }
                    return;
                }
                BillingServiceManager.this.bindToGooglePlayService();
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void logDebug(String str) {
        Log.i("UnityIAP", str);
    }
}

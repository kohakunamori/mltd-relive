package com.unity.purchasing.googleplay;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.IntentSender;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.RemoteException;
import android.text.TextUtils;
import android.util.Log;
import com.android.vending.billing.IInAppBillingService;
import com.google.vr.ndk.base.DaydreamApi;
import com.unity.purchasing.common.SaneJSONObject;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.json.JSONException;

/* JADX INFO: loaded from: classes.dex */
public class IabHelper {
    public static final int BILLING_RESPONSE_RESULT_BILLING_UNAVAILABLE = 3;
    public static final int BILLING_RESPONSE_RESULT_DEVELOPER_ERROR = 5;
    public static final int BILLING_RESPONSE_RESULT_ERROR = 6;
    public static final int BILLING_RESPONSE_RESULT_ITEM_ALREADY_OWNED = 7;
    public static final int BILLING_RESPONSE_RESULT_ITEM_NOT_OWNED = 8;
    public static final int BILLING_RESPONSE_RESULT_ITEM_UNAVAILABLE = 4;
    public static final int BILLING_RESPONSE_RESULT_OK = 0;
    public static final int BILLING_RESPONSE_RESULT_SERVICE_UNAVAILABLE = 2;
    public static final int BILLING_RESPONSE_RESULT_USER_CANCELED = 1;
    public static final String GET_SKU_DETAILS_ITEM_LIST = "ITEM_ID_LIST";
    public static final String GET_SKU_DETAILS_ITEM_TYPE_LIST = "ITEM_TYPE_LIST";
    public static final int IABHELPER_BAD_RESPONSE = -1002;
    public static final int IABHELPER_ERROR_BASE = -1000;
    public static final int IABHELPER_INVALID_CONSUMPTION = -1010;
    public static final int IABHELPER_MISSING_TOKEN = -1007;
    public static final int IABHELPER_REMOTE_EXCEPTION = -1001;
    public static final int IABHELPER_SEND_INTENT_FAILED = -1004;
    public static final int IABHELPER_SUBSCRIPTIONS_NOT_AVAILABLE = -1009;
    public static final int IABHELPER_UNKNOWN_ERROR = -1008;
    public static final int IABHELPER_UNKNOWN_PURCHASE_RESPONSE = -1006;
    public static final int IABHELPER_USER_CANCELLED = -1005;
    public static final int IABHELPER_VERIFICATION_FAILED = -1003;
    public static final String INAPP_CONTINUATION_TOKEN = "INAPP_CONTINUATION_TOKEN";
    public static final String ITEM_TYPE_INAPP = "inapp";
    public static final String ITEM_TYPE_SUBS = "subs";
    public static final String RESPONSE_BUY_INTENT = "BUY_INTENT";
    public static final String RESPONSE_CODE = "RESPONSE_CODE";
    public static final String RESPONSE_GET_SKU_DETAILS_LIST = "DETAILS_LIST";
    public static final String RESPONSE_INAPP_ITEM_LIST = "INAPP_PURCHASE_ITEM_LIST";
    public static final String RESPONSE_INAPP_PURCHASE_DATA = "INAPP_PURCHASE_DATA";
    public static final String RESPONSE_INAPP_PURCHASE_DATA_LIST = "INAPP_PURCHASE_DATA_LIST";
    public static final String RESPONSE_INAPP_SIGNATURE = "INAPP_DATA_SIGNATURE";
    public static final String RESPONSE_INAPP_SIGNATURE_LIST = "INAPP_DATA_SIGNATURE_LIST";
    private IActivityLauncher launcher;
    Context mContext;
    OnIabPurchaseFinishedListener mPurchaseListener;
    String mPurchasingItemType;
    int mRequestCode;
    private IBillingServiceManager serviceManager;
    boolean mDebugLog = false;
    String mDebugTag = "IabHelper";
    volatile boolean mSetupDone = false;
    volatile boolean mDisposed = false;
    boolean mSubscriptionsSupported = false;
    private boolean mVrSupported = false;
    private boolean mUnityVrEnabled = false;
    private boolean mDaydreamApiAvailable = false;
    String mAsyncOperation = "";
    private Inventory inv = new Inventory();

    public interface OnConsumeFinishedListener {
        void onConsumeFinished(Purchase purchase, IabResult iabResult) throws JSONException;
    }

    public interface OnConsumeMultiFinishedListener {
        void onConsumeMultiFinished(List<Purchase> list, List<IabResult> list2);
    }

    public interface OnIabPurchaseFinishedListener {
        void onIabPurchaseFinished(IabResult iabResult, Purchase purchase);
    }

    public interface OnIabSetupFinishedListener {
        void onIabSetupFinished(IabResult iabResult);
    }

    public interface QueryInventoryFinishedListener {
        void onQueryInventoryFinished(IabResult iabResult, Inventory inventory) throws Exception;
    }

    public IabHelper(Context context, IBillingServiceManager iBillingServiceManager, IActivityLauncher iActivityLauncher) {
        this.mContext = context.getApplicationContext();
        this.serviceManager = iBillingServiceManager;
        this.launcher = iActivityLauncher;
        logDebug("IAB helper created.");
    }

    public void enableDebugLogging(boolean z, String str) {
        this.mDebugLog = z;
        this.mDebugTag = str;
    }

    public void enableDebugLogging(boolean z) {
        this.mDebugLog = z;
    }

    public void enableUnityVr(boolean z) {
        this.mUnityVrEnabled = z;
    }

    public void enableDaydreamApi(boolean z) {
        this.mDaydreamApiAvailable = z;
    }

    public void startSetup(final OnIabSetupFinishedListener onIabSetupFinishedListener) {
        if (this.mSetupDone) {
            throw new IllegalStateException("IAB helper is already set up.");
        }
        logDebug("Starting in-app billing setup.");
        this.serviceManager.workWith(new BillingServiceProcessor() { // from class: com.unity.purchasing.googleplay.IabHelper.1
            @Override // com.unity.purchasing.googleplay.BillingServiceProcessor
            public void workWith(IInAppBillingService iInAppBillingService) {
                IabHelper.this.finishSetup(onIabSetupFinishedListener, iInAppBillingService);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void finishSetup(OnIabSetupFinishedListener onIabSetupFinishedListener, IInAppBillingService iInAppBillingService) {
        String packageName = this.mContext.getPackageName();
        try {
            logDebug("Checking for in-app billing 3 support.");
            int iIsBillingSupported = iInAppBillingService.isBillingSupported(3, packageName, "inapp");
            if (iIsBillingSupported != 0) {
                onIabSetupFinishedListener.onIabSetupFinished(new IabResult(iIsBillingSupported, "Billing V3 not supported."));
                this.mSubscriptionsSupported = false;
                return;
            }
            logDebug("In-app billing version 3 supported for " + packageName);
            int iIsBillingSupported2 = iInAppBillingService.isBillingSupported(3, packageName, "subs");
            if (iIsBillingSupported2 == 0) {
                logDebug("Subscriptions AVAILABLE.");
                this.mSubscriptionsSupported = true;
            } else {
                logDebug("Subscriptions NOT AVAILABLE. Response: " + iIsBillingSupported2);
            }
            Bundle bundle = new Bundle();
            bundle.putBoolean("vr", true);
            int iIsBillingSupportedExtraParams = iInAppBillingService.isBillingSupportedExtraParams(7, this.mContext.getPackageName(), "inapp", bundle);
            if (iIsBillingSupportedExtraParams == 0) {
                logDebug("VR supported.");
                this.mVrSupported = true;
            } else {
                logDebug("VR purchases  NOT AVAILABLE. Response: " + iIsBillingSupportedExtraParams);
            }
            this.mSetupDone = true;
            onIabSetupFinishedListener.onIabSetupFinished(new IabResult(0, "Setup successful."));
        } catch (RemoteException unused) {
            onIabSetupFinishedListener.onIabSetupFinished(new IabResult(IABHELPER_REMOTE_EXCEPTION, "RemoteException while setting up in-app billing."));
        }
    }

    public void dispose() {
        logDebug("Disposing.");
        this.mSetupDone = false;
        this.serviceManager.dispose();
        this.mDisposed = true;
    }

    public boolean subscriptionsSupported() {
        return this.mSubscriptionsSupported;
    }

    public void launchPurchaseFlow(Activity activity, String str, int i, OnIabPurchaseFinishedListener onIabPurchaseFinishedListener) {
        launchPurchaseFlow(activity, str, i, onIabPurchaseFinishedListener, "");
    }

    public void launchPurchaseFlow(Activity activity, String str, int i, OnIabPurchaseFinishedListener onIabPurchaseFinishedListener, String str2) {
        launchPurchaseFlow(activity, str, "inapp", i, onIabPurchaseFinishedListener, str2);
    }

    public void launchSubscriptionPurchaseFlow(Activity activity, String str, int i, OnIabPurchaseFinishedListener onIabPurchaseFinishedListener) {
        launchSubscriptionPurchaseFlow(activity, str, i, onIabPurchaseFinishedListener, "");
    }

    public void launchSubscriptionPurchaseFlow(Activity activity, String str, int i, OnIabPurchaseFinishedListener onIabPurchaseFinishedListener, String str2) {
        launchPurchaseFlow(activity, str, "subs", i, onIabPurchaseFinishedListener, str2);
    }

    public void launchPurchaseFlow(final Activity activity, final String str, final String str2, final int i, final OnIabPurchaseFinishedListener onIabPurchaseFinishedListener, final String str3) {
        checkSetupDone("launchPurchaseFlow");
        if (str2.equals("subs") && !this.mSubscriptionsSupported) {
            IabResult iabResult = new IabResult(IABHELPER_SUBSCRIPTIONS_NOT_AVAILABLE, "Subscriptions are not available.");
            if (onIabPurchaseFinishedListener != null) {
                onIabPurchaseFinishedListener.onIabPurchaseFinished(iabResult, null);
                return;
            }
            return;
        }
        this.serviceManager.workWith(new BillingServiceProcessor() { // from class: com.unity.purchasing.googleplay.IabHelper.2
            /* JADX WARN: Code duplicated, block: B:19:0x00c3 A[Catch: JSONException -> 0x00c1, RemoteException -> 0x0162, SendIntentException -> 0x0191, TryCatch #0 {JSONException -> 0x00c1, blocks: (B:14:0x00a6, B:16:0x00b4, B:20:0x00d0, B:22:0x00d9, B:19:0x00c3), top: B:44:0x00a6, outer: #3 }] */
            @Override // com.unity.purchasing.googleplay.BillingServiceProcessor
            public void workWith(IInAppBillingService iInAppBillingService) {
                Bundle buyIntent;
                Purchase purchase;
                try {
                    IabHelper.this.logDebug("Constructing buy intent for " + str + ", item type: " + str2);
                    if (IabHelper.this.mVrSupported && IabHelper.this.mUnityVrEnabled) {
                        Bundle bundle = new Bundle();
                        bundle.putBoolean("vr", true);
                        IabHelper.this.logDebug("Initiating VR purchase intent");
                        buyIntent = iInAppBillingService.getBuyIntentExtraParams(7, IabHelper.this.mContext.getPackageName(), str, str2, str3, bundle);
                    } else {
                        buyIntent = iInAppBillingService.getBuyIntent(3, IabHelper.this.mContext.getPackageName(), str, str2, str3);
                    }
                    int responseCodeFromBundle = IabHelper.this.getResponseCodeFromBundle(buyIntent);
                    if (responseCodeFromBundle != 0) {
                        IabHelper.this.logError("Unable to buy item, Error response: " + IabHelper.getResponseDesc(responseCodeFromBundle));
                        IabResult iabResult2 = new IabResult(responseCodeFromBundle, "Unable to buy item");
                        SaneJSONObject saneJSONObject = new SaneJSONObject();
                        saneJSONObject.put("productId", str);
                        if (responseCodeFromBundle == 7) {
                            try {
                                if (IabHelper.this.inv.hasPurchase(str)) {
                                    purchase = IabHelper.this.inv.getPurchase(str);
                                } else {
                                    purchase = new Purchase(str2, saneJSONObject.toString(), "");
                                }
                            } catch (JSONException e) {
                                e.printStackTrace();
                                return;
                            }
                        } else {
                            purchase = new Purchase(str2, saneJSONObject.toString(), "");
                        }
                        activity.finish();
                        if (onIabPurchaseFinishedListener != null) {
                            onIabPurchaseFinishedListener.onIabPurchaseFinished(iabResult2, purchase);
                            return;
                        }
                        return;
                    }
                    final PendingIntent pendingIntent = (PendingIntent) buyIntent.getParcelable(IabHelper.RESPONSE_BUY_INTENT);
                    IabHelper.this.logDebug("Launching buy intent for " + str + ". Request code: " + i);
                    IabHelper.this.mRequestCode = i;
                    IabHelper.this.mPurchaseListener = onIabPurchaseFinishedListener;
                    IabHelper.this.mPurchasingItemType = str2;
                    if (IabHelper.this.mVrSupported && IabHelper.this.mUnityVrEnabled && IabHelper.this.mDaydreamApiAvailable) {
                        new Handler(Looper.getMainLooper()).post(new Runnable() { // from class: com.unity.purchasing.googleplay.IabHelper.2.1
                            @Override // java.lang.Runnable
                            public void run() {
                                DaydreamApi daydreamApiCreate = DaydreamApi.create(activity);
                                daydreamApiCreate.launchInVrForResult(activity, pendingIntent, i);
                                daydreamApiCreate.close();
                            }
                        });
                    } else {
                        pendingIntent.getIntentSender();
                        IabHelper.this.launcher.startIntentSenderForResult(activity, pendingIntent, i, new Intent(), str);
                    }
                } catch (IntentSender.SendIntentException e2) {
                    IabHelper.this.logError("SendIntentException while launching purchase flow for sku " + str);
                    e2.printStackTrace();
                    IabResult iabResult3 = new IabResult(IabHelper.IABHELPER_SEND_INTENT_FAILED, "Failed to send intent.");
                    if (onIabPurchaseFinishedListener != null) {
                        onIabPurchaseFinishedListener.onIabPurchaseFinished(iabResult3, null);
                    }
                } catch (RemoteException e3) {
                    IabHelper.this.logError("RemoteException while launching purchase flow for sku " + str);
                    e3.printStackTrace();
                    IabResult iabResult4 = new IabResult(IabHelper.IABHELPER_REMOTE_EXCEPTION, "Remote exception while starting purchase flow");
                    if (onIabPurchaseFinishedListener != null) {
                        onIabPurchaseFinishedListener.onIabPurchaseFinished(iabResult4, null);
                    }
                }
            }
        });
    }

    public boolean handleActivityResult(int i, int i2, Intent intent) {
        if (i != this.mRequestCode) {
            return false;
        }
        checkSetupDone("handleActivityResult");
        if (intent == null) {
            logError("Null data in IAB activity result.");
            IabResult iabResult = new IabResult(IABHELPER_BAD_RESPONSE, "Null data in IAB result");
            if (this.mPurchaseListener != null) {
                this.mPurchaseListener.onIabPurchaseFinished(iabResult, null);
            }
            return true;
        }
        int responseCodeFromIntent = getResponseCodeFromIntent(intent);
        String stringExtra = intent.getStringExtra(RESPONSE_INAPP_PURCHASE_DATA);
        String stringExtra2 = intent.getStringExtra(RESPONSE_INAPP_SIGNATURE);
        if (i2 == -1 && responseCodeFromIntent == 0) {
            logDebug("Successful resultcode from purchase activity.");
            logDebug("Purchase data: " + stringExtra);
            logDebug("Data signature: " + stringExtra2);
            logDebug("Extras: " + intent.getExtras());
            logDebug("Expected item type: " + this.mPurchasingItemType);
            if (stringExtra == null || stringExtra2 == null) {
                logError("BUG: either purchaseData or dataSignature is null.");
                logDebug("Extras: " + intent.getExtras().toString());
                IabResult iabResult2 = new IabResult(IABHELPER_UNKNOWN_ERROR, "IAB returned null purchaseData or dataSignature");
                if (this.mPurchaseListener != null) {
                    this.mPurchaseListener.onIabPurchaseFinished(iabResult2, null);
                }
                return true;
            }
            try {
                Purchase purchase = new Purchase(this.mPurchasingItemType, stringExtra, stringExtra2);
                purchase.getSku();
                if (this.mPurchaseListener != null) {
                    this.mPurchaseListener.onIabPurchaseFinished(new IabResult(0, "Success"), purchase);
                }
            } catch (JSONException e) {
                logError("Failed to parse purchase data.");
                e.printStackTrace();
                IabResult iabResult3 = new IabResult(IABHELPER_BAD_RESPONSE, "Failed to parse purchase data.");
                if (this.mPurchaseListener != null) {
                    this.mPurchaseListener.onIabPurchaseFinished(iabResult3, null);
                }
                return true;
            }
        } else if (i2 == -1) {
            logDebug("Result code was OK but in-app billing response was not OK: " + getResponseDesc(responseCodeFromIntent));
            if (this.mPurchaseListener != null) {
                this.mPurchaseListener.onIabPurchaseFinished(new IabResult(responseCodeFromIntent, "Problem purchasing item."), null);
            }
        } else if (i2 == 0) {
            logDebug("Purchase canceled - Response: " + getResponseDesc(responseCodeFromIntent));
            IabResult iabResult4 = new IabResult(IABHELPER_USER_CANCELLED, "User canceled.");
            if (this.mPurchaseListener != null) {
                this.mPurchaseListener.onIabPurchaseFinished(iabResult4, null);
            }
        } else {
            logError("Purchase failed. Result code: " + Integer.toString(i2) + ". Response: " + getResponseDesc(responseCodeFromIntent));
            IabResult iabResult5 = new IabResult(IABHELPER_UNKNOWN_PURCHASE_RESPONSE, "Unknown purchase response.");
            if (this.mPurchaseListener != null) {
                this.mPurchaseListener.onIabPurchaseFinished(iabResult5, null);
            }
        }
        return true;
    }

    public Inventory queryInventory(boolean z, List<String> list, IInAppBillingService iInAppBillingService) throws IabException {
        return queryInventory(z, list, null, iInAppBillingService);
    }

    public Inventory queryInventory(boolean z, List<String> list, List<String> list2, IInAppBillingService iInAppBillingService) throws IabException {
        int iQuerySkuDetails;
        int iQuerySkuDetails2;
        checkSetupDone("queryInventory");
        try {
            int iQueryPurchases = queryPurchases(this.inv, "inapp", iInAppBillingService);
            if (iQueryPurchases != 0) {
                throw new IabException(iQueryPurchases, "Error refreshing inventory (querying owned items).");
            }
            if (z && (iQuerySkuDetails2 = querySkuDetails("inapp", this.inv, list, iInAppBillingService)) != 0) {
                throw new IabException(iQuerySkuDetails2, "Error refreshing inventory (querying prices of items).");
            }
            if (this.mSubscriptionsSupported) {
                int iQueryPurchases2 = queryPurchases(this.inv, "subs", iInAppBillingService);
                if (iQueryPurchases2 != 0) {
                    throw new IabException(iQueryPurchases2, "Error refreshing inventory (querying owned subscriptions).");
                }
                if (z && (iQuerySkuDetails = querySkuDetails("subs", this.inv, list, iInAppBillingService)) != 0) {
                    throw new IabException(iQuerySkuDetails, "Error refreshing inventory (querying prices of subscriptions).");
                }
            }
            return this.inv;
        } catch (RemoteException e) {
            throw new IabException(IABHELPER_REMOTE_EXCEPTION, "Remote exception while refreshing inventory.", e);
        } catch (SecurityException e2) {
            throw new IabException(IABHELPER_UNKNOWN_ERROR, "SecurityException querying inventory, update Google Play - https://github.com/googlesamples/android-play-billing/issues/26", e2);
        } catch (JSONException e3) {
            throw new IabException(IABHELPER_BAD_RESPONSE, "Error parsing JSON response while refreshing inventory.", e3);
        }
    }

    public void queryInventoryAsync(final boolean z, final List<String> list, final QueryInventoryFinishedListener queryInventoryFinishedListener, final long j) {
        checkSetupDone("queryInventory");
        this.serviceManager.workWith(new BillingServiceProcessor() { // from class: com.unity.purchasing.googleplay.IabHelper.3
            @Override // com.unity.purchasing.googleplay.BillingServiceProcessor
            public void workWith(IInAppBillingService iInAppBillingService) {
                Inventory inventoryQueryInventory;
                try {
                    Thread.sleep(j);
                } catch (InterruptedException unused) {
                }
                IabResult iabResult = new IabResult(0, "Inventory refresh successful.");
                try {
                    inventoryQueryInventory = IabHelper.this.queryInventory(z, list, iInAppBillingService);
                } catch (IabException e) {
                    iabResult = e.getResult();
                    inventoryQueryInventory = null;
                }
                if (IabHelper.this.mDisposed || queryInventoryFinishedListener == null) {
                    return;
                }
                try {
                    queryInventoryFinishedListener.onQueryInventoryFinished(iabResult, inventoryQueryInventory);
                } catch (Exception e2) {
                    e2.printStackTrace();
                }
            }
        });
    }

    public void queryInventoryAsync(QueryInventoryFinishedListener queryInventoryFinishedListener) {
        queryInventoryAsync(true, null, queryInventoryFinishedListener, 0L);
    }

    public void queryInventoryAsync(boolean z, QueryInventoryFinishedListener queryInventoryFinishedListener) {
        queryInventoryAsync(z, null, queryInventoryFinishedListener, 0L);
    }

    void consume(Purchase purchase, IInAppBillingService iInAppBillingService) throws IabException {
        if (!purchase.mItemType.equals("inapp")) {
            throw new IabException(IABHELPER_INVALID_CONSUMPTION, "Items of type '" + purchase.mItemType + "' can't be consumed.");
        }
        try {
            String token = purchase.getToken();
            String sku = purchase.getSku();
            if (token == null || token.equals("")) {
                logError("Can't consume " + sku + ". No token.");
                throw new IabException(IABHELPER_MISSING_TOKEN, "PurchaseInfo is missing token for sku: " + sku + " " + purchase);
            }
            logDebug("Consuming sku: " + sku + ", token: " + token);
            int iConsumePurchase = iInAppBillingService.consumePurchase(3, this.mContext.getPackageName(), token);
            if (iConsumePurchase == 0) {
                logDebug("Successfully consumed sku: " + sku);
                return;
            }
            logDebug("Error consuming consuming sku " + sku + ". " + getResponseDesc(iConsumePurchase));
            throw new IabException(iConsumePurchase, "Error consuming sku " + sku);
        } catch (RemoteException e) {
            throw new IabException(IABHELPER_REMOTE_EXCEPTION, "Remote exception while consuming. PurchaseInfo: " + purchase, e);
        }
    }

    public void consumeAsync(Purchase purchase, OnConsumeFinishedListener onConsumeFinishedListener) {
        checkSetupDone("consume");
        ArrayList arrayList = new ArrayList();
        arrayList.add(purchase);
        consumeAsyncInternal(arrayList, onConsumeFinishedListener, null);
    }

    public void consumeAsync(List<Purchase> list, OnConsumeMultiFinishedListener onConsumeMultiFinishedListener) {
        checkSetupDone("consume");
        consumeAsyncInternal(list, null, onConsumeMultiFinishedListener);
    }

    public static String getResponseDesc(int i) {
        String[] strArrSplit = "0:OK/1:User Canceled/2:Unknown/3:Billing Unavailable/4:Item unavailable/5:Developer Error/6:Error/7:Item Already Owned/8:Item not owned".split("/");
        String[] strArrSplit2 = "0:OK/-1001:Remote exception during initialization/-1002:Bad response received/-1003:Purchase signature verification failed/-1004:Send intent failed/-1005:User cancelled/-1006:Unknown purchase response/-1007:Missing token/-1008:Unknown error/-1009:Subscriptions not available/-1010:Invalid consumption attempt".split("/");
        if (i <= -1000) {
            int i2 = (-1000) - i;
            if (i2 >= 0 && i2 < strArrSplit2.length) {
                return strArrSplit2[i2];
            }
            return String.valueOf(i) + ":Unknown IAB Helper Error";
        }
        if (i < 0 || i >= strArrSplit.length) {
            return String.valueOf(i) + ":Unknown";
        }
        return strArrSplit[i];
    }

    void checkSetupDone(String str) {
        if (this.mSetupDone) {
            return;
        }
        logError("Illegal state for operation (" + str + "): IAB helper is not set up.");
        throw new IllegalStateException("IAB helper is not set up. Can't perform operation: " + str);
    }

    int getResponseCodeFromBundle(Bundle bundle) {
        Object obj = bundle.get("RESPONSE_CODE");
        if (obj == null) {
            logDebug("Bundle with null response code, assuming OK (known issue)");
            return 0;
        }
        if (obj instanceof Integer) {
            return ((Integer) obj).intValue();
        }
        if (obj instanceof Long) {
            return (int) ((Long) obj).longValue();
        }
        logError("Unexpected type for bundle response code.");
        logError(obj.getClass().getName());
        throw new RuntimeException("Unexpected type for bundle response code: " + obj.getClass().getName());
    }

    int getResponseCodeFromIntent(Intent intent) {
        Object obj = intent.getExtras().get("RESPONSE_CODE");
        if (obj == null) {
            logError("Intent with no response code, assuming OK (known issue)");
            return 0;
        }
        if (obj instanceof Integer) {
            return ((Integer) obj).intValue();
        }
        if (obj instanceof Long) {
            return (int) ((Long) obj).longValue();
        }
        logError("Unexpected type for intent response code.");
        logError(obj.getClass().getName());
        throw new RuntimeException("Unexpected type for intent response code: " + obj.getClass().getName());
    }

    int queryPurchases(Inventory inventory, String str, IInAppBillingService iInAppBillingService) throws JSONException, RemoteException {
        if (this.mDisposed) {
            logDebug("queryPurchases - Biller disposed. Returning...");
            return 0;
        }
        logDebug("Querying owned items, item type: " + str);
        logDebug("Package name: " + this.mContext.getPackageName());
        String string = null;
        do {
            logDebug("Calling getPurchases with continuation token: " + string);
            Bundle purchases = iInAppBillingService.getPurchases(3, this.mContext.getPackageName(), str, string);
            int responseCodeFromBundle = getResponseCodeFromBundle(purchases);
            logDebug("Owned items response: " + String.valueOf(responseCodeFromBundle));
            if (responseCodeFromBundle != 0) {
                logDebug("getPurchases() failed: " + getResponseDesc(responseCodeFromBundle));
                return responseCodeFromBundle;
            }
            if (!purchases.containsKey(RESPONSE_INAPP_ITEM_LIST) || !purchases.containsKey(RESPONSE_INAPP_PURCHASE_DATA_LIST) || !purchases.containsKey(RESPONSE_INAPP_SIGNATURE_LIST)) {
                logError("Bundle returned from getPurchases() doesn't contain required fields.");
                return IABHELPER_BAD_RESPONSE;
            }
            ArrayList<String> stringArrayList = purchases.getStringArrayList(RESPONSE_INAPP_ITEM_LIST);
            ArrayList<String> stringArrayList2 = purchases.getStringArrayList(RESPONSE_INAPP_PURCHASE_DATA_LIST);
            ArrayList<String> stringArrayList3 = purchases.getStringArrayList(RESPONSE_INAPP_SIGNATURE_LIST);
            for (int i = 0; i < stringArrayList2.size(); i++) {
                String str2 = stringArrayList2.get(i);
                String str3 = stringArrayList3.get(i);
                logDebug("Sku is owned: " + stringArrayList.get(i));
                Purchase purchase = new Purchase(str, str2, str3);
                if (TextUtils.isEmpty(purchase.getToken())) {
                    logWarn("BUG: empty/null token!");
                    logDebug("Purchase data: " + str2);
                }
                inventory.addPurchase(purchase);
            }
            string = purchases.getString(INAPP_CONTINUATION_TOKEN);
            logDebug("Continuation token: " + string);
        } while (!TextUtils.isEmpty(string));
        return 0;
    }

    /* JADX WARN: Multi-variable type inference failed */
    int querySkuDetails(String str, Inventory inventory, List<String> list, IInAppBillingService iInAppBillingService) throws JSONException, RemoteException {
        logDebug("Querying SKU details.");
        ArrayList arrayList = new ArrayList();
        arrayList.addAll(inventory.getAllOwnedSkus(str));
        if (list != null) {
            arrayList.addAll(list);
        }
        if (arrayList.size() == 0) {
            logDebug("queryPrices: nothing to do because there are no SKUs.");
            return 0;
        }
        while (arrayList.size() > 0) {
            int iMin = Math.min(20, arrayList.size());
            ArrayList arrayList2 = new ArrayList();
            for (int i = 0; i < iMin; i++) {
                arrayList2.add(arrayList.get(i));
            }
            Bundle bundle = new Bundle();
            bundle.putStringArrayList(GET_SKU_DETAILS_ITEM_LIST, arrayList2);
            Bundle skuDetails = iInAppBillingService.getSkuDetails(3, this.mContext.getPackageName(), str, bundle);
            arrayList.removeAll(arrayList2);
            if (!skuDetails.containsKey(RESPONSE_GET_SKU_DETAILS_LIST)) {
                int responseCodeFromBundle = getResponseCodeFromBundle(skuDetails);
                if (responseCodeFromBundle != 0) {
                    logDebug("getSkuDetails() failed: " + getResponseDesc(responseCodeFromBundle));
                    return responseCodeFromBundle;
                }
                logError("getSkuDetails() returned a bundle with neither an error nor a detail list.");
                return IABHELPER_BAD_RESPONSE;
            }
            Iterator<String> it = skuDetails.getStringArrayList(RESPONSE_GET_SKU_DETAILS_LIST).iterator();
            while (it.hasNext()) {
                inventory.addSkuDetails(new SkuDetails(str, it.next()));
            }
        }
        return 0;
    }

    void consumeAsyncInternal(final List<Purchase> list, final OnConsumeFinishedListener onConsumeFinishedListener, final OnConsumeMultiFinishedListener onConsumeMultiFinishedListener) {
        this.serviceManager.workWith(new BillingServiceProcessor() { // from class: com.unity.purchasing.googleplay.IabHelper.4
            @Override // com.unity.purchasing.googleplay.BillingServiceProcessor
            public void workWith(IInAppBillingService iInAppBillingService) {
                ArrayList arrayList = new ArrayList();
                for (Purchase purchase : list) {
                    try {
                        IabHelper.this.consume(purchase, iInAppBillingService);
                        arrayList.add(new IabResult(0, "Successful consume of sku " + purchase.getSku()));
                    } catch (IabException e) {
                        arrayList.add(e.getResult());
                    }
                }
                if (!IabHelper.this.mDisposed && onConsumeFinishedListener != null) {
                    try {
                        onConsumeFinishedListener.onConsumeFinished((Purchase) list.get(0), (IabResult) arrayList.get(0));
                    } catch (JSONException e2) {
                        e2.printStackTrace();
                    }
                }
                if (IabHelper.this.mDisposed || onConsumeMultiFinishedListener == null) {
                    return;
                }
                onConsumeMultiFinishedListener.onConsumeMultiFinished(list, arrayList);
            }
        });
    }

    public static String byteArrayToHexString(byte[] bArr) {
        StringBuilder sb = new StringBuilder(bArr.length * 2);
        for (byte b : bArr) {
            sb.append(String.format("%02x", Integer.valueOf(b & 255)));
        }
        return sb.toString();
    }

    void logDebug(String str) {
        Log.i("UnityIAP", str);
    }

    void logError(String str) {
        Log.e(this.mDebugTag, "In-app billing error: " + str);
    }

    void logWarn(String str) {
        Log.w(this.mDebugTag, "In-app billing warning: " + str);
    }
}

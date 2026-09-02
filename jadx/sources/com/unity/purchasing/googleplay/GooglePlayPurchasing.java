package com.unity.purchasing.googleplay;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Handler;
import android.os.RemoteException;
import android.util.Log;
import com.android.vending.billing.IInAppBillingService;
import com.google.vr.ndk.base.DaydreamApi;
import com.unity.purchasing.common.IStoreCallback;
import com.unity.purchasing.common.IUnityCallback;
import com.unity.purchasing.common.InitializationFailureReason;
import com.unity.purchasing.common.ProductDefinition;
import com.unity.purchasing.common.ProductDescription;
import com.unity.purchasing.common.ProductMetadata;
import com.unity.purchasing.common.ProductType;
import com.unity.purchasing.common.PurchaseFailureDescription;
import com.unity.purchasing.common.PurchaseFailureReason;
import com.unity.purchasing.common.StoreDeserializer;
import com.unity.purchasing.common.UnityPurchasing;
import com.unity3d.player.UnityPlayer;
import com.unity3d.player.UnityPlayerActivity;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class GooglePlayPurchasing extends StoreDeserializer {
    public static final int ACTIVITY_REQUEST_CODE = 999;
    protected static final String TAG = "UnityIAP";
    private static GooglePlayPurchasing instance;
    private static final boolean isDaydreamApiAvailable;
    public boolean activityPending;
    private Context context;
    public IabHelper helper;
    private Inventory inventory;
    private boolean isUnityVrEnabled;
    private IActivityLauncher launcher;
    private IBillingServiceManager manager;
    private String skuUnderPurchase;
    private IStoreCallback unityPurchasing;
    Features features = new Features();
    public IabHelper.OnIabPurchaseFinishedListener PurchaseListener = new IabHelper.OnIabPurchaseFinishedListener() { // from class: com.unity.purchasing.googleplay.GooglePlayPurchasing.1
        /* JADX WARN: Code duplicated, block: B:19:0x0061  */
        @Override // com.unity.purchasing.googleplay.IabHelper.OnIabPurchaseFinishedListener
        public void onIabPurchaseFinished(IabResult iabResult, Purchase purchase) {
            if (GooglePlayPurchasing.this.purchaseInProgress) {
                GooglePlayPurchasing.log("onIabPurchaseFinished: %s", Boolean.toString(iabResult.isSuccess()));
                GooglePlayPurchasing.log(iabResult.mMessage);
                GooglePlayPurchasing.this.purchaseInProgress = false;
                if (iabResult.isSuccess()) {
                    GooglePlayPurchasing.log("Product purchased successfully!");
                    GooglePlayPurchasing.this.NotifyUnityOfPurchase(purchase);
                    return;
                }
                GooglePlayPurchasing.log("Purchase response code:%s", Integer.toString(iabResult.getResponse()));
                PurchaseFailureReason purchaseFailureReason = PurchaseFailureReason.Unknown;
                int response = iabResult.getResponse();
                if (response == -1005) {
                    purchaseFailureReason = PurchaseFailureReason.UserCancelled;
                } else if (response != 7) {
                    switch (response) {
                        case 1:
                            purchaseFailureReason = PurchaseFailureReason.UserCancelled;
                            break;
                        case 2:
                        case 3:
                            purchaseFailureReason = PurchaseFailureReason.BillingUnavailable;
                            break;
                        case 4:
                            purchaseFailureReason = PurchaseFailureReason.ItemUnavailable;
                            break;
                    }
                } else if (GooglePlayPurchasing.this.features.supportsPurchaseFailureReasonDuplicateTransaction) {
                    purchaseFailureReason = PurchaseFailureReason.DuplicateTransaction;
                }
                PurchaseFailureDescription purchaseFailureDescription = new PurchaseFailureDescription(GooglePlayPurchasing.this.skuUnderPurchase, purchaseFailureReason, String.valueOf(iabResult.getResponse()));
                if (iabResult.getResponse() == -1002) {
                    GooglePlayPurchasing.log("Received bad response, polling for successful purchases to investigate failure more deeply");
                    GooglePlayPurchasing.this.reconcileFailedPurchaseWithInventory(purchaseFailureDescription);
                } else {
                    GooglePlayPurchasing.this.unityPurchasing.OnPurchaseFailed(purchaseFailureDescription);
                }
            }
        }
    };
    private BroadcastReceiver purchasesUpdatedReceiver = null;
    private int offlineBackOffTime = 5000;
    private volatile boolean purchaseInProgress = false;

    static {
        boolean z;
        try {
            Class.forName("com.google.vr.ndk.base.DaydreamApi");
            z = true;
        } catch (Throwable unused) {
            z = false;
        }
        isDaydreamApiAvailable = z;
    }

    class Features {
        public boolean supportsPurchaseFailureReasonDuplicateTransaction;

        Features() {
        }
    }

    public static GooglePlayPurchasing instance(IUnityCallback iUnityCallback) {
        if (instance == null) {
            BillingServiceManager billingServiceManager = new BillingServiceManager(UnityPlayer.currentActivity);
            instance = new GooglePlayPurchasing(new UnityPurchasing(iUnityCallback), new IabHelper(UnityPlayer.currentActivity, billingServiceManager, new ActivityLauncher()), billingServiceManager, UnityPlayer.currentActivity, new ActivityLauncher());
        }
        return instance;
    }

    public static boolean ContinuePurchase(Activity activity, String str, String str2) {
        if (instance == null) {
            return false;
        }
        instance.StartPurchase(activity, str, str2);
        return true;
    }

    public static void ProcessActivityResult(int i, int i2, Intent intent) {
        if (instance != null) {
            instance.onActivityResult(i, i2, intent);
        }
    }

    public GooglePlayPurchasing(IStoreCallback iStoreCallback, IabHelper iabHelper, IBillingServiceManager iBillingServiceManager, Context context, IActivityLauncher iActivityLauncher) {
        this.unityPurchasing = iStoreCallback;
        this.helper = iabHelper;
        this.helper.enableDaydreamApi(isDaydreamApiAvailable);
        this.manager = iBillingServiceManager;
        this.context = context;
        this.launcher = iActivityLauncher;
        instance = this;
        registerPurchasesUpdatedReceiver();
    }

    public void SetUnityVrEnabled(boolean z) {
        this.isUnityVrEnabled = z;
        log("isUnityVrEnabled = %s", String.valueOf(this.isUnityVrEnabled));
    }

    public void StartPurchase(Activity activity, String str, String str2) {
        this.helper.enableUnityVr(this.isUnityVrEnabled);
        if (this.inventory.getSkuDetails(str).mItemType == "inapp") {
            this.helper.launchPurchaseFlow(activity, str, ACTIVITY_REQUEST_CODE, this.PurchaseListener, str2);
        } else {
            this.helper.launchSubscriptionPurchaseFlow(activity, str, ACTIVITY_REQUEST_CODE, this.PurchaseListener, str2);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void pollForNewPurchases() {
        reconcileFailedPurchaseWithInventory(null);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void reconcileFailedPurchaseWithInventory(final PurchaseFailureDescription purchaseFailureDescription) {
        this.manager.workWith(new BillingServiceProcessor() { // from class: com.unity.purchasing.googleplay.GooglePlayPurchasing.2
            @Override // com.unity.purchasing.googleplay.BillingServiceProcessor
            public void workWith(IInAppBillingService iInAppBillingService) {
                boolean z = false;
                try {
                    boolean zHasPurchase = purchaseFailureDescription != null ? GooglePlayPurchasing.this.inventory.hasPurchase(purchaseFailureDescription.productId) : false;
                    if (GooglePlayPurchasing.this.helper.queryPurchases(GooglePlayPurchasing.this.inventory, "inapp", iInAppBillingService) != 0) {
                        GooglePlayPurchasing.log("Received bad response from queryPurchases");
                    }
                    boolean zHasPurchase2 = purchaseFailureDescription != null ? GooglePlayPurchasing.this.inventory.hasPurchase(purchaseFailureDescription.productId) : false;
                    if (purchaseFailureDescription != null) {
                        if ((!zHasPurchase && !zHasPurchase2) || (zHasPurchase && zHasPurchase2)) {
                            GooglePlayPurchasing.this.unityPurchasing.OnPurchaseFailed(purchaseFailureDescription);
                        } else if (!zHasPurchase && zHasPurchase2) {
                            Purchase purchase = GooglePlayPurchasing.this.inventory.getPurchase(purchaseFailureDescription.productId);
                            GooglePlayPurchasing.this.unityPurchasing.OnPurchaseSucceeded(purchase.getSku(), GooglePlayPurchasing.this.encodeReceipt(purchase), purchase.getOrderIdOrPurchaseToken());
                        }
                        z = true;
                    }
                    if (z) {
                        return;
                    }
                    GooglePlayPurchasing.this.NotifyUnityOfProducts(GooglePlayPurchasing.this.inventory);
                } catch (RemoteException | JSONException e) {
                    Log.e(GooglePlayPurchasing.TAG, "exception", e);
                    if (purchaseFailureDescription == null || z) {
                        return;
                    }
                    GooglePlayPurchasing.this.unityPurchasing.OnPurchaseFailed(purchaseFailureDescription);
                }
            }
        });
    }

    private void registerPurchasesUpdatedReceiver() {
        if (this.purchasesUpdatedReceiver == null) {
            this.purchasesUpdatedReceiver = new BroadcastReceiver() { // from class: com.unity.purchasing.googleplay.GooglePlayPurchasing.3
                @Override // android.content.BroadcastReceiver
                public void onReceive(Context context, Intent intent) {
                    GooglePlayPurchasing.this.pollForNewPurchases();
                }
            };
            this.context.registerReceiver(this.purchasesUpdatedReceiver, new IntentFilter("com.android.vending.billing.PURCHASES_UPDATED"));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void QueryInventory(final List<String> list, long j) {
        log("QueryInventory: %s", Integer.toString(list.size()));
        this.helper.queryInventoryAsync(true, list, new IabHelper.QueryInventoryFinishedListener() { // from class: com.unity.purchasing.googleplay.GooglePlayPurchasing.4
            @Override // com.unity.purchasing.googleplay.IabHelper.QueryInventoryFinishedListener
            public void onQueryInventoryFinished(IabResult iabResult, Inventory inventory) throws Exception {
                GooglePlayPurchasing.log("onQueryInventoryFinished: %s", Boolean.toString(iabResult.isSuccess()));
                GooglePlayPurchasing.log(iabResult.mMessage);
                if (!iabResult.isFailure()) {
                    GooglePlayPurchasing.this.inventory = inventory;
                    GooglePlayPurchasing.this.NotifyUnityOfProducts(inventory);
                    return;
                }
                GooglePlayPurchasing.log("Failed to Query inventory. UnityIAP will automatically retry in " + GooglePlayPurchasing.this.offlineBackOffTime + "ms");
                GooglePlayPurchasing.this.QueryInventory(list, (long) GooglePlayPurchasing.this.offlineBackOffTime);
                GooglePlayPurchasing.this.offlineBackOffTime = Math.min(300000, GooglePlayPurchasing.this.offlineBackOffTime * 2);
            }
        }, j);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void NotifyUnityOfProducts(Inventory inventory) {
        String orderIdOrPurchaseToken;
        ArrayList arrayList = new ArrayList();
        for (Map.Entry<String, SkuDetails> entry : inventory.mSkuMap.entrySet()) {
            SkuDetails value = entry.getValue();
            ProductMetadata productMetadata = new ProductMetadata(value.getPrice(), value.getTitle(), value.getDescription(), value.getISOCurrencyCode(), new BigDecimal(value.getPriceInMicros()).divide(new BigDecimal(1000000)));
            String strEncodeReceipt = null;
            if (inventory.hasPurchase(entry.getKey())) {
                Purchase purchase = inventory.getPurchase(entry.getKey());
                strEncodeReceipt = encodeReceipt(purchase);
                orderIdOrPurchaseToken = purchase.getOrderIdOrPurchaseToken();
            } else {
                orderIdOrPurchaseToken = null;
            }
            arrayList.add(new ProductDescription(entry.getKey(), productMetadata, strEncodeReceipt, orderIdOrPurchaseToken));
        }
        this.unityPurchasing.OnProductsRetrieved(arrayList);
    }

    protected void onActivityResult(int i, int i2, Intent intent) {
        if (this.helper != null) {
            log("onActivityResult");
            this.helper.handleActivityResult(i, i2, intent);
            this.purchaseInProgress = false;
        }
    }

    private Purchase findPurchaseByOrderId(String str) {
        for (Purchase purchase : this.inventory.getAllPurchases()) {
            if (purchase.getOrderIdOrPurchaseToken().equals(str)) {
                return purchase;
            }
        }
        log("No consumable with order %s", str);
        return null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void NotifyUnityOfPurchase(Purchase purchase) {
        log("NotifyUnityOfPurchase");
        this.inventory.addPurchase(purchase);
        this.unityPurchasing.OnPurchaseSucceeded(purchase.getSku(), encodeReceipt(purchase), purchase.getOrderIdOrPurchaseToken());
    }

    /* JADX INFO: Access modifiers changed from: private */
    public String encodeReceipt(Purchase purchase) {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put("json", purchase.getOriginalJson());
            jSONObject.put("signature", purchase.getSignature());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return jSONObject.toString();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void log(String str) {
        Log.i(TAG, str);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void log(String str, String str2) {
        log(String.format(str, str2));
    }

    @Override // com.unity.purchasing.common.IStore
    public void RetrieveProducts(List<ProductDefinition> list) {
        final ArrayList arrayList = new ArrayList();
        Iterator<ProductDefinition> it = list.iterator();
        while (it.hasNext()) {
            arrayList.add(it.next().storeSpecificId);
        }
        IabHelper.OnIabSetupFinishedListener onIabSetupFinishedListener = new IabHelper.OnIabSetupFinishedListener() { // from class: com.unity.purchasing.googleplay.GooglePlayPurchasing.5
            @Override // com.unity.purchasing.googleplay.IabHelper.OnIabSetupFinishedListener
            public void onIabSetupFinished(IabResult iabResult) {
                GooglePlayPurchasing.log("onIabSetupFinished: %s", Integer.toString(iabResult.mResponse));
                if (iabResult.isFailure()) {
                    GooglePlayPurchasing.log("Failed to setup IAB. Notifying Unity...");
                    GooglePlayPurchasing.this.unityPurchasing.OnSetupFailed(InitializationFailureReason.PurchasingUnavailable);
                } else {
                    GooglePlayPurchasing.log("Requesting %s products", Integer.toString(arrayList.size()));
                    GooglePlayPurchasing.this.QueryInventory(arrayList, 0L);
                }
            }
        };
        if (!this.helper.mSetupDone) {
            try {
                this.manager.initialise();
                this.helper.startSetup(onIabSetupFinishedListener);
                return;
            } catch (GooglePlayBillingUnAvailableException unused) {
                this.unityPurchasing.OnSetupFailed(InitializationFailureReason.PurchasingUnavailable);
                return;
            }
        }
        log("Requesting %s products", Integer.toString(arrayList.size()));
        QueryInventory(arrayList, 0L);
    }

    @Override // com.unity.purchasing.common.IStore
    public void Purchase(ProductDefinition productDefinition) {
        Purchase(productDefinition, (String) null);
    }

    @Override // com.unity.purchasing.common.IStore
    public void Purchase(ProductDefinition productDefinition, String str) {
        if (this.purchaseInProgress) {
            this.unityPurchasing.OnPurchaseFailed(new PurchaseFailureDescription(productDefinition.storeSpecificId, PurchaseFailureReason.ExistingPurchasePending));
            return;
        }
        String str2 = productDefinition.storeSpecificId;
        this.skuUnderPurchase = str2;
        log("onPurchaseProduct: %s", str2);
        SkuDetails skuDetails = this.inventory.getSkuDetails(str2);
        log("ITEM TYPE:%s", skuDetails.getType());
        boolean z = (this.context instanceof UnityPlayerActivity) && this.isUnityVrEnabled && isDaydreamApiAvailable;
        final Intent intentCreatePurchaseIntent = createPurchaseIntent(z);
        intentCreatePurchaseIntent.putExtra("productId", str2);
        intentCreatePurchaseIntent.putExtra("itemType", skuDetails.getType());
        intentCreatePurchaseIntent.putExtra("developerPayload", str);
        this.purchaseInProgress = true;
        this.activityPending = true;
        if (z) {
            new Handler(this.context.getMainLooper()).post(new Runnable() { // from class: com.unity.purchasing.googleplay.GooglePlayPurchasing.6
                @Override // java.lang.Runnable
                public void run() {
                    intentCreatePurchaseIntent.putExtra("vr", true);
                    DaydreamApi daydreamApiCreate = DaydreamApi.create(GooglePlayPurchasing.this.context);
                    daydreamApiCreate.launchInVr(intentCreatePurchaseIntent);
                    daydreamApiCreate.close();
                }
            });
        } else {
            this.launcher.startActivity(this.context, intentCreatePurchaseIntent);
        }
    }

    protected Intent createPurchaseIntent(boolean z) {
        return new Intent(this.context, (Class<?>) (z ? VRPurchaseActivity.class : PurchaseActivity.class));
    }

    @Override // com.unity.purchasing.common.IStore
    public void FinishTransaction(ProductDefinition productDefinition, String str) {
        Purchase purchaseFindPurchaseByOrderId;
        log("Finish transaction:%s", str);
        if (productDefinition == null) {
            log("Received FinishTransaction for unknown product with transaction %s. Not consuming.", str);
        } else {
            if (productDefinition.type != ProductType.Consumable || (purchaseFindPurchaseByOrderId = findPurchaseByOrderId(str)) == null) {
                return;
            }
            log("Consuming %s", purchaseFindPurchaseByOrderId.getSku());
            this.inventory.erasePurchase(purchaseFindPurchaseByOrderId.getSku());
            this.helper.consumeAsync(purchaseFindPurchaseByOrderId, new IabHelper.OnConsumeFinishedListener() { // from class: com.unity.purchasing.googleplay.GooglePlayPurchasing.7
                @Override // com.unity.purchasing.googleplay.IabHelper.OnConsumeFinishedListener
                public void onConsumeFinished(Purchase purchase, IabResult iabResult) throws JSONException {
                    GooglePlayPurchasing.log("onConsumeFinished:%s", Boolean.toString(iabResult.isSuccess()));
                    GooglePlayPurchasing.log(iabResult.mMessage);
                    GooglePlayPurchasing.log(String.valueOf(iabResult.getResponse()));
                }
            });
        }
    }

    public void SetFeatures(String str) {
        for (String str2 : str.split(",")) {
            if (str2.equals("supportsPurchaseFailureReasonDuplicateTransaction")) {
                this.features.supportsPurchaseFailureReasonDuplicateTransaction = true;
            }
        }
    }
}

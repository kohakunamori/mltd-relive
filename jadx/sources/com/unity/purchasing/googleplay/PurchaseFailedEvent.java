package com.unity.purchasing.googleplay;

import com.unity.purchasing.common.PurchaseFailureReason;
import com.unity.purchasing.common.SaneJSONObject;

/* JADX INFO: loaded from: classes.dex */
public class PurchaseFailedEvent {
    public static String jsonEncodePurchaseFailure(String str, PurchaseFailureReason purchaseFailureReason, String str2) {
        SaneJSONObject saneJSONObject = new SaneJSONObject();
        saneJSONObject.put("productId", str);
        saneJSONObject.put("reason", purchaseFailureReason);
        saneJSONObject.put("message", str2);
        return saneJSONObject.toString();
    }
}

package com.unity.purchasing.common;

/* JADX INFO: loaded from: classes.dex */
public class PurchaseFailureDescription {
    public String message;
    public String productId;
    public PurchaseFailureReason reason;

    public PurchaseFailureDescription(String str, PurchaseFailureReason purchaseFailureReason, String str2) {
        this.productId = str;
        this.reason = purchaseFailureReason;
        this.message = str2;
    }

    public PurchaseFailureDescription(String str, PurchaseFailureReason purchaseFailureReason) {
        this(str, purchaseFailureReason, "");
    }

    public boolean equals(Object obj) {
        if (obj == null || !(obj instanceof PurchaseFailureDescription)) {
            return false;
        }
        return equalsAllFields((PurchaseFailureDescription) obj);
    }

    public boolean equalsAllFields(PurchaseFailureDescription purchaseFailureDescription) {
        return this.productId.equals(purchaseFailureDescription.productId) && this.reason == purchaseFailureDescription.reason && this.message.equals(purchaseFailureDescription.message);
    }

    public String toString() {
        return "productId: \"" + this.productId + "\" reason: " + this.reason + " message: \"" + this.message + "\"";
    }
}

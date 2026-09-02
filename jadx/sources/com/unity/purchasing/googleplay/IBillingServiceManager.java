package com.unity.purchasing.googleplay;

/* JADX INFO: loaded from: classes.dex */
public interface IBillingServiceManager {
    void dispose();

    void initialise() throws GooglePlayBillingUnAvailableException;

    void workWith(BillingServiceProcessor billingServiceProcessor);
}

package com.unity.purchasing.googleplay;

import com.google.firebase.analytics.FirebaseAnalytics;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class SkuDetails {
    String isoCurrencyCode;
    String mDescription;
    String mItemType;
    String mJson;
    String mPrice;
    String mSku;
    String mTitle;
    String mType;
    long priceInMicros;

    public SkuDetails() {
    }

    public SkuDetails(String str) throws JSONException {
        this("inapp", str);
    }

    public SkuDetails(String str, String str2) throws JSONException {
        this.mItemType = str;
        this.mJson = str2;
        JSONObject jSONObject = new JSONObject(this.mJson);
        this.mSku = jSONObject.optString("productId");
        this.mType = jSONObject.optString("type");
        this.mPrice = jSONObject.optString(FirebaseAnalytics.Param.PRICE);
        this.mTitle = jSONObject.optString("title");
        this.mDescription = jSONObject.optString("description");
        this.priceInMicros = jSONObject.optLong("price_amount_micros");
        this.isoCurrencyCode = jSONObject.optString("price_currency_code");
    }

    public String getSku() {
        return this.mSku;
    }

    public String getType() {
        return this.mType;
    }

    public String getPrice() {
        return this.mPrice;
    }

    public String getTitle() {
        return this.mTitle;
    }

    public String getDescription() {
        return this.mDescription;
    }

    public long getPriceInMicros() {
        return this.priceInMicros;
    }

    public String getISOCurrencyCode() {
        return this.isoCurrencyCode;
    }

    public String toString() {
        return "SkuDetails:" + this.mJson;
    }
}

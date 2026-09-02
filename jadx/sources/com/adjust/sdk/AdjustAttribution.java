package com.adjust.sdk;

import com.google.firebase.analytics.FirebaseAnalytics;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.ObjectStreamField;
import java.io.Serializable;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class AdjustAttribution implements Serializable {
    private static final ObjectStreamField[] serialPersistentFields = {new ObjectStreamField("trackerToken", String.class), new ObjectStreamField("trackerName", String.class), new ObjectStreamField("network", String.class), new ObjectStreamField(FirebaseAnalytics.Param.CAMPAIGN, String.class), new ObjectStreamField("adgroup", String.class), new ObjectStreamField("creative", String.class), new ObjectStreamField("clickLabel", String.class), new ObjectStreamField("adid", String.class), new ObjectStreamField("costType", String.class), new ObjectStreamField("costAmount", Double.class), new ObjectStreamField("costCurrency", String.class)};
    private static final long serialVersionUID = 1;
    public String adgroup;
    public String adid;
    public String campaign;
    public String clickLabel;
    public Double costAmount;
    public String costCurrency;
    public String costType;
    public String creative;
    public String network;
    public String trackerName;
    public String trackerToken;

    public static AdjustAttribution fromJson(JSONObject jSONObject, String str, String str2) {
        if (jSONObject == null) {
            return null;
        }
        AdjustAttribution adjustAttribution = new AdjustAttribution();
        if ("unity".equals(str2)) {
            adjustAttribution.trackerToken = jSONObject.optString("tracker_token", "");
            adjustAttribution.trackerName = jSONObject.optString("tracker_name", "");
            adjustAttribution.network = jSONObject.optString("network", "");
            adjustAttribution.campaign = jSONObject.optString(FirebaseAnalytics.Param.CAMPAIGN, "");
            adjustAttribution.adgroup = jSONObject.optString("adgroup", "");
            adjustAttribution.creative = jSONObject.optString("creative", "");
            adjustAttribution.clickLabel = jSONObject.optString("click_label", "");
            if (str == null) {
                str = "";
            }
            adjustAttribution.adid = str;
            adjustAttribution.costType = jSONObject.optString("cost_type", "");
            adjustAttribution.costAmount = Double.valueOf(jSONObject.optDouble("cost_amount", 0.0d));
            adjustAttribution.costCurrency = jSONObject.optString("cost_currency", "");
        } else {
            adjustAttribution.trackerToken = jSONObject.optString("tracker_token");
            adjustAttribution.trackerName = jSONObject.optString("tracker_name");
            adjustAttribution.network = jSONObject.optString("network");
            adjustAttribution.campaign = jSONObject.optString(FirebaseAnalytics.Param.CAMPAIGN);
            adjustAttribution.adgroup = jSONObject.optString("adgroup");
            adjustAttribution.creative = jSONObject.optString("creative");
            adjustAttribution.clickLabel = jSONObject.optString("click_label");
            adjustAttribution.adid = str;
            adjustAttribution.costType = jSONObject.optString("cost_type");
            adjustAttribution.costAmount = Double.valueOf(jSONObject.optDouble("cost_amount"));
            adjustAttribution.costCurrency = jSONObject.optString("cost_currency");
        }
        return adjustAttribution;
    }

    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        AdjustAttribution adjustAttribution = (AdjustAttribution) obj;
        return Util.equalString(this.trackerToken, adjustAttribution.trackerToken) && Util.equalString(this.trackerName, adjustAttribution.trackerName) && Util.equalString(this.network, adjustAttribution.network) && Util.equalString(this.campaign, adjustAttribution.campaign) && Util.equalString(this.adgroup, adjustAttribution.adgroup) && Util.equalString(this.creative, adjustAttribution.creative) && Util.equalString(this.clickLabel, adjustAttribution.clickLabel) && Util.equalString(this.adid, adjustAttribution.adid) && Util.equalString(this.costType, adjustAttribution.costType) && Util.equalsDouble(this.costAmount, adjustAttribution.costAmount) && Util.equalString(this.costCurrency, adjustAttribution.costCurrency);
    }

    public int hashCode() {
        return ((((((((((((((((((((629 + Util.hashString(this.trackerToken)) * 37) + Util.hashString(this.trackerName)) * 37) + Util.hashString(this.network)) * 37) + Util.hashString(this.campaign)) * 37) + Util.hashString(this.adgroup)) * 37) + Util.hashString(this.creative)) * 37) + Util.hashString(this.clickLabel)) * 37) + Util.hashString(this.adid)) * 37) + Util.hashString(this.costType)) * 37) + Util.hashDouble(this.costAmount)) * 37) + Util.hashString(this.costCurrency);
    }

    public String toString() {
        return Util.formatString("tt:%s tn:%s net:%s cam:%s adg:%s cre:%s cl:%s adid:%s ct:%s ca:%.2f cc:%s", this.trackerToken, this.trackerName, this.network, this.campaign, this.adgroup, this.creative, this.clickLabel, this.adid, this.costType, this.costAmount, this.costCurrency);
    }

    private void writeObject(ObjectOutputStream objectOutputStream) throws IOException {
        objectOutputStream.defaultWriteObject();
    }

    private void readObject(ObjectInputStream objectInputStream) throws ClassNotFoundException, IOException {
        objectInputStream.defaultReadObject();
    }
}

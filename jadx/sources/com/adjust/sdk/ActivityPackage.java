package com.adjust.sdk;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.ObjectStreamField;
import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/* JADX INFO: loaded from: classes.dex */
public class ActivityPackage implements Serializable {
    private static final ObjectStreamField[] serialPersistentFields = {new ObjectStreamField("path", String.class), new ObjectStreamField("clientSdk", String.class), new ObjectStreamField("parameters", Map.class), new ObjectStreamField("activityKind", ActivityKind.class), new ObjectStreamField("suffix", String.class), new ObjectStreamField("callbackParameters", Map.class), new ObjectStreamField("partnerParameters", Map.class)};
    private static final long serialVersionUID = -35935556512024097L;
    private ActivityKind activityKind;
    private Map<String, String> callbackParameters;
    private long clickTimeInMilliseconds;
    private long clickTimeInSeconds;
    private long clickTimeServerInSeconds;
    private String clientSdk;
    private Boolean googlePlayInstant;
    private transient int hashCode;
    private long installBeginTimeInSeconds;
    private long installBeginTimeServerInSeconds;
    private String installVersion;
    private Map<String, String> parameters;
    private Map<String, String> partnerParameters;
    private String path;
    private int retries;
    private String suffix;

    public String getPath() {
        return this.path;
    }

    public void setPath(String str) {
        this.path = str;
    }

    public String getClientSdk() {
        return this.clientSdk;
    }

    public void setClientSdk(String str) {
        this.clientSdk = str;
    }

    public Map<String, String> getParameters() {
        return this.parameters;
    }

    public void setParameters(Map<String, String> map) {
        this.parameters = map;
    }

    public void setCallbackParameters(Map<String, String> map) {
        this.callbackParameters = map;
    }

    public void setPartnerParameters(Map<String, String> map) {
        this.partnerParameters = map;
    }

    public ActivityKind getActivityKind() {
        return this.activityKind;
    }

    public String getSuffix() {
        return this.suffix;
    }

    public void setSuffix(String str) {
        this.suffix = str;
    }

    public int getRetries() {
        return this.retries;
    }

    public int increaseRetries() {
        this.retries++;
        return this.retries;
    }

    public long getClickTimeInMilliseconds() {
        return this.clickTimeInMilliseconds;
    }

    public void setClickTimeInMilliseconds(long j) {
        this.clickTimeInMilliseconds = j;
    }

    public long getClickTimeInSeconds() {
        return this.clickTimeInSeconds;
    }

    public void setClickTimeInSeconds(long j) {
        this.clickTimeInSeconds = j;
    }

    public long getInstallBeginTimeInSeconds() {
        return this.installBeginTimeInSeconds;
    }

    public void setInstallBeginTimeInSeconds(long j) {
        this.installBeginTimeInSeconds = j;
    }

    public long getClickTimeServerInSeconds() {
        return this.clickTimeServerInSeconds;
    }

    public void setClickTimeServerInSeconds(long j) {
        this.clickTimeServerInSeconds = j;
    }

    public long getInstallBeginTimeServerInSeconds() {
        return this.installBeginTimeServerInSeconds;
    }

    public void setInstallBeginTimeServerInSeconds(long j) {
        this.installBeginTimeServerInSeconds = j;
    }

    public String getInstallVersion() {
        return this.installVersion;
    }

    public void setInstallVersion(String str) {
        this.installVersion = str;
    }

    public Boolean getGooglePlayInstant() {
        return this.googlePlayInstant;
    }

    public void setGooglePlayInstant(Boolean bool) {
        this.googlePlayInstant = bool;
    }

    public Map<String, String> getCallbackParameters() {
        return this.callbackParameters;
    }

    public Map<String, String> getPartnerParameters() {
        return this.partnerParameters;
    }

    public ActivityPackage(ActivityKind activityKind) {
        this.activityKind = ActivityKind.UNKNOWN;
        this.activityKind = activityKind;
    }

    public String toString() {
        return Util.formatString("%s%s", this.activityKind.toString(), this.suffix);
    }

    public String getExtendedString() {
        StringBuilder sb = new StringBuilder();
        sb.append(Util.formatString("Path:      %s\n", this.path));
        sb.append(Util.formatString("ClientSdk: %s\n", this.clientSdk));
        if (this.parameters != null) {
            sb.append("Parameters:");
            TreeMap treeMap = new TreeMap(this.parameters);
            List listAsList = Arrays.asList("app_secret", "secret_id", "event_callback_id");
            for (Map.Entry entry : treeMap.entrySet()) {
                String str = (String) entry.getKey();
                if (!listAsList.contains(str)) {
                    sb.append(Util.formatString("\n\t%-16s %s", str, entry.getValue()));
                }
            }
        }
        return sb.toString();
    }

    public String getFailureMessage() {
        return Util.formatString("Failed to track %s%s", this.activityKind.toString(), this.suffix);
    }

    private void writeObject(ObjectOutputStream objectOutputStream) throws IOException {
        objectOutputStream.defaultWriteObject();
    }

    private void readObject(ObjectInputStream objectInputStream) throws ClassNotFoundException, IOException {
        ObjectInputStream.GetField fields = objectInputStream.readFields();
        this.path = Util.readStringField(fields, "path", null);
        this.clientSdk = Util.readStringField(fields, "clientSdk", null);
        this.parameters = (Map) Util.readObjectField(fields, "parameters", null);
        this.activityKind = (ActivityKind) Util.readObjectField(fields, "activityKind", ActivityKind.UNKNOWN);
        this.suffix = Util.readStringField(fields, "suffix", null);
        this.callbackParameters = (Map) Util.readObjectField(fields, "callbackParameters", null);
        this.partnerParameters = (Map) Util.readObjectField(fields, "partnerParameters", null);
    }

    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        ActivityPackage activityPackage = (ActivityPackage) obj;
        return Util.equalString(this.path, activityPackage.path) && Util.equalString(this.clientSdk, activityPackage.clientSdk) && Util.equalObject(this.parameters, activityPackage.parameters) && Util.equalEnum(this.activityKind, activityPackage.activityKind) && Util.equalString(this.suffix, activityPackage.suffix) && Util.equalObject(this.callbackParameters, activityPackage.callbackParameters) && Util.equalObject(this.partnerParameters, activityPackage.partnerParameters);
    }

    public int hashCode() {
        if (this.hashCode == 0) {
            this.hashCode = 17;
            this.hashCode = (this.hashCode * 37) + Util.hashString(this.path);
            this.hashCode = (this.hashCode * 37) + Util.hashString(this.clientSdk);
            this.hashCode = (this.hashCode * 37) + Util.hashObject(this.parameters);
            this.hashCode = (this.hashCode * 37) + Util.hashEnum(this.activityKind);
            this.hashCode = (this.hashCode * 37) + Util.hashString(this.suffix);
            this.hashCode = (this.hashCode * 37) + Util.hashObject(this.callbackParameters);
            this.hashCode = (this.hashCode * 37) + Util.hashObject(this.partnerParameters);
        }
        return this.hashCode;
    }
}

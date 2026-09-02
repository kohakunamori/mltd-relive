package com.adjust.sdk;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.ObjectStreamField;
import java.io.Serializable;
import java.util.Calendar;
import java.util.LinkedList;

/* JADX INFO: loaded from: classes.dex */
public class ActivityState implements Serializable, Cloneable {
    private static final int ORDER_ID_MAXCOUNT = 10;
    private static final ObjectStreamField[] serialPersistentFields = {new ObjectStreamField("uuid", String.class), new ObjectStreamField("enabled", Boolean.TYPE), new ObjectStreamField("isGdprForgotten", Boolean.TYPE), new ObjectStreamField("isThirdPartySharingDisabled", Boolean.TYPE), new ObjectStreamField("askingAttribution", Boolean.TYPE), new ObjectStreamField("eventCount", Integer.TYPE), new ObjectStreamField("sessionCount", Integer.TYPE), new ObjectStreamField("subsessionCount", Integer.TYPE), new ObjectStreamField("sessionLength", Long.TYPE), new ObjectStreamField("timeSpent", Long.TYPE), new ObjectStreamField("lastActivity", Long.TYPE), new ObjectStreamField("lastInterval", Long.TYPE), new ObjectStreamField("updatePackages", Boolean.TYPE), new ObjectStreamField("orderIds", LinkedList.class), new ObjectStreamField("pushToken", String.class), new ObjectStreamField("adid", String.class), new ObjectStreamField("clickTime", Long.TYPE), new ObjectStreamField("installBegin", Long.TYPE), new ObjectStreamField("installReferrer", String.class), new ObjectStreamField("googlePlayInstant", Boolean.class), new ObjectStreamField("clickTimeServer", Long.TYPE), new ObjectStreamField("installBeginServer", Long.TYPE), new ObjectStreamField("installVersion", String.class), new ObjectStreamField("clickTimeHuawei", Long.TYPE), new ObjectStreamField("installBeginHuawei", Long.TYPE), new ObjectStreamField("installReferrerHuawei", String.class)};
    private static final long serialVersionUID = 9039439291143138148L;
    private transient ILogger logger = AdjustFactory.getLogger();
    protected String uuid = Util.createUuid();
    protected boolean enabled = true;
    protected boolean isGdprForgotten = false;
    protected boolean isThirdPartySharingDisabled = false;
    protected boolean askingAttribution = false;
    protected int eventCount = 0;
    protected int sessionCount = 0;
    protected int subsessionCount = -1;
    protected long sessionLength = -1;
    protected long timeSpent = -1;
    protected long lastActivity = -1;
    protected long lastInterval = -1;
    protected boolean updatePackages = false;
    protected LinkedList<String> orderIds = null;
    protected String pushToken = null;
    protected String adid = null;
    protected long clickTime = 0;
    protected long installBegin = 0;
    protected String installReferrer = null;
    protected Boolean googlePlayInstant = null;
    protected long clickTimeServer = 0;
    protected long installBeginServer = 0;
    protected String installVersion = null;
    protected long clickTimeHuawei = 0;
    protected long installBeginHuawei = 0;
    protected String installReferrerHuawei = null;

    protected ActivityState() {
    }

    protected void resetSessionAttributes(long j) {
        this.subsessionCount = 1;
        this.sessionLength = 0L;
        this.timeSpent = 0L;
        this.lastActivity = j;
        this.lastInterval = -1L;
    }

    protected void addOrderId(String str) {
        if (this.orderIds == null) {
            this.orderIds = new LinkedList<>();
        }
        if (this.orderIds.size() >= 10) {
            this.orderIds.removeLast();
        }
        this.orderIds.addFirst(str);
    }

    protected boolean findOrderId(String str) {
        if (this.orderIds == null) {
            return false;
        }
        return this.orderIds.contains(str);
    }

    public String toString() {
        double d = this.sessionLength;
        Double.isNaN(d);
        double d2 = this.timeSpent;
        Double.isNaN(d2);
        return Util.formatString("ec:%d sc:%d ssc:%d sl:%.1f ts:%.1f la:%s uuid:%s", Integer.valueOf(this.eventCount), Integer.valueOf(this.sessionCount), Integer.valueOf(this.subsessionCount), Double.valueOf(d / 1000.0d), Double.valueOf(d2 / 1000.0d), stamp(this.lastActivity), this.uuid);
    }

    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        ActivityState activityState = (ActivityState) obj;
        return Util.equalString(this.uuid, activityState.uuid) && Util.equalBoolean(Boolean.valueOf(this.enabled), Boolean.valueOf(activityState.enabled)) && Util.equalBoolean(Boolean.valueOf(this.isGdprForgotten), Boolean.valueOf(activityState.isGdprForgotten)) && Util.equalBoolean(Boolean.valueOf(this.isThirdPartySharingDisabled), Boolean.valueOf(activityState.isThirdPartySharingDisabled)) && Util.equalBoolean(Boolean.valueOf(this.askingAttribution), Boolean.valueOf(activityState.askingAttribution)) && Util.equalInt(Integer.valueOf(this.eventCount), Integer.valueOf(activityState.eventCount)) && Util.equalInt(Integer.valueOf(this.sessionCount), Integer.valueOf(activityState.sessionCount)) && Util.equalInt(Integer.valueOf(this.subsessionCount), Integer.valueOf(activityState.subsessionCount)) && Util.equalLong(Long.valueOf(this.sessionLength), Long.valueOf(activityState.sessionLength)) && Util.equalLong(Long.valueOf(this.timeSpent), Long.valueOf(activityState.timeSpent)) && Util.equalLong(Long.valueOf(this.lastInterval), Long.valueOf(activityState.lastInterval)) && Util.equalBoolean(Boolean.valueOf(this.updatePackages), Boolean.valueOf(activityState.updatePackages)) && Util.equalObject(this.orderIds, activityState.orderIds) && Util.equalString(this.pushToken, activityState.pushToken) && Util.equalString(this.adid, activityState.adid) && Util.equalLong(Long.valueOf(this.clickTime), Long.valueOf(activityState.clickTime)) && Util.equalLong(Long.valueOf(this.installBegin), Long.valueOf(activityState.installBegin)) && Util.equalString(this.installReferrer, activityState.installReferrer) && Util.equalBoolean(this.googlePlayInstant, activityState.googlePlayInstant) && Util.equalLong(Long.valueOf(this.clickTimeServer), Long.valueOf(activityState.clickTimeServer)) && Util.equalLong(Long.valueOf(this.installBeginServer), Long.valueOf(activityState.installBeginServer)) && Util.equalString(this.installVersion, activityState.installVersion) && Util.equalLong(Long.valueOf(this.clickTimeHuawei), Long.valueOf(activityState.clickTimeHuawei)) && Util.equalLong(Long.valueOf(this.installBeginHuawei), Long.valueOf(activityState.installBeginHuawei)) && Util.equalString(this.installReferrerHuawei, activityState.installReferrerHuawei);
    }

    public int hashCode() {
        return ((((((((((((((((((((((((((((((((((((((((((((((((629 + Util.hashString(this.uuid)) * 37) + Util.hashBoolean(Boolean.valueOf(this.enabled))) * 37) + Util.hashBoolean(Boolean.valueOf(this.isGdprForgotten))) * 37) + Util.hashBoolean(Boolean.valueOf(this.isThirdPartySharingDisabled))) * 37) + Util.hashBoolean(Boolean.valueOf(this.askingAttribution))) * 37) + this.eventCount) * 37) + this.sessionCount) * 37) + this.subsessionCount) * 37) + Util.hashLong(Long.valueOf(this.sessionLength))) * 37) + Util.hashLong(Long.valueOf(this.timeSpent))) * 37) + Util.hashLong(Long.valueOf(this.lastInterval))) * 37) + Util.hashBoolean(Boolean.valueOf(this.updatePackages))) * 37) + Util.hashObject(this.orderIds)) * 37) + Util.hashString(this.pushToken)) * 37) + Util.hashString(this.adid)) * 37) + Util.hashLong(Long.valueOf(this.clickTime))) * 37) + Util.hashLong(Long.valueOf(this.installBegin))) * 37) + Util.hashString(this.installReferrer)) * 37) + Util.hashBoolean(this.googlePlayInstant)) * 37) + Util.hashLong(Long.valueOf(this.clickTimeServer))) * 37) + Util.hashLong(Long.valueOf(this.installBeginServer))) * 37) + Util.hashString(this.installVersion)) * 37) + Util.hashLong(Long.valueOf(this.clickTimeHuawei))) * 37) + Util.hashLong(Long.valueOf(this.installBeginHuawei))) * 37) + Util.hashString(this.installReferrerHuawei);
    }

    private void readObject(ObjectInputStream objectInputStream) throws ClassNotFoundException, IOException {
        ObjectInputStream.GetField fields = objectInputStream.readFields();
        this.eventCount = Util.readIntField(fields, "eventCount", 0);
        this.sessionCount = Util.readIntField(fields, "sessionCount", 0);
        this.subsessionCount = Util.readIntField(fields, "subsessionCount", -1);
        this.sessionLength = Util.readLongField(fields, "sessionLength", -1L);
        this.timeSpent = Util.readLongField(fields, "timeSpent", -1L);
        this.lastActivity = Util.readLongField(fields, "lastActivity", -1L);
        this.lastInterval = Util.readLongField(fields, "lastInterval", -1L);
        this.uuid = Util.readStringField(fields, "uuid", null);
        this.enabled = Util.readBooleanField(fields, "enabled", true);
        this.isGdprForgotten = Util.readBooleanField(fields, "isGdprForgotten", false);
        this.isThirdPartySharingDisabled = Util.readBooleanField(fields, "isThirdPartySharingDisabled", false);
        this.askingAttribution = Util.readBooleanField(fields, "askingAttribution", false);
        this.updatePackages = Util.readBooleanField(fields, "updatePackages", false);
        this.orderIds = (LinkedList) Util.readObjectField(fields, "orderIds", null);
        this.pushToken = Util.readStringField(fields, "pushToken", null);
        this.adid = Util.readStringField(fields, "adid", null);
        this.clickTime = Util.readLongField(fields, "clickTime", -1L);
        this.installBegin = Util.readLongField(fields, "installBegin", -1L);
        this.installReferrer = Util.readStringField(fields, "installReferrer", null);
        this.googlePlayInstant = (Boolean) Util.readObjectField(fields, "googlePlayInstant", null);
        this.clickTimeServer = Util.readLongField(fields, "clickTimeServer", -1L);
        this.installBeginServer = Util.readLongField(fields, "installBeginServer", -1L);
        this.installVersion = Util.readStringField(fields, "installVersion", null);
        this.clickTimeHuawei = Util.readLongField(fields, "clickTimeHuawei", -1L);
        this.installBeginHuawei = Util.readLongField(fields, "installBeginHuawei", -1L);
        this.installReferrerHuawei = Util.readStringField(fields, "installReferrerHuawei", null);
        if (this.uuid == null) {
            this.uuid = Util.createUuid();
        }
    }

    private void writeObject(ObjectOutputStream objectOutputStream) throws IOException {
        objectOutputStream.defaultWriteObject();
    }

    private static String stamp(long j) {
        Calendar.getInstance().setTimeInMillis(j);
        return Util.formatString("%02d:%02d:%02d", 11, 12, 13);
    }
}

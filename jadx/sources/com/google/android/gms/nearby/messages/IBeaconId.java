package com.google.android.gms.nearby.messages;

import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.nearby.messages.internal.zzl;
import java.util.UUID;

/* JADX INFO: loaded from: classes.dex */
public class IBeaconId {
    public static final int LENGTH = 20;
    private final zzl zzet;

    public IBeaconId(UUID uuid, short s, short s2) {
        this.zzet = new zzl(uuid, Short.valueOf(s), Short.valueOf(s2));
    }

    private IBeaconId(byte[] bArr) {
        Preconditions.checkArgument(bArr.length == 20, "iBeacon ID must be a UUID, a major, and a minor (20 total bytes).");
        this.zzet = new zzl(bArr);
    }

    public static IBeaconId from(Message message) {
        boolean zZzl = message.zzl(Message.MESSAGE_TYPE_I_BEACON_ID);
        String type = message.getType();
        StringBuilder sb = new StringBuilder(String.valueOf(type).length() + 55);
        sb.append("Message type '");
        sb.append(type);
        sb.append("' is not Message.MESSAGE_TYPE_I_BEACON_ID");
        Preconditions.checkArgument(zZzl, sb.toString());
        return new IBeaconId(message.getContent());
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof IBeaconId) {
            return Objects.equal(this.zzet, ((IBeaconId) obj).zzet);
        }
        return false;
    }

    public short getMajor() {
        return this.zzet.zzaf().shortValue();
    }

    public short getMinor() {
        return this.zzet.zzag().shortValue();
    }

    public UUID getProximityUuid() {
        return this.zzet.getProximityUuid();
    }

    public int hashCode() {
        return Objects.hashCode(this.zzet);
    }

    public String toString() {
        String strValueOf = String.valueOf(getProximityUuid());
        short major = getMajor();
        short minor = getMinor();
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 53);
        sb.append("IBeaconId{proximityUuid=");
        sb.append(strValueOf);
        sb.append(", major=");
        sb.append((int) major);
        sb.append(", minor=");
        sb.append((int) minor);
        sb.append('}');
        return sb.toString();
    }
}

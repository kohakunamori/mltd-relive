package com.google.android.gms.nearby.messages;

import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.internal.nearby.zzgp;
import com.google.android.gms.internal.nearby.zzgu;
import com.google.android.gms.nearby.messages.internal.zzad;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "MessageFilterCreator")
public class MessageFilter extends AbstractSafeParcelable {
    public static final Parcelable.Creator<MessageFilter> CREATOR = new zzc();
    public static final MessageFilter INCLUDE_ALL_MY_TYPES = new Builder().includeAllMyTypes().build();

    @SafeParcelable.VersionField(m24id = 1000)
    private final int zzex;

    @SafeParcelable.Field(getter = "getMessageTypes", m22id = 1)
    private final List<zzad> zzey;

    @SafeParcelable.Field(getter = "getDeviceFilters", m22id = 2)
    private final List<zzgu> zzez;

    @SafeParcelable.Field(getter = "getIncludeAllMyTypes", m22id = 3)
    private final boolean zzfa;

    @SafeParcelable.Field(getter = "getBleFilters", m22id = 4)
    private final List<zzgp> zzfb;

    @SafeParcelable.Field(getter = "getNumRawAudioBytes", m22id = 5)
    private final int zzfc;

    public static final class Builder {
        private boolean zzfa;
        private final Set<zzad> zzfd = new HashSet();
        private final List<zzgu> zzez = new ArrayList();
        private final Set<zzgp> zzfe = new HashSet();
        private int zzfc = 0;

        private final Builder zza(String str, String str2) {
            this.zzfd.add(new zzad(str, str2));
            return this;
        }

        public final MessageFilter build() {
            Preconditions.checkState(this.zzfa || !this.zzfd.isEmpty(), "At least one of the include methods must be called.");
            return new MessageFilter(new ArrayList(this.zzfd), this.zzez, this.zzfa, new ArrayList(this.zzfe), this.zzfc);
        }

        public final Builder includeAllMyTypes() {
            this.zzfa = true;
            return this;
        }

        public final Builder includeAudioBytes(int i) {
            Preconditions.checkArgument(this.zzfc == 0, "includeAudioBytes() can only be called once per MessageFilter instance.");
            boolean z = i > 0;
            StringBuilder sb = new StringBuilder(44);
            sb.append("Invalid value for numAudioBytes: ");
            sb.append(i);
            Preconditions.checkArgument(z, sb.toString());
            Preconditions.checkArgument(i <= 10, "numAudioBytes is capped by AudioBytes.MAX_SIZE = 10");
            zza(Message.MESSAGE_NAMESPACE_RESERVED, Message.MESSAGE_TYPE_AUDIO_BYTES);
            this.zzfc = i;
            return this;
        }

        public final Builder includeEddystoneUids(String str, @Nullable String str2) {
            zza(Message.MESSAGE_NAMESPACE_RESERVED, Message.MESSAGE_TYPE_EDDYSTONE_UID);
            this.zzez.add(zzgu.zzb(str, str2));
            return this;
        }

        public final Builder includeFilter(MessageFilter messageFilter) {
            this.zzfd.addAll(messageFilter.zzaa());
            this.zzez.addAll(messageFilter.zzac());
            this.zzfe.addAll(messageFilter.zzad());
            this.zzfa = messageFilter.zzab() | this.zzfa;
            return this;
        }

        public final Builder includeIBeaconIds(UUID uuid, @Nullable Short sh, @Nullable Short sh2) {
            zza(Message.MESSAGE_NAMESPACE_RESERVED, Message.MESSAGE_TYPE_I_BEACON_ID);
            this.zzez.add(zzgu.zza(uuid, sh, sh2));
            return this;
        }

        public final Builder includeNamespacedType(String str, String str2) {
            Preconditions.checkArgument((str == null || str.isEmpty() || str.contains("*")) ? false : true, "namespace(%s) cannot be null, empty or contain (*).", str);
            Preconditions.checkArgument((str2 == null || str2.contains("*")) ? false : true, "type(%s) cannot be null or contain (*).", str2);
            return zza(str, str2);
        }
    }

    @SafeParcelable.Constructor
    MessageFilter(@SafeParcelable.Param(m23id = 1000) int i, @SafeParcelable.Param(m23id = 1) List<zzad> list, @SafeParcelable.Param(m23id = 2) List<zzgu> list2, @SafeParcelable.Param(m23id = 3) boolean z, @SafeParcelable.Param(m23id = 4) List<zzgp> list3, @SafeParcelable.Param(m23id = 5) int i2) {
        this.zzex = i;
        this.zzey = Collections.unmodifiableList((List) Preconditions.checkNotNull(list));
        this.zzfa = z;
        this.zzez = Collections.unmodifiableList(list2 == null ? Collections.emptyList() : list2);
        this.zzfb = Collections.unmodifiableList(list3 == null ? Collections.emptyList() : list3);
        this.zzfc = i2;
    }

    private MessageFilter(List<zzad> list, List<zzgu> list2, boolean z, List<zzgp> list3, int i) {
        this(2, list, list2, z, list3, i);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof MessageFilter)) {
            return false;
        }
        MessageFilter messageFilter = (MessageFilter) obj;
        return this.zzfa == messageFilter.zzfa && Objects.equal(this.zzey, messageFilter.zzey) && Objects.equal(this.zzez, messageFilter.zzez) && Objects.equal(this.zzfb, messageFilter.zzfb);
    }

    public int hashCode() {
        return Objects.hashCode(this.zzey, this.zzez, Boolean.valueOf(this.zzfa), this.zzfb);
    }

    public String toString() {
        boolean z = this.zzfa;
        String strValueOf = String.valueOf(this.zzey);
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 53);
        sb.append("MessageFilter{includeAllMyTypes=");
        sb.append(z);
        sb.append(", messageTypes=");
        sb.append(strValueOf);
        sb.append("}");
        return sb.toString();
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeTypedList(parcel, 1, this.zzey, false);
        SafeParcelWriter.writeTypedList(parcel, 2, this.zzez, false);
        SafeParcelWriter.writeBoolean(parcel, 3, this.zzfa);
        SafeParcelWriter.writeTypedList(parcel, 4, this.zzfb, false);
        SafeParcelWriter.writeInt(parcel, 5, this.zzfc);
        SafeParcelWriter.writeInt(parcel, 1000, this.zzex);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final List<zzad> zzaa() {
        return this.zzey;
    }

    public final boolean zzab() {
        return this.zzfa;
    }

    final List<zzgu> zzac() {
        return this.zzez;
    }

    public final List<zzgp> zzad() {
        return this.zzfb;
    }
}

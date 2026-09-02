package com.google.android.gms.games.event;

import android.database.CharArrayBuffer;
import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.DataUtils;
import com.google.android.gms.games.Player;
import com.google.android.gms.games.PlayerEntity;
import com.google.android.gms.games.internal.zzd;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "EventEntityCreator")
@SafeParcelable.Reserved({1000})
public final class EventEntity extends zzd implements Event {
    public static final Parcelable.Creator<EventEntity> CREATOR = new zza();

    @SafeParcelable.Field(getter = "getDescription", m22id = 3)
    private final String description;

    @SafeParcelable.Field(getter = "getName", m22id = 2)
    private final String name;

    @SafeParcelable.Field(getter = "getValue", m22id = 7)
    private final long value;

    @SafeParcelable.Field(getter = "getIconImageUrl", m22id = 5)
    private final String zzac;

    @SafeParcelable.Field(getter = "getPlayer", m22id = 6)
    private final PlayerEntity zzfj;

    @SafeParcelable.Field(getter = "getEventId", m22id = 1)
    private final String zzgl;

    @SafeParcelable.Field(getter = "getFormattedValue", m22id = 8)
    private final String zzgm;

    @SafeParcelable.Field(getter = "isVisible", m22id = 9)
    private final boolean zzgn;

    @SafeParcelable.Field(getter = "getIconImageUri", m22id = 4)
    private final Uri zzr;

    public EventEntity(Event event) {
        this.zzgl = event.getEventId();
        this.name = event.getName();
        this.description = event.getDescription();
        this.zzr = event.getIconImageUri();
        this.zzac = event.getIconImageUrl();
        this.zzfj = (PlayerEntity) event.getPlayer().freeze();
        this.value = event.getValue();
        this.zzgm = event.getFormattedValue();
        this.zzgn = event.isVisible();
    }

    /* JADX WARN: Can't rename method to resolve collision */
    @Override // com.google.android.gms.common.data.Freezable
    public final Event freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @SafeParcelable.Constructor
    EventEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) String str2, @SafeParcelable.Param(m23id = 3) String str3, @SafeParcelable.Param(m23id = 4) Uri uri, @SafeParcelable.Param(m23id = 5) String str4, @SafeParcelable.Param(m23id = 6) Player player, @SafeParcelable.Param(m23id = 7) long j, @SafeParcelable.Param(m23id = 8) String str5, @SafeParcelable.Param(m23id = 9) boolean z) {
        this.zzgl = str;
        this.name = str2;
        this.description = str3;
        this.zzr = uri;
        this.zzac = str4;
        this.zzfj = new PlayerEntity(player);
        this.value = j;
        this.zzgm = str5;
        this.zzgn = z;
    }

    @Override // com.google.android.gms.games.event.Event
    public final String getEventId() {
        return this.zzgl;
    }

    @Override // com.google.android.gms.games.event.Event
    public final String getName() {
        return this.name;
    }

    @Override // com.google.android.gms.games.event.Event
    public final void getName(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.name, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.event.Event
    public final String getDescription() {
        return this.description;
    }

    @Override // com.google.android.gms.games.event.Event
    public final void getDescription(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.description, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.event.Event
    public final Uri getIconImageUri() {
        return this.zzr;
    }

    @Override // com.google.android.gms.games.event.Event
    public final String getIconImageUrl() {
        return this.zzac;
    }

    @Override // com.google.android.gms.games.event.Event
    public final Player getPlayer() {
        return this.zzfj;
    }

    @Override // com.google.android.gms.games.event.Event
    public final long getValue() {
        return this.value;
    }

    @Override // com.google.android.gms.games.event.Event
    public final String getFormattedValue() {
        return this.zzgm;
    }

    @Override // com.google.android.gms.games.event.Event
    public final void getFormattedValue(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.zzgm, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.event.Event
    public final boolean isVisible() {
        return this.zzgn;
    }

    public final int hashCode() {
        return zza(this);
    }

    static int zza(Event event) {
        return Objects.hashCode(event.getEventId(), event.getName(), event.getDescription(), event.getIconImageUri(), event.getIconImageUrl(), event.getPlayer(), Long.valueOf(event.getValue()), event.getFormattedValue(), Boolean.valueOf(event.isVisible()));
    }

    public final boolean equals(Object obj) {
        return zza(this, obj);
    }

    static boolean zza(Event event, Object obj) {
        if (!(obj instanceof Event)) {
            return false;
        }
        if (event == obj) {
            return true;
        }
        Event event2 = (Event) obj;
        return Objects.equal(event2.getEventId(), event.getEventId()) && Objects.equal(event2.getName(), event.getName()) && Objects.equal(event2.getDescription(), event.getDescription()) && Objects.equal(event2.getIconImageUri(), event.getIconImageUri()) && Objects.equal(event2.getIconImageUrl(), event.getIconImageUrl()) && Objects.equal(event2.getPlayer(), event.getPlayer()) && Objects.equal(Long.valueOf(event2.getValue()), Long.valueOf(event.getValue())) && Objects.equal(event2.getFormattedValue(), event.getFormattedValue()) && Objects.equal(Boolean.valueOf(event2.isVisible()), Boolean.valueOf(event.isVisible()));
    }

    public final String toString() {
        return zzb(this);
    }

    static String zzb(Event event) {
        return Objects.toStringHelper(event).add("Id", event.getEventId()).add("Name", event.getName()).add("Description", event.getDescription()).add("IconImageUri", event.getIconImageUri()).add("IconImageUrl", event.getIconImageUrl()).add("Player", event.getPlayer()).add("Value", Long.valueOf(event.getValue())).add("FormattedValue", event.getFormattedValue()).add("isVisible", Boolean.valueOf(event.isVisible())).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getEventId(), false);
        SafeParcelWriter.writeString(parcel, 2, getName(), false);
        SafeParcelWriter.writeString(parcel, 3, getDescription(), false);
        SafeParcelWriter.writeParcelable(parcel, 4, getIconImageUri(), i, false);
        SafeParcelWriter.writeString(parcel, 5, getIconImageUrl(), false);
        SafeParcelWriter.writeParcelable(parcel, 6, getPlayer(), i, false);
        SafeParcelWriter.writeLong(parcel, 7, getValue());
        SafeParcelWriter.writeString(parcel, 8, getFormattedValue(), false);
        SafeParcelWriter.writeBoolean(parcel, 9, isVisible());
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

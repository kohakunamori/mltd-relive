package com.google.android.gms.games.multiplayer.realtime;

import android.database.CharArrayBuffer;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.DataUtils;
import com.google.android.gms.common.util.RetainForClient;
import com.google.android.gms.games.Player;
import com.google.android.gms.games.internal.GamesDowngradeableSafeParcel;
import com.google.android.gms.games.multiplayer.Participant;
import com.google.android.gms.games.multiplayer.ParticipantEntity;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@RetainForClient
@SafeParcelable.Class(creator = "RoomEntityCreator")
@SafeParcelable.Reserved({1000})
public final class RoomEntity extends GamesDowngradeableSafeParcel implements Room {
    public static final Parcelable.Creator<RoomEntity> CREATOR = new zza();

    @SafeParcelable.Field(getter = "getDescription", m22id = 5)
    private final String description;

    @SafeParcelable.Field(getter = "getCreationTimestamp", m22id = 3)
    private final long zzoz;

    @SafeParcelable.Field(getter = "getParticipants", m22id = 8)
    private final ArrayList<ParticipantEntity> zzpc;

    @SafeParcelable.Field(getter = "getVariant", m22id = 6)
    private final int zzpd;

    @Nullable
    @SafeParcelable.Field(getter = "getAutoMatchCriteria", m22id = 7)
    private final Bundle zzpz;

    @SafeParcelable.Field(getter = "getRoomId", m22id = 1)
    private final String zzqc;

    @SafeParcelable.Field(getter = "getCreatorId", m22id = 2)
    private final String zzqd;

    @SafeParcelable.Field(getter = "getStatus", m22id = 4)
    private final int zzqe;

    @SafeParcelable.Field(getter = "getAutoMatchWaitEstimateSeconds", m22id = 9)
    private final int zzqf;

    static final class zza extends zze {
        zza() {
        }

        @Override // com.google.android.gms.games.multiplayer.realtime.zze
        /* JADX INFO: renamed from: zzg */
        public final RoomEntity createFromParcel(Parcel parcel) {
            if (RoomEntity.zzb(RoomEntity.getUnparcelClientVersion()) || RoomEntity.canUnparcelSafely(RoomEntity.class.getCanonicalName())) {
                return super.createFromParcel(parcel);
            }
            String string = parcel.readString();
            String string2 = parcel.readString();
            long j = parcel.readLong();
            int i = parcel.readInt();
            String string3 = parcel.readString();
            int i2 = parcel.readInt();
            Bundle bundle = parcel.readBundle();
            int i3 = parcel.readInt();
            ArrayList arrayList = new ArrayList(i3);
            for (int i4 = 0; i4 < i3; i4++) {
                arrayList.add(ParticipantEntity.CREATOR.createFromParcel(parcel));
            }
            return new RoomEntity(string, string2, j, i, string3, i2, bundle, arrayList, -1);
        }

        @Override // com.google.android.gms.games.multiplayer.realtime.zze, android.os.Parcelable.Creator
        public final /* synthetic */ RoomEntity createFromParcel(Parcel parcel) {
            return createFromParcel(parcel);
        }
    }

    public RoomEntity(Room room) {
        this(room, ParticipantEntity.zza(room.getParticipants()));
    }

    /* JADX WARN: Can't rename method to resolve collision */
    @Override // com.google.android.gms.common.data.Freezable
    public final Room freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    private RoomEntity(Room room, ArrayList<ParticipantEntity> arrayList) {
        this.zzqc = room.getRoomId();
        this.zzqd = room.getCreatorId();
        this.zzoz = room.getCreationTimestamp();
        this.zzqe = room.getStatus();
        this.description = room.getDescription();
        this.zzpd = room.getVariant();
        this.zzpz = room.getAutoMatchCriteria();
        this.zzpc = arrayList;
        this.zzqf = room.getAutoMatchWaitEstimateSeconds();
    }

    @SafeParcelable.Constructor
    RoomEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) String str2, @SafeParcelable.Param(m23id = 3) long j, @SafeParcelable.Param(m23id = 4) int i, @SafeParcelable.Param(m23id = 5) String str3, @SafeParcelable.Param(m23id = 6) int i2, @Nullable @SafeParcelable.Param(m23id = 7) Bundle bundle, @SafeParcelable.Param(m23id = 8) ArrayList<ParticipantEntity> arrayList, @SafeParcelable.Param(m23id = 9) int i3) {
        this.zzqc = str;
        this.zzqd = str2;
        this.zzoz = j;
        this.zzqe = i;
        this.description = str3;
        this.zzpd = i2;
        this.zzpz = bundle;
        this.zzpc = arrayList;
        this.zzqf = i3;
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final String getRoomId() {
        return this.zzqc;
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final String getCreatorId() {
        return this.zzqd;
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final long getCreationTimestamp() {
        return this.zzoz;
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final int getStatus() {
        return this.zzqe;
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final String getDescription() {
        return this.description;
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final void getDescription(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.description, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final int getVariant() {
        return this.zzpd;
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    @Nullable
    public final Bundle getAutoMatchCriteria() {
        return this.zzpz;
    }

    @Override // com.google.android.gms.games.multiplayer.Participatable
    public final ArrayList<Participant> getParticipants() {
        return new ArrayList<>(this.zzpc);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final int getAutoMatchWaitEstimateSeconds() {
        return this.zzqf;
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final int getParticipantStatus(String str) {
        return zza((Room) this, str);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final ArrayList<String> getParticipantIds() {
        return zzc(this);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final String getParticipantId(String str) {
        return zzb(this, str);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.Room
    public final Participant getParticipant(String str) {
        return zzc(this, str);
    }

    @Override // com.google.android.gms.common.internal.DowngradeableSafeParcel
    public final void setShouldDowngrade(boolean z) {
        super.setShouldDowngrade(z);
        int size = this.zzpc.size();
        for (int i = 0; i < size; i++) {
            this.zzpc.get(i).setShouldDowngrade(z);
        }
    }

    public final int hashCode() {
        return zza(this);
    }

    static int zza(Room room) {
        return Objects.hashCode(room.getRoomId(), room.getCreatorId(), Long.valueOf(room.getCreationTimestamp()), Integer.valueOf(room.getStatus()), room.getDescription(), Integer.valueOf(room.getVariant()), Integer.valueOf(com.google.android.gms.games.internal.zzc.zza(room.getAutoMatchCriteria())), room.getParticipants(), Integer.valueOf(room.getAutoMatchWaitEstimateSeconds()));
    }

    public final boolean equals(Object obj) {
        return zza(this, obj);
    }

    static boolean zza(Room room, Object obj) {
        if (!(obj instanceof Room)) {
            return false;
        }
        if (room == obj) {
            return true;
        }
        Room room2 = (Room) obj;
        return Objects.equal(room2.getRoomId(), room.getRoomId()) && Objects.equal(room2.getCreatorId(), room.getCreatorId()) && Objects.equal(Long.valueOf(room2.getCreationTimestamp()), Long.valueOf(room.getCreationTimestamp())) && Objects.equal(Integer.valueOf(room2.getStatus()), Integer.valueOf(room.getStatus())) && Objects.equal(room2.getDescription(), room.getDescription()) && Objects.equal(Integer.valueOf(room2.getVariant()), Integer.valueOf(room.getVariant())) && com.google.android.gms.games.internal.zzc.zza(room2.getAutoMatchCriteria(), room.getAutoMatchCriteria()) && Objects.equal(room2.getParticipants(), room.getParticipants()) && Objects.equal(Integer.valueOf(room2.getAutoMatchWaitEstimateSeconds()), Integer.valueOf(room.getAutoMatchWaitEstimateSeconds()));
    }

    public final String toString() {
        return zzb(this);
    }

    static String zzb(Room room) {
        return Objects.toStringHelper(room).add("RoomId", room.getRoomId()).add("CreatorId", room.getCreatorId()).add("CreationTimestamp", Long.valueOf(room.getCreationTimestamp())).add("RoomStatus", Integer.valueOf(room.getStatus())).add("Description", room.getDescription()).add("Variant", Integer.valueOf(room.getVariant())).add("AutoMatchCriteria", room.getAutoMatchCriteria()).add("Participants", room.getParticipants()).add("AutoMatchWaitEstimateSeconds", Integer.valueOf(room.getAutoMatchWaitEstimateSeconds())).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        if (!shouldDowngrade()) {
            int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
            SafeParcelWriter.writeString(parcel, 1, getRoomId(), false);
            SafeParcelWriter.writeString(parcel, 2, getCreatorId(), false);
            SafeParcelWriter.writeLong(parcel, 3, getCreationTimestamp());
            SafeParcelWriter.writeInt(parcel, 4, getStatus());
            SafeParcelWriter.writeString(parcel, 5, getDescription(), false);
            SafeParcelWriter.writeInt(parcel, 6, getVariant());
            SafeParcelWriter.writeBundle(parcel, 7, getAutoMatchCriteria(), false);
            SafeParcelWriter.writeTypedList(parcel, 8, getParticipants(), false);
            SafeParcelWriter.writeInt(parcel, 9, getAutoMatchWaitEstimateSeconds());
            SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
            return;
        }
        parcel.writeString(this.zzqc);
        parcel.writeString(this.zzqd);
        parcel.writeLong(this.zzoz);
        parcel.writeInt(this.zzqe);
        parcel.writeString(this.description);
        parcel.writeInt(this.zzpd);
        parcel.writeBundle(this.zzpz);
        int size = this.zzpc.size();
        parcel.writeInt(size);
        for (int i2 = 0; i2 < size; i2++) {
            this.zzpc.get(i2).writeToParcel(parcel, i);
        }
    }

    static int zza(Room room, String str) {
        ArrayList<Participant> participants = room.getParticipants();
        int size = participants.size();
        for (int i = 0; i < size; i++) {
            Participant participant = participants.get(i);
            if (participant.getParticipantId().equals(str)) {
                return participant.getStatus();
            }
        }
        String roomId = room.getRoomId();
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 28 + String.valueOf(roomId).length());
        sb.append("Participant ");
        sb.append(str);
        sb.append(" is not in room ");
        sb.append(roomId);
        throw new IllegalStateException(sb.toString());
    }

    static ArrayList<String> zzc(Room room) {
        ArrayList<Participant> participants = room.getParticipants();
        int size = participants.size();
        ArrayList<String> arrayList = new ArrayList<>(size);
        for (int i = 0; i < size; i++) {
            arrayList.add(participants.get(i).getParticipantId());
        }
        return arrayList;
    }

    static String zzb(Room room, String str) {
        ArrayList<Participant> participants = room.getParticipants();
        int size = participants.size();
        for (int i = 0; i < size; i++) {
            Participant participant = participants.get(i);
            Player player = participant.getPlayer();
            if (player != null && player.getPlayerId().equals(str)) {
                return participant.getParticipantId();
            }
        }
        return null;
    }

    static Participant zzc(Room room, String str) {
        ArrayList<Participant> participants = room.getParticipants();
        int size = participants.size();
        for (int i = 0; i < size; i++) {
            Participant participant = participants.get(i);
            if (participant.getParticipantId().equals(str)) {
                return participant;
            }
        }
        String roomId = room.getRoomId();
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 29 + String.valueOf(roomId).length());
        sb.append("Participant ");
        sb.append(str);
        sb.append(" is not in match ");
        sb.append(roomId);
        throw new IllegalStateException(sb.toString());
    }
}

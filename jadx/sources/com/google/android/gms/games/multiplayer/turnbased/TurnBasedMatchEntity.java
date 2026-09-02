package com.google.android.gms.games.multiplayer.turnbased;

import android.database.CharArrayBuffer;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.DataUtils;
import com.google.android.gms.games.Game;
import com.google.android.gms.games.GameEntity;
import com.google.android.gms.games.Player;
import com.google.android.gms.games.multiplayer.Multiplayer;
import com.google.android.gms.games.multiplayer.Participant;
import com.google.android.gms.games.multiplayer.ParticipantEntity;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "TurnBasedMatchEntityCreator")
@SafeParcelable.Reserved({1000})
public final class TurnBasedMatchEntity extends com.google.android.gms.games.internal.zzd implements TurnBasedMatch {
    public static final Parcelable.Creator<TurnBasedMatchEntity> CREATOR = new zzc();

    @SafeParcelable.Field(getter = "getData", m22id = 12)
    private final byte[] data;

    @SafeParcelable.Field(getter = "getDescription", m22id = 20)
    private final String description;

    @SafeParcelable.Field(getter = "getVersion", m22id = 11)
    private final int version;

    @SafeParcelable.Field(getter = "getLastUpdatedTimestamp", m22id = 6)
    private final long zzfm;

    @SafeParcelable.Field(getter = "getGame", m22id = 1)
    private final GameEntity zzlp;

    @SafeParcelable.Field(getter = "getCreationTimestamp", m22id = 4)
    private final long zzoz;

    @SafeParcelable.Field(getter = "getParticipants", m22id = 13)
    private final ArrayList<ParticipantEntity> zzpc;

    @SafeParcelable.Field(getter = "getVariant", m22id = 10)
    private final int zzpd;

    @Nullable
    @SafeParcelable.Field(getter = "getAutoMatchCriteria", m22id = 17)
    private final Bundle zzpz;

    @SafeParcelable.Field(getter = "getCreatorId", m22id = 3)
    private final String zzqd;

    @SafeParcelable.Field(getter = "getMatchId", m22id = 2)
    private final String zzqm;

    @SafeParcelable.Field(getter = "getLastUpdaterId", m22id = 5)
    private final String zzqn;

    @SafeParcelable.Field(getter = "getPendingParticipantId", m22id = 7)
    private final String zzqo;

    @SafeParcelable.Field(getter = "getStatus", m22id = 8)
    private final int zzqp;

    @SafeParcelable.Field(getter = "getRematchId", m22id = 14)
    private final String zzqq;

    @SafeParcelable.Field(getter = "getPreviousMatchData", m22id = 15)
    private final byte[] zzqr;

    @SafeParcelable.Field(getter = "getMatchNumber", m22id = 16)
    private final int zzqs;

    @SafeParcelable.Field(getter = "getTurnStatus", m22id = 18)
    private final int zzqt;

    @SafeParcelable.Field(getter = "isLocallyModified", m22id = 19)
    private final boolean zzqu;

    @SafeParcelable.Field(getter = "getDescriptionParticipantId", m22id = 21)
    private final String zzqv;

    public TurnBasedMatchEntity(@NonNull TurnBasedMatch turnBasedMatch) {
        this(turnBasedMatch, ParticipantEntity.zza(turnBasedMatch.getParticipants()));
    }

    /* JADX WARN: Can't rename method to resolve collision */
    @Override // com.google.android.gms.common.data.Freezable
    public final TurnBasedMatch freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    private TurnBasedMatchEntity(@NonNull TurnBasedMatch turnBasedMatch, @NonNull ArrayList<ParticipantEntity> arrayList) {
        this.zzlp = new GameEntity(turnBasedMatch.getGame());
        this.zzqm = turnBasedMatch.getMatchId();
        this.zzqd = turnBasedMatch.getCreatorId();
        this.zzoz = turnBasedMatch.getCreationTimestamp();
        this.zzqn = turnBasedMatch.getLastUpdaterId();
        this.zzfm = turnBasedMatch.getLastUpdatedTimestamp();
        this.zzqo = turnBasedMatch.getPendingParticipantId();
        this.zzqp = turnBasedMatch.getStatus();
        this.zzqt = turnBasedMatch.getTurnStatus();
        this.zzpd = turnBasedMatch.getVariant();
        this.version = turnBasedMatch.getVersion();
        this.zzqq = turnBasedMatch.getRematchId();
        this.zzqs = turnBasedMatch.getMatchNumber();
        this.zzpz = turnBasedMatch.getAutoMatchCriteria();
        this.zzqu = turnBasedMatch.isLocallyModified();
        this.description = turnBasedMatch.getDescription();
        this.zzqv = turnBasedMatch.getDescriptionParticipantId();
        byte[] data = turnBasedMatch.getData();
        if (data == null) {
            this.data = null;
        } else {
            this.data = new byte[data.length];
            System.arraycopy(data, 0, this.data, 0, data.length);
        }
        byte[] previousMatchData = turnBasedMatch.getPreviousMatchData();
        if (previousMatchData == null) {
            this.zzqr = null;
        } else {
            this.zzqr = new byte[previousMatchData.length];
            System.arraycopy(previousMatchData, 0, this.zzqr, 0, previousMatchData.length);
        }
        this.zzpc = arrayList;
    }

    @SafeParcelable.Constructor
    TurnBasedMatchEntity(@SafeParcelable.Param(m23id = 1) GameEntity gameEntity, @SafeParcelable.Param(m23id = 2) String str, @SafeParcelable.Param(m23id = 3) String str2, @SafeParcelable.Param(m23id = 4) long j, @SafeParcelable.Param(m23id = 5) String str3, @SafeParcelable.Param(m23id = 6) long j2, @SafeParcelable.Param(m23id = 7) String str4, @SafeParcelable.Param(m23id = 8) int i, @SafeParcelable.Param(m23id = 10) int i2, @SafeParcelable.Param(m23id = 11) int i3, @SafeParcelable.Param(m23id = 12) byte[] bArr, @SafeParcelable.Param(m23id = 13) ArrayList<ParticipantEntity> arrayList, @SafeParcelable.Param(m23id = 14) String str5, @SafeParcelable.Param(m23id = 15) byte[] bArr2, @SafeParcelable.Param(m23id = 16) int i4, @Nullable @SafeParcelable.Param(m23id = 17) Bundle bundle, @SafeParcelable.Param(m23id = 18) int i5, @SafeParcelable.Param(m23id = 19) boolean z, @SafeParcelable.Param(m23id = 20) String str6, @SafeParcelable.Param(m23id = 21) String str7) {
        this.zzlp = gameEntity;
        this.zzqm = str;
        this.zzqd = str2;
        this.zzoz = j;
        this.zzqn = str3;
        this.zzfm = j2;
        this.zzqo = str4;
        this.zzqp = i;
        this.zzqt = i5;
        this.zzpd = i2;
        this.version = i3;
        this.data = bArr;
        this.zzpc = arrayList;
        this.zzqq = str5;
        this.zzqr = bArr2;
        this.zzqs = i4;
        this.zzpz = bundle;
        this.zzqu = z;
        this.description = str6;
        this.zzqv = str7;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final Game getGame() {
        return this.zzlp;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final String getMatchId() {
        return this.zzqm;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final String getCreatorId() {
        return this.zzqd;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final long getCreationTimestamp() {
        return this.zzoz;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final String getLastUpdaterId() {
        return this.zzqn;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final long getLastUpdatedTimestamp() {
        return this.zzfm;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final String getPendingParticipantId() {
        return this.zzqo;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final int getStatus() {
        return this.zzqp;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final int getTurnStatus() {
        return this.zzqt;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final String getDescription() {
        return this.description;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final String getDescriptionParticipantId() {
        return this.zzqv;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final Participant getDescriptionParticipant() {
        String descriptionParticipantId = getDescriptionParticipantId();
        if (descriptionParticipantId == null) {
            return null;
        }
        return getParticipant(descriptionParticipantId);
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final void getDescription(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.description, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final int getVariant() {
        return this.zzpd;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final byte[] getData() {
        return this.data;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final int getVersion() {
        return this.version;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final String getRematchId() {
        return this.zzqq;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final byte[] getPreviousMatchData() {
        return this.zzqr;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final int getMatchNumber() {
        return this.zzqs;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    @Nullable
    public final Bundle getAutoMatchCriteria() {
        return this.zzpz;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final int getAvailableAutoMatchSlots() {
        if (this.zzpz == null) {
            return 0;
        }
        return this.zzpz.getInt(Multiplayer.EXTRA_MAX_AUTOMATCH_PLAYERS);
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final boolean canRematch() {
        return this.zzqp == 2 && this.zzqq == null;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final boolean isLocallyModified() {
        return this.zzqu;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final int getParticipantStatus(String str) {
        return zza((TurnBasedMatch) this, str);
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final ArrayList<String> getParticipantIds() {
        return zzc(this);
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final String getParticipantId(String str) {
        return zzb(this, str);
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
    public final Participant getParticipant(String str) {
        return zzc(this, str);
    }

    @Override // com.google.android.gms.games.multiplayer.Participatable
    public final ArrayList<Participant> getParticipants() {
        return new ArrayList<>(this.zzpc);
    }

    public final int hashCode() {
        return zza(this);
    }

    static int zza(TurnBasedMatch turnBasedMatch) {
        return Objects.hashCode(turnBasedMatch.getGame(), turnBasedMatch.getMatchId(), turnBasedMatch.getCreatorId(), Long.valueOf(turnBasedMatch.getCreationTimestamp()), turnBasedMatch.getLastUpdaterId(), Long.valueOf(turnBasedMatch.getLastUpdatedTimestamp()), turnBasedMatch.getPendingParticipantId(), Integer.valueOf(turnBasedMatch.getStatus()), Integer.valueOf(turnBasedMatch.getTurnStatus()), turnBasedMatch.getDescription(), Integer.valueOf(turnBasedMatch.getVariant()), Integer.valueOf(turnBasedMatch.getVersion()), turnBasedMatch.getParticipants(), turnBasedMatch.getRematchId(), Integer.valueOf(turnBasedMatch.getMatchNumber()), Integer.valueOf(com.google.android.gms.games.internal.zzc.zza(turnBasedMatch.getAutoMatchCriteria())), Integer.valueOf(turnBasedMatch.getAvailableAutoMatchSlots()), Boolean.valueOf(turnBasedMatch.isLocallyModified()));
    }

    public final boolean equals(Object obj) {
        return zza(this, obj);
    }

    static boolean zza(TurnBasedMatch turnBasedMatch, Object obj) {
        if (!(obj instanceof TurnBasedMatch)) {
            return false;
        }
        if (turnBasedMatch == obj) {
            return true;
        }
        TurnBasedMatch turnBasedMatch2 = (TurnBasedMatch) obj;
        return Objects.equal(turnBasedMatch2.getGame(), turnBasedMatch.getGame()) && Objects.equal(turnBasedMatch2.getMatchId(), turnBasedMatch.getMatchId()) && Objects.equal(turnBasedMatch2.getCreatorId(), turnBasedMatch.getCreatorId()) && Objects.equal(Long.valueOf(turnBasedMatch2.getCreationTimestamp()), Long.valueOf(turnBasedMatch.getCreationTimestamp())) && Objects.equal(turnBasedMatch2.getLastUpdaterId(), turnBasedMatch.getLastUpdaterId()) && Objects.equal(Long.valueOf(turnBasedMatch2.getLastUpdatedTimestamp()), Long.valueOf(turnBasedMatch.getLastUpdatedTimestamp())) && Objects.equal(turnBasedMatch2.getPendingParticipantId(), turnBasedMatch.getPendingParticipantId()) && Objects.equal(Integer.valueOf(turnBasedMatch2.getStatus()), Integer.valueOf(turnBasedMatch.getStatus())) && Objects.equal(Integer.valueOf(turnBasedMatch2.getTurnStatus()), Integer.valueOf(turnBasedMatch.getTurnStatus())) && Objects.equal(turnBasedMatch2.getDescription(), turnBasedMatch.getDescription()) && Objects.equal(Integer.valueOf(turnBasedMatch2.getVariant()), Integer.valueOf(turnBasedMatch.getVariant())) && Objects.equal(Integer.valueOf(turnBasedMatch2.getVersion()), Integer.valueOf(turnBasedMatch.getVersion())) && Objects.equal(turnBasedMatch2.getParticipants(), turnBasedMatch.getParticipants()) && Objects.equal(turnBasedMatch2.getRematchId(), turnBasedMatch.getRematchId()) && Objects.equal(Integer.valueOf(turnBasedMatch2.getMatchNumber()), Integer.valueOf(turnBasedMatch.getMatchNumber())) && com.google.android.gms.games.internal.zzc.zza(turnBasedMatch2.getAutoMatchCriteria(), turnBasedMatch.getAutoMatchCriteria()) && Objects.equal(Integer.valueOf(turnBasedMatch2.getAvailableAutoMatchSlots()), Integer.valueOf(turnBasedMatch.getAvailableAutoMatchSlots())) && Objects.equal(Boolean.valueOf(turnBasedMatch2.isLocallyModified()), Boolean.valueOf(turnBasedMatch.isLocallyModified()));
    }

    public final String toString() {
        return zzb(this);
    }

    static String zzb(TurnBasedMatch turnBasedMatch) {
        return Objects.toStringHelper(turnBasedMatch).add("Game", turnBasedMatch.getGame()).add("MatchId", turnBasedMatch.getMatchId()).add("CreatorId", turnBasedMatch.getCreatorId()).add("CreationTimestamp", Long.valueOf(turnBasedMatch.getCreationTimestamp())).add("LastUpdaterId", turnBasedMatch.getLastUpdaterId()).add("LastUpdatedTimestamp", Long.valueOf(turnBasedMatch.getLastUpdatedTimestamp())).add("PendingParticipantId", turnBasedMatch.getPendingParticipantId()).add("MatchStatus", Integer.valueOf(turnBasedMatch.getStatus())).add("TurnStatus", Integer.valueOf(turnBasedMatch.getTurnStatus())).add("Description", turnBasedMatch.getDescription()).add("Variant", Integer.valueOf(turnBasedMatch.getVariant())).add("Data", turnBasedMatch.getData()).add("Version", Integer.valueOf(turnBasedMatch.getVersion())).add("Participants", turnBasedMatch.getParticipants()).add("RematchId", turnBasedMatch.getRematchId()).add("PreviousData", turnBasedMatch.getPreviousMatchData()).add("MatchNumber", Integer.valueOf(turnBasedMatch.getMatchNumber())).add("AutoMatchCriteria", turnBasedMatch.getAutoMatchCriteria()).add("AvailableAutoMatchSlots", Integer.valueOf(turnBasedMatch.getAvailableAutoMatchSlots())).add("LocallyModified", Boolean.valueOf(turnBasedMatch.isLocallyModified())).add("DescriptionParticipantId", turnBasedMatch.getDescriptionParticipantId()).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, getGame(), i, false);
        SafeParcelWriter.writeString(parcel, 2, getMatchId(), false);
        SafeParcelWriter.writeString(parcel, 3, getCreatorId(), false);
        SafeParcelWriter.writeLong(parcel, 4, getCreationTimestamp());
        SafeParcelWriter.writeString(parcel, 5, getLastUpdaterId(), false);
        SafeParcelWriter.writeLong(parcel, 6, getLastUpdatedTimestamp());
        SafeParcelWriter.writeString(parcel, 7, getPendingParticipantId(), false);
        SafeParcelWriter.writeInt(parcel, 8, getStatus());
        SafeParcelWriter.writeInt(parcel, 10, getVariant());
        SafeParcelWriter.writeInt(parcel, 11, getVersion());
        SafeParcelWriter.writeByteArray(parcel, 12, getData(), false);
        SafeParcelWriter.writeTypedList(parcel, 13, getParticipants(), false);
        SafeParcelWriter.writeString(parcel, 14, getRematchId(), false);
        SafeParcelWriter.writeByteArray(parcel, 15, getPreviousMatchData(), false);
        SafeParcelWriter.writeInt(parcel, 16, getMatchNumber());
        SafeParcelWriter.writeBundle(parcel, 17, getAutoMatchCriteria(), false);
        SafeParcelWriter.writeInt(parcel, 18, getTurnStatus());
        SafeParcelWriter.writeBoolean(parcel, 19, isLocallyModified());
        SafeParcelWriter.writeString(parcel, 20, getDescription(), false);
        SafeParcelWriter.writeString(parcel, 21, getDescriptionParticipantId(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    static int zza(TurnBasedMatch turnBasedMatch, String str) {
        ArrayList<Participant> participants = turnBasedMatch.getParticipants();
        int size = participants.size();
        for (int i = 0; i < size; i++) {
            Participant participant = participants.get(i);
            if (participant.getParticipantId().equals(str)) {
                return participant.getStatus();
            }
        }
        String matchId = turnBasedMatch.getMatchId();
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 29 + String.valueOf(matchId).length());
        sb.append("Participant ");
        sb.append(str);
        sb.append(" is not in match ");
        sb.append(matchId);
        throw new IllegalStateException(sb.toString());
    }

    static ArrayList<String> zzc(TurnBasedMatch turnBasedMatch) {
        ArrayList<Participant> participants = turnBasedMatch.getParticipants();
        int size = participants.size();
        ArrayList<String> arrayList = new ArrayList<>(size);
        for (int i = 0; i < size; i++) {
            arrayList.add(participants.get(i).getParticipantId());
        }
        return arrayList;
    }

    static String zzb(TurnBasedMatch turnBasedMatch, String str) {
        ArrayList<Participant> participants = turnBasedMatch.getParticipants();
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

    static Participant zzc(TurnBasedMatch turnBasedMatch, String str) {
        ArrayList<Participant> participants = turnBasedMatch.getParticipants();
        int size = participants.size();
        for (int i = 0; i < size; i++) {
            Participant participant = participants.get(i);
            if (participant.getParticipantId().equals(str)) {
                return participant;
            }
        }
        String matchId = turnBasedMatch.getMatchId();
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 29 + String.valueOf(matchId).length());
        sb.append("Participant ");
        sb.append(str);
        sb.append(" is not in match ");
        sb.append(matchId);
        throw new IllegalStateException(sb.toString());
    }
}

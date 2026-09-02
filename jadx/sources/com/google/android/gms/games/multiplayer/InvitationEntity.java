package com.google.android.gms.games.multiplayer;

import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.RetainForClient;
import com.google.android.gms.games.Game;
import com.google.android.gms.games.GameEntity;
import com.google.android.gms.games.internal.GamesDowngradeableSafeParcel;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@RetainForClient
@SafeParcelable.Class(creator = "InvitationEntityCreator")
@SafeParcelable.Reserved({1000})
public final class InvitationEntity extends GamesDowngradeableSafeParcel implements Invitation {
    public static final Parcelable.Creator<InvitationEntity> CREATOR = new zza();

    @SafeParcelable.Field(getter = "getGame", m22id = 1)
    private final GameEntity zzlp;

    @SafeParcelable.Field(getter = "getInvitationId", m22id = 2)
    private final String zzoy;

    @SafeParcelable.Field(getter = "getCreationTimestamp", m22id = 3)
    private final long zzoz;

    @SafeParcelable.Field(getter = "getInvitationType", m22id = 4)
    private final int zzpa;

    @SafeParcelable.Field(getter = "getInviter", m22id = 5)
    private final ParticipantEntity zzpb;

    @SafeParcelable.Field(getter = "getParticipants", m22id = 6)
    private final ArrayList<ParticipantEntity> zzpc;

    @SafeParcelable.Field(getter = "getVariant", m22id = 7)
    private final int zzpd;

    @SafeParcelable.Field(getter = "getAvailableAutoMatchSlots", m22id = 8)
    private final int zzpe;

    static final class zza extends com.google.android.gms.games.multiplayer.zza {
        zza() {
        }

        @Override // com.google.android.gms.games.multiplayer.zza
        /* JADX INFO: renamed from: zze */
        public final InvitationEntity createFromParcel(Parcel parcel) {
            if (InvitationEntity.zzb(InvitationEntity.getUnparcelClientVersion()) || InvitationEntity.canUnparcelSafely(InvitationEntity.class.getCanonicalName())) {
                return super.createFromParcel(parcel);
            }
            GameEntity gameEntityCreateFromParcel = GameEntity.CREATOR.createFromParcel(parcel);
            String string = parcel.readString();
            long j = parcel.readLong();
            int i = parcel.readInt();
            ParticipantEntity participantEntityCreateFromParcel = ParticipantEntity.CREATOR.createFromParcel(parcel);
            int i2 = parcel.readInt();
            ArrayList arrayList = new ArrayList(i2);
            for (int i3 = 0; i3 < i2; i3++) {
                arrayList.add(ParticipantEntity.CREATOR.createFromParcel(parcel));
            }
            return new InvitationEntity(gameEntityCreateFromParcel, string, j, i, participantEntityCreateFromParcel, arrayList, -1, 0);
        }

        @Override // com.google.android.gms.games.multiplayer.zza, android.os.Parcelable.Creator
        public final /* synthetic */ InvitationEntity createFromParcel(Parcel parcel) {
            return createFromParcel(parcel);
        }
    }

    InvitationEntity(@NonNull Invitation invitation) {
        this(invitation, ParticipantEntity.zza(invitation.getParticipants()));
    }

    /* JADX WARN: Can't rename method to resolve collision */
    @Override // com.google.android.gms.common.data.Freezable
    public final Invitation freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    private InvitationEntity(@NonNull Invitation invitation, @NonNull ArrayList<ParticipantEntity> arrayList) {
        ParticipantEntity participantEntity;
        this.zzlp = new GameEntity(invitation.getGame());
        this.zzoy = invitation.getInvitationId();
        this.zzoz = invitation.getCreationTimestamp();
        this.zzpa = invitation.getInvitationType();
        this.zzpd = invitation.getVariant();
        this.zzpe = invitation.getAvailableAutoMatchSlots();
        String participantId = invitation.getInviter().getParticipantId();
        this.zzpc = arrayList;
        ArrayList<ParticipantEntity> arrayList2 = arrayList;
        int size = arrayList2.size();
        int i = 0;
        while (i < size) {
            ParticipantEntity participantEntity2 = arrayList2.get(i);
            i++;
            participantEntity = participantEntity2;
            if (participantEntity.getParticipantId().equals(participantId)) {
                Preconditions.checkNotNull(participantEntity, "Must have a valid inviter!");
                this.zzpb = participantEntity;
            }
        }
        participantEntity = null;
        Preconditions.checkNotNull(participantEntity, "Must have a valid inviter!");
        this.zzpb = participantEntity;
    }

    @SafeParcelable.Constructor
    InvitationEntity(@SafeParcelable.Param(m23id = 1) GameEntity gameEntity, @SafeParcelable.Param(m23id = 2) String str, @SafeParcelable.Param(m23id = 3) long j, @SafeParcelable.Param(m23id = 4) int i, @SafeParcelable.Param(m23id = 5) ParticipantEntity participantEntity, @SafeParcelable.Param(m23id = 6) ArrayList<ParticipantEntity> arrayList, @SafeParcelable.Param(m23id = 7) int i2, @SafeParcelable.Param(m23id = 8) int i3) {
        this.zzlp = gameEntity;
        this.zzoy = str;
        this.zzoz = j;
        this.zzpa = i;
        this.zzpb = participantEntity;
        this.zzpc = arrayList;
        this.zzpd = i2;
        this.zzpe = i3;
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final Game getGame() {
        return this.zzlp;
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final String getInvitationId() {
        return this.zzoy;
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final Participant getInviter() {
        return this.zzpb;
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final long getCreationTimestamp() {
        return this.zzoz;
    }

    @Override // com.google.android.gms.games.multiplayer.Participatable
    public final ArrayList<Participant> getParticipants() {
        return new ArrayList<>(this.zzpc);
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final int getInvitationType() {
        return this.zzpa;
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final int getVariant() {
        return this.zzpd;
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final int getAvailableAutoMatchSlots() {
        return this.zzpe;
    }

    @Override // com.google.android.gms.common.internal.DowngradeableSafeParcel
    public final void setShouldDowngrade(boolean z) {
        super.setShouldDowngrade(z);
        this.zzlp.setShouldDowngrade(z);
        this.zzpb.setShouldDowngrade(z);
        int size = this.zzpc.size();
        for (int i = 0; i < size; i++) {
            this.zzpc.get(i).setShouldDowngrade(z);
        }
    }

    public final int hashCode() {
        return zza(this);
    }

    static int zza(Invitation invitation) {
        return Objects.hashCode(invitation.getGame(), invitation.getInvitationId(), Long.valueOf(invitation.getCreationTimestamp()), Integer.valueOf(invitation.getInvitationType()), invitation.getInviter(), invitation.getParticipants(), Integer.valueOf(invitation.getVariant()), Integer.valueOf(invitation.getAvailableAutoMatchSlots()));
    }

    public final boolean equals(Object obj) {
        return zza(this, obj);
    }

    static boolean zza(Invitation invitation, Object obj) {
        if (!(obj instanceof Invitation)) {
            return false;
        }
        if (invitation == obj) {
            return true;
        }
        Invitation invitation2 = (Invitation) obj;
        return Objects.equal(invitation2.getGame(), invitation.getGame()) && Objects.equal(invitation2.getInvitationId(), invitation.getInvitationId()) && Objects.equal(Long.valueOf(invitation2.getCreationTimestamp()), Long.valueOf(invitation.getCreationTimestamp())) && Objects.equal(Integer.valueOf(invitation2.getInvitationType()), Integer.valueOf(invitation.getInvitationType())) && Objects.equal(invitation2.getInviter(), invitation.getInviter()) && Objects.equal(invitation2.getParticipants(), invitation.getParticipants()) && Objects.equal(Integer.valueOf(invitation2.getVariant()), Integer.valueOf(invitation.getVariant())) && Objects.equal(Integer.valueOf(invitation2.getAvailableAutoMatchSlots()), Integer.valueOf(invitation.getAvailableAutoMatchSlots()));
    }

    public final String toString() {
        return zzb(this);
    }

    static String zzb(Invitation invitation) {
        return Objects.toStringHelper(invitation).add("Game", invitation.getGame()).add("InvitationId", invitation.getInvitationId()).add("CreationTimestamp", Long.valueOf(invitation.getCreationTimestamp())).add("InvitationType", Integer.valueOf(invitation.getInvitationType())).add("Inviter", invitation.getInviter()).add("Participants", invitation.getParticipants()).add("Variant", Integer.valueOf(invitation.getVariant())).add("AvailableAutoMatchSlots", Integer.valueOf(invitation.getAvailableAutoMatchSlots())).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        if (!shouldDowngrade()) {
            int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
            SafeParcelWriter.writeParcelable(parcel, 1, getGame(), i, false);
            SafeParcelWriter.writeString(parcel, 2, getInvitationId(), false);
            SafeParcelWriter.writeLong(parcel, 3, getCreationTimestamp());
            SafeParcelWriter.writeInt(parcel, 4, getInvitationType());
            SafeParcelWriter.writeParcelable(parcel, 5, getInviter(), i, false);
            SafeParcelWriter.writeTypedList(parcel, 6, getParticipants(), false);
            SafeParcelWriter.writeInt(parcel, 7, getVariant());
            SafeParcelWriter.writeInt(parcel, 8, getAvailableAutoMatchSlots());
            SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
            return;
        }
        this.zzlp.writeToParcel(parcel, i);
        parcel.writeString(this.zzoy);
        parcel.writeLong(this.zzoz);
        parcel.writeInt(this.zzpa);
        this.zzpb.writeToParcel(parcel, i);
        int size = this.zzpc.size();
        parcel.writeInt(size);
        for (int i2 = 0; i2 < size; i2++) {
            this.zzpc.get(i2).writeToParcel(parcel, i);
        }
    }
}

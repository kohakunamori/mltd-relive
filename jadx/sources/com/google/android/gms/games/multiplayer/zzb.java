package com.google.android.gms.games.multiplayer;

import android.os.Parcel;
import com.google.android.gms.common.data.DataBufferRef;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.games.Game;
import com.google.android.gms.games.GameRef;
import com.google.android.gms.measurement.api.AppMeasurementSdk;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public final class zzb extends DataBufferRef implements Invitation {
    private final Game zznw;
    private final ArrayList<Participant> zzpc;
    private final ParticipantRef zzpf;

    zzb(DataHolder dataHolder, int i, int i2) {
        super(dataHolder, i);
        this.zznw = new GameRef(dataHolder, i);
        this.zzpc = new ArrayList<>(i2);
        String string = getString("external_inviter_id");
        ParticipantRef participantRef = null;
        for (int i3 = 0; i3 < i2; i3++) {
            ParticipantRef participantRef2 = new ParticipantRef(this.mDataHolder, this.mDataRow + i3);
            if (participantRef2.getParticipantId().equals(string)) {
                participantRef = participantRef2;
            }
            this.zzpc.add(participantRef2);
        }
        this.zzpf = (ParticipantRef) Preconditions.checkNotNull(participantRef, "Must have a valid inviter!");
    }

    @Override // android.os.Parcelable
    public final int describeContents() {
        return 0;
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final Game getGame() {
        return this.zznw;
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final String getInvitationId() {
        return getString("external_invitation_id");
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final Participant getInviter() {
        return this.zzpf;
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final long getCreationTimestamp() {
        return Math.max(getLong(AppMeasurementSdk.ConditionalUserProperty.CREATION_TIMESTAMP), getLong("last_modified_timestamp"));
    }

    @Override // com.google.android.gms.games.multiplayer.Participatable
    public final ArrayList<Participant> getParticipants() {
        return this.zzpc;
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final int getInvitationType() {
        return getInteger("type");
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final int getVariant() {
        return getInteger("variant");
    }

    @Override // com.google.android.gms.games.multiplayer.Invitation
    public final int getAvailableAutoMatchSlots() {
        if (getBoolean("has_automatch_criteria")) {
            return getInteger("automatch_max_players");
        }
        return 0;
    }

    @Override // com.google.android.gms.common.data.DataBufferRef
    public final int hashCode() {
        return InvitationEntity.zza(this);
    }

    @Override // com.google.android.gms.common.data.DataBufferRef
    public final boolean equals(Object obj) {
        return InvitationEntity.zza(this, obj);
    }

    public final String toString() {
        return InvitationEntity.zzb(this);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        ((InvitationEntity) ((Invitation) freeze())).writeToParcel(parcel, i);
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* synthetic */ Invitation freeze() {
        return new InvitationEntity(this);
    }
}

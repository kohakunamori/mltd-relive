package com.google.android.gms.games.request;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.games.Game;
import com.google.android.gms.games.GameEntity;
import com.google.android.gms.games.Player;
import com.google.android.gms.games.PlayerEntity;
import com.google.android.gms.games.internal.zzd;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "GameRequestEntityCreator")
@SafeParcelable.Reserved({1000})
@Deprecated
public final class GameRequestEntity extends zzd implements GameRequest {
    public static final Parcelable.Creator<GameRequestEntity> CREATOR = new zza();

    @SafeParcelable.Field(getter = "getData", m22id = 3)
    private final byte[] data;

    @SafeParcelable.Field(getter = "getStatus", m22id = 12)
    private final int status;

    @SafeParcelable.Field(getter = "getType", m22id = 7)
    private final int type;

    @SafeParcelable.Field(getter = "getGame", m22id = 1)
    private final GameEntity zzlp;

    @SafeParcelable.Field(getter = "getCreationTimestamp", m22id = 9)
    private final long zzoz;

    @SafeParcelable.Field(getter = "getSender", m22id = 2)
    private final PlayerEntity zzrk;

    @SafeParcelable.Field(getter = "getRequestId", m22id = 4)
    private final String zzrl;

    @SafeParcelable.Field(getter = "getRecipients", m22id = 5)
    private final ArrayList<PlayerEntity> zzrm;

    @SafeParcelable.Field(getter = "getExpirationTimestamp", m22id = 10)
    private final long zzrn;

    @SafeParcelable.Field(getter = "getRecipientStatusBundle", m22id = 11)
    private final Bundle zzro;

    public GameRequestEntity(GameRequest gameRequest) {
        this.zzlp = new GameEntity(gameRequest.getGame());
        this.zzrk = new PlayerEntity(gameRequest.getSender());
        this.zzrl = gameRequest.getRequestId();
        this.type = gameRequest.getType();
        this.zzoz = gameRequest.getCreationTimestamp();
        this.zzrn = gameRequest.getExpirationTimestamp();
        this.status = gameRequest.getStatus();
        byte[] data = gameRequest.getData();
        if (data == null) {
            this.data = null;
        } else {
            this.data = new byte[data.length];
            System.arraycopy(data, 0, this.data, 0, data.length);
        }
        List<Player> recipients = gameRequest.getRecipients();
        int size = recipients.size();
        this.zzrm = new ArrayList<>(size);
        this.zzro = new Bundle();
        for (int i = 0; i < size; i++) {
            Player playerFreeze = recipients.get(i).freeze();
            String playerId = playerFreeze.getPlayerId();
            this.zzrm.add((PlayerEntity) playerFreeze);
            this.zzro.putInt(playerId, gameRequest.getRecipientStatus(playerId));
        }
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ GameRequest freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @SafeParcelable.Constructor
    GameRequestEntity(@SafeParcelable.Param(m23id = 1) GameEntity gameEntity, @SafeParcelable.Param(m23id = 2) PlayerEntity playerEntity, @SafeParcelable.Param(m23id = 3) byte[] bArr, @SafeParcelable.Param(m23id = 4) String str, @SafeParcelable.Param(m23id = 5) ArrayList<PlayerEntity> arrayList, @SafeParcelable.Param(m23id = 7) int i, @SafeParcelable.Param(m23id = 9) long j, @SafeParcelable.Param(m23id = 10) long j2, @SafeParcelable.Param(m23id = 11) Bundle bundle, @SafeParcelable.Param(m23id = 12) int i2) {
        this.zzlp = gameEntity;
        this.zzrk = playerEntity;
        this.data = bArr;
        this.zzrl = str;
        this.zzrm = arrayList;
        this.type = i;
        this.zzoz = j;
        this.zzrn = j2;
        this.zzro = bundle;
        this.status = i2;
    }

    @Override // com.google.android.gms.games.request.GameRequest
    public final String getRequestId() {
        return this.zzrl;
    }

    @Override // com.google.android.gms.games.request.GameRequest
    public final Game getGame() {
        return this.zzlp;
    }

    @Override // com.google.android.gms.games.request.GameRequest
    public final Player getSender() {
        return this.zzrk;
    }

    @Override // com.google.android.gms.games.request.GameRequest
    public final List<Player> getRecipients() {
        return new ArrayList(this.zzrm);
    }

    @Override // com.google.android.gms.games.request.GameRequest
    public final boolean isConsumed(String str) {
        return getRecipientStatus(str) == 1;
    }

    @Override // com.google.android.gms.games.request.GameRequest
    public final byte[] getData() {
        return this.data;
    }

    @Override // com.google.android.gms.games.request.GameRequest
    public final int getType() {
        return this.type;
    }

    @Override // com.google.android.gms.games.request.GameRequest
    public final long getCreationTimestamp() {
        return this.zzoz;
    }

    @Override // com.google.android.gms.games.request.GameRequest
    public final long getExpirationTimestamp() {
        return this.zzrn;
    }

    @Override // com.google.android.gms.games.request.GameRequest
    public final int getRecipientStatus(String str) {
        return this.zzro.getInt(str, 0);
    }

    @Override // com.google.android.gms.games.request.GameRequest
    public final int getStatus() {
        return this.status;
    }

    public final int hashCode() {
        return zza(this);
    }

    static int zza(GameRequest gameRequest) {
        return (Arrays.hashCode(zzb(gameRequest)) * 31) + Objects.hashCode(gameRequest.getGame(), gameRequest.getRecipients(), gameRequest.getRequestId(), gameRequest.getSender(), Integer.valueOf(gameRequest.getType()), Long.valueOf(gameRequest.getCreationTimestamp()), Long.valueOf(gameRequest.getExpirationTimestamp()));
    }

    public final boolean equals(Object obj) {
        return zza(this, obj);
    }

    static boolean zza(GameRequest gameRequest, Object obj) {
        if (!(obj instanceof GameRequest)) {
            return false;
        }
        if (gameRequest == obj) {
            return true;
        }
        GameRequest gameRequest2 = (GameRequest) obj;
        return Objects.equal(gameRequest2.getGame(), gameRequest.getGame()) && Objects.equal(gameRequest2.getRecipients(), gameRequest.getRecipients()) && Objects.equal(gameRequest2.getRequestId(), gameRequest.getRequestId()) && Objects.equal(gameRequest2.getSender(), gameRequest.getSender()) && Arrays.equals(zzb(gameRequest2), zzb(gameRequest)) && Objects.equal(Integer.valueOf(gameRequest2.getType()), Integer.valueOf(gameRequest.getType())) && Objects.equal(Long.valueOf(gameRequest2.getCreationTimestamp()), Long.valueOf(gameRequest.getCreationTimestamp())) && Objects.equal(Long.valueOf(gameRequest2.getExpirationTimestamp()), Long.valueOf(gameRequest.getExpirationTimestamp()));
    }

    private static int[] zzb(GameRequest gameRequest) {
        List<Player> recipients = gameRequest.getRecipients();
        int size = recipients.size();
        int[] iArr = new int[size];
        for (int i = 0; i < size; i++) {
            iArr[i] = gameRequest.getRecipientStatus(recipients.get(i).getPlayerId());
        }
        return iArr;
    }

    public final String toString() {
        return zzc(this);
    }

    static String zzc(GameRequest gameRequest) {
        return Objects.toStringHelper(gameRequest).add("Game", gameRequest.getGame()).add("Sender", gameRequest.getSender()).add("Recipients", gameRequest.getRecipients()).add("Data", gameRequest.getData()).add("RequestId", gameRequest.getRequestId()).add("Type", Integer.valueOf(gameRequest.getType())).add("CreationTimestamp", Long.valueOf(gameRequest.getCreationTimestamp())).add("ExpirationTimestamp", Long.valueOf(gameRequest.getExpirationTimestamp())).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, getGame(), i, false);
        SafeParcelWriter.writeParcelable(parcel, 2, getSender(), i, false);
        SafeParcelWriter.writeByteArray(parcel, 3, getData(), false);
        SafeParcelWriter.writeString(parcel, 4, getRequestId(), false);
        SafeParcelWriter.writeTypedList(parcel, 5, getRecipients(), false);
        SafeParcelWriter.writeInt(parcel, 7, getType());
        SafeParcelWriter.writeLong(parcel, 9, getCreationTimestamp());
        SafeParcelWriter.writeLong(parcel, 10, getExpirationTimestamp());
        SafeParcelWriter.writeBundle(parcel, 11, this.zzro, false);
        SafeParcelWriter.writeInt(parcel, 12, getStatus());
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

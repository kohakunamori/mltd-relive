package com.google.android.gms.games.quest;

import android.database.CharArrayBuffer;
import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.DataUtils;
import com.google.android.gms.games.Game;
import com.google.android.gms.games.GameEntity;
import com.google.android.gms.games.internal.zzd;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "QuestEntityCreator")
@SafeParcelable.Reserved({1000})
@Deprecated
public final class QuestEntity extends zzd implements Quest {
    public static final Parcelable.Creator<QuestEntity> CREATOR = new zzc();

    @SafeParcelable.Field(getter = "getDescription", m22id = 6)
    private final String description;

    @SafeParcelable.Field(getter = "getName", m22id = 12)
    private final String name;

    @SafeParcelable.Field(getter = "getState", m22id = 15)
    private final int state;

    @SafeParcelable.Field(getter = "getType", m22id = 16)
    private final int type;

    @SafeParcelable.Field(getter = "getLastUpdatedTimestamp", m22id = 8)
    private final long zzfm;

    @SafeParcelable.Field(getter = "getGame", m22id = 1)
    private final GameEntity zzlp;

    @SafeParcelable.Field(getter = "getQuestId", m22id = 2)
    private final String zzra;

    @SafeParcelable.Field(getter = "getAcceptedTimestamp", m22id = 3)
    private final long zzrb;

    @SafeParcelable.Field(getter = "getBannerImageUri", m22id = 4)
    private final Uri zzrc;

    @SafeParcelable.Field(getter = "getBannerImageUrl", m22id = 5)
    private final String zzrd;

    @SafeParcelable.Field(getter = "getEndTimestamp", m22id = 7)
    private final long zzre;

    @SafeParcelable.Field(getter = "getIconImageUri", m22id = 9)
    private final Uri zzrf;

    @SafeParcelable.Field(getter = "getIconImageUrl", m22id = 10)
    private final String zzrg;

    @SafeParcelable.Field(getter = "getNotifyTimestamp", m22id = 13)
    private final long zzrh;

    @SafeParcelable.Field(getter = "getStartTimestamp", m22id = 14)
    private final long zzri;

    @SafeParcelable.Field(getter = "getMilestones", m22id = 17)
    private final ArrayList<MilestoneEntity> zzrj;

    public QuestEntity(Quest quest) {
        this.zzlp = new GameEntity(quest.getGame());
        this.zzra = quest.getQuestId();
        this.zzrb = quest.getAcceptedTimestamp();
        this.description = quest.getDescription();
        this.zzrc = quest.getBannerImageUri();
        this.zzrd = quest.getBannerImageUrl();
        this.zzre = quest.getEndTimestamp();
        this.zzrf = quest.getIconImageUri();
        this.zzrg = quest.getIconImageUrl();
        this.zzfm = quest.getLastUpdatedTimestamp();
        this.name = quest.getName();
        this.zzrh = quest.zzdr();
        this.zzri = quest.getStartTimestamp();
        this.state = quest.getState();
        this.type = quest.getType();
        List<Milestone> listZzdq = quest.zzdq();
        int size = listZzdq.size();
        this.zzrj = new ArrayList<>(size);
        for (int i = 0; i < size; i++) {
            this.zzrj.add((MilestoneEntity) listZzdq.get(i).freeze());
        }
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ Quest freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @SafeParcelable.Constructor
    QuestEntity(@SafeParcelable.Param(m23id = 1) GameEntity gameEntity, @SafeParcelable.Param(m23id = 2) String str, @SafeParcelable.Param(m23id = 3) long j, @SafeParcelable.Param(m23id = 4) Uri uri, @SafeParcelable.Param(m23id = 5) String str2, @SafeParcelable.Param(m23id = 6) String str3, @SafeParcelable.Param(m23id = 7) long j2, @SafeParcelable.Param(m23id = 8) long j3, @SafeParcelable.Param(m23id = 9) Uri uri2, @SafeParcelable.Param(m23id = 10) String str4, @SafeParcelable.Param(m23id = 12) String str5, @SafeParcelable.Param(m23id = 13) long j4, @SafeParcelable.Param(m23id = 14) long j5, @SafeParcelable.Param(m23id = 15) int i, @SafeParcelable.Param(m23id = 16) int i2, @SafeParcelable.Param(m23id = 17) ArrayList<MilestoneEntity> arrayList) {
        this.zzlp = gameEntity;
        this.zzra = str;
        this.zzrb = j;
        this.zzrc = uri;
        this.zzrd = str2;
        this.description = str3;
        this.zzre = j2;
        this.zzfm = j3;
        this.zzrf = uri2;
        this.zzrg = str4;
        this.name = str5;
        this.zzrh = j4;
        this.zzri = j5;
        this.state = i;
        this.type = i2;
        this.zzrj = arrayList;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final String getQuestId() {
        return this.zzra;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final String getName() {
        return this.name;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final void getName(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.name, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final String getDescription() {
        return this.description;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final void getDescription(CharArrayBuffer charArrayBuffer) {
        DataUtils.copyStringToBuffer(this.description, charArrayBuffer);
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final Uri getIconImageUri() {
        return this.zzrf;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final String getIconImageUrl() {
        return this.zzrg;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final Uri getBannerImageUri() {
        return this.zzrc;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final String getBannerImageUrl() {
        return this.zzrd;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final Milestone getCurrentMilestone() {
        return zzdq().get(0);
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final List<Milestone> zzdq() {
        return new ArrayList(this.zzrj);
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final Game getGame() {
        return this.zzlp;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final int getState() {
        return this.state;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final int getType() {
        return this.type;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final long getAcceptedTimestamp() {
        return this.zzrb;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final long getEndTimestamp() {
        return this.zzre;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final long getLastUpdatedTimestamp() {
        return this.zzfm;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final long zzdr() {
        return this.zzrh;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final long getStartTimestamp() {
        return this.zzri;
    }

    @Override // com.google.android.gms.games.quest.Quest
    public final boolean isEndingSoon() {
        return this.zzrh <= System.currentTimeMillis() + 1800000;
    }

    public final int hashCode() {
        return zza(this);
    }

    static int zza(Quest quest) {
        return Objects.hashCode(quest.getGame(), quest.getQuestId(), Long.valueOf(quest.getAcceptedTimestamp()), quest.getBannerImageUri(), quest.getDescription(), Long.valueOf(quest.getEndTimestamp()), quest.getIconImageUri(), Long.valueOf(quest.getLastUpdatedTimestamp()), quest.zzdq(), quest.getName(), Long.valueOf(quest.zzdr()), Long.valueOf(quest.getStartTimestamp()), Integer.valueOf(quest.getState()));
    }

    public final boolean equals(Object obj) {
        return zza(this, obj);
    }

    static boolean zza(Quest quest, Object obj) {
        if (!(obj instanceof Quest)) {
            return false;
        }
        if (quest == obj) {
            return true;
        }
        Quest quest2 = (Quest) obj;
        return Objects.equal(quest2.getGame(), quest.getGame()) && Objects.equal(quest2.getQuestId(), quest.getQuestId()) && Objects.equal(Long.valueOf(quest2.getAcceptedTimestamp()), Long.valueOf(quest.getAcceptedTimestamp())) && Objects.equal(quest2.getBannerImageUri(), quest.getBannerImageUri()) && Objects.equal(quest2.getDescription(), quest.getDescription()) && Objects.equal(Long.valueOf(quest2.getEndTimestamp()), Long.valueOf(quest.getEndTimestamp())) && Objects.equal(quest2.getIconImageUri(), quest.getIconImageUri()) && Objects.equal(Long.valueOf(quest2.getLastUpdatedTimestamp()), Long.valueOf(quest.getLastUpdatedTimestamp())) && Objects.equal(quest2.zzdq(), quest.zzdq()) && Objects.equal(quest2.getName(), quest.getName()) && Objects.equal(Long.valueOf(quest2.zzdr()), Long.valueOf(quest.zzdr())) && Objects.equal(Long.valueOf(quest2.getStartTimestamp()), Long.valueOf(quest.getStartTimestamp())) && Objects.equal(Integer.valueOf(quest2.getState()), Integer.valueOf(quest.getState()));
    }

    public final String toString() {
        return zzb(this);
    }

    static String zzb(Quest quest) {
        return Objects.toStringHelper(quest).add("Game", quest.getGame()).add("QuestId", quest.getQuestId()).add("AcceptedTimestamp", Long.valueOf(quest.getAcceptedTimestamp())).add("BannerImageUri", quest.getBannerImageUri()).add("BannerImageUrl", quest.getBannerImageUrl()).add("Description", quest.getDescription()).add("EndTimestamp", Long.valueOf(quest.getEndTimestamp())).add("IconImageUri", quest.getIconImageUri()).add("IconImageUrl", quest.getIconImageUrl()).add("LastUpdatedTimestamp", Long.valueOf(quest.getLastUpdatedTimestamp())).add("Milestones", quest.zzdq()).add("Name", quest.getName()).add("NotifyTimestamp", Long.valueOf(quest.zzdr())).add("StartTimestamp", Long.valueOf(quest.getStartTimestamp())).add("State", Integer.valueOf(quest.getState())).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, getGame(), i, false);
        SafeParcelWriter.writeString(parcel, 2, getQuestId(), false);
        SafeParcelWriter.writeLong(parcel, 3, getAcceptedTimestamp());
        SafeParcelWriter.writeParcelable(parcel, 4, getBannerImageUri(), i, false);
        SafeParcelWriter.writeString(parcel, 5, getBannerImageUrl(), false);
        SafeParcelWriter.writeString(parcel, 6, getDescription(), false);
        SafeParcelWriter.writeLong(parcel, 7, getEndTimestamp());
        SafeParcelWriter.writeLong(parcel, 8, getLastUpdatedTimestamp());
        SafeParcelWriter.writeParcelable(parcel, 9, getIconImageUri(), i, false);
        SafeParcelWriter.writeString(parcel, 10, getIconImageUrl(), false);
        SafeParcelWriter.writeString(parcel, 12, getName(), false);
        SafeParcelWriter.writeLong(parcel, 13, this.zzrh);
        SafeParcelWriter.writeLong(parcel, 14, getStartTimestamp());
        SafeParcelWriter.writeInt(parcel, 15, getState());
        SafeParcelWriter.writeInt(parcel, 16, this.type);
        SafeParcelWriter.writeTypedList(parcel, 17, zzdq(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

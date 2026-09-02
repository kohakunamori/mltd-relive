package com.google.android.gms.games.quest;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.games.internal.zzd;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "MilestoneEntityCreator")
@SafeParcelable.Reserved({1000})
@Deprecated
public final class MilestoneEntity extends zzd implements Milestone {
    public static final Parcelable.Creator<MilestoneEntity> CREATOR = new zza();

    @SafeParcelable.Field(getter = "getState", m22id = 5)
    private final int state;

    @SafeParcelable.Field(getter = "getEventId", m22id = 6)
    private final String zzgl;

    @SafeParcelable.Field(getter = "getMilestoneId", m22id = 1)
    private final String zzqw;

    @SafeParcelable.Field(getter = "getCurrentProgress", m22id = 2)
    private final long zzqx;

    @SafeParcelable.Field(getter = "getTargetProgress", m22id = 3)
    private final long zzqy;

    @SafeParcelable.Field(getter = "getCompletionRewardData", m22id = 4)
    private final byte[] zzqz;

    public MilestoneEntity(Milestone milestone) {
        this.zzqw = milestone.getMilestoneId();
        this.zzqx = milestone.getCurrentProgress();
        this.zzqy = milestone.getTargetProgress();
        this.state = milestone.getState();
        this.zzgl = milestone.getEventId();
        byte[] completionRewardData = milestone.getCompletionRewardData();
        if (completionRewardData == null) {
            this.zzqz = null;
        } else {
            this.zzqz = new byte[completionRewardData.length];
            System.arraycopy(completionRewardData, 0, this.zzqz, 0, completionRewardData.length);
        }
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ Milestone freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @SafeParcelable.Constructor
    MilestoneEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) long j, @SafeParcelable.Param(m23id = 3) long j2, @SafeParcelable.Param(m23id = 4) byte[] bArr, @SafeParcelable.Param(m23id = 5) int i, @SafeParcelable.Param(m23id = 6) String str2) {
        this.zzqw = str;
        this.zzqx = j;
        this.zzqy = j2;
        this.zzqz = bArr;
        this.state = i;
        this.zzgl = str2;
    }

    @Override // com.google.android.gms.games.quest.Milestone
    public final String getEventId() {
        return this.zzgl;
    }

    @Override // com.google.android.gms.games.quest.Milestone
    public final String getMilestoneId() {
        return this.zzqw;
    }

    @Override // com.google.android.gms.games.quest.Milestone
    public final long getCurrentProgress() {
        return this.zzqx;
    }

    @Override // com.google.android.gms.games.quest.Milestone
    public final long getTargetProgress() {
        return this.zzqy;
    }

    @Override // com.google.android.gms.games.quest.Milestone
    public final byte[] getCompletionRewardData() {
        return this.zzqz;
    }

    @Override // com.google.android.gms.games.quest.Milestone
    public final int getState() {
        return this.state;
    }

    public final int hashCode() {
        return zza(this);
    }

    static int zza(Milestone milestone) {
        return Objects.hashCode(milestone.getMilestoneId(), Long.valueOf(milestone.getCurrentProgress()), Long.valueOf(milestone.getTargetProgress()), Integer.valueOf(milestone.getState()), milestone.getEventId());
    }

    public final boolean equals(Object obj) {
        return zza(this, obj);
    }

    static boolean zza(Milestone milestone, Object obj) {
        if (!(obj instanceof Milestone)) {
            return false;
        }
        if (milestone == obj) {
            return true;
        }
        Milestone milestone2 = (Milestone) obj;
        return Objects.equal(milestone2.getMilestoneId(), milestone.getMilestoneId()) && Objects.equal(Long.valueOf(milestone2.getCurrentProgress()), Long.valueOf(milestone.getCurrentProgress())) && Objects.equal(Long.valueOf(milestone2.getTargetProgress()), Long.valueOf(milestone.getTargetProgress())) && Objects.equal(Integer.valueOf(milestone2.getState()), Integer.valueOf(milestone.getState())) && Objects.equal(milestone2.getEventId(), milestone.getEventId());
    }

    public final String toString() {
        return zzb(this);
    }

    static String zzb(Milestone milestone) {
        return Objects.toStringHelper(milestone).add("MilestoneId", milestone.getMilestoneId()).add("CurrentProgress", Long.valueOf(milestone.getCurrentProgress())).add("TargetProgress", Long.valueOf(milestone.getTargetProgress())).add("State", Integer.valueOf(milestone.getState())).add("CompletionRewardData", milestone.getCompletionRewardData()).add("EventId", milestone.getEventId()).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getMilestoneId(), false);
        SafeParcelWriter.writeLong(parcel, 2, getCurrentProgress());
        SafeParcelWriter.writeLong(parcel, 3, getTargetProgress());
        SafeParcelWriter.writeByteArray(parcel, 4, getCompletionRewardData(), false);
        SafeParcelWriter.writeInt(parcel, 5, getState());
        SafeParcelWriter.writeString(parcel, 6, getEventId(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

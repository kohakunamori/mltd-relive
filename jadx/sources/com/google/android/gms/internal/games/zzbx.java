package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.quest.QuestBuffer;
import com.google.android.gms.games.quest.Quests;

/* JADX INFO: loaded from: classes.dex */
final class zzbx implements Quests.LoadQuestsResult {
    private final /* synthetic */ Status zzbd;

    zzbx(zzbw zzbwVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.common.api.Releasable
    public final void release() {
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }

    @Override // com.google.android.gms.games.quest.Quests.LoadQuestsResult
    public final QuestBuffer getQuests() {
        return new QuestBuffer(DataHolder.empty(this.zzbd.getStatusCode()));
    }
}

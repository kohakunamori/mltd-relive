package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.quest.Quest;
import com.google.android.gms.games.quest.Quests;

/* JADX INFO: loaded from: classes.dex */
final class zzbt implements Quests.AcceptQuestResult {
    private final /* synthetic */ Status zzbd;

    zzbt(zzbs zzbsVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.games.quest.Quests.AcceptQuestResult
    public final Quest getQuest() {
        return null;
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }
}

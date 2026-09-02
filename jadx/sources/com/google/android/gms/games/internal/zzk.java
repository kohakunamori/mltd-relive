package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.quest.Quests;

/* JADX INFO: loaded from: classes.dex */
final class zzk extends zze.zzat<Quests.AcceptQuestResult> {
    zzk(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zzaj(DataHolder dataHolder) {
        setResult(new zze.zza(dataHolder));
    }
}

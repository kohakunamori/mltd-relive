package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.quest.Quests;

/* JADX INFO: loaded from: classes.dex */
final class zzl extends zze.zzat<Quests.ClaimMilestoneResult> {
    private final /* synthetic */ String zzha;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzl(BaseImplementation.ResultHolder resultHolder, String str) {
        super(resultHolder);
        this.zzha = str;
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zzai(DataHolder dataHolder) {
        setResult(new zze.zzg(dataHolder, this.zzha));
    }
}

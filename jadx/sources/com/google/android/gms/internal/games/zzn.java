package com.google.android.gms.internal.games;

import android.os.RemoteException;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.games.achievement.Achievements;

/* JADX INFO: loaded from: classes.dex */
final class zzn extends zzq {
    private final /* synthetic */ String val$id;
    private final /* synthetic */ int zzka;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzn(zze zzeVar, String str, GoogleApiClient googleApiClient, String str2, int i) {
        super(str, googleApiClient);
        this.val$id = str2;
        this.zzka = i;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ApiMethodImpl
    public final /* synthetic */ void doExecute(Api.AnyClient anyClient) throws RemoteException {
        ((com.google.android.gms.games.internal.zze) anyClient).zzb((BaseImplementation.ResultHolder<Achievements.UpdateAchievementResult>) null, this.val$id, this.zzka);
    }
}

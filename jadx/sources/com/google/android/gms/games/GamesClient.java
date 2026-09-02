package com.google.android.gms.games;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresPermission;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public class GamesClient extends com.google.android.gms.internal.games.zzt {
    GamesClient(@NonNull Context context, @NonNull Games.GamesOptions gamesOptions) {
        super(context, gamesOptions);
    }

    GamesClient(@NonNull Activity activity, @NonNull Games.GamesOptions gamesOptions) {
        super(activity, gamesOptions);
    }

    public Task<Void> setGravityForPopups(int i) {
        return doWrite(new zzn(this, i));
    }

    public Task<Void> setViewForPopups(@NonNull View view) {
        return doWrite(new zzo(this, view));
    }

    @RequiresPermission("android.permission.GET_ACCOUNTS")
    public Task<String> getCurrentAccountName() {
        return doRead(new zzp(this));
    }

    public Task<String> getAppId() {
        return doRead(new zzq(this));
    }

    public Task<Intent> getSettingsIntent() {
        return doRead(new zzr(this));
    }

    public Task<Bundle> getActivationHint() {
        return doRead(new zzs(this));
    }

    @KeepForSdk
    public Task<Integer> getSdkVariant() {
        return doRead(new zzt(this));
    }
}

package com.google.android.gms.games;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import androidx.annotation.IntRange;
import androidx.annotation.NonNull;
import com.google.android.gms.common.api.PendingResult;
import com.google.android.gms.common.internal.PendingResultUtil;
import com.google.android.gms.games.achievement.AchievementBuffer;
import com.google.android.gms.games.achievement.Achievements;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public class AchievementsClient extends com.google.android.gms.internal.games.zzt {
    private static final PendingResultUtil.ResultConverter<Achievements.LoadAchievementsResult, AchievementBuffer> zze = new zzb();
    private static final PendingResultUtil.ResultConverter<Achievements.UpdateAchievementResult, Void> zzf = new zzc();
    private static final PendingResultUtil.ResultConverter<Achievements.UpdateAchievementResult, Boolean> zzg = new zzd();
    private static final com.google.android.gms.games.internal.zzbn zzh = new zze();

    AchievementsClient(@NonNull Context context, @NonNull Games.GamesOptions gamesOptions) {
        super(context, gamesOptions);
    }

    AchievementsClient(@NonNull Activity activity, @NonNull Games.GamesOptions gamesOptions) {
        super(activity, gamesOptions);
    }

    public Task<Intent> getAchievementsIntent() {
        return doRead(new zza(this));
    }

    public Task<AnnotatedData<AchievementBuffer>> load(boolean z) {
        return com.google.android.gms.games.internal.zzbe.zzb(Games.Achievements.load(asGoogleApiClient(), z), zze);
    }

    public void reveal(@NonNull String str) {
        Games.Achievements.reveal(asGoogleApiClient(), str);
    }

    public Task<Void> revealImmediate(@NonNull String str) {
        return zza(Games.Achievements.revealImmediate(asGoogleApiClient(), str));
    }

    public void unlock(@NonNull String str) {
        Games.Achievements.unlock(asGoogleApiClient(), str);
    }

    public Task<Void> unlockImmediate(@NonNull String str) {
        return zza(Games.Achievements.unlockImmediate(asGoogleApiClient(), str));
    }

    public void increment(@NonNull String str, @IntRange(from = 0) int i) {
        Games.Achievements.increment(asGoogleApiClient(), str, i);
    }

    public Task<Boolean> incrementImmediate(@NonNull String str, @IntRange(from = 0) int i) {
        return zzb(Games.Achievements.incrementImmediate(asGoogleApiClient(), str, i));
    }

    public void setSteps(@NonNull String str, @IntRange(from = 0) int i) {
        Games.Achievements.setSteps(asGoogleApiClient(), str, i);
    }

    public Task<Boolean> setStepsImmediate(@NonNull String str, @IntRange(from = 0) int i) {
        return zzb(Games.Achievements.setStepsImmediate(asGoogleApiClient(), str, i));
    }

    private static Task<Void> zza(@NonNull PendingResult<Achievements.UpdateAchievementResult> pendingResult) {
        return com.google.android.gms.games.internal.zzbe.zza(pendingResult, zzh, zzf);
    }

    private static Task<Boolean> zzb(@NonNull PendingResult<Achievements.UpdateAchievementResult> pendingResult) {
        return com.google.android.gms.games.internal.zzbe.zza(pendingResult, zzh, zzg);
    }
}

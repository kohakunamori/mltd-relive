package com.google.android.gms.games;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import androidx.annotation.IntRange;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.gms.common.api.ApiException;
import com.google.android.gms.common.api.PendingResult;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.common.api.internal.ListenerHolders;
import com.google.android.gms.common.internal.PendingResultUtil;
import com.google.android.gms.games.multiplayer.ParticipantResult;
import com.google.android.gms.games.multiplayer.turnbased.LoadMatchesResponse;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchConfig;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchUpdateCallback;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer;
import com.google.android.gms.tasks.Task;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class TurnBasedMultiplayerClient extends com.google.android.gms.internal.games.zzt {
    private static final com.google.android.gms.games.internal.zzbl<TurnBasedMatch> zzen = new zzcv();
    private static final PendingResultUtil.ResultConverter<TurnBasedMultiplayer.LoadMatchesResult, LoadMatchesResponse> zzeo = new zzce();
    private static final com.google.android.gms.games.internal.zzbm<TurnBasedMultiplayer.LoadMatchesResult> zzep = new zzcf();
    private static final PendingResultUtil.ResultConverter<TurnBasedMultiplayer.LoadMatchResult, TurnBasedMatch> zzeq = new zzcg();
    private static final PendingResultUtil.ResultConverter<TurnBasedMultiplayer.CancelMatchResult, String> zzer = new zzch();
    private static final com.google.android.gms.games.internal.zzbn zzes = new zzci();
    private static final PendingResultUtil.ResultConverter<TurnBasedMultiplayer.LeaveMatchResult, Void> zzet = new zzcj();
    private static final PendingResultUtil.ResultConverter<TurnBasedMultiplayer.LeaveMatchResult, TurnBasedMatch> zzeu = new zzck();
    private static final com.google.android.gms.games.internal.zzbn zzev = new zzcl();
    private static final PendingResultUtil.ResultConverter<TurnBasedMultiplayer.UpdateMatchResult, TurnBasedMatch> zzew = new zzcm();
    private static final PendingResultUtil.ResultConverter<TurnBasedMultiplayer.InitiateMatchResult, TurnBasedMatch> zzex = new zzcn();

    TurnBasedMultiplayerClient(@NonNull Context context, @NonNull Games.GamesOptions gamesOptions) {
        super(context, gamesOptions);
    }

    public static class MatchOutOfDateApiException extends ApiException {
        protected final TurnBasedMatch match;

        MatchOutOfDateApiException(@NonNull Status status, @NonNull TurnBasedMatch turnBasedMatch) {
            super(status);
            this.match = turnBasedMatch;
        }

        public TurnBasedMatch getMatch() {
            return this.match;
        }
    }

    TurnBasedMultiplayerClient(@NonNull Activity activity, @NonNull Games.GamesOptions gamesOptions) {
        super(activity, gamesOptions);
    }

    public Task<Intent> getInboxIntent() {
        return doRead(new zzcd(this));
    }

    public Task<Void> registerTurnBasedMatchUpdateCallback(@NonNull TurnBasedMatchUpdateCallback turnBasedMatchUpdateCallback) {
        ListenerHolder<L> listenerHolderRegisterListener = registerListener(turnBasedMatchUpdateCallback, TurnBasedMatchUpdateCallback.class.getSimpleName());
        return doRegisterEventListener(new zzco(this, listenerHolderRegisterListener, listenerHolderRegisterListener), new zzcp(this, listenerHolderRegisterListener.getListenerKey()));
    }

    public Task<Boolean> unregisterTurnBasedMatchUpdateCallback(@NonNull TurnBasedMatchUpdateCallback turnBasedMatchUpdateCallback) {
        return doUnregisterEventListener(ListenerHolders.createListenerKey(turnBasedMatchUpdateCallback, TurnBasedMatchUpdateCallback.class.getSimpleName()));
    }

    public Task<Intent> getSelectOpponentsIntent(@IntRange(from = 1) int i, @IntRange(from = 1) int i2) {
        return getSelectOpponentsIntent(i, i2, true);
    }

    public Task<Intent> getSelectOpponentsIntent(@IntRange(from = 1) int i, @IntRange(from = 1) int i2, boolean z) {
        return doRead(new zzcq(this, i, i2, z));
    }

    public Task<TurnBasedMatch> createMatch(@NonNull TurnBasedMatchConfig turnBasedMatchConfig) {
        return com.google.android.gms.games.internal.zzbe.toTask(Games.TurnBasedMultiplayer.createMatch(asGoogleApiClient(), turnBasedMatchConfig), zzex);
    }

    public Task<TurnBasedMatch> rematch(@NonNull String str) {
        return com.google.android.gms.games.internal.zzbe.toTask(Games.TurnBasedMultiplayer.rematch(asGoogleApiClient(), str), zzex);
    }

    public Task<TurnBasedMatch> acceptInvitation(@NonNull String str) {
        return com.google.android.gms.games.internal.zzbe.toTask(Games.TurnBasedMultiplayer.acceptInvitation(asGoogleApiClient(), str), zzex);
    }

    public Task<Void> declineInvitation(@NonNull String str) {
        return doWrite(new zzcr(this, str));
    }

    public Task<Void> dismissInvitation(@NonNull String str) {
        return doWrite(new zzcs(this, str));
    }

    public Task<Integer> getMaxMatchDataSize() {
        return doRead(new zzct(this));
    }

    public Task<TurnBasedMatch> takeTurn(@NonNull String str, @Nullable byte[] bArr, @Nullable String str2) {
        return zze(Games.TurnBasedMultiplayer.takeTurn(asGoogleApiClient(), str, bArr, str2));
    }

    public Task<TurnBasedMatch> takeTurn(@NonNull String str, @Nullable byte[] bArr, @Nullable String str2, @Nullable ParticipantResult... participantResultArr) {
        return zze(Games.TurnBasedMultiplayer.takeTurn(asGoogleApiClient(), str, bArr, str2, participantResultArr));
    }

    public Task<TurnBasedMatch> takeTurn(@NonNull String str, @Nullable byte[] bArr, @Nullable String str2, @Nullable List<ParticipantResult> list) {
        return zze(Games.TurnBasedMultiplayer.takeTurn(asGoogleApiClient(), str, bArr, str2, list));
    }

    public Task<TurnBasedMatch> finishMatch(@NonNull String str) {
        return zze(Games.TurnBasedMultiplayer.finishMatch(asGoogleApiClient(), str));
    }

    public Task<TurnBasedMatch> finishMatch(@NonNull String str, @Nullable byte[] bArr, @Nullable ParticipantResult... participantResultArr) {
        return zze(Games.TurnBasedMultiplayer.finishMatch(asGoogleApiClient(), str, bArr, participantResultArr));
    }

    public Task<TurnBasedMatch> finishMatch(@NonNull String str, @Nullable byte[] bArr, @Nullable List<ParticipantResult> list) {
        return zze(Games.TurnBasedMultiplayer.finishMatch(asGoogleApiClient(), str, bArr, list));
    }

    public Task<Void> leaveMatch(@NonNull String str) {
        return zzd(Games.TurnBasedMultiplayer.leaveMatch(asGoogleApiClient(), str));
    }

    public Task<Void> leaveMatchDuringTurn(@NonNull String str, @Nullable String str2) {
        return zzd(Games.TurnBasedMultiplayer.leaveMatchDuringTurn(asGoogleApiClient(), str, str2));
    }

    public Task<String> cancelMatch(@NonNull String str) {
        return com.google.android.gms.games.internal.zzbe.toTask(Games.TurnBasedMultiplayer.cancelMatch(asGoogleApiClient(), str), zzer);
    }

    public Task<Void> dismissMatch(@NonNull String str) {
        return doWrite(new zzcu(this, str));
    }

    public Task<AnnotatedData<LoadMatchesResponse>> loadMatchesByStatus(@NonNull int[] iArr) {
        return com.google.android.gms.games.internal.zzbe.zza(Games.TurnBasedMultiplayer.loadMatchesByStatus(asGoogleApiClient(), iArr), zzeo, zzep);
    }

    public Task<AnnotatedData<LoadMatchesResponse>> loadMatchesByStatus(int i, @NonNull int[] iArr) {
        return com.google.android.gms.games.internal.zzbe.zza(Games.TurnBasedMultiplayer.loadMatchesByStatus(asGoogleApiClient(), i, iArr), zzeo, zzep);
    }

    public Task<AnnotatedData<TurnBasedMatch>> loadMatch(@NonNull String str) {
        return com.google.android.gms.games.internal.zzbe.zza(Games.TurnBasedMultiplayer.loadMatch(asGoogleApiClient(), str), zzeq);
    }

    private static Task<Void> zzd(@NonNull PendingResult<TurnBasedMultiplayer.LeaveMatchResult> pendingResult) {
        return com.google.android.gms.games.internal.zzbe.zza(pendingResult, zzes, zzet, zzeu, zzen);
    }

    private static Task<TurnBasedMatch> zze(@NonNull PendingResult<TurnBasedMultiplayer.UpdateMatchResult> pendingResult) {
        return com.google.android.gms.games.internal.zzbe.zza(pendingResult, zzev, zzew, zzew, zzen);
    }
}

package com.google.android.gms.games;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import androidx.annotation.NonNull;
import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.common.api.internal.ListenerHolders;
import com.google.android.gms.common.internal.PendingResultUtil;
import com.google.android.gms.games.video.CaptureState;
import com.google.android.gms.games.video.VideoCapabilities;
import com.google.android.gms.games.video.Videos;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public class VideosClient extends com.google.android.gms.internal.games.zzt {
    public static final int CAPTURE_OVERLAY_STATE_CAPTURE_STARTED = 2;
    public static final int CAPTURE_OVERLAY_STATE_CAPTURE_STOPPED = 3;
    public static final int CAPTURE_OVERLAY_STATE_DISMISSED = 4;
    public static final int CAPTURE_OVERLAY_STATE_SHOWN = 1;
    private static final PendingResultUtil.ResultConverter<Videos.CaptureAvailableResult, Boolean> zzez = new zzda();
    private static final PendingResultUtil.ResultConverter<Videos.CaptureStateResult, CaptureState> zzfa = new zzdb();
    private static final PendingResultUtil.ResultConverter<Videos.CaptureCapabilitiesResult, VideoCapabilities> zzfb = new zzdc();

    public interface OnCaptureOverlayStateListener extends Videos.CaptureOverlayStateListener {
        @Override // com.google.android.gms.games.video.Videos.CaptureOverlayStateListener
        void onCaptureOverlayStateChanged(int i);
    }

    VideosClient(@NonNull Context context, @NonNull Games.GamesOptions gamesOptions) {
        super(context, gamesOptions);
    }

    VideosClient(@NonNull Activity activity, @NonNull Games.GamesOptions gamesOptions) {
        super(activity, gamesOptions);
    }

    public Task<VideoCapabilities> getCaptureCapabilities() {
        return com.google.android.gms.games.internal.zzbe.toTask(Games.Videos.getCaptureCapabilities(asGoogleApiClient()), zzfb);
    }

    public Task<Intent> getCaptureOverlayIntent() {
        return doRead(new zzcw(this));
    }

    public Task<CaptureState> getCaptureState() {
        return com.google.android.gms.games.internal.zzbe.toTask(Games.Videos.getCaptureState(asGoogleApiClient()), zzfa);
    }

    public Task<Boolean> isCaptureAvailable(int i) {
        return com.google.android.gms.games.internal.zzbe.toTask(Games.Videos.isCaptureAvailable(asGoogleApiClient(), i), zzez);
    }

    public Task<Boolean> isCaptureSupported() {
        return doRead(new zzcx(this));
    }

    public Task<Void> registerOnCaptureOverlayStateChangedListener(@NonNull OnCaptureOverlayStateListener onCaptureOverlayStateListener) {
        ListenerHolder<L> listenerHolderRegisterListener = registerListener(onCaptureOverlayStateListener, OnCaptureOverlayStateListener.class.getSimpleName());
        return doRegisterEventListener(new zzcy(this, listenerHolderRegisterListener, listenerHolderRegisterListener), new zzcz(this, listenerHolderRegisterListener.getListenerKey()));
    }

    public Task<Boolean> unregisterOnCaptureOverlayStateChangedListener(@NonNull OnCaptureOverlayStateListener onCaptureOverlayStateListener) {
        return doUnregisterEventListener(ListenerHolders.createListenerKey(onCaptureOverlayStateListener, OnCaptureOverlayStateListener.class.getSimpleName()));
    }
}

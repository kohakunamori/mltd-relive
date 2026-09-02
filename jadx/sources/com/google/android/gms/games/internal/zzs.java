package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.games.video.Videos;

/* JADX INFO: loaded from: classes.dex */
final class zzs extends zze.zzu<Videos.CaptureOverlayStateListener> {
    zzs(ListenerHolder listenerHolder) {
        super(listenerHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void onCaptureOverlayStateChanged(final int i) {
        zzc(new zze.zzap(i) { // from class: com.google.android.gms.games.internal.zzt
            private final int zzhc;

            {
                this.zzhc = i;
            }

            @Override // com.google.android.gms.games.internal.zze.zzap
            public final void accept(Object obj) {
                ((Videos.CaptureOverlayStateListener) obj).onCaptureOverlayStateChanged(this.zzhc);
            }
        });
    }
}

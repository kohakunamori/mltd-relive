package com.google.android.gms.games;

import android.app.Activity;
import android.content.Context;
import androidx.annotation.NonNull;
import com.google.android.gms.common.internal.PendingResultUtil;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public class GamesMetadataClient extends com.google.android.gms.internal.games.zzt {
    private static final PendingResultUtil.ResultConverter<GamesMetadata.LoadGamesResult, Game> zzbg = new zzv();
    private static final com.google.android.gms.games.internal.zzbm<GamesMetadata.LoadGamesResult> zzbh = new zzw();

    GamesMetadataClient(@NonNull Context context, @NonNull Games.GamesOptions gamesOptions) {
        super(context, gamesOptions);
    }

    GamesMetadataClient(@NonNull Activity activity, @NonNull Games.GamesOptions gamesOptions) {
        super(activity, gamesOptions);
    }

    public Task<Game> getCurrentGame() {
        return doRead(new zzu(this));
    }

    public Task<AnnotatedData<Game>> loadGame() {
        return com.google.android.gms.games.internal.zzbe.zza(Games.GamesMetadata.loadGame(asGoogleApiClient()), zzbg, zzbh);
    }
}

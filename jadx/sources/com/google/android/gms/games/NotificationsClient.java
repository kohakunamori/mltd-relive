package com.google.android.gms.games;

import android.app.Activity;
import android.content.Context;
import androidx.annotation.NonNull;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public class NotificationsClient extends com.google.android.gms.internal.games.zzt {
    public static final int NOTIFICATION_TYPES_ALL = 19;
    public static final int NOTIFICATION_TYPES_MULTIPLAYER = 3;
    public static final int NOTIFICATION_TYPE_INVITATION = 1;
    public static final int NOTIFICATION_TYPE_LEVEL_UP = 16;
    public static final int NOTIFICATION_TYPE_MATCH_UPDATE = 2;

    NotificationsClient(@NonNull Context context, @NonNull Games.GamesOptions gamesOptions) {
        super(context, gamesOptions);
    }

    NotificationsClient(@NonNull Activity activity, @NonNull Games.GamesOptions gamesOptions) {
        super(activity, gamesOptions);
    }

    public Task<Void> clearAll() {
        return clear(19);
    }

    public Task<Void> clear(int i) {
        return doWrite(new zzao(this, i));
    }
}

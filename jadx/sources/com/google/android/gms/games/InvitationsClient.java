package com.google.android.gms.games;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import androidx.annotation.NonNull;
import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.common.api.internal.ListenerHolders;
import com.google.android.gms.common.internal.PendingResultUtil;
import com.google.android.gms.games.multiplayer.InvitationBuffer;
import com.google.android.gms.games.multiplayer.InvitationCallback;
import com.google.android.gms.games.multiplayer.Invitations;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public class InvitationsClient extends com.google.android.gms.internal.games.zzt {
    private static final PendingResultUtil.ResultConverter<Invitations.LoadInvitationsResult, InvitationBuffer> zzbi = new zzaa();

    InvitationsClient(@NonNull Context context, @NonNull Games.GamesOptions gamesOptions) {
        super(context, gamesOptions);
    }

    InvitationsClient(@NonNull Activity activity, @NonNull Games.GamesOptions gamesOptions) {
        super(activity, gamesOptions);
    }

    public Task<Intent> getInvitationInboxIntent() {
        return doRead(new zzx(this));
    }

    public Task<Void> registerInvitationCallback(@NonNull InvitationCallback invitationCallback) {
        ListenerHolder<L> listenerHolderRegisterListener = registerListener(invitationCallback, InvitationCallback.class.getSimpleName());
        return doRegisterEventListener(new zzy(this, listenerHolderRegisterListener, listenerHolderRegisterListener), new zzz(this, listenerHolderRegisterListener.getListenerKey()));
    }

    public Task<Boolean> unregisterInvitationCallback(@NonNull InvitationCallback invitationCallback) {
        return doUnregisterEventListener(ListenerHolders.createListenerKey(invitationCallback, InvitationCallback.class.getSimpleName()));
    }

    public Task<AnnotatedData<InvitationBuffer>> loadInvitations() {
        return loadInvitations(0);
    }

    public Task<AnnotatedData<InvitationBuffer>> loadInvitations(int i) {
        return com.google.android.gms.games.internal.zzbe.zzb(Games.Invitations.loadInvitations(asGoogleApiClient(), i), zzbi);
    }
}

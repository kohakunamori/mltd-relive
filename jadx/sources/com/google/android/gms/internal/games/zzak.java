package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.multiplayer.InvitationBuffer;
import com.google.android.gms.games.multiplayer.Invitations;

/* JADX INFO: loaded from: classes.dex */
final class zzak implements Invitations.LoadInvitationsResult {
    private final /* synthetic */ Status zzbd;

    zzak(zzaj zzajVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.common.api.Releasable
    public final void release() {
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }

    @Override // com.google.android.gms.games.multiplayer.Invitations.LoadInvitationsResult
    public final InvitationBuffer getInvitations() {
        return new InvitationBuffer(DataHolder.empty(14));
    }
}

package com.google.android.gms.games.multiplayer.turnbased;

import android.os.Bundle;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.internal.zzbd;
import com.google.android.gms.games.multiplayer.InvitationBuffer;

/* JADX INFO: loaded from: classes.dex */
public final class LoadMatchesResponse {
    private final InvitationBuffer zzqh;
    private final TurnBasedMatchBuffer zzqi;
    private final TurnBasedMatchBuffer zzqj;
    private final TurnBasedMatchBuffer zzqk;

    public LoadMatchesResponse(Bundle bundle) {
        DataHolder dataHolderZza = zza(bundle, 0);
        if (dataHolderZza != null) {
            this.zzqh = new InvitationBuffer(dataHolderZza);
        } else {
            this.zzqh = null;
        }
        DataHolder dataHolderZza2 = zza(bundle, 1);
        if (dataHolderZza2 != null) {
            this.zzqi = new TurnBasedMatchBuffer(dataHolderZza2);
        } else {
            this.zzqi = null;
        }
        DataHolder dataHolderZza3 = zza(bundle, 2);
        if (dataHolderZza3 != null) {
            this.zzqj = new TurnBasedMatchBuffer(dataHolderZza3);
        } else {
            this.zzqj = null;
        }
        DataHolder dataHolderZza4 = zza(bundle, 3);
        if (dataHolderZza4 != null) {
            this.zzqk = new TurnBasedMatchBuffer(dataHolderZza4);
        } else {
            this.zzqk = null;
        }
    }

    private static DataHolder zza(Bundle bundle, int i) {
        String str;
        switch (i) {
            case 0:
                str = "TURN_STATUS_INVITED";
                break;
            case 1:
                str = "TURN_STATUS_MY_TURN";
                break;
            case 2:
                str = "TURN_STATUS_THEIR_TURN";
                break;
            case 3:
                str = "TURN_STATUS_COMPLETE";
                break;
            default:
                StringBuilder sb = new StringBuilder(38);
                sb.append("Unknown match turn status: ");
                sb.append(i);
                zzbd.m36e("MatchTurnStatus", sb.toString());
                str = "TURN_STATUS_UNKNOWN";
                break;
        }
        if (bundle.containsKey(str)) {
            return (DataHolder) bundle.getParcelable(str);
        }
        return null;
    }

    public final InvitationBuffer getInvitations() {
        return this.zzqh;
    }

    public final TurnBasedMatchBuffer getMyTurnMatches() {
        return this.zzqi;
    }

    public final TurnBasedMatchBuffer getTheirTurnMatches() {
        return this.zzqj;
    }

    public final TurnBasedMatchBuffer getCompletedMatches() {
        return this.zzqk;
    }

    @Deprecated
    public final void close() {
        release();
    }

    public final void release() {
        if (this.zzqh != null) {
            this.zzqh.release();
        }
        if (this.zzqi != null) {
            this.zzqi.release();
        }
        if (this.zzqj != null) {
            this.zzqj.release();
        }
        if (this.zzqk != null) {
            this.zzqk.release();
        }
    }

    public final boolean hasData() {
        if (this.zzqh != null && this.zzqh.getCount() > 0) {
            return true;
        }
        if (this.zzqi != null && this.zzqi.getCount() > 0) {
            return true;
        }
        if (this.zzqj == null || this.zzqj.getCount() <= 0) {
            return this.zzqk != null && this.zzqk.getCount() > 0;
        }
        return true;
    }
}

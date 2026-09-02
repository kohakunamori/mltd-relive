package com.google.android.gms.games.multiplayer.turnbased;

import android.os.Bundle;

/* JADX INFO: loaded from: classes.dex */
public final class zzb extends TurnBasedMatchConfig {
    private final int zzpd;
    private final Bundle zzpz;
    private final String[] zzqb;
    private final int zzql;

    zzb(TurnBasedMatchConfig.Builder builder) {
        this.zzpd = builder.zzpd;
        this.zzql = builder.zzql;
        this.zzpz = builder.zzpz;
        this.zzqb = (String[]) builder.zzpy.toArray(new String[builder.zzpy.size()]);
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchConfig
    public final int getVariant() {
        return this.zzpd;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchConfig
    public final int zzdp() {
        return this.zzql;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchConfig
    public final String[] getInvitedPlayerIds() {
        return this.zzqb;
    }

    @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchConfig
    public final Bundle getAutoMatchCriteria() {
        return this.zzpz;
    }
}

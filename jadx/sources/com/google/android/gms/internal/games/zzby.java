package com.google.android.gms.internal.games;

import android.content.Intent;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.multiplayer.realtime.RealTimeMessageReceivedListener;
import com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer;
import com.google.android.gms.games.multiplayer.realtime.Room;
import com.google.android.gms.games.multiplayer.realtime.RoomConfig;
import com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener;
import com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class zzby implements RealTimeMultiplayer {
    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final Intent getWaitingRoomIntent(GoogleApiClient googleApiClient, Room room, int i) {
        return Games.zza(googleApiClient).zzb(room, i);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final Intent getSelectOpponentsIntent(GoogleApiClient googleApiClient, int i, int i2) {
        return Games.zza(googleApiClient).zzd(i, i2, true);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final Intent getSelectOpponentsIntent(GoogleApiClient googleApiClient, int i, int i2, boolean z) {
        return Games.zza(googleApiClient).zzd(i, i2, z);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final void create(GoogleApiClient googleApiClient, RoomConfig roomConfig) {
        com.google.android.gms.games.internal.zze zzeVarZza = Games.zza(googleApiClient, false);
        if (zzeVarZza == null) {
            return;
        }
        zzeVarZza.zzb(zza(googleApiClient, roomConfig), zzb(googleApiClient, roomConfig), zzc(googleApiClient, roomConfig), roomConfig);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final void join(GoogleApiClient googleApiClient, RoomConfig roomConfig) {
        com.google.android.gms.games.internal.zze zzeVarZza = Games.zza(googleApiClient, false);
        if (zzeVarZza == null) {
            return;
        }
        zzeVarZza.zzd(zza(googleApiClient, roomConfig), zzb(googleApiClient, roomConfig), zzc(googleApiClient, roomConfig), roomConfig);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final void leave(GoogleApiClient googleApiClient, RoomUpdateListener roomUpdateListener, String str) {
        com.google.android.gms.games.internal.zze zzeVarZza = Games.zza(googleApiClient, false);
        if (zzeVarZza != null) {
            zzeVarZza.zza(googleApiClient.registerListener(roomUpdateListener), str);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final int sendReliableMessage(GoogleApiClient googleApiClient, RealTimeMultiplayer.ReliableMessageSentCallback reliableMessageSentCallback, byte[] bArr, String str, String str2) {
        return Games.zza(googleApiClient).zzb(zza(googleApiClient, reliableMessageSentCallback), bArr, str, str2);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final int sendUnreliableMessage(GoogleApiClient googleApiClient, byte[] bArr, String str, String str2) {
        return Games.zza(googleApiClient).zza(bArr, str, new String[]{str2});
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final int sendUnreliableMessage(GoogleApiClient googleApiClient, byte[] bArr, String str, List<String> list) {
        return Games.zza(googleApiClient).zza(bArr, str, (String[]) list.toArray(new String[list.size()]));
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final int sendUnreliableMessageToOthers(GoogleApiClient googleApiClient, byte[] bArr, String str) {
        return Games.zza(googleApiClient).zzb(bArr, str);
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final void declineInvitation(GoogleApiClient googleApiClient, String str) {
        com.google.android.gms.games.internal.zze zzeVarZza = Games.zza(googleApiClient, false);
        if (zzeVarZza != null) {
            zzeVarZza.zze(str, 0);
        }
    }

    @Override // com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
    public final void dismissInvitation(GoogleApiClient googleApiClient, String str) {
        com.google.android.gms.games.internal.zze zzeVarZza = Games.zza(googleApiClient, false);
        if (zzeVarZza != null) {
            zzeVarZza.zzc(str, 0);
        }
    }

    private static <L> ListenerHolder<L> zza(GoogleApiClient googleApiClient, L l) {
        if (l == null) {
            return null;
        }
        return googleApiClient.registerListener(l);
    }

    private static ListenerHolder<RoomUpdateListener> zza(@NonNull GoogleApiClient googleApiClient, @NonNull RoomConfig roomConfig) {
        if (roomConfig.getRoomUpdateCallback() != null) {
            return googleApiClient.registerListener(roomConfig.getRoomUpdateCallback());
        }
        return googleApiClient.registerListener(roomConfig.getRoomUpdateListener());
    }

    @Nullable
    private static ListenerHolder<RoomStatusUpdateListener> zzb(@NonNull GoogleApiClient googleApiClient, @NonNull RoomConfig roomConfig) {
        if (roomConfig.getRoomStatusUpdateCallback() != null) {
            return zza(googleApiClient, roomConfig.getRoomStatusUpdateCallback());
        }
        return zza(googleApiClient, roomConfig.getRoomStatusUpdateListener());
    }

    @Nullable
    private static ListenerHolder<RealTimeMessageReceivedListener> zzc(@NonNull GoogleApiClient googleApiClient, @NonNull RoomConfig roomConfig) {
        if (roomConfig.getOnMessageReceivedListener() != null) {
            return googleApiClient.registerListener(roomConfig.getOnMessageReceivedListener());
        }
        return googleApiClient.registerListener(roomConfig.getMessageReceivedListener());
    }
}

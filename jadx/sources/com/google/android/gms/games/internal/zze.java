package com.google.android.gms.games.internal;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Looper;
import android.os.RemoteException;
import android.view.View;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.FirstPartyScopes;
import com.google.android.gms.common.Scopes;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Scope;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.api.internal.DataHolderResult;
import com.google.android.gms.common.api.internal.ListenerHolder;
import com.google.android.gms.common.data.BitmapTeleporter;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.common.internal.Asserts;
import com.google.android.gms.common.internal.BaseGmsClient;
import com.google.android.gms.common.internal.BinderWrapper;
import com.google.android.gms.common.internal.ClientSettings;
import com.google.android.gms.common.internal.GmsClient;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.ServiceSpecificExtraArgs;
import com.google.android.gms.drive.Contents;
import com.google.android.gms.games.Game;
import com.google.android.gms.games.GameBuffer;
import com.google.android.gms.games.GameEntity;
import com.google.android.gms.games.Games;
import com.google.android.gms.games.GamesClientStatusCodes;
import com.google.android.gms.games.GamesMetadata;
import com.google.android.gms.games.GamesStatusCodes;
import com.google.android.gms.games.Player;
import com.google.android.gms.games.PlayerBuffer;
import com.google.android.gms.games.PlayerEntity;
import com.google.android.gms.games.Players;
import com.google.android.gms.games.achievement.AchievementBuffer;
import com.google.android.gms.games.achievement.Achievements;
import com.google.android.gms.games.event.EventBuffer;
import com.google.android.gms.games.event.Events;
import com.google.android.gms.games.leaderboard.Leaderboard;
import com.google.android.gms.games.leaderboard.LeaderboardBuffer;
import com.google.android.gms.games.leaderboard.LeaderboardEntity;
import com.google.android.gms.games.leaderboard.LeaderboardScore;
import com.google.android.gms.games.leaderboard.LeaderboardScoreBuffer;
import com.google.android.gms.games.leaderboard.LeaderboardScoreEntity;
import com.google.android.gms.games.leaderboard.Leaderboards;
import com.google.android.gms.games.leaderboard.ScoreSubmissionData;
import com.google.android.gms.games.multiplayer.Invitation;
import com.google.android.gms.games.multiplayer.InvitationBuffer;
import com.google.android.gms.games.multiplayer.Invitations;
import com.google.android.gms.games.multiplayer.OnInvitationReceivedListener;
import com.google.android.gms.games.multiplayer.ParticipantResult;
import com.google.android.gms.games.multiplayer.realtime.RealTimeMessage;
import com.google.android.gms.games.multiplayer.realtime.RealTimeMessageReceivedListener;
import com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer;
import com.google.android.gms.games.multiplayer.realtime.Room;
import com.google.android.gms.games.multiplayer.realtime.RoomConfig;
import com.google.android.gms.games.multiplayer.realtime.RoomEntity;
import com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener;
import com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener;
import com.google.android.gms.games.multiplayer.turnbased.LoadMatchesResponse;
import com.google.android.gms.games.multiplayer.turnbased.OnTurnBasedMatchUpdateReceivedListener;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchBuffer;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchConfig;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer;
import com.google.android.gms.games.quest.Milestone;
import com.google.android.gms.games.quest.Quest;
import com.google.android.gms.games.quest.QuestBuffer;
import com.google.android.gms.games.quest.QuestEntity;
import com.google.android.gms.games.quest.QuestUpdateListener;
import com.google.android.gms.games.quest.Quests;
import com.google.android.gms.games.request.GameRequest;
import com.google.android.gms.games.request.GameRequestBuffer;
import com.google.android.gms.games.request.OnRequestReceivedListener;
import com.google.android.gms.games.request.Requests;
import com.google.android.gms.games.snapshot.Snapshot;
import com.google.android.gms.games.snapshot.SnapshotContents;
import com.google.android.gms.games.snapshot.SnapshotContentsEntity;
import com.google.android.gms.games.snapshot.SnapshotEntity;
import com.google.android.gms.games.snapshot.SnapshotMetadata;
import com.google.android.gms.games.snapshot.SnapshotMetadataBuffer;
import com.google.android.gms.games.snapshot.SnapshotMetadataChange;
import com.google.android.gms.games.snapshot.SnapshotMetadataChangeEntity;
import com.google.android.gms.games.snapshot.SnapshotMetadataEntity;
import com.google.android.gms.games.snapshot.Snapshots;
import com.google.android.gms.games.stats.PlayerStats;
import com.google.android.gms.games.stats.PlayerStatsBuffer;
import com.google.android.gms.games.stats.PlayerStatsEntity;
import com.google.android.gms.games.stats.Stats;
import com.google.android.gms.games.video.CaptureState;
import com.google.android.gms.games.video.VideoCapabilities;
import com.google.android.gms.games.video.Videos;
import com.google.android.gms.internal.games.zzeh;
import com.google.android.gms.internal.games.zzej;
import com.google.android.gms.internal.games.zzek;
import com.google.android.gms.signin.internal.SignInClientImpl;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
public class zze extends GmsClient<zzbu> {
    private final zzej zzgo;
    private final String zzgp;
    private PlayerEntity zzgq;
    private GameEntity zzgr;
    private final zzby zzgs;
    private boolean zzgt;
    private final Binder zzgu;
    private final long zzgv;
    private boolean zzgw;
    private final Games.GamesOptions zzgx;
    private Bundle zzgy;

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzaa extends zzbd implements TurnBasedMultiplayer.LoadMatchResult {
        zzaa(DataHolder dataHolder) {
            super(dataHolder);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    interface zzap<T> {
        void accept(T t);
    }

    /* JADX INFO: Access modifiers changed from: private */
    interface zzav<T> {
        void zza(T t, Room room, ArrayList<String> arrayList);
    }

    /* JADX INFO: Access modifiers changed from: private */
    interface zzaw<T> {
        void zza(T t, Room room);
    }

    /* JADX INFO: Access modifiers changed from: private */
    interface zzaz<T> {
        void zza(T t, int i, Room room);
    }

    private static final class zzbh extends zzbd implements TurnBasedMultiplayer.UpdateMatchResult {
        zzbh(DataHolder dataHolder) {
            super(dataHolder);
        }
    }

    private static abstract class zzl extends DataHolderResult {
        zzl(DataHolder dataHolder) {
            super(dataHolder, GamesStatusCodes.zza(dataHolder.getStatusCode()));
        }
    }

    private static final class zzn extends zzbd implements TurnBasedMultiplayer.InitiateMatchResult {
        zzn(DataHolder dataHolder) {
            super(dataHolder);
        }
    }

    private static final class zzt extends zzbd implements TurnBasedMultiplayer.LeaveMatchResult {
        zzt(DataHolder dataHolder) {
            super(dataHolder);
        }
    }

    public zze(Context context, Looper looper, ClientSettings clientSettings, Games.GamesOptions gamesOptions, GoogleApiClient.ConnectionCallbacks connectionCallbacks, GoogleApiClient.OnConnectionFailedListener onConnectionFailedListener) {
        super(context, looper, 1, clientSettings, connectionCallbacks, onConnectionFailedListener);
        this.zzgo = new com.google.android.gms.games.internal.zzf(this);
        this.zzgt = false;
        this.zzgw = false;
        this.zzgp = clientSettings.getRealClientPackageName();
        this.zzgu = new Binder();
        this.zzgs = zzby.zza(this, clientSettings.getGravityForPopups());
        this.zzgv = hashCode();
        this.zzgx = gamesOptions;
        if (this.zzgx.zzaz) {
            return;
        }
        if (clientSettings.getViewForPopups() != null || (context instanceof Activity)) {
            zza(clientSettings.getViewForPopups());
        }
    }

    @Override // com.google.android.gms.common.internal.GmsClient, com.google.android.gms.common.internal.BaseGmsClient, com.google.android.gms.common.api.Api.Client
    public int getMinApkVersion() {
        return 12451000;
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient
    protected String getServiceDescriptor() {
        return "com.google.android.gms.games.internal.IGamesService";
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient
    protected String getStartServiceAction() {
        return "com.google.android.gms.games.service.START";
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient, com.google.android.gms.common.api.Api.Client
    public boolean requiresSignIn() {
        return true;
    }

    private static final class zzaf extends zzl implements Quests.LoadQuestsResult {
        zzaf(DataHolder dataHolder) {
            super(dataHolder);
        }

        @Override // com.google.android.gms.games.quest.Quests.LoadQuestsResult
        public final QuestBuffer getQuests() {
            return new QuestBuffer(this.mDataHolder);
        }
    }

    private static final class zzai extends zzl implements Snapshots.LoadSnapshotsResult {
        zzai(DataHolder dataHolder) {
            super(dataHolder);
        }

        @Override // com.google.android.gms.games.snapshot.Snapshots.LoadSnapshotsResult
        public final SnapshotMetadataBuffer getSnapshots() {
            return new SnapshotMetadataBuffer(this.mDataHolder);
        }
    }

    private static final class zzaj extends zzu<OnTurnBasedMatchUpdateReceivedListener> {
        zzaj(ListenerHolder<OnTurnBasedMatchUpdateReceivedListener> listenerHolder) {
            super(listenerHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzr(DataHolder dataHolder) {
            TurnBasedMatchBuffer turnBasedMatchBuffer = new TurnBasedMatchBuffer(dataHolder);
            try {
                final TurnBasedMatch turnBasedMatchFreeze = turnBasedMatchBuffer.getCount() > 0 ? turnBasedMatchBuffer.get(0).freeze() : null;
                turnBasedMatchBuffer.release();
                if (turnBasedMatchFreeze != null) {
                    zzc(new zzap(turnBasedMatchFreeze) { // from class: com.google.android.gms.games.internal.zzag
                        private final TurnBasedMatch zzij;

                        {
                            this.zzij = turnBasedMatchFreeze;
                        }

                        @Override // com.google.android.gms.games.internal.zze.zzap
                        public final void accept(Object obj) {
                            ((OnTurnBasedMatchUpdateReceivedListener) obj).onTurnBasedMatchReceived(this.zzij);
                        }
                    });
                }
            } catch (Throwable th) {
                turnBasedMatchBuffer.release();
                throw th;
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void onTurnBasedMatchRemoved(final String str) {
            zzc(new zzap(str) { // from class: com.google.android.gms.games.internal.zzah
                private final String zzhv;

                {
                    this.zzhv = str;
                }

                @Override // com.google.android.gms.games.internal.zze.zzap
                public final void accept(Object obj) {
                    ((OnTurnBasedMatchUpdateReceivedListener) obj).onTurnBasedMatchRemoved(this.zzhv);
                }
            });
        }
    }

    private static final class zzak extends zzl implements Snapshots.OpenSnapshotResult {
        private final String zzek;
        private final Snapshot zzik;
        private final Snapshot zzil;
        private final SnapshotContents zzim;

        zzak(DataHolder dataHolder, Contents contents) {
            this(dataHolder, null, contents, null, null);
        }

        zzak(DataHolder dataHolder, String str, Contents contents, Contents contents2, Contents contents3) {
            super(dataHolder);
            SnapshotMetadataBuffer snapshotMetadataBuffer = new SnapshotMetadataBuffer(dataHolder);
            try {
                if (snapshotMetadataBuffer.getCount() == 0) {
                    this.zzik = null;
                    this.zzil = null;
                } else {
                    boolean z = true;
                    if (snapshotMetadataBuffer.getCount() == 1) {
                        if (dataHolder.getStatusCode() == 4004) {
                            z = false;
                        }
                        Asserts.checkState(z);
                        this.zzik = new SnapshotEntity(new SnapshotMetadataEntity((SnapshotMetadata) snapshotMetadataBuffer.get(0)), new SnapshotContentsEntity(contents));
                        this.zzil = null;
                    } else {
                        this.zzik = new SnapshotEntity(new SnapshotMetadataEntity((SnapshotMetadata) snapshotMetadataBuffer.get(0)), new SnapshotContentsEntity(contents));
                        this.zzil = new SnapshotEntity(new SnapshotMetadataEntity((SnapshotMetadata) snapshotMetadataBuffer.get(1)), new SnapshotContentsEntity(contents2));
                    }
                }
                snapshotMetadataBuffer.release();
                this.zzek = str;
                this.zzim = new SnapshotContentsEntity(contents3);
            } catch (Throwable th) {
                snapshotMetadataBuffer.release();
                throw th;
            }
        }

        @Override // com.google.android.gms.games.snapshot.Snapshots.OpenSnapshotResult
        public final Snapshot getSnapshot() {
            return this.zzik;
        }

        @Override // com.google.android.gms.games.snapshot.Snapshots.OpenSnapshotResult
        public final String getConflictId() {
            return this.zzek;
        }

        @Override // com.google.android.gms.games.snapshot.Snapshots.OpenSnapshotResult
        public final Snapshot getConflictingSnapshot() {
            return this.zzil;
        }

        @Override // com.google.android.gms.games.snapshot.Snapshots.OpenSnapshotResult
        public final SnapshotContents getResolutionSnapshotContents() {
            return this.zzim;
        }
    }

    private static final class zzal extends zzat<Players.LoadPlayersResult> {
        zzal(BaseImplementation.ResultHolder<Players.LoadPlayersResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zze(DataHolder dataHolder) {
            setResult(new zzae(dataHolder));
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzf(DataHolder dataHolder) {
            setResult(new zzae(dataHolder));
        }
    }

    private static final class zzam extends zzu<QuestUpdateListener> {
        zzam(ListenerHolder<QuestUpdateListener> listenerHolder) {
            super(listenerHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzak(DataHolder dataHolder) {
            final Quest questZzba = zzba(dataHolder);
            if (questZzba != null) {
                zzc(new zzap(questZzba) { // from class: com.google.android.gms.games.internal.zzai
                    private final Quest zzin;

                    {
                        this.zzin = questZzba;
                    }

                    @Override // com.google.android.gms.games.internal.zze.zzap
                    public final void accept(Object obj) {
                        ((QuestUpdateListener) obj).onQuestCompleted(this.zzin);
                    }
                });
            }
        }

        private static Quest zzba(DataHolder dataHolder) {
            QuestBuffer questBuffer = new QuestBuffer(dataHolder);
            try {
                return questBuffer.getCount() > 0 ? questBuffer.get(0).freeze() : null;
            } finally {
                questBuffer.release();
            }
        }
    }

    private static final class zzan extends zzat<Quests.LoadQuestsResult> {
        zzan(BaseImplementation.ResultHolder<Quests.LoadQuestsResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzam(DataHolder dataHolder) {
            setResult(new zzaf(dataHolder));
        }
    }

    private static final class zzaq extends zzu<OnRequestReceivedListener> {
        zzaq(ListenerHolder<OnRequestReceivedListener> listenerHolder) {
            super(listenerHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzm(DataHolder dataHolder) {
            GameRequestBuffer gameRequestBuffer = new GameRequestBuffer(dataHolder);
            try {
                final GameRequest gameRequestFreeze = gameRequestBuffer.getCount() > 0 ? gameRequestBuffer.get(0).freeze() : null;
                gameRequestBuffer.release();
                if (gameRequestFreeze != null) {
                    zzc(new zzap(gameRequestFreeze) { // from class: com.google.android.gms.games.internal.zzak
                        private final GameRequest zzir;

                        {
                            this.zzir = gameRequestFreeze;
                        }

                        @Override // com.google.android.gms.games.internal.zze.zzap
                        public final void accept(Object obj) {
                            ((OnRequestReceivedListener) obj).onRequestReceived(this.zzir);
                        }
                    });
                }
            } catch (Throwable th) {
                gameRequestBuffer.release();
                throw th;
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void onRequestRemoved(final String str) {
            zzc(new zzap(str) { // from class: com.google.android.gms.games.internal.zzal
                private final String zzhv;

                {
                    this.zzhv = str;
                }

                @Override // com.google.android.gms.games.internal.zze.zzap
                public final void accept(Object obj) {
                    ((OnRequestReceivedListener) obj).onRequestRemoved(this.zzhv);
                }
            });
        }
    }

    private static final class zzar extends zzat<Requests.LoadRequestsResult> {
        zzar(BaseImplementation.ResultHolder<Requests.LoadRequestsResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzb(int i, Bundle bundle) {
            bundle.setClassLoader(getClass().getClassLoader());
            setResult(new zzag(GamesStatusCodes.zza(i), bundle));
        }
    }

    private static final class zzas extends zzat<Requests.UpdateRequestsResult> {
        zzas(BaseImplementation.ResultHolder<Requests.UpdateRequestsResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzad(DataHolder dataHolder) {
            setResult(new zzbi(dataHolder));
        }
    }

    private static final class zzau extends com.google.android.gms.games.internal.zza {
        private final ListenerHolder<? extends RoomUpdateListener> zzit;
        private final ListenerHolder<? extends RoomStatusUpdateListener> zziu;
        private final ListenerHolder<? extends RealTimeMessageReceivedListener> zziv;

        zzau(ListenerHolder<? extends RoomUpdateListener> listenerHolder) {
            this(listenerHolder, null, null);
        }

        zzau(ListenerHolder<? extends RoomUpdateListener> listenerHolder, @Nullable ListenerHolder<? extends RoomStatusUpdateListener> listenerHolder2, @Nullable ListenerHolder<? extends RealTimeMessageReceivedListener> listenerHolder3) {
            this.zzit = (ListenerHolder) Preconditions.checkNotNull(listenerHolder, "Callbacks must not be null");
            this.zziu = listenerHolder2;
            this.zziv = listenerHolder3;
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzs(DataHolder dataHolder) {
            this.zzit.notifyListener(zze.zza(dataHolder, com.google.android.gms.games.internal.zzam.zziw));
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzt(DataHolder dataHolder) {
            this.zzit.notifyListener(zze.zza(dataHolder, com.google.android.gms.games.internal.zzan.zziw));
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void onLeftRoom(final int i, final String str) {
            this.zzit.notifyListener(zze.zza(new zzap(i, str) { // from class: com.google.android.gms.games.internal.zzav
                private final int zzhc;
                private final String zziz;

                {
                    this.zzhc = i;
                    this.zziz = str;
                }

                @Override // com.google.android.gms.games.internal.zze.zzap
                public final void accept(Object obj) {
                    ((RoomUpdateListener) obj).onLeftRoom(this.zzhc, this.zziz);
                }
            }));
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzw(DataHolder dataHolder) {
            this.zzit.notifyListener(zze.zza(dataHolder, com.google.android.gms.games.internal.zzaw.zziw));
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzu(DataHolder dataHolder) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(dataHolder, com.google.android.gms.games.internal.zzax.zzja));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzv(DataHolder dataHolder) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(dataHolder, com.google.android.gms.games.internal.zzay.zzja));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzx(DataHolder dataHolder) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(dataHolder, com.google.android.gms.games.internal.zzaz.zzja));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzy(DataHolder dataHolder) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(dataHolder, com.google.android.gms.games.internal.zzba.zzja));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zze(DataHolder dataHolder, String[] strArr) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(dataHolder, strArr, com.google.android.gms.games.internal.zzbb.zzix));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzf(DataHolder dataHolder, String[] strArr) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(dataHolder, strArr, com.google.android.gms.games.internal.zzbc.zzix));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zza(DataHolder dataHolder, String[] strArr) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(dataHolder, strArr, com.google.android.gms.games.internal.zzao.zzix));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzb(DataHolder dataHolder, String[] strArr) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(dataHolder, strArr, com.google.android.gms.games.internal.zzap.zzix));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzc(DataHolder dataHolder, String[] strArr) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(dataHolder, strArr, com.google.android.gms.games.internal.zzaq.zzix));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzd(DataHolder dataHolder, String[] strArr) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(dataHolder, strArr, com.google.android.gms.games.internal.zzar.zzix));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void onP2PConnected(final String str) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(new zzap(str) { // from class: com.google.android.gms.games.internal.zzas
                    private final String zzhv;

                    {
                        this.zzhv = str;
                    }

                    @Override // com.google.android.gms.games.internal.zze.zzap
                    public final void accept(Object obj) {
                        ((RoomStatusUpdateListener) obj).onP2PConnected(this.zzhv);
                    }
                }));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void onP2PDisconnected(final String str) {
            if (this.zziu != null) {
                this.zziu.notifyListener(zze.zza(new zzap(str) { // from class: com.google.android.gms.games.internal.zzat
                    private final String zzhv;

                    {
                        this.zzhv = str;
                    }

                    @Override // com.google.android.gms.games.internal.zze.zzap
                    public final void accept(Object obj) {
                        ((RoomStatusUpdateListener) obj).onP2PDisconnected(this.zzhv);
                    }
                }));
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void onRealTimeMessageReceived(final RealTimeMessage realTimeMessage) {
            if (this.zziv != null) {
                this.zziv.notifyListener(zze.zza(new zzap(realTimeMessage) { // from class: com.google.android.gms.games.internal.zzau
                    private final RealTimeMessage zziy;

                    {
                        this.zziy = realTimeMessage;
                    }

                    @Override // com.google.android.gms.games.internal.zze.zzap
                    public final void accept(Object obj) {
                        ((RealTimeMessageReceivedListener) obj).onRealTimeMessageReceived(this.zziy);
                    }
                }));
            }
        }
    }

    private static final class zzax extends zzat<Snapshots.OpenSnapshotResult> {
        zzax(BaseImplementation.ResultHolder<Snapshots.OpenSnapshotResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zza(DataHolder dataHolder, Contents contents) {
            setResult(new zzak(dataHolder, contents));
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zza(DataHolder dataHolder, String str, Contents contents, Contents contents2, Contents contents3) {
            setResult(new zzak(dataHolder, str, contents, contents2, contents3));
        }
    }

    private static final class zzay extends zzat<Snapshots.LoadSnapshotsResult> {
        zzay(BaseImplementation.ResultHolder<Snapshots.LoadSnapshotsResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzag(DataHolder dataHolder) {
            setResult(new zzai(dataHolder));
        }
    }

    private static final class zzb extends zzat<Achievements.UpdateAchievementResult> {
        zzb(BaseImplementation.ResultHolder<Achievements.UpdateAchievementResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzb(int i, String str) {
            setResult(new zzbg(i, str));
        }
    }

    private static final class zzbb extends zzat<TurnBasedMultiplayer.InitiateMatchResult> {
        zzbb(BaseImplementation.ResultHolder<TurnBasedMultiplayer.InitiateMatchResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzo(DataHolder dataHolder) {
            setResult(new zzn(dataHolder));
        }
    }

    private static final class zzbc extends zzat<TurnBasedMultiplayer.LeaveMatchResult> {
        zzbc(BaseImplementation.ResultHolder<TurnBasedMultiplayer.LeaveMatchResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzq(DataHolder dataHolder) {
            setResult(new zzt(dataHolder));
        }
    }

    private static final class zzbe extends zzat<TurnBasedMultiplayer.UpdateMatchResult> {
        zzbe(BaseImplementation.ResultHolder<TurnBasedMultiplayer.UpdateMatchResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzp(DataHolder dataHolder) {
            setResult(new zzbh(dataHolder));
        }
    }

    private static final class zzbf extends zzat<TurnBasedMultiplayer.LoadMatchesResult> {
        zzbf(BaseImplementation.ResultHolder<TurnBasedMultiplayer.LoadMatchesResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zza(int i, Bundle bundle) {
            bundle.setClassLoader(getClass().getClassLoader());
            setResult(new zzab(GamesStatusCodes.zza(i), bundle));
        }
    }

    private static final class zzj extends zzat<Events.LoadEventsResult> {
        zzj(BaseImplementation.ResultHolder<Events.LoadEventsResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzb(DataHolder dataHolder) {
            setResult(new zzx(dataHolder));
        }
    }

    private static final class zzo extends zzu<OnInvitationReceivedListener> {
        zzo(ListenerHolder<OnInvitationReceivedListener> listenerHolder) {
            super(listenerHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzl(DataHolder dataHolder) {
            InvitationBuffer invitationBuffer = new InvitationBuffer(dataHolder);
            try {
                final Invitation invitationFreeze = invitationBuffer.getCount() > 0 ? invitationBuffer.get(0).freeze() : null;
                invitationBuffer.release();
                if (invitationFreeze != null) {
                    zzc(new zzap(invitationFreeze) { // from class: com.google.android.gms.games.internal.zzae
                        private final Invitation zzhu;

                        {
                            this.zzhu = invitationFreeze;
                        }

                        @Override // com.google.android.gms.games.internal.zze.zzap
                        public final void accept(Object obj) {
                            ((OnInvitationReceivedListener) obj).onInvitationReceived(this.zzhu);
                        }
                    });
                }
            } catch (Throwable th) {
                invitationBuffer.release();
                throw th;
            }
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void onInvitationRemoved(final String str) {
            zzc(new zzap(str) { // from class: com.google.android.gms.games.internal.zzaf
                private final String zzhv;

                {
                    this.zzhv = str;
                }

                @Override // com.google.android.gms.games.internal.zze.zzap
                public final void accept(Object obj) {
                    ((OnInvitationReceivedListener) obj).onInvitationRemoved(this.zzhv);
                }
            });
        }
    }

    private static final class zzp extends zzat<Invitations.LoadInvitationsResult> {
        zzp(BaseImplementation.ResultHolder<Invitations.LoadInvitationsResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzk(DataHolder dataHolder) {
            setResult(new zzz(dataHolder));
        }
    }

    private static final class zzr extends zzat<Leaderboards.LoadScoresResult> {
        zzr(BaseImplementation.ResultHolder<Leaderboards.LoadScoresResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zza(DataHolder dataHolder, DataHolder dataHolder2) {
            setResult(new zzah(dataHolder, dataHolder2));
        }
    }

    private static final class zzs extends zzat<Leaderboards.LeaderboardMetadataResult> {
        zzs(BaseImplementation.ResultHolder<Leaderboards.LeaderboardMetadataResult> resultHolder) {
            super(resultHolder);
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zzc(DataHolder dataHolder) {
            setResult(new zzq(dataHolder));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static abstract class zzv<T> implements ListenerHolder.Notifier<T> {
        private zzv() {
        }

        @Override // com.google.android.gms.common.api.internal.ListenerHolder.Notifier
        public void onNotifyListenerFailed() {
        }

        /* synthetic */ zzv(com.google.android.gms.games.internal.zzf zzfVar) {
            this();
        }
    }

    private static final class zzae extends zzl implements Players.LoadPlayersResult {
        private final PlayerBuffer zzif;

        zzae(DataHolder dataHolder) {
            super(dataHolder);
            this.zzif = new PlayerBuffer(dataHolder);
        }

        @Override // com.google.android.gms.games.Players.LoadPlayersResult
        public final PlayerBuffer getPlayers() {
            return this.zzif;
        }
    }

    private static final class zzao extends com.google.android.gms.games.internal.zza {
        private final ListenerHolder<RealTimeMultiplayer.ReliableMessageSentCallback> zzio;

        zzao(ListenerHolder<RealTimeMultiplayer.ReliableMessageSentCallback> listenerHolder) {
            this.zzio = listenerHolder;
        }

        @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
        public final void zza(final int i, final int i2, final String str) {
            if (this.zzio != null) {
                this.zzio.notifyListener(zze.zza(new zzap(i, i2, str) { // from class: com.google.android.gms.games.internal.zzaj
                    private final int zzhc;
                    private final int zzip;
                    private final String zziq;

                    {
                        this.zzhc = i;
                        this.zzip = i2;
                        this.zziq = str;
                    }

                    @Override // com.google.android.gms.games.internal.zze.zzap
                    public final void accept(Object obj) {
                        ((RealTimeMultiplayer.ReliableMessageSentCallback) obj).onRealTimeMessageSent(this.zzhc, this.zzip, this.zziq);
                    }
                }));
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static abstract class zzat<T> extends com.google.android.gms.games.internal.zza {
        private final BaseImplementation.ResultHolder<T> zzis;

        zzat(BaseImplementation.ResultHolder<T> resultHolder) {
            this.zzis = (BaseImplementation.ResultHolder) Preconditions.checkNotNull(resultHolder, "Holder must not be null");
        }

        final void setResult(T t) {
            this.zzis.setResult(t);
        }
    }

    private static final class zzbi extends zzl implements Requests.UpdateRequestsResult {
        private final zzek zzjc;

        zzbi(DataHolder dataHolder) {
            super(dataHolder);
            this.zzjc = zzek.zzbb(dataHolder);
        }

        @Override // com.google.android.gms.games.request.Requests.UpdateRequestsResult
        public final int getRequestOutcome(String str) {
            return this.zzjc.getRequestOutcome(str);
        }

        @Override // com.google.android.gms.games.request.Requests.UpdateRequestsResult
        public final Set<String> getRequestIds() {
            return this.zzjc.getRequestIds();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    class zzk extends zzeh {
        zzk() {
            super(zze.this.getContext().getMainLooper(), 1000);
        }

        @Override // com.google.android.gms.internal.games.zzeh
        protected final void zzf(String str, int i) {
            try {
                if (zze.this.isConnected()) {
                    ((zzbu) zze.this.getService()).zza(str, i);
                    return;
                }
                StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 89);
                sb.append("Unable to increment event ");
                sb.append(str);
                sb.append(" by ");
                sb.append(i);
                sb.append(" because the games client is no longer connected");
                com.google.android.gms.games.internal.zzbd.m36e("GamesClientImpl", sb.toString());
            } catch (RemoteException e) {
                zze zzeVar = zze.this;
                zze.zza(e);
            } catch (SecurityException e2) {
                zze zzeVar2 = zze.this;
                zze.zza(e2);
            }
        }
    }

    private static final class zzq extends zzl implements Leaderboards.LeaderboardMetadataResult {
        private final LeaderboardBuffer zzhw;

        zzq(DataHolder dataHolder) {
            super(dataHolder);
            this.zzhw = new LeaderboardBuffer(dataHolder);
        }

        @Override // com.google.android.gms.games.leaderboard.Leaderboards.LeaderboardMetadataResult
        public final LeaderboardBuffer getLeaderboards() {
            return this.zzhw;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static abstract class zzu<T> extends com.google.android.gms.games.internal.zza {
        private final ListenerHolder<T> zzhx;

        zzu(ListenerHolder<T> listenerHolder) {
            this.zzhx = (ListenerHolder) Preconditions.checkNotNull(listenerHolder, "Callback must not be null");
        }

        final void zzc(zzap<T> zzapVar) {
            this.zzhx.notifyListener(zze.zza(zzapVar));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzw extends zzl implements Achievements.LoadAchievementsResult {
        private final AchievementBuffer zzhy;

        zzw(DataHolder dataHolder) {
            super(dataHolder);
            this.zzhy = new AchievementBuffer(dataHolder);
        }

        @Override // com.google.android.gms.games.achievement.Achievements.LoadAchievementsResult
        public final AchievementBuffer getAchievements() {
            return this.zzhy;
        }
    }

    private static final class zzx extends zzl implements Events.LoadEventsResult {
        private final EventBuffer zzhz;

        zzx(DataHolder dataHolder) {
            super(dataHolder);
            this.zzhz = new EventBuffer(dataHolder);
        }

        @Override // com.google.android.gms.games.event.Events.LoadEventsResult
        public final EventBuffer getEvents() {
            return this.zzhz;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzy extends zzl implements GamesMetadata.LoadGamesResult {
        private final GameBuffer zzia;

        zzy(DataHolder dataHolder) {
            super(dataHolder);
            this.zzia = new GameBuffer(dataHolder);
        }

        @Override // com.google.android.gms.games.GamesMetadata.LoadGamesResult
        public final GameBuffer getGames() {
            return this.zzia;
        }
    }

    private static final class zzz extends zzl implements Invitations.LoadInvitationsResult {
        private final InvitationBuffer zzib;

        zzz(DataHolder dataHolder) {
            super(dataHolder);
            this.zzib = new InvitationBuffer(dataHolder);
        }

        @Override // com.google.android.gms.games.multiplayer.Invitations.LoadInvitationsResult
        public final InvitationBuffer getInvitations() {
            return this.zzib;
        }
    }

    private static final class zzab implements TurnBasedMultiplayer.LoadMatchesResult {
        private final Status zzhl;
        private final LoadMatchesResponse zzic;

        zzab(Status status, Bundle bundle) {
            this.zzhl = status;
            this.zzic = new LoadMatchesResponse(bundle);
        }

        @Override // com.google.android.gms.common.api.Result
        public final Status getStatus() {
            return this.zzhl;
        }

        @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer.LoadMatchesResult
        public final LoadMatchesResponse getMatches() {
            return this.zzic;
        }

        @Override // com.google.android.gms.common.api.Releasable
        public final void release() {
            this.zzic.release();
        }
    }

    private static final class zzag implements Requests.LoadRequestsResult {
        private final Status zzhl;
        private final Bundle zzig;

        zzag(Status status, Bundle bundle) {
            this.zzhl = status;
            this.zzig = bundle;
        }

        @Override // com.google.android.gms.common.api.Result
        public final Status getStatus() {
            return this.zzhl;
        }

        @Override // com.google.android.gms.games.request.Requests.LoadRequestsResult
        public final GameRequestBuffer getRequests(int i) {
            String str;
            switch (i) {
                case 1:
                    str = "GIFT";
                    break;
                case 2:
                    str = "WISH";
                    break;
                default:
                    StringBuilder sb = new StringBuilder(33);
                    sb.append("Unknown request type: ");
                    sb.append(i);
                    com.google.android.gms.games.internal.zzbd.m36e("RequestType", sb.toString());
                    str = "UNKNOWN_TYPE";
                    break;
            }
            if (this.zzig.containsKey(str)) {
                return new GameRequestBuffer((DataHolder) this.zzig.get(str));
            }
            return null;
        }

        @Override // com.google.android.gms.common.api.Releasable
        public final void release() {
            Iterator<String> it = this.zzig.keySet().iterator();
            while (it.hasNext()) {
                DataHolder dataHolder = (DataHolder) this.zzig.getParcelable(it.next());
                if (dataHolder != null) {
                    dataHolder.close();
                }
            }
        }
    }

    private static final class zzbg implements Achievements.UpdateAchievementResult {
        private final String zzfc;
        private final Status zzhl;

        zzbg(int i, String str) {
            this.zzhl = GamesStatusCodes.zza(i);
            this.zzfc = str;
        }

        @Override // com.google.android.gms.common.api.Result
        public final Status getStatus() {
            return this.zzhl;
        }

        @Override // com.google.android.gms.games.achievement.Achievements.UpdateAchievementResult
        public final String getAchievementId() {
            return this.zzfc;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzc implements TurnBasedMultiplayer.CancelMatchResult {
        private final Status zzhl;
        private final String zzhm;

        zzc(Status status, String str) {
            this.zzhl = status;
            this.zzhm = str;
        }

        @Override // com.google.android.gms.common.api.Result
        public final Status getStatus() {
            return this.zzhl;
        }

        @Override // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer.CancelMatchResult
        public final String getMatchId() {
            return this.zzhm;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzd implements Videos.CaptureAvailableResult {
        private final Status zzhl;
        private final boolean zzhn;

        zzd(Status status, boolean z) {
            this.zzhl = status;
            this.zzhn = z;
        }

        @Override // com.google.android.gms.common.api.Result
        public final Status getStatus() {
            return this.zzhl;
        }

        @Override // com.google.android.gms.games.video.Videos.CaptureAvailableResult
        public final boolean isAvailable() {
            return this.zzhn;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: com.google.android.gms.games.internal.zze$zze, reason: collision with other inner class name */
    static final class C0527zze implements Videos.CaptureCapabilitiesResult {
        private final Status zzhl;
        private final VideoCapabilities zzho;

        C0527zze(Status status, VideoCapabilities videoCapabilities) {
            this.zzhl = status;
            this.zzho = videoCapabilities;
        }

        @Override // com.google.android.gms.common.api.Result
        public final Status getStatus() {
            return this.zzhl;
        }

        @Override // com.google.android.gms.games.video.Videos.CaptureCapabilitiesResult
        public final VideoCapabilities getCapabilities() {
            return this.zzho;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzf implements Videos.CaptureStateResult {
        private final Status zzhl;
        private final CaptureState zzhp;

        zzf(Status status, CaptureState captureState) {
            this.zzhl = status;
            this.zzhp = captureState;
        }

        @Override // com.google.android.gms.common.api.Result
        public final Status getStatus() {
            return this.zzhl;
        }

        @Override // com.google.android.gms.games.video.Videos.CaptureStateResult
        public final CaptureState getCaptureState() {
            return this.zzhp;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzi implements Snapshots.DeleteSnapshotResult {
        private final Status zzhl;
        private final String zzhs;

        zzi(int i, String str) {
            this.zzhl = GamesStatusCodes.zza(i);
            this.zzhs = str;
        }

        @Override // com.google.android.gms.common.api.Result
        public final Status getStatus() {
            return this.zzhl;
        }

        @Override // com.google.android.gms.games.snapshot.Snapshots.DeleteSnapshotResult
        public final String getSnapshotId() {
            return this.zzhs;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzm implements Games.GetServerAuthCodeResult {
        private final Status zzhl;
        private final String zzht;

        zzm(Status status, String str) {
            this.zzhl = status;
            this.zzht = str;
        }

        @Override // com.google.android.gms.common.api.Result
        public final Status getStatus() {
            return this.zzhl;
        }

        @Override // com.google.android.gms.games.Games.GetServerAuthCodeResult
        public final String getCode() {
            return this.zzht;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzba extends zzl implements Leaderboards.SubmitScoreResult {
        private final ScoreSubmissionData zzjb;

        zzba(DataHolder dataHolder) {
            super(dataHolder);
            try {
                this.zzjb = new ScoreSubmissionData(dataHolder);
            } finally {
                dataHolder.close();
            }
        }

        @Override // com.google.android.gms.games.leaderboard.Leaderboards.SubmitScoreResult
        public final ScoreSubmissionData getScoreData() {
            return this.zzjb;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zza extends zzl implements Quests.AcceptQuestResult {
        private final Quest zzhk;

        zza(DataHolder dataHolder) {
            super(dataHolder);
            QuestBuffer questBuffer = new QuestBuffer(dataHolder);
            try {
                if (questBuffer.getCount() > 0) {
                    this.zzhk = new QuestEntity(questBuffer.get(0));
                } else {
                    this.zzhk = null;
                }
            } finally {
                questBuffer.release();
            }
        }

        @Override // com.google.android.gms.games.quest.Quests.AcceptQuestResult
        public final Quest getQuest() {
            return this.zzhk;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzac extends zzl implements Leaderboards.LoadPlayerScoreResult {
        private final LeaderboardScoreEntity zzid;

        zzac(DataHolder dataHolder) {
            super(dataHolder);
            LeaderboardScoreBuffer leaderboardScoreBuffer = new LeaderboardScoreBuffer(dataHolder);
            try {
                if (leaderboardScoreBuffer.getCount() > 0) {
                    this.zzid = (LeaderboardScoreEntity) ((LeaderboardScore) leaderboardScoreBuffer.get(0)).freeze();
                } else {
                    this.zzid = null;
                }
            } finally {
                leaderboardScoreBuffer.release();
            }
        }

        @Override // com.google.android.gms.games.leaderboard.Leaderboards.LoadPlayerScoreResult
        public final LeaderboardScore getScore() {
            return this.zzid;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzad extends zzl implements Stats.LoadPlayerStatsResult {
        private final PlayerStats zzie;

        zzad(DataHolder dataHolder) {
            super(dataHolder);
            PlayerStatsBuffer playerStatsBuffer = new PlayerStatsBuffer(dataHolder);
            try {
                if (playerStatsBuffer.getCount() > 0) {
                    this.zzie = new PlayerStatsEntity((PlayerStats) playerStatsBuffer.get(0));
                } else {
                    this.zzie = null;
                }
            } finally {
                playerStatsBuffer.release();
            }
        }

        @Override // com.google.android.gms.games.stats.Stats.LoadPlayerStatsResult
        public final PlayerStats getPlayerStats() {
            return this.zzie;
        }
    }

    private static abstract class zzbd extends zzl {
        private final TurnBasedMatch match;

        zzbd(DataHolder dataHolder) {
            super(dataHolder);
            TurnBasedMatchBuffer turnBasedMatchBuffer = new TurnBasedMatchBuffer(dataHolder);
            try {
                if (turnBasedMatchBuffer.getCount() > 0) {
                    this.match = turnBasedMatchBuffer.get(0).freeze();
                } else {
                    this.match = null;
                }
            } finally {
                turnBasedMatchBuffer.release();
            }
        }

        public TurnBasedMatch getMatch() {
            return this.match;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzh extends zzl implements Snapshots.CommitSnapshotResult {
        private final SnapshotMetadata zzhr;

        zzh(DataHolder dataHolder) {
            super(dataHolder);
            SnapshotMetadataBuffer snapshotMetadataBuffer = new SnapshotMetadataBuffer(dataHolder);
            try {
                if (snapshotMetadataBuffer.getCount() > 0) {
                    this.zzhr = new SnapshotMetadataEntity((SnapshotMetadata) snapshotMetadataBuffer.get(0));
                } else {
                    this.zzhr = null;
                }
            } finally {
                snapshotMetadataBuffer.release();
            }
        }

        @Override // com.google.android.gms.games.snapshot.Snapshots.CommitSnapshotResult
        public final SnapshotMetadata getSnapshotMetadata() {
            return this.zzhr;
        }
    }

    private static final class zzah extends zzl implements Leaderboards.LoadScoresResult {
        private final LeaderboardEntity zzih;
        private final LeaderboardScoreBuffer zzii;

        zzah(DataHolder dataHolder, DataHolder dataHolder2) {
            super(dataHolder2);
            LeaderboardBuffer leaderboardBuffer = new LeaderboardBuffer(dataHolder);
            try {
                if (leaderboardBuffer.getCount() > 0) {
                    this.zzih = (LeaderboardEntity) leaderboardBuffer.get(0).freeze();
                } else {
                    this.zzih = null;
                }
                leaderboardBuffer.release();
                this.zzii = new LeaderboardScoreBuffer(dataHolder2);
            } catch (Throwable th) {
                leaderboardBuffer.release();
                throw th;
            }
        }

        @Override // com.google.android.gms.games.leaderboard.Leaderboards.LoadScoresResult
        public final Leaderboard getLeaderboard() {
            return this.zzih;
        }

        @Override // com.google.android.gms.games.leaderboard.Leaderboards.LoadScoresResult
        public final LeaderboardScoreBuffer getScores() {
            return this.zzii;
        }
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient
    public void onConnectionFailed(ConnectionResult connectionResult) {
        super.onConnectionFailed(connectionResult);
        this.zzgt = false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    static final class zzg extends zzl implements Quests.ClaimMilestoneResult {
        private final Quest zzhk;
        private final Milestone zzhq;

        zzg(DataHolder dataHolder, String str) {
            super(dataHolder);
            QuestBuffer questBuffer = new QuestBuffer(dataHolder);
            try {
                if (questBuffer.getCount() > 0) {
                    this.zzhk = new QuestEntity(questBuffer.get(0));
                    List<Milestone> listZzdq = this.zzhk.zzdq();
                    int size = listZzdq.size();
                    for (int i = 0; i < size; i++) {
                        if (listZzdq.get(i).getMilestoneId().equals(str)) {
                            this.zzhq = listZzdq.get(i);
                            questBuffer.release();
                            return;
                        }
                    }
                    this.zzhq = null;
                } else {
                    this.zzhq = null;
                    this.zzhk = null;
                }
                questBuffer.release();
            } catch (Throwable th) {
                questBuffer.release();
                throw th;
            }
        }

        @Override // com.google.android.gms.games.quest.Quests.ClaimMilestoneResult
        public final Milestone getMilestone() {
            return this.zzhq;
        }

        @Override // com.google.android.gms.games.quest.Quests.ClaimMilestoneResult
        public final Quest getQuest() {
            return this.zzhk;
        }
    }

    public final void zzk(int i) {
        this.zzgs.setGravity(i);
    }

    public final void zza(View view) {
        this.zzgs.zzb(view);
    }

    @Override // com.google.android.gms.common.internal.GmsClient
    protected Set<Scope> validateScopes(Set<Scope> set) {
        HashSet hashSet = new HashSet(set);
        boolean zContains = set.contains(Games.SCOPE_GAMES);
        boolean zContains2 = set.contains(Games.SCOPE_GAMES_LITE);
        if (set.contains(Games.zzam)) {
            Preconditions.checkState(!zContains, "Cannot have both %s and %s!", Scopes.GAMES, FirstPartyScopes.GAMES_1P);
        } else {
            Preconditions.checkState(zContains || zContains2, "Games APIs requires %s function.", Scopes.GAMES_LITE);
            if (zContains2 && zContains) {
                hashSet.remove(Games.SCOPE_GAMES_LITE);
            }
        }
        return hashSet;
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient, com.google.android.gms.common.api.Api.Client
    public void connect(BaseGmsClient.ConnectionProgressReportCallbacks connectionProgressReportCallbacks) {
        this.zzgq = null;
        this.zzgr = null;
        super.connect(connectionProgressReportCallbacks);
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient, com.google.android.gms.common.api.Api.Client
    public void disconnect() {
        this.zzgt = false;
        if (isConnected()) {
            try {
                zzbu zzbuVar = (zzbu) getService();
                zzbuVar.zzci();
                this.zzgo.flush();
                zzbuVar.zza(this.zzgv);
            } catch (RemoteException unused) {
                com.google.android.gms.games.internal.zzbd.m39w("GamesClientImpl", "Failed to notify client disconnect.");
            }
        }
        super.disconnect();
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient, com.google.android.gms.common.internal.GmsClientEventManager.GmsClientEventState
    public Bundle getConnectionHint() {
        try {
            Bundle connectionHint = ((zzbu) getService()).getConnectionHint();
            if (connectionHint != null) {
                connectionHint.setClassLoader(zze.class.getClassLoader());
                this.zzgy = connectionHint;
            }
            return connectionHint;
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    @Nullable
    public final Bundle zzat() {
        Bundle connectionHint = getConnectionHint();
        if (connectionHint == null) {
            connectionHint = this.zzgy;
        }
        this.zzgy = null;
        return connectionHint;
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient
    protected Bundle getGetServiceRequestExtraArgs() {
        String string = getContext().getResources().getConfiguration().locale.toString();
        Bundle bundleZzg = this.zzgx.zzg();
        bundleZzg.putString(ServiceSpecificExtraArgs.GamesExtraArgs.GAME_PACKAGE_NAME, this.zzgp);
        bundleZzg.putString(ServiceSpecificExtraArgs.GamesExtraArgs.DESIRED_LOCALE, string);
        bundleZzg.putParcelable(ServiceSpecificExtraArgs.GamesExtraArgs.WINDOW_TOKEN, new BinderWrapper(this.zzgs.zzcp()));
        bundleZzg.putInt("com.google.android.gms.games.key.API_VERSION", 6);
        bundleZzg.putBundle(ServiceSpecificExtraArgs.GamesExtraArgs.SIGNIN_OPTIONS, SignInClientImpl.createBundleFromClientSettings(getClientSettings()));
        return bundleZzg;
    }

    public final String zzau() throws RemoteException {
        return ((zzbu) getService()).zzau();
    }

    public final String zzav() {
        try {
            return zzau();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zza(String str, BaseImplementation.ResultHolder<Games.GetServerAuthCodeResult> resultHolder) throws RemoteException {
        Preconditions.checkNotEmpty(str, "Please provide a valid serverClientId");
        try {
            ((zzbu) getService()).zza(str, new com.google.android.gms.games.internal.zzy(resultHolder));
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final String zza(boolean z) throws RemoteException {
        if (this.zzgq != null) {
            return this.zzgq.getPlayerId();
        }
        return ((zzbu) getService()).zzck();
    }

    public final String zzb(boolean z) {
        try {
            return zza(true);
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final Player zzaw() throws RemoteException {
        checkConnected();
        synchronized (this) {
            if (this.zzgq == null) {
                PlayerBuffer playerBuffer = new PlayerBuffer(((zzbu) getService()).zzcl());
                try {
                    if (playerBuffer.getCount() > 0) {
                        this.zzgq = (PlayerEntity) ((Player) playerBuffer.get(0)).freeze();
                    }
                    playerBuffer.release();
                } catch (Throwable th) {
                    playerBuffer.release();
                    throw th;
                }
            }
        }
        return this.zzgq;
    }

    public final Player zzax() {
        try {
            return zzaw();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final Game zzay() throws RemoteException {
        checkConnected();
        synchronized (this) {
            if (this.zzgr == null) {
                GameBuffer gameBuffer = new GameBuffer(((zzbu) getService()).zzcm());
                try {
                    if (gameBuffer.getCount() > 0) {
                        this.zzgr = (GameEntity) ((Game) gameBuffer.get(0)).freeze();
                    }
                    gameBuffer.release();
                } catch (Throwable th) {
                    gameBuffer.release();
                    throw th;
                }
            }
        }
        return this.zzgr;
    }

    public final Game zzaz() {
        try {
            return zzay();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Players.LoadPlayersResult> resultHolder, String str, boolean z) throws RemoteException {
        try {
            ((zzbu) getService()).zzb(new zzal(resultHolder), str, z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Players.LoadPlayersResult> resultHolder, int i, boolean z, boolean z2) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzal(resultHolder), i, z, z2);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Players.LoadPlayersResult> resultHolder, String str, int i, boolean z, boolean z2) throws RemoteException {
        if (((str.hashCode() == 156408498 && str.equals("played_with")) ? (byte) 0 : (byte) -1) != 0) {
            String strValueOf = String.valueOf(str);
            throw new IllegalArgumentException(strValueOf.length() != 0 ? "Invalid player collection: ".concat(strValueOf) : new String("Invalid player collection: "));
        }
        try {
            ((zzbu) getService()).zza(new zzal(resultHolder), str, i, z, z2);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Players.LoadPlayersResult> resultHolder, boolean z) throws RemoteException {
        try {
            ((zzbu) getService()).zzc(new zzal(resultHolder), z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final Intent zzba() throws RemoteException {
        return ((zzbu) getService()).zzba();
    }

    public final Intent zzbb() {
        try {
            return zzba();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final Intent zza(String str, int i, int i2) {
        try {
            return ((zzbu) getService()).zzb(str, i, i2);
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zzb(BaseImplementation.ResultHolder<Leaderboards.LeaderboardMetadataResult> resultHolder, boolean z) throws RemoteException {
        try {
            ((zzbu) getService()).zzb(new zzs(resultHolder), z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzb(BaseImplementation.ResultHolder<Leaderboards.LeaderboardMetadataResult> resultHolder, String str, boolean z) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzs(resultHolder), str, z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Leaderboards.LoadPlayerScoreResult> resultHolder, String str, String str2, int i, int i2) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new com.google.android.gms.games.internal.zzz(resultHolder), (String) null, str2, i, i2);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Leaderboards.LoadScoresResult> resultHolder, String str, int i, int i2, int i3, boolean z) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzr(resultHolder), str, i, i2, i3, z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzb(BaseImplementation.ResultHolder<Leaderboards.LoadScoresResult> resultHolder, String str, int i, int i2, int i3, boolean z) throws RemoteException {
        try {
            ((zzbu) getService()).zzb(new zzr(resultHolder), str, i, i2, i3, z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Leaderboards.LoadScoresResult> resultHolder, LeaderboardScoreBuffer leaderboardScoreBuffer, int i, int i2) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzr(resultHolder), leaderboardScoreBuffer.zzdi().zzdj(), i, i2);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Leaderboards.SubmitScoreResult> resultHolder, String str, long j, String str2) throws RemoteException {
        try {
            ((zzbu) getService()).zza(resultHolder == null ? null : new com.google.android.gms.games.internal.zzaa(resultHolder), str, j, str2);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final Intent zzbc() {
        try {
            return ((zzbu) getService()).zzbc();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zzc(BaseImplementation.ResultHolder<Achievements.LoadAchievementsResult> resultHolder, boolean z) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new com.google.android.gms.games.internal.zzab(resultHolder), z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Achievements.UpdateAchievementResult> resultHolder, String str) throws RemoteException {
        try {
            ((zzbu) getService()).zza(resultHolder == null ? null : new zzb(resultHolder), str, this.zzgs.zzcp(), this.zzgs.zzco());
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzb(BaseImplementation.ResultHolder<Achievements.UpdateAchievementResult> resultHolder, String str) throws RemoteException {
        try {
            ((zzbu) getService()).zzb(resultHolder == null ? null : new zzb(resultHolder), str, this.zzgs.zzcp(), this.zzgs.zzco());
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Achievements.UpdateAchievementResult> resultHolder, String str, int i) throws RemoteException {
        try {
            ((zzbu) getService()).zza(resultHolder == null ? null : new zzb(resultHolder), str, i, this.zzgs.zzcp(), this.zzgs.zzco());
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzb(BaseImplementation.ResultHolder<Achievements.UpdateAchievementResult> resultHolder, String str, int i) throws RemoteException {
        try {
            ((zzbu) getService()).zzb(resultHolder == null ? null : new zzb(resultHolder), str, i, this.zzgs.zzcp(), this.zzgs.zzco());
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzd(BaseImplementation.ResultHolder<Events.LoadEventsResult> resultHolder, boolean z) throws RemoteException {
        this.zzgo.flush();
        try {
            ((zzbu) getService()).zze(new zzj(resultHolder), z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Events.LoadEventsResult> resultHolder, boolean z, String... strArr) throws RemoteException {
        this.zzgo.flush();
        try {
            ((zzbu) getService()).zza(new zzj(resultHolder), z, strArr);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(String str, int i) {
        this.zzgo.zza(str, i);
    }

    public final Intent zzbd() {
        try {
            return ((zzbu) getService()).zzbd();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final Intent zzbe() {
        try {
            return ((zzbu) getService()).zzbe();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zza(ListenerHolder<OnInvitationReceivedListener> listenerHolder) throws RemoteException {
        ((zzbu) getService()).zza(new zzo(listenerHolder), this.zzgv);
    }

    public final void zzb(ListenerHolder<OnInvitationReceivedListener> listenerHolder) {
        try {
            zza(listenerHolder);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zzbf() throws RemoteException {
        ((zzbu) getService()).zzb(this.zzgv);
    }

    public final void zzbg() {
        try {
            zzbf();
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zzc(ListenerHolder<OnTurnBasedMatchUpdateReceivedListener> listenerHolder) throws RemoteException {
        ((zzbu) getService()).zzb(new zzaj(listenerHolder), this.zzgv);
    }

    public final void zzd(ListenerHolder<OnTurnBasedMatchUpdateReceivedListener> listenerHolder) {
        try {
            zzc(listenerHolder);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zzbh() throws RemoteException {
        ((zzbu) getService()).zzc(this.zzgv);
    }

    public final void zzbi() {
        try {
            zzbh();
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zze(ListenerHolder<QuestUpdateListener> listenerHolder) {
        try {
            ((zzbu) getService()).zzd(new zzam(listenerHolder), this.zzgv);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zzbj() {
        try {
            ((zzbu) getService()).zze(this.zzgv);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zzf(ListenerHolder<OnRequestReceivedListener> listenerHolder) {
        try {
            ((zzbu) getService()).zzc(new zzaq(listenerHolder), this.zzgv);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zzbk() {
        try {
            ((zzbu) getService()).zzd(this.zzgv);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final Intent zza(PlayerEntity playerEntity) throws RemoteException {
        return ((zzbu) getService()).zza(playerEntity);
    }

    public final Intent zzb(PlayerEntity playerEntity) {
        try {
            return zza(playerEntity);
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final Intent zzbl() throws RemoteException {
        return ((zzbu) getService()).zzbl();
    }

    public final Intent zzbm() {
        try {
            return zzbl();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final Intent zza(Room room, int i) throws RemoteException {
        return ((zzbu) getService()).zza((RoomEntity) room.freeze(), i);
    }

    public final Intent zzb(Room room, int i) {
        try {
            return zza(room, i);
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final Intent zzbn() throws RemoteException {
        return ((zzbu) getService()).zzbn();
    }

    public final Intent zzbo() {
        try {
            return zzbn();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zza(BaseImplementation.ResultHolder<GamesMetadata.LoadGamesResult> resultHolder) throws RemoteException {
        try {
            ((zzbu) getService()).zzb(new com.google.android.gms.games.internal.zzac(resultHolder));
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient, com.google.android.gms.common.api.Api.Client
    public void onUserSignOut(@NonNull BaseGmsClient.SignOutCallbacks signOutCallbacks) {
        try {
            zzb(new com.google.android.gms.games.internal.zzad(signOutCallbacks));
        } catch (RemoteException unused) {
            signOutCallbacks.onSignOutComplete();
        }
    }

    public final void zzb(BaseImplementation.ResultHolder<Status> resultHolder) throws RemoteException {
        this.zzgo.flush();
        try {
            ((zzbu) getService()).zza(new com.google.android.gms.games.internal.zzg(resultHolder));
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final int zzbp() throws RemoteException {
        return ((zzbu) getService()).zzbp();
    }

    public final int zzbq() {
        try {
            return zzbp();
        } catch (RemoteException e) {
            zza(e);
            return 4368;
        }
    }

    public final String zzbr() throws RemoteException {
        return ((zzbu) getService()).zzbr();
    }

    public final String zzbs() {
        try {
            return zzbr();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Invitations.LoadInvitationsResult> resultHolder, int i) throws RemoteException {
        try {
            ((zzbu) getService()).zza((zzbq) new zzp(resultHolder), i);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzb(String str, int i) throws RemoteException {
        ((zzbu) getService()).zzb(str, i);
    }

    public final void zzc(String str, int i) {
        try {
            zzb(str, i);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zzd(String str, int i) throws RemoteException {
        ((zzbu) getService()).zzd(str, i);
    }

    public final void zze(String str, int i) {
        try {
            zzd(str, i);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final Intent zza(int i, int i2, boolean z) throws RemoteException {
        return ((zzbu) getService()).zza(i, i2, z);
    }

    public final Intent zzb(int i, int i2, boolean z) {
        try {
            return zza(i, i2, z);
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zza(BaseImplementation.ResultHolder<TurnBasedMultiplayer.InitiateMatchResult> resultHolder, TurnBasedMatchConfig turnBasedMatchConfig) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzbb(resultHolder), turnBasedMatchConfig.getVariant(), turnBasedMatchConfig.zzdp(), turnBasedMatchConfig.getInvitedPlayerIds(), turnBasedMatchConfig.getAutoMatchCriteria());
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzc(BaseImplementation.ResultHolder<TurnBasedMultiplayer.InitiateMatchResult> resultHolder, String str) throws RemoteException {
        try {
            ((zzbu) getService()).zzb(new zzbb(resultHolder), str);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzd(BaseImplementation.ResultHolder<TurnBasedMultiplayer.InitiateMatchResult> resultHolder, String str) throws RemoteException {
        try {
            ((zzbu) getService()).zzc(new zzbb(resultHolder), str);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final int zzbt() throws RemoteException {
        return ((zzbu) getService()).zzbt();
    }

    public final int zzbu() {
        try {
            return zzbt();
        } catch (RemoteException e) {
            zza(e);
            return -1;
        }
    }

    public final void zza(BaseImplementation.ResultHolder<TurnBasedMultiplayer.UpdateMatchResult> resultHolder, String str, byte[] bArr, String str2, ParticipantResult[] participantResultArr) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzbe(resultHolder), str, bArr, str2, participantResultArr);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<TurnBasedMultiplayer.UpdateMatchResult> resultHolder, String str, byte[] bArr, ParticipantResult[] participantResultArr) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzbe(resultHolder), str, bArr, participantResultArr);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zze(BaseImplementation.ResultHolder<TurnBasedMultiplayer.LeaveMatchResult> resultHolder, String str) throws RemoteException {
        try {
            ((zzbu) getService()).zze(new zzbc(resultHolder), str);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<TurnBasedMultiplayer.LeaveMatchResult> resultHolder, String str, String str2) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzbc(resultHolder), str, str2);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzf(BaseImplementation.ResultHolder<TurnBasedMultiplayer.CancelMatchResult> resultHolder, String str) throws RemoteException {
        try {
            ((zzbu) getService()).zzd(new com.google.android.gms.games.internal.zzh(resultHolder), str);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzb(String str) throws RemoteException {
        ((zzbu) getService()).zzf(str);
    }

    public final void zzc(String str) {
        try {
            zzb(str);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<TurnBasedMultiplayer.LoadMatchesResult> resultHolder, int i, int[] iArr) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzbf(resultHolder), i, iArr);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzg(BaseImplementation.ResultHolder<TurnBasedMultiplayer.LoadMatchResult> resultHolder, String str) throws RemoteException {
        try {
            ((zzbu) getService()).zzf(new com.google.android.gms.games.internal.zzi(resultHolder), str);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final Intent zzc(int i, int i2, boolean z) throws RemoteException {
        return ((zzbu) getService()).zzc(i, i2, z);
    }

    public final Intent zzd(int i, int i2, boolean z) {
        try {
            return zzc(i, i2, z);
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zza(ListenerHolder<? extends RoomUpdateListener> listenerHolder, ListenerHolder<? extends RoomStatusUpdateListener> listenerHolder2, ListenerHolder<? extends RealTimeMessageReceivedListener> listenerHolder3, RoomConfig roomConfig) throws RemoteException {
        ((zzbu) getService()).zza(new zzau(listenerHolder, listenerHolder2, listenerHolder3), this.zzgu, roomConfig.getVariant(), roomConfig.getInvitedPlayerIds(), roomConfig.getAutoMatchCriteria(), false, this.zzgv);
    }

    public final void zzb(ListenerHolder<? extends RoomUpdateListener> listenerHolder, ListenerHolder<? extends RoomStatusUpdateListener> listenerHolder2, ListenerHolder<? extends RealTimeMessageReceivedListener> listenerHolder3, RoomConfig roomConfig) {
        try {
            zza(listenerHolder, listenerHolder2, listenerHolder3, roomConfig);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zzc(ListenerHolder<? extends RoomUpdateListener> listenerHolder, ListenerHolder<? extends RoomStatusUpdateListener> listenerHolder2, ListenerHolder<? extends RealTimeMessageReceivedListener> listenerHolder3, RoomConfig roomConfig) throws RemoteException {
        ((zzbu) getService()).zza((zzbq) new zzau(listenerHolder, listenerHolder2, listenerHolder3), (IBinder) this.zzgu, roomConfig.getInvitationId(), false, this.zzgv);
    }

    public final void zzd(ListenerHolder<? extends RoomUpdateListener> listenerHolder, ListenerHolder<? extends RoomStatusUpdateListener> listenerHolder2, ListenerHolder<? extends RealTimeMessageReceivedListener> listenerHolder3, RoomConfig roomConfig) {
        try {
            zzc(listenerHolder, listenerHolder2, listenerHolder3, roomConfig);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zza(ListenerHolder<? extends RoomUpdateListener> listenerHolder, String str) {
        try {
            ((zzbu) getService()).zza(new zzau(listenerHolder), str);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final int zza(ListenerHolder<RealTimeMultiplayer.ReliableMessageSentCallback> listenerHolder, byte[] bArr, String str, String str2) throws RemoteException {
        return ((zzbu) getService()).zza(new zzao(listenerHolder), bArr, str, str2);
    }

    public final int zzb(ListenerHolder<RealTimeMultiplayer.ReliableMessageSentCallback> listenerHolder, byte[] bArr, String str, String str2) {
        try {
            return zza(listenerHolder, bArr, str, str2);
        } catch (RemoteException e) {
            zza(e);
            return -1;
        }
    }

    public final int zza(byte[] bArr, String str, String[] strArr) {
        Preconditions.checkNotNull(strArr, "Participant IDs must not be null");
        try {
            Preconditions.checkNotNull(strArr, "Participant IDs must not be null");
            return ((zzbu) getService()).zzb(bArr, str, strArr);
        } catch (RemoteException e) {
            zza(e);
            return -1;
        }
    }

    public final int zza(byte[] bArr, String str) throws RemoteException {
        return ((zzbu) getService()).zzb(bArr, str, (String[]) null);
    }

    public final int zzb(byte[] bArr, String str) {
        try {
            return zza(bArr, str);
        } catch (RemoteException e) {
            zza(e);
            return -1;
        }
    }

    public final void zzl(int i) throws RemoteException {
        ((zzbu) getService()).zzl(i);
    }

    public final void zzm(int i) {
        try {
            zzl(i);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final Intent zzbv() {
        try {
            return ((zzbu) getService()).zzbv();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final Intent zza(int i, byte[] bArr, int i2, Bitmap bitmap, String str) {
        try {
            Intent intentZza = ((zzbu) getService()).zza(i, bArr, i2, str);
            Preconditions.checkNotNull(bitmap, "Must provide a non null icon");
            intentZza.putExtra("com.google.android.gms.games.REQUEST_ITEM_ICON", bitmap);
            return intentZza;
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final int zzbw() {
        try {
            return ((zzbu) getService()).zzbw();
        } catch (RemoteException e) {
            zza(e);
            return -1;
        }
    }

    public final int zzbx() {
        try {
            return ((zzbu) getService()).zzbx();
        } catch (RemoteException e) {
            zza(e);
            return -1;
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Requests.UpdateRequestsResult> resultHolder, String[] strArr) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzas(resultHolder), strArr);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzb(BaseImplementation.ResultHolder<Requests.UpdateRequestsResult> resultHolder, String[] strArr) throws RemoteException {
        try {
            ((zzbu) getService()).zzb(new zzas(resultHolder), strArr);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Requests.LoadRequestsResult> resultHolder, int i, int i2, int i3) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzar(resultHolder), i, i2, i3);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zze(BaseImplementation.ResultHolder<Stats.LoadPlayerStatsResult> resultHolder, boolean z) throws RemoteException {
        try {
            ((zzbu) getService()).zzf(new com.google.android.gms.games.internal.zzj(resultHolder), z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final Intent zza(int[] iArr) {
        try {
            return ((zzbu) getService()).zza(iArr);
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final Intent zzd(String str) {
        try {
            return ((zzbu) getService()).zzd(str);
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zzh(BaseImplementation.ResultHolder<Quests.AcceptQuestResult> resultHolder, String str) throws RemoteException {
        this.zzgo.flush();
        try {
            ((zzbu) getService()).zzh(new com.google.android.gms.games.internal.zzk(resultHolder), str);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzb(BaseImplementation.ResultHolder<Quests.ClaimMilestoneResult> resultHolder, String str, String str2) throws RemoteException {
        this.zzgo.flush();
        try {
            Preconditions.checkNotNull(str2, "MilestoneId must not be null");
            ((zzbu) getService()).zzb(new com.google.android.gms.games.internal.zzl(resultHolder, str2), str, str2);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Quests.LoadQuestsResult> resultHolder, int[] iArr, int i, boolean z) throws RemoteException {
        this.zzgo.flush();
        try {
            ((zzbu) getService()).zza(new zzan(resultHolder), iArr, i, z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzb(BaseImplementation.ResultHolder<Quests.LoadQuestsResult> resultHolder, boolean z, String[] strArr) throws RemoteException {
        this.zzgo.flush();
        try {
            ((zzbu) getService()).zza(new zzan(resultHolder), strArr, z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zze(String str) {
        try {
            ((zzbu) getService()).zza(str, this.zzgs.zzcp(), this.zzgs.zzco());
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final int zzby() throws RemoteException {
        return ((zzbu) getService()).zzby();
    }

    public final int zzbz() {
        try {
            return zzby();
        } catch (RemoteException e) {
            zza(e);
            return -1;
        }
    }

    public final int zzca() throws RemoteException {
        return ((zzbu) getService()).zzca();
    }

    public final int zzcb() {
        try {
            return zzca();
        } catch (RemoteException e) {
            zza(e);
            return -1;
        }
    }

    public final Intent zza(String str, boolean z, boolean z2, int i) throws RemoteException {
        return ((zzbu) getService()).zza(str, z, z2, i);
    }

    public final Intent zzb(String str, boolean z, boolean z2, int i) {
        try {
            return zza(str, z, z2, i);
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zzf(BaseImplementation.ResultHolder<Snapshots.LoadSnapshotsResult> resultHolder, boolean z) throws RemoteException {
        try {
            ((zzbu) getService()).zzd(new zzay(resultHolder), z);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Snapshots.OpenSnapshotResult> resultHolder, String str, boolean z, int i) throws RemoteException {
        try {
            ((zzbu) getService()).zza(new zzax(resultHolder), str, z, i);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Snapshots.CommitSnapshotResult> resultHolder, Snapshot snapshot, SnapshotMetadataChange snapshotMetadataChange) throws RemoteException {
        SnapshotContents snapshotContents = snapshot.getSnapshotContents();
        Preconditions.checkState(!snapshotContents.isClosed(), "Snapshot already closed");
        BitmapTeleporter bitmapTeleporterZzdt = snapshotMetadataChange.zzdt();
        if (bitmapTeleporterZzdt != null) {
            bitmapTeleporterZzdt.setTempDir(getContext().getCacheDir());
        }
        Contents contentsZzds = snapshotContents.zzds();
        snapshotContents.close();
        try {
            ((zzbu) getService()).zza(new com.google.android.gms.games.internal.zzm(resultHolder), snapshot.getMetadata().getSnapshotId(), (SnapshotMetadataChangeEntity) snapshotMetadataChange, contentsZzds);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(Snapshot snapshot) throws RemoteException {
        SnapshotContents snapshotContents = snapshot.getSnapshotContents();
        Preconditions.checkState(!snapshotContents.isClosed(), "Snapshot already closed");
        Contents contentsZzds = snapshotContents.zzds();
        snapshotContents.close();
        ((zzbu) getService()).zza(contentsZzds);
    }

    public final void zzb(Snapshot snapshot) {
        try {
            zza(snapshot);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zzi(BaseImplementation.ResultHolder<Snapshots.DeleteSnapshotResult> resultHolder, String str) throws RemoteException {
        try {
            ((zzbu) getService()).zzg(new com.google.android.gms.games.internal.zzn(resultHolder), str);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zza(BaseImplementation.ResultHolder<Snapshots.OpenSnapshotResult> resultHolder, String str, String str2, SnapshotMetadataChange snapshotMetadataChange, SnapshotContents snapshotContents) throws RemoteException {
        Preconditions.checkState(!snapshotContents.isClosed(), "SnapshotContents already closed");
        BitmapTeleporter bitmapTeleporterZzdt = snapshotMetadataChange.zzdt();
        if (bitmapTeleporterZzdt != null) {
            bitmapTeleporterZzdt.setTempDir(getContext().getCacheDir());
        }
        Contents contentsZzds = snapshotContents.zzds();
        snapshotContents.close();
        try {
            ((zzbu) getService()).zza(new zzax(resultHolder), str, str2, (SnapshotMetadataChangeEntity) snapshotMetadataChange, contentsZzds);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzc(BaseImplementation.ResultHolder<Videos.CaptureCapabilitiesResult> resultHolder) throws RemoteException {
        try {
            ((zzbu) getService()).zzc(new com.google.android.gms.games.internal.zzo(resultHolder));
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final Intent zzcc() throws RemoteException {
        return ((zzbu) getService()).zzcn();
    }

    public final Intent zzcd() {
        try {
            return zzcc();
        } catch (RemoteException e) {
            zza(e);
            return null;
        }
    }

    public final void zzd(BaseImplementation.ResultHolder<Videos.CaptureStateResult> resultHolder) throws RemoteException {
        try {
            ((zzbu) getService()).zzd(new com.google.android.gms.games.internal.zzq(resultHolder));
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final void zzb(BaseImplementation.ResultHolder<Videos.CaptureAvailableResult> resultHolder, int i) throws RemoteException {
        try {
            ((zzbu) getService()).zzb((zzbq) new com.google.android.gms.games.internal.zzr(resultHolder), i);
        } catch (SecurityException e) {
            zza(resultHolder, e);
        }
    }

    public final boolean zzce() throws RemoteException {
        return ((zzbu) getService()).zzce();
    }

    public final boolean zzcf() {
        try {
            return zzce();
        } catch (RemoteException e) {
            zza(e);
            return false;
        }
    }

    public final void zzg(ListenerHolder<Videos.CaptureOverlayStateListener> listenerHolder) throws RemoteException {
        ((zzbu) getService()).zze(new com.google.android.gms.games.internal.zzs(listenerHolder), this.zzgv);
    }

    public final void zzh(ListenerHolder<Videos.CaptureOverlayStateListener> listenerHolder) {
        try {
            zzg(listenerHolder);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    public final void zzcg() throws RemoteException {
        ((zzbu) getService()).zzf(this.zzgv);
    }

    public final void zzch() {
        try {
            zzcg();
        } catch (RemoteException e) {
            zza(e);
        }
    }

    final void zza(IBinder iBinder, Bundle bundle) {
        if (isConnected()) {
            try {
                ((zzbu) getService()).zza(iBinder, bundle);
            } catch (RemoteException e) {
                zza(e);
            }
        }
    }

    final void zzci() {
        if (isConnected()) {
            try {
                ((zzbu) getService()).zzci();
            } catch (RemoteException e) {
                zza(e);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void zza(RemoteException remoteException) {
        com.google.android.gms.games.internal.zzbd.m40w("GamesClientImpl", "service died", remoteException);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void zza(SecurityException securityException) {
        com.google.android.gms.games.internal.zzbd.m37e("GamesClientImpl", "Is player signed out?", securityException);
    }

    private static <R> void zza(BaseImplementation.ResultHolder<R> resultHolder, SecurityException securityException) {
        if (resultHolder != null) {
            resultHolder.setFailedResult(GamesClientStatusCodes.zza(4));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static Room zzay(DataHolder dataHolder) {
        com.google.android.gms.games.multiplayer.realtime.zzb zzbVar = new com.google.android.gms.games.multiplayer.realtime.zzb(dataHolder);
        try {
            return zzbVar.getCount() > 0 ? zzbVar.get(0).freeze() : null;
        } finally {
            zzbVar.release();
        }
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient
    protected void onPostInitHandler(int i, IBinder iBinder, Bundle bundle, int i2) {
        if (i == 0 && bundle != null) {
            bundle.setClassLoader(zze.class.getClassLoader());
            this.zzgt = bundle.getBoolean("show_welcome_popup");
            this.zzgw = this.zzgt;
            this.zzgq = (PlayerEntity) bundle.getParcelable("com.google.android.gms.games.current_player");
            this.zzgr = (GameEntity) bundle.getParcelable("com.google.android.gms.games.current_game");
        }
        super.onPostInitHandler(i, iBinder, bundle, i2);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static <T> ListenerHolder.Notifier<T> zza(zzap<T> zzapVar) {
        return new com.google.android.gms.games.internal.zzu(zzapVar);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static <T> ListenerHolder.Notifier<T> zza(DataHolder dataHolder, zzaw<T> zzawVar) {
        return new com.google.android.gms.games.internal.zzv(zzawVar, dataHolder);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static <T> ListenerHolder.Notifier<T> zza(DataHolder dataHolder, String[] strArr, zzav<T> zzavVar) {
        return new com.google.android.gms.games.internal.zzw(zzavVar, dataHolder, new ArrayList(Arrays.asList(strArr)));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static <T> ListenerHolder.Notifier<T> zza(DataHolder dataHolder, zzaz<T> zzazVar) {
        return new com.google.android.gms.games.internal.zzx(zzazVar, dataHolder);
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient
    public /* synthetic */ void onConnectedLocked(@NonNull IInterface iInterface) {
        zzbu zzbuVar = (zzbu) iInterface;
        super.onConnectedLocked(zzbuVar);
        if (this.zzgt) {
            this.zzgs.zzcr();
            this.zzgt = false;
        }
        if (this.zzgx.zzar || this.zzgx.zzaz) {
            return;
        }
        try {
            zzbuVar.zza(new com.google.android.gms.games.internal.zzp(new zzbw(this.zzgs.zzcq())), this.zzgv);
        } catch (RemoteException e) {
            zza(e);
        }
    }

    @Override // com.google.android.gms.common.internal.BaseGmsClient
    protected /* synthetic */ IInterface createServiceInterface(IBinder iBinder) {
        if (iBinder == null) {
            return null;
        }
        IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.games.internal.IGamesService");
        if (iInterfaceQueryLocalInterface instanceof zzbu) {
            return (zzbu) iInterfaceQueryLocalInterface;
        }
        return new zzbv(iBinder);
    }
}

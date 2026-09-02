package com.google.android.gms.games;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Looper;
import android.text.TextUtils;
import android.view.View;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresPermission;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInOptionsExtension;
import com.google.android.gms.common.FirstPartyScopes;
import com.google.android.gms.common.Scopes;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.PendingResult;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Scope;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.internal.ClientSettings;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.ShowFirstParty;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.games.achievement.Achievements;
import com.google.android.gms.games.event.Events;
import com.google.android.gms.games.leaderboard.Leaderboards;
import com.google.android.gms.games.multiplayer.Invitations;
import com.google.android.gms.games.multiplayer.Multiplayer;
import com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer;
import com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer;
import com.google.android.gms.games.quest.Quests;
import com.google.android.gms.games.request.Requests;
import com.google.android.gms.games.snapshot.Snapshots;
import com.google.android.gms.games.stats.Stats;
import com.google.android.gms.games.video.Videos;
import com.google.android.gms.internal.games.zzdw;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@VisibleForTesting
@KeepForSdk
public final class Games {
    public static final String EXTRA_PLAYER_IDS = "players";
    public static final String EXTRA_STATUS = "status";
    static final Api.ClientKey<com.google.android.gms.games.internal.zze> CLIENT_KEY = new Api.ClientKey<>();
    private static final Api.AbstractClientBuilder<com.google.android.gms.games.internal.zze, GamesOptions> zzak = new zzi();
    private static final Api.AbstractClientBuilder<com.google.android.gms.games.internal.zze, GamesOptions> zzal = new zzj();
    public static final Scope SCOPE_GAMES = new Scope(Scopes.GAMES);
    public static final Scope SCOPE_GAMES_LITE = new Scope(Scopes.GAMES_LITE);

    @Deprecated
    public static final Api<GamesOptions> API = new Api<>("Games.API", zzak, CLIENT_KEY);

    @ShowFirstParty
    public static final Scope zzam = new Scope(FirstPartyScopes.GAMES_1P);

    @ShowFirstParty
    private static final Api<GamesOptions> zzan = new Api<>("Games.API_1P", zzal, CLIENT_KEY);

    @Deprecated
    public static final GamesMetadata GamesMetadata = new com.google.android.gms.internal.games.zzac();

    @Deprecated
    public static final Achievements Achievements = new com.google.android.gms.internal.games.zze();
    private static final com.google.android.gms.games.appcontent.zzm zzao = new com.google.android.gms.internal.games.zzs();

    @Deprecated
    public static final Events Events = new com.google.android.gms.internal.games.zzu();

    @Deprecated
    public static final Leaderboards Leaderboards = new com.google.android.gms.internal.games.zzal();

    @Deprecated
    public static final Invitations Invitations = new com.google.android.gms.internal.games.zzah();

    @Deprecated
    public static final TurnBasedMultiplayer TurnBasedMultiplayer = new com.google.android.gms.internal.games.zzcz();

    @Deprecated
    public static final RealTimeMultiplayer RealTimeMultiplayer = new com.google.android.gms.internal.games.zzby();
    private static final Multiplayer zzap = new com.google.android.gms.internal.games.zzbb();

    @Deprecated
    public static final Players Players = new com.google.android.gms.internal.games.zzbd();

    @Deprecated
    public static final Notifications Notifications = new com.google.android.gms.internal.games.zzbc();

    @Deprecated
    public static final Quests Quests = new com.google.android.gms.internal.games.zzbn();

    @Deprecated
    public static final Requests Requests = new com.google.android.gms.internal.games.zzbz();

    @Deprecated
    public static final Snapshots Snapshots = new com.google.android.gms.internal.games.zzch();

    @Deprecated
    public static final Stats Stats = new com.google.android.gms.internal.games.zzcv();

    @Deprecated
    public static final Videos Videos = new zzdw();

    @KeepForSdk
    @Deprecated
    public interface GetServerAuthCodeResult extends Result {
        @KeepForSdk
        String getCode();
    }

    public static abstract class zza<T extends Result> extends BaseImplementation.ApiMethodImpl<T, com.google.android.gms.games.internal.zze> {
        public zza(GoogleApiClient googleApiClient) {
            super(Games.CLIENT_KEY, googleApiClient);
        }
    }

    private Games() {
    }

    /* JADX INFO: Access modifiers changed from: private */
    static abstract class zzb extends Api.AbstractClientBuilder<com.google.android.gms.games.internal.zze, GamesOptions> {
        private zzb() {
        }

        @Override // com.google.android.gms.common.api.Api.BaseClientBuilder
        public int getPriority() {
            return 1;
        }

        @Override // com.google.android.gms.common.api.Api.AbstractClientBuilder
        public /* synthetic */ Api.Client buildClient(Context context, Looper looper, ClientSettings clientSettings, GamesOptions gamesOptions, GoogleApiClient.ConnectionCallbacks connectionCallbacks, GoogleApiClient.OnConnectionFailedListener onConnectionFailedListener) {
            GamesOptions gamesOptionsBuild = gamesOptions;
            if (gamesOptionsBuild == null) {
                gamesOptionsBuild = new GamesOptions.Builder((zzi) null).build();
            }
            return new com.google.android.gms.games.internal.zze(context, looper, clientSettings, gamesOptionsBuild, connectionCallbacks, onConnectionFailedListener);
        }

        /* synthetic */ zzb(zzi zziVar) {
            this();
        }
    }

    public static com.google.android.gms.games.internal.zze zza(GoogleApiClient googleApiClient) {
        return zza(googleApiClient, true);
    }

    /* JADX INFO: Access modifiers changed from: private */
    static abstract class zzc extends zza<GetServerAuthCodeResult> {
        private zzc(GoogleApiClient googleApiClient) {
            super(googleApiClient);
        }

        @Override // com.google.android.gms.common.api.internal.BasePendingResult
        public /* synthetic */ Result createFailedResult(Status status) {
            return new zzm(this, status);
        }

        /* synthetic */ zzc(GoogleApiClient googleApiClient, zzi zziVar) {
            this(googleApiClient);
        }
    }

    public static com.google.android.gms.games.internal.zze zza(GoogleApiClient googleApiClient, boolean z) {
        Preconditions.checkArgument(googleApiClient != null, "GoogleApiClient parameter is required.");
        Preconditions.checkState(googleApiClient.isConnected(), "GoogleApiClient must be connected.");
        return zzb(googleApiClient, z);
    }

    /* JADX INFO: Access modifiers changed from: private */
    static abstract class zzd extends zza<Status> {
        private zzd(GoogleApiClient googleApiClient) {
            super(googleApiClient);
        }

        @Override // com.google.android.gms.common.api.internal.BasePendingResult
        public /* synthetic */ Result createFailedResult(Status status) {
            return status;
        }

        /* synthetic */ zzd(GoogleApiClient googleApiClient, zzi zziVar) {
            this(googleApiClient);
        }
    }

    public static com.google.android.gms.games.internal.zze zzb(GoogleApiClient googleApiClient, boolean z) {
        Preconditions.checkState(googleApiClient.hasApi(API), "GoogleApiClient is not configured to use the Games Api. Pass Games.API into GoogleApiClient.Builder#addApi() to use this feature.");
        boolean zHasConnectedApi = googleApiClient.hasConnectedApi(API);
        if (z && !zHasConnectedApi) {
            throw new IllegalStateException("GoogleApiClient has an optional Games.API and is not connected to Games. Use GoogleApiClient.hasConnectedApi(Games.API) to guard this call.");
        }
        if (zHasConnectedApi) {
            return (com.google.android.gms.games.internal.zze) googleApiClient.getClient(CLIENT_KEY);
        }
        return null;
    }

    public static final class GamesOptions implements GoogleSignInOptionsExtension, Api.ApiOptions.HasGoogleSignInAccountOptions, Api.ApiOptions.Optional {
        public final boolean zzar;
        public final boolean zzas;
        public final int zzat;
        public final boolean zzau;
        public final int zzav;
        public final String zzaw;
        public final ArrayList<String> zzax;
        public final boolean zzay;
        public final boolean zzaz;
        public final boolean zzba;
        public final GoogleSignInAccount zzbb;
        public final String zzbc;

        private GamesOptions(boolean z, boolean z2, int i, boolean z3, int i2, String str, ArrayList<String> arrayList, boolean z4, boolean z5, boolean z6, GoogleSignInAccount googleSignInAccount, String str2) {
            this.zzar = z;
            this.zzas = z2;
            this.zzat = i;
            this.zzau = z3;
            this.zzav = i2;
            this.zzaw = str;
            this.zzax = arrayList;
            this.zzay = z4;
            this.zzaz = z5;
            this.zzba = z6;
            this.zzbb = googleSignInAccount;
            this.zzbc = str2;
        }

        @Override // com.google.android.gms.auth.api.signin.GoogleSignInOptionsExtension
        public final int getExtensionType() {
            return 1;
        }

        public static final class Builder {
            private boolean zzar;
            private boolean zzas;
            private int zzat;
            private boolean zzau;
            private int zzav;
            private String zzaw;
            private ArrayList<String> zzax;
            private boolean zzay;
            private boolean zzaz;
            private boolean zzba;
            GoogleSignInAccount zzbb;
            private String zzbc;

            private Builder() {
                this.zzar = false;
                this.zzas = true;
                this.zzat = 17;
                this.zzau = false;
                this.zzav = 4368;
                this.zzaw = null;
                this.zzax = new ArrayList<>();
                this.zzay = false;
                this.zzaz = false;
                this.zzba = false;
                this.zzbb = null;
                this.zzbc = null;
            }

            private Builder(GamesOptions gamesOptions) {
                this.zzar = false;
                this.zzas = true;
                this.zzat = 17;
                this.zzau = false;
                this.zzav = 4368;
                this.zzaw = null;
                this.zzax = new ArrayList<>();
                this.zzay = false;
                this.zzaz = false;
                this.zzba = false;
                this.zzbb = null;
                this.zzbc = null;
                if (gamesOptions != null) {
                    this.zzar = gamesOptions.zzar;
                    this.zzas = gamesOptions.zzas;
                    this.zzat = gamesOptions.zzat;
                    this.zzau = gamesOptions.zzau;
                    this.zzav = gamesOptions.zzav;
                    this.zzaw = gamesOptions.zzaw;
                    this.zzax = gamesOptions.zzax;
                    this.zzay = gamesOptions.zzay;
                    this.zzaz = gamesOptions.zzaz;
                    this.zzba = gamesOptions.zzba;
                    this.zzbb = gamesOptions.zzbb;
                    this.zzbc = gamesOptions.zzbc;
                }
            }

            public final Builder setShowConnectingPopup(boolean z) {
                this.zzas = z;
                this.zzat = 17;
                return this;
            }

            public final Builder setShowConnectingPopup(boolean z, int i) {
                this.zzas = z;
                this.zzat = i;
                return this;
            }

            public final Builder setSdkVariant(int i) {
                this.zzav = i;
                return this;
            }

            public final GamesOptions build() {
                return new GamesOptions(this.zzar, this.zzas, this.zzat, this.zzau, this.zzav, this.zzaw, this.zzax, this.zzay, this.zzaz, this.zzba, this.zzbb, this.zzbc, null);
            }

            /* synthetic */ Builder(zzi zziVar) {
                this();
            }

            /* synthetic */ Builder(GamesOptions gamesOptions, zzi zziVar) {
                this((GamesOptions) null);
            }
        }

        public final boolean equals(Object obj) {
            if (obj == this) {
                return true;
            }
            if (!(obj instanceof GamesOptions)) {
                return false;
            }
            GamesOptions gamesOptions = (GamesOptions) obj;
            return this.zzar == gamesOptions.zzar && this.zzas == gamesOptions.zzas && this.zzat == gamesOptions.zzat && this.zzau == gamesOptions.zzau && this.zzav == gamesOptions.zzav && (this.zzaw != null ? this.zzaw.equals(gamesOptions.zzaw) : gamesOptions.zzaw == null) && this.zzax.equals(gamesOptions.zzax) && this.zzay == gamesOptions.zzay && this.zzaz == gamesOptions.zzaz && this.zzba == gamesOptions.zzba && (this.zzbb != null ? this.zzbb.equals(gamesOptions.zzbb) : gamesOptions.zzbb == null) && TextUtils.equals(this.zzbc, gamesOptions.zzbc);
        }

        public final int hashCode() {
            return (((((((((((((((((((((((this.zzar ? 1 : 0) + 527) * 31) + (this.zzas ? 1 : 0)) * 31) + this.zzat) * 31) + (this.zzau ? 1 : 0)) * 31) + this.zzav) * 31) + (this.zzaw == null ? 0 : this.zzaw.hashCode())) * 31) + this.zzax.hashCode()) * 31) + (this.zzay ? 1 : 0)) * 31) + (this.zzaz ? 1 : 0)) * 31) + (this.zzba ? 1 : 0)) * 31) + (this.zzbb == null ? 0 : this.zzbb.hashCode())) * 31) + (this.zzbc != null ? this.zzbc.hashCode() : 0);
        }

        @Override // com.google.android.gms.auth.api.signin.GoogleSignInOptionsExtension
        public final List<Scope> getImpliedScopes() {
            if (this.zzay) {
                return Collections.singletonList(Games.SCOPE_GAMES);
            }
            return Collections.singletonList(Games.SCOPE_GAMES_LITE);
        }

        @Override // com.google.android.gms.auth.api.signin.GoogleSignInOptionsExtension
        public final Bundle toBundle() {
            return zzg();
        }

        public final Bundle zzg() {
            Bundle bundle = new Bundle();
            bundle.putBoolean("com.google.android.gms.games.key.isHeadless", this.zzar);
            bundle.putBoolean("com.google.android.gms.games.key.showConnectingPopup", this.zzas);
            bundle.putInt("com.google.android.gms.games.key.connectingPopupGravity", this.zzat);
            bundle.putBoolean("com.google.android.gms.games.key.retryingSignIn", this.zzau);
            bundle.putInt("com.google.android.gms.games.key.sdkVariant", this.zzav);
            bundle.putString("com.google.android.gms.games.key.forceResolveAccountKey", this.zzaw);
            bundle.putStringArrayList("com.google.android.gms.games.key.proxyApis", this.zzax);
            bundle.putBoolean("com.google.android.gms.games.key.requireGooglePlus", this.zzay);
            bundle.putBoolean("com.google.android.gms.games.key.unauthenticated", this.zzaz);
            bundle.putBoolean("com.google.android.gms.games.key.skipWelcomePopup", this.zzba);
            bundle.putParcelable("com.google.android.gms.games.key.googleSignInAccount", this.zzbb);
            bundle.putString("com.google.android.gms.games.key.realClientPackageName", this.zzbc);
            return bundle;
        }

        public static Builder builder() {
            return new Builder((zzi) null);
        }

        @Override // com.google.android.gms.common.api.Api.ApiOptions.HasGoogleSignInAccountOptions
        public final GoogleSignInAccount getGoogleSignInAccount() {
            return this.zzbb;
        }

        /* synthetic */ GamesOptions(boolean z, boolean z2, int i, boolean z3, int i2, String str, ArrayList arrayList, boolean z4, boolean z5, boolean z6, GoogleSignInAccount googleSignInAccount, String str2, zzi zziVar) {
            this(z, z2, i, z3, i2, str, arrayList, z4, z5, z6, googleSignInAccount, str2);
        }
    }

    @Deprecated
    public static void setGravityForPopups(GoogleApiClient googleApiClient, int i) {
        com.google.android.gms.games.internal.zze zzeVarZza = zza(googleApiClient, false);
        if (zzeVarZza != null) {
            zzeVarZza.zzk(i);
        }
    }

    @Deprecated
    public static void setViewForPopups(GoogleApiClient googleApiClient, View view) {
        Preconditions.checkNotNull(view);
        com.google.android.gms.games.internal.zze zzeVarZza = zza(googleApiClient, false);
        if (zzeVarZza != null) {
            zzeVarZza.zza(view);
        }
    }

    @RequiresPermission("android.permission.GET_ACCOUNTS")
    @Deprecated
    public static String getCurrentAccountName(GoogleApiClient googleApiClient) {
        return zza(googleApiClient, true).zzav();
    }

    @KeepForSdk
    @Deprecated
    public static PendingResult<GetServerAuthCodeResult> getGamesServerAuthCode(GoogleApiClient googleApiClient, String str) {
        Preconditions.checkNotEmpty(str, "Please provide a valid serverClientId");
        return googleApiClient.execute(new zzk(googleApiClient, str));
    }

    @Deprecated
    public static String getAppId(GoogleApiClient googleApiClient) {
        return zza(googleApiClient, true).zzbs();
    }

    @Deprecated
    public static Intent getSettingsIntent(GoogleApiClient googleApiClient) {
        return zza(googleApiClient, true).zzbo();
    }

    @Deprecated
    public static PendingResult<Status> signOut(GoogleApiClient googleApiClient) {
        return googleApiClient.execute(new zzl(googleApiClient));
    }

    /* JADX WARN: Multi-variable type inference failed */
    private static GamesOptions zza(@NonNull GoogleSignInAccount googleSignInAccount) {
        GamesOptions.Builder builder = new GamesOptions.Builder(null, 0 == true ? 1 : 0);
        builder.zzbb = googleSignInAccount;
        return builder.setSdkVariant(1052947).build();
    }

    public static GamesMetadataClient getGamesMetadataClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new GamesMetadataClient(activity, zza(googleSignInAccount));
    }

    public static GamesMetadataClient getGamesMetadataClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new GamesMetadataClient(context, zza(googleSignInAccount));
    }

    public static AchievementsClient getAchievementsClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new AchievementsClient(activity, zza(googleSignInAccount));
    }

    public static AchievementsClient getAchievementsClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new AchievementsClient(context, zza(googleSignInAccount));
    }

    public static EventsClient getEventsClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new EventsClient(activity, zza(googleSignInAccount));
    }

    public static EventsClient getEventsClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new EventsClient(context, zza(googleSignInAccount));
    }

    public static LeaderboardsClient getLeaderboardsClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new LeaderboardsClient(activity, zza(googleSignInAccount));
    }

    public static LeaderboardsClient getLeaderboardsClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new LeaderboardsClient(context, zza(googleSignInAccount));
    }

    public static InvitationsClient getInvitationsClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new InvitationsClient(activity, zza(googleSignInAccount));
    }

    public static InvitationsClient getInvitationsClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new InvitationsClient(context, zza(googleSignInAccount));
    }

    public static TurnBasedMultiplayerClient getTurnBasedMultiplayerClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new TurnBasedMultiplayerClient(activity, zza(googleSignInAccount));
    }

    public static TurnBasedMultiplayerClient getTurnBasedMultiplayerClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new TurnBasedMultiplayerClient(context, zza(googleSignInAccount));
    }

    public static RealTimeMultiplayerClient getRealTimeMultiplayerClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new RealTimeMultiplayerClient(activity, zza(googleSignInAccount));
    }

    public static RealTimeMultiplayerClient getRealTimeMultiplayerClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new RealTimeMultiplayerClient(context, zza(googleSignInAccount));
    }

    public static PlayersClient getPlayersClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new PlayersClient(activity, zza(googleSignInAccount));
    }

    public static PlayersClient getPlayersClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new PlayersClient(context, zza(googleSignInAccount));
    }

    public static NotificationsClient getNotificationsClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new NotificationsClient(activity, zza(googleSignInAccount));
    }

    public static NotificationsClient getNotificationsClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new NotificationsClient(context, zza(googleSignInAccount));
    }

    public static SnapshotsClient getSnapshotsClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new SnapshotsClient(activity, zza(googleSignInAccount));
    }

    public static SnapshotsClient getSnapshotsClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new SnapshotsClient(context, zza(googleSignInAccount));
    }

    public static PlayerStatsClient getPlayerStatsClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new PlayerStatsClient(activity, zza(googleSignInAccount));
    }

    public static PlayerStatsClient getPlayerStatsClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new PlayerStatsClient(context, zza(googleSignInAccount));
    }

    public static VideosClient getVideosClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new VideosClient(activity, zza(googleSignInAccount));
    }

    public static VideosClient getVideosClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new VideosClient(context, zza(googleSignInAccount));
    }

    public static GamesClient getGamesClient(@NonNull Activity activity, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new GamesClient(activity, zza(googleSignInAccount));
    }

    public static GamesClient getGamesClient(@NonNull Context context, @NonNull GoogleSignInAccount googleSignInAccount) {
        Preconditions.checkNotNull(googleSignInAccount, "GoogleSignInAccount must not be null");
        return new GamesClient(context, zza(googleSignInAccount));
    }

    @Deprecated
    public static int getSdkVariant(GoogleApiClient googleApiClient) {
        return zza(googleApiClient, true).zzbq();
    }
}

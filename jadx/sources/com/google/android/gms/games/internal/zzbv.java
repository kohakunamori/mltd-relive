package com.google.android.gms.games.internal;

import android.content.Intent;
import android.os.Bundle;
import android.os.IBinder;
import android.os.Parcel;
import android.os.RemoteException;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.drive.Contents;
import com.google.android.gms.games.GamesActivityResultCodes;
import com.google.android.gms.games.GamesStatusCodes;
import com.google.android.gms.games.PlayerEntity;
import com.google.android.gms.games.multiplayer.ParticipantResult;
import com.google.android.gms.games.multiplayer.realtime.RoomEntity;
import com.google.android.gms.games.snapshot.SnapshotMetadataChangeEntity;
import com.google.android.gms.nearby.connection.ConnectionsStatusCodes;

/* JADX INFO: loaded from: classes.dex */
public final class zzbv extends com.google.android.gms.internal.games.zza implements zzbu {
    zzbv(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.games.internal.IGamesService");
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(long j) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeLong(j);
        zzb(5001, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        zzb(5002, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final String zzbr() throws RemoteException {
        Parcel parcelZza = zza(5003, zza());
        String string = parcelZza.readString();
        parcelZza.recycle();
        return string;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Bundle getConnectionHint() throws RemoteException {
        Parcel parcelZza = zza(5004, zza());
        Bundle bundle = (Bundle) com.google.android.gms.internal.games.zzc.zza(parcelZza, Bundle.CREATOR);
        parcelZza.recycle();
        return bundle;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(IBinder iBinder, Bundle bundle) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeStrongBinder(iBinder);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, bundle);
        zzb(5005, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzci() throws RemoteException {
        zzb(5006, zza());
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final String zzau() throws RemoteException {
        Parcel parcelZza = zza(5007, zza());
        String string = parcelZza.readString();
        parcelZza.recycle();
        return string;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final String zzck() throws RemoteException {
        Parcel parcelZza = zza(5012, zza());
        String string = parcelZza.readString();
        parcelZza.recycle();
        return string;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final DataHolder zzcl() throws RemoteException {
        Parcel parcelZza = zza(5013, zza());
        DataHolder dataHolder = (DataHolder) com.google.android.gms.internal.games.zzc.zza(parcelZza, DataHolder.CREATOR);
        parcelZza.recycle();
        return dataHolder;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, int i, boolean z, boolean z2) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeInt(i);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z2);
        zzb(5015, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, int i, int i2, int i3, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeInt(i);
        parcelZza.writeInt(i2);
        parcelZza.writeInt(i3);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(5019, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(zzbq zzbqVar, String str, int i, int i2, int i3, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeInt(i);
        parcelZza.writeInt(i2);
        parcelZza.writeInt(i3);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(5020, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, Bundle bundle, int i, int i2) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, bundle);
        parcelZza.writeInt(i);
        parcelZza.writeInt(i2);
        zzb(5021, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, IBinder iBinder, Bundle bundle) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeStrongBinder(iBinder);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, bundle);
        zzb(5023, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(zzbq zzbqVar, String str, IBinder iBinder, Bundle bundle) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeStrongBinder(iBinder);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, bundle);
        zzb(5024, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, int i, IBinder iBinder, Bundle bundle) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeInt(i);
        parcelZza.writeStrongBinder(iBinder);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, bundle);
        zzb(5025, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(zzbq zzbqVar) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        zzb(5026, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzd(String str, int i) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeString(str);
        parcelZza.writeInt(i);
        zzb(5028, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(String str, int i) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeString(str);
        parcelZza.writeInt(i);
        zzb(5029, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, long j) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeLong(j);
        zzb(5058, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(long j) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeLong(j);
        zzb(5059, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, IBinder iBinder, int i, String[] strArr, Bundle bundle, boolean z, long j) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeStrongBinder(iBinder);
        parcelZza.writeInt(i);
        parcelZza.writeStringArray(strArr);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, bundle);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, false);
        parcelZza.writeLong(j);
        zzb(5030, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, IBinder iBinder, String str, boolean z, long j) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeStrongBinder(iBinder);
        parcelZza.writeString(str);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, false);
        parcelZza.writeLong(j);
        zzb(5031, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        zzb(5032, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final int zza(zzbq zzbqVar, byte[] bArr, String str, String str2) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeByteArray(bArr);
        parcelZza.writeString(str);
        parcelZza.writeString(str2);
        Parcel parcelZza2 = zza(5033, parcelZza);
        int i = parcelZza2.readInt();
        parcelZza2.recycle();
        return i;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final int zzb(byte[] bArr, String str, String[] strArr) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeByteArray(bArr);
        parcelZza.writeString(str);
        parcelZza.writeStringArray(strArr);
        Parcel parcelZza2 = zza(5034, parcelZza);
        int i = parcelZza2.readInt();
        parcelZza2.recycle();
        return i;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzl(int i) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeInt(i);
        zzb(5036, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final DataHolder zzcm() throws RemoteException {
        Parcel parcelZza = zza(5502, zza());
        DataHolder dataHolder = (DataHolder) com.google.android.gms.internal.games.zzc.zza(parcelZza, DataHolder.CREATOR);
        parcelZza.recycle();
        return dataHolder;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(GamesStatusCodes.STATUS_MULTIPLAYER_ERROR_NOT_TRUSTED_TESTER, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(zzbq zzbqVar, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(GamesStatusCodes.STATUS_MATCH_ERROR_OUT_OF_DATE_VERSION, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(GamesStatusCodes.STATUS_MATCH_ERROR_INVALID_MATCH_RESULTS, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, long j, String str2) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeLong(j);
        parcelZza.writeString(str2);
        zzb(GamesStatusCodes.STATUS_INVALID_REAL_TIME_ROOM_ID, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(zzbq zzbqVar, String str, int i, IBinder iBinder, Bundle bundle) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeInt(i);
        parcelZza.writeStrongBinder(iBinder);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, bundle);
        zzb(GamesStatusCodes.STATUS_PARTICIPANT_NOT_CONNECTED, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, String str2, int i, int i2) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(null);
        parcelZza.writeString(str2);
        parcelZza.writeInt(i);
        parcelZza.writeInt(i2);
        zzb(8001, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzf(String str) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeString(str);
        zzb(8002, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, int i, int i2, String[] strArr, Bundle bundle) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeInt(i);
        parcelZza.writeInt(i2);
        parcelZza.writeStringArray(strArr);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, bundle);
        zzb(ConnectionsStatusCodes.STATUS_CONNECTION_REJECTED, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(zzbq zzbqVar, String str) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        zzb(ConnectionsStatusCodes.STATUS_NOT_CONNECTED_TO_ENDPOINT, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzc(zzbq zzbqVar, String str) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        zzb(8006, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, byte[] bArr, String str2, ParticipantResult[] participantResultArr) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeByteArray(bArr);
        parcelZza.writeString(str2);
        parcelZza.writeTypedArray(participantResultArr, 0);
        zzb(ConnectionsStatusCodes.STATUS_BLUETOOTH_ERROR, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, byte[] bArr, ParticipantResult[] participantResultArr) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeByteArray(bArr);
        parcelZza.writeTypedArray(participantResultArr, 0);
        zzb(ConnectionsStatusCodes.STATUS_ALREADY_HAVE_ACTIVE_STRATEGY, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzd(zzbq zzbqVar, String str) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        zzb(ConnectionsStatusCodes.STATUS_OUT_OF_ORDER_API_CALL, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zze(zzbq zzbqVar, String str) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        zzb(8010, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, String str2) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeString(str2);
        zzb(ConnectionsStatusCodes.STATUS_ENDPOINT_UNKNOWN, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(zzbq zzbqVar, long j) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeLong(j);
        zzb(ConnectionsStatusCodes.STATUS_ENDPOINT_IO_ERROR, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzc(long j) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeLong(j);
        zzb(ConnectionsStatusCodes.STATUS_PAYLOAD_IO_ERROR, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzf(zzbq zzbqVar, String str) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        zzb(8014, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final int zzbt() throws RemoteException {
        Parcel parcelZza = zza(8024, zza());
        int i = parcelZza.readInt();
        parcelZza.recycle();
        return i;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzc(zzbq zzbqVar, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(8027, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zzba() throws RemoteException {
        Parcel parcelZza = zza(GamesStatusCodes.STATUS_VIDEO_STORAGE_ERROR, zza());
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza, Intent.CREATOR);
        parcelZza.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zzbc() throws RemoteException {
        Parcel parcelZza = zza(9005, zza());
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza, Intent.CREATOR);
        parcelZza.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zzbd() throws RemoteException {
        Parcel parcelZza = zza(GamesStatusCodes.STATUS_VIDEO_ALREADY_CAPTURING, zza());
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza, Intent.CREATOR);
        parcelZza.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zzbe() throws RemoteException {
        Parcel parcelZza = zza(9007, zza());
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza, Intent.CREATOR);
        parcelZza.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zza(int i, int i2, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeInt(i);
        parcelZza.writeInt(i2);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        Parcel parcelZza2 = zza(9008, parcelZza);
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza2, Intent.CREATOR);
        parcelZza2.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zzc(int i, int i2, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeInt(i);
        parcelZza.writeInt(i2);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        Parcel parcelZza2 = zza(GamesStatusCodes.STATUS_VIDEO_OUT_OF_DISK_SPACE, parcelZza);
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza2, Intent.CREATOR);
        parcelZza2.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zzbl() throws RemoteException {
        Parcel parcelZza = zza(9010, zza());
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza, Intent.CREATOR);
        parcelZza.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zza(RoomEntity roomEntity, int i) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, roomEntity);
        parcelZza.writeInt(i);
        Parcel parcelZza2 = zza(9011, parcelZza);
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza2, Intent.CREATOR);
        parcelZza2.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zzbn() throws RemoteException {
        Parcel parcelZza = zza(9012, zza());
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza, Intent.CREATOR);
        parcelZza.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final int zzbp() throws RemoteException {
        Parcel parcelZza = zza(9019, zza());
        int i = parcelZza.readInt();
        parcelZza.recycle();
        return i;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, int i, boolean z, boolean z2) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeInt(i);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z2);
        zzb(9020, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzc(zzbq zzbqVar, long j) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeLong(j);
        zzb(GamesActivityResultCodes.RESULT_RECONNECT_REQUIRED, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzd(long j) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeLong(j);
        zzb(GamesActivityResultCodes.RESULT_SIGN_IN_FAILED, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String[] strArr) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeStringArray(strArr);
        zzb(GamesActivityResultCodes.RESULT_NETWORK_FAILURE, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(zzbq zzbqVar, String[] strArr) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeStringArray(strArr);
        zzb(GamesActivityResultCodes.RESULT_SEND_REQUEST_FAILED, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, int i, int i2, int i3) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeInt(i);
        parcelZza.writeInt(i2);
        parcelZza.writeInt(i3);
        zzb(10009, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zza(int i, byte[] bArr, int i2, String str) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeInt(i);
        parcelZza.writeByteArray(bArr);
        parcelZza.writeInt(i2);
        parcelZza.writeString(str);
        Parcel parcelZza2 = zza(10012, parcelZza);
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza2, Intent.CREATOR);
        parcelZza2.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final int zzbw() throws RemoteException {
        Parcel parcelZza = zza(10013, zza());
        int i = parcelZza.readInt();
        parcelZza.recycle();
        return i;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final int zzbx() throws RemoteException {
        Parcel parcelZza = zza(10023, zza());
        int i = parcelZza.readInt();
        parcelZza.recycle();
        return i;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zzbv() throws RemoteException {
        Parcel parcelZza = zza(10015, zza());
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza, Intent.CREATOR);
        parcelZza.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, int i) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeInt(i);
        zzb(10016, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, int i, int[] iArr) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeInt(i);
        parcelZza.writeIntArray(iArr);
        zzb(10018, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zza(String str, boolean z, boolean z2, int i) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeString(str);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z2);
        parcelZza.writeInt(i);
        Parcel parcelZza2 = zza(12001, parcelZza);
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza2, Intent.CREATOR);
        parcelZza2.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzd(zzbq zzbqVar, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(12002, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, SnapshotMetadataChangeEntity snapshotMetadataChangeEntity, Contents contents) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, snapshotMetadataChangeEntity);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, contents);
        zzb(12007, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(Contents contents) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, contents);
        zzb(12019, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzg(zzbq zzbqVar, String str) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        zzb(12020, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, String str2, SnapshotMetadataChangeEntity snapshotMetadataChangeEntity, Contents contents) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeString(str2);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, snapshotMetadataChangeEntity);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, contents);
        zzb(12033, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final int zzby() throws RemoteException {
        Parcel parcelZza = zza(12035, zza());
        int i = parcelZza.readInt();
        parcelZza.recycle();
        return i;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final int zzca() throws RemoteException {
        Parcel parcelZza = zza(12036, zza());
        int i = parcelZza.readInt();
        parcelZza.recycle();
        return i;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zze(zzbq zzbqVar, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(12016, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, boolean z, String[] strArr) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        parcelZza.writeStringArray(strArr);
        zzb(12031, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(String str, int i) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeString(str);
        parcelZza.writeInt(i);
        zzb(12017, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzh(zzbq zzbqVar, String str) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        zzb(12008, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(zzbq zzbqVar, String str, String str2) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        parcelZza.writeString(str2);
        zzb(12009, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, int[] iArr, int i, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeIntArray(iArr);
        parcelZza.writeInt(i);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(12010, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String[] strArr, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeStringArray(strArr);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(12029, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzd(zzbq zzbqVar, long j) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeLong(j);
        zzb(12011, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zze(long j) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeLong(j);
        zzb(12012, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zza(int[] iArr) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeIntArray(iArr);
        Parcel parcelZza2 = zza(12030, parcelZza);
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza2, Intent.CREATOR);
        parcelZza2.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zzd(String str) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeString(str);
        Parcel parcelZza2 = zza(12034, parcelZza);
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza2, Intent.CREATOR);
        parcelZza2.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(String str, IBinder iBinder, Bundle bundle) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeString(str);
        parcelZza.writeStrongBinder(iBinder);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, bundle);
        zzb(13002, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(zzbq zzbqVar, String str, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(13006, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbq zzbqVar, String str, boolean z, int i) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeString(str);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        parcelZza.writeInt(i);
        zzb(15001, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(zzbs zzbsVar, long j) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbsVar);
        parcelZza.writeLong(j);
        zzb(15501, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zza(PlayerEntity playerEntity) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, playerEntity);
        Parcel parcelZza2 = zza(15503, parcelZza);
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza2, Intent.CREATOR);
        parcelZza2.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzf(zzbq zzbqVar, boolean z) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        com.google.android.gms.internal.games.zzc.writeBoolean(parcelZza, z);
        zzb(17001, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zzb(String str, int i, int i2) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeString(str);
        parcelZza.writeInt(i);
        parcelZza.writeInt(i2);
        Parcel parcelZza2 = zza(18001, parcelZza);
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza2, Intent.CREATOR);
        parcelZza2.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final Intent zzcn() throws RemoteException {
        Parcel parcelZza = zza(19002, zza());
        Intent intent = (Intent) com.google.android.gms.internal.games.zzc.zza(parcelZza, Intent.CREATOR);
        parcelZza.recycle();
        return intent;
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zza(String str, zzbq zzbqVar) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeString(str);
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        zzb(20001, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzc(zzbq zzbqVar) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        zzb(21007, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzb(zzbq zzbqVar, int i) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeInt(i);
        zzb(22016, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zze(zzbq zzbqVar, long j) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        parcelZza.writeLong(j);
        zzb(22026, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzf(long j) throws RemoteException {
        Parcel parcelZza = zza();
        parcelZza.writeLong(j);
        zzb(22027, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final void zzd(zzbq zzbqVar) throws RemoteException {
        Parcel parcelZza = zza();
        com.google.android.gms.internal.games.zzc.zza(parcelZza, zzbqVar);
        zzb(22028, parcelZza);
    }

    @Override // com.google.android.gms.games.internal.zzbu
    public final boolean zzce() throws RemoteException {
        Parcel parcelZza = zza(22030, zza());
        boolean zZza = com.google.android.gms.internal.games.zzc.zza(parcelZza);
        parcelZza.recycle();
        return zZza;
    }
}

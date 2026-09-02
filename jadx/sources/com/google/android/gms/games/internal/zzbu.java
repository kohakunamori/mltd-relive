package com.google.android.gms.games.internal;

import android.content.Intent;
import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.RemoteException;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.drive.Contents;
import com.google.android.gms.games.PlayerEntity;
import com.google.android.gms.games.multiplayer.ParticipantResult;
import com.google.android.gms.games.multiplayer.realtime.RoomEntity;
import com.google.android.gms.games.snapshot.SnapshotMetadataChangeEntity;

/* JADX INFO: loaded from: classes.dex */
public interface zzbu extends IInterface {
    Bundle getConnectionHint() throws RemoteException;

    int zza(zzbq zzbqVar, byte[] bArr, String str, String str2) throws RemoteException;

    Intent zza(int i, int i2, boolean z) throws RemoteException;

    Intent zza(int i, byte[] bArr, int i2, String str) throws RemoteException;

    Intent zza(PlayerEntity playerEntity) throws RemoteException;

    Intent zza(RoomEntity roomEntity, int i) throws RemoteException;

    Intent zza(String str, boolean z, boolean z2, int i) throws RemoteException;

    Intent zza(int[] iArr) throws RemoteException;

    void zza(long j) throws RemoteException;

    void zza(IBinder iBinder, Bundle bundle) throws RemoteException;

    void zza(Contents contents) throws RemoteException;

    void zza(zzbq zzbqVar) throws RemoteException;

    void zza(zzbq zzbqVar, int i) throws RemoteException;

    void zza(zzbq zzbqVar, int i, int i2, int i3) throws RemoteException;

    void zza(zzbq zzbqVar, int i, int i2, String[] strArr, Bundle bundle) throws RemoteException;

    void zza(zzbq zzbqVar, int i, boolean z, boolean z2) throws RemoteException;

    void zza(zzbq zzbqVar, int i, int[] iArr) throws RemoteException;

    void zza(zzbq zzbqVar, long j) throws RemoteException;

    void zza(zzbq zzbqVar, Bundle bundle, int i, int i2) throws RemoteException;

    void zza(zzbq zzbqVar, IBinder iBinder, int i, String[] strArr, Bundle bundle, boolean z, long j) throws RemoteException;

    void zza(zzbq zzbqVar, IBinder iBinder, String str, boolean z, long j) throws RemoteException;

    void zza(zzbq zzbqVar, String str) throws RemoteException;

    void zza(zzbq zzbqVar, String str, int i, int i2, int i3, boolean z) throws RemoteException;

    void zza(zzbq zzbqVar, String str, int i, IBinder iBinder, Bundle bundle) throws RemoteException;

    void zza(zzbq zzbqVar, String str, int i, boolean z, boolean z2) throws RemoteException;

    void zza(zzbq zzbqVar, String str, long j, String str2) throws RemoteException;

    void zza(zzbq zzbqVar, String str, IBinder iBinder, Bundle bundle) throws RemoteException;

    void zza(zzbq zzbqVar, String str, SnapshotMetadataChangeEntity snapshotMetadataChangeEntity, Contents contents) throws RemoteException;

    void zza(zzbq zzbqVar, String str, String str2) throws RemoteException;

    void zza(zzbq zzbqVar, String str, String str2, int i, int i2) throws RemoteException;

    void zza(zzbq zzbqVar, String str, String str2, SnapshotMetadataChangeEntity snapshotMetadataChangeEntity, Contents contents) throws RemoteException;

    void zza(zzbq zzbqVar, String str, boolean z) throws RemoteException;

    void zza(zzbq zzbqVar, String str, boolean z, int i) throws RemoteException;

    void zza(zzbq zzbqVar, String str, byte[] bArr, String str2, ParticipantResult[] participantResultArr) throws RemoteException;

    void zza(zzbq zzbqVar, String str, byte[] bArr, ParticipantResult[] participantResultArr) throws RemoteException;

    void zza(zzbq zzbqVar, boolean z) throws RemoteException;

    void zza(zzbq zzbqVar, boolean z, String[] strArr) throws RemoteException;

    void zza(zzbq zzbqVar, int[] iArr, int i, boolean z) throws RemoteException;

    void zza(zzbq zzbqVar, String[] strArr) throws RemoteException;

    void zza(zzbq zzbqVar, String[] strArr, boolean z) throws RemoteException;

    void zza(zzbs zzbsVar, long j) throws RemoteException;

    void zza(String str, int i) throws RemoteException;

    void zza(String str, IBinder iBinder, Bundle bundle) throws RemoteException;

    void zza(String str, zzbq zzbqVar) throws RemoteException;

    String zzau() throws RemoteException;

    int zzb(byte[] bArr, String str, String[] strArr) throws RemoteException;

    Intent zzb(String str, int i, int i2) throws RemoteException;

    void zzb(long j) throws RemoteException;

    void zzb(zzbq zzbqVar) throws RemoteException;

    void zzb(zzbq zzbqVar, int i) throws RemoteException;

    void zzb(zzbq zzbqVar, long j) throws RemoteException;

    void zzb(zzbq zzbqVar, String str) throws RemoteException;

    void zzb(zzbq zzbqVar, String str, int i, int i2, int i3, boolean z) throws RemoteException;

    void zzb(zzbq zzbqVar, String str, int i, IBinder iBinder, Bundle bundle) throws RemoteException;

    void zzb(zzbq zzbqVar, String str, IBinder iBinder, Bundle bundle) throws RemoteException;

    void zzb(zzbq zzbqVar, String str, String str2) throws RemoteException;

    void zzb(zzbq zzbqVar, String str, boolean z) throws RemoteException;

    void zzb(zzbq zzbqVar, boolean z) throws RemoteException;

    void zzb(zzbq zzbqVar, String[] strArr) throws RemoteException;

    void zzb(String str, int i) throws RemoteException;

    Intent zzba() throws RemoteException;

    Intent zzbc() throws RemoteException;

    Intent zzbd() throws RemoteException;

    Intent zzbe() throws RemoteException;

    Intent zzbl() throws RemoteException;

    Intent zzbn() throws RemoteException;

    int zzbp() throws RemoteException;

    String zzbr() throws RemoteException;

    int zzbt() throws RemoteException;

    Intent zzbv() throws RemoteException;

    int zzbw() throws RemoteException;

    int zzbx() throws RemoteException;

    int zzby() throws RemoteException;

    Intent zzc(int i, int i2, boolean z) throws RemoteException;

    void zzc(long j) throws RemoteException;

    void zzc(zzbq zzbqVar) throws RemoteException;

    void zzc(zzbq zzbqVar, long j) throws RemoteException;

    void zzc(zzbq zzbqVar, String str) throws RemoteException;

    void zzc(zzbq zzbqVar, boolean z) throws RemoteException;

    int zzca() throws RemoteException;

    boolean zzce() throws RemoteException;

    void zzci() throws RemoteException;

    String zzck() throws RemoteException;

    DataHolder zzcl() throws RemoteException;

    DataHolder zzcm() throws RemoteException;

    Intent zzcn() throws RemoteException;

    Intent zzd(String str) throws RemoteException;

    void zzd(long j) throws RemoteException;

    void zzd(zzbq zzbqVar) throws RemoteException;

    void zzd(zzbq zzbqVar, long j) throws RemoteException;

    void zzd(zzbq zzbqVar, String str) throws RemoteException;

    void zzd(zzbq zzbqVar, boolean z) throws RemoteException;

    void zzd(String str, int i) throws RemoteException;

    void zze(long j) throws RemoteException;

    void zze(zzbq zzbqVar, long j) throws RemoteException;

    void zze(zzbq zzbqVar, String str) throws RemoteException;

    void zze(zzbq zzbqVar, boolean z) throws RemoteException;

    void zzf(long j) throws RemoteException;

    void zzf(zzbq zzbqVar, String str) throws RemoteException;

    void zzf(zzbq zzbqVar, boolean z) throws RemoteException;

    void zzf(String str) throws RemoteException;

    void zzg(zzbq zzbqVar, String str) throws RemoteException;

    void zzh(zzbq zzbqVar, String str) throws RemoteException;

    void zzl(int i) throws RemoteException;
}

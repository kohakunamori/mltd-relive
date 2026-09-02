package com.google.android.gms.games.snapshot;

import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.IOUtils;
import com.google.android.gms.drive.Contents;
import com.google.android.gms.games.internal.zzbd;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "SnapshotContentsEntityCreator")
@SafeParcelable.Reserved({1000})
public final class SnapshotContentsEntity extends com.google.android.gms.games.internal.zzd implements SnapshotContents {

    @SafeParcelable.Field(getter = "getContents", m22id = 1)
    private Contents zzrq;
    private static final Object zzrp = new Object();
    public static final Parcelable.Creator<SnapshotContentsEntity> CREATOR = new zza();

    @SafeParcelable.Constructor
    public SnapshotContentsEntity(@SafeParcelable.Param(m23id = 1) Contents contents) {
        this.zzrq = contents;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotContents
    public final ParcelFileDescriptor getParcelFileDescriptor() {
        Preconditions.checkState(!isClosed(), "Cannot mutate closed contents!");
        return this.zzrq.getParcelFileDescriptor();
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotContents
    public final Contents zzds() {
        return this.zzrq;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotContents
    public final void close() {
        this.zzrq = null;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotContents
    public final boolean isClosed() {
        return this.zzrq == null;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotContents
    public final byte[] readFully() throws IOException {
        byte[] inputStreamFully;
        Preconditions.checkState(!isClosed(), "Must provide a previously opened Snapshot");
        synchronized (zzrp) {
            FileInputStream fileInputStream = new FileInputStream(this.zzrq.getParcelFileDescriptor().getFileDescriptor());
            BufferedInputStream bufferedInputStream = new BufferedInputStream(fileInputStream);
            try {
                fileInputStream.getChannel().position(0L);
                inputStreamFully = IOUtils.readInputStreamFully(bufferedInputStream, false);
                fileInputStream.getChannel().position(0L);
            } catch (IOException e) {
                zzbd.m40w("SnapshotContentsEntity", "Failed to read snapshot data", e);
                throw e;
            }
        }
        return inputStreamFully;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotContents
    public final boolean writeBytes(byte[] bArr) {
        return zza(0, bArr, 0, bArr.length, true);
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotContents
    public final boolean modifyBytes(int i, byte[] bArr, int i2, int i3) {
        return zza(i, bArr, i2, bArr.length, false);
    }

    private final boolean zza(int i, byte[] bArr, int i2, int i3, boolean z) {
        Preconditions.checkState(!isClosed(), "Must provide a previously opened SnapshotContents");
        synchronized (zzrp) {
            FileOutputStream fileOutputStream = new FileOutputStream(this.zzrq.getParcelFileDescriptor().getFileDescriptor());
            BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(fileOutputStream);
            try {
                FileChannel channel = fileOutputStream.getChannel();
                channel.position(i);
                bufferedOutputStream.write(bArr, i2, i3);
                if (z) {
                    channel.truncate(bArr.length);
                }
                bufferedOutputStream.flush();
            } catch (IOException e) {
                zzbd.m38i("SnapshotContentsEntity", "Failed to write snapshot data", e);
                return false;
            }
        }
        return true;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, this.zzrq, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}

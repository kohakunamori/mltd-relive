package com.google.android.gms.drive.events;

import androidx.annotation.NonNull;
import com.google.android.gms.drive.DriveContents;

/* JADX INFO: loaded from: classes.dex */
public abstract class OpenFileCallback {
    public abstract void onContents(@NonNull DriveContents driveContents);

    public abstract void onError(@NonNull Exception exc);

    public abstract void onProgress(long j, long j2);
}

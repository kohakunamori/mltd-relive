package com.google.firebase.iid;

import android.os.Bundle;
import androidx.annotation.NonNull;
import com.google.android.gms.tasks.Continuation;
import com.google.android.gms.tasks.Task;
import java.io.IOException;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzo implements Continuation<Bundle, String> {
    private final /* synthetic */ zzk zza;

    zzo(zzk zzkVar) {
        this.zza = zzkVar;
    }

    @Override // com.google.android.gms.tasks.Continuation
    public final /* synthetic */ String then(@NonNull Task<Bundle> task) throws Exception {
        Bundle result = task.getResult(IOException.class);
        zzk zzkVar = this.zza;
        return zzk.zza(result);
    }
}

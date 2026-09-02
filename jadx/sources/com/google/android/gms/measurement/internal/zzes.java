package com.google.android.gms.measurement.internal;

import android.content.SharedPreferences;
import android.util.Pair;
import androidx.annotation.WorkerThread;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes.dex */
public final class zzes {
    private final /* synthetic */ zzeo zzmj;

    @VisibleForTesting
    private final String zzmk;
    private final String zzml;
    private final String zzmm;
    private final long zzmn;

    private zzes(zzeo zzeoVar, String str, long j) {
        this.zzmj = zzeoVar;
        Preconditions.checkNotEmpty(str);
        Preconditions.checkArgument(j > 0);
        this.zzmk = String.valueOf(str).concat(":start");
        this.zzml = String.valueOf(str).concat(":count");
        this.zzmm = String.valueOf(str).concat(":value");
        this.zzmn = j;
    }

    @WorkerThread
    private final void zzhk() {
        this.zzmj.zzo();
        long jCurrentTimeMillis = this.zzmj.zzx().currentTimeMillis();
        SharedPreferences.Editor editorEdit = this.zzmj.zzhb().edit();
        editorEdit.remove(this.zzml);
        editorEdit.remove(this.zzmm);
        editorEdit.putLong(this.zzmk, jCurrentTimeMillis);
        editorEdit.apply();
    }

    @WorkerThread
    public final void zzc(String str, long j) {
        this.zzmj.zzo();
        if (zzhm() == 0) {
            zzhk();
        }
        if (str == null) {
            str = "";
        }
        long j2 = this.zzmj.zzhb().getLong(this.zzml, 0L);
        if (j2 <= 0) {
            SharedPreferences.Editor editorEdit = this.zzmj.zzhb().edit();
            editorEdit.putString(this.zzmm, str);
            editorEdit.putLong(this.zzml, 1L);
            editorEdit.apply();
            return;
        }
        long j3 = j2 + 1;
        boolean z = (this.zzmj.zzz().zzjw().nextLong() & Long.MAX_VALUE) < Long.MAX_VALUE / j3;
        SharedPreferences.Editor editorEdit2 = this.zzmj.zzhb().edit();
        if (z) {
            editorEdit2.putString(this.zzmm, str);
        }
        editorEdit2.putLong(this.zzml, j3);
        editorEdit2.apply();
    }

    @WorkerThread
    public final Pair<String, Long> zzhl() {
        long jAbs;
        this.zzmj.zzo();
        this.zzmj.zzo();
        long jZzhm = zzhm();
        if (jZzhm == 0) {
            zzhk();
            jAbs = 0;
        } else {
            jAbs = Math.abs(jZzhm - this.zzmj.zzx().currentTimeMillis());
        }
        if (jAbs < this.zzmn) {
            return null;
        }
        if (jAbs > (this.zzmn << 1)) {
            zzhk();
            return null;
        }
        String string = this.zzmj.zzhb().getString(this.zzmm, null);
        long j = this.zzmj.zzhb().getLong(this.zzml, 0L);
        zzhk();
        if (string == null || j <= 0) {
            return zzeo.zzlg;
        }
        return new Pair<>(string, Long.valueOf(j));
    }

    @WorkerThread
    private final long zzhm() {
        return this.zzmj.zzhb().getLong(this.zzmk, 0L);
    }
}

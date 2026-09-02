package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzlu implements zzdb<zzlt> {
    private static zzlu zzatc = new zzlu();
    private final zzdb<zzlt> zzapj;

    public static boolean zzzz() {
        return ((zzlt) zzatc.get()).zzzz();
    }

    public static boolean zzaaa() {
        return ((zzlt) zzatc.get()).zzaaa();
    }

    public static boolean zzaab() {
        return ((zzlt) zzatc.get()).zzaab();
    }

    public static boolean zzaac() {
        return ((zzlt) zzatc.get()).zzaac();
    }

    private zzlu(zzdb<zzlt> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzlu() {
        this(zzda.zzg(new zzlw()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzlt get() {
        return this.zzapj.get();
    }
}

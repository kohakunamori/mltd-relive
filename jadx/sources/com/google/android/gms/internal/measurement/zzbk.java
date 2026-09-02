package com.google.android.gms.internal.measurement;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class zzbk {

    public static final class zza extends zzey<zza, C0528zza> implements zzgk {
        private static final zza zzun = new zza();
        private static volatile zzgr<zza> zzuo;
        private int zzue;
        private int zzuf;
        private String zzug = "";
        private zzff<zzb> zzuh = zzun();
        private boolean zzui;
        private zzc zzuj;
        private boolean zzuk;
        private boolean zzul;
        private boolean zzum;

        private zza() {
        }

        /* JADX INFO: renamed from: com.google.android.gms.internal.measurement.zzbk$zza$zza, reason: collision with other inner class name */
        public static final class C0528zza extends zzey.zza<zza, C0528zza> implements zzgk {
            private C0528zza() {
                super(zza.zzun);
            }

            public final String zzjz() {
                return ((zza) this.zzahx).zzjz();
            }

            public final C0528zza zzbs(String str) {
                zzuc();
                ((zza) this.zzahx).zzbt(str);
                return this;
            }

            public final int zzka() {
                return ((zza) this.zzahx).zzka();
            }

            public final zzb zze(int i) {
                return ((zza) this.zzahx).zze(i);
            }

            public final C0528zza zza(int i, zzb zzbVar) {
                zzuc();
                ((zza) this.zzahx).zzb(i, zzbVar);
                return this;
            }

            /* synthetic */ C0528zza(zzbj zzbjVar) {
                this();
            }
        }

        public final boolean zzkb() {
            return (this.zzue & 1) != 0;
        }

        public final int getId() {
            return this.zzuf;
        }

        public final String zzjz() {
            return this.zzug;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzbt(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 2;
            this.zzug = str;
        }

        public final List<zzb> zzkc() {
            return this.zzuh;
        }

        public final int zzka() {
            return this.zzuh.size();
        }

        public final zzb zze(int i) {
            return this.zzuh.get(i);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(int i, zzb zzbVar) {
            if (zzbVar == null) {
                throw new NullPointerException();
            }
            if (!this.zzuh.zzrx()) {
                this.zzuh = zzey.zza(this.zzuh);
            }
            this.zzuh.set(i, zzbVar);
        }

        public final boolean zzkd() {
            return (this.zzue & 8) != 0;
        }

        public final zzc zzke() {
            return this.zzuj == null ? zzc.zzle() : this.zzuj;
        }

        public final boolean zzkf() {
            return this.zzuk;
        }

        public final boolean zzkg() {
            return this.zzul;
        }

        public final boolean zzkh() {
            return (this.zzue & 64) != 0;
        }

        public final boolean zzki() {
            return this.zzum;
        }

        public static zza zza(byte[] bArr, zzel zzelVar) throws zzfi {
            return (zza) zzey.zza(zzun, bArr, zzelVar);
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbj zzbjVar = null;
            switch (zzbj.zzud[i - 1]) {
                case 1:
                    return new zza();
                case 2:
                    return new C0528zza(zzbjVar);
                case 3:
                    return zza(zzun, "\u0001\b\u0000\u0001\u0001\b\b\u0000\u0001\u0000\u0001\u0004\u0000\u0002\b\u0001\u0003\u001b\u0004\u0007\u0002\u0005\t\u0003\u0006\u0007\u0004\u0007\u0007\u0005\b\u0007\u0006", new Object[]{"zzue", "zzuf", "zzug", "zzuh", zzb.class, "zzui", "zzuj", "zzuk", "zzul", "zzum"});
                case 4:
                    return zzun;
                case 5:
                    zzgr<zza> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zza.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzun);
                                zzuo = zzcVar;
                            }
                            break;
                        }
                    }
                    return zzcVar;
                case 6:
                    return (byte) 1;
                case 7:
                    return null;
                default:
                    throw new UnsupportedOperationException();
            }
        }

        public static zzgr<zza> zzkj() {
            return (zzgr) zzun.zza(zzey.zzd.zzaij, (Object) null, (Object) null);
        }

        static {
            zzey.zza((Class<zza>) zza.class, zzun);
        }
    }

    public static final class zzb extends zzey<zzb, zza> implements zzgk {
        private static volatile zzgr<zzb> zzuo;
        private static final zzb zzut = new zzb();
        private int zzue;
        private zze zzup;
        private zzc zzuq;
        private boolean zzur;
        private String zzus = "";

        private zzb() {
        }

        public static final class zza extends zzey.zza<zzb, zza> implements zzgk {
            private zza() {
                super(zzb.zzut);
            }

            public final zza zzbu(String str) {
                zzuc();
                ((zzb) this.zzahx).zzbv(str);
                return this;
            }

            /* synthetic */ zza(zzbj zzbjVar) {
                this();
            }
        }

        public final boolean zzkl() {
            return (this.zzue & 1) != 0;
        }

        public final zze zzkm() {
            return this.zzup == null ? zze.zzls() : this.zzup;
        }

        public final boolean zzkn() {
            return (this.zzue & 2) != 0;
        }

        public final zzc zzko() {
            return this.zzuq == null ? zzc.zzle() : this.zzuq;
        }

        public final boolean zzkp() {
            return (this.zzue & 4) != 0;
        }

        public final boolean zzkq() {
            return this.zzur;
        }

        public final String zzkr() {
            return this.zzus;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzbv(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 8;
            this.zzus = str;
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbj zzbjVar = null;
            switch (zzbj.zzud[i - 1]) {
                case 1:
                    return new zzb();
                case 2:
                    return new zza(zzbjVar);
                case 3:
                    return zza(zzut, "\u0001\u0004\u0000\u0001\u0001\u0004\u0004\u0000\u0000\u0000\u0001\t\u0000\u0002\t\u0001\u0003\u0007\u0002\u0004\b\u0003", new Object[]{"zzue", "zzup", "zzuq", "zzur", "zzus"});
                case 4:
                    return zzut;
                case 5:
                    zzgr<zzb> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzb.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzut);
                                zzuo = zzcVar;
                            }
                            break;
                        }
                    }
                    return zzcVar;
                case 6:
                    return (byte) 1;
                case 7:
                    return null;
                default:
                    throw new UnsupportedOperationException();
            }
        }

        public static zzb zzks() {
            return zzut;
        }

        static {
            zzey.zza((Class<zzb>) zzb.class, zzut);
        }
    }

    public static final class zzc extends zzey<zzc, zza> implements zzgk {
        private static volatile zzgr<zzc> zzuo;
        private static final zzc zzuz = new zzc();
        private int zzue;
        private int zzuu;
        private boolean zzuv;
        private String zzuw = "";
        private String zzux = "";
        private String zzuy = "";

        public enum zzb implements zzfc {
            UNKNOWN_COMPARISON_TYPE(0),
            LESS_THAN(1),
            GREATER_THAN(2),
            EQUAL(3),
            BETWEEN(4);

            private static final zzfb<zzb> zzvf = new zzbl();
            private final int value;

            @Override // com.google.android.gms.internal.measurement.zzfc
            public final int zzlg() {
                return this.value;
            }

            public static zzb zzf(int i) {
                switch (i) {
                    case 0:
                        return UNKNOWN_COMPARISON_TYPE;
                    case 1:
                        return LESS_THAN;
                    case 2:
                        return GREATER_THAN;
                    case 3:
                        return EQUAL;
                    case 4:
                        return BETWEEN;
                    default:
                        return null;
                }
            }

            public static zzfe zzlh() {
                return zzbm.zzvk;
            }

            zzb(int i) {
                this.value = i;
            }
        }

        private zzc() {
        }

        public static final class zza extends zzey.zza<zzc, zza> implements zzgk {
            private zza() {
                super(zzc.zzuz);
            }

            /* synthetic */ zza(zzbj zzbjVar) {
                this();
            }
        }

        public final boolean zzku() {
            return (this.zzue & 1) != 0;
        }

        public final zzb zzkv() {
            zzb zzbVarZzf = zzb.zzf(this.zzuu);
            return zzbVarZzf == null ? zzb.UNKNOWN_COMPARISON_TYPE : zzbVarZzf;
        }

        public final boolean zzkw() {
            return (this.zzue & 2) != 0;
        }

        public final boolean zzkx() {
            return this.zzuv;
        }

        public final boolean zzky() {
            return (this.zzue & 4) != 0;
        }

        public final String zzkz() {
            return this.zzuw;
        }

        public final boolean zzla() {
            return (this.zzue & 8) != 0;
        }

        public final String zzlb() {
            return this.zzux;
        }

        public final boolean zzlc() {
            return (this.zzue & 16) != 0;
        }

        public final String zzld() {
            return this.zzuy;
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbj zzbjVar = null;
            switch (zzbj.zzud[i - 1]) {
                case 1:
                    return new zzc();
                case 2:
                    return new zza(zzbjVar);
                case 3:
                    return zza(zzuz, "\u0001\u0005\u0000\u0001\u0001\u0005\u0005\u0000\u0000\u0000\u0001\f\u0000\u0002\u0007\u0001\u0003\b\u0002\u0004\b\u0003\u0005\b\u0004", new Object[]{"zzue", "zzuu", zzb.zzlh(), "zzuv", "zzuw", "zzux", "zzuy"});
                case 4:
                    return zzuz;
                case 5:
                    zzgr<zzc> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzc.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzuz);
                                zzuo = zzcVar;
                            }
                            break;
                        }
                    }
                    return zzcVar;
                case 6:
                    return (byte) 1;
                case 7:
                    return null;
                default:
                    throw new UnsupportedOperationException();
            }
        }

        public static zzc zzle() {
            return zzuz;
        }

        static {
            zzey.zza((Class<zzc>) zzc.class, zzuz);
        }
    }

    public static final class zzd extends zzey<zzd, zza> implements zzgk {
        private static volatile zzgr<zzd> zzuo;
        private static final zzd zzvj = new zzd();
        private int zzue;
        private int zzuf;
        private boolean zzuk;
        private boolean zzul;
        private boolean zzum;
        private String zzvh = "";
        private zzb zzvi;

        private zzd() {
        }

        public static final class zza extends zzey.zza<zzd, zza> implements zzgk {
            private zza() {
                super(zzd.zzvj);
            }

            public final zza zzbw(String str) {
                zzuc();
                ((zzd) this.zzahx).setPropertyName(str);
                return this;
            }

            /* synthetic */ zza(zzbj zzbjVar) {
                this();
            }
        }

        public final boolean zzkb() {
            return (this.zzue & 1) != 0;
        }

        public final int getId() {
            return this.zzuf;
        }

        public final String getPropertyName() {
            return this.zzvh;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void setPropertyName(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 2;
            this.zzvh = str;
        }

        public final zzb zzli() {
            return this.zzvi == null ? zzb.zzks() : this.zzvi;
        }

        public final boolean zzkf() {
            return this.zzuk;
        }

        public final boolean zzkg() {
            return this.zzul;
        }

        public final boolean zzkh() {
            return (this.zzue & 32) != 0;
        }

        public final boolean zzki() {
            return this.zzum;
        }

        public static zzd zzb(byte[] bArr, zzel zzelVar) throws zzfi {
            return (zzd) zzey.zza(zzvj, bArr, zzelVar);
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbj zzbjVar = null;
            switch (zzbj.zzud[i - 1]) {
                case 1:
                    return new zzd();
                case 2:
                    return new zza(zzbjVar);
                case 3:
                    return zza(zzvj, "\u0001\u0006\u0000\u0001\u0001\u0006\u0006\u0000\u0000\u0000\u0001\u0004\u0000\u0002\b\u0001\u0003\t\u0002\u0004\u0007\u0003\u0005\u0007\u0004\u0006\u0007\u0005", new Object[]{"zzue", "zzuf", "zzvh", "zzvi", "zzuk", "zzul", "zzum"});
                case 4:
                    return zzvj;
                case 5:
                    zzgr<zzd> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzd.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzvj);
                                zzuo = zzcVar;
                            }
                            break;
                        }
                    }
                    return zzcVar;
                case 6:
                    return (byte) 1;
                case 7:
                    return null;
                default:
                    throw new UnsupportedOperationException();
            }
        }

        public static zzgr<zzd> zzkj() {
            return (zzgr) zzvj.zza(zzey.zzd.zzaij, (Object) null, (Object) null);
        }

        static {
            zzey.zza((Class<zzd>) zzd.class, zzvj);
        }
    }

    public static final class zze extends zzey<zze, zzb> implements zzgk {
        private static volatile zzgr<zze> zzuo;
        private static final zze zzvp = new zze();
        private int zzue;
        private int zzvl;
        private boolean zzvn;
        private String zzvm = "";
        private zzff<String> zzvo = zzey.zzun();

        public enum zza implements zzfc {
            UNKNOWN_MATCH_TYPE(0),
            REGEXP(1),
            BEGINS_WITH(2),
            ENDS_WITH(3),
            PARTIAL(4),
            EXACT(5),
            IN_LIST(6);

            private static final zzfb<zza> zzvf = new zzbo();
            private final int value;

            @Override // com.google.android.gms.internal.measurement.zzfc
            public final int zzlg() {
                return this.value;
            }

            public static zza zzh(int i) {
                switch (i) {
                    case 0:
                        return UNKNOWN_MATCH_TYPE;
                    case 1:
                        return REGEXP;
                    case 2:
                        return BEGINS_WITH;
                    case 3:
                        return ENDS_WITH;
                    case 4:
                        return PARTIAL;
                    case 5:
                        return EXACT;
                    case 6:
                        return IN_LIST;
                    default:
                        return null;
                }
            }

            public static zzfe zzlh() {
                return zzbn.zzvk;
            }

            zza(int i) {
                this.value = i;
            }
        }

        private zze() {
        }

        public static final class zzb extends zzey.zza<zze, zzb> implements zzgk {
            private zzb() {
                super(zze.zzvp);
            }

            /* synthetic */ zzb(zzbj zzbjVar) {
                this();
            }
        }

        public final boolean zzlk() {
            return (this.zzue & 1) != 0;
        }

        public final zza zzll() {
            zza zzaVarZzh = zza.zzh(this.zzvl);
            return zzaVarZzh == null ? zza.UNKNOWN_MATCH_TYPE : zzaVarZzh;
        }

        public final boolean zzlm() {
            return (this.zzue & 2) != 0;
        }

        public final String zzln() {
            return this.zzvm;
        }

        public final boolean zzlo() {
            return (this.zzue & 4) != 0;
        }

        public final boolean zzlp() {
            return this.zzvn;
        }

        public final List<String> zzlq() {
            return this.zzvo;
        }

        public final int zzlr() {
            return this.zzvo.size();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbj zzbjVar = null;
            switch (zzbj.zzud[i - 1]) {
                case 1:
                    return new zze();
                case 2:
                    return new zzb(zzbjVar);
                case 3:
                    return zza(zzvp, "\u0001\u0004\u0000\u0001\u0001\u0004\u0004\u0000\u0001\u0000\u0001\f\u0000\u0002\b\u0001\u0003\u0007\u0002\u0004\u001a", new Object[]{"zzue", "zzvl", zza.zzlh(), "zzvm", "zzvn", "zzvo"});
                case 4:
                    return zzvp;
                case 5:
                    zzgr<zze> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zze.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzvp);
                                zzuo = zzcVar;
                            }
                            break;
                        }
                    }
                    return zzcVar;
                case 6:
                    return (byte) 1;
                case 7:
                    return null;
                default:
                    throw new UnsupportedOperationException();
            }
        }

        public static zze zzls() {
            return zzvp;
        }

        static {
            zzey.zza((Class<zze>) zze.class, zzvp);
        }
    }
}

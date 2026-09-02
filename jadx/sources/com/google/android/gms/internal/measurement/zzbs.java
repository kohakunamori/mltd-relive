package com.google.android.gms.internal.measurement;

import com.google.android.gms.drive.DriveFile;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class zzbs {

    public static final class zza extends zzey<zza, C0530zza> implements zzgk {
        private static volatile zzgr<zza> zzuo;
        private static final zza zzwf = new zza();
        private int zzue;
        private int zzwb;
        private zzi zzwc;
        private zzi zzwd;
        private boolean zzwe;

        private zza() {
        }

        /* JADX INFO: renamed from: com.google.android.gms.internal.measurement.zzbs$zza$zza, reason: collision with other inner class name */
        public static final class C0530zza extends zzey.zza<zza, C0530zza> implements zzgk {
            private C0530zza() {
                super(zza.zzwf);
            }

            public final C0530zza zzi(int i) {
                zzuc();
                ((zza) this.zzahx).zzj(i);
                return this;
            }

            public final zzi zzlv() {
                return ((zza) this.zzahx).zzlv();
            }

            public final C0530zza zza(zzi.zza zzaVar) {
                zzuc();
                ((zza) this.zzahx).zzb(zzaVar);
                return this;
            }

            public final boolean zzlw() {
                return ((zza) this.zzahx).zzlw();
            }

            public final zzi zzlx() {
                return ((zza) this.zzahx).zzlx();
            }

            public final C0530zza zza(zzi zziVar) {
                zzuc();
                ((zza) this.zzahx).zzb(zziVar);
                return this;
            }

            public final C0530zza zzk(boolean z) {
                zzuc();
                ((zza) this.zzahx).zzl(z);
                return this;
            }

            /* synthetic */ C0530zza(zzbr zzbrVar) {
                this();
            }
        }

        public final boolean zzly() {
            return (this.zzue & 1) != 0;
        }

        public final int zzlz() {
            return this.zzwb;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzj(int i) {
            this.zzue |= 1;
            this.zzwb = i;
        }

        public final zzi zzlv() {
            return this.zzwc == null ? zzi.zzqi() : this.zzwc;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(zzi.zza zzaVar) {
            this.zzwc = (zzi) ((zzey) zzaVar.zzug());
            this.zzue |= 2;
        }

        public final boolean zzlw() {
            return (this.zzue & 4) != 0;
        }

        public final zzi zzlx() {
            return this.zzwd == null ? zzi.zzqi() : this.zzwd;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(zzi zziVar) {
            if (zziVar == null) {
                throw new NullPointerException();
            }
            this.zzwd = zziVar;
            this.zzue |= 4;
        }

        public final boolean zzma() {
            return (this.zzue & 8) != 0;
        }

        public final boolean zzmb() {
            return this.zzwe;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzl(boolean z) {
            this.zzue |= 8;
            this.zzwe = z;
        }

        public static C0530zza zzmc() {
            return zzwf.zzui();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbr zzbrVar = null;
            switch (zzbr.zzud[i - 1]) {
                case 1:
                    return new zza();
                case 2:
                    return new C0530zza(zzbrVar);
                case 3:
                    return zza(zzwf, "\u0001\u0004\u0000\u0001\u0001\u0004\u0004\u0000\u0000\u0000\u0001\u0004\u0000\u0002\t\u0001\u0003\t\u0002\u0004\u0007\u0003", new Object[]{"zzue", "zzwb", "zzwc", "zzwd", "zzwe"});
                case 4:
                    return zzwf;
                case 5:
                    zzgr<zza> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zza.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzwf);
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

        static {
            zzey.zza((Class<zza>) zza.class, zzwf);
        }
    }

    public static final class zzb extends zzey<zzb, zza> implements zzgk {
        private static volatile zzgr<zzb> zzuo;
        private static final zzb zzwi = new zzb();
        private int zzue;
        private int zzwg;
        private long zzwh;

        private zzb() {
        }

        public static final class zza extends zzey.zza<zzb, zza> implements zzgk {
            private zza() {
                super(zzb.zzwi);
            }

            public final zza zzk(int i) {
                zzuc();
                ((zzb) this.zzahx).setIndex(i);
                return this;
            }

            public final zza zzae(long j) {
                zzuc();
                ((zzb) this.zzahx).zzaf(j);
                return this;
            }

            /* synthetic */ zza(zzbr zzbrVar) {
                this();
            }
        }

        public final boolean zzme() {
            return (this.zzue & 1) != 0;
        }

        public final int getIndex() {
            return this.zzwg;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void setIndex(int i) {
            this.zzue |= 1;
            this.zzwg = i;
        }

        public final boolean zzmf() {
            return (this.zzue & 2) != 0;
        }

        public final long zzmg() {
            return this.zzwh;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzaf(long j) {
            this.zzue |= 2;
            this.zzwh = j;
        }

        public static zza zzmh() {
            return zzwi.zzui();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbr zzbrVar = null;
            switch (zzbr.zzud[i - 1]) {
                case 1:
                    return new zzb();
                case 2:
                    return new zza(zzbrVar);
                case 3:
                    return zza(zzwi, "\u0001\u0002\u0000\u0001\u0001\u0002\u0002\u0000\u0000\u0000\u0001\u0004\u0000\u0002\u0002\u0001", new Object[]{"zzue", "zzwg", "zzwh"});
                case 4:
                    return zzwi;
                case 5:
                    zzgr<zzb> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzb.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzwi);
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

        static {
            zzey.zza((Class<zzb>) zzb.class, zzwi);
        }
    }

    public static final class zzc extends zzey<zzc, zza> implements zzgk {
        private static volatile zzgr<zzc> zzuo;
        private static final zzc zzwo = new zzc();
        private int zzue;
        private zzff<zze> zzwj = zzun();
        private String zzwk = "";
        private long zzwl;
        private long zzwm;
        private int zzwn;

        private zzc() {
        }

        public static final class zza extends zzey.zza<zzc, zza> implements zzgk {
            private zza() {
                super(zzc.zzwo);
            }

            public final List<zze> zzmj() {
                return Collections.unmodifiableList(((zzc) this.zzahx).zzmj());
            }

            public final int zzmk() {
                return ((zzc) this.zzahx).zzmk();
            }

            public final zze zzl(int i) {
                return ((zzc) this.zzahx).zzl(i);
            }

            public final zza zza(int i, zze zzeVar) {
                zzuc();
                ((zzc) this.zzahx).zzb(i, zzeVar);
                return this;
            }

            public final zza zza(int i, zze.zza zzaVar) {
                zzuc();
                ((zzc) this.zzahx).zzb(i, zzaVar);
                return this;
            }

            public final zza zza(zze zzeVar) {
                zzuc();
                ((zzc) this.zzahx).zzb(zzeVar);
                return this;
            }

            public final zza zza(zze.zza zzaVar) {
                zzuc();
                ((zzc) this.zzahx).zzb(zzaVar);
                return this;
            }

            public final zza zzm(int i) {
                zzuc();
                ((zzc) this.zzahx).zzn(i);
                return this;
            }

            public final String getName() {
                return ((zzc) this.zzahx).getName();
            }

            public final zza zzbx(String str) {
                zzuc();
                ((zzc) this.zzahx).setName(str);
                return this;
            }

            public final boolean zzml() {
                return ((zzc) this.zzahx).zzml();
            }

            public final long getTimestampMillis() {
                return ((zzc) this.zzahx).getTimestampMillis();
            }

            public final zza zzag(long j) {
                zzuc();
                ((zzc) this.zzahx).zzai(j);
                return this;
            }

            public final long zzmm() {
                return ((zzc) this.zzahx).zzmm();
            }

            public final zza zzah(long j) {
                zzuc();
                ((zzc) this.zzahx).zzaj(j);
                return this;
            }

            /* synthetic */ zza(zzbr zzbrVar) {
                this();
            }
        }

        public final List<zze> zzmj() {
            return this.zzwj;
        }

        public final int zzmk() {
            return this.zzwj.size();
        }

        public final zze zzl(int i) {
            return this.zzwj.get(i);
        }

        private final void zzmn() {
            if (this.zzwj.zzrx()) {
                return;
            }
            this.zzwj = zzey.zza(this.zzwj);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(int i, zze zzeVar) {
            if (zzeVar == null) {
                throw new NullPointerException();
            }
            zzmn();
            this.zzwj.set(i, zzeVar);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(int i, zze.zza zzaVar) {
            zzmn();
            this.zzwj.set(i, (zze) ((zzey) zzaVar.zzug()));
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(zze zzeVar) {
            if (zzeVar == null) {
                throw new NullPointerException();
            }
            zzmn();
            this.zzwj.add(zzeVar);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(zze.zza zzaVar) {
            zzmn();
            this.zzwj.add((zze) ((zzey) zzaVar.zzug()));
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzn(int i) {
            zzmn();
            this.zzwj.remove(i);
        }

        public final String getName() {
            return this.zzwk;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void setName(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 1;
            this.zzwk = str;
        }

        public final boolean zzml() {
            return (this.zzue & 2) != 0;
        }

        public final long getTimestampMillis() {
            return this.zzwl;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzai(long j) {
            this.zzue |= 2;
            this.zzwl = j;
        }

        public final boolean zzmo() {
            return (this.zzue & 4) != 0;
        }

        public final long zzmm() {
            return this.zzwm;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzaj(long j) {
            this.zzue |= 4;
            this.zzwm = j;
        }

        public final boolean zzmp() {
            return (this.zzue & 8) != 0;
        }

        public final int getCount() {
            return this.zzwn;
        }

        public static zzc zzc(byte[] bArr, zzel zzelVar) throws zzfi {
            return (zzc) zzey.zza(zzwo, bArr, zzelVar);
        }

        public static zza zzmq() {
            return zzwo.zzui();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbr zzbrVar = null;
            switch (zzbr.zzud[i - 1]) {
                case 1:
                    return new zzc();
                case 2:
                    return new zza(zzbrVar);
                case 3:
                    return zza(zzwo, "\u0001\u0005\u0000\u0001\u0001\u0005\u0005\u0000\u0001\u0000\u0001\u001b\u0002\b\u0000\u0003\u0002\u0001\u0004\u0002\u0002\u0005\u0004\u0003", new Object[]{"zzue", "zzwj", zze.class, "zzwk", "zzwl", "zzwm", "zzwn"});
                case 4:
                    return zzwo;
                case 5:
                    zzgr<zzc> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzc.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzwo);
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

        static {
            zzey.zza((Class<zzc>) zzc.class, zzwo);
        }
    }

    public static final class zzd extends zzey<zzd, zza> implements zzgk {
        private static volatile zzgr<zzd> zzuo;
        private static final zzd zzwq = new zzd();
        private int zzue;
        private String zzwk = "";
        private long zzwp;

        private zzd() {
        }

        public static final class zza extends zzey.zza<zzd, zza> implements zzgk {
            private zza() {
                super(zzd.zzwq);
            }

            public final zza zzby(String str) {
                zzuc();
                ((zzd) this.zzahx).setName(str);
                return this;
            }

            public final zza zzak(long j) {
                zzuc();
                ((zzd) this.zzahx).zzal(j);
                return this;
            }

            /* synthetic */ zza(zzbr zzbrVar) {
                this();
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void setName(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 1;
            this.zzwk = str;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzal(long j) {
            this.zzue |= 2;
            this.zzwp = j;
        }

        public static zza zzms() {
            return zzwq.zzui();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbr zzbrVar = null;
            switch (zzbr.zzud[i - 1]) {
                case 1:
                    return new zzd();
                case 2:
                    return new zza(zzbrVar);
                case 3:
                    return zza(zzwq, "\u0001\u0002\u0000\u0001\u0001\u0002\u0002\u0000\u0000\u0000\u0001\b\u0000\u0002\u0002\u0001", new Object[]{"zzue", "zzwk", "zzwp"});
                case 4:
                    return zzwq;
                case 5:
                    zzgr<zzd> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzd.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzwq);
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

        static {
            zzey.zza((Class<zzd>) zzd.class, zzwq);
        }
    }

    public static final class zze extends zzey<zze, zza> implements zzgk {
        private static volatile zzgr<zze> zzuo;
        private static final zze zzwu = new zze();
        private int zzue;
        private long zzwp;
        private float zzws;
        private double zzwt;
        private String zzwk = "";
        private String zzwr = "";

        private zze() {
        }

        public static final class zza extends zzey.zza<zze, zza> implements zzgk {
            private zza() {
                super(zze.zzwu);
            }

            public final zza zzbz(String str) {
                zzuc();
                ((zze) this.zzahx).setName(str);
                return this;
            }

            public final zza zzca(String str) {
                zzuc();
                ((zze) this.zzahx).zzcb(str);
                return this;
            }

            public final zza zzmu() {
                zzuc();
                ((zze) this.zzahx).zzmz();
                return this;
            }

            public final zza zzam(long j) {
                zzuc();
                ((zze) this.zzahx).zzal(j);
                return this;
            }

            public final zza zzmv() {
                zzuc();
                ((zze) this.zzahx).zznc();
                return this;
            }

            public final zza zza(double d) {
                zzuc();
                ((zze) this.zzahx).zzb(d);
                return this;
            }

            public final zza zzmw() {
                zzuc();
                ((zze) this.zzahx).zznf();
                return this;
            }

            /* synthetic */ zza(zzbr zzbrVar) {
                this();
            }
        }

        public final String getName() {
            return this.zzwk;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void setName(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 1;
            this.zzwk = str;
        }

        public final boolean zzmx() {
            return (this.zzue & 2) != 0;
        }

        public final String zzmy() {
            return this.zzwr;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzcb(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 2;
            this.zzwr = str;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzmz() {
            this.zzue &= -3;
            this.zzwr = zzwu.zzwr;
        }

        public final boolean zzna() {
            return (this.zzue & 4) != 0;
        }

        public final long zznb() {
            return this.zzwp;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzal(long j) {
            this.zzue |= 4;
            this.zzwp = j;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zznc() {
            this.zzue &= -5;
            this.zzwp = 0L;
        }

        public final boolean zznd() {
            return (this.zzue & 16) != 0;
        }

        public final double zzne() {
            return this.zzwt;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(double d) {
            this.zzue |= 16;
            this.zzwt = d;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zznf() {
            this.zzue &= -17;
            this.zzwt = 0.0d;
        }

        public static zza zzng() {
            return zzwu.zzui();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbr zzbrVar = null;
            switch (zzbr.zzud[i - 1]) {
                case 1:
                    return new zze();
                case 2:
                    return new zza(zzbrVar);
                case 3:
                    return zza(zzwu, "\u0001\u0005\u0000\u0001\u0001\u0005\u0005\u0000\u0000\u0000\u0001\b\u0000\u0002\b\u0001\u0003\u0002\u0002\u0004\u0001\u0003\u0005\u0000\u0004", new Object[]{"zzue", "zzwk", "zzwr", "zzwp", "zzws", "zzwt"});
                case 4:
                    return zzwu;
                case 5:
                    zzgr<zze> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zze.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzwu);
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

        static {
            zzey.zza((Class<zze>) zze.class, zzwu);
        }
    }

    public static final class zzf extends zzey<zzf, zza> implements zzgk {
        private static volatile zzgr<zzf> zzuo;
        private static final zzf zzww = new zzf();
        private zzff<zzg> zzwv = zzun();

        private zzf() {
        }

        public static final class zza extends zzey.zza<zzf, zza> implements zzgk {
            private zza() {
                super(zzf.zzww);
            }

            public final zzg zzo(int i) {
                return ((zzf) this.zzahx).zzo(0);
            }

            public final zza zza(zzg.zza zzaVar) {
                zzuc();
                ((zzf) this.zzahx).zzb(zzaVar);
                return this;
            }

            /* synthetic */ zza(zzbr zzbrVar) {
                this();
            }
        }

        public final List<zzg> zzni() {
            return this.zzwv;
        }

        public final zzg zzo(int i) {
            return this.zzwv.get(0);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(zzg.zza zzaVar) {
            if (!this.zzwv.zzrx()) {
                this.zzwv = zzey.zza(this.zzwv);
            }
            this.zzwv.add((zzg) ((zzey) zzaVar.zzug()));
        }

        public static zza zznj() {
            return zzww.zzui();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbr zzbrVar = null;
            switch (zzbr.zzud[i - 1]) {
                case 1:
                    return new zzf();
                case 2:
                    return new zza(zzbrVar);
                case 3:
                    return zza(zzww, "\u0001\u0001\u0000\u0000\u0001\u0001\u0001\u0000\u0001\u0000\u0001\u001b", new Object[]{"zzwv", zzg.class});
                case 4:
                    return zzww;
                case 5:
                    zzgr<zzf> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzf.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzww);
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

        static {
            zzey.zza((Class<zzf>) zzf.class, zzww);
        }
    }

    public static final class zzg extends zzey<zzg, zza> implements zzgk {
        private static volatile zzgr<zzg> zzuo;
        private static final zzg zzyo = new zzg();
        private int zzue;
        private int zzwx;
        private int zzwy;
        private long zzxb;
        private long zzxc;
        private long zzxd;
        private long zzxe;
        private long zzxf;
        private int zzxk;
        private long zzxo;
        private long zzxp;
        private boolean zzxr;
        private long zzxt;
        private int zzxu;
        private boolean zzxx;
        private int zzya;
        private int zzyb;
        private int zzyc;
        private long zzye;
        private long zzyf;
        private int zzyi;
        private zzh zzyk;
        private long zzym;
        private long zzyn;
        private zzff<zzc> zzwz = zzun();
        private zzff<zzk> zzxa = zzun();
        private String zzxg = "";
        private String zzxh = "";
        private String zzxi = "";
        private String zzxj = "";
        private String zzxl = "";
        private String zzxm = "";
        private String zzxn = "";
        private String zzxq = "";
        private String zzxs = "";
        private String zzxv = "";
        private String zzxw = "";
        private zzff<zza> zzxy = zzun();
        private String zzxz = "";
        private String zzyd = "";
        private String zzyg = "";
        private String zzyh = "";
        private String zzyj = "";
        private zzfd zzyl = zzul();

        private zzg() {
        }

        public static final class zza extends zzey.zza<zzg, zza> implements zzgk {
            private zza() {
                super(zzg.zzyo);
            }

            public final zza zzp(int i) {
                zzuc();
                ((zzg) this.zzahx).zzx(1);
                return this;
            }

            public final List<zzc> zznl() {
                return Collections.unmodifiableList(((zzg) this.zzahx).zznl());
            }

            public final int zznm() {
                return ((zzg) this.zzahx).zznm();
            }

            public final zzc zzq(int i) {
                return ((zzg) this.zzahx).zzq(i);
            }

            public final zza zza(int i, zzc.zza zzaVar) {
                zzuc();
                ((zzg) this.zzahx).zzb(i, zzaVar);
                return this;
            }

            public final zza zza(zzc.zza zzaVar) {
                zzuc();
                ((zzg) this.zzahx).zzb(zzaVar);
                return this;
            }

            public final zza zza(Iterable<? extends zzc> iterable) {
                zzuc();
                ((zzg) this.zzahx).zze(iterable);
                return this;
            }

            public final zza zznn() {
                zzuc();
                ((zzg) this.zzahx).zzoa();
                return this;
            }

            public final zza zzr(int i) {
                zzuc();
                ((zzg) this.zzahx).zzy(i);
                return this;
            }

            public final List<zzk> zzno() {
                return Collections.unmodifiableList(((zzg) this.zzahx).zzno());
            }

            public final int zznp() {
                return ((zzg) this.zzahx).zznp();
            }

            public final zzk zzs(int i) {
                return ((zzg) this.zzahx).zzs(i);
            }

            public final zza zza(int i, zzk zzkVar) {
                zzuc();
                ((zzg) this.zzahx).zzb(i, zzkVar);
                return this;
            }

            public final zza zza(zzk zzkVar) {
                zzuc();
                ((zzg) this.zzahx).zzb(zzkVar);
                return this;
            }

            public final zza zza(zzk.zza zzaVar) {
                zzuc();
                ((zzg) this.zzahx).zzb(zzaVar);
                return this;
            }

            public final zza zzb(Iterable<? extends zzk> iterable) {
                zzuc();
                ((zzg) this.zzahx).zzf(iterable);
                return this;
            }

            public final zza zzan(long j) {
                zzuc();
                ((zzg) this.zzahx).zzaz(j);
                return this;
            }

            public final long zznq() {
                return ((zzg) this.zzahx).zznq();
            }

            public final zza zzao(long j) {
                zzuc();
                ((zzg) this.zzahx).zzba(j);
                return this;
            }

            public final long zznr() {
                return ((zzg) this.zzahx).zznr();
            }

            public final zza zzap(long j) {
                zzuc();
                ((zzg) this.zzahx).zzbb(j);
                return this;
            }

            public final zza zzaq(long j) {
                zzuc();
                ((zzg) this.zzahx).zzbc(j);
                return this;
            }

            public final zza zzns() {
                zzuc();
                ((zzg) this.zzahx).zzoi();
                return this;
            }

            public final zza zzar(long j) {
                zzuc();
                ((zzg) this.zzahx).zzbd(j);
                return this;
            }

            public final zza zznt() {
                zzuc();
                ((zzg) this.zzahx).zzol();
                return this;
            }

            public final zza zzcc(String str) {
                zzuc();
                ((zzg) this.zzahx).zzcr(str);
                return this;
            }

            public final zza zzcd(String str) {
                zzuc();
                ((zzg) this.zzahx).zzcs(str);
                return this;
            }

            public final zza zzce(String str) {
                zzuc();
                ((zzg) this.zzahx).zzct(str);
                return this;
            }

            public final zza zzcf(String str) {
                zzuc();
                ((zzg) this.zzahx).zzcu(str);
                return this;
            }

            public final zza zzt(int i) {
                zzuc();
                ((zzg) this.zzahx).zzz(i);
                return this;
            }

            public final zza zzcg(String str) {
                zzuc();
                ((zzg) this.zzahx).zzg(str);
                return this;
            }

            public final String zzag() {
                return ((zzg) this.zzahx).zzag();
            }

            public final zza zzch(String str) {
                zzuc();
                ((zzg) this.zzahx).zzcv(str);
                return this;
            }

            public final zza zzci(String str) {
                zzuc();
                ((zzg) this.zzahx).zzf(str);
                return this;
            }

            public final zza zzas(long j) {
                zzuc();
                ((zzg) this.zzahx).zzh(j);
                return this;
            }

            public final zza zzat(long j) {
                zzuc();
                ((zzg) this.zzahx).zzbe(j);
                return this;
            }

            public final zza zzcj(String str) {
                zzuc();
                ((zzg) this.zzahx).zzcw(str);
                return this;
            }

            public final zza zzm(boolean z) {
                zzuc();
                ((zzg) this.zzahx).zzo(z);
                return this;
            }

            public final zza zzck(String str) {
                zzuc();
                ((zzg) this.zzahx).zza(str);
                return this;
            }

            public final zza zzau(long j) {
                zzuc();
                ((zzg) this.zzahx).zzi(j);
                return this;
            }

            public final zza zzu(int i) {
                zzuc();
                ((zzg) this.zzahx).zzaa(i);
                return this;
            }

            public final zza zzcl(String str) {
                zzuc();
                ((zzg) this.zzahx).zzcx(str);
                return this;
            }

            public final zza zznu() {
                zzuc();
                ((zzg) this.zzahx).zzpa();
                return this;
            }

            public final String getGmpAppId() {
                return ((zzg) this.zzahx).getGmpAppId();
            }

            public final zza zzcm(String str) {
                zzuc();
                ((zzg) this.zzahx).zzb(str);
                return this;
            }

            public final zza zzn(boolean z) {
                zzuc();
                ((zzg) this.zzahx).zzp(z);
                return this;
            }

            public final zza zzc(Iterable<? extends zza> iterable) {
                zzuc();
                ((zzg) this.zzahx).zzg(iterable);
                return this;
            }

            public final zza zznv() {
                zzuc();
                ((zzg) this.zzahx).zzpe();
                return this;
            }

            public final zza zzcn(String str) {
                zzuc();
                ((zzg) this.zzahx).zze(str);
                return this;
            }

            public final zza zzv(int i) {
                zzuc();
                ((zzg) this.zzahx).zzab(i);
                return this;
            }

            public final zza zzco(String str) {
                zzuc();
                ((zzg) this.zzahx).zzcy(str);
                return this;
            }

            public final zza zzav(long j) {
                zzuc();
                ((zzg) this.zzahx).zzbf(j);
                return this;
            }

            public final zza zzaw(long j) {
                zzuc();
                ((zzg) this.zzahx).zzt(j);
                return this;
            }

            public final zza zzcp(String str) {
                zzuc();
                ((zzg) this.zzahx).zzcz(null);
                return this;
            }

            public final zza zznw() {
                zzuc();
                ((zzg) this.zzahx).zzpm();
                return this;
            }

            public final zza zzw(int i) {
                zzuc();
                ((zzg) this.zzahx).zzac(i);
                return this;
            }

            public final zza zzcq(String str) {
                zzuc();
                ((zzg) this.zzahx).zzda(str);
                return this;
            }

            public final zza zza(zzh.zza zzaVar) {
                zzuc();
                ((zzg) this.zzahx).zzb(zzaVar);
                return this;
            }

            public final zza zzd(Iterable<? extends Integer> iterable) {
                zzuc();
                ((zzg) this.zzahx).zzh(iterable);
                return this;
            }

            public final zza zzax(long j) {
                zzuc();
                ((zzg) this.zzahx).zzj(j);
                return this;
            }

            public final zza zzay(long j) {
                zzuc();
                ((zzg) this.zzahx).zzbg(j);
                return this;
            }

            /* synthetic */ zza(zzbr zzbrVar) {
                this();
            }
        }

        public final boolean zznx() {
            return (this.zzue & 1) != 0;
        }

        public final int zzny() {
            return this.zzwy;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzx(int i) {
            this.zzue |= 1;
            this.zzwy = i;
        }

        public final List<zzc> zznl() {
            return this.zzwz;
        }

        public final int zznm() {
            return this.zzwz.size();
        }

        public final zzc zzq(int i) {
            return this.zzwz.get(i);
        }

        private final void zznz() {
            if (this.zzwz.zzrx()) {
                return;
            }
            this.zzwz = zzey.zza(this.zzwz);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(int i, zzc.zza zzaVar) {
            zznz();
            this.zzwz.set(i, (zzc) ((zzey) zzaVar.zzug()));
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(zzc.zza zzaVar) {
            zznz();
            this.zzwz.add((zzc) ((zzey) zzaVar.zzug()));
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zze(Iterable<? extends zzc> iterable) {
            zznz();
            zzdf.zza(iterable, this.zzwz);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzoa() {
            this.zzwz = zzun();
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzy(int i) {
            zznz();
            this.zzwz.remove(i);
        }

        public final List<zzk> zzno() {
            return this.zzxa;
        }

        public final int zznp() {
            return this.zzxa.size();
        }

        public final zzk zzs(int i) {
            return this.zzxa.get(i);
        }

        private final void zzob() {
            if (this.zzxa.zzrx()) {
                return;
            }
            this.zzxa = zzey.zza(this.zzxa);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(int i, zzk zzkVar) {
            if (zzkVar == null) {
                throw new NullPointerException();
            }
            zzob();
            this.zzxa.set(i, zzkVar);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(zzk zzkVar) {
            if (zzkVar == null) {
                throw new NullPointerException();
            }
            zzob();
            this.zzxa.add(zzkVar);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(zzk.zza zzaVar) {
            zzob();
            this.zzxa.add((zzk) ((zzey) zzaVar.zzug()));
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzf(Iterable<? extends zzk> iterable) {
            zzob();
            zzdf.zza(iterable, this.zzxa);
        }

        public final boolean zzoc() {
            return (this.zzue & 2) != 0;
        }

        public final long zzod() {
            return this.zzxb;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzaz(long j) {
            this.zzue |= 2;
            this.zzxb = j;
        }

        public final boolean zzoe() {
            return (this.zzue & 4) != 0;
        }

        public final long zznq() {
            return this.zzxc;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzba(long j) {
            this.zzue |= 4;
            this.zzxc = j;
        }

        public final boolean zzof() {
            return (this.zzue & 8) != 0;
        }

        public final long zznr() {
            return this.zzxd;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzbb(long j) {
            this.zzue |= 8;
            this.zzxd = j;
        }

        public final boolean zzog() {
            return (this.zzue & 16) != 0;
        }

        public final long zzoh() {
            return this.zzxe;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzbc(long j) {
            this.zzue |= 16;
            this.zzxe = j;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzoi() {
            this.zzue &= -17;
            this.zzxe = 0L;
        }

        public final boolean zzoj() {
            return (this.zzue & 32) != 0;
        }

        public final long zzok() {
            return this.zzxf;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzbd(long j) {
            this.zzue |= 32;
            this.zzxf = j;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzol() {
            this.zzue &= -33;
            this.zzxf = 0L;
        }

        public final String zzom() {
            return this.zzxg;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzcr(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 64;
            this.zzxg = str;
        }

        public final String getOsVersion() {
            return this.zzxh;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzcs(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 128;
            this.zzxh = str;
        }

        public final String zzon() {
            return this.zzxi;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzct(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 256;
            this.zzxi = str;
        }

        public final String zzcr() {
            return this.zzxj;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzcu(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 512;
            this.zzxj = str;
        }

        public final boolean zzoo() {
            return (this.zzue & 1024) != 0;
        }

        public final int zzop() {
            return this.zzxk;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzz(int i) {
            this.zzue |= 1024;
            this.zzxk = i;
        }

        public final String zzan() {
            return this.zzxl;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzg(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 2048;
            this.zzxl = str;
        }

        public final String zzag() {
            return this.zzxm;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzcv(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 4096;
            this.zzxm = str;
        }

        public final String zzal() {
            return this.zzxn;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzf(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 8192;
            this.zzxn = str;
        }

        public final boolean zzoq() {
            return (this.zzue & 16384) != 0;
        }

        public final long zzao() {
            return this.zzxo;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzh(long j) {
            this.zzue |= 16384;
            this.zzxo = j;
        }

        public final boolean zzor() {
            return (this.zzue & 32768) != 0;
        }

        public final long zzos() {
            return this.zzxp;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzbe(long j) {
            this.zzue |= 32768;
            this.zzxp = j;
        }

        public final String zzot() {
            return this.zzxq;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzcw(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 65536;
            this.zzxq = str;
        }

        public final boolean zzou() {
            return (this.zzue & 131072) != 0;
        }

        public final boolean zzov() {
            return this.zzxr;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzo(boolean z) {
            this.zzue |= 131072;
            this.zzxr = z;
        }

        public final String getAppInstanceId() {
            return this.zzxs;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zza(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 262144;
            this.zzxs = str;
        }

        public final boolean zzow() {
            return (this.zzue & 524288) != 0;
        }

        public final long zzap() {
            return this.zzxt;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzi(long j) {
            this.zzue |= 524288;
            this.zzxt = j;
        }

        public final boolean zzox() {
            return (this.zzue & 1048576) != 0;
        }

        public final int zzoy() {
            return this.zzxu;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzaa(int i) {
            this.zzue |= 1048576;
            this.zzxu = i;
        }

        public final String zzoz() {
            return this.zzxv;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzcx(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 2097152;
            this.zzxv = str;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzpa() {
            this.zzue &= -2097153;
            this.zzxv = zzyo.zzxv;
        }

        public final String getGmpAppId() {
            return this.zzxw;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 4194304;
            this.zzxw = str;
        }

        public final boolean zzpb() {
            return (this.zzue & 8388608) != 0;
        }

        public final boolean zzpc() {
            return this.zzxx;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzp(boolean z) {
            this.zzue |= 8388608;
            this.zzxx = z;
        }

        public final List<zza> zzpd() {
            return this.zzxy;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzg(Iterable<? extends zza> iterable) {
            if (!this.zzxy.zzrx()) {
                this.zzxy = zzey.zza(this.zzxy);
            }
            zzdf.zza(iterable, this.zzxy);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzpe() {
            this.zzxy = zzun();
        }

        public final String getFirebaseInstanceId() {
            return this.zzxz;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zze(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 16777216;
            this.zzxz = str;
        }

        public final boolean zzpf() {
            return (this.zzue & 33554432) != 0;
        }

        public final int zzpg() {
            return this.zzya;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzab(int i) {
            this.zzue |= 33554432;
            this.zzya = i;
        }

        public final String zzph() {
            return this.zzyd;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzcy(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= DriveFile.MODE_READ_ONLY;
            this.zzyd = str;
        }

        public final boolean zzpi() {
            return (this.zzue & DriveFile.MODE_WRITE_ONLY) != 0;
        }

        public final long zzpj() {
            return this.zzye;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzbf(long j) {
            this.zzue |= DriveFile.MODE_WRITE_ONLY;
            this.zzye = j;
        }

        public final boolean zzpk() {
            return (this.zzue & 1073741824) != 0;
        }

        public final long zzbd() {
            return this.zzyf;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzt(long j) {
            this.zzue |= 1073741824;
            this.zzyf = j;
        }

        public final String zzpl() {
            return this.zzyg;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzcz(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= Integer.MIN_VALUE;
            this.zzyg = str;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzpm() {
            this.zzue &= Integer.MAX_VALUE;
            this.zzyg = zzyo.zzyg;
        }

        public final boolean zzpn() {
            return (this.zzwx & 2) != 0;
        }

        public final int zzpo() {
            return this.zzyi;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzac(int i) {
            this.zzwx |= 2;
            this.zzyi = i;
        }

        public final String zzpp() {
            return this.zzyj;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzda(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzwx |= 4;
            this.zzyj = str;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(zzh.zza zzaVar) {
            this.zzyk = (zzh) ((zzey) zzaVar.zzug());
            this.zzwx |= 8;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzh(Iterable<? extends Integer> iterable) {
            if (!this.zzyl.zzrx()) {
                zzfd zzfdVar = this.zzyl;
                int size = zzfdVar.size();
                this.zzyl = zzfdVar.zzap(size == 0 ? 10 : size << 1);
            }
            zzdf.zza(iterable, this.zzyl);
        }

        public final boolean zzpq() {
            return (this.zzwx & 16) != 0;
        }

        public final long zzaq() {
            return this.zzym;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzj(long j) {
            this.zzwx |= 16;
            this.zzym = j;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzbg(long j) {
            this.zzwx |= 32;
            this.zzyn = j;
        }

        public static zzg zzd(byte[] bArr, zzel zzelVar) throws zzfi {
            return (zzg) zzey.zza(zzyo, bArr, zzelVar);
        }

        public static zza zzpr() {
            return zzyo.zzui();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbr zzbrVar = null;
            switch (zzbr.zzud[i - 1]) {
                case 1:
                    return new zzg();
                case 2:
                    return new zza(zzbrVar);
                case 3:
                    return zza(zzyo, "\u0001*\u0000\u0002\u0001/*\u0000\u0004\u0000\u0001\u0004\u0000\u0002\u001b\u0003\u001b\u0004\u0002\u0001\u0005\u0002\u0002\u0006\u0002\u0003\u0007\u0002\u0005\b\b\u0006\t\b\u0007\n\b\b\u000b\b\t\f\u0004\n\r\b\u000b\u000e\b\f\u0010\b\r\u0011\u0002\u000e\u0012\u0002\u000f\u0013\b\u0010\u0014\u0007\u0011\u0015\b\u0012\u0016\u0002\u0013\u0017\u0004\u0014\u0018\b\u0015\u0019\b\u0016\u001a\u0002\u0004\u001c\u0007\u0017\u001d\u001b\u001e\b\u0018\u001f\u0004\u0019 \u0004\u001a!\u0004\u001b\"\b\u001c#\u0002\u001d$\u0002\u001e%\b\u001f&\b '\u0004!)\b\",\t#-\u001d.\u0002$/\u0002%", new Object[]{"zzue", "zzwx", "zzwy", "zzwz", zzc.class, "zzxa", zzk.class, "zzxb", "zzxc", "zzxd", "zzxf", "zzxg", "zzxh", "zzxi", "zzxj", "zzxk", "zzxl", "zzxm", "zzxn", "zzxo", "zzxp", "zzxq", "zzxr", "zzxs", "zzxt", "zzxu", "zzxv", "zzxw", "zzxe", "zzxx", "zzxy", zza.class, "zzxz", "zzya", "zzyb", "zzyc", "zzyd", "zzye", "zzyf", "zzyg", "zzyh", "zzyi", "zzyj", "zzyk", "zzyl", "zzym", "zzyn"});
                case 4:
                    return zzyo;
                case 5:
                    zzgr<zzg> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzg.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzyo);
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

        static {
            zzey.zza((Class<zzg>) zzg.class, zzyo);
        }
    }

    public static final class zzh extends zzey<zzh, zza> implements zzgk {
        private static volatile zzgr<zzh> zzuo;
        private static final zzh zzyr = new zzh();
        private int zzue;
        private int zzyp = 1;
        private zzff<zzd> zzyq = zzun();

        public enum zzb implements zzfc {
            RADS(1),
            PROVISIONING(2);

            private static final zzfb<zzb> zzvf = new zzbt();
            private final int value;

            @Override // com.google.android.gms.internal.measurement.zzfc
            public final int zzlg() {
                return this.value;
            }

            public static zzb zzad(int i) {
                switch (i) {
                    case 1:
                        return RADS;
                    case 2:
                        return PROVISIONING;
                    default:
                        return null;
                }
            }

            public static zzfe zzlh() {
                return zzbu.zzvk;
            }

            zzb(int i) {
                this.value = i;
            }
        }

        private zzh() {
        }

        public static final class zza extends zzey.zza<zzh, zza> implements zzgk {
            private zza() {
                super(zzh.zzyr);
            }

            public final zza zza(zzd.zza zzaVar) {
                zzuc();
                ((zzh) this.zzahx).zzb(zzaVar);
                return this;
            }

            /* synthetic */ zza(zzbr zzbrVar) {
                this();
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(zzd.zza zzaVar) {
            if (!this.zzyq.zzrx()) {
                this.zzyq = zzey.zza(this.zzyq);
            }
            this.zzyq.add((zzd) ((zzey) zzaVar.zzug()));
        }

        public static zza zzpt() {
            return zzyr.zzui();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbr zzbrVar = null;
            switch (zzbr.zzud[i - 1]) {
                case 1:
                    return new zzh();
                case 2:
                    return new zza(zzbrVar);
                case 3:
                    return zza(zzyr, "\u0001\u0002\u0000\u0001\u0001\u0002\u0002\u0000\u0001\u0000\u0001\f\u0000\u0002\u001b", new Object[]{"zzue", "zzyp", zzb.zzlh(), "zzyq", zzd.class});
                case 4:
                    return zzyr;
                case 5:
                    zzgr<zzh> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzh.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzyr);
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

        static {
            zzey.zza((Class<zzh>) zzh.class, zzyr);
        }
    }

    public static final class zzi extends zzey<zzi, zza> implements zzgk {
        private static volatile zzgr<zzi> zzuo;
        private static final zzi zzyz = new zzi();
        private zzfg zzyv = zzum();
        private zzfg zzyw = zzum();
        private zzff<zzb> zzyx = zzun();
        private zzff<zzj> zzyy = zzun();

        private zzi() {
        }

        public static final class zza extends zzey.zza<zzi, zza> implements zzgk {
            private zza() {
                super(zzi.zzyz);
            }

            public final zza zzn(Iterable<? extends Long> iterable) {
                zzuc();
                ((zzi) this.zzahx).zzi(iterable);
                return this;
            }

            public final zza zzqq() {
                zzuc();
                ((zzi) this.zzahx).zzpx();
                return this;
            }

            public final zza zzo(Iterable<? extends Long> iterable) {
                zzuc();
                ((zzi) this.zzahx).zzj(iterable);
                return this;
            }

            public final zza zzqr() {
                zzuc();
                ((zzi) this.zzahx).zzqa();
                return this;
            }

            public final zza zzp(Iterable<? extends zzb> iterable) {
                zzuc();
                ((zzi) this.zzahx).zzk(iterable);
                return this;
            }

            public final zza zzaj(int i) {
                zzuc();
                ((zzi) this.zzahx).zzaf(i);
                return this;
            }

            public final zza zzq(Iterable<? extends zzj> iterable) {
                zzuc();
                ((zzi) this.zzahx).zzl(iterable);
                return this;
            }

            public final zza zzak(int i) {
                zzuc();
                ((zzi) this.zzahx).zzah(i);
                return this;
            }

            /* synthetic */ zza(zzbr zzbrVar) {
                this();
            }
        }

        public final List<Long> zzpv() {
            return this.zzyv;
        }

        public final int zzpw() {
            return this.zzyv.size();
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzi(Iterable<? extends Long> iterable) {
            if (!this.zzyv.zzrx()) {
                this.zzyv = zzey.zza(this.zzyv);
            }
            zzdf.zza(iterable, this.zzyv);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzpx() {
            this.zzyv = zzum();
        }

        public final List<Long> zzpy() {
            return this.zzyw;
        }

        public final int zzpz() {
            return this.zzyw.size();
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzj(Iterable<? extends Long> iterable) {
            if (!this.zzyw.zzrx()) {
                this.zzyw = zzey.zza(this.zzyw);
            }
            zzdf.zza(iterable, this.zzyw);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzqa() {
            this.zzyw = zzum();
        }

        public final List<zzb> zzqb() {
            return this.zzyx;
        }

        public final int zzqc() {
            return this.zzyx.size();
        }

        public final zzb zzae(int i) {
            return this.zzyx.get(i);
        }

        private final void zzqd() {
            if (this.zzyx.zzrx()) {
                return;
            }
            this.zzyx = zzey.zza(this.zzyx);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzk(Iterable<? extends zzb> iterable) {
            zzqd();
            zzdf.zza(iterable, this.zzyx);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzaf(int i) {
            zzqd();
            this.zzyx.remove(i);
        }

        public final List<zzj> zzqe() {
            return this.zzyy;
        }

        public final int zzqf() {
            return this.zzyy.size();
        }

        public final zzj zzag(int i) {
            return this.zzyy.get(i);
        }

        private final void zzqg() {
            if (this.zzyy.zzrx()) {
                return;
            }
            this.zzyy = zzey.zza(this.zzyy);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzl(Iterable<? extends zzj> iterable) {
            zzqg();
            zzdf.zza(iterable, this.zzyy);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzah(int i) {
            zzqg();
            this.zzyy.remove(i);
        }

        public static zzi zze(byte[] bArr, zzel zzelVar) throws zzfi {
            return (zzi) zzey.zza(zzyz, bArr, zzelVar);
        }

        public static zza zzqh() {
            return zzyz.zzui();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbr zzbrVar = null;
            switch (zzbr.zzud[i - 1]) {
                case 1:
                    return new zzi();
                case 2:
                    return new zza(zzbrVar);
                case 3:
                    return zza(zzyz, "\u0001\u0004\u0000\u0000\u0001\u0004\u0004\u0000\u0004\u0000\u0001\u0015\u0002\u0015\u0003\u001b\u0004\u001b", new Object[]{"zzyv", "zzyw", "zzyx", zzb.class, "zzyy", zzj.class});
                case 4:
                    return zzyz;
                case 5:
                    zzgr<zzi> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzi.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzyz);
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

        public static zzi zzqi() {
            return zzyz;
        }

        static {
            zzey.zza((Class<zzi>) zzi.class, zzyz);
        }
    }

    public static final class zzj extends zzey<zzj, zza> implements zzgk {
        private static volatile zzgr<zzj> zzuo;
        private static final zzj zzzb = new zzj();
        private int zzue;
        private int zzwg;
        private zzfg zzza = zzum();

        private zzj() {
        }

        public static final class zza extends zzey.zza<zzj, zza> implements zzgk {
            private zza() {
                super(zzj.zzzb);
            }

            public final zza zzal(int i) {
                zzuc();
                ((zzj) this.zzahx).setIndex(i);
                return this;
            }

            public final zza zzbj(long j) {
                zzuc();
                ((zzj) this.zzahx).zzbh(j);
                return this;
            }

            public final zza zzr(Iterable<? extends Long> iterable) {
                zzuc();
                ((zzj) this.zzahx).zzm(iterable);
                return this;
            }

            public final zza zzqw() {
                zzuc();
                ((zzj) this.zzahx).zzqn();
                return this;
            }

            /* synthetic */ zza(zzbr zzbrVar) {
                this();
            }
        }

        public final boolean zzme() {
            return (this.zzue & 1) != 0;
        }

        public final int getIndex() {
            return this.zzwg;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void setIndex(int i) {
            this.zzue |= 1;
            this.zzwg = i;
        }

        public final List<Long> zzqk() {
            return this.zzza;
        }

        public final int zzql() {
            return this.zzza.size();
        }

        public final long zzai(int i) {
            return this.zzza.getLong(i);
        }

        private final void zzqm() {
            if (this.zzza.zzrx()) {
                return;
            }
            this.zzza = zzey.zza(this.zzza);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzbh(long j) {
            zzqm();
            this.zzza.zzby(j);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzm(Iterable<? extends Long> iterable) {
            zzqm();
            zzdf.zza(iterable, this.zzza);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzqn() {
            this.zzza = zzum();
        }

        public static zza zzqo() {
            return zzzb.zzui();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbr zzbrVar = null;
            switch (zzbr.zzud[i - 1]) {
                case 1:
                    return new zzj();
                case 2:
                    return new zza(zzbrVar);
                case 3:
                    return zza(zzzb, "\u0001\u0002\u0000\u0001\u0001\u0002\u0002\u0000\u0001\u0000\u0001\u0004\u0000\u0002\u0014", new Object[]{"zzue", "zzwg", "zzza"});
                case 4:
                    return zzzb;
                case 5:
                    zzgr<zzj> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzj.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzzb);
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

        static {
            zzey.zza((Class<zzj>) zzj.class, zzzb);
        }
    }

    public static final class zzk extends zzey<zzk, zza> implements zzgk {
        private static volatile zzgr<zzk> zzuo;
        private static final zzk zzzd = new zzk();
        private int zzue;
        private long zzwp;
        private float zzws;
        private double zzwt;
        private long zzzc;
        private String zzwk = "";
        private String zzwr = "";

        private zzk() {
        }

        public static final class zza extends zzey.zza<zzk, zza> implements zzgk {
            private zza() {
                super(zzk.zzzd);
            }

            public final zza zzbk(long j) {
                zzuc();
                ((zzk) this.zzahx).zzbi(j);
                return this;
            }

            public final zza zzdb(String str) {
                zzuc();
                ((zzk) this.zzahx).setName(str);
                return this;
            }

            public final zza zzdc(String str) {
                zzuc();
                ((zzk) this.zzahx).zzcb(str);
                return this;
            }

            public final zza zzqz() {
                zzuc();
                ((zzk) this.zzahx).zzmz();
                return this;
            }

            public final zza zzbl(long j) {
                zzuc();
                ((zzk) this.zzahx).zzal(j);
                return this;
            }

            public final zza zzra() {
                zzuc();
                ((zzk) this.zzahx).zznc();
                return this;
            }

            public final zza zzc(double d) {
                zzuc();
                ((zzk) this.zzahx).zzb(d);
                return this;
            }

            public final zza zzrb() {
                zzuc();
                ((zzk) this.zzahx).zznf();
                return this;
            }

            /* synthetic */ zza(zzbr zzbrVar) {
                this();
            }
        }

        public final boolean zzqs() {
            return (this.zzue & 1) != 0;
        }

        public final long zzqt() {
            return this.zzzc;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzbi(long j) {
            this.zzue |= 1;
            this.zzzc = j;
        }

        public final String getName() {
            return this.zzwk;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void setName(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 2;
            this.zzwk = str;
        }

        public final boolean zzmx() {
            return (this.zzue & 4) != 0;
        }

        public final String zzmy() {
            return this.zzwr;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzcb(String str) {
            if (str == null) {
                throw new NullPointerException();
            }
            this.zzue |= 4;
            this.zzwr = str;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzmz() {
            this.zzue &= -5;
            this.zzwr = zzzd.zzwr;
        }

        public final boolean zzna() {
            return (this.zzue & 8) != 0;
        }

        public final long zznb() {
            return this.zzwp;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzal(long j) {
            this.zzue |= 8;
            this.zzwp = j;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zznc() {
            this.zzue &= -9;
            this.zzwp = 0L;
        }

        public final boolean zznd() {
            return (this.zzue & 32) != 0;
        }

        public final double zzne() {
            return this.zzwt;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zzb(double d) {
            this.zzue |= 32;
            this.zzwt = d;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final void zznf() {
            this.zzue &= -33;
            this.zzwt = 0.0d;
        }

        public static zza zzqu() {
            return zzzd.zzui();
        }

        @Override // com.google.android.gms.internal.measurement.zzey
        protected final Object zza(int i, Object obj, Object obj2) {
            zzbr zzbrVar = null;
            switch (zzbr.zzud[i - 1]) {
                case 1:
                    return new zzk();
                case 2:
                    return new zza(zzbrVar);
                case 3:
                    return zza(zzzd, "\u0001\u0006\u0000\u0001\u0001\u0006\u0006\u0000\u0000\u0000\u0001\u0002\u0000\u0002\b\u0001\u0003\b\u0002\u0004\u0002\u0003\u0005\u0001\u0004\u0006\u0000\u0005", new Object[]{"zzue", "zzzc", "zzwk", "zzwr", "zzwp", "zzws", "zzwt"});
                case 4:
                    return zzzd;
                case 5:
                    zzgr<zzk> zzcVar = zzuo;
                    if (zzcVar == null) {
                        synchronized (zzk.class) {
                            zzcVar = zzuo;
                            if (zzcVar == null) {
                                zzcVar = new zzey.zzc<>(zzzd);
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

        static {
            zzey.zza((Class<zzk>) zzk.class, zzzd);
        }
    }
}

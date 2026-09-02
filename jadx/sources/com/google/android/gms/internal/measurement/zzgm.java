package com.google.android.gms.internal.measurement;

import androidx.core.text.HtmlCompat;
import androidx.core.view.MotionEventCompat;
import com.google.android.gms.drive.DriveFile;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.apache.commons.net.ftp.FTPCommand;
import sun.misc.Unsafe;

/* JADX INFO: loaded from: classes.dex */
final class zzgm<T> implements zzgx<T> {
    private static final int[] zzakh = new int[0];
    private static final Unsafe zzaki = zzhv.zzwv();
    private final int[] zzakj;
    private final Object[] zzakk;
    private final int zzakl;
    private final int zzakm;
    private final zzgi zzakn;
    private final boolean zzako;
    private final boolean zzakp;
    private final boolean zzakq;
    private final boolean zzakr;
    private final int[] zzaks;
    private final int zzakt;
    private final int zzaku;
    private final zzgq zzakv;
    private final zzfs zzakw;
    private final zzhp<?, ?> zzakx;
    private final zzen<?> zzaky;
    private final zzgb zzakz;

    private zzgm(int[] iArr, Object[] objArr, int i, int i2, zzgi zzgiVar, boolean z, boolean z2, int[] iArr2, int i3, int i4, zzgq zzgqVar, zzfs zzfsVar, zzhp<?, ?> zzhpVar, zzen<?> zzenVar, zzgb zzgbVar) {
        this.zzakj = iArr;
        this.zzakk = objArr;
        this.zzakl = i;
        this.zzakm = i2;
        this.zzakp = zzgiVar instanceof zzey;
        this.zzakq = z;
        this.zzako = zzenVar != null && zzenVar.zze(zzgiVar);
        this.zzakr = false;
        this.zzaks = iArr2;
        this.zzakt = i3;
        this.zzaku = i4;
        this.zzakv = zzgqVar;
        this.zzakw = zzfsVar;
        this.zzakx = zzhpVar;
        this.zzaky = zzenVar;
        this.zzakn = zzgiVar;
        this.zzakz = zzgbVar;
    }

    private static boolean zzcc(int i) {
        return (i & DriveFile.MODE_WRITE_ONLY) != 0;
    }

    /* JADX WARN: Code duplicated, block: B:176:0x037f  */
    /* JADX WARN: Code duplicated, block: B:190:0x03c7  */
    /* JADX WARN: Code duplicated, block: B:193:0x03ce  */
    /* JADX WARN: Code duplicated, block: B:196:0x03db  */
    static <T> zzgm<T> zza(Class<T> cls, zzgg zzggVar, zzgq zzgqVar, zzfs zzfsVar, zzhp<?, ?> zzhpVar, zzen<?> zzenVar, zzgb zzgbVar) {
        int i;
        int i2;
        int iCharAt;
        int i3;
        int i4;
        int i5;
        int iCharAt2;
        int i6;
        int iCharAt3;
        int iCharAt4;
        int i7;
        int i8;
        int i9;
        int[] iArr;
        int i10;
        char cCharAt;
        int i11;
        char cCharAt2;
        int i12;
        char cCharAt3;
        int i13;
        char cCharAt4;
        char cCharAt5;
        char cCharAt6;
        char cCharAt7;
        char cCharAt8;
        int i14;
        int i15;
        int i16;
        int iObjectFieldOffset;
        int i17;
        int i18;
        int iObjectFieldOffset2;
        Field fieldZza;
        int i19;
        char cCharAt9;
        int i20;
        int i21;
        int i22;
        Field fieldZza2;
        Field fieldZza3;
        int i23;
        char cCharAt10;
        int i24;
        char cCharAt11;
        int i25;
        char cCharAt12;
        char cCharAt13;
        char cCharAt14;
        if (zzggVar instanceof zzgv) {
            zzgv zzgvVar = (zzgv) zzggVar;
            int iCharAt5 = 0;
            boolean z = zzgvVar.zzvr() == zzey.zzd.zzaim;
            String strZzvz = zzgvVar.zzvz();
            int length = strZzvz.length();
            int iCharAt6 = strZzvz.charAt(0);
            if (iCharAt6 >= 55296) {
                int i26 = iCharAt6 & 8191;
                int i27 = 1;
                int i28 = 13;
                while (true) {
                    i = i27 + 1;
                    cCharAt14 = strZzvz.charAt(i27);
                    if (cCharAt14 < 55296) {
                        break;
                    }
                    i26 |= (cCharAt14 & 8191) << i28;
                    i28 += 13;
                    i27 = i;
                }
                iCharAt6 = (cCharAt14 << i28) | i26;
            } else {
                i = 1;
            }
            int i29 = i + 1;
            int iCharAt7 = strZzvz.charAt(i);
            if (iCharAt7 >= 55296) {
                int i30 = iCharAt7 & 8191;
                int i31 = 13;
                while (true) {
                    i2 = i29 + 1;
                    cCharAt13 = strZzvz.charAt(i29);
                    if (cCharAt13 < 55296) {
                        break;
                    }
                    i30 |= (cCharAt13 & 8191) << i31;
                    i31 += 13;
                    i29 = i2;
                }
                iCharAt7 = i30 | (cCharAt13 << i31);
            } else {
                i2 = i29;
            }
            if (iCharAt7 == 0) {
                iArr = zzakh;
                iCharAt4 = 0;
                iCharAt = 0;
                i9 = 0;
                iCharAt2 = 0;
                iCharAt3 = 0;
                i8 = 0;
            } else {
                int i32 = i2 + 1;
                iCharAt = strZzvz.charAt(i2);
                if (iCharAt >= 55296) {
                    int i33 = iCharAt & 8191;
                    int i34 = 13;
                    while (true) {
                        i3 = i32 + 1;
                        cCharAt8 = strZzvz.charAt(i32);
                        if (cCharAt8 < 55296) {
                            break;
                        }
                        i33 |= (cCharAt8 & 8191) << i34;
                        i34 += 13;
                        i32 = i3;
                    }
                    iCharAt = (cCharAt8 << i34) | i33;
                } else {
                    i3 = i32;
                }
                int i35 = i3 + 1;
                int iCharAt8 = strZzvz.charAt(i3);
                if (iCharAt8 >= 55296) {
                    int i36 = iCharAt8 & 8191;
                    int i37 = 13;
                    while (true) {
                        i4 = i35 + 1;
                        cCharAt7 = strZzvz.charAt(i35);
                        if (cCharAt7 < 55296) {
                            break;
                        }
                        i36 |= (cCharAt7 & 8191) << i37;
                        i37 += 13;
                        i35 = i4;
                    }
                    iCharAt8 = i36 | (cCharAt7 << i37);
                } else {
                    i4 = i35;
                }
                int i38 = i4 + 1;
                int iCharAt9 = strZzvz.charAt(i4);
                if (iCharAt9 >= 55296) {
                    int i39 = iCharAt9 & 8191;
                    int i40 = 13;
                    while (true) {
                        i5 = i38 + 1;
                        cCharAt6 = strZzvz.charAt(i38);
                        if (cCharAt6 < 55296) {
                            break;
                        }
                        i39 |= (cCharAt6 & 8191) << i40;
                        i40 += 13;
                        i38 = i5;
                    }
                    iCharAt9 = (cCharAt6 << i40) | i39;
                } else {
                    i5 = i38;
                }
                int i41 = i5 + 1;
                iCharAt2 = strZzvz.charAt(i5);
                if (iCharAt2 >= 55296) {
                    int i42 = iCharAt2 & 8191;
                    int i43 = 13;
                    while (true) {
                        i6 = i41 + 1;
                        cCharAt5 = strZzvz.charAt(i41);
                        if (cCharAt5 < 55296) {
                            break;
                        }
                        i42 |= (cCharAt5 & 8191) << i43;
                        i43 += 13;
                        i41 = i6;
                    }
                    iCharAt2 = (cCharAt5 << i43) | i42;
                } else {
                    i6 = i41;
                }
                int i44 = i6 + 1;
                iCharAt3 = strZzvz.charAt(i6);
                if (iCharAt3 >= 55296) {
                    int i45 = iCharAt3 & 8191;
                    int i46 = 13;
                    while (true) {
                        i13 = i44 + 1;
                        cCharAt4 = strZzvz.charAt(i44);
                        if (cCharAt4 < 55296) {
                            break;
                        }
                        i45 |= (cCharAt4 & 8191) << i46;
                        i46 += 13;
                        i44 = i13;
                    }
                    iCharAt3 = (cCharAt4 << i46) | i45;
                    i44 = i13;
                }
                int i47 = i44 + 1;
                iCharAt4 = strZzvz.charAt(i44);
                if (iCharAt4 >= 55296) {
                    int i48 = iCharAt4 & 8191;
                    int i49 = 13;
                    while (true) {
                        i12 = i47 + 1;
                        cCharAt3 = strZzvz.charAt(i47);
                        if (cCharAt3 < 55296) {
                            break;
                        }
                        i48 |= (cCharAt3 & 8191) << i49;
                        i49 += 13;
                        i47 = i12;
                    }
                    iCharAt4 = i48 | (cCharAt3 << i49);
                    i47 = i12;
                }
                int i50 = i47 + 1;
                int iCharAt10 = strZzvz.charAt(i47);
                if (iCharAt10 >= 55296) {
                    int i51 = 13;
                    int i52 = iCharAt10 & 8191;
                    int i53 = i50;
                    while (true) {
                        i11 = i53 + 1;
                        cCharAt2 = strZzvz.charAt(i53);
                        if (cCharAt2 < 55296) {
                            break;
                        }
                        i52 |= (cCharAt2 & 8191) << i51;
                        i51 += 13;
                        i53 = i11;
                    }
                    iCharAt10 = i52 | (cCharAt2 << i51);
                    i7 = i11;
                } else {
                    i7 = i50;
                }
                int i54 = i7 + 1;
                iCharAt5 = strZzvz.charAt(i7);
                if (iCharAt5 >= 55296) {
                    int i55 = 13;
                    int i56 = iCharAt5 & 8191;
                    int i57 = i54;
                    while (true) {
                        i10 = i57 + 1;
                        cCharAt = strZzvz.charAt(i57);
                        if (cCharAt < 55296) {
                            break;
                        }
                        i56 |= (cCharAt & 8191) << i55;
                        i55 += 13;
                        i57 = i10;
                    }
                    iCharAt5 = i56 | (cCharAt << i55);
                    i54 = i10;
                }
                int[] iArr2 = new int[iCharAt5 + iCharAt4 + iCharAt10];
                i8 = (iCharAt << 1) + iCharAt8;
                i9 = iCharAt9;
                i2 = i54;
                iArr = iArr2;
            }
            Unsafe unsafe = zzaki;
            Object[] objArrZzwa = zzgvVar.zzwa();
            Class<?> cls2 = zzgvVar.zzvt().getClass();
            int i58 = i2;
            int[] iArr3 = new int[iCharAt3 * 3];
            Object[] objArr = new Object[iCharAt3 << 1];
            int i59 = iCharAt5 + iCharAt4;
            int i60 = i8;
            int i61 = i59;
            int i62 = i58;
            int i63 = 0;
            int i64 = 0;
            int i65 = iCharAt5;
            while (i62 < length) {
                int i66 = i62 + 1;
                int iCharAt11 = strZzvz.charAt(i62);
                char c = 55296;
                if (iCharAt11 >= 55296) {
                    int i67 = 13;
                    int i68 = iCharAt11 & 8191;
                    int i69 = i66;
                    while (true) {
                        i25 = i69 + 1;
                        cCharAt12 = strZzvz.charAt(i69);
                        if (cCharAt12 < c) {
                            break;
                        }
                        i68 |= (cCharAt12 & 8191) << i67;
                        i67 += 13;
                        i69 = i25;
                        c = 55296;
                    }
                    iCharAt11 = i68 | (cCharAt12 << i67);
                    i14 = i25;
                } else {
                    i14 = i66;
                }
                int i70 = i14 + 1;
                int iCharAt12 = strZzvz.charAt(i14);
                int i71 = length;
                char c2 = 55296;
                if (iCharAt12 >= 55296) {
                    int i72 = 13;
                    int i73 = iCharAt12 & 8191;
                    int i74 = i70;
                    while (true) {
                        i24 = i74 + 1;
                        cCharAt11 = strZzvz.charAt(i74);
                        if (cCharAt11 < c2) {
                            break;
                        }
                        i73 |= (cCharAt11 & 8191) << i72;
                        i72 += 13;
                        i74 = i24;
                        c2 = 55296;
                    }
                    iCharAt12 = i73 | (cCharAt11 << i72);
                    i15 = i24;
                } else {
                    i15 = i70;
                }
                int i75 = iCharAt5;
                int i76 = iCharAt12 & 255;
                boolean z2 = z;
                if ((iCharAt12 & 1024) != 0) {
                    iArr[i63] = i64;
                    i63++;
                }
                int i77 = i63;
                if (i76 >= 51) {
                    int i78 = i15 + 1;
                    int iCharAt13 = strZzvz.charAt(i15);
                    char c3 = 55296;
                    if (iCharAt13 >= 55296) {
                        int i79 = iCharAt13 & 8191;
                        int i80 = 13;
                        while (true) {
                            i23 = i78 + 1;
                            cCharAt10 = strZzvz.charAt(i78);
                            if (cCharAt10 < c3) {
                                break;
                            }
                            i79 |= (cCharAt10 & 8191) << i80;
                            i80 += 13;
                            i78 = i23;
                            c3 = 55296;
                        }
                        iCharAt13 = i79 | (cCharAt10 << i80);
                        i78 = i23;
                    }
                    int i81 = i76 - 51;
                    int i82 = i78;
                    if (i81 == 9 || i81 == 17) {
                        i21 = 1;
                        i22 = i60 + 1;
                        objArr[((i64 / 3) << 1) + 1] = objArrZzwa[i60];
                    } else {
                        if (i81 == 12 && (iCharAt6 & 1) == 1) {
                            objArr[((i64 / 3) << 1) + 1] = objArrZzwa[i60];
                            i22 = i60 + 1;
                        } else {
                            i22 = i60;
                        }
                        i21 = 1;
                    }
                    int i83 = iCharAt13 << i21;
                    Object obj = objArrZzwa[i83];
                    if (obj instanceof Field) {
                        fieldZza2 = (Field) obj;
                    } else {
                        fieldZza2 = zza(cls2, (String) obj);
                        objArrZzwa[i83] = fieldZza2;
                    }
                    i16 = i9;
                    int iObjectFieldOffset3 = (int) unsafe.objectFieldOffset(fieldZza2);
                    int i84 = i83 + 1;
                    Object obj2 = objArrZzwa[i84];
                    if (obj2 instanceof Field) {
                        fieldZza3 = (Field) obj2;
                    } else {
                        fieldZza3 = zza(cls2, (String) obj2);
                        objArrZzwa[i84] = fieldZza3;
                    }
                    int iObjectFieldOffset4 = (int) unsafe.objectFieldOffset(fieldZza3);
                    iCharAt2 = iCharAt2;
                    objArr = objArr;
                    i60 = i22;
                    i17 = i82;
                    iObjectFieldOffset = iObjectFieldOffset3;
                    iObjectFieldOffset2 = iObjectFieldOffset4;
                    i18 = 0;
                } else {
                    i16 = i9;
                    int i85 = i60 + 1;
                    Field fieldZza4 = zza(cls2, (String) objArrZzwa[i60]);
                    if (i76 == 9 || i76 == 17) {
                        iCharAt2 = iCharAt2;
                        objArr[((i64 / 3) << 1) + 1] = fieldZza4.getType();
                    } else {
                        if (i76 == 27 || i76 == 49) {
                            iCharAt2 = iCharAt2;
                            i20 = i85 + 1;
                            objArr[((i64 / 3) << 1) + 1] = objArrZzwa[i85];
                        } else if (i76 == 12 || i76 == 30 || i76 == 44) {
                            iCharAt2 = iCharAt2;
                            if ((iCharAt6 & 1) == 1) {
                                i20 = i85 + 1;
                                objArr[((i64 / 3) << 1) + 1] = objArrZzwa[i85];
                            }
                            iObjectFieldOffset = (int) unsafe.objectFieldOffset(fieldZza4);
                            if ((iCharAt6 & 1) == 1 || i76 > 17) {
                                i17 = i15;
                                i18 = 0;
                                iObjectFieldOffset2 = 0;
                            } else {
                                i17 = i15 + 1;
                                int iCharAt14 = strZzvz.charAt(i15);
                                if (iCharAt14 >= 55296) {
                                    int i86 = iCharAt14 & 8191;
                                    int i87 = 13;
                                    while (true) {
                                        i19 = i17 + 1;
                                        cCharAt9 = strZzvz.charAt(i17);
                                        if (cCharAt9 < 55296) {
                                            break;
                                        }
                                        i86 |= (cCharAt9 & 8191) << i87;
                                        i87 += 13;
                                        i17 = i19;
                                    }
                                    iCharAt14 = i86 | (cCharAt9 << i87);
                                    i17 = i19;
                                }
                                int i88 = (iCharAt << 1) + (iCharAt14 / 32);
                                Object obj3 = objArrZzwa[i88];
                                if (obj3 instanceof Field) {
                                    fieldZza = (Field) obj3;
                                } else {
                                    fieldZza = zza(cls2, (String) obj3);
                                    objArrZzwa[i88] = fieldZza;
                                }
                                iObjectFieldOffset2 = (int) unsafe.objectFieldOffset(fieldZza);
                                i18 = iCharAt14 % 32;
                            }
                            if (i76 >= 18 || i76 > 49) {
                                i60 = i85;
                            } else {
                                iArr[i61] = iObjectFieldOffset;
                                i60 = i85;
                                i61++;
                            }
                        } else {
                            if (i76 == 50) {
                                int i89 = i65 + 1;
                                iArr[i65] = i64;
                                int i90 = (i64 / 3) << 1;
                                int i91 = i85 + 1;
                                objArr[i90] = objArrZzwa[i85];
                                if ((iCharAt12 & 2048) != 0) {
                                    i85 = i91 + 1;
                                    objArr[i90 + 1] = objArrZzwa[i91];
                                } else {
                                    i85 = i91;
                                }
                                i65 = i89;
                            } else {
                                iCharAt2 = iCharAt2;
                            }
                            iObjectFieldOffset = (int) unsafe.objectFieldOffset(fieldZza4);
                            if ((iCharAt6 & 1) == 1) {
                                i17 = i15;
                                i18 = 0;
                                iObjectFieldOffset2 = 0;
                            } else {
                                i17 = i15;
                                i18 = 0;
                                iObjectFieldOffset2 = 0;
                            }
                            if (i76 >= 18) {
                                i60 = i85;
                            } else {
                                i60 = i85;
                            }
                        }
                        objArr = objArr;
                        i85 = i20;
                        iObjectFieldOffset = (int) unsafe.objectFieldOffset(fieldZza4);
                        if ((iCharAt6 & 1) == 1) {
                            i17 = i15;
                            i18 = 0;
                            iObjectFieldOffset2 = 0;
                        } else {
                            i17 = i15;
                            i18 = 0;
                            iObjectFieldOffset2 = 0;
                        }
                        if (i76 >= 18) {
                            i60 = i85;
                        } else {
                            i60 = i85;
                        }
                    }
                    objArr = objArr;
                    iObjectFieldOffset = (int) unsafe.objectFieldOffset(fieldZza4);
                    if ((iCharAt6 & 1) == 1) {
                        i17 = i15;
                        i18 = 0;
                        iObjectFieldOffset2 = 0;
                    } else {
                        i17 = i15;
                        i18 = 0;
                        iObjectFieldOffset2 = 0;
                    }
                    if (i76 >= 18) {
                        i60 = i85;
                    } else {
                        i60 = i85;
                    }
                }
                int i92 = i64 + 1;
                iArr3[i64] = iCharAt11;
                int i93 = i92 + 1;
                iArr3[i92] = (i76 << 20) | ((iCharAt12 & 256) != 0 ? DriveFile.MODE_READ_ONLY : 0) | ((iCharAt12 & 512) != 0 ? DriveFile.MODE_WRITE_ONLY : 0) | iObjectFieldOffset;
                i64 = i93 + 1;
                iArr3[i93] = (i18 << 20) | iObjectFieldOffset2;
                i62 = i17;
                length = i71;
                iCharAt5 = i75;
                z = z2;
                i63 = i77;
                i9 = i16;
                iCharAt2 = iCharAt2;
                objArr = objArr;
            }
            return new zzgm<>(iArr3, objArr, i9, iCharAt2, zzgvVar.zzvt(), z, false, iArr, iCharAt5, i59, zzgqVar, zzfsVar, zzhpVar, zzenVar, zzgbVar);
        }
        ((zzhm) zzggVar).zzvr();
        int i94 = zzey.zzd.zzaim;
        throw new NoSuchMethodError();
    }

    private static Field zza(Class<?> cls, String str) {
        try {
            return cls.getDeclaredField(str);
        } catch (NoSuchFieldException unused) {
            Field[] declaredFields = cls.getDeclaredFields();
            for (Field field : declaredFields) {
                if (str.equals(field.getName())) {
                    return field;
                }
            }
            String name = cls.getName();
            String string = Arrays.toString(declaredFields);
            StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 40 + String.valueOf(name).length() + String.valueOf(string).length());
            sb.append("Field ");
            sb.append(str);
            sb.append(" for ");
            sb.append(name);
            sb.append(" not found. Known fields are ");
            sb.append(string);
            throw new RuntimeException(sb.toString());
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzgx
    public final T newInstance() {
        return (T) this.zzakv.newInstance(this.zzakn);
    }

    /* JADX WARN: Code duplicated, block: B:104:0x01c1  */
    @Override // com.google.android.gms.internal.measurement.zzgx
    public final boolean equals(T t, T t2) {
        int length = this.zzakj.length;
        int i = 0;
        while (true) {
            boolean zZzd = true;
            if (i < length) {
                int iZzca = zzca(i);
                long j = iZzca & 1048575;
                switch ((iZzca & 267386880) >>> 20) {
                    case 0:
                        if (!zzc(t, t2, i) || Double.doubleToLongBits(zzhv.zzo(t, j)) != Double.doubleToLongBits(zzhv.zzo(t2, j))) {
                            zZzd = false;
                        }
                        break;
                    case 1:
                        if (!zzc(t, t2, i) || Float.floatToIntBits(zzhv.zzn(t, j)) != Float.floatToIntBits(zzhv.zzn(t2, j))) {
                            zZzd = false;
                        }
                        break;
                    case 2:
                        if (!zzc(t, t2, i) || zzhv.zzl(t, j) != zzhv.zzl(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 3:
                        if (!zzc(t, t2, i) || zzhv.zzl(t, j) != zzhv.zzl(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 4:
                        if (!zzc(t, t2, i) || zzhv.zzk(t, j) != zzhv.zzk(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 5:
                        if (!zzc(t, t2, i) || zzhv.zzl(t, j) != zzhv.zzl(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 6:
                        if (!zzc(t, t2, i) || zzhv.zzk(t, j) != zzhv.zzk(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 7:
                        if (!zzc(t, t2, i) || zzhv.zzm(t, j) != zzhv.zzm(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 8:
                        if (!zzc(t, t2, i) || !zzgz.zzd(zzhv.zzp(t, j), zzhv.zzp(t2, j))) {
                            zZzd = false;
                        }
                        break;
                    case 9:
                        if (!zzc(t, t2, i) || !zzgz.zzd(zzhv.zzp(t, j), zzhv.zzp(t2, j))) {
                            zZzd = false;
                        }
                        break;
                    case 10:
                        if (!zzc(t, t2, i) || !zzgz.zzd(zzhv.zzp(t, j), zzhv.zzp(t2, j))) {
                            zZzd = false;
                        }
                        break;
                    case 11:
                        if (!zzc(t, t2, i) || zzhv.zzk(t, j) != zzhv.zzk(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 12:
                        if (!zzc(t, t2, i) || zzhv.zzk(t, j) != zzhv.zzk(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 13:
                        if (!zzc(t, t2, i) || zzhv.zzk(t, j) != zzhv.zzk(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 14:
                        if (!zzc(t, t2, i) || zzhv.zzl(t, j) != zzhv.zzl(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 15:
                        if (!zzc(t, t2, i) || zzhv.zzk(t, j) != zzhv.zzk(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 16:
                        if (!zzc(t, t2, i) || zzhv.zzl(t, j) != zzhv.zzl(t2, j)) {
                            zZzd = false;
                        }
                        break;
                    case 17:
                        if (!zzc(t, t2, i) || !zzgz.zzd(zzhv.zzp(t, j), zzhv.zzp(t2, j))) {
                            zZzd = false;
                        }
                        break;
                    case 18:
                    case 19:
                    case 20:
                    case 21:
                    case 22:
                    case 23:
                    case 24:
                    case 25:
                    case 26:
                    case 27:
                    case 28:
                    case 29:
                    case 30:
                    case FTPCommand.HELP /* 31 */:
                    case 32:
                    case 33:
                    case 34:
                    case 35:
                    case 36:
                    case 37:
                    case 38:
                    case 39:
                    case MotionEventCompat.AXIS_GENERIC_9 /* 40 */:
                    case MotionEventCompat.AXIS_GENERIC_10 /* 41 */:
                    case MotionEventCompat.AXIS_GENERIC_11 /* 42 */:
                    case MotionEventCompat.AXIS_GENERIC_12 /* 43 */:
                    case MotionEventCompat.AXIS_GENERIC_13 /* 44 */:
                    case MotionEventCompat.AXIS_GENERIC_14 /* 45 */:
                    case MotionEventCompat.AXIS_GENERIC_15 /* 46 */:
                    case MotionEventCompat.AXIS_GENERIC_16 /* 47 */:
                    case 48:
                    case 49:
                        zZzd = zzgz.zzd(zzhv.zzp(t, j), zzhv.zzp(t2, j));
                        break;
                    case 50:
                        zZzd = zzgz.zzd(zzhv.zzp(t, j), zzhv.zzp(t2, j));
                        break;
                    case 51:
                    case 52:
                    case 53:
                    case 54:
                    case 55:
                    case 56:
                    case 57:
                    case 58:
                    case 59:
                    case 60:
                    case 61:
                    case 62:
                    case HtmlCompat.FROM_HTML_MODE_COMPACT /* 63 */:
                    case 64:
                    case 65:
                    case 66:
                    case 67:
                    case 68:
                        long jZzcb = zzcb(i) & 1048575;
                        if (zzhv.zzk(t, jZzcb) != zzhv.zzk(t2, jZzcb) || !zzgz.zzd(zzhv.zzp(t, j), zzhv.zzp(t2, j))) {
                            zZzd = false;
                        }
                        break;
                }
                if (!zZzd) {
                    return false;
                }
                i += 3;
            } else {
                if (!this.zzakx.zzx(t).equals(this.zzakx.zzx(t2))) {
                    return false;
                }
                if (this.zzako) {
                    return this.zzaky.zzh(t).equals(this.zzaky.zzh(t2));
                }
                return true;
            }
        }
    }

    @Override // com.google.android.gms.internal.measurement.zzgx
    public final int hashCode(T t) {
        int length = this.zzakj.length;
        int iZzbx = 0;
        for (int i = 0; i < length; i += 3) {
            int iZzca = zzca(i);
            int i2 = this.zzakj[i];
            long j = 1048575 & iZzca;
            switch ((iZzca & 267386880) >>> 20) {
                case 0:
                    iZzbx = (iZzbx * 53) + zzez.zzbx(Double.doubleToLongBits(zzhv.zzo(t, j)));
                    break;
                case 1:
                    iZzbx = (iZzbx * 53) + Float.floatToIntBits(zzhv.zzn(t, j));
                    break;
                case 2:
                    iZzbx = (iZzbx * 53) + zzez.zzbx(zzhv.zzl(t, j));
                    break;
                case 3:
                    iZzbx = (iZzbx * 53) + zzez.zzbx(zzhv.zzl(t, j));
                    break;
                case 4:
                    iZzbx = (iZzbx * 53) + zzhv.zzk(t, j);
                    break;
                case 5:
                    iZzbx = (iZzbx * 53) + zzez.zzbx(zzhv.zzl(t, j));
                    break;
                case 6:
                    iZzbx = (iZzbx * 53) + zzhv.zzk(t, j);
                    break;
                case 7:
                    iZzbx = (iZzbx * 53) + zzez.zzs(zzhv.zzm(t, j));
                    break;
                case 8:
                    iZzbx = (iZzbx * 53) + ((String) zzhv.zzp(t, j)).hashCode();
                    break;
                case 9:
                    Object objZzp = zzhv.zzp(t, j);
                    iZzbx = (iZzbx * 53) + (objZzp != null ? objZzp.hashCode() : 37);
                    break;
                case 10:
                    iZzbx = (iZzbx * 53) + zzhv.zzp(t, j).hashCode();
                    break;
                case 11:
                    iZzbx = (iZzbx * 53) + zzhv.zzk(t, j);
                    break;
                case 12:
                    iZzbx = (iZzbx * 53) + zzhv.zzk(t, j);
                    break;
                case 13:
                    iZzbx = (iZzbx * 53) + zzhv.zzk(t, j);
                    break;
                case 14:
                    iZzbx = (iZzbx * 53) + zzez.zzbx(zzhv.zzl(t, j));
                    break;
                case 15:
                    iZzbx = (iZzbx * 53) + zzhv.zzk(t, j);
                    break;
                case 16:
                    iZzbx = (iZzbx * 53) + zzez.zzbx(zzhv.zzl(t, j));
                    break;
                case 17:
                    Object objZzp2 = zzhv.zzp(t, j);
                    iZzbx = (iZzbx * 53) + (objZzp2 != null ? objZzp2.hashCode() : 37);
                    break;
                case 18:
                case 19:
                case 20:
                case 21:
                case 22:
                case 23:
                case 24:
                case 25:
                case 26:
                case 27:
                case 28:
                case 29:
                case 30:
                case FTPCommand.HELP /* 31 */:
                case 32:
                case 33:
                case 34:
                case 35:
                case 36:
                case 37:
                case 38:
                case 39:
                case MotionEventCompat.AXIS_GENERIC_9 /* 40 */:
                case MotionEventCompat.AXIS_GENERIC_10 /* 41 */:
                case MotionEventCompat.AXIS_GENERIC_11 /* 42 */:
                case MotionEventCompat.AXIS_GENERIC_12 /* 43 */:
                case MotionEventCompat.AXIS_GENERIC_13 /* 44 */:
                case MotionEventCompat.AXIS_GENERIC_14 /* 45 */:
                case MotionEventCompat.AXIS_GENERIC_15 /* 46 */:
                case MotionEventCompat.AXIS_GENERIC_16 /* 47 */:
                case 48:
                case 49:
                    iZzbx = (iZzbx * 53) + zzhv.zzp(t, j).hashCode();
                    break;
                case 50:
                    iZzbx = (iZzbx * 53) + zzhv.zzp(t, j).hashCode();
                    break;
                case 51:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzez.zzbx(Double.doubleToLongBits(zzf(t, j)));
                    }
                    break;
                case 52:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + Float.floatToIntBits(zzg(t, j));
                    }
                    break;
                case 53:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzez.zzbx(zzi(t, j));
                    }
                    break;
                case 54:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzez.zzbx(zzi(t, j));
                    }
                    break;
                case 55:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzh(t, j);
                    }
                    break;
                case 56:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzez.zzbx(zzi(t, j));
                    }
                    break;
                case 57:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzh(t, j);
                    }
                    break;
                case 58:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzez.zzs(zzj(t, j));
                    }
                    break;
                case 59:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + ((String) zzhv.zzp(t, j)).hashCode();
                    }
                    break;
                case 60:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzhv.zzp(t, j).hashCode();
                    }
                    break;
                case 61:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzhv.zzp(t, j).hashCode();
                    }
                    break;
                case 62:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzh(t, j);
                    }
                    break;
                case HtmlCompat.FROM_HTML_MODE_COMPACT /* 63 */:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzh(t, j);
                    }
                    break;
                case 64:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzh(t, j);
                    }
                    break;
                case 65:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzez.zzbx(zzi(t, j));
                    }
                    break;
                case 66:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzh(t, j);
                    }
                    break;
                case 67:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzez.zzbx(zzi(t, j));
                    }
                    break;
                case 68:
                    if (zza(t, i2, i)) {
                        iZzbx = (iZzbx * 53) + zzhv.zzp(t, j).hashCode();
                    }
                    break;
            }
        }
        int iHashCode = (iZzbx * 53) + this.zzakx.zzx(t).hashCode();
        return this.zzako ? (iHashCode * 53) + this.zzaky.zzh(t).hashCode() : iHashCode;
    }

    @Override // com.google.android.gms.internal.measurement.zzgx
    public final void zzc(T t, T t2) {
        if (t2 == null) {
            throw new NullPointerException();
        }
        for (int i = 0; i < this.zzakj.length; i += 3) {
            int iZzca = zzca(i);
            long j = 1048575 & iZzca;
            int i2 = this.zzakj[i];
            switch ((iZzca & 267386880) >>> 20) {
                case 0:
                    if (zza(t2, i)) {
                        zzhv.zza(t, j, zzhv.zzo(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 1:
                    if (zza(t2, i)) {
                        zzhv.zza((Object) t, j, zzhv.zzn(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 2:
                    if (zza(t2, i)) {
                        zzhv.zza((Object) t, j, zzhv.zzl(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 3:
                    if (zza(t2, i)) {
                        zzhv.zza((Object) t, j, zzhv.zzl(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 4:
                    if (zza(t2, i)) {
                        zzhv.zzb(t, j, zzhv.zzk(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 5:
                    if (zza(t2, i)) {
                        zzhv.zza((Object) t, j, zzhv.zzl(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 6:
                    if (zza(t2, i)) {
                        zzhv.zzb(t, j, zzhv.zzk(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 7:
                    if (zza(t2, i)) {
                        zzhv.zza(t, j, zzhv.zzm(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 8:
                    if (zza(t2, i)) {
                        zzhv.zza(t, j, zzhv.zzp(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 9:
                    zza(t, t2, i);
                    break;
                case 10:
                    if (zza(t2, i)) {
                        zzhv.zza(t, j, zzhv.zzp(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 11:
                    if (zza(t2, i)) {
                        zzhv.zzb(t, j, zzhv.zzk(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 12:
                    if (zza(t2, i)) {
                        zzhv.zzb(t, j, zzhv.zzk(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 13:
                    if (zza(t2, i)) {
                        zzhv.zzb(t, j, zzhv.zzk(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 14:
                    if (zza(t2, i)) {
                        zzhv.zza((Object) t, j, zzhv.zzl(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 15:
                    if (zza(t2, i)) {
                        zzhv.zzb(t, j, zzhv.zzk(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 16:
                    if (zza(t2, i)) {
                        zzhv.zza((Object) t, j, zzhv.zzl(t2, j));
                        zzb(t, i);
                    }
                    break;
                case 17:
                    zza(t, t2, i);
                    break;
                case 18:
                case 19:
                case 20:
                case 21:
                case 22:
                case 23:
                case 24:
                case 25:
                case 26:
                case 27:
                case 28:
                case 29:
                case 30:
                case FTPCommand.HELP /* 31 */:
                case 32:
                case 33:
                case 34:
                case 35:
                case 36:
                case 37:
                case 38:
                case 39:
                case MotionEventCompat.AXIS_GENERIC_9 /* 40 */:
                case MotionEventCompat.AXIS_GENERIC_10 /* 41 */:
                case MotionEventCompat.AXIS_GENERIC_11 /* 42 */:
                case MotionEventCompat.AXIS_GENERIC_12 /* 43 */:
                case MotionEventCompat.AXIS_GENERIC_13 /* 44 */:
                case MotionEventCompat.AXIS_GENERIC_14 /* 45 */:
                case MotionEventCompat.AXIS_GENERIC_15 /* 46 */:
                case MotionEventCompat.AXIS_GENERIC_16 /* 47 */:
                case 48:
                case 49:
                    this.zzakw.zza(t, t2, j);
                    break;
                case 50:
                    zzgz.zza(this.zzakz, t, t2, j);
                    break;
                case 51:
                case 52:
                case 53:
                case 54:
                case 55:
                case 56:
                case 57:
                case 58:
                case 59:
                    if (zza(t2, i2, i)) {
                        zzhv.zza(t, j, zzhv.zzp(t2, j));
                        zzb(t, i2, i);
                    }
                    break;
                case 60:
                    zzb(t, t2, i);
                    break;
                case 61:
                case 62:
                case HtmlCompat.FROM_HTML_MODE_COMPACT /* 63 */:
                case 64:
                case 65:
                case 66:
                case 67:
                    if (zza(t2, i2, i)) {
                        zzhv.zza(t, j, zzhv.zzp(t2, j));
                        zzb(t, i2, i);
                    }
                    break;
                case 68:
                    zzb(t, t2, i);
                    break;
            }
        }
        if (this.zzakq) {
            return;
        }
        zzgz.zza(this.zzakx, t, t2);
        if (this.zzako) {
            zzgz.zza(this.zzaky, t, t2);
        }
    }

    private final void zza(T t, T t2, int i) {
        long jZzca = zzca(i) & 1048575;
        if (zza(t2, i)) {
            Object objZzp = zzhv.zzp(t, jZzca);
            Object objZzp2 = zzhv.zzp(t2, jZzca);
            if (objZzp != null && objZzp2 != null) {
                zzhv.zza(t, jZzca, zzez.zza(objZzp, objZzp2));
                zzb(t, i);
            } else if (objZzp2 != null) {
                zzhv.zza(t, jZzca, objZzp2);
                zzb(t, i);
            }
        }
    }

    private final void zzb(T t, T t2, int i) {
        int iZzca = zzca(i);
        int i2 = this.zzakj[i];
        long j = iZzca & 1048575;
        if (zza(t2, i2, i)) {
            Object objZzp = zzhv.zzp(t, j);
            Object objZzp2 = zzhv.zzp(t2, j);
            if (objZzp != null && objZzp2 != null) {
                zzhv.zza(t, j, zzez.zza(objZzp, objZzp2));
                zzb(t, i2, i);
            } else if (objZzp2 != null) {
                zzhv.zza(t, j, objZzp2);
                zzb(t, i2, i);
            }
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Code duplicated, block: B:417:0x09ce A[PHI: r5
      0x09ce: PHI (r5v4 int) = 
      (r5v1 int)
      (r5v1 int)
      (r5v1 int)
      (r5v15 int)
      (r5v16 int)
      (r5v1 int)
      (r5v17 int)
      (r5v1 int)
      (r5v18 int)
      (r5v1 int)
      (r5v19 int)
      (r5v1 int)
      (r5v20 int)
      (r5v1 int)
      (r5v21 int)
      (r5v1 int)
      (r5v22 int)
      (r5v1 int)
      (r5v23 int)
      (r5v1 int)
      (r5v24 int)
      (r5v1 int)
      (r5v25 int)
      (r5v26 int)
      (r5v34 int)
      (r5v35 int)
      (r5v36 int)
      (r5v37 int)
      (r5v1 int)
      (r5v47 int)
      (r5v1 int)
      (r5v48 int)
      (r5v1 int)
      (r5v49 int)
      (r5v1 int)
      (r5v50 int)
      (r5v1 int)
      (r5v51 int)
      (r5v1 int)
      (r5v52 int)
      (r5v1 int)
      (r5v53 int)
      (r5v1 int)
      (r5v54 int)
      (r5v1 int)
      (r5v55 int)
      (r5v1 int)
      (r5v56 int)
      (r5v1 int)
      (r5v57 int)
      (r5v1 int)
      (r5v58 int)
      (r5v1 int)
      (r5v59 int)
      (r5v1 int)
      (r5v60 int)
      (r5v61 int)
      (r5v62 int)
      (r5v1 int)
      (r5v63 int)
      (r5v1 int)
      (r5v64 int)
      (r5v1 int)
      (r5v65 int)
      (r5v1 int)
      (r5v66 int)
      (r5v1 int)
      (r5v67 int)
      (r5v1 int)
      (r5v68 int)
      (r5v1 int)
      (r5v69 int)
      (r5v1 int)
      (r5v70 int)
      (r5v1 int)
      (r5v71 int)
      (r5v72 int)
      (r5v1 int)
      (r5v73 int)
      (r5v1 int)
      (r5v74 int)
      (r5v1 int)
      (r5v75 int)
      (r5v1 int)
      (r5v76 int)
      (r5v1 int)
      (r5v77 int)
      (r5v1 int)
      (r5v78 int)
      (r5v1 int)
      (r5v79 int)
      (r5v1 int)
      (r5v80 int)
      (r5v1 int)
      (r5v81 int)
     binds: [B:253:0x05b6, B:454:0x0a7c, B:448:0x0a5e, B:452:0x0a71, B:451:0x0a68, B:445:0x0a4b, B:446:0x0a4d, B:442:0x0a3b, B:443:0x0a3d, B:439:0x0a2d, B:440:0x0a2f, B:436:0x0a1f, B:437:0x0a21, B:433:0x0a14, B:434:0x0a16, B:430:0x0a08, B:431:0x0a0a, B:427:0x09fa, B:428:0x09fc, B:424:0x09ec, B:425:0x09ee, B:421:0x09d8, B:422:0x09da, B:416:0x09c2, B:406:0x0958, B:405:0x0947, B:404:0x093a, B:403:0x092c, B:393:0x08cf, B:397:0x08d9, B:387:0x08ae, B:391:0x08b8, B:381:0x088d, B:385:0x0897, B:375:0x086c, B:379:0x0876, B:369:0x084b, B:373:0x0855, B:363:0x082a, B:367:0x0834, B:357:0x0809, B:361:0x0813, B:351:0x07e8, B:355:0x07f2, B:345:0x07c7, B:349:0x07d1, B:339:0x07a6, B:343:0x07b0, B:333:0x0785, B:337:0x078f, B:327:0x0764, B:331:0x076e, B:321:0x0743, B:325:0x074d, B:315:0x0722, B:319:0x072c, B:313:0x0707, B:312:0x06f6, B:310:0x06eb, B:311:0x06ed, B:307:0x06dd, B:308:0x06df, B:304:0x06cc, B:305:0x06ce, B:301:0x06bb, B:302:0x06bd, B:298:0x06aa, B:299:0x06ac, B:295:0x069b, B:296:0x069d, B:292:0x068d, B:293:0x068f, B:289:0x067f, B:290:0x0681, B:283:0x065f, B:287:0x0672, B:286:0x0669, B:280:0x064a, B:281:0x064c, B:277:0x0637, B:278:0x0639, B:274:0x0626, B:275:0x0628, B:271:0x0615, B:272:0x0617, B:268:0x0607, B:269:0x0609, B:265:0x05f8, B:266:0x05fa, B:262:0x05e7, B:263:0x05e9, B:259:0x05d6, B:260:0x05d8, B:256:0x05bf, B:257:0x05c1] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$PrimitiveArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:596)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    @Override // com.google.android.gms.internal.measurement.zzgx
    public final int zzt(T t) {
        int i;
        int i2;
        long j;
        int i3 = 267386880;
        int i4 = 1048575;
        int i5 = 1;
        if (this.zzakq) {
            Unsafe unsafe = zzaki;
            int i6 = 0;
            int iZzb = 0;
            while (i6 < this.zzakj.length) {
                int iZzca = zzca(i6);
                int i7 = (iZzca & i3) >>> 20;
                int i8 = this.zzakj[i6];
                long j2 = iZzca & 1048575;
                int i9 = (i7 < zzet.DOUBLE_LIST_PACKED.m41id() || i7 > zzet.SINT64_LIST_PACKED.m41id()) ? 0 : this.zzakj[i6 + 2] & 1048575;
                switch (i7) {
                    case 0:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzb(i8, 0.0d);
                        }
                        break;
                    case 1:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzb(i8, 0.0f);
                        }
                        break;
                    case 2:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzd(i8, zzhv.zzl(t, j2));
                        }
                        break;
                    case 3:
                        if (zza(t, i6)) {
                            iZzb += zzee.zze(i8, zzhv.zzl(t, j2));
                        }
                        break;
                    case 4:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzg(i8, zzhv.zzk(t, j2));
                        }
                        break;
                    case 5:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzg(i8, 0L);
                        }
                        break;
                    case 6:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzj(i8, 0);
                        }
                        break;
                    case 7:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzc(i8, true);
                        }
                        break;
                    case 8:
                        if (zza(t, i6)) {
                            Object objZzp = zzhv.zzp(t, j2);
                            if (objZzp instanceof zzdp) {
                                iZzb += zzee.zzc(i8, (zzdp) objZzp);
                            } else {
                                iZzb += zzee.zzc(i8, (String) objZzp);
                            }
                        }
                        break;
                    case 9:
                        if (zza(t, i6)) {
                            iZzb += zzgz.zzc(i8, zzhv.zzp(t, j2), zzbx(i6));
                        }
                        break;
                    case 10:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzc(i8, (zzdp) zzhv.zzp(t, j2));
                        }
                        break;
                    case 11:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzh(i8, zzhv.zzk(t, j2));
                        }
                        break;
                    case 12:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzl(i8, zzhv.zzk(t, j2));
                        }
                        break;
                    case 13:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzk(i8, 0);
                        }
                        break;
                    case 14:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzh(i8, 0L);
                        }
                        break;
                    case 15:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzi(i8, zzhv.zzk(t, j2));
                        }
                        break;
                    case 16:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzf(i8, zzhv.zzl(t, j2));
                        }
                        break;
                    case 17:
                        if (zza(t, i6)) {
                            iZzb += zzee.zzc(i8, (zzgi) zzhv.zzp(t, j2), zzbx(i6));
                        }
                        break;
                    case 18:
                        iZzb += zzgz.zzw(i8, zze(t, j2), false);
                        break;
                    case 19:
                        iZzb += zzgz.zzv(i8, zze(t, j2), false);
                        break;
                    case 20:
                        iZzb += zzgz.zzo(i8, zze(t, j2), false);
                        break;
                    case 21:
                        iZzb += zzgz.zzp(i8, zze(t, j2), false);
                        break;
                    case 22:
                        iZzb += zzgz.zzs(i8, zze(t, j2), false);
                        break;
                    case 23:
                        iZzb += zzgz.zzw(i8, zze(t, j2), false);
                        break;
                    case 24:
                        iZzb += zzgz.zzv(i8, zze(t, j2), false);
                        break;
                    case 25:
                        iZzb += zzgz.zzx(i8, zze(t, j2), false);
                        break;
                    case 26:
                        iZzb += zzgz.zzc(i8, zze(t, j2));
                        break;
                    case 27:
                        iZzb += zzgz.zzc(i8, zze(t, j2), zzbx(i6));
                        break;
                    case 28:
                        iZzb += zzgz.zzd(i8, (List<zzdp>) zze(t, j2));
                        break;
                    case 29:
                        iZzb += zzgz.zzt(i8, zze(t, j2), false);
                        break;
                    case 30:
                        iZzb += zzgz.zzr(i8, zze(t, j2), false);
                        break;
                    case FTPCommand.HELP /* 31 */:
                        iZzb += zzgz.zzv(i8, zze(t, j2), false);
                        break;
                    case 32:
                        iZzb += zzgz.zzw(i8, zze(t, j2), false);
                        break;
                    case 33:
                        iZzb += zzgz.zzu(i8, zze(t, j2), false);
                        break;
                    case 34:
                        iZzb += zzgz.zzq(i8, zze(t, j2), false);
                        break;
                    case 35:
                        int iZzac = zzgz.zzac((List) unsafe.getObject(t, j2));
                        if (iZzac > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzac);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzac) + iZzac;
                        }
                        break;
                    case 36:
                        int iZzab = zzgz.zzab((List) unsafe.getObject(t, j2));
                        if (iZzab > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzab);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzab) + iZzab;
                        }
                        break;
                    case 37:
                        int iZzu = zzgz.zzu((List) unsafe.getObject(t, j2));
                        if (iZzu > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzu);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzu) + iZzu;
                        }
                        break;
                    case 38:
                        int iZzv = zzgz.zzv((List) unsafe.getObject(t, j2));
                        if (iZzv > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzv);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzv) + iZzv;
                        }
                        break;
                    case 39:
                        int iZzy = zzgz.zzy((List) unsafe.getObject(t, j2));
                        if (iZzy > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzy);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzy) + iZzy;
                        }
                        break;
                    case MotionEventCompat.AXIS_GENERIC_9 /* 40 */:
                        int iZzac2 = zzgz.zzac((List) unsafe.getObject(t, j2));
                        if (iZzac2 > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzac2);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzac2) + iZzac2;
                        }
                        break;
                    case MotionEventCompat.AXIS_GENERIC_10 /* 41 */:
                        int iZzab2 = zzgz.zzab((List) unsafe.getObject(t, j2));
                        if (iZzab2 > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzab2);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzab2) + iZzab2;
                        }
                        break;
                    case MotionEventCompat.AXIS_GENERIC_11 /* 42 */:
                        int iZzad = zzgz.zzad((List) unsafe.getObject(t, j2));
                        if (iZzad > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzad);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzad) + iZzad;
                        }
                        break;
                    case MotionEventCompat.AXIS_GENERIC_12 /* 43 */:
                        int iZzz = zzgz.zzz((List) unsafe.getObject(t, j2));
                        if (iZzz > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzz);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzz) + iZzz;
                        }
                        break;
                    case MotionEventCompat.AXIS_GENERIC_13 /* 44 */:
                        int iZzx = zzgz.zzx((List) unsafe.getObject(t, j2));
                        if (iZzx > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzx);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzx) + iZzx;
                        }
                        break;
                    case MotionEventCompat.AXIS_GENERIC_14 /* 45 */:
                        int iZzab3 = zzgz.zzab((List) unsafe.getObject(t, j2));
                        if (iZzab3 > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzab3);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzab3) + iZzab3;
                        }
                        break;
                    case MotionEventCompat.AXIS_GENERIC_15 /* 46 */:
                        int iZzac3 = zzgz.zzac((List) unsafe.getObject(t, j2));
                        if (iZzac3 > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzac3);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzac3) + iZzac3;
                        }
                        break;
                    case MotionEventCompat.AXIS_GENERIC_16 /* 47 */:
                        int iZzaa = zzgz.zzaa((List) unsafe.getObject(t, j2));
                        if (iZzaa > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzaa);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzaa) + iZzaa;
                        }
                        break;
                    case 48:
                        int iZzw = zzgz.zzw((List) unsafe.getObject(t, j2));
                        if (iZzw > 0) {
                            if (this.zzakr) {
                                unsafe.putInt(t, i9, iZzw);
                            }
                            iZzb += zzee.zzbi(i8) + zzee.zzbk(iZzw) + iZzw;
                        }
                        break;
                    case 49:
                        iZzb += zzgz.zzd(i8, zze(t, j2), zzbx(i6));
                        break;
                    case 50:
                        iZzb += this.zzakz.zzb(i8, zzhv.zzp(t, j2), zzby(i6));
                        break;
                    case 51:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzb(i8, 0.0d);
                        }
                        break;
                    case 52:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzb(i8, 0.0f);
                        }
                        break;
                    case 53:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzd(i8, zzi(t, j2));
                        }
                        break;
                    case 54:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zze(i8, zzi(t, j2));
                        }
                        break;
                    case 55:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzg(i8, zzh(t, j2));
                        }
                        break;
                    case 56:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzg(i8, 0L);
                        }
                        break;
                    case 57:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzj(i8, 0);
                        }
                        break;
                    case 58:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzc(i8, true);
                        }
                        break;
                    case 59:
                        if (zza(t, i8, i6)) {
                            Object objZzp2 = zzhv.zzp(t, j2);
                            if (objZzp2 instanceof zzdp) {
                                iZzb += zzee.zzc(i8, (zzdp) objZzp2);
                            } else {
                                iZzb += zzee.zzc(i8, (String) objZzp2);
                            }
                        }
                        break;
                    case 60:
                        if (zza(t, i8, i6)) {
                            iZzb += zzgz.zzc(i8, zzhv.zzp(t, j2), zzbx(i6));
                        }
                        break;
                    case 61:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzc(i8, (zzdp) zzhv.zzp(t, j2));
                        }
                        break;
                    case 62:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzh(i8, zzh(t, j2));
                        }
                        break;
                    case HtmlCompat.FROM_HTML_MODE_COMPACT /* 63 */:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzl(i8, zzh(t, j2));
                        }
                        break;
                    case 64:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzk(i8, 0);
                        }
                        break;
                    case 65:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzh(i8, 0L);
                        }
                        break;
                    case 66:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzi(i8, zzh(t, j2));
                        }
                        break;
                    case 67:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzf(i8, zzi(t, j2));
                        }
                        break;
                    case 68:
                        if (zza(t, i8, i6)) {
                            iZzb += zzee.zzc(i8, (zzgi) zzhv.zzp(t, j2), zzbx(i6));
                        }
                        break;
                }
                i6 += 3;
                i3 = 267386880;
            }
            return iZzb + zza(this.zzakx, t);
        }
        Unsafe unsafe2 = zzaki;
        int i10 = 0;
        int iZzb2 = 0;
        int i11 = -1;
        int i12 = 0;
        while (i10 < this.zzakj.length) {
            int iZzca2 = zzca(i10);
            int i13 = this.zzakj[i10];
            int i14 = (iZzca2 & 267386880) >>> 20;
            if (i14 <= 17) {
                i = this.zzakj[i10 + 2];
                int i15 = i & i4;
                i2 = i5 << (i >>> 20);
                if (i15 != i11) {
                    i12 = unsafe2.getInt(t, i15);
                    i11 = i15;
                }
            } else {
                i = (!this.zzakr || i14 < zzet.DOUBLE_LIST_PACKED.m41id() || i14 > zzet.SINT64_LIST_PACKED.m41id()) ? 0 : this.zzakj[i10 + 2] & i4;
                i2 = 0;
            }
            long j3 = iZzca2 & i4;
            switch (i14) {
                case 0:
                    j = 0;
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzb(i13, 0.0d);
                    }
                    break;
                case 1:
                    j = 0;
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzb(i13, 0.0f);
                    }
                    break;
                case 2:
                    j = 0;
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzd(i13, unsafe2.getLong(t, j3));
                    }
                    break;
                case 3:
                    j = 0;
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zze(i13, unsafe2.getLong(t, j3));
                    }
                    break;
                case 4:
                    j = 0;
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzg(i13, unsafe2.getInt(t, j3));
                    }
                    break;
                case 5:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzg(i13, 0L);
                        j = 0;
                    }
                    j = 0;
                    break;
                case 6:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzj(i13, 0);
                    }
                    j = 0;
                    break;
                case 7:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzc(i13, true);
                    }
                    j = 0;
                    break;
                case 8:
                    if ((i12 & i2) != 0) {
                        Object object = unsafe2.getObject(t, j3);
                        if (object instanceof zzdp) {
                            iZzb2 += zzee.zzc(i13, (zzdp) object);
                        } else {
                            iZzb2 += zzee.zzc(i13, (String) object);
                        }
                    }
                    j = 0;
                    break;
                case 9:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzgz.zzc(i13, unsafe2.getObject(t, j3), zzbx(i10));
                    }
                    j = 0;
                    break;
                case 10:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzc(i13, (zzdp) unsafe2.getObject(t, j3));
                    }
                    j = 0;
                    break;
                case 11:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzh(i13, unsafe2.getInt(t, j3));
                    }
                    j = 0;
                    break;
                case 12:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzl(i13, unsafe2.getInt(t, j3));
                    }
                    j = 0;
                    break;
                case 13:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzk(i13, 0);
                    }
                    j = 0;
                    break;
                case 14:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzh(i13, 0L);
                    }
                    j = 0;
                    break;
                case 15:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzi(i13, unsafe2.getInt(t, j3));
                    }
                    j = 0;
                    break;
                case 16:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzf(i13, unsafe2.getLong(t, j3));
                    }
                    j = 0;
                    break;
                case 17:
                    if ((i12 & i2) != 0) {
                        iZzb2 += zzee.zzc(i13, (zzgi) unsafe2.getObject(t, j3), zzbx(i10));
                    }
                    j = 0;
                    break;
                case 18:
                    iZzb2 += zzgz.zzw(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 19:
                    iZzb2 += zzgz.zzv(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 20:
                    iZzb2 += zzgz.zzo(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 21:
                    iZzb2 += zzgz.zzp(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 22:
                    iZzb2 += zzgz.zzs(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 23:
                    iZzb2 += zzgz.zzw(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 24:
                    iZzb2 += zzgz.zzv(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 25:
                    iZzb2 += zzgz.zzx(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 26:
                    iZzb2 += zzgz.zzc(i13, (List) unsafe2.getObject(t, j3));
                    j = 0;
                    break;
                case 27:
                    iZzb2 += zzgz.zzc(i13, (List<?>) unsafe2.getObject(t, j3), zzbx(i10));
                    j = 0;
                    break;
                case 28:
                    iZzb2 += zzgz.zzd(i13, (List<zzdp>) unsafe2.getObject(t, j3));
                    j = 0;
                    break;
                case 29:
                    iZzb2 += zzgz.zzt(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 30:
                    iZzb2 += zzgz.zzr(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case FTPCommand.HELP /* 31 */:
                    iZzb2 += zzgz.zzv(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 32:
                    iZzb2 += zzgz.zzw(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 33:
                    iZzb2 += zzgz.zzu(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 34:
                    iZzb2 += zzgz.zzq(i13, (List) unsafe2.getObject(t, j3), false);
                    j = 0;
                    break;
                case 35:
                    int iZzac4 = zzgz.zzac((List) unsafe2.getObject(t, j3));
                    if (iZzac4 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzac4);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzac4) + iZzac4;
                    }
                    j = 0;
                    break;
                case 36:
                    int iZzab4 = zzgz.zzab((List) unsafe2.getObject(t, j3));
                    if (iZzab4 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzab4);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzab4) + iZzab4;
                    }
                    j = 0;
                    break;
                case 37:
                    int iZzu2 = zzgz.zzu((List) unsafe2.getObject(t, j3));
                    if (iZzu2 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzu2);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzu2) + iZzu2;
                    }
                    j = 0;
                    break;
                case 38:
                    int iZzv2 = zzgz.zzv((List) unsafe2.getObject(t, j3));
                    if (iZzv2 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzv2);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzv2) + iZzv2;
                    }
                    j = 0;
                    break;
                case 39:
                    int iZzy2 = zzgz.zzy((List) unsafe2.getObject(t, j3));
                    if (iZzy2 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzy2);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzy2) + iZzy2;
                    }
                    j = 0;
                    break;
                case MotionEventCompat.AXIS_GENERIC_9 /* 40 */:
                    int iZzac5 = zzgz.zzac((List) unsafe2.getObject(t, j3));
                    if (iZzac5 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzac5);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzac5) + iZzac5;
                    }
                    j = 0;
                    break;
                case MotionEventCompat.AXIS_GENERIC_10 /* 41 */:
                    int iZzab5 = zzgz.zzab((List) unsafe2.getObject(t, j3));
                    if (iZzab5 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzab5);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzab5) + iZzab5;
                    }
                    j = 0;
                    break;
                case MotionEventCompat.AXIS_GENERIC_11 /* 42 */:
                    int iZzad2 = zzgz.zzad((List) unsafe2.getObject(t, j3));
                    if (iZzad2 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzad2);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzad2) + iZzad2;
                    }
                    j = 0;
                    break;
                case MotionEventCompat.AXIS_GENERIC_12 /* 43 */:
                    int iZzz2 = zzgz.zzz((List) unsafe2.getObject(t, j3));
                    if (iZzz2 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzz2);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzz2) + iZzz2;
                    }
                    j = 0;
                    break;
                case MotionEventCompat.AXIS_GENERIC_13 /* 44 */:
                    int iZzx2 = zzgz.zzx((List) unsafe2.getObject(t, j3));
                    if (iZzx2 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzx2);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzx2) + iZzx2;
                    }
                    j = 0;
                    break;
                case MotionEventCompat.AXIS_GENERIC_14 /* 45 */:
                    int iZzab6 = zzgz.zzab((List) unsafe2.getObject(t, j3));
                    if (iZzab6 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzab6);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzab6) + iZzab6;
                    }
                    j = 0;
                    break;
                case MotionEventCompat.AXIS_GENERIC_15 /* 46 */:
                    int iZzac6 = zzgz.zzac((List) unsafe2.getObject(t, j3));
                    if (iZzac6 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzac6);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzac6) + iZzac6;
                    }
                    j = 0;
                    break;
                case MotionEventCompat.AXIS_GENERIC_16 /* 47 */:
                    int iZzaa2 = zzgz.zzaa((List) unsafe2.getObject(t, j3));
                    if (iZzaa2 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzaa2);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzaa2) + iZzaa2;
                    }
                    j = 0;
                    break;
                case 48:
                    int iZzw2 = zzgz.zzw((List) unsafe2.getObject(t, j3));
                    if (iZzw2 > 0) {
                        if (this.zzakr) {
                            unsafe2.putInt(t, i, iZzw2);
                        }
                        iZzb2 += zzee.zzbi(i13) + zzee.zzbk(iZzw2) + iZzw2;
                    }
                    j = 0;
                    break;
                case 49:
                    iZzb2 += zzgz.zzd(i13, (List) unsafe2.getObject(t, j3), zzbx(i10));
                    j = 0;
                    break;
                case 50:
                    iZzb2 += this.zzakz.zzb(i13, unsafe2.getObject(t, j3), zzby(i10));
                    j = 0;
                    break;
                case 51:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzb(i13, 0.0d);
                    }
                    j = 0;
                    break;
                case 52:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzb(i13, 0.0f);
                    }
                    j = 0;
                    break;
                case 53:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzd(i13, zzi(t, j3));
                    }
                    j = 0;
                    break;
                case 54:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zze(i13, zzi(t, j3));
                    }
                    j = 0;
                    break;
                case 55:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzg(i13, zzh(t, j3));
                    }
                    j = 0;
                    break;
                case 56:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzg(i13, 0L);
                    }
                    j = 0;
                    break;
                case 57:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzj(i13, 0);
                    }
                    j = 0;
                    break;
                case 58:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzc(i13, true);
                    }
                    j = 0;
                    break;
                case 59:
                    if (zza(t, i13, i10)) {
                        Object object2 = unsafe2.getObject(t, j3);
                        if (object2 instanceof zzdp) {
                            iZzb2 += zzee.zzc(i13, (zzdp) object2);
                        } else {
                            iZzb2 += zzee.zzc(i13, (String) object2);
                        }
                    }
                    j = 0;
                    break;
                case 60:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzgz.zzc(i13, unsafe2.getObject(t, j3), zzbx(i10));
                    }
                    j = 0;
                    break;
                case 61:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzc(i13, (zzdp) unsafe2.getObject(t, j3));
                    }
                    j = 0;
                    break;
                case 62:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzh(i13, zzh(t, j3));
                    }
                    j = 0;
                    break;
                case HtmlCompat.FROM_HTML_MODE_COMPACT /* 63 */:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzl(i13, zzh(t, j3));
                    }
                    j = 0;
                    break;
                case 64:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzk(i13, 0);
                    }
                    j = 0;
                    break;
                case 65:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzh(i13, 0L);
                    }
                    j = 0;
                    break;
                case 66:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzi(i13, zzh(t, j3));
                    }
                    j = 0;
                    break;
                case 67:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzf(i13, zzi(t, j3));
                    }
                    j = 0;
                    break;
                case 68:
                    if (zza(t, i13, i10)) {
                        iZzb2 += zzee.zzc(i13, (zzgi) unsafe2.getObject(t, j3), zzbx(i10));
                    }
                    j = 0;
                    break;
                default:
                    j = 0;
                    break;
            }
            i10 += 3;
            i4 = 1048575;
            i5 = 1;
        }
        int iZza = iZzb2 + zza(this.zzakx, t);
        if (!this.zzako) {
            return iZza;
        }
        zzeo<T> zzeoVarZzh = this.zzaky.zzh(t);
        int iZzb3 = 0;
        for (int i16 = 0; i16 < zzeoVarZzh.zzaex.zzwh(); i16++) {
            Map.Entry entryZzcf = zzeoVarZzh.zzaex.zzcf(i16);
            iZzb3 += zzeo.zzb((zzeq<?>) entryZzcf.getKey(), entryZzcf.getValue());
        }
        for (Map.Entry entry : zzeoVarZzh.zzaex.zzwi()) {
            iZzb3 += zzeo.zzb((zzeq<?>) entry.getKey(), entry.getValue());
        }
        return iZza + iZzb3;
    }

    private static <UT, UB> int zza(zzhp<UT, UB> zzhpVar, T t) {
        return zzhpVar.zzt(zzhpVar.zzx(t));
    }

    private static List<?> zze(Object obj, long j) {
        return (List) zzhv.zzp(obj, j);
    }

    /* JADX WARN: Code duplicated, block: B:178:0x054a  */
    /* JADX WARN: Code duplicated, block: B:9:0x0032  */
    @Override // com.google.android.gms.internal.measurement.zzgx
    public final void zza(T t, zzim zzimVar) throws IOException {
        Iterator it;
        Map.Entry<?, ?> entry;
        Iterator itDescendingIterator;
        Map.Entry<?, ?> entry2;
        if (zzimVar.zztk() == zzey.zzd.zzaip) {
            zza(this.zzakx, t, zzimVar);
            if (this.zzako) {
                zzeo<T> zzeoVarZzh = this.zzaky.zzh(t);
                if (zzeoVarZzh.zzaex.isEmpty()) {
                    itDescendingIterator = null;
                    entry2 = null;
                } else {
                    itDescendingIterator = zzeoVarZzh.descendingIterator();
                    entry2 = (Map.Entry) itDescendingIterator.next();
                }
            } else {
                itDescendingIterator = null;
                entry2 = null;
            }
            for (int length = this.zzakj.length - 3; length >= 0; length -= 3) {
                int iZzca = zzca(length);
                int i = this.zzakj[length];
                while (entry2 != null && this.zzaky.zza(entry2) > i) {
                    this.zzaky.zza(zzimVar, entry2);
                    entry2 = itDescendingIterator.hasNext() ? (Map.Entry) itDescendingIterator.next() : null;
                }
                switch ((iZzca & 267386880) >>> 20) {
                    case 0:
                        if (zza(t, length)) {
                            zzimVar.zza(i, zzhv.zzo(t, iZzca & 1048575));
                        }
                        break;
                    case 1:
                        if (zza(t, length)) {
                            zzimVar.zza(i, zzhv.zzn(t, iZzca & 1048575));
                        }
                        break;
                    case 2:
                        if (zza(t, length)) {
                            zzimVar.zzi(i, zzhv.zzl(t, iZzca & 1048575));
                        }
                        break;
                    case 3:
                        if (zza(t, length)) {
                            zzimVar.zza(i, zzhv.zzl(t, iZzca & 1048575));
                        }
                        break;
                    case 4:
                        if (zza(t, length)) {
                            zzimVar.zzc(i, zzhv.zzk(t, iZzca & 1048575));
                        }
                        break;
                    case 5:
                        if (zza(t, length)) {
                            zzimVar.zzc(i, zzhv.zzl(t, iZzca & 1048575));
                        }
                        break;
                    case 6:
                        if (zza(t, length)) {
                            zzimVar.zzf(i, zzhv.zzk(t, iZzca & 1048575));
                        }
                        break;
                    case 7:
                        if (zza(t, length)) {
                            zzimVar.zzb(i, zzhv.zzm(t, iZzca & 1048575));
                        }
                        break;
                    case 8:
                        if (zza(t, length)) {
                            zza(i, zzhv.zzp(t, iZzca & 1048575), zzimVar);
                        }
                        break;
                    case 9:
                        if (zza(t, length)) {
                            zzimVar.zza(i, zzhv.zzp(t, iZzca & 1048575), zzbx(length));
                        }
                        break;
                    case 10:
                        if (zza(t, length)) {
                            zzimVar.zza(i, (zzdp) zzhv.zzp(t, iZzca & 1048575));
                        }
                        break;
                    case 11:
                        if (zza(t, length)) {
                            zzimVar.zzd(i, zzhv.zzk(t, iZzca & 1048575));
                        }
                        break;
                    case 12:
                        if (zza(t, length)) {
                            zzimVar.zzn(i, zzhv.zzk(t, iZzca & 1048575));
                        }
                        break;
                    case 13:
                        if (zza(t, length)) {
                            zzimVar.zzm(i, zzhv.zzk(t, iZzca & 1048575));
                        }
                        break;
                    case 14:
                        if (zza(t, length)) {
                            zzimVar.zzj(i, zzhv.zzl(t, iZzca & 1048575));
                        }
                        break;
                    case 15:
                        if (zza(t, length)) {
                            zzimVar.zze(i, zzhv.zzk(t, iZzca & 1048575));
                        }
                        break;
                    case 16:
                        if (zza(t, length)) {
                            zzimVar.zzb(i, zzhv.zzl(t, iZzca & 1048575));
                        }
                        break;
                    case 17:
                        if (zza(t, length)) {
                            zzimVar.zzb(i, zzhv.zzp(t, iZzca & 1048575), zzbx(length));
                        }
                        break;
                    case 18:
                        zzgz.zza(this.zzakj[length], (List<Double>) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 19:
                        zzgz.zzb(this.zzakj[length], (List<Float>) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 20:
                        zzgz.zzc(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 21:
                        zzgz.zzd(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 22:
                        zzgz.zzh(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 23:
                        zzgz.zzf(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 24:
                        zzgz.zzk(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 25:
                        zzgz.zzn(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 26:
                        zzgz.zza(this.zzakj[length], (List<String>) zzhv.zzp(t, iZzca & 1048575), zzimVar);
                        break;
                    case 27:
                        zzgz.zza(this.zzakj[length], (List<?>) zzhv.zzp(t, iZzca & 1048575), zzimVar, zzbx(length));
                        break;
                    case 28:
                        zzgz.zzb(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar);
                        break;
                    case 29:
                        zzgz.zzi(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 30:
                        zzgz.zzm(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case FTPCommand.HELP /* 31 */:
                        zzgz.zzl(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 32:
                        zzgz.zzg(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 33:
                        zzgz.zzj(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 34:
                        zzgz.zze(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, false);
                        break;
                    case 35:
                        zzgz.zza(this.zzakj[length], (List<Double>) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case 36:
                        zzgz.zzb(this.zzakj[length], (List<Float>) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case 37:
                        zzgz.zzc(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case 38:
                        zzgz.zzd(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case 39:
                        zzgz.zzh(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_9 /* 40 */:
                        zzgz.zzf(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_10 /* 41 */:
                        zzgz.zzk(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_11 /* 42 */:
                        zzgz.zzn(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_12 /* 43 */:
                        zzgz.zzi(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_13 /* 44 */:
                        zzgz.zzm(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_14 /* 45 */:
                        zzgz.zzl(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_15 /* 46 */:
                        zzgz.zzg(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_16 /* 47 */:
                        zzgz.zzj(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case 48:
                        zzgz.zze(this.zzakj[length], (List) zzhv.zzp(t, iZzca & 1048575), zzimVar, true);
                        break;
                    case 49:
                        zzgz.zzb(this.zzakj[length], (List<?>) zzhv.zzp(t, iZzca & 1048575), zzimVar, zzbx(length));
                        break;
                    case 50:
                        zza(zzimVar, i, zzhv.zzp(t, iZzca & 1048575), length);
                        break;
                    case 51:
                        if (zza(t, i, length)) {
                            zzimVar.zza(i, zzf(t, iZzca & 1048575));
                        }
                        break;
                    case 52:
                        if (zza(t, i, length)) {
                            zzimVar.zza(i, zzg(t, iZzca & 1048575));
                        }
                        break;
                    case 53:
                        if (zza(t, i, length)) {
                            zzimVar.zzi(i, zzi(t, iZzca & 1048575));
                        }
                        break;
                    case 54:
                        if (zza(t, i, length)) {
                            zzimVar.zza(i, zzi(t, iZzca & 1048575));
                        }
                        break;
                    case 55:
                        if (zza(t, i, length)) {
                            zzimVar.zzc(i, zzh(t, iZzca & 1048575));
                        }
                        break;
                    case 56:
                        if (zza(t, i, length)) {
                            zzimVar.zzc(i, zzi(t, iZzca & 1048575));
                        }
                        break;
                    case 57:
                        if (zza(t, i, length)) {
                            zzimVar.zzf(i, zzh(t, iZzca & 1048575));
                        }
                        break;
                    case 58:
                        if (zza(t, i, length)) {
                            zzimVar.zzb(i, zzj(t, iZzca & 1048575));
                        }
                        break;
                    case 59:
                        if (zza(t, i, length)) {
                            zza(i, zzhv.zzp(t, iZzca & 1048575), zzimVar);
                        }
                        break;
                    case 60:
                        if (zza(t, i, length)) {
                            zzimVar.zza(i, zzhv.zzp(t, iZzca & 1048575), zzbx(length));
                        }
                        break;
                    case 61:
                        if (zza(t, i, length)) {
                            zzimVar.zza(i, (zzdp) zzhv.zzp(t, iZzca & 1048575));
                        }
                        break;
                    case 62:
                        if (zza(t, i, length)) {
                            zzimVar.zzd(i, zzh(t, iZzca & 1048575));
                        }
                        break;
                    case HtmlCompat.FROM_HTML_MODE_COMPACT /* 63 */:
                        if (zza(t, i, length)) {
                            zzimVar.zzn(i, zzh(t, iZzca & 1048575));
                        }
                        break;
                    case 64:
                        if (zza(t, i, length)) {
                            zzimVar.zzm(i, zzh(t, iZzca & 1048575));
                        }
                        break;
                    case 65:
                        if (zza(t, i, length)) {
                            zzimVar.zzj(i, zzi(t, iZzca & 1048575));
                        }
                        break;
                    case 66:
                        if (zza(t, i, length)) {
                            zzimVar.zze(i, zzh(t, iZzca & 1048575));
                        }
                        break;
                    case 67:
                        if (zza(t, i, length)) {
                            zzimVar.zzb(i, zzi(t, iZzca & 1048575));
                        }
                        break;
                    case 68:
                        if (zza(t, i, length)) {
                            zzimVar.zzb(i, zzhv.zzp(t, iZzca & 1048575), zzbx(length));
                        }
                        break;
                }
            }
            while (entry2 != null) {
                this.zzaky.zza(zzimVar, entry2);
                entry2 = itDescendingIterator.hasNext() ? (Map.Entry) itDescendingIterator.next() : null;
            }
            return;
        }
        if (this.zzakq) {
            if (this.zzako) {
                zzeo<T> zzeoVarZzh2 = this.zzaky.zzh(t);
                if (zzeoVarZzh2.zzaex.isEmpty()) {
                    it = null;
                    entry = null;
                } else {
                    it = zzeoVarZzh2.iterator();
                    entry = (Map.Entry) it.next();
                }
            } else {
                it = null;
                entry = null;
            }
            int length2 = this.zzakj.length;
            Map.Entry<?, ?> entry3 = entry;
            for (int i2 = 0; i2 < length2; i2 += 3) {
                int iZzca2 = zzca(i2);
                int i3 = this.zzakj[i2];
                while (entry3 != null && this.zzaky.zza(entry3) <= i3) {
                    this.zzaky.zza(zzimVar, entry3);
                    entry3 = it.hasNext() ? (Map.Entry) it.next() : null;
                }
                switch ((iZzca2 & 267386880) >>> 20) {
                    case 0:
                        if (zza(t, i2)) {
                            zzimVar.zza(i3, zzhv.zzo(t, iZzca2 & 1048575));
                        }
                        break;
                    case 1:
                        if (zza(t, i2)) {
                            zzimVar.zza(i3, zzhv.zzn(t, iZzca2 & 1048575));
                        }
                        break;
                    case 2:
                        if (zza(t, i2)) {
                            zzimVar.zzi(i3, zzhv.zzl(t, iZzca2 & 1048575));
                        }
                        break;
                    case 3:
                        if (zza(t, i2)) {
                            zzimVar.zza(i3, zzhv.zzl(t, iZzca2 & 1048575));
                        }
                        break;
                    case 4:
                        if (zza(t, i2)) {
                            zzimVar.zzc(i3, zzhv.zzk(t, iZzca2 & 1048575));
                        }
                        break;
                    case 5:
                        if (zza(t, i2)) {
                            zzimVar.zzc(i3, zzhv.zzl(t, iZzca2 & 1048575));
                        }
                        break;
                    case 6:
                        if (zza(t, i2)) {
                            zzimVar.zzf(i3, zzhv.zzk(t, iZzca2 & 1048575));
                        }
                        break;
                    case 7:
                        if (zza(t, i2)) {
                            zzimVar.zzb(i3, zzhv.zzm(t, iZzca2 & 1048575));
                        }
                        break;
                    case 8:
                        if (zza(t, i2)) {
                            zza(i3, zzhv.zzp(t, iZzca2 & 1048575), zzimVar);
                        }
                        break;
                    case 9:
                        if (zza(t, i2)) {
                            zzimVar.zza(i3, zzhv.zzp(t, iZzca2 & 1048575), zzbx(i2));
                        }
                        break;
                    case 10:
                        if (zza(t, i2)) {
                            zzimVar.zza(i3, (zzdp) zzhv.zzp(t, iZzca2 & 1048575));
                        }
                        break;
                    case 11:
                        if (zza(t, i2)) {
                            zzimVar.zzd(i3, zzhv.zzk(t, iZzca2 & 1048575));
                        }
                        break;
                    case 12:
                        if (zza(t, i2)) {
                            zzimVar.zzn(i3, zzhv.zzk(t, iZzca2 & 1048575));
                        }
                        break;
                    case 13:
                        if (zza(t, i2)) {
                            zzimVar.zzm(i3, zzhv.zzk(t, iZzca2 & 1048575));
                        }
                        break;
                    case 14:
                        if (zza(t, i2)) {
                            zzimVar.zzj(i3, zzhv.zzl(t, iZzca2 & 1048575));
                        }
                        break;
                    case 15:
                        if (zza(t, i2)) {
                            zzimVar.zze(i3, zzhv.zzk(t, iZzca2 & 1048575));
                        }
                        break;
                    case 16:
                        if (zza(t, i2)) {
                            zzimVar.zzb(i3, zzhv.zzl(t, iZzca2 & 1048575));
                        }
                        break;
                    case 17:
                        if (zza(t, i2)) {
                            zzimVar.zzb(i3, zzhv.zzp(t, iZzca2 & 1048575), zzbx(i2));
                        }
                        break;
                    case 18:
                        zzgz.zza(this.zzakj[i2], (List<Double>) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 19:
                        zzgz.zzb(this.zzakj[i2], (List<Float>) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 20:
                        zzgz.zzc(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 21:
                        zzgz.zzd(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 22:
                        zzgz.zzh(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 23:
                        zzgz.zzf(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 24:
                        zzgz.zzk(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 25:
                        zzgz.zzn(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 26:
                        zzgz.zza(this.zzakj[i2], (List<String>) zzhv.zzp(t, iZzca2 & 1048575), zzimVar);
                        break;
                    case 27:
                        zzgz.zza(this.zzakj[i2], (List<?>) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, zzbx(i2));
                        break;
                    case 28:
                        zzgz.zzb(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar);
                        break;
                    case 29:
                        zzgz.zzi(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 30:
                        zzgz.zzm(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case FTPCommand.HELP /* 31 */:
                        zzgz.zzl(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 32:
                        zzgz.zzg(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 33:
                        zzgz.zzj(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 34:
                        zzgz.zze(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, false);
                        break;
                    case 35:
                        zzgz.zza(this.zzakj[i2], (List<Double>) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case 36:
                        zzgz.zzb(this.zzakj[i2], (List<Float>) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case 37:
                        zzgz.zzc(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case 38:
                        zzgz.zzd(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case 39:
                        zzgz.zzh(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_9 /* 40 */:
                        zzgz.zzf(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_10 /* 41 */:
                        zzgz.zzk(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_11 /* 42 */:
                        zzgz.zzn(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_12 /* 43 */:
                        zzgz.zzi(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_13 /* 44 */:
                        zzgz.zzm(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_14 /* 45 */:
                        zzgz.zzl(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_15 /* 46 */:
                        zzgz.zzg(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case MotionEventCompat.AXIS_GENERIC_16 /* 47 */:
                        zzgz.zzj(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case 48:
                        zzgz.zze(this.zzakj[i2], (List) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, true);
                        break;
                    case 49:
                        zzgz.zzb(this.zzakj[i2], (List<?>) zzhv.zzp(t, iZzca2 & 1048575), zzimVar, zzbx(i2));
                        break;
                    case 50:
                        zza(zzimVar, i3, zzhv.zzp(t, iZzca2 & 1048575), i2);
                        break;
                    case 51:
                        if (zza(t, i3, i2)) {
                            zzimVar.zza(i3, zzf(t, iZzca2 & 1048575));
                        }
                        break;
                    case 52:
                        if (zza(t, i3, i2)) {
                            zzimVar.zza(i3, zzg(t, iZzca2 & 1048575));
                        }
                        break;
                    case 53:
                        if (zza(t, i3, i2)) {
                            zzimVar.zzi(i3, zzi(t, iZzca2 & 1048575));
                        }
                        break;
                    case 54:
                        if (zza(t, i3, i2)) {
                            zzimVar.zza(i3, zzi(t, iZzca2 & 1048575));
                        }
                        break;
                    case 55:
                        if (zza(t, i3, i2)) {
                            zzimVar.zzc(i3, zzh(t, iZzca2 & 1048575));
                        }
                        break;
                    case 56:
                        if (zza(t, i3, i2)) {
                            zzimVar.zzc(i3, zzi(t, iZzca2 & 1048575));
                        }
                        break;
                    case 57:
                        if (zza(t, i3, i2)) {
                            zzimVar.zzf(i3, zzh(t, iZzca2 & 1048575));
                        }
                        break;
                    case 58:
                        if (zza(t, i3, i2)) {
                            zzimVar.zzb(i3, zzj(t, iZzca2 & 1048575));
                        }
                        break;
                    case 59:
                        if (zza(t, i3, i2)) {
                            zza(i3, zzhv.zzp(t, iZzca2 & 1048575), zzimVar);
                        }
                        break;
                    case 60:
                        if (zza(t, i3, i2)) {
                            zzimVar.zza(i3, zzhv.zzp(t, iZzca2 & 1048575), zzbx(i2));
                        }
                        break;
                    case 61:
                        if (zza(t, i3, i2)) {
                            zzimVar.zza(i3, (zzdp) zzhv.zzp(t, iZzca2 & 1048575));
                        }
                        break;
                    case 62:
                        if (zza(t, i3, i2)) {
                            zzimVar.zzd(i3, zzh(t, iZzca2 & 1048575));
                        }
                        break;
                    case HtmlCompat.FROM_HTML_MODE_COMPACT /* 63 */:
                        if (zza(t, i3, i2)) {
                            zzimVar.zzn(i3, zzh(t, iZzca2 & 1048575));
                        }
                        break;
                    case 64:
                        if (zza(t, i3, i2)) {
                            zzimVar.zzm(i3, zzh(t, iZzca2 & 1048575));
                        }
                        break;
                    case 65:
                        if (zza(t, i3, i2)) {
                            zzimVar.zzj(i3, zzi(t, iZzca2 & 1048575));
                        }
                        break;
                    case 66:
                        if (zza(t, i3, i2)) {
                            zzimVar.zze(i3, zzh(t, iZzca2 & 1048575));
                        }
                        break;
                    case 67:
                        if (zza(t, i3, i2)) {
                            zzimVar.zzb(i3, zzi(t, iZzca2 & 1048575));
                        }
                        break;
                    case 68:
                        if (zza(t, i3, i2)) {
                            zzimVar.zzb(i3, zzhv.zzp(t, iZzca2 & 1048575), zzbx(i2));
                        }
                        break;
                }
            }
            while (entry3 != null) {
                this.zzaky.zza(zzimVar, entry3);
                entry3 = it.hasNext() ? (Map.Entry) it.next() : null;
            }
            zza(this.zzakx, t, zzimVar);
            return;
        }
        zzb(t, zzimVar);
    }

    /* JADX WARN: Code duplicated, block: B:7:0x0023  */
    private final void zzb(T t, zzim zzimVar) throws IOException {
        Iterator it;
        Map.Entry<?, ?> entry;
        int i;
        int i2;
        if (this.zzako) {
            zzeo<T> zzeoVarZzh = this.zzaky.zzh(t);
            if (zzeoVarZzh.zzaex.isEmpty()) {
                it = null;
                entry = null;
            } else {
                it = zzeoVarZzh.iterator();
                entry = (Map.Entry) it.next();
            }
        } else {
            it = null;
            entry = null;
        }
        int i3 = -1;
        int length = this.zzakj.length;
        Unsafe unsafe = zzaki;
        Map.Entry<?, ?> entry2 = entry;
        int i4 = 0;
        int i5 = 0;
        while (i4 < length) {
            int iZzca = zzca(i4);
            int i6 = this.zzakj[i4];
            int i7 = (267386880 & iZzca) >>> 20;
            if (this.zzakq || i7 > 17) {
                i4 = i4;
                i = 0;
            } else {
                int i8 = this.zzakj[i4 + 2];
                int i9 = i8 & 1048575;
                if (i9 != i3) {
                    i5 = unsafe.getInt(t, i9);
                    i3 = i9;
                }
                i = 1 << (i8 >>> 20);
            }
            while (entry2 != null && this.zzaky.zza(entry2) <= i6) {
                this.zzaky.zza(zzimVar, entry2);
                entry2 = it.hasNext() ? (Map.Entry) it.next() : null;
            }
            long j = iZzca & 1048575;
            switch (i7) {
                case 0:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zza(i6, zzhv.zzo(t, j));
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 1:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zza(i6, zzhv.zzn(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 2:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zzi(i6, unsafe.getLong(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 3:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zza(i6, unsafe.getLong(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 4:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zzc(i6, unsafe.getInt(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 5:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zzc(i6, unsafe.getLong(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 6:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zzf(i6, unsafe.getInt(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 7:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zzb(i6, zzhv.zzm(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 8:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zza(i6, unsafe.getObject(t, j), zzimVar);
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 9:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zza(i6, unsafe.getObject(t, j), zzbx(i2));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 10:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zza(i6, (zzdp) unsafe.getObject(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 11:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zzd(i6, unsafe.getInt(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 12:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zzn(i6, unsafe.getInt(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 13:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zzm(i6, unsafe.getInt(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 14:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zzj(i6, unsafe.getLong(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 15:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zze(i6, unsafe.getInt(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 16:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zzb(i6, unsafe.getLong(t, j));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 17:
                    i2 = i4;
                    if ((i & i5) != 0) {
                        zzimVar.zzb(i6, unsafe.getObject(t, j), zzbx(i2));
                    } else {
                        continue;
                    }
                    i4 = i2 + 3;
                    break;
                case 18:
                    i2 = i4;
                    zzgz.zza(this.zzakj[i2], (List<Double>) unsafe.getObject(t, j), zzimVar, false);
                    continue;
                    i4 = i2 + 3;
                    break;
                case 19:
                    i2 = i4;
                    zzgz.zzb(this.zzakj[i2], (List<Float>) unsafe.getObject(t, j), zzimVar, false);
                    continue;
                    i4 = i2 + 3;
                    break;
                case 20:
                    i2 = i4;
                    zzgz.zzc(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    continue;
                    i4 = i2 + 3;
                    break;
                case 21:
                    i2 = i4;
                    zzgz.zzd(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    continue;
                    i4 = i2 + 3;
                    break;
                case 22:
                    i2 = i4;
                    zzgz.zzh(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    continue;
                    i4 = i2 + 3;
                    break;
                case 23:
                    i2 = i4;
                    zzgz.zzf(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    continue;
                    i4 = i2 + 3;
                    break;
                case 24:
                    i2 = i4;
                    zzgz.zzk(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    continue;
                    i4 = i2 + 3;
                    break;
                case 25:
                    i2 = i4;
                    zzgz.zzn(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    continue;
                    i4 = i2 + 3;
                    break;
                case 26:
                    i2 = i4;
                    zzgz.zza(this.zzakj[i2], (List<String>) unsafe.getObject(t, j), zzimVar);
                    break;
                case 27:
                    i2 = i4;
                    zzgz.zza(this.zzakj[i2], (List<?>) unsafe.getObject(t, j), zzimVar, zzbx(i2));
                    break;
                case 28:
                    i2 = i4;
                    zzgz.zzb(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar);
                    break;
                case 29:
                    i2 = i4;
                    zzgz.zzi(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    break;
                case 30:
                    i2 = i4;
                    zzgz.zzm(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    break;
                case FTPCommand.HELP /* 31 */:
                    i2 = i4;
                    zzgz.zzl(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    break;
                case 32:
                    i2 = i4;
                    zzgz.zzg(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    break;
                case 33:
                    i2 = i4;
                    zzgz.zzj(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    break;
                case 34:
                    i2 = i4;
                    zzgz.zze(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, false);
                    break;
                case 35:
                    i2 = i4;
                    zzgz.zza(this.zzakj[i2], (List<Double>) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case 36:
                    i2 = i4;
                    zzgz.zzb(this.zzakj[i2], (List<Float>) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case 37:
                    i2 = i4;
                    zzgz.zzc(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case 38:
                    i2 = i4;
                    zzgz.zzd(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case 39:
                    i2 = i4;
                    zzgz.zzh(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case MotionEventCompat.AXIS_GENERIC_9 /* 40 */:
                    i2 = i4;
                    zzgz.zzf(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case MotionEventCompat.AXIS_GENERIC_10 /* 41 */:
                    i2 = i4;
                    zzgz.zzk(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case MotionEventCompat.AXIS_GENERIC_11 /* 42 */:
                    i2 = i4;
                    zzgz.zzn(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case MotionEventCompat.AXIS_GENERIC_12 /* 43 */:
                    i2 = i4;
                    zzgz.zzi(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case MotionEventCompat.AXIS_GENERIC_13 /* 44 */:
                    i2 = i4;
                    zzgz.zzm(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case MotionEventCompat.AXIS_GENERIC_14 /* 45 */:
                    i2 = i4;
                    zzgz.zzl(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case MotionEventCompat.AXIS_GENERIC_15 /* 46 */:
                    i2 = i4;
                    zzgz.zzg(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case MotionEventCompat.AXIS_GENERIC_16 /* 47 */:
                    i2 = i4;
                    zzgz.zzj(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case 48:
                    i2 = i4;
                    zzgz.zze(this.zzakj[i2], (List) unsafe.getObject(t, j), zzimVar, true);
                    break;
                case 49:
                    i2 = i4;
                    zzgz.zzb(this.zzakj[i2], (List<?>) unsafe.getObject(t, j), zzimVar, zzbx(i2));
                    break;
                case 50:
                    i2 = i4;
                    zza(zzimVar, i6, unsafe.getObject(t, j), i2);
                    break;
                case 51:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zza(i6, zzf(t, j));
                    }
                    break;
                case 52:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zza(i6, zzg(t, j));
                    }
                    break;
                case 53:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zzi(i6, zzi(t, j));
                    }
                    break;
                case 54:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zza(i6, zzi(t, j));
                    }
                    break;
                case 55:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zzc(i6, zzh(t, j));
                    }
                    break;
                case 56:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zzc(i6, zzi(t, j));
                    }
                    break;
                case 57:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zzf(i6, zzh(t, j));
                    }
                    break;
                case 58:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zzb(i6, zzj(t, j));
                    }
                    break;
                case 59:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zza(i6, unsafe.getObject(t, j), zzimVar);
                    }
                    break;
                case 60:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zza(i6, unsafe.getObject(t, j), zzbx(i2));
                    }
                    break;
                case 61:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zza(i6, (zzdp) unsafe.getObject(t, j));
                    }
                    break;
                case 62:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zzd(i6, zzh(t, j));
                    }
                    break;
                case HtmlCompat.FROM_HTML_MODE_COMPACT /* 63 */:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zzn(i6, zzh(t, j));
                    }
                    break;
                case 64:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zzm(i6, zzh(t, j));
                    }
                    break;
                case 65:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zzj(i6, zzi(t, j));
                    }
                    break;
                case 66:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zze(i6, zzh(t, j));
                    }
                    break;
                case 67:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zzb(i6, zzi(t, j));
                    }
                    break;
                case 68:
                    i2 = i4;
                    if (zza(t, i6, i2)) {
                        zzimVar.zzb(i6, unsafe.getObject(t, j), zzbx(i2));
                    }
                    break;
                default:
                    i2 = i4;
                    break;
            }
            i4 = i2 + 3;
        }
        while (entry2 != null) {
            this.zzaky.zza(zzimVar, entry2);
            entry2 = it.hasNext() ? (Map.Entry) it.next() : null;
        }
        zza(this.zzakx, t, zzimVar);
    }

    private final <K, V> void zza(zzim zzimVar, int i, Object obj, int i2) throws IOException {
        if (obj != null) {
            zzimVar.zza(i, this.zzakz.zzr(zzby(i2)), this.zzakz.zzn(obj));
        }
    }

    private static <UT, UB> void zza(zzhp<UT, UB> zzhpVar, T t, zzim zzimVar) throws IOException {
        zzhpVar.zza(zzhpVar.zzx(t), zzimVar);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference incomplete: some casts might be missing */
    @Override // com.google.android.gms.internal.measurement.zzgx
    public final void zza(T t, zzgy zzgyVar, zzel zzelVar) throws IOException {
        Object objZza;
        if (zzelVar == null) {
            throw new NullPointerException();
        }
        zzhp<?, ?> zzhpVar = this.zzakx;
        zzen<?> zzenVar = this.zzaky;
        zzeo zzeoVarZzi = null;
        Object objZza2 = null;
        while (true) {
            try {
                int iZzsy = zzgyVar.zzsy();
                int iZzcd = zzcd(iZzsy);
                if (iZzcd < 0) {
                    if (iZzsy == Integer.MAX_VALUE) {
                        for (int i = this.zzakt; i < this.zzaku; i++) {
                            objZza2 = zza((Object) t, this.zzaks[i], objZza2, (zzhp<UT, Object>) zzhpVar);
                        }
                        if (objZza2 != null) {
                            zzhpVar.zzf(t, (Object) objZza2);
                            return;
                        }
                        return;
                    }
                    Object objZza3 = !this.zzako ? null : zzenVar.zza(zzelVar, this.zzakn, iZzsy);
                    if (objZza3 != null) {
                        if (zzeoVarZzi == null) {
                            zzeoVarZzi = zzenVar.zzi(t);
                        }
                        zzeo zzeoVar = zzeoVarZzi;
                        objZza2 = zzenVar.zza(zzgyVar, objZza3, zzelVar, zzeoVar, objZza2, zzhpVar);
                        zzeoVarZzi = zzeoVar;
                    } else {
                        zzhpVar.zza(zzgyVar);
                        if (objZza2 == null) {
                            objZza2 = zzhpVar.zzy(t);
                        }
                        if (!zzhpVar.zza((Object) objZza2, zzgyVar)) {
                            for (int i2 = this.zzakt; i2 < this.zzaku; i2++) {
                                objZza2 = zza((Object) t, this.zzaks[i2], objZza2, (zzhp<UT, Object>) zzhpVar);
                            }
                            if (objZza2 != null) {
                                zzhpVar.zzf(t, (Object) objZza2);
                                return;
                            }
                            return;
                        }
                    }
                } else {
                    int iZzca = zzca(iZzcd);
                    switch ((267386880 & iZzca) >>> 20) {
                        case 0:
                            zzhv.zza(t, iZzca & 1048575, zzgyVar.readDouble());
                            zzb(t, iZzcd);
                            break;
                        case 1:
                            zzhv.zza((Object) t, iZzca & 1048575, zzgyVar.readFloat());
                            zzb(t, iZzcd);
                            break;
                        case 2:
                            zzhv.zza((Object) t, iZzca & 1048575, zzgyVar.zzsi());
                            zzb(t, iZzcd);
                            break;
                        case 3:
                            zzhv.zza((Object) t, iZzca & 1048575, zzgyVar.zzsh());
                            zzb(t, iZzcd);
                            break;
                        case 4:
                            zzhv.zzb(t, iZzca & 1048575, zzgyVar.zzsj());
                            zzb(t, iZzcd);
                            break;
                        case 5:
                            zzhv.zza((Object) t, iZzca & 1048575, zzgyVar.zzsk());
                            zzb(t, iZzcd);
                            break;
                        case 6:
                            zzhv.zzb(t, iZzca & 1048575, zzgyVar.zzsl());
                            zzb(t, iZzcd);
                            break;
                        case 7:
                            zzhv.zza(t, iZzca & 1048575, zzgyVar.zzsm());
                            zzb(t, iZzcd);
                            break;
                        case 8:
                            zza(t, iZzca, zzgyVar);
                            zzb(t, iZzcd);
                            break;
                        case 9:
                            if (zza(t, iZzcd)) {
                                long j = iZzca & 1048575;
                                zzhv.zza(t, j, zzez.zza(zzhv.zzp(t, j), zzgyVar.zza(zzbx(iZzcd), zzelVar)));
                            } else {
                                zzhv.zza(t, iZzca & 1048575, zzgyVar.zza(zzbx(iZzcd), zzelVar));
                                zzb(t, iZzcd);
                            }
                            break;
                        case 10:
                            zzhv.zza(t, iZzca & 1048575, zzgyVar.zzso());
                            zzb(t, iZzcd);
                            break;
                        case 11:
                            zzhv.zzb(t, iZzca & 1048575, zzgyVar.zzsp());
                            zzb(t, iZzcd);
                            break;
                        case 12:
                            int iZzsq = zzgyVar.zzsq();
                            zzfe zzfeVarZzbz = zzbz(iZzcd);
                            if (zzfeVarZzbz == null || zzfeVarZzbz.zzg(iZzsq)) {
                                zzhv.zzb(t, iZzca & 1048575, iZzsq);
                                zzb(t, iZzcd);
                            } else {
                                objZza = zzgz.zza(iZzsy, iZzsq, objZza2, (zzhp<UT, Object>) zzhpVar);
                                objZza2 = objZza;
                            }
                            break;
                        case 13:
                            zzhv.zzb(t, iZzca & 1048575, zzgyVar.zzsr());
                            zzb(t, iZzcd);
                            break;
                        case 14:
                            zzhv.zza((Object) t, iZzca & 1048575, zzgyVar.zzss());
                            zzb(t, iZzcd);
                            break;
                        case 15:
                            zzhv.zzb(t, iZzca & 1048575, zzgyVar.zzst());
                            zzb(t, iZzcd);
                            break;
                        case 16:
                            zzhv.zza((Object) t, iZzca & 1048575, zzgyVar.zzsu());
                            zzb(t, iZzcd);
                            break;
                        case 17:
                            if (zza(t, iZzcd)) {
                                long j2 = iZzca & 1048575;
                                zzhv.zza(t, j2, zzez.zza(zzhv.zzp(t, j2), zzgyVar.zzb(zzbx(iZzcd), zzelVar)));
                            } else {
                                zzhv.zza(t, iZzca & 1048575, zzgyVar.zzb(zzbx(iZzcd), zzelVar));
                                zzb(t, iZzcd);
                            }
                            break;
                        case 18:
                            zzgyVar.zze(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 19:
                            zzgyVar.zzf(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 20:
                            zzgyVar.zzh(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 21:
                            zzgyVar.zzg(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 22:
                            zzgyVar.zzi(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 23:
                            zzgyVar.zzj(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 24:
                            zzgyVar.zzk(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 25:
                            zzgyVar.zzl(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 26:
                            if (zzcc(iZzca)) {
                                zzgyVar.zzm(this.zzakw.zza(t, iZzca & 1048575));
                            } else {
                                zzgyVar.readStringList(this.zzakw.zza(t, iZzca & 1048575));
                            }
                            break;
                        case 27:
                            zzgyVar.zza(this.zzakw.zza(t, iZzca & 1048575), zzbx(iZzcd), zzelVar);
                            break;
                        case 28:
                            zzgyVar.zzn(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 29:
                            zzgyVar.zzo(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 30:
                            List<Integer> listZza = this.zzakw.zza(t, iZzca & 1048575);
                            zzgyVar.zzp(listZza);
                            objZza = zzgz.zza(iZzsy, listZza, zzbz(iZzcd), objZza2, zzhpVar);
                            objZza2 = objZza;
                            break;
                        case FTPCommand.HELP /* 31 */:
                            zzgyVar.zzq(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 32:
                            zzgyVar.zzr(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 33:
                            zzgyVar.zzs(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 34:
                            zzgyVar.zzt(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 35:
                            zzgyVar.zze(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 36:
                            zzgyVar.zzf(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 37:
                            zzgyVar.zzh(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 38:
                            zzgyVar.zzg(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 39:
                            zzgyVar.zzi(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case MotionEventCompat.AXIS_GENERIC_9 /* 40 */:
                            zzgyVar.zzj(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case MotionEventCompat.AXIS_GENERIC_10 /* 41 */:
                            zzgyVar.zzk(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case MotionEventCompat.AXIS_GENERIC_11 /* 42 */:
                            zzgyVar.zzl(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case MotionEventCompat.AXIS_GENERIC_12 /* 43 */:
                            zzgyVar.zzo(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case MotionEventCompat.AXIS_GENERIC_13 /* 44 */:
                            List<Integer> listZza2 = this.zzakw.zza(t, iZzca & 1048575);
                            zzgyVar.zzp(listZza2);
                            objZza = zzgz.zza(iZzsy, listZza2, zzbz(iZzcd), objZza2, zzhpVar);
                            objZza2 = objZza;
                            break;
                        case MotionEventCompat.AXIS_GENERIC_14 /* 45 */:
                            zzgyVar.zzq(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case MotionEventCompat.AXIS_GENERIC_15 /* 46 */:
                            zzgyVar.zzr(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case MotionEventCompat.AXIS_GENERIC_16 /* 47 */:
                            zzgyVar.zzs(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 48:
                            zzgyVar.zzt(this.zzakw.zza(t, iZzca & 1048575));
                            break;
                        case 49:
                            zzgyVar.zzb(this.zzakw.zza(t, iZzca & 1048575), zzbx(iZzcd), zzelVar);
                            break;
                        case 50:
                            Object objZzby = zzby(iZzcd);
                            long jZzca = zzca(iZzcd) & 1048575;
                            Object objZzp = zzhv.zzp(t, jZzca);
                            if (objZzp == null) {
                                objZzp = this.zzakz.zzq(objZzby);
                                zzhv.zza(t, jZzca, objZzp);
                            } else if (this.zzakz.zzo(objZzp)) {
                                Object objZzq = this.zzakz.zzq(objZzby);
                                this.zzakz.zzb(objZzq, objZzp);
                                zzhv.zza(t, jZzca, objZzq);
                                objZzp = objZzq;
                            }
                            zzgyVar.zza(this.zzakz.zzm(objZzp), this.zzakz.zzr(objZzby), zzelVar);
                            break;
                        case 51:
                            zzhv.zza(t, iZzca & 1048575, Double.valueOf(zzgyVar.readDouble()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 52:
                            zzhv.zza(t, iZzca & 1048575, Float.valueOf(zzgyVar.readFloat()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 53:
                            zzhv.zza(t, iZzca & 1048575, Long.valueOf(zzgyVar.zzsi()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 54:
                            zzhv.zza(t, iZzca & 1048575, Long.valueOf(zzgyVar.zzsh()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 55:
                            zzhv.zza(t, iZzca & 1048575, Integer.valueOf(zzgyVar.zzsj()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 56:
                            zzhv.zza(t, iZzca & 1048575, Long.valueOf(zzgyVar.zzsk()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 57:
                            zzhv.zza(t, iZzca & 1048575, Integer.valueOf(zzgyVar.zzsl()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 58:
                            zzhv.zza(t, iZzca & 1048575, Boolean.valueOf(zzgyVar.zzsm()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 59:
                            zza(t, iZzca, zzgyVar);
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 60:
                            if (zza(t, iZzsy, iZzcd)) {
                                long j3 = iZzca & 1048575;
                                zzhv.zza(t, j3, zzez.zza(zzhv.zzp(t, j3), zzgyVar.zza(zzbx(iZzcd), zzelVar)));
                            } else {
                                zzhv.zza(t, iZzca & 1048575, zzgyVar.zza(zzbx(iZzcd), zzelVar));
                                zzb(t, iZzcd);
                            }
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 61:
                            zzhv.zza(t, iZzca & 1048575, zzgyVar.zzso());
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 62:
                            zzhv.zza(t, iZzca & 1048575, Integer.valueOf(zzgyVar.zzsp()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case HtmlCompat.FROM_HTML_MODE_COMPACT /* 63 */:
                            int iZzsq2 = zzgyVar.zzsq();
                            zzfe zzfeVarZzbz2 = zzbz(iZzcd);
                            if (zzfeVarZzbz2 == null || zzfeVarZzbz2.zzg(iZzsq2)) {
                                zzhv.zza(t, iZzca & 1048575, Integer.valueOf(iZzsq2));
                                zzb(t, iZzsy, iZzcd);
                            } else {
                                objZza = zzgz.zza(iZzsy, iZzsq2, objZza2, (zzhp<UT, Object>) zzhpVar);
                                objZza2 = objZza;
                            }
                            break;
                        case 64:
                            zzhv.zza(t, iZzca & 1048575, Integer.valueOf(zzgyVar.zzsr()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 65:
                            zzhv.zza(t, iZzca & 1048575, Long.valueOf(zzgyVar.zzss()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 66:
                            zzhv.zza(t, iZzca & 1048575, Integer.valueOf(zzgyVar.zzst()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 67:
                            zzhv.zza(t, iZzca & 1048575, Long.valueOf(zzgyVar.zzsu()));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        case 68:
                            zzhv.zza(t, iZzca & 1048575, zzgyVar.zzb(zzbx(iZzcd), zzelVar));
                            zzb(t, iZzsy, iZzcd);
                            break;
                        default:
                            if (objZza2 == null) {
                                try {
                                    objZza2 = zzhpVar.zzwp();
                                } catch (zzfh unused) {
                                    zzhpVar.zza(zzgyVar);
                                    if (objZza2 == null) {
                                        objZza2 = zzhpVar.zzy(t);
                                    }
                                    if (!zzhpVar.zza((Object) objZza2, zzgyVar)) {
                                        for (int i3 = this.zzakt; i3 < this.zzaku; i3++) {
                                            objZza2 = zza((Object) t, this.zzaks[i3], objZza2, (zzhp<UT, Object>) zzhpVar);
                                        }
                                        if (objZza2 != null) {
                                            zzhpVar.zzf(t, (Object) objZza2);
                                            return;
                                        }
                                        return;
                                    }
                                }
                                break;
                            }
                            if (!zzhpVar.zza((Object) objZza2, zzgyVar)) {
                                for (int i4 = this.zzakt; i4 < this.zzaku; i4++) {
                                    objZza2 = zza((Object) t, this.zzaks[i4], objZza2, (zzhp<UT, Object>) zzhpVar);
                                }
                                if (objZza2 != null) {
                                    zzhpVar.zzf(t, (Object) objZza2);
                                    return;
                                }
                                return;
                            }
                            break;
                            break;
                    }
                }
            } catch (Throwable th) {
                for (int i5 = this.zzakt; i5 < this.zzaku; i5++) {
                    objZza2 = zza((Object) t, this.zzaks[i5], objZza2, (zzhp<UT, Object>) zzhpVar);
                }
                if (objZza2 != null) {
                    zzhpVar.zzf(t, (Object) objZza2);
                }
                throw th;
            }
        }
    }

    private static zzhs zzu(Object obj) {
        zzey zzeyVar = (zzey) obj;
        zzhs zzhsVar = zzeyVar.zzahz;
        if (zzhsVar != zzhs.zzwq()) {
            return zzhsVar;
        }
        zzhs zzhsVarZzwr = zzhs.zzwr();
        zzeyVar.zzahz = zzhsVarZzwr;
        return zzhsVarZzwr;
    }

    private static int zza(byte[] bArr, int i, int i2, zzig zzigVar, Class<?> cls, zzdk zzdkVar) throws IOException {
        switch (zzgl.zzaee[zzigVar.ordinal()]) {
            case 1:
                int iZzb = zzdl.zzb(bArr, i, zzdkVar);
                zzdkVar.zzadc = Boolean.valueOf(zzdkVar.zzadb != 0);
                return iZzb;
            case 2:
                return zzdl.zze(bArr, i, zzdkVar);
            case 3:
                zzdkVar.zzadc = Double.valueOf(zzdl.zzc(bArr, i));
                return i + 8;
            case 4:
            case 5:
                zzdkVar.zzadc = Integer.valueOf(zzdl.zza(bArr, i));
                return i + 4;
            case 6:
            case 7:
                zzdkVar.zzadc = Long.valueOf(zzdl.zzb(bArr, i));
                return i + 8;
            case 8:
                zzdkVar.zzadc = Float.valueOf(zzdl.zzd(bArr, i));
                return i + 4;
            case 9:
            case 10:
            case 11:
                int iZza = zzdl.zza(bArr, i, zzdkVar);
                zzdkVar.zzadc = Integer.valueOf(zzdkVar.zzada);
                return iZza;
            case 12:
            case 13:
                int iZzb2 = zzdl.zzb(bArr, i, zzdkVar);
                zzdkVar.zzadc = Long.valueOf(zzdkVar.zzadb);
                return iZzb2;
            case 14:
                return zzdl.zza(zzgt.zzvy().zzf(cls), bArr, i, i2, zzdkVar);
            case 15:
                int iZza2 = zzdl.zza(bArr, i, zzdkVar);
                zzdkVar.zzadc = Integer.valueOf(zzeb.zzaz(zzdkVar.zzada));
                return iZza2;
            case 16:
                int iZzb3 = zzdl.zzb(bArr, i, zzdkVar);
                zzdkVar.zzadc = Long.valueOf(zzeb.zzbm(zzdkVar.zzadb));
                return iZzb3;
            case 17:
                return zzdl.zzd(bArr, i, zzdkVar);
            default:
                throw new RuntimeException("unsupported field type.");
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Multi-variable type inference failed */
    private final int zza(T t, byte[] bArr, int i, int i2, int i3, int i4, int i5, int i6, long j, int i7, long j2, zzdk zzdkVar) throws IOException {
        int iZza;
        int iZzb = i;
        zzff zzffVarZzap = (zzff) zzaki.getObject(t, j2);
        if (!zzffVarZzap.zzrx()) {
            int size = zzffVarZzap.size();
            zzffVarZzap = zzffVarZzap.zzap(size == 0 ? 10 : size << 1);
            zzaki.putObject(t, j2, zzffVarZzap);
        }
        switch (i7) {
            case 18:
            case 35:
                if (i5 == 2) {
                    zzeh zzehVar = (zzeh) zzffVarZzap;
                    int iZza2 = zzdl.zza(bArr, iZzb, zzdkVar);
                    int i8 = zzdkVar.zzada + iZza2;
                    while (iZza2 < i8) {
                        zzehVar.zzf(zzdl.zzc(bArr, iZza2));
                        iZza2 += 8;
                    }
                    if (iZza2 == i8) {
                        return iZza2;
                    }
                    throw zzfi.zzut();
                }
                if (i5 == 1) {
                    zzeh zzehVar2 = (zzeh) zzffVarZzap;
                    zzehVar2.zzf(zzdl.zzc(bArr, i));
                    int i9 = iZzb + 8;
                    while (i9 < i2) {
                        int iZza3 = zzdl.zza(bArr, i9, zzdkVar);
                        if (i3 != zzdkVar.zzada) {
                            return i9;
                        }
                        zzehVar2.zzf(zzdl.zzc(bArr, iZza3));
                        i9 = iZza3 + 8;
                    }
                    return i9;
                }
                return iZzb;
            case 19:
            case 36:
                if (i5 == 2) {
                    zzeu zzeuVar = (zzeu) zzffVarZzap;
                    int iZza4 = zzdl.zza(bArr, iZzb, zzdkVar);
                    int i10 = zzdkVar.zzada + iZza4;
                    while (iZza4 < i10) {
                        zzeuVar.zzc(zzdl.zzd(bArr, iZza4));
                        iZza4 += 4;
                    }
                    if (iZza4 == i10) {
                        return iZza4;
                    }
                    throw zzfi.zzut();
                }
                if (i5 == 5) {
                    zzeu zzeuVar2 = (zzeu) zzffVarZzap;
                    zzeuVar2.zzc(zzdl.zzd(bArr, i));
                    int i11 = iZzb + 4;
                    while (i11 < i2) {
                        int iZza5 = zzdl.zza(bArr, i11, zzdkVar);
                        if (i3 != zzdkVar.zzada) {
                            return i11;
                        }
                        zzeuVar2.zzc(zzdl.zzd(bArr, iZza5));
                        i11 = iZza5 + 4;
                    }
                    return i11;
                }
                return iZzb;
            case 20:
            case 21:
            case 37:
            case 38:
                if (i5 == 2) {
                    zzfw zzfwVar = (zzfw) zzffVarZzap;
                    int iZza6 = zzdl.zza(bArr, iZzb, zzdkVar);
                    int i12 = zzdkVar.zzada + iZza6;
                    while (iZza6 < i12) {
                        iZza6 = zzdl.zzb(bArr, iZza6, zzdkVar);
                        zzfwVar.zzby(zzdkVar.zzadb);
                    }
                    if (iZza6 == i12) {
                        return iZza6;
                    }
                    throw zzfi.zzut();
                }
                if (i5 == 0) {
                    zzfw zzfwVar2 = (zzfw) zzffVarZzap;
                    int iZzb2 = zzdl.zzb(bArr, iZzb, zzdkVar);
                    zzfwVar2.zzby(zzdkVar.zzadb);
                    while (iZzb2 < i2) {
                        int iZza7 = zzdl.zza(bArr, iZzb2, zzdkVar);
                        if (i3 != zzdkVar.zzada) {
                            return iZzb2;
                        }
                        iZzb2 = zzdl.zzb(bArr, iZza7, zzdkVar);
                        zzfwVar2.zzby(zzdkVar.zzadb);
                    }
                    return iZzb2;
                }
                return iZzb;
            case 22:
            case 29:
            case 39:
            case MotionEventCompat.AXIS_GENERIC_12 /* 43 */:
                if (i5 == 2) {
                    return zzdl.zza(bArr, iZzb, (zzff<?>) zzffVarZzap, zzdkVar);
                }
                if (i5 == 0) {
                    return zzdl.zza(i3, bArr, i, i2, (zzff<?>) zzffVarZzap, zzdkVar);
                }
                return iZzb;
            case 23:
            case 32:
            case MotionEventCompat.AXIS_GENERIC_9 /* 40 */:
            case MotionEventCompat.AXIS_GENERIC_15 /* 46 */:
                if (i5 == 2) {
                    zzfw zzfwVar3 = (zzfw) zzffVarZzap;
                    int iZza8 = zzdl.zza(bArr, iZzb, zzdkVar);
                    int i13 = zzdkVar.zzada + iZza8;
                    while (iZza8 < i13) {
                        zzfwVar3.zzby(zzdl.zzb(bArr, iZza8));
                        iZza8 += 8;
                    }
                    if (iZza8 == i13) {
                        return iZza8;
                    }
                    throw zzfi.zzut();
                }
                if (i5 == 1) {
                    zzfw zzfwVar4 = (zzfw) zzffVarZzap;
                    zzfwVar4.zzby(zzdl.zzb(bArr, i));
                    int i14 = iZzb + 8;
                    while (i14 < i2) {
                        int iZza9 = zzdl.zza(bArr, i14, zzdkVar);
                        if (i3 != zzdkVar.zzada) {
                            return i14;
                        }
                        zzfwVar4.zzby(zzdl.zzb(bArr, iZza9));
                        i14 = iZza9 + 8;
                    }
                    return i14;
                }
                return iZzb;
            case 24:
            case FTPCommand.HELP /* 31 */:
            case MotionEventCompat.AXIS_GENERIC_10 /* 41 */:
            case MotionEventCompat.AXIS_GENERIC_14 /* 45 */:
                if (i5 == 2) {
                    zzfa zzfaVar = (zzfa) zzffVarZzap;
                    int iZza10 = zzdl.zza(bArr, iZzb, zzdkVar);
                    int i15 = zzdkVar.zzada + iZza10;
                    while (iZza10 < i15) {
                        zzfaVar.zzbu(zzdl.zza(bArr, iZza10));
                        iZza10 += 4;
                    }
                    if (iZza10 == i15) {
                        return iZza10;
                    }
                    throw zzfi.zzut();
                }
                if (i5 == 5) {
                    zzfa zzfaVar2 = (zzfa) zzffVarZzap;
                    zzfaVar2.zzbu(zzdl.zza(bArr, i));
                    int i16 = iZzb + 4;
                    while (i16 < i2) {
                        int iZza11 = zzdl.zza(bArr, i16, zzdkVar);
                        if (i3 != zzdkVar.zzada) {
                            return i16;
                        }
                        zzfaVar2.zzbu(zzdl.zza(bArr, iZza11));
                        i16 = iZza11 + 4;
                    }
                    return i16;
                }
                return iZzb;
            case 25:
            case MotionEventCompat.AXIS_GENERIC_11 /* 42 */:
                if (i5 == 2) {
                    zzdn zzdnVar = (zzdn) zzffVarZzap;
                    iZza = zzdl.zza(bArr, iZzb, zzdkVar);
                    int i17 = zzdkVar.zzada + iZza;
                    while (iZza < i17) {
                        iZza = zzdl.zzb(bArr, iZza, zzdkVar);
                        zzdnVar.addBoolean(zzdkVar.zzadb != 0);
                    }
                    if (iZza != i17) {
                        throw zzfi.zzut();
                    }
                    return iZza;
                }
                if (i5 == 0) {
                    zzdn zzdnVar2 = (zzdn) zzffVarZzap;
                    iZzb = zzdl.zzb(bArr, iZzb, zzdkVar);
                    zzdnVar2.addBoolean(zzdkVar.zzadb != 0);
                    while (iZzb < i2) {
                        int iZza12 = zzdl.zza(bArr, iZzb, zzdkVar);
                        if (i3 == zzdkVar.zzada) {
                            iZzb = zzdl.zzb(bArr, iZza12, zzdkVar);
                            zzdnVar2.addBoolean(zzdkVar.zzadb != 0);
                        }
                    }
                }
                return iZzb;
            case 26:
                if (i5 == 2) {
                    if ((j & 536870912) == 0) {
                        int iZza13 = zzdl.zza(bArr, iZzb, zzdkVar);
                        int i18 = zzdkVar.zzada;
                        if (i18 < 0) {
                            throw zzfi.zzuu();
                        }
                        if (i18 == 0) {
                            zzffVarZzap.add("");
                        } else {
                            zzffVarZzap.add(new String(bArr, iZza13, i18, zzez.UTF_8));
                            iZza13 += i18;
                        }
                        while (iZza13 < i2) {
                            int iZza14 = zzdl.zza(bArr, iZza13, zzdkVar);
                            if (i3 != zzdkVar.zzada) {
                                return iZza13;
                            }
                            iZza13 = zzdl.zza(bArr, iZza14, zzdkVar);
                            int i19 = zzdkVar.zzada;
                            if (i19 < 0) {
                                throw zzfi.zzuu();
                            }
                            if (i19 == 0) {
                                zzffVarZzap.add("");
                            } else {
                                zzffVarZzap.add(new String(bArr, iZza13, i19, zzez.UTF_8));
                                iZza13 += i19;
                            }
                        }
                        return iZza13;
                    }
                    int iZza15 = zzdl.zza(bArr, iZzb, zzdkVar);
                    int i20 = zzdkVar.zzada;
                    if (i20 < 0) {
                        throw zzfi.zzuu();
                    }
                    if (i20 == 0) {
                        zzffVarZzap.add("");
                    } else {
                        int i21 = iZza15 + i20;
                        if (!zzhy.zzf(bArr, iZza15, i21)) {
                            throw zzfi.zzvb();
                        }
                        zzffVarZzap.add(new String(bArr, iZza15, i20, zzez.UTF_8));
                        iZza15 = i21;
                    }
                    while (iZza15 < i2) {
                        int iZza16 = zzdl.zza(bArr, iZza15, zzdkVar);
                        if (i3 != zzdkVar.zzada) {
                            return iZza15;
                        }
                        iZza15 = zzdl.zza(bArr, iZza16, zzdkVar);
                        int i22 = zzdkVar.zzada;
                        if (i22 < 0) {
                            throw zzfi.zzuu();
                        }
                        if (i22 == 0) {
                            zzffVarZzap.add("");
                        } else {
                            int i23 = iZza15 + i22;
                            if (!zzhy.zzf(bArr, iZza15, i23)) {
                                throw zzfi.zzvb();
                            }
                            zzffVarZzap.add(new String(bArr, iZza15, i22, zzez.UTF_8));
                            iZza15 = i23;
                        }
                    }
                    return iZza15;
                }
                return iZzb;
            case 27:
                if (i5 == 2) {
                    return zzdl.zza(zzbx(i6), i3, bArr, i, i2, zzffVarZzap, zzdkVar);
                }
                return iZzb;
            case 28:
                if (i5 == 2) {
                    int iZza17 = zzdl.zza(bArr, iZzb, zzdkVar);
                    int i24 = zzdkVar.zzada;
                    if (i24 < 0) {
                        throw zzfi.zzuu();
                    }
                    if (i24 > bArr.length - iZza17) {
                        throw zzfi.zzut();
                    }
                    if (i24 == 0) {
                        zzffVarZzap.add(zzdp.zzadh);
                    } else {
                        zzffVarZzap.add(zzdp.zzb(bArr, iZza17, i24));
                        iZza17 += i24;
                    }
                    while (iZza17 < i2) {
                        int iZza18 = zzdl.zza(bArr, iZza17, zzdkVar);
                        if (i3 != zzdkVar.zzada) {
                            return iZza17;
                        }
                        iZza17 = zzdl.zza(bArr, iZza18, zzdkVar);
                        int i25 = zzdkVar.zzada;
                        if (i25 < 0) {
                            throw zzfi.zzuu();
                        }
                        if (i25 > bArr.length - iZza17) {
                            throw zzfi.zzut();
                        }
                        if (i25 == 0) {
                            zzffVarZzap.add(zzdp.zzadh);
                        } else {
                            zzffVarZzap.add(zzdp.zzb(bArr, iZza17, i25));
                            iZza17 += i25;
                        }
                    }
                    return iZza17;
                }
                return iZzb;
            case 30:
            case MotionEventCompat.AXIS_GENERIC_13 /* 44 */:
                if (i5 != 2) {
                    if (i5 == 0) {
                        iZza = zzdl.zza(i3, bArr, i, i2, (zzff<?>) zzffVarZzap, zzdkVar);
                    }
                    return iZzb;
                }
                iZza = zzdl.zza(bArr, iZzb, (zzff<?>) zzffVarZzap, zzdkVar);
                zzey zzeyVar = (zzey) t;
                zzhs zzhsVar = zzeyVar.zzahz;
                if (zzhsVar == zzhs.zzwq()) {
                    zzhsVar = null;
                }
                zzhs zzhsVar2 = (zzhs) zzgz.zza(i4, zzffVarZzap, zzbz(i6), zzhsVar, this.zzakx);
                if (zzhsVar2 != null) {
                    zzeyVar.zzahz = zzhsVar2;
                }
                return iZza;
            case 33:
            case MotionEventCompat.AXIS_GENERIC_16 /* 47 */:
                if (i5 == 2) {
                    zzfa zzfaVar3 = (zzfa) zzffVarZzap;
                    int iZza19 = zzdl.zza(bArr, iZzb, zzdkVar);
                    int i26 = zzdkVar.zzada + iZza19;
                    while (iZza19 < i26) {
                        iZza19 = zzdl.zza(bArr, iZza19, zzdkVar);
                        zzfaVar3.zzbu(zzeb.zzaz(zzdkVar.zzada));
                    }
                    if (iZza19 == i26) {
                        return iZza19;
                    }
                    throw zzfi.zzut();
                }
                if (i5 == 0) {
                    zzfa zzfaVar4 = (zzfa) zzffVarZzap;
                    int iZza20 = zzdl.zza(bArr, iZzb, zzdkVar);
                    zzfaVar4.zzbu(zzeb.zzaz(zzdkVar.zzada));
                    while (iZza20 < i2) {
                        int iZza21 = zzdl.zza(bArr, iZza20, zzdkVar);
                        if (i3 != zzdkVar.zzada) {
                            return iZza20;
                        }
                        iZza20 = zzdl.zza(bArr, iZza21, zzdkVar);
                        zzfaVar4.zzbu(zzeb.zzaz(zzdkVar.zzada));
                    }
                    return iZza20;
                }
                return iZzb;
            case 34:
            case 48:
                if (i5 == 2) {
                    zzfw zzfwVar5 = (zzfw) zzffVarZzap;
                    int iZza22 = zzdl.zza(bArr, iZzb, zzdkVar);
                    int i27 = zzdkVar.zzada + iZza22;
                    while (iZza22 < i27) {
                        iZza22 = zzdl.zzb(bArr, iZza22, zzdkVar);
                        zzfwVar5.zzby(zzeb.zzbm(zzdkVar.zzadb));
                    }
                    if (iZza22 == i27) {
                        return iZza22;
                    }
                    throw zzfi.zzut();
                }
                if (i5 == 0) {
                    zzfw zzfwVar6 = (zzfw) zzffVarZzap;
                    int iZzb3 = zzdl.zzb(bArr, iZzb, zzdkVar);
                    zzfwVar6.zzby(zzeb.zzbm(zzdkVar.zzadb));
                    while (iZzb3 < i2) {
                        int iZza23 = zzdl.zza(bArr, iZzb3, zzdkVar);
                        if (i3 != zzdkVar.zzada) {
                            return iZzb3;
                        }
                        iZzb3 = zzdl.zzb(bArr, iZza23, zzdkVar);
                        zzfwVar6.zzby(zzeb.zzbm(zzdkVar.zzadb));
                    }
                    return iZzb3;
                }
                return iZzb;
            case 49:
                if (i5 == 3) {
                    zzgx zzgxVarZzbx = zzbx(i6);
                    int i28 = (i3 & (-8)) | 4;
                    iZzb = zzdl.zza(zzgxVarZzbx, bArr, i, i2, i28, zzdkVar);
                    zzffVarZzap.add(zzdkVar.zzadc);
                    while (iZzb < i2) {
                        int iZza24 = zzdl.zza(bArr, iZzb, zzdkVar);
                        if (i3 == zzdkVar.zzada) {
                            iZzb = zzdl.zza(zzgxVarZzbx, bArr, iZza24, i2, i28, zzdkVar);
                            zzffVarZzap.add(zzdkVar.zzadc);
                        }
                    }
                }
                return iZzb;
            default:
                return iZzb;
        }
    }

    private final <K, V> int zza(T t, byte[] bArr, int i, int i2, int i3, long j, zzdk zzdkVar) throws IOException {
        Unsafe unsafe = zzaki;
        Object objZzby = zzby(i3);
        Object object = unsafe.getObject(t, j);
        if (this.zzakz.zzo(object)) {
            Object objZzq = this.zzakz.zzq(objZzby);
            this.zzakz.zzb(objZzq, object);
            unsafe.putObject(t, j, objZzq);
            object = objZzq;
        }
        zzfz<?, ?> zzfzVarZzr = this.zzakz.zzr(objZzby);
        Map<?, ?> mapZzm = this.zzakz.zzm(object);
        int iZza = zzdl.zza(bArr, i, zzdkVar);
        int i4 = zzdkVar.zzada;
        if (i4 < 0 || i4 > i2 - iZza) {
            throw zzfi.zzut();
        }
        int i5 = i4 + iZza;
        K k = zzfzVarZzr.zzakc;
        V v = zzfzVarZzr.zzaba;
        while (iZza < i5) {
            int iZza2 = iZza + 1;
            int i6 = bArr[iZza];
            if (i6 < 0) {
                iZza2 = zzdl.zza(i6, bArr, iZza2, zzdkVar);
                i6 = zzdkVar.zzada;
            }
            int i7 = iZza2;
            int i8 = i6 & 7;
            switch (i6 >>> 3) {
                case 1:
                    if (i8 == zzfzVarZzr.zzakb.zzxa()) {
                        iZza = zza(bArr, i7, i2, zzfzVarZzr.zzakb, (Class<?>) null, zzdkVar);
                        k = (K) zzdkVar.zzadc;
                    } else {
                        iZza = zzdl.zza(i6, bArr, i7, i2, zzdkVar);
                    }
                    break;
                case 2:
                    if (i8 == zzfzVarZzr.zzakd.zzxa()) {
                        iZza = zza(bArr, i7, i2, zzfzVarZzr.zzakd, zzfzVarZzr.zzaba.getClass(), zzdkVar);
                        v = zzdkVar.zzadc;
                    } else {
                        iZza = zzdl.zza(i6, bArr, i7, i2, zzdkVar);
                    }
                    break;
                default:
                    iZza = zzdl.zza(i6, bArr, i7, i2, zzdkVar);
                    break;
            }
        }
        if (iZza != i5) {
            throw zzfi.zzva();
        }
        mapZzm.put(k, v);
        return i5;
    }

    private final int zza(T t, byte[] bArr, int i, int i2, int i3, int i4, int i5, int i6, int i7, long j, int i8, zzdk zzdkVar) throws IOException {
        int iZzb;
        Unsafe unsafe = zzaki;
        long j2 = this.zzakj[i8 + 2] & 1048575;
        switch (i7) {
            case 51:
                if (i5 != 1) {
                    return i;
                }
                unsafe.putObject(t, j, Double.valueOf(zzdl.zzc(bArr, i)));
                iZzb = i + 8;
                break;
                break;
            case 52:
                if (i5 != 5) {
                    return i;
                }
                unsafe.putObject(t, j, Float.valueOf(zzdl.zzd(bArr, i)));
                iZzb = i + 4;
                break;
                break;
            case 53:
            case 54:
                if (i5 != 0) {
                    return i;
                }
                iZzb = zzdl.zzb(bArr, i, zzdkVar);
                unsafe.putObject(t, j, Long.valueOf(zzdkVar.zzadb));
                break;
                break;
            case 55:
            case 62:
                if (i5 != 0) {
                    return i;
                }
                iZzb = zzdl.zza(bArr, i, zzdkVar);
                unsafe.putObject(t, j, Integer.valueOf(zzdkVar.zzada));
                break;
                break;
            case 56:
            case 65:
                if (i5 != 1) {
                    return i;
                }
                unsafe.putObject(t, j, Long.valueOf(zzdl.zzb(bArr, i)));
                iZzb = i + 8;
                break;
                break;
            case 57:
            case 64:
                if (i5 != 5) {
                    return i;
                }
                unsafe.putObject(t, j, Integer.valueOf(zzdl.zza(bArr, i)));
                iZzb = i + 4;
                break;
                break;
            case 58:
                if (i5 != 0) {
                    return i;
                }
                iZzb = zzdl.zzb(bArr, i, zzdkVar);
                unsafe.putObject(t, j, Boolean.valueOf(zzdkVar.zzadb != 0));
                break;
                break;
            case 59:
                if (i5 != 2) {
                    return i;
                }
                int iZza = zzdl.zza(bArr, i, zzdkVar);
                int i9 = zzdkVar.zzada;
                if (i9 == 0) {
                    unsafe.putObject(t, j, "");
                } else {
                    if ((i6 & DriveFile.MODE_WRITE_ONLY) != 0 && !zzhy.zzf(bArr, iZza, iZza + i9)) {
                        throw zzfi.zzvb();
                    }
                    unsafe.putObject(t, j, new String(bArr, iZza, i9, zzez.UTF_8));
                    iZza += i9;
                }
                unsafe.putInt(t, j2, i4);
                return iZza;
            case 60:
                if (i5 != 2) {
                    return i;
                }
                int iZza2 = zzdl.zza(zzbx(i8), bArr, i, i2, zzdkVar);
                Object object = unsafe.getInt(t, j2) == i4 ? unsafe.getObject(t, j) : null;
                if (object == null) {
                    unsafe.putObject(t, j, zzdkVar.zzadc);
                } else {
                    unsafe.putObject(t, j, zzez.zza(object, zzdkVar.zzadc));
                }
                unsafe.putInt(t, j2, i4);
                return iZza2;
            case 61:
                if (i5 != 2) {
                    return i;
                }
                iZzb = zzdl.zze(bArr, i, zzdkVar);
                unsafe.putObject(t, j, zzdkVar.zzadc);
                break;
                break;
            case HtmlCompat.FROM_HTML_MODE_COMPACT /* 63 */:
                if (i5 != 0) {
                    return i;
                }
                int iZza3 = zzdl.zza(bArr, i, zzdkVar);
                int i10 = zzdkVar.zzada;
                zzfe zzfeVarZzbz = zzbz(i8);
                if (zzfeVarZzbz == null || zzfeVarZzbz.zzg(i10)) {
                    unsafe.putObject(t, j, Integer.valueOf(i10));
                    iZzb = iZza3;
                } else {
                    zzu(t).zzb(i3, Long.valueOf(i10));
                    return iZza3;
                }
                break;
                break;
            case 66:
                if (i5 != 0) {
                    return i;
                }
                iZzb = zzdl.zza(bArr, i, zzdkVar);
                unsafe.putObject(t, j, Integer.valueOf(zzeb.zzaz(zzdkVar.zzada)));
                break;
                break;
            case 67:
                if (i5 != 0) {
                    return i;
                }
                iZzb = zzdl.zzb(bArr, i, zzdkVar);
                unsafe.putObject(t, j, Long.valueOf(zzeb.zzbm(zzdkVar.zzadb)));
                break;
                break;
            case 68:
                if (i5 != 3) {
                    return i;
                }
                iZzb = zzdl.zza(zzbx(i8), bArr, i, i2, (i3 & (-8)) | 4, zzdkVar);
                Object object2 = unsafe.getInt(t, j2) == i4 ? unsafe.getObject(t, j) : null;
                if (object2 == null) {
                    unsafe.putObject(t, j, zzdkVar.zzadc);
                } else {
                    unsafe.putObject(t, j, zzez.zza(object2, zzdkVar.zzadc));
                }
                break;
                break;
            default:
                return i;
        }
        unsafe.putInt(t, j2, i4);
        return iZzb;
    }

    private final zzgx zzbx(int i) {
        int i2 = (i / 3) << 1;
        zzgx zzgxVar = (zzgx) this.zzakk[i2];
        if (zzgxVar != null) {
            return zzgxVar;
        }
        zzgx<T> zzgxVarZzf = zzgt.zzvy().zzf((Class) this.zzakk[i2 + 1]);
        this.zzakk[i2] = zzgxVarZzf;
        return zzgxVarZzf;
    }

    private final Object zzby(int i) {
        return this.zzakk[(i / 3) << 1];
    }

    private final zzfe zzbz(int i) {
        return (zzfe) this.zzakk[((i / 3) << 1) + 1];
    }

    /*  JADX ERROR: Type inference failed
        jadx.core.utils.exceptions.JadxOverflowException: Type inference error: updates count limit reached with updateSeq = 12321. Try increasing type updates limit count.
        	at jadx.core.utils.ErrorsCounter.addError(ErrorsCounter.java:59)
        	at jadx.core.utils.ErrorsCounter.error(ErrorsCounter.java:31)
        	at jadx.core.dex.attributes.nodes.NotificationAttrNode.addError(NotificationAttrNode.java:19)
        	at jadx.core.dex.visitors.typeinference.TypeInferenceVisitor.visit(TypeInferenceVisitor.java:79)
        */
    final int zza(T r31, byte[] r32, int r33, int r34, int r35, com.google.android.gms.internal.measurement.zzdk r36) throws java.io.IOException {
        /*
            Method dump skipped, instruction units count: 1232
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.measurement.zzgm.zza(java.lang.Object, byte[], int, int, int, com.google.android.gms.internal.measurement.zzdk):int");
    }

    /* JADX WARN: Code restructure failed: missing block: B:102:0x0231, code lost:
    
        if (r0 == r15) goto L92;
     */
    /* JADX WARN: Code restructure failed: missing block: B:91:0x01e4, code lost:
    
        if (r0 == r15) goto L92;
     */
    /* JADX WARN: Code restructure failed: missing block: B:92:0x01e6, code lost:
    
        r2 = r0;
     */
    /* JADX WARN: Code restructure failed: missing block: B:98:0x0212, code lost:
    
        if (r0 == r15) goto L92;
     */
    /* JADX WARN: Failed to find 'out' block for switch in B:20:0x0062. Please report as an issue. */
    @Override // com.google.android.gms.internal.measurement.zzgx
    /*
        Code decompiled incorrectly, please refer to instructions dump.
    */
    public final void zza(T t, byte[] bArr, int i, int i2, zzdk zzdkVar) throws IOException {
        int i3;
        int iZza;
        int iZzcd;
        int i4;
        int i5;
        int i6;
        int iZzb;
        zzgm<T> zzgmVar = this;
        T t2 = t;
        byte[] bArr2 = bArr;
        int i7 = i2;
        zzdk zzdkVar2 = zzdkVar;
        if (zzgmVar.zzakq) {
            Unsafe unsafe = zzaki;
            int i8 = -1;
            int iZza2 = i;
            int i9 = -1;
            int i10 = 0;
            while (iZza2 < i7) {
                int i11 = iZza2 + 1;
                byte b = bArr2[iZza2];
                if (b < 0) {
                    iZza = zzdl.zza(b, bArr2, i11, zzdkVar2);
                    i3 = zzdkVar2.zzada;
                } else {
                    i3 = b;
                    iZza = i11;
                }
                i9 = i3 >>> 3;
                int i12 = i3 & 7;
                if (i9 > i9) {
                    iZzcd = zzgmVar.zzp(i9, i10 / 3);
                } else {
                    iZzcd = zzgmVar.zzcd(i9);
                }
                int i13 = iZzcd;
                if (i13 == i8) {
                    i9 = i9;
                    i4 = iZza;
                    unsafe = unsafe;
                    i5 = 0;
                } else {
                    int i14 = zzgmVar.zzakj[i13 + 1];
                    int i15 = (267386880 & i14) >>> 20;
                    long j = 1048575 & i14;
                    if (i15 <= 17) {
                        switch (i15) {
                            case 0:
                                i6 = i13;
                                if (i12 != 1) {
                                    i5 = i6;
                                } else {
                                    zzhv.zza(t2, j, zzdl.zzc(bArr2, iZza));
                                    iZza2 = iZza + 8;
                                    i10 = i6;
                                    i8 = -1;
                                }
                                break;
                            case 1:
                                i6 = i13;
                                if (i12 != 5) {
                                    i5 = i6;
                                } else {
                                    zzhv.zza((Object) t2, j, zzdl.zzd(bArr2, iZza));
                                    iZza2 = iZza + 4;
                                    i10 = i6;
                                    i8 = -1;
                                }
                                break;
                            case 2:
                            case 3:
                                i6 = i13;
                                if (i12 != 0) {
                                    i5 = i6;
                                } else {
                                    iZzb = zzdl.zzb(bArr2, iZza, zzdkVar2);
                                    unsafe.putLong(t, j, zzdkVar2.zzadb);
                                    iZza2 = iZzb;
                                    i10 = i6;
                                    i8 = -1;
                                }
                                break;
                            case 4:
                            case 11:
                                i6 = i13;
                                if (i12 != 0) {
                                    i5 = i6;
                                } else {
                                    iZza2 = zzdl.zza(bArr2, iZza, zzdkVar2);
                                    unsafe.putInt(t2, j, zzdkVar2.zzada);
                                    i10 = i6;
                                    i8 = -1;
                                }
                                break;
                            case 5:
                            case 14:
                                if (i12 != 1) {
                                    i5 = i13;
                                } else {
                                    i6 = i13;
                                    unsafe.putLong(t, j, zzdl.zzb(bArr2, iZza));
                                    iZza2 = iZza + 8;
                                    i10 = i6;
                                    i8 = -1;
                                }
                                break;
                            case 6:
                            case 13:
                                if (i12 != 5) {
                                    i5 = i13;
                                } else {
                                    unsafe.putInt(t2, j, zzdl.zza(bArr2, iZza));
                                    iZza2 = iZza + 4;
                                    i10 = i13;
                                    i8 = -1;
                                }
                                break;
                            case 7:
                                if (i12 != 0) {
                                    i5 = i13;
                                } else {
                                    int iZzb2 = zzdl.zzb(bArr2, iZza, zzdkVar2);
                                    zzhv.zza(t2, j, zzdkVar2.zzadb != 0);
                                    iZza2 = iZzb2;
                                    i10 = i13;
                                    i8 = -1;
                                }
                                break;
                            case 8:
                                if (i12 != 2) {
                                    i5 = i13;
                                } else {
                                    if ((536870912 & i14) == 0) {
                                        iZza2 = zzdl.zzc(bArr2, iZza, zzdkVar2);
                                    } else {
                                        iZza2 = zzdl.zzd(bArr2, iZza, zzdkVar2);
                                    }
                                    unsafe.putObject(t2, j, zzdkVar2.zzadc);
                                    i10 = i13;
                                    i8 = -1;
                                }
                                break;
                            case 9:
                                if (i12 != 2) {
                                    i5 = i13;
                                } else {
                                    iZza2 = zzdl.zza(zzgmVar.zzbx(i13), bArr2, iZza, i7, zzdkVar2);
                                    Object object = unsafe.getObject(t2, j);
                                    if (object == null) {
                                        unsafe.putObject(t2, j, zzdkVar2.zzadc);
                                    } else {
                                        unsafe.putObject(t2, j, zzez.zza(object, zzdkVar2.zzadc));
                                    }
                                    i10 = i13;
                                    i8 = -1;
                                }
                                break;
                            case 10:
                                if (i12 != 2) {
                                    i5 = i13;
                                } else {
                                    iZza2 = zzdl.zze(bArr2, iZza, zzdkVar2);
                                    unsafe.putObject(t2, j, zzdkVar2.zzadc);
                                    i10 = i13;
                                    i8 = -1;
                                }
                                break;
                            case 12:
                                i6 = i13;
                                if (i12 != 0) {
                                    i5 = i6;
                                } else {
                                    iZza2 = zzdl.zza(bArr2, iZza, zzdkVar2);
                                    unsafe.putInt(t2, j, zzdkVar2.zzada);
                                    i10 = i6;
                                    i8 = -1;
                                }
                                break;
                            case 15:
                                i6 = i13;
                                if (i12 != 0) {
                                    i5 = i6;
                                } else {
                                    iZza2 = zzdl.zza(bArr2, iZza, zzdkVar2);
                                    unsafe.putInt(t2, j, zzeb.zzaz(zzdkVar2.zzada));
                                    i10 = i6;
                                    i8 = -1;
                                }
                                break;
                            case 16:
                                if (i12 != 0) {
                                    i5 = i13;
                                } else {
                                    iZzb = zzdl.zzb(bArr2, iZza, zzdkVar2);
                                    i6 = i13;
                                    unsafe.putLong(t, j, zzeb.zzbm(zzdkVar2.zzadb));
                                    iZza2 = iZzb;
                                    i10 = i6;
                                    i8 = -1;
                                }
                                break;
                            default:
                                i5 = i13;
                                break;
                        }
                    } else {
                        if (i15 != 27) {
                            i5 = i13;
                            if (i15 <= 49) {
                                i9 = i9;
                                int i16 = iZza;
                                unsafe = unsafe;
                                iZza2 = zza(t, bArr, iZza, i2, i3, i9, i12, i5, i14, i15, j, zzdkVar);
                            } else {
                                i9 = i9;
                                iZza = iZza;
                                unsafe = unsafe;
                                if (i15 != 50) {
                                    iZza2 = zza(t, bArr, iZza, i2, i3, i9, i12, i14, i15, j, i5, zzdkVar);
                                } else if (i12 == 2) {
                                    iZza2 = zza(t, bArr, iZza, i2, i5, j, zzdkVar);
                                }
                            }
                        } else if (i12 == 2) {
                            zzff zzffVarZzap = (zzff) unsafe.getObject(t2, j);
                            if (!zzffVarZzap.zzrx()) {
                                int size = zzffVarZzap.size();
                                zzffVarZzap = zzffVarZzap.zzap(size == 0 ? 10 : size << 1);
                                unsafe.putObject(t2, j, zzffVarZzap);
                            }
                            iZza2 = zzdl.zza(zzgmVar.zzbx(i13), i3, bArr, iZza, i2, zzffVarZzap, zzdkVar);
                            i10 = i13;
                            i8 = -1;
                        } else {
                            i5 = i13;
                        }
                        t2 = t;
                        bArr2 = bArr;
                        zzdkVar2 = zzdkVar;
                        unsafe = unsafe;
                        i10 = i5;
                        i9 = i9;
                        i8 = -1;
                        i7 = i2;
                        zzgmVar = this;
                    }
                    i4 = iZza;
                }
                iZza2 = zzdl.zza(i3, bArr, i4, i2, zzu(t), zzdkVar);
                t2 = t;
                bArr2 = bArr;
                zzdkVar2 = zzdkVar;
                unsafe = unsafe;
                i10 = i5;
                i9 = i9;
                i8 = -1;
                i7 = i2;
                zzgmVar = this;
            }
            if (iZza2 != i7) {
                throw zzfi.zzva();
            }
            return;
        }
        zza(t, bArr, i, i2, 0, zzdkVar);
    }

    @Override // com.google.android.gms.internal.measurement.zzgx
    public final void zzj(T t) {
        for (int i = this.zzakt; i < this.zzaku; i++) {
            long jZzca = zzca(this.zzaks[i]) & 1048575;
            Object objZzp = zzhv.zzp(t, jZzca);
            if (objZzp != null) {
                zzhv.zza(t, jZzca, this.zzakz.zzp(objZzp));
            }
        }
        int length = this.zzaks.length;
        for (int i2 = this.zzaku; i2 < length; i2++) {
            this.zzakw.zzb(t, this.zzaks[i2]);
        }
        this.zzakx.zzj(t);
        if (this.zzako) {
            this.zzaky.zzj(t);
        }
    }

    private final <UT, UB> UB zza(Object obj, int i, UB ub, zzhp<UT, UB> zzhpVar) {
        zzfe zzfeVarZzbz;
        int i2 = this.zzakj[i];
        Object objZzp = zzhv.zzp(obj, zzca(i) & 1048575);
        return (objZzp == null || (zzfeVarZzbz = zzbz(i)) == null) ? ub : (UB) zza(i, i2, this.zzakz.zzm(objZzp), zzfeVarZzbz, ub, zzhpVar);
    }

    private final <K, V, UT, UB> UB zza(int i, int i2, Map<K, V> map, zzfe zzfeVar, UB ub, zzhp<UT, UB> zzhpVar) {
        zzfz<?, ?> zzfzVarZzr = this.zzakz.zzr(zzby(i));
        Iterator<Map.Entry<K, V>> it = map.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<K, V> next = it.next();
            if (!zzfeVar.zzg(((Integer) next.getValue()).intValue())) {
                if (ub == null) {
                    ub = zzhpVar.zzwp();
                }
                zzdx zzdxVarZzas = zzdp.zzas(zzga.zza(zzfzVarZzr, next.getKey(), next.getValue()));
                try {
                    zzga.zza(zzdxVarZzas.zzsf(), zzfzVarZzr, next.getKey(), next.getValue());
                    zzhpVar.zza(ub, i2, zzdxVarZzas.zzse());
                    it.remove();
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }
        return ub;
    }

    /* JADX WARN: Code duplicated, block: B:51:0x00c7  */
    /* JADX WARN: Code duplicated, block: B:53:0x00d6  */
    /* JADX WARN: Code duplicated, block: B:56:0x00e1  */
    /* JADX WARN: Code duplicated, block: B:59:0x00ed A[LOOP:2: B:54:0x00db->B:59:0x00ed, LOOP_END] */
    /* JADX WARN: Code duplicated, block: B:78:0x00f2 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:83:0x0104 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:91:0x00eb A[SYNTHETIC] */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r4v12 */
    /* JADX WARN: Type inference failed for: r4v13 */
    /* JADX WARN: Type inference failed for: r4v14, types: [com.google.android.gms.internal.measurement.zzgx] */
    /* JADX WARN: Type inference failed for: r4v17 */
    /* JADX WARN: Type inference failed for: r4v18 */
    /* JADX WARN: Type inference failed for: r4v5, types: [com.google.android.gms.internal.measurement.zzgx] */
    @Override // com.google.android.gms.internal.measurement.zzgx
    public final boolean zzv(T t) {
        int i;
        List list;
        ?? Zzbx;
        int i2;
        int i3 = 0;
        int i4 = -1;
        int i5 = 0;
        while (true) {
            boolean z = true;
            if (i3 >= this.zzakt) {
                return !this.zzako || this.zzaky.zzh(t).isInitialized();
            }
            int i6 = this.zzaks[i3];
            int i7 = this.zzakj[i6];
            int iZzca = zzca(i6);
            if (this.zzakq) {
                i = 0;
            } else {
                int i8 = this.zzakj[i6 + 2];
                int i9 = i8 & 1048575;
                i = 1 << (i8 >>> 20);
                if (i9 != i4) {
                    i5 = zzaki.getInt(t, i9);
                    i4 = i9;
                }
            }
            if (((268435456 & iZzca) != 0) && !zza(t, i6, i5, i)) {
                return false;
            }
            int i10 = (267386880 & iZzca) >>> 20;
            if (i10 == 9 || i10 == 17) {
                if (zza(t, i6, i5, i) && !zza(t, iZzca, zzbx(i6))) {
                    return false;
                }
            } else if (i10 == 27) {
                list = (List) zzhv.zzp(t, iZzca & 1048575);
                if (!list.isEmpty()) {
                    Zzbx = zzbx(i6);
                    while (i2 < list.size()) {
                        if (!Zzbx.zzv(list.get(i2))) {
                            z = false;
                        }
                    }
                }
                if (!z) {
                    return false;
                }
            } else if (i10 != 60 && i10 != 68) {
                switch (i10) {
                    case 49:
                        list = (List) zzhv.zzp(t, iZzca & 1048575);
                        if (!list.isEmpty()) {
                            Zzbx = zzbx(i6);
                            for (i2 = 0; i2 < list.size(); i2++) {
                                if (!Zzbx.zzv(list.get(i2))) {
                                    z = false;
                                }
                            }
                        }
                        if (!z) {
                            return false;
                        }
                        break;
                        break;
                    case 50:
                        Map<?, ?> mapZzn = this.zzakz.zzn(zzhv.zzp(t, iZzca & 1048575));
                        if (!mapZzn.isEmpty()) {
                            if (this.zzakz.zzr(zzby(i6)).zzakd.zzwz() == zzij.MESSAGE) {
                                ?? Zzf = 0;
                                for (Object obj : mapZzn.values()) {
                                    if (Zzf == 0) {
                                        Zzf = Zzf;
                                        Zzf = zzgt.zzvy().zzf(obj.getClass());
                                    }
                                    Zzf = Zzf;
                                    if (!Zzf.zzv(obj)) {
                                        z = false;
                                    }
                                }
                            }
                        }
                        if (!z) {
                            return false;
                        }
                        break;
                        break;
                }
            } else if (zza(t, i7, i6) && !zza(t, iZzca, zzbx(i6))) {
                return false;
            }
            i3++;
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    private static boolean zza(Object obj, int i, zzgx zzgxVar) {
        return zzgxVar.zzv(zzhv.zzp(obj, i & 1048575));
    }

    private static void zza(int i, Object obj, zzim zzimVar) throws IOException {
        if (obj instanceof String) {
            zzimVar.zzb(i, (String) obj);
        } else {
            zzimVar.zza(i, (zzdp) obj);
        }
    }

    private final void zza(Object obj, int i, zzgy zzgyVar) throws IOException {
        if (zzcc(i)) {
            zzhv.zza(obj, i & 1048575, zzgyVar.zzsn());
        } else if (this.zzakp) {
            zzhv.zza(obj, i & 1048575, zzgyVar.readString());
        } else {
            zzhv.zza(obj, i & 1048575, zzgyVar.zzso());
        }
    }

    private final int zzca(int i) {
        return this.zzakj[i + 1];
    }

    private final int zzcb(int i) {
        return this.zzakj[i + 2];
    }

    private static <T> double zzf(T t, long j) {
        return ((Double) zzhv.zzp(t, j)).doubleValue();
    }

    private static <T> float zzg(T t, long j) {
        return ((Float) zzhv.zzp(t, j)).floatValue();
    }

    private static <T> int zzh(T t, long j) {
        return ((Integer) zzhv.zzp(t, j)).intValue();
    }

    private static <T> long zzi(T t, long j) {
        return ((Long) zzhv.zzp(t, j)).longValue();
    }

    private static <T> boolean zzj(T t, long j) {
        return ((Boolean) zzhv.zzp(t, j)).booleanValue();
    }

    private final boolean zzc(T t, T t2, int i) {
        return zza(t, i) == zza(t2, i);
    }

    private final boolean zza(T t, int i, int i2, int i3) {
        if (this.zzakq) {
            return zza(t, i);
        }
        return (i2 & i3) != 0;
    }

    private final boolean zza(T t, int i) {
        if (this.zzakq) {
            int iZzca = zzca(i);
            long j = iZzca & 1048575;
            switch ((iZzca & 267386880) >>> 20) {
                case 0:
                    return zzhv.zzo(t, j) != 0.0d;
                case 1:
                    return zzhv.zzn(t, j) != 0.0f;
                case 2:
                    return zzhv.zzl(t, j) != 0;
                case 3:
                    return zzhv.zzl(t, j) != 0;
                case 4:
                    return zzhv.zzk(t, j) != 0;
                case 5:
                    return zzhv.zzl(t, j) != 0;
                case 6:
                    return zzhv.zzk(t, j) != 0;
                case 7:
                    return zzhv.zzm(t, j);
                case 8:
                    Object objZzp = zzhv.zzp(t, j);
                    if (objZzp instanceof String) {
                        return !((String) objZzp).isEmpty();
                    }
                    if (objZzp instanceof zzdp) {
                        return !zzdp.zzadh.equals(objZzp);
                    }
                    throw new IllegalArgumentException();
                case 9:
                    return zzhv.zzp(t, j) != null;
                case 10:
                    return !zzdp.zzadh.equals(zzhv.zzp(t, j));
                case 11:
                    return zzhv.zzk(t, j) != 0;
                case 12:
                    return zzhv.zzk(t, j) != 0;
                case 13:
                    return zzhv.zzk(t, j) != 0;
                case 14:
                    return zzhv.zzl(t, j) != 0;
                case 15:
                    return zzhv.zzk(t, j) != 0;
                case 16:
                    return zzhv.zzl(t, j) != 0;
                case 17:
                    return zzhv.zzp(t, j) != null;
                default:
                    throw new IllegalArgumentException();
            }
        }
        int iZzcb = zzcb(i);
        return (zzhv.zzk(t, (long) (iZzcb & 1048575)) & (1 << (iZzcb >>> 20))) != 0;
    }

    private final void zzb(T t, int i) {
        if (this.zzakq) {
            return;
        }
        int iZzcb = zzcb(i);
        long j = iZzcb & 1048575;
        zzhv.zzb(t, j, zzhv.zzk(t, j) | (1 << (iZzcb >>> 20)));
    }

    private final boolean zza(T t, int i, int i2) {
        return zzhv.zzk(t, (long) (zzcb(i2) & 1048575)) == i;
    }

    private final void zzb(T t, int i, int i2) {
        zzhv.zzb(t, zzcb(i2) & 1048575, i);
    }

    private final int zzcd(int i) {
        if (i < this.zzakl || i > this.zzakm) {
            return -1;
        }
        return zzq(i, 0);
    }

    private final int zzp(int i, int i2) {
        if (i < this.zzakl || i > this.zzakm) {
            return -1;
        }
        return zzq(i, i2);
    }

    private final int zzq(int i, int i2) {
        int length = (this.zzakj.length / 3) - 1;
        while (i2 <= length) {
            int i3 = (length + i2) >>> 1;
            int i4 = i3 * 3;
            int i5 = this.zzakj[i4];
            if (i == i5) {
                return i4;
            }
            if (i < i5) {
                length = i3 - 1;
            } else {
                i2 = i3 + 1;
            }
        }
        return -1;
    }
}

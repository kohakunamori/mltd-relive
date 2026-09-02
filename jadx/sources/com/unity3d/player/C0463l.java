package com.unity3d.player;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.LayerDrawable;
import android.view.View;
import androidx.core.view.ViewCompat;

/* JADX INFO: renamed from: com.unity3d.player.l */
/* JADX INFO: loaded from: classes.dex */
public final class C0463l extends View {

    /* JADX INFO: renamed from: a */
    final int f665a;

    /* JADX INFO: renamed from: b */
    final int f666b;

    /* JADX INFO: renamed from: c */
    Bitmap f667c;

    /* JADX INFO: renamed from: d */
    Bitmap f668d;

    /* JADX INFO: renamed from: com.unity3d.player.l$1, reason: invalid class name */
    static /* synthetic */ class AnonymousClass1 {

        /* JADX INFO: renamed from: a */
        static final /* synthetic */ int[] f669a = new int[a.m519a().length];

        static {
            try {
                f669a[a.f670a - 1] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f669a[a.f671b - 1] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                f669a[a.f672c - 1] = 3;
            } catch (NoSuchFieldError unused3) {
            }
        }
    }

    /* JADX WARN: $VALUES field not found */
    /* JADX WARN: Failed to restore enum class, 'enum' modifier and super class removed */
    /* JADX INFO: renamed from: com.unity3d.player.l$a */
    static final class a {

        /* JADX INFO: renamed from: a */
        public static final int f670a = 1;

        /* JADX INFO: renamed from: b */
        public static final int f671b = 2;

        /* JADX INFO: renamed from: c */
        public static final int f672c = 3;

        /* JADX INFO: renamed from: d */
        private static final /* synthetic */ int[] f673d = {f670a, f671b, f672c};

        /* JADX INFO: renamed from: a */
        public static int[] m519a() {
            return (int[]) f673d.clone();
        }
    }

    public C0463l(Context context, int i) {
        super(context);
        this.f665a = i;
        this.f666b = getResources().getIdentifier("unity_static_splash", "drawable", getContext().getPackageName());
        if (this.f666b != 0) {
            forceLayout();
        }
    }

    @Override // android.view.View
    public final void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        if (this.f667c != null) {
            this.f667c.recycle();
            this.f667c = null;
        }
        if (this.f668d != null) {
            this.f668d.recycle();
            this.f668d = null;
        }
    }

    /* JADX WARN: Code duplicated, block: B:29:0x0068  */
    @Override // android.view.View
    public final void onLayout(boolean z, int i, int i2, int i3, int i4) {
        if (this.f666b == 0) {
            return;
        }
        if (this.f667c == null) {
            BitmapFactory.Options options = new BitmapFactory.Options();
            options.inScaled = false;
            this.f667c = BitmapFactory.decodeResource(getResources(), this.f666b, options);
        }
        int width = this.f667c.getWidth();
        int height = this.f667c.getHeight();
        int width2 = getWidth();
        int height2 = getHeight();
        if (width2 == 0 || height2 == 0) {
            return;
        }
        float f = width / height;
        float f2 = width2;
        float f3 = height2;
        boolean z2 = f2 / f3 <= f;
        switch (AnonymousClass1.f669a[this.f665a - 1]) {
            case 1:
                if (width2 < width) {
                    height = (int) (f2 / f);
                    width = width2;
                }
                if (height2 < height) {
                    width = (int) (f3 * f);
                    height = height2;
                }
                break;
            case 2:
            case 3:
                if (!((this.f665a == a.f672c) ^ z2)) {
                    width = (int) (f3 * f);
                    height = height2;
                } else {
                    height = (int) (f2 / f);
                    width = width2;
                }
                break;
        }
        if (this.f668d != null) {
            if (this.f668d.getWidth() == width && this.f668d.getHeight() == height) {
                return;
            }
            if (this.f668d != this.f667c) {
                this.f668d.recycle();
                this.f668d = null;
            }
        }
        this.f668d = Bitmap.createScaledBitmap(this.f667c, width, height, true);
        this.f668d.setDensity(getResources().getDisplayMetrics().densityDpi);
        ColorDrawable colorDrawable = new ColorDrawable(ViewCompat.MEASURED_STATE_MASK);
        BitmapDrawable bitmapDrawable = new BitmapDrawable(getResources(), this.f668d);
        bitmapDrawable.setGravity(17);
        setBackground(new LayerDrawable(new Drawable[]{colorDrawable, bitmapDrawable}));
    }
}

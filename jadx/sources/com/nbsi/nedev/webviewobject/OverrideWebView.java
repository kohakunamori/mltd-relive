package com.nbsi.nedev.webviewobject;

import android.content.Context;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.webkit.WebView;

/* JADX INFO: loaded from: classes.dex */
public class OverrideWebView extends WebView {
    boolean isTouchDown;
    float last_dY;
    float oldY;

    public OverrideWebView(Context context) {
        super(context);
        this.isTouchDown = false;
        this.oldY = Float.MIN_VALUE;
        this.last_dY = 0.0f;
    }

    public OverrideWebView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.isTouchDown = false;
        this.oldY = Float.MIN_VALUE;
        this.last_dY = 0.0f;
    }

    public OverrideWebView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.isTouchDown = false;
        this.oldY = Float.MIN_VALUE;
        this.last_dY = 0.0f;
    }

    @Override // android.webkit.WebView, android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        switch (motionEvent.getAction()) {
            case 0:
                this.oldY = motionEvent.getY();
                this.last_dY = 0.0f;
                this.isTouchDown = true;
                break;
            case 1:
                this.isTouchDown = false;
            case 2:
                float y = motionEvent.getY();
                if (y != this.oldY) {
                    this.last_dY = this.oldY - y;
                }
                break;
        }
        return super.onTouchEvent(motionEvent);
    }

    @Override // android.view.View
    protected boolean overScrollBy(int i, int i2, int i3, int i4, int i5, int i6, int i7, int i8, boolean z) {
        if (!this.isTouchDown && this.last_dY != 0.0f) {
            if (i2 < 0 && 0.0f < this.last_dY) {
                return true;
            }
            if (i2 > 0 && this.last_dY < 0.0f) {
                return true;
            }
        }
        return super.overScrollBy(i, i2, i3, i4, i5, i6, i7, i8, z);
    }
}

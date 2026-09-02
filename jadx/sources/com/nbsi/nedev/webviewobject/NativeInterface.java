package com.nbsi.nedev.webviewobject;

import android.webkit.JavascriptInterface;

/* JADX INFO: loaded from: classes.dex */
public class NativeInterface {
    WebviewObjectUnityListener unitylistener;

    public NativeInterface(WebviewObjectUnityListener webviewObjectUnityListener) {
        this.unitylistener = null;
        this.unitylistener = webviewObjectUnityListener;
    }

    @JavascriptInterface
    public String Call(String str, String str2) {
        return this.unitylistener.callFromJS(str, str2);
    }
}

package com.nbsi.nedev.webviewobject;

import android.webkit.WebChromeClient;

/* JADX INFO: loaded from: classes.dex */
public class WebviewObjectWebChromeClient extends WebChromeClient {
    WebviewObjectUnityListener unitylistener;

    public WebviewObjectWebChromeClient(WebviewObjectUnityListener webviewObjectUnityListener) {
        this.unitylistener = null;
        this.unitylistener = webviewObjectUnityListener;
    }
}

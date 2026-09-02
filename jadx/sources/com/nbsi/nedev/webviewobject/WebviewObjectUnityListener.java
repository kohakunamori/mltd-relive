package com.nbsi.nedev.webviewobject;

/* JADX INFO: loaded from: classes.dex */
public interface WebviewObjectUnityListener {
    String callFromJS(String str, String str2);

    void onInitComplete();

    void onPageFinished(String str);

    void onPageStarted(String str);

    boolean onReceivedError(int i, String str, String str2);

    boolean overrideUrl(String str, String str2);
}

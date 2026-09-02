package com.nbsi.nedev.webviewobject;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.graphics.Color;
import android.graphics.Point;
import android.graphics.Rect;
import android.os.Build;
import android.view.ViewGroup;
import android.webkit.CookieManager;
import android.webkit.CookieSyncManager;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.RelativeLayout;
import com.unity3d.player.UnityPlayer;
import java.net.HttpURLConnection;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class WebviewObject {
    private static RelativeLayout globallayout;
    WebView mWebview = null;
    WebviewObjectUnityListener unitylistener = null;
    boolean isInitComplete = false;
    WebviewObjectWebViewClient webviewclient = null;
    HashMap<String, String> customheader = null;
    Padding padding = null;
    private Rect resize_tmp = null;
    private int scr_w_tmp = 0;
    private int scr_h_tmp = 0;

    private class Padding {
        int left = 0;
        int top = 0;
        int right = 0;
        int bottom = 0;

        public Padding() {
        }
    }

    private WebviewObject() {
    }

    public static WebviewObject createWebviewObject() {
        return new WebviewObject();
    }

    public void setListener(WebviewObjectUnityListener webviewObjectUnityListener) {
        this.unitylistener = webviewObjectUnityListener;
    }

    public void setDisplayPos(int i, int i2, int i3, int i4, int i5, int i6) {
        setDisplayPos(i, i2, i3, i4, i5, i6, null);
    }

    @SuppressLint({"NewApi"})
    public void setDisplayPos(final int i, final int i2, final int i3, final int i4, final int i5, final int i6, final WebviewObjectSettings webviewObjectSettings) {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.1
            @Override // java.lang.Runnable
            public void run() {
                String userAgentString;
                Activity activity = UnityPlayer.currentActivity;
                if (WebviewObject.this.mWebview != null && WebviewObject.globallayout != null) {
                    WebviewObject.globallayout.removeView(WebviewObject.this.mWebview);
                    WebviewObject.this.mWebview = null;
                }
                WebviewObject.this.mWebview = new OverrideWebView(activity);
                WebviewObjectSettings webviewObjectSettings2 = webviewObjectSettings;
                if (webviewObjectSettings2 == null) {
                    webviewObjectSettings2 = new WebviewObjectSettings();
                }
                if (WebviewObject.this.unitylistener != null) {
                    WebviewObject.this.webviewclient = new WebviewObjectWebViewClient(WebviewObject.this.unitylistener, webviewObjectSettings2.isCheckURL, webviewObjectSettings2.javascriptInterfaceName, webviewObjectSettings2.overrideURLScheme);
                    WebviewObject.this.mWebview.setWebViewClient(WebviewObject.this.webviewclient);
                    WebviewObject.this.mWebview.setWebChromeClient(new WebviewObjectWebChromeClient(WebviewObject.this.unitylistener));
                }
                WebviewObject.this.mWebview.setFocusable(true);
                WebviewObject.this.mWebview.setFocusableInTouchMode(true);
                WebviewObject.this.mWebview.setOverScrollMode(webviewObjectSettings2.OverScrollMode);
                WebviewObject.this.mWebview.setHorizontalFadingEdgeEnabled(webviewObjectSettings2.isHorizontalFadingEdgeEnabled);
                WebviewObject.this.mWebview.setVerticalFadingEdgeEnabled(webviewObjectSettings2.isVerticalFadingEdgeEnabled);
                WebviewObject.this.mWebview.setHorizontalScrollBarEnabled(webviewObjectSettings2.isHorizontalScrollBarEnabled);
                WebviewObject.this.mWebview.setVerticalScrollBarEnabled(webviewObjectSettings2.isVerticalScrollBarEnabled);
                WebviewObject.this.mWebview.setHovered(false);
                WebviewObject.this.mWebview.setLongClickable(false);
                WebviewObject.this.mWebview.setHapticFeedbackEnabled(false);
                WebSettings settings = WebviewObject.this.mWebview.getSettings();
                settings.setJavaScriptEnabled(true);
                settings.setDatabaseEnabled(true);
                if (webviewObjectSettings2.isDomStorageEnable) {
                    settings.setDomStorageEnabled(true);
                }
                settings.setUseWideViewPort(webviewObjectSettings2.isUseWideViewPort);
                settings.setLoadWithOverviewMode(webviewObjectSettings2.isLoadWithOverviewMode);
                if (webviewObjectSettings2.isZoomSupport) {
                    settings.setBuiltInZoomControls(true);
                    settings.setDisplayZoomControls(false);
                }
                if (webviewObjectSettings2.replaceUserAgent != null && webviewObjectSettings2.replaceUserAgent.length() > 0) {
                    userAgentString = webviewObjectSettings2.replaceUserAgent;
                } else {
                    userAgentString = settings.getUserAgentString();
                }
                if (webviewObjectSettings2.prefixUserAgent != null) {
                    userAgentString = webviewObjectSettings2.prefixUserAgent + userAgentString;
                }
                if (webviewObjectSettings2.suffixUserAgent != null) {
                    userAgentString = userAgentString + webviewObjectSettings2.suffixUserAgent;
                }
                settings.setUserAgentString(userAgentString);
                if (webviewObjectSettings2.isClearCache) {
                    WebviewObject.this.mWebview.clearCache(true);
                }
                settings.setAppCacheEnabled(true);
                if (21 <= Build.VERSION.SDK_INT) {
                    CookieManager.getInstance().removeAllCookies(null);
                    CookieManager.getInstance().flush();
                } else {
                    CookieSyncManager cookieSyncManagerCreateInstance = CookieSyncManager.createInstance(activity);
                    cookieSyncManagerCreateInstance.startSync();
                    CookieManager cookieManager = CookieManager.getInstance();
                    cookieManager.removeAllCookie();
                    cookieManager.removeSessionCookie();
                    cookieSyncManagerCreateInstance.stopSync();
                    cookieSyncManagerCreateInstance.sync();
                }
                if (WebviewObject.globallayout == null) {
                    RelativeLayout unused = WebviewObject.globallayout = new RelativeLayout(activity);
                    activity.addContentView(WebviewObject.globallayout, new RelativeLayout.LayoutParams(-1, -1));
                    WebviewObject.globallayout.setFocusable(true);
                    WebviewObject.globallayout.setFocusableInTouchMode(true);
                }
                RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(i3, i4);
                if (WebviewObject.this.resize_tmp != null) {
                    layoutParams.leftMargin = WebviewObject.this.resize_tmp.left;
                    layoutParams.topMargin = WebviewObject.this.resize_tmp.top;
                    layoutParams.width = WebviewObject.this.resize_tmp.right - WebviewObject.this.resize_tmp.left;
                    layoutParams.height = WebviewObject.this.resize_tmp.bottom - WebviewObject.this.resize_tmp.top;
                    WebviewObject.this.resize_tmp = null;
                } else {
                    layoutParams.leftMargin = i;
                    layoutParams.topMargin = i2;
                }
                HttpURLConnection.setFollowRedirects(true);
                WebviewObject.this.setWebviewSize(layoutParams, layoutParams.leftMargin, layoutParams.topMargin, layoutParams.width, layoutParams.height, i5, i6);
                WebviewObject.globallayout.addView(WebviewObject.this.mWebview, layoutParams);
                if (!webviewObjectSettings2.isInitWithWindwShow) {
                    WebviewObject.this.mWebview.setVisibility(8);
                }
                WebviewObject.this.isInitComplete = true;
                new Thread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.1.1
                    @Override // java.lang.Runnable
                    public void run() {
                        WebviewObject.this.unitylistener.onInitComplete();
                    }
                }).start();
            }
        });
    }

    public static void RemoveAllCookie() {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.2
            @Override // java.lang.Runnable
            public void run() {
                Activity activity = UnityPlayer.currentActivity;
                if (21 <= Build.VERSION.SDK_INT) {
                    CookieManager.getInstance().removeAllCookies(null);
                    CookieManager.getInstance().flush();
                    return;
                }
                CookieSyncManager cookieSyncManagerCreateInstance = CookieSyncManager.createInstance(activity);
                cookieSyncManagerCreateInstance.startSync();
                CookieManager cookieManager = CookieManager.getInstance();
                cookieManager.removeAllCookie();
                cookieManager.removeSessionCookie();
                cookieSyncManagerCreateInstance.stopSync();
                cookieSyncManagerCreateInstance.sync();
            }
        });
    }

    public void ForceInvisibility() {
        if (this.mWebview != null) {
            UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.3
                @Override // java.lang.Runnable
                public void run() {
                    if (WebviewObject.this.mWebview.getVisibility() != 8) {
                        WebviewObject.this.mWebview.stopLoading();
                        WebviewObject.this.mWebview.setVisibility(8);
                    }
                }
            });
        }
    }

    public void SetVisibility(final boolean z) {
        if (this.mWebview != null) {
            UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.4
                @Override // java.lang.Runnable
                public void run() {
                    if (z) {
                        WebviewObject.this.mWebview.setVisibility(0);
                        if (WebviewObject.globallayout != null) {
                            WebviewObject.globallayout.requestFocus();
                        }
                        WebviewObject.this.mWebview.requestFocus();
                        return;
                    }
                    WebviewObject.this.mWebview.stopLoading();
                    WebviewObject.this.mWebview.setVisibility(8);
                }
            });
        }
    }

    public void resize(final int i, final int i2, final int i3, final int i4, final int i5, final int i6) {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.5
            @Override // java.lang.Runnable
            public void run() {
                RelativeLayout.LayoutParams layoutParams = WebviewObject.this.mWebview != null ? (RelativeLayout.LayoutParams) WebviewObject.this.mWebview.getLayoutParams() : null;
                if (layoutParams == null) {
                    WebviewObject.this.resize_tmp = new Rect();
                    WebviewObject.this.resize_tmp.left = i;
                    WebviewObject.this.resize_tmp.top = i2;
                    WebviewObject.this.resize_tmp.right = i + i3;
                    WebviewObject.this.resize_tmp.bottom = i2 + i4;
                    WebviewObject.this.scr_w_tmp = i5;
                    WebviewObject.this.scr_h_tmp = i6;
                    return;
                }
                if (layoutParams.leftMargin == i && layoutParams.topMargin == i2 && layoutParams.width == i3 && layoutParams.height == i4) {
                    return;
                }
                RelativeLayout.LayoutParams layoutParams2 = (RelativeLayout.LayoutParams) WebviewObject.this.mWebview.getLayoutParams();
                WebviewObject.this.setWebviewSize(layoutParams2, i, i2, i3, i4, i5, i6);
                WebviewObject.this.mWebview.setLayoutParams(layoutParams2);
                WebviewObject.this.mWebview.invalidate();
            }
        });
    }

    public void setWebviewSize(RelativeLayout.LayoutParams layoutParams, int i, int i2, int i3, int i4, int i5, int i6) {
        if (this.padding == null) {
            this.padding = new Padding();
        }
        Point realDisplaySize = getRealDisplaySize();
        float f = i5 / realDisplaySize.x;
        float f2 = i6 / realDisplaySize.y;
        layoutParams.leftMargin = (int) ((i + this.padding.left) / f);
        layoutParams.topMargin = (int) ((i2 + this.padding.top) / f2);
        layoutParams.width = (int) ((i3 - (this.padding.left + this.padding.right)) / f);
        layoutParams.height = (int) ((i4 - (this.padding.top + this.padding.bottom)) / f2);
    }

    public static Point getRealDisplaySize() {
        Point point = new Point();
        ViewGroup viewGroup = (ViewGroup) UnityPlayer.currentActivity.getWindow().getDecorView().findViewById(android.R.id.content);
        point.x = viewGroup.getWidth();
        point.y = viewGroup.getHeight();
        return point;
    }

    public void ClearRequestHeader() {
        this.customheader = new HashMap<>();
    }

    public void SetRequestHeader(String str, String str2) {
        if (this.customheader == null) {
            ClearRequestHeader();
        }
        this.customheader.put(str, str2);
    }

    public void LoadURL(String str) {
        LoadURL(str, null);
    }

    public void LoadURL(final String str, final String str2) {
        if (str == null) {
            return;
        }
        if (this.resize_tmp != null) {
            RelativeLayout.LayoutParams layoutParams = (RelativeLayout.LayoutParams) this.mWebview.getLayoutParams();
            layoutParams.leftMargin = this.resize_tmp.left;
            layoutParams.topMargin = this.resize_tmp.top;
            layoutParams.width = this.resize_tmp.right - this.resize_tmp.left;
            layoutParams.height = this.resize_tmp.bottom - this.resize_tmp.top;
            setWebviewSize(layoutParams, layoutParams.leftMargin, layoutParams.topMargin, layoutParams.width, layoutParams.height, this.scr_w_tmp, this.scr_h_tmp);
            this.resize_tmp = null;
        }
        if (this.webviewclient == null || !this.webviewclient.shouldOverrideUrlCheck(str)) {
            UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.6
                @Override // java.lang.Runnable
                public void run() {
                    if (WebviewObject.this.mWebview != null) {
                        WebviewObject.this.mWebview.stopLoading();
                    }
                    if (WebviewObject.this.webviewclient != null) {
                        WebviewObject.this.webviewclient.setErrorCheckURL(str);
                    }
                    HashMap map = null;
                    if (str2 == null) {
                        WebviewObject.this.webviewclient.setAuthString(null);
                    } else {
                        String authString = WebviewObject.this.webviewclient.setAuthString(str2);
                        map = new HashMap();
                        map.put("Authorization", authString);
                    }
                    if (WebviewObject.this.customheader != null) {
                        if (map == null) {
                            map = new HashMap();
                        }
                        for (Map.Entry<String, String> entry : WebviewObject.this.customheader.entrySet()) {
                            map.put(entry.getKey(), entry.getValue());
                        }
                    }
                    if (map != null) {
                        WebviewObject.this.mWebview.loadUrl(str, map);
                    } else {
                        WebviewObject.this.mWebview.loadUrl(str);
                    }
                }
            });
        }
    }

    public void setPadding(int i, int i2, int i3, int i4) {
        if (this.padding == null) {
            this.padding = new Padding();
        }
        this.padding.left = i;
        this.padding.top = i2;
        this.padding.right = i3;
        this.padding.bottom = i4;
    }

    public void onPause() {
        if (this.mWebview != null) {
            UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.7
                @Override // java.lang.Runnable
                public void run() {
                    WebviewObject.this.mWebview.onPause();
                }
            });
        }
    }

    public void onResume() {
        if (this.mWebview != null) {
            UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.8
                @Override // java.lang.Runnable
                public void run() {
                    WebviewObject.this.mWebview.onResume();
                }
            });
        }
    }

    public boolean isInitComplete() {
        return this.isInitComplete;
    }

    public void destroy() {
        if (this.mWebview != null) {
            UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.9
                @Override // java.lang.Runnable
                public void run() {
                    if (WebviewObject.globallayout != null) {
                        WebviewObject.globallayout.removeView(WebviewObject.this.mWebview);
                    }
                    if (WebviewObject.this.mWebview != null) {
                        Activity activity = UnityPlayer.currentActivity;
                        WebviewObject.this.mWebview.stopLoading();
                        WebviewObject.this.mWebview.setWebChromeClient(null);
                        WebviewObject.this.mWebview.setWebViewClient(null);
                        activity.unregisterForContextMenu(WebviewObject.this.mWebview);
                        WebviewObject.this.mWebview.clearHistory();
                        WebviewObject.this.mWebview.clearCache(true);
                        WebviewObject.this.mWebview.destroy();
                        WebviewObject.this.mWebview = null;
                    }
                }
            });
        }
    }

    @SuppressLint({"NewApi"})
    public void EvaluateJS(final String str) {
        if (this.mWebview != null) {
            UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.10
                @Override // java.lang.Runnable
                public void run() {
                    if (19 <= Build.VERSION.SDK_INT) {
                        WebviewObject.this.mWebview.evaluateJavascript(str, null);
                        return;
                    }
                    WebviewObject.this.mWebview.loadUrl("javascript:" + str);
                }
            });
        }
    }

    public void SetAppCache(final String str) {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.11
            @Override // java.lang.Runnable
            public void run() {
                WebSettings settings = WebviewObject.this.mWebview.getSettings();
                settings.setAppCachePath(str);
                settings.setAppCacheEnabled(true);
            }
        });
    }

    public void ClearCache() {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.12
            @Override // java.lang.Runnable
            public void run() {
                WebviewObject.this.mWebview.clearCache(true);
            }
        });
    }

    public void SetBackgroundColor(int i) {
        if (this.mWebview != null) {
            this.mWebview.setBackgroundColor(i);
        }
    }

    public void SetTransparent(final boolean z) {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.13
            @Override // java.lang.Runnable
            public void run() {
                if (z) {
                    WebviewObject.this.mWebview.setBackgroundColor(Color.argb(1, 0, 0, 0));
                } else {
                    WebviewObject.this.mWebview.setBackgroundColor(Color.argb(255, 255, 255, 255));
                }
            }
        });
    }

    public void SetBounces(final boolean z) {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.14
            @Override // java.lang.Runnable
            public void run() {
                if (z) {
                    WebviewObject.this.mWebview.setOverScrollMode(0);
                } else {
                    WebviewObject.this.mWebview.setOverScrollMode(2);
                }
            }
        });
    }

    public void StopLoading() {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.15
            @Override // java.lang.Runnable
            public void run() {
                if (WebviewObject.this.mWebview != null) {
                    WebviewObject.this.mWebview.stopLoading();
                }
            }
        });
    }

    public void Reload() {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.16
            @Override // java.lang.Runnable
            public void run() {
                if (WebviewObject.this.mWebview != null) {
                    WebviewObject.this.mWebview.reload();
                }
            }
        });
    }

    public void Invalidate() {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable() { // from class: com.nbsi.nedev.webviewobject.WebviewObject.17
            @Override // java.lang.Runnable
            public void run() {
                if (WebviewObject.this.mWebview != null) {
                    WebviewObject.this.mWebview.invalidate();
                }
            }
        });
    }
}

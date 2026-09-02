package com.nbsi.nedev.webviewobject;

import android.annotation.TargetApi;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Build;
import android.util.Base64;
import android.webkit.HttpAuthHandler;
import android.webkit.MimeTypeMap;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import com.adjust.sdk.Constants;
import com.unity3d.player.UnityPlayer;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class WebviewObjectWebViewClient extends WebViewClient {
    boolean isURLCheck;
    String javascriptInterfaceName;
    NativeInterface nativeInterface;
    WebviewObjectUnityListener unitylistener;
    String errorCheckURL = null;
    Uri errorCheckURI = null;
    HashMap<String, String> schememap = null;
    final String OpenBrowserQuery = "openbrowser=true";
    String authstr = null;
    String authuser = null;
    String authpass = null;

    private WebResourceResponse shouldInterceptRequestProc(String str, HttpURLConnection httpURLConnection) {
        return null;
    }

    public WebviewObjectWebViewClient(WebviewObjectUnityListener webviewObjectUnityListener, boolean z, String str, String str2) {
        this.unitylistener = null;
        this.nativeInterface = null;
        this.javascriptInterfaceName = null;
        this.isURLCheck = false;
        this.unitylistener = webviewObjectUnityListener;
        if (str != null) {
            this.nativeInterface = new NativeInterface(this.unitylistener);
            this.javascriptInterfaceName = str;
        }
        this.isURLCheck = z;
        setURLScheme(str2);
    }

    private void setURLScheme(String str) {
        String[] strArrSplit;
        this.schememap = new HashMap<>();
        if (str == null || (strArrSplit = str.split(";")) == null) {
            return;
        }
        for (String str2 : strArrSplit) {
            String[] strArrSplit2 = str2.split(":");
            if (strArrSplit2 != null && 2 <= strArrSplit2.length) {
                this.schememap.put(strArrSplit2[0], strArrSplit2[1]);
            }
        }
    }

    public void setErrorCheckURL(String str) {
        this.errorCheckURL = str;
        this.errorCheckURI = Uri.parse(str);
    }

    @Override // android.webkit.WebViewClient
    public boolean shouldOverrideUrlLoading(WebView webView, String str) {
        return shouldOverrideUrlCheck(str);
    }

    /* JADX WARN: Code duplicated, block: B:40:0x00a0  */
    public boolean shouldOverrideUrlCheck(String str) {
        String fileExtensionFromUrl;
        Uri uri;
        String query;
        String mimeTypeFromExtension = null;
        try {
            int iIndexOf = str.indexOf("?");
            fileExtensionFromUrl = MimeTypeMap.getFileExtensionFromUrl(URLEncoder.encode(iIndexOf > 0 ? str.substring(0, iIndexOf) : str, Constants.ENCODING));
            if (fileExtensionFromUrl != null) {
                try {
                    mimeTypeFromExtension = MimeTypeMap.getSingleton().getMimeTypeFromExtension(fileExtensionFromUrl);
                } catch (UnsupportedEncodingException unused) {
                }
            }
        } catch (UnsupportedEncodingException unused2) {
            fileExtensionFromUrl = null;
        }
        if (((fileExtensionFromUrl.hashCode() == 110834 && fileExtensionFromUrl.equals("pdf")) ? (byte) 0 : (byte) -1) == 0) {
            Intent intent = new Intent("android.intent.action.VIEW");
            intent.setDataAndType(Uri.parse(str), mimeTypeFromExtension);
            try {
                UnityPlayer.currentActivity.startActivity(intent);
            } catch (ActivityNotFoundException unused3) {
            }
            return true;
        }
        if (str.startsWith("https://play.google.com/store/apps")) {
            Intent intent2 = new Intent("android.intent.action.VIEW");
            intent2.setData(Uri.parse(str));
            intent2.setPackage("com.android.vending");
            UnityPlayer.currentActivity.startActivity(intent2);
            return true;
        }
        String[] strArrSplit = str.split(":");
        if (strArrSplit != null && this.schememap.containsKey(strArrSplit[0])) {
            switch (this.schememap.get(strArrSplit[0])) {
                case "default":
                    switch (strArrSplit[0]) {
                        case "mailto":
                            UnityPlayer.currentActivity.startActivity(new Intent("android.intent.action.SENDTO", Uri.parse(str)));
                            return true;
                        case "browser":
                            UnityPlayer.currentActivity.startActivity(new Intent("android.intent.action.VIEW", Uri.parse(str.substring(strArrSplit[0].length() + 1))));
                            return true;
                        default:
                            UnityPlayer.currentActivity.startActivity(new Intent("android.intent.action.VIEW", Uri.parse(str)));
                            return true;
                    }
                case "app":
                    return this.unitylistener.overrideUrl(strArrSplit[0], str);
            }
        }
        if (strArrSplit != null && ((strArrSplit[0].equals("http") || strArrSplit[0].equals(Constants.SCHEME)) && (uri = Uri.parse(str)) != null && (query = uri.getQuery()) != null && query.contains("openbrowser=true"))) {
            UnityPlayer.currentActivity.startActivity(new Intent("android.intent.action.VIEW", uri));
            return true;
        }
        return false;
    }

    class stringOptRunnable2 implements Runnable {
        String str1;
        String str2;

        @Override // java.lang.Runnable
        public void run() {
        }

        public stringOptRunnable2(String str, String str2) {
            this.str1 = null;
            this.str2 = null;
            this.str1 = str;
            this.str2 = str2;
        }
    }

    @Override // android.webkit.WebViewClient
    @Deprecated
    public WebResourceResponse shouldInterceptRequest(WebView webView, String str) {
        if (!this.isURLCheck) {
            return super.shouldInterceptRequest(webView, str);
        }
        if (this.errorCheckURL == null || !this.errorCheckURL.equals(str)) {
            return null;
        }
        try {
            return shouldInterceptRequestProc(str, (HttpURLConnection) new URL(str).openConnection());
        } catch (Exception unused) {
            return null;
        }
    }

    @Override // android.webkit.WebViewClient
    @TargetApi(21)
    public WebResourceResponse shouldInterceptRequest(WebView webView, WebResourceRequest webResourceRequest) {
        if (!this.isURLCheck) {
            return super.shouldInterceptRequest(webView, webResourceRequest);
        }
        Uri url = webResourceRequest.getUrl();
        if (this.errorCheckURI == null || !this.errorCheckURI.equals(url)) {
            return null;
        }
        try {
            String string = url.toString();
            HttpURLConnection httpURLConnection = (HttpURLConnection) new URL(string).openConnection();
            String method = webResourceRequest.getMethod();
            if (method != null) {
                httpURLConnection.setRequestMethod(method);
                if (Constants.SCHEME.equals(url.getScheme()) && Build.VERSION.SDK_INT > 13 && Build.VERSION.SDK_INT < 19) {
                    httpURLConnection.setRequestProperty("Connection", "close");
                }
            }
            Map<String, String> requestHeaders = webResourceRequest.getRequestHeaders();
            if (requestHeaders != null) {
                for (Map.Entry<String, String> entry : requestHeaders.entrySet()) {
                    httpURLConnection.setRequestProperty(entry.getKey(), entry.getValue());
                }
            }
            return shouldInterceptRequestProc(string, httpURLConnection);
        } catch (Exception unused) {
            return null;
        }
    }

    @Override // android.webkit.WebViewClient
    public void onReceivedHttpAuthRequest(WebView webView, HttpAuthHandler httpAuthHandler, String str, String str2) {
        httpAuthHandler.proceed(this.authuser, this.authpass);
    }

    public String setAuthString(String str) {
        if (str != null) {
            String[] strArrSplit = str.split(":");
            if (strArrSplit.length == 2) {
                this.authstr = "Basic " + Base64.encodeToString(str.getBytes(), 2);
                this.authuser = strArrSplit[0];
                this.authpass = strArrSplit[1];
                return this.authstr;
            }
        }
        this.authstr = null;
        this.authuser = null;
        this.authpass = null;
        return null;
    }

    @Override // android.webkit.WebViewClient
    public void onPageStarted(WebView webView, String str, Bitmap bitmap) {
        if (this.nativeInterface != null) {
            webView.removeJavascriptInterface(this.javascriptInterfaceName);
            webView.addJavascriptInterface(this.nativeInterface, this.javascriptInterfaceName);
        }
        super.onPageStarted(webView, str, bitmap);
        new Thread(new stringOptRunnable(str) { // from class: com.nbsi.nedev.webviewobject.WebviewObjectWebViewClient.1
            @Override // com.nbsi.nedev.webviewobject.WebviewObjectWebViewClient.stringOptRunnable, java.lang.Runnable
            public void run() {
                WebviewObjectWebViewClient.this.unitylistener.onPageStarted(this.str);
            }
        }).start();
    }

    class stringOptRunnable implements Runnable {
        String str;

        @Override // java.lang.Runnable
        public void run() {
        }

        public stringOptRunnable(String str) {
            this.str = null;
            this.str = str;
        }
    }

    @Override // android.webkit.WebViewClient
    public void onPageFinished(WebView webView, String str) {
        super.onPageFinished(webView, str);
        new Thread(new stringOptRunnable(str) { // from class: com.nbsi.nedev.webviewobject.WebviewObjectWebViewClient.2
            @Override // com.nbsi.nedev.webviewobject.WebviewObjectWebViewClient.stringOptRunnable, java.lang.Runnable
            public void run() {
                WebviewObjectWebViewClient.this.unitylistener.onPageFinished(this.str);
            }
        }).start();
    }

    @Override // android.webkit.WebViewClient
    public void onReceivedError(WebView webView, int i, String str, String str2) {
        if (i == 401) {
            super.onReceivedError(webView, i, str, str2);
        } else {
            if (this.errorCheckURL == null || !this.errorCheckURL.equals(str2)) {
                return;
            }
            new Thread(new receivedErrorRunnable1(this, webView, i, str, str2) { // from class: com.nbsi.nedev.webviewobject.WebviewObjectWebViewClient.3
                @Override // com.nbsi.nedev.webviewobject.WebviewObjectWebViewClient.receivedErrorRunnable1, java.lang.Runnable
                public void run() {
                    if (WebviewObjectWebViewClient.this.unitylistener.onReceivedError(this.errorCode, this.description, this.failingUrl)) {
                        return;
                    }
                    this.wbclient.onReceivedErrorSuper(this.view, this.errorCode, this.description, this.failingUrl);
                }
            }).start();
        }
    }

    public void onReceivedErrorSuper(WebView webView, int i, String str, String str2) {
        super.onReceivedError(webView, i, str, str2);
    }

    class receivedErrorRunnable1 implements Runnable {
        String description;
        int errorCode;
        String failingUrl;
        WebView view;
        WebviewObjectWebViewClient wbclient;

        @Override // java.lang.Runnable
        public void run() {
        }

        public receivedErrorRunnable1(WebviewObjectWebViewClient webviewObjectWebViewClient, WebView webView, int i, String str, String str2) {
            this.wbclient = null;
            this.view = null;
            this.errorCode = 0;
            this.description = null;
            this.failingUrl = null;
            this.wbclient = webviewObjectWebViewClient;
            this.view = webView;
            this.errorCode = i;
            this.description = str;
            this.failingUrl = str2;
        }
    }

    @Override // android.webkit.WebViewClient
    @TargetApi(23)
    public void onReceivedError(WebView webView, WebResourceRequest webResourceRequest, WebResourceError webResourceError) {
        new Thread(new receivedErrorRunnable2(this, webView, webResourceRequest, webResourceError) { // from class: com.nbsi.nedev.webviewobject.WebviewObjectWebViewClient.4
            @Override // com.nbsi.nedev.webviewobject.WebviewObjectWebViewClient.receivedErrorRunnable2, java.lang.Runnable
            public void run() {
                boolean zOnReceivedError;
                String string = this.request != null ? this.request.getUrl().toString() : null;
                if (this.error != null) {
                    zOnReceivedError = WebviewObjectWebViewClient.this.unitylistener.onReceivedError(this.error.getErrorCode(), this.error.toString(), string);
                } else {
                    zOnReceivedError = WebviewObjectWebViewClient.this.unitylistener.onReceivedError(-1, null, string);
                }
                if (zOnReceivedError) {
                    return;
                }
                this.wbclient.onReceivedErrorSuper(this.view, this.request, this.error);
            }
        }).start();
    }

    @TargetApi(23)
    public void onReceivedErrorSuper(WebView webView, WebResourceRequest webResourceRequest, WebResourceError webResourceError) {
        super.onReceivedError(webView, webResourceRequest, webResourceError);
    }

    class receivedErrorRunnable2 implements Runnable {
        WebResourceError error;
        WebResourceRequest request;
        WebView view;
        WebviewObjectWebViewClient wbclient;

        @Override // java.lang.Runnable
        public void run() {
        }

        public receivedErrorRunnable2(WebviewObjectWebViewClient webviewObjectWebViewClient, WebView webView, WebResourceRequest webResourceRequest, WebResourceError webResourceError) {
            this.wbclient = null;
            this.view = null;
            this.wbclient = webviewObjectWebViewClient;
            this.view = webView;
            this.request = webResourceRequest;
            this.error = webResourceError;
        }
    }

    @Override // android.webkit.WebViewClient
    @TargetApi(23)
    public void onReceivedHttpError(WebView webView, WebResourceRequest webResourceRequest, WebResourceResponse webResourceResponse) {
        if (webResourceResponse.getStatusCode() == 401) {
            super.onReceivedHttpError(webView, webResourceRequest, webResourceResponse);
        } else {
            new Thread(new receivedHttpErrorRunnable(this, webView, webResourceRequest, webResourceResponse) { // from class: com.nbsi.nedev.webviewobject.WebviewObjectWebViewClient.5
                @Override // com.nbsi.nedev.webviewobject.WebviewObjectWebViewClient.receivedHttpErrorRunnable, java.lang.Runnable
                public void run() {
                    boolean zOnReceivedError;
                    String string = this.request != null ? this.request.getUrl().toString() : null;
                    if (WebviewObjectWebViewClient.this.errorCheckURL == null || !WebviewObjectWebViewClient.this.errorCheckURL.equals(string)) {
                        return;
                    }
                    if (this.errorResponse != null) {
                        zOnReceivedError = WebviewObjectWebViewClient.this.unitylistener.onReceivedError(this.errorResponse.getStatusCode(), this.errorResponse.toString(), string);
                    } else {
                        zOnReceivedError = WebviewObjectWebViewClient.this.unitylistener.onReceivedError(-1, null, string);
                    }
                    if (zOnReceivedError) {
                        return;
                    }
                    this.wbclient.onReceivedHttpErrorSuper(this.view, this.request, this.errorResponse);
                }
            }).start();
        }
    }

    @TargetApi(23)
    public void onReceivedHttpErrorSuper(WebView webView, WebResourceRequest webResourceRequest, WebResourceResponse webResourceResponse) {
        super.onReceivedHttpError(webView, webResourceRequest, webResourceResponse);
    }

    class receivedHttpErrorRunnable implements Runnable {
        WebResourceResponse errorResponse;
        WebResourceRequest request;
        WebView view;
        WebviewObjectWebViewClient wbclient;

        @Override // java.lang.Runnable
        public void run() {
        }

        public receivedHttpErrorRunnable(WebviewObjectWebViewClient webviewObjectWebViewClient, WebView webView, WebResourceRequest webResourceRequest, WebResourceResponse webResourceResponse) {
            this.wbclient = null;
            this.view = null;
            this.wbclient = webviewObjectWebViewClient;
            this.view = webView;
            this.request = webResourceRequest;
            this.errorResponse = webResourceResponse;
        }
    }
}

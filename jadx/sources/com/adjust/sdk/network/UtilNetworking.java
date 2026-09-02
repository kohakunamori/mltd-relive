package com.adjust.sdk.network;

import com.adjust.sdk.AdjustFactory;
import com.adjust.sdk.ILogger;
import java.io.IOException;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class UtilNetworking {
    private static String userAgent;

    public interface IConnectionOptions {
        void applyConnectionOptions(HttpsURLConnection httpsURLConnection, String str);
    }

    public interface IHttpsURLConnectionProvider {
        HttpsURLConnection generateHttpsURLConnection(URL url) throws IOException;
    }

    private static ILogger getLogger() {
        return AdjustFactory.getLogger();
    }

    public static void setUserAgent(String str) {
        userAgent = str;
    }

    public static IConnectionOptions createDefaultConnectionOptions() {
        return new IConnectionOptions() { // from class: com.adjust.sdk.network.UtilNetworking.1
            @Override // com.adjust.sdk.network.UtilNetworking.IConnectionOptions
            public void applyConnectionOptions(HttpsURLConnection httpsURLConnection, String str) {
                httpsURLConnection.setRequestProperty("Client-SDK", str);
                httpsURLConnection.setConnectTimeout(60000);
                httpsURLConnection.setReadTimeout(60000);
                if (UtilNetworking.userAgent != null) {
                    httpsURLConnection.setRequestProperty("User-Agent", UtilNetworking.userAgent);
                }
            }
        };
    }

    public static IHttpsURLConnectionProvider createDefaultHttpsURLConnectionProvider() {
        return new IHttpsURLConnectionProvider() { // from class: com.adjust.sdk.network.UtilNetworking.2
            @Override // com.adjust.sdk.network.UtilNetworking.IHttpsURLConnectionProvider
            public HttpsURLConnection generateHttpsURLConnection(URL url) throws IOException {
                return (HttpsURLConnection) url.openConnection();
            }
        };
    }

    public static String extractJsonString(JSONObject jSONObject, String str) {
        Object objOpt = jSONObject.opt(str);
        if (objOpt instanceof String) {
            return (String) objOpt;
        }
        if (objOpt != null) {
            return objOpt.toString();
        }
        return null;
    }

    public static Long extractJsonLong(JSONObject jSONObject, String str) {
        Object objOpt = jSONObject.opt(str);
        if (objOpt instanceof Long) {
            return (Long) objOpt;
        }
        if (objOpt instanceof Number) {
            return Long.valueOf(((Number) objOpt).longValue());
        }
        if (!(objOpt instanceof String)) {
            return null;
        }
        try {
            return Long.valueOf((long) Double.parseDouble((String) objOpt));
        } catch (NumberFormatException unused) {
            return null;
        }
    }
}

package com.google.firebase.messaging;

import android.annotation.TargetApi;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.graphics.Color;
import android.graphics.drawable.AdaptiveIconDrawable;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.SystemClock;
import android.text.TextUtils;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import androidx.core.content.ContextCompat;
import com.google.android.gms.common.util.PlatformVersion;
import com.google.android.gms.drive.DriveFile;
import com.nbsi.nedev.webviewobject.WebviewObjectSettings;
import java.util.Arrays;
import java.util.Iterator;
import java.util.MissingFormatArgumentException;
import java.util.concurrent.atomic.AtomicInteger;
import javax.annotation.concurrent.GuardedBy;
import org.json.JSONArray;
import org.json.JSONException;

/* JADX INFO: compiled from: com.google.firebase:firebase-messaging@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
public final class zza {
    private static final AtomicInteger zza = new AtomicInteger((int) SystemClock.elapsedRealtime());
    private final Context zzb;
    private final String zzc;

    @GuardedBy("this")
    private Bundle zzd;

    public zza(Context context, String str) {
        this.zzb = context;
        this.zzc = str;
    }

    public final zzc zza(Bundle bundle) {
        Uri defaultUri;
        Intent launchIntentForPackage;
        PendingIntent activity;
        NotificationCompat.Builder builder = new NotificationCompat.Builder(this.zzb, zzc(zza(bundle, "gcm.n.android_channel_id")));
        builder.setAutoCancel(true);
        builder.setContentTitle(zze(bundle));
        String strZzd = zzd(bundle, "gcm.n.body");
        if (!TextUtils.isEmpty(strZzd)) {
            builder.setContentText(strZzd);
            builder.setStyle(new NotificationCompat.BigTextStyle().bigText(strZzd));
        }
        builder.setSmallIcon(zza(zza(bundle, "gcm.n.icon")));
        String strZzc = zzc(bundle);
        PendingIntent pendingIntentZza = null;
        if (TextUtils.isEmpty(strZzc)) {
            defaultUri = null;
        } else if (!WebviewObjectSettings.URLSCHEME_TYPE_PLUGUIN_DEFAULT.equals(strZzc) && this.zzb.getResources().getIdentifier(strZzc, "raw", this.zzc) != 0) {
            String str = this.zzc;
            StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 24 + String.valueOf(strZzc).length());
            sb.append("android.resource://");
            sb.append(str);
            sb.append("/raw/");
            sb.append(strZzc);
            defaultUri = Uri.parse(sb.toString());
        } else {
            defaultUri = RingtoneManager.getDefaultUri(2);
        }
        if (defaultUri != null) {
            builder.setSound(defaultUri);
        }
        String strZza = zza(bundle, "gcm.n.click_action");
        if (!TextUtils.isEmpty(strZza)) {
            launchIntentForPackage = new Intent(strZza);
            launchIntentForPackage.setPackage(this.zzc);
            launchIntentForPackage.setFlags(DriveFile.MODE_READ_ONLY);
        } else {
            Uri uriZzd = zzd(bundle);
            if (uriZzd != null) {
                launchIntentForPackage = new Intent("android.intent.action.VIEW");
                launchIntentForPackage.setPackage(this.zzc);
                launchIntentForPackage.setData(uriZzd);
            } else {
                launchIntentForPackage = this.zzb.getPackageManager().getLaunchIntentForPackage(this.zzc);
                if (launchIntentForPackage == null) {
                    Log.w("FirebaseMessaging", "No activity found to launch app");
                }
            }
        }
        if (launchIntentForPackage == null) {
            activity = null;
        } else {
            launchIntentForPackage.addFlags(67108864);
            Bundle bundle2 = new Bundle(bundle);
            Iterator<String> it = bundle2.keySet().iterator();
            while (it.hasNext()) {
                String next = it.next();
                if (next != null && next.startsWith("google.c.")) {
                    it.remove();
                }
            }
            launchIntentForPackage.putExtras(bundle2);
            for (String str2 : bundle2.keySet()) {
                if (str2.startsWith("gcm.n.") || str2.startsWith("gcm.notification.")) {
                    launchIntentForPackage.removeExtra(str2);
                }
            }
            activity = PendingIntent.getActivity(this.zzb, zza.incrementAndGet(), launchIntentForPackage, 1073741824);
            if (zzf(bundle)) {
                Intent intent = new Intent("com.google.firebase.messaging.NOTIFICATION_OPEN");
                zza(intent, bundle);
                intent.putExtra("pending_intent", activity);
                activity = zza(zza.incrementAndGet(), intent);
            }
        }
        builder.setContentIntent(activity);
        if (zzf(bundle)) {
            Intent intent2 = new Intent("com.google.firebase.messaging.NOTIFICATION_DISMISS");
            zza(intent2, bundle);
            pendingIntentZza = zza(zza.incrementAndGet(), intent2);
        }
        if (pendingIntentZza != null) {
            builder.setDeleteIntent(pendingIntentZza);
        }
        Integer numZzb = zzb(zza(bundle, "gcm.n.color"));
        if (numZzb != null) {
            builder.setColor(numZzb.intValue());
        }
        String strZza2 = zza(bundle, "gcm.n.tag");
        if (TextUtils.isEmpty(strZza2)) {
            long jUptimeMillis = SystemClock.uptimeMillis();
            StringBuilder sb2 = new StringBuilder(37);
            sb2.append("FCM-Notification:");
            sb2.append(jUptimeMillis);
            strZza2 = sb2.toString();
        }
        return new zzc(builder, strZza2, 0);
    }

    @NonNull
    private final CharSequence zze(Bundle bundle) {
        String strZzd = zzd(bundle, "gcm.n.title");
        if (!TextUtils.isEmpty(strZzd)) {
            return strZzd;
        }
        try {
            return zzb(0).loadLabel(this.zzb.getPackageManager());
        } catch (PackageManager.NameNotFoundException e) {
            String strValueOf = String.valueOf(e);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 35);
            sb.append("Couldn't get own application info: ");
            sb.append(strValueOf);
            Log.e("FirebaseMessaging", sb.toString());
            return "";
        }
    }

    public static boolean zzb(Bundle bundle) {
        return "1".equals(zza(bundle, "gcm.n.e")) || zza(bundle, "gcm.n.icon") != null;
    }

    public static String zza(Bundle bundle, String str) {
        String string = bundle.getString(str);
        return string == null ? bundle.getString(str.replace("gcm.n.", "gcm.notification.")) : string;
    }

    /* JADX WARN: Multi-variable type inference failed */
    public static Object[] zzb(Bundle bundle, String str) {
        String strValueOf = String.valueOf(str);
        String strValueOf2 = String.valueOf("_loc_args");
        String strZza = zza(bundle, strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf));
        if (TextUtils.isEmpty(strZza)) {
            return null;
        }
        try {
            JSONArray jSONArray = new JSONArray(strZza);
            String[] strArr = new String[jSONArray.length()];
            for (int i = 0; i < strArr.length; i++) {
                strArr[i] = jSONArray.opt(i);
            }
            return strArr;
        } catch (JSONException unused) {
            String strValueOf3 = String.valueOf(str);
            String strValueOf4 = String.valueOf("_loc_args");
            String strSubstring = (strValueOf4.length() != 0 ? strValueOf3.concat(strValueOf4) : new String(strValueOf3)).substring(6);
            StringBuilder sb = new StringBuilder(String.valueOf(strSubstring).length() + 41 + String.valueOf(strZza).length());
            sb.append("Malformed ");
            sb.append(strSubstring);
            sb.append(": ");
            sb.append(strZza);
            sb.append("  Default value will be used.");
            Log.w("FirebaseMessaging", sb.toString());
            return null;
        }
    }

    private final String zzd(Bundle bundle, String str) {
        String strZza = zza(bundle, str);
        return !TextUtils.isEmpty(strZza) ? strZza : zze(bundle, str);
    }

    public static String zzc(Bundle bundle, String str) {
        String strValueOf = String.valueOf(str);
        String strValueOf2 = String.valueOf("_loc_key");
        return zza(bundle, strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf));
    }

    private final String zze(Bundle bundle, String str) {
        String strZzc = zzc(bundle, str);
        if (TextUtils.isEmpty(strZzc)) {
            return null;
        }
        Resources resources = this.zzb.getResources();
        int identifier = resources.getIdentifier(strZzc, "string", this.zzc);
        if (identifier == 0) {
            String strValueOf = String.valueOf(str);
            String strValueOf2 = String.valueOf("_loc_key");
            String strSubstring = (strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf)).substring(6);
            StringBuilder sb = new StringBuilder(String.valueOf(strSubstring).length() + 49 + String.valueOf(str).length());
            sb.append(strSubstring);
            sb.append(" resource not found: ");
            sb.append(str);
            sb.append(" Default value will be used.");
            Log.w("FirebaseMessaging", sb.toString());
            return null;
        }
        Object[] objArrZzb = zzb(bundle, str);
        if (objArrZzb == null) {
            return resources.getString(identifier);
        }
        try {
            return resources.getString(identifier, objArrZzb);
        } catch (MissingFormatArgumentException e) {
            String string = Arrays.toString(objArrZzb);
            StringBuilder sb2 = new StringBuilder(String.valueOf(str).length() + 58 + String.valueOf(string).length());
            sb2.append("Missing format argument for ");
            sb2.append(str);
            sb2.append(": ");
            sb2.append(string);
            sb2.append(" Default value will be used.");
            Log.w("FirebaseMessaging", sb2.toString(), e);
            return null;
        }
    }

    @TargetApi(26)
    private final boolean zza(int i) {
        if (Build.VERSION.SDK_INT != 26) {
            return true;
        }
        try {
            if (!(this.zzb.getResources().getDrawable(i, null) instanceof AdaptiveIconDrawable)) {
                return true;
            }
            StringBuilder sb = new StringBuilder(77);
            sb.append("Adaptive icons cannot be used in notifications. Ignoring icon id: ");
            sb.append(i);
            Log.e("FirebaseMessaging", sb.toString());
            return false;
        } catch (Resources.NotFoundException unused) {
            StringBuilder sb2 = new StringBuilder(66);
            sb2.append("Couldn't find resource ");
            sb2.append(i);
            sb2.append(", treating it as an invalid icon");
            Log.e("FirebaseMessaging", sb2.toString());
            return false;
        }
    }

    private final int zza(String str) {
        if (!TextUtils.isEmpty(str)) {
            Resources resources = this.zzb.getResources();
            int identifier = resources.getIdentifier(str, "drawable", this.zzc);
            if (identifier != 0 && zza(identifier)) {
                return identifier;
            }
            int identifier2 = resources.getIdentifier(str, "mipmap", this.zzc);
            if (identifier2 != 0 && zza(identifier2)) {
                return identifier2;
            }
            StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 61);
            sb.append("Icon resource ");
            sb.append(str);
            sb.append(" not found. Notification will use default icon.");
            Log.w("FirebaseMessaging", sb.toString());
        }
        int i = zza().getInt("com.google.firebase.messaging.default_notification_icon", 0);
        if (i == 0 || !zza(i)) {
            try {
                i = zzb(0).icon;
            } catch (PackageManager.NameNotFoundException e) {
                String strValueOf = String.valueOf(e);
                StringBuilder sb2 = new StringBuilder(String.valueOf(strValueOf).length() + 35);
                sb2.append("Couldn't get own application info: ");
                sb2.append(strValueOf);
                Log.w("FirebaseMessaging", sb2.toString());
            }
        }
        return (i == 0 || !zza(i)) ? android.R.drawable.sym_def_app_icon : i;
    }

    private final Integer zzb(String str) {
        if (Build.VERSION.SDK_INT < 21) {
            return null;
        }
        if (!TextUtils.isEmpty(str)) {
            try {
                return Integer.valueOf(Color.parseColor(str));
            } catch (IllegalArgumentException unused) {
                StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 54);
                sb.append("Color ");
                sb.append(str);
                sb.append(" not valid. Notification will use default color.");
                Log.w("FirebaseMessaging", sb.toString());
            }
        }
        int i = zza().getInt("com.google.firebase.messaging.default_notification_color", 0);
        if (i != 0) {
            try {
                return Integer.valueOf(ContextCompat.getColor(this.zzb, i));
            } catch (Resources.NotFoundException unused2) {
                Log.w("FirebaseMessaging", "Cannot find the color resource referenced in AndroidManifest.");
            }
        }
        return null;
    }

    public static String zzc(Bundle bundle) {
        String strZza = zza(bundle, "gcm.n.sound2");
        return TextUtils.isEmpty(strZza) ? zza(bundle, "gcm.n.sound") : strZza;
    }

    @Nullable
    static Uri zzd(@NonNull Bundle bundle) {
        String strZza = zza(bundle, "gcm.n.link_android");
        if (TextUtils.isEmpty(strZza)) {
            strZza = zza(bundle, "gcm.n.link");
        }
        if (TextUtils.isEmpty(strZza)) {
            return null;
        }
        return Uri.parse(strZza);
    }

    private final synchronized Bundle zza() {
        if (this.zzd != null) {
            return this.zzd;
        }
        try {
            ApplicationInfo applicationInfoZzb = zzb(128);
            if (applicationInfoZzb != null && applicationInfoZzb.metaData != null) {
                this.zzd = applicationInfoZzb.metaData;
                return this.zzd;
            }
        } catch (PackageManager.NameNotFoundException e) {
            String strValueOf = String.valueOf(e);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 35);
            sb.append("Couldn't get own application info: ");
            sb.append(strValueOf);
            Log.w("FirebaseMessaging", sb.toString());
        }
        return Bundle.EMPTY;
    }

    @TargetApi(26)
    private final String zzc(String str) {
        if (!PlatformVersion.isAtLeastO()) {
            return null;
        }
        int i = 0;
        try {
            i = zzb(0).targetSdkVersion;
        } catch (PackageManager.NameNotFoundException unused) {
        }
        if (i < 26) {
            return null;
        }
        NotificationManager notificationManager = (NotificationManager) this.zzb.getSystemService(NotificationManager.class);
        if (!TextUtils.isEmpty(str)) {
            if (notificationManager.getNotificationChannel(str) != null) {
                return str;
            }
            StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 122);
            sb.append("Notification Channel requested (");
            sb.append(str);
            sb.append(") has not been created by the app. Manifest configuration, or default, value will be used.");
            Log.w("FirebaseMessaging", sb.toString());
        }
        String string = zza().getString("com.google.firebase.messaging.default_notification_channel_id");
        if (!TextUtils.isEmpty(string)) {
            if (notificationManager.getNotificationChannel(string) != null) {
                return string;
            }
            Log.w("FirebaseMessaging", "Notification Channel set in AndroidManifest.xml has not been created by the app. Default value will be used.");
        } else {
            Log.w("FirebaseMessaging", "Missing Default Notification Channel metadata in AndroidManifest. Default value will be used.");
        }
        if (notificationManager.getNotificationChannel("fcm_fallback_notification_channel") != null) {
            return "fcm_fallback_notification_channel";
        }
        notificationManager.createNotificationChannel(new NotificationChannel("fcm_fallback_notification_channel", this.zzb.getString(this.zzb.getResources().getIdentifier("fcm_fallback_notification_channel_label", "string", this.zzc)), 3));
        return "fcm_fallback_notification_channel";
    }

    private final ApplicationInfo zzb(int i) throws PackageManager.NameNotFoundException {
        return this.zzb.getPackageManager().getApplicationInfo(this.zzc, i);
    }

    private static void zza(Intent intent, Bundle bundle) {
        for (String str : bundle.keySet()) {
            if (str.startsWith("google.c.a.") || str.equals("from")) {
                intent.putExtra(str, bundle.getString(str));
            }
        }
    }

    private final PendingIntent zza(int i, Intent intent) {
        return PendingIntent.getBroadcast(this.zzb, i, new Intent("com.google.firebase.MESSAGING_EVENT").setComponent(new ComponentName(this.zzb, "com.google.firebase.iid.FirebaseInstanceIdReceiver")).putExtra("wrapped_intent", intent), 1073741824);
    }

    private static boolean zzf(Bundle bundle) {
        return bundle != null && "1".equals(bundle.getString("google.c.a.e"));
    }
}

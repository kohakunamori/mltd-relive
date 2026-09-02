package com.adjust.sdk;

import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import java.util.concurrent.atomic.AtomicBoolean;

/* JADX INFO: loaded from: classes.dex */
public class InstallReferrerHuawei {
    private static final String REFERRER_PROVIDER_AUTHORITY = "com.huawei.appmarket.commondata";
    private static final String REFERRER_PROVIDER_URI = "content://com.huawei.appmarket.commondata/item/5";
    private Context context;
    private final InstallReferrerReadListener referrerCallback;
    private ILogger logger = AdjustFactory.getLogger();
    private final AtomicBoolean shouldTryToRead = new AtomicBoolean(true);

    public InstallReferrerHuawei(Context context, InstallReferrerReadListener installReferrerReadListener) {
        this.context = context;
        this.referrerCallback = installReferrerReadListener;
    }

    /* JADX WARN: Code duplicated, block: B:20:0x007e A[Catch: all -> 0x0079, Exception -> 0x007b, TRY_LEAVE, TryCatch #4 {Exception -> 0x007b, all -> 0x0079, blocks: (B:13:0x0043, B:15:0x0049, B:20:0x007e), top: B:37:0x0043 }] */
    /* JADX WARN: Code duplicated, block: B:22:0x0097  */
    public void readReferrer() {
        Cursor cursorQuery;
        if (!this.shouldTryToRead.get()) {
            this.logger.debug("Should not try to read Install referrer Huawei", new Object[0]);
            return;
        }
        if (!Util.resolveContentProvider(this.context, REFERRER_PROVIDER_AUTHORITY)) {
            return;
        }
        Cursor cursor = null;
        Uri uri = Uri.parse(REFERRER_PROVIDER_URI);
        try {
            try {
                cursorQuery = this.context.getContentResolver().query(uri, null, null, new String[]{this.context.getPackageName()}, null);
                if (cursorQuery != null) {
                    try {
                        if (cursorQuery.moveToFirst()) {
                            String string = cursorQuery.getString(0);
                            String string2 = cursorQuery.getString(1);
                            String string3 = cursorQuery.getString(2);
                            this.logger.debug("InstallReferrerHuawei reads referrer[%s] clickTime[%s] installTime[%s]", string, string2, string3);
                            this.referrerCallback.onInstallReferrerRead(new ReferrerDetails(string, Long.parseLong(string2), Long.parseLong(string3)));
                        } else {
                            this.logger.debug("InstallReferrerHuawei fail to read referrer for package [%s] and content uri [%s]", this.context.getPackageName(), uri.toString());
                        }
                        if (cursorQuery != null) {
                            cursorQuery.close();
                        }
                    } catch (Exception e) {
                        e = e;
                        cursor = cursorQuery;
                        this.logger.debug("InstallReferrerHuawei error [%s]", e.getMessage());
                        if (cursor != null) {
                            cursor.close();
                        }
                    } catch (Throwable th) {
                        th = th;
                        if (cursorQuery != null) {
                            cursorQuery.close();
                        }
                        throw th;
                    }
                } else {
                    this.logger.debug("InstallReferrerHuawei fail to read referrer for package [%s] and content uri [%s]", this.context.getPackageName(), uri.toString());
                    if (cursorQuery != null) {
                        cursorQuery.close();
                    }
                }
            } catch (Exception e2) {
                e = e2;
            }
            this.shouldTryToRead.set(false);
        } catch (Throwable th2) {
            th = th2;
            cursorQuery = cursor;
        }
    }
}

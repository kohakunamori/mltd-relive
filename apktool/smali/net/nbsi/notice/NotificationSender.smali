.class public Lnet/nbsi/notice/NotificationSender;
.super Ljava/lang/Object;
.source "NotificationSender.java"


# static fields
.field private static final DEFAULT_NOTIFICATION_ID:I = 0x1

.field private static final TAG:Ljava/lang/String; = "NotificationBuilder"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static GetString(Landroid/content/Context;Landroid/os/Bundle;Landroid/content/res/Resources;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 152
    invoke-virtual {p1, p3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_0

    .line 154
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "bnsi_notification_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    const-string v0, "string"

    .line 155
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p2, p3, v0, p0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    if-eqz p0, :cond_0

    .line 157
    invoke-virtual {p2, p0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    :cond_0
    return-object p1
.end method

.method public static SendNotification(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 20

    move-object/from16 v1, p0

    .line 51
    invoke-virtual/range {p1 .. p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    .line 52
    invoke-virtual {v0}, Landroid/os/Bundle;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    .line 53
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const-string v4, "message"

    .line 54
    invoke-static {v1, v0, v2, v4}, Lnet/nbsi/notice/NotificationSender;->GetString(Landroid/content/Context;Landroid/os/Bundle;Landroid/content/res/Resources;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "title"

    .line 55
    invoke-static {v1, v0, v2, v5}, Lnet/nbsi/notice/NotificationSender;->GetString(Landroid/content/Context;Landroid/os/Bundle;Landroid/content/res/Resources;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "subtitle"

    .line 56
    invoke-static {v1, v0, v2, v6}, Lnet/nbsi/notice/NotificationSender;->GetString(Landroid/content/Context;Landroid/os/Bundle;Landroid/content/res/Resources;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "tickerText"

    .line 57
    invoke-static {v1, v0, v2, v7}, Lnet/nbsi/notice/NotificationSender;->GetString(Landroid/content/Context;Landroid/os/Bundle;Landroid/content/res/Resources;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "vibrate"

    .line 58
    invoke-static {v1, v0, v2, v8}, Lnet/nbsi/notice/NotificationSender;->GetString(Landroid/content/Context;Landroid/os/Bundle;Landroid/content/res/Resources;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v9, "lights"

    .line 59
    invoke-static {v1, v0, v2, v9}, Lnet/nbsi/notice/NotificationSender;->GetString(Landroid/content/Context;Landroid/os/Bundle;Landroid/content/res/Resources;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const-string v10, "sound"

    .line 60
    invoke-static {v1, v0, v2, v10}, Lnet/nbsi/notice/NotificationSender;->GetString(Landroid/content/Context;Landroid/os/Bundle;Landroid/content/res/Resources;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    const-string v11, "smallIcon"

    .line 61
    invoke-static {v1, v0, v2, v11}, Lnet/nbsi/notice/NotificationSender;->GetString(Landroid/content/Context;Landroid/os/Bundle;Landroid/content/res/Resources;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    const-string v12, "largeIcon"

    .line 62
    invoke-static {v1, v0, v2, v12}, Lnet/nbsi/notice/NotificationSender;->GetString(Landroid/content/Context;Landroid/os/Bundle;Landroid/content/res/Resources;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    const-string v13, "notificationid"

    .line 63
    invoke-static {v1, v0, v2, v13}, Lnet/nbsi/notice/NotificationSender;->GetString(Landroid/content/Context;Landroid/os/Bundle;Landroid/content/res/Resources;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    :goto_0
    const-string v2, "NotificationBuilder"

    const-string v13, "SendNotification() "

    .line 66
    invoke-static {v2, v13}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v11, :cond_1

    const-string v11, "app_icon"

    :cond_1
    if-nez v5, :cond_2

    const-string v5, "No Title"

    :cond_2
    if-nez v4, :cond_3

    const-string v4, "No Message"

    :cond_3
    const/4 v2, 0x1

    if-eqz v0, :cond_4

    .line 77
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    move v13, v0

    goto :goto_1

    :cond_4
    const/4 v13, 0x1

    :goto_1
    const-string v0, "notification"

    .line 80
    invoke-virtual {v1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    move-object v14, v0

    check-cast v14, Landroid/app/NotificationManager;

    .line 83
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v15

    .line 86
    :try_start_0
    invoke-virtual {v15}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {v15}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    const-string v3, "NotificationBuilder"

    .line 87
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_4

    move/from16 v17, v13

    :try_start_1
    const-string v13, "Start Activity Class: "

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v13, v0, Landroid/content/pm/PackageInfo;->activities:[Landroid/content/pm/ActivityInfo;

    const/16 v16, 0x0

    aget-object v13, v13, v16

    iget-object v13, v13, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_1} :catch_3

    .line 89
    :try_start_2
    iget-object v0, v0, Landroid/content/pm/PackageInfo;->activities:[Landroid/content/pm/ActivityInfo;

    const/4 v2, 0x0

    aget-object v0, v0, v2

    iget-object v0, v0, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3
    :try_end_2
    .catch Ljava/lang/ClassNotFoundException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_2 .. :try_end_2} :catch_3

    :try_start_3
    const-string v0, "NotificationBuilder"

    .line 90
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "Class = "

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/Class;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catch Ljava/lang/ClassNotFoundException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_5

    :catch_0
    move-exception v0

    goto :goto_2

    :catch_1
    move-exception v0

    const/4 v3, 0x0

    .line 92
    :goto_2
    :try_start_4
    invoke-virtual {v0}, Ljava/lang/ClassNotFoundException;->printStackTrace()V
    :try_end_4
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_5

    :catch_2
    move-exception v0

    goto :goto_4

    :catch_3
    move-exception v0

    goto :goto_3

    :catch_4
    move-exception v0

    move/from16 v17, v13

    :goto_3
    const/4 v3, 0x0

    .line 95
    :goto_4
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    :goto_5
    if-nez v3, :cond_5

    .line 100
    new-instance v0, Landroid/content/Intent;

    const-class v2, Lcom/unity3d/player/UnityPlayerNativeActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/4 v2, 0x0

    invoke-static {v1, v2, v0, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    goto :goto_6

    :cond_5
    const/4 v2, 0x0

    .line 103
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0, v1, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-static {v1, v2, v0, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    .line 107
    :goto_6
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const-string v13, "drawable"

    .line 108
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v11, v13, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    const-string v11, "NotificationBuilder"

    .line 112
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v19, v7

    const-string v7, "packageName:"

    invoke-virtual {v13, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v13, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v11, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v12, :cond_6

    const-string v7, "drawable"

    .line 114
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v3, v12, v7, v11}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    .line 115
    invoke-static {v3, v15}, Lnet/nbsi/notice/NotificationSender;->getDrawableResource(ILandroid/content/Context;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    .line 116
    check-cast v3, Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {v3}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object v3

    goto :goto_7

    :cond_6
    const/4 v3, 0x0

    :goto_7
    if-eqz v10, :cond_7

    const-string v7, "0"

    .line 120
    invoke-virtual {v10, v7}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v7

    if-eqz v7, :cond_7

    const/16 v18, 0x1

    goto :goto_8

    :cond_7
    const/16 v18, 0x0

    :goto_8
    if-eqz v8, :cond_8

    const-string v7, "0"

    .line 122
    invoke-virtual {v8, v7}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v7

    if-eqz v7, :cond_8

    or-int/lit8 v18, v18, 0x2

    :cond_8
    if-eqz v9, :cond_9

    const-string v7, "0"

    .line 124
    invoke-virtual {v9, v7}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v7

    if-eqz v7, :cond_9

    or-int/lit8 v18, v18, 0x4

    :cond_9
    move/from16 v7, v18

    const-string v8, "default"

    .line 128
    sget v9, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v10, 0x1a

    if-lt v9, v10, :cond_a

    .line 129
    new-instance v9, Landroid/app/NotificationChannel;

    const-string v10, "\u30ed\u30fc\u30ab\u30eb\u901a\u77e5"

    const/4 v11, 0x3

    invoke-direct {v9, v8, v10, v11}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 132
    invoke-virtual {v14, v9}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    const-string v9, "NotificationBuilder"

    const-string v10, "Create notificaion channel "

    .line 133
    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 135
    :cond_a
    new-instance v9, Landroidx/core/app/NotificationCompat$Builder;

    invoke-direct {v9, v1, v8}, Landroidx/core/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 137
    invoke-virtual {v9, v0}, Landroidx/core/app/NotificationCompat$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 138
    invoke-virtual {v0, v2}, Landroidx/core/app/NotificationCompat$Builder;->setSmallIcon(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 139
    invoke-virtual {v0, v3}, Landroidx/core/app/NotificationCompat$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 140
    invoke-virtual {v0, v5}, Landroidx/core/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 141
    invoke-virtual {v0, v6}, Landroidx/core/app/NotificationCompat$Builder;->setSubText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    new-instance v1, Landroidx/core/app/NotificationCompat$BigTextStyle;

    invoke-direct {v1}, Landroidx/core/app/NotificationCompat$BigTextStyle;-><init>()V

    .line 142
    invoke-virtual {v1, v4}, Landroidx/core/app/NotificationCompat$BigTextStyle;->bigText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$BigTextStyle;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationCompat$Builder;->setStyle(Landroidx/core/app/NotificationCompat$Style;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 143
    invoke-virtual {v0, v4}, Landroidx/core/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 144
    invoke-virtual {v0, v7}, Landroidx/core/app/NotificationCompat$Builder;->setDefaults(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    move-object/from16 v3, v19

    .line 145
    invoke-virtual {v0, v3}, Landroidx/core/app/NotificationCompat$Builder;->setTicker(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    const/4 v1, 0x1

    .line 146
    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationCompat$Builder;->setAutoCancel(Z)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 148
    invoke-virtual {v0}, Landroidx/core/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    move/from16 v2, v17

    invoke-virtual {v14, v2, v0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    return-void
.end method

.method public static getDrawableResource(ILandroid/content/Context;)Landroid/graphics/drawable/Drawable;
    .locals 2

    .line 28
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x15

    if-lt v0, v1, :cond_0

    const-string v0, "NotificationBuilder"

    const-string v1, "lollipop getDrawable"

    .line 29
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 30
    invoke-virtual {p1, p0}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    goto :goto_0

    :cond_0
    const-string v0, "NotificationBuilder"

    const-string v1, "NOT lollipop getDrawable"

    .line 32
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 33
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    :goto_0
    return-object p0
.end method

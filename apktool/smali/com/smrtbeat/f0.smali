.class Lcom/smrtbeat/f0;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "CommitPrefEdits"
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/smrtbeat/f0$e;
    }
.end annotation


# static fields
.field static final a:Ljava/lang/String; = "no permission"

.field private static final b:Ljava/lang/String; = "unknown"

.field private static final c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final d:Ljava/lang/String; = "com.smrtbeat.pref1"

.field private static final e:Ljava/lang/String; = "com.smrtbeat.pref3"

.field private static final f:Ljava/lang/String; = "com.smrtbeat.pref4"

.field private static final g:Ljava/lang/String; = "com.smrtbeat.pref5"

.field private static final h:Ljava/lang/String; = "com.smrtbeat.pref6"

.field private static final i:J = 0x5265c00L


# direct methods
.method static constructor <clinit>()V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/f0;->o()Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/f0;->c:Ljava/util/List;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static a(Landroid/content/SharedPreferences;)J
    .locals 3

    const-string v0, "com.smrtbeat.pref6"

    const-wide/16 v1, 0x0

    invoke-static {p0, v0, v1, v2}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences;Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method

.method private static a(Landroid/content/SharedPreferences;Ljava/lang/String;J)J
    .locals 2

    :try_start_0
    invoke-interface {p0, p1, p2, p3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v0

    :catch_0
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0, p1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-static {p0}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences$Editor;)V

    return-wide p2
.end method

.method static a(I)Ljava/lang/String;
    .locals 3

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x0

    const/16 v2, 0x15

    if-lt v0, v2, :cond_1

    invoke-static {}, Lcom/smrtbeat/w;->a()[Ljava/lang/String;

    move-result-object v0

    array-length v2, v0

    if-gt v2, p0, :cond_0

    return-object v1

    :cond_0
    aget-object p0, v0, p0

    return-object p0

    :cond_1
    if-eqz p0, :cond_3

    const/4 v0, 0x1

    if-eq p0, v0, :cond_2

    return-object v1

    :cond_2
    invoke-static {}, Lcom/smrtbeat/a0;->b()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_3
    invoke-static {}, Lcom/smrtbeat/a0;->a()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static a(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    const-string v0, "unknown"

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object p0

    const-string v1, "android.os.SystemProperties"

    invoke-virtual {p0, v1}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p0

    const/4 v1, 0x1

    new-array v2, v1, [Ljava/lang/Class;

    const-class v3, Ljava/lang/String;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const-string v3, "get"

    invoke-virtual {p0, v3, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    new-array v1, v1, [Ljava/lang/Object;

    new-instance v3, Ljava/lang/String;

    invoke-direct {v3, p1}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    aput-object v3, v1, v4

    invoke-virtual {v2, p0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-object p0, v0

    :goto_0
    return-object p0
.end method

.method static a(Ljava/io/File;)Ljava/lang/String;
    .locals 4

    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v1

    add-int/lit8 v2, v1, -0x1

    const-string v3, "."

    invoke-virtual {v0, v3, v2}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;I)I

    move-result v2

    if-ltz v1, :cond_0

    if-ltz v2, :cond_0

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static a(Ljava/net/HttpURLConnection;)Ljava/lang/String;
    .locals 7

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x1

    :try_start_0
    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    :try_start_1
    new-instance v3, Ljava/io/InputStreamReader;

    const-string v4, "UTF-8"

    invoke-direct {v3, p0, v4}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    new-instance v4, Ljava/io/BufferedReader;

    const/16 v5, 0x400

    invoke-direct {v4, v3, v5}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    :goto_0
    invoke-virtual {v4}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "\n"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    invoke-virtual {v4}, Ljava/io/BufferedReader;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_1

    :catch_0
    move-exception p0

    sget-object v3, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object p0

    aput-object p0, v2, v1

    const-string p0, "readResponse :%s"

    invoke-static {p0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-static {v3, p0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :goto_1
    return-object v0

    :catchall_0
    move-exception v0

    move-object v3, v0

    move-object v0, v4

    goto :goto_4

    :catch_1
    move-exception v0

    move-object v3, v0

    move-object v0, v4

    goto :goto_2

    :catchall_1
    move-exception v3

    goto :goto_4

    :catch_2
    move-exception v3

    goto :goto_2

    :catchall_2
    move-exception p0

    move-object v3, p0

    move-object p0, v0

    goto :goto_4

    :catch_3
    move-exception p0

    move-object v3, p0

    move-object p0, v0

    :goto_2
    :try_start_4
    sget-object v4, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    const-string v5, "readResponse :%s"

    :try_start_5
    new-array v6, v2, [Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v6, v1

    invoke-static {v5, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v4, v3}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :try_start_6
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_4

    goto :goto_3

    :catch_4
    move-exception p0

    sget-object v0, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object p0

    aput-object p0, v2, v1

    const-string p0, "readResponse :%s"

    invoke-static {p0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-static {v0, p0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :cond_1
    :goto_3
    const-string p0, ""

    return-object p0

    :goto_4
    :try_start_7
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_5

    goto :goto_5

    :catch_5
    move-exception p0

    sget-object v0, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object p0

    aput-object p0, v2, v1

    const-string p0, "readResponse :%s"

    invoke-static {p0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-static {v0, p0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :cond_2
    :goto_5
    throw v3
.end method

.method static a(Landroid/app/Activity;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/smrtbeat/f0;->a(Landroid/app/Activity;Z)V

    return-void
.end method

.method private static declared-synchronized a(Landroid/app/Activity;Z)V
    .locals 3

    const-class v0, Lcom/smrtbeat/f0;

    monitor-enter v0

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    if-eqz p1, :cond_0

    sput-object v1, Lcom/smrtbeat/j;->U:Ljava/lang/String;

    invoke-static {}, Lcom/smrtbeat/f0;->r()V

    goto :goto_0

    :cond_0
    sget-object v2, Lcom/smrtbeat/j;->U:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, ""

    sput-object v1, Lcom/smrtbeat/j;->U:Ljava/lang/String;

    :cond_1
    :goto_0
    invoke-static {}, Lcom/smrtbeat/f0;->h()Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_2

    monitor-exit v0

    return-void

    :cond_2
    :try_start_1
    sget-object v1, Lcom/smrtbeat/j;->O:Lcom/smrtbeat/g;

    if-eqz v1, :cond_3

    sget-object v1, Lcom/smrtbeat/j;->P:Ljava/lang/Thread;

    if-eqz v1, :cond_3

    invoke-virtual {v1}, Ljava/lang/Thread;->getState()Ljava/lang/Thread$State;

    move-result-object v1

    sget-object v2, Ljava/lang/Thread$State;->TERMINATED:Ljava/lang/Thread$State;

    if-ne v1, v2, :cond_4

    :cond_3
    new-instance v1, Lcom/smrtbeat/g;

    invoke-direct {v1}, Lcom/smrtbeat/g;-><init>()V

    sput-object v1, Lcom/smrtbeat/j;->O:Lcom/smrtbeat/g;

    new-instance v1, Ljava/lang/Thread;

    sget-object v2, Lcom/smrtbeat/j;->O:Lcom/smrtbeat/g;

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    sput-object v1, Lcom/smrtbeat/j;->P:Ljava/lang/Thread;

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    :cond_4
    if-eqz p1, :cond_5

    sget-object p1, Lcom/smrtbeat/j;->O:Lcom/smrtbeat/g;

    invoke-virtual {p1, p0}, Lcom/smrtbeat/g;->b(Landroid/app/Activity;)V

    goto :goto_1

    :cond_5
    sget-object p1, Lcom/smrtbeat/j;->O:Lcom/smrtbeat/g;

    invoke-virtual {p1, p0}, Lcom/smrtbeat/g;->a(Landroid/app/Activity;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_1
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method static a(Landroid/app/Application;)V
    .locals 3

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    sget-object v1, Lcom/smrtbeat/f0;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Landroid/app/Application;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    new-instance v1, Lcom/smrtbeat/f0$b;

    invoke-direct {v1}, Lcom/smrtbeat/f0$b;-><init>()V

    invoke-virtual {p0, v1, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    return-void
.end method

.method static synthetic a(Landroid/content/Context;)V
    .locals 0

    invoke-static {p0}, Lcom/smrtbeat/f0;->b(Landroid/content/Context;)V

    return-void
.end method

.method static a(Landroid/content/SharedPreferences$Editor;)V
    .locals 3

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x9

    if-lt v0, v1, :cond_0

    invoke-static {p0}, Lcom/smrtbeat/y;->a(Landroid/content/SharedPreferences$Editor;)V

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/smrtbeat/f0$c;

    invoke-direct {v1}, Lcom/smrtbeat/f0$c;-><init>()V

    invoke-virtual {v1, p0}, Lcom/smrtbeat/f0$c;->a(Landroid/content/SharedPreferences$Editor;)Ljava/lang/Runnable;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    const-wide/16 v1, 0x3e8

    :try_start_0
    invoke-virtual {v0, v1, v2}, Ljava/lang/Thread;->join(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    return-void
.end method

.method static a(Landroid/content/SharedPreferences$Editor;Z)V
    .locals 1

    const-string v0, "com.smrtbeat.pref5"

    invoke-interface {p0, v0, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    sput-boolean p1, Lcom/smrtbeat/j;->g0:Z

    return-void
.end method

.method static a(Lcom/smrtbeat/d;)V
    .locals 3

    if-eqz p0, :cond_2

    invoke-virtual {p0}, Lcom/smrtbeat/d;->e()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lcom/smrtbeat/d;->e()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/smrtbeat/j;->H:Ljava/util/List;

    monitor-enter v0

    :try_start_0
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    const/16 v2, 0x80

    if-lt v1, v2, :cond_1

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    :cond_1
    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0

    :cond_2
    :goto_0
    return-void
.end method

.method static a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_0

    goto/16 :goto_1

    :cond_0
    sget-object v0, Lcom/smrtbeat/f0$d;->a:[I

    invoke-virtual {p0}, Ljava/lang/Enum;->ordinal()I

    move-result p0

    aget p0, v0, p0

    packed-switch p0, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    sget-object p0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-static {p0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[V/"

    goto :goto_0

    :pswitch_1
    sget-object p0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[D/"

    goto :goto_0

    :pswitch_2
    sget-object p0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-static {p0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[I/"

    goto :goto_0

    :pswitch_3
    sget-object p0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-static {p0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[W/"

    goto :goto_0

    :pswitch_4
    sget-object p0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-static {p0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[E/"

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/smrtbeat/q;->a(Ljava/lang/String;)V

    :cond_1
    :goto_1
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static a(Lcom/smrtbeat/f0$e;Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 2

    sget-object v0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_0

    goto/16 :goto_1

    :cond_0
    invoke-static {p2}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/smrtbeat/f0$d;->a:[I

    invoke-virtual {p0}, Ljava/lang/Enum;->ordinal()I

    move-result p0

    aget p0, v1, p0

    packed-switch p0, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    sget-object p0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-static {p0, p1, p2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object p0

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[V/"

    goto :goto_0

    :pswitch_1
    sget-object p0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-static {p0, p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object p0

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[D/"

    goto :goto_0

    :pswitch_2
    sget-object p0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-static {p0, p1, p2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object p0

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[I/"

    goto :goto_0

    :pswitch_3
    sget-object p0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-static {p0, p1, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object p0

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[W/"

    goto :goto_0

    :pswitch_4
    sget-object p0, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-static {p0, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    invoke-static {}, Lcom/smrtbeat/q;->a()Lcom/smrtbeat/q;

    move-result-object p0

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[E/"

    :goto_0
    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "]"

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "\n"

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/smrtbeat/q;->a(Ljava/lang/String;)V

    :cond_1
    :goto_1
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static a(Lcom/smrtbeat/j$a;Landroid/graphics/Bitmap;)V
    .locals 1

    sget-object v0, Lcom/smrtbeat/f0$d;->b:[I

    invoke-virtual {p0}, Ljava/lang/Enum;->ordinal()I

    move-result p0

    aget p0, v0, p0

    const/4 v0, 0x1

    if-eq p0, v0, :cond_1

    const/4 v0, 0x2

    if-eq p0, v0, :cond_0

    goto :goto_1

    :cond_0
    sget-object p0, Lcom/smrtbeat/j;->V:Landroid/graphics/Bitmap;

    if-eq p0, p1, :cond_2

    if-eqz p1, :cond_2

    goto :goto_0

    :cond_1
    sget-object p0, Lcom/smrtbeat/j;->W:Landroid/graphics/Bitmap;

    if-eq p0, p1, :cond_2

    if-eqz p1, :cond_2

    :goto_0
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->recycle()V

    :cond_2
    :goto_1
    return-void
.end method

.method static declared-synchronized a(Lcom/smrtbeat/j$a;Landroid/graphics/Bitmap;J)V
    .locals 3

    const-class v0, Lcom/smrtbeat/f0;

    monitor-enter v0

    :try_start_0
    sget-boolean v1, Lcom/smrtbeat/j;->d0:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    :cond_0
    if-eqz p1, :cond_7

    :try_start_1
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v1

    if-nez v1, :cond_7

    sget-object v1, Lcom/smrtbeat/f0$d;->b:[I

    invoke-virtual {p0}, Ljava/lang/Enum;->ordinal()I

    move-result v2

    aget v1, v1, v2

    const/4 v2, 0x1

    if-eq v1, v2, :cond_4

    const/4 v2, 0x2

    if-eq v1, v2, :cond_1

    goto :goto_1

    :cond_1
    sget-object v1, Lcom/smrtbeat/j;->V:Landroid/graphics/Bitmap;

    if-eq v1, p1, :cond_3

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    :cond_2
    sput-object p1, Lcom/smrtbeat/j;->V:Landroid/graphics/Bitmap;

    :cond_3
    sput-wide p2, Lcom/smrtbeat/j;->X:J

    sget-object p1, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;

    const-string p2, "save screen capture"

    :goto_0
    invoke-static {p1, p2}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    goto :goto_1

    :cond_4
    sget-object v1, Lcom/smrtbeat/j;->W:Landroid/graphics/Bitmap;

    if-eq v1, p1, :cond_6

    if-eqz v1, :cond_5

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    :cond_5
    sput-object p1, Lcom/smrtbeat/j;->W:Landroid/graphics/Bitmap;

    :cond_6
    sput-wide p2, Lcom/smrtbeat/j;->X:J

    sget-object p1, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;

    const-string p2, "save screen capture (gl)"

    goto :goto_0

    :goto_1
    sput-object p0, Lcom/smrtbeat/j;->Y:Lcom/smrtbeat/j$a;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_7
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method static a(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lcom/smrtbeat/d;

    invoke-direct {v0, p0}, Lcom/smrtbeat/d;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    return-void
.end method

.method static a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lcom/smrtbeat/j;->I:Ljava/util/Map;

    invoke-interface {v0, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method static a(Z)V
    .locals 0

    sput-boolean p0, Lcom/smrtbeat/j;->e0:Z

    return-void
.end method

.method static a()Z
    .locals 1

    :try_start_0
    const-string v0, "com.google.android.gms.ads.identifier.AdvertisingIdClient"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method private static a(Landroid/content/SharedPreferences;Ljava/lang/String;Z)Z
    .locals 1

    :try_start_0
    invoke-interface {p0, p1, p2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0, p1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-static {p0}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences$Editor;)V

    return p2
.end method

.method static a(Ljava/io/File;Ljava/io/File;)Z
    .locals 11

    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_11
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_c
    .catchall {:try_start_0 .. :try_end_0} :catchall_4

    :try_start_1
    invoke-virtual {v1}, Ljava/io/FileInputStream;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v8
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_6
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    :try_start_2
    new-instance v9, Ljava/io/FileOutputStream;

    invoke-direct {v9, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_7
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_5
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    :try_start_3
    invoke-virtual {v9}, Ljava/io/FileOutputStream;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v10
    :try_end_3
    .catch Ljava/io/FileNotFoundException; {:try_start_3 .. :try_end_3} :catch_12
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_d
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    const-wide/16 v3, 0x0

    :try_start_4
    invoke-virtual {v8}, Ljava/nio/channels/FileChannel;->size()J

    move-result-wide v5

    move-object v2, v8

    move-object v7, v10

    invoke-virtual/range {v2 .. v7}, Ljava/nio/channels/FileChannel;->transferTo(JJLjava/nio/channels/WritableByteChannel;)J
    :try_end_4
    .catch Ljava/io/FileNotFoundException; {:try_start_4 .. :try_end_4} :catch_3
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    if-eqz v8, :cond_0

    :try_start_5
    invoke-virtual {v8}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_0

    :catch_0
    :cond_0
    if-eqz v10, :cond_1

    :try_start_6
    invoke-virtual {v10}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1

    :catch_1
    :cond_1
    :try_start_7
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_16

    goto/16 :goto_4

    :catchall_0
    move-exception p0

    move-object v0, v10

    goto :goto_1

    :catch_2
    move-object v0, v10

    goto :goto_2

    :catch_3
    move-object v0, v10

    goto :goto_3

    :catchall_1
    move-exception p0

    goto :goto_1

    :catchall_2
    move-exception p0

    goto :goto_0

    :catchall_3
    move-exception p0

    move-object v8, v0

    :goto_0
    move-object v9, v0

    goto :goto_1

    :catch_4
    move-object v8, v0

    :catch_5
    move-object v9, v0

    goto :goto_2

    :catch_6
    move-object v8, v0

    :catch_7
    move-object v9, v0

    goto :goto_3

    :catchall_4
    move-exception p0

    move-object v1, v0

    move-object v8, v1

    move-object v9, v8

    :goto_1
    if-eqz v8, :cond_2

    :try_start_8
    invoke-virtual {v8}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_8

    :catch_8
    :cond_2
    if-eqz v0, :cond_3

    :try_start_9
    invoke-virtual {v0}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_9

    :catch_9
    :cond_3
    if-eqz v1, :cond_4

    :try_start_a
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_a

    :catch_a
    :cond_4
    if-eqz v9, :cond_5

    :try_start_b
    invoke-virtual {v9}, Ljava/io/FileOutputStream;->close()V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_b

    :catch_b
    :cond_5
    throw p0

    :catch_c
    move-object v1, v0

    move-object v8, v1

    move-object v9, v8

    :catch_d
    :goto_2
    if-eqz v8, :cond_6

    :try_start_c
    invoke-virtual {v8}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_c
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_c} :catch_e

    :catch_e
    :cond_6
    if-eqz v0, :cond_7

    :try_start_d
    invoke-virtual {v0}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_d
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_d} :catch_f

    :catch_f
    :cond_7
    if-eqz v1, :cond_8

    :try_start_e
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_e
    .catch Ljava/io/IOException; {:try_start_e .. :try_end_e} :catch_10

    :catch_10
    :cond_8
    if-eqz v9, :cond_c

    goto :goto_4

    :catch_11
    move-object v1, v0

    move-object v8, v1

    move-object v9, v8

    :catch_12
    :goto_3
    if-eqz v8, :cond_9

    :try_start_f
    invoke-virtual {v8}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_f
    .catch Ljava/io/IOException; {:try_start_f .. :try_end_f} :catch_13

    :catch_13
    :cond_9
    if-eqz v0, :cond_a

    :try_start_10
    invoke-virtual {v0}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_10
    .catch Ljava/io/IOException; {:try_start_10 .. :try_end_10} :catch_14

    :catch_14
    :cond_a
    if-eqz v1, :cond_b

    :try_start_11
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_11
    .catch Ljava/io/IOException; {:try_start_11 .. :try_end_11} :catch_15

    :catch_15
    :cond_b
    if-eqz v9, :cond_c

    :catch_16
    :goto_4
    :try_start_12
    invoke-virtual {v9}, Ljava/io/FileOutputStream;->close()V
    :try_end_12
    .catch Ljava/io/IOException; {:try_start_12 .. :try_end_12} :catch_17

    :catch_17
    :cond_c
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_d

    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    :cond_d
    return p1
.end method

.method static b(Landroid/content/SharedPreferences;)J
    .locals 3

    const-string v0, "com.smrtbeat.pref3"

    const-wide/16 v1, 0x0

    invoke-static {p0, v0, v1, v2}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences;Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method

.method static b(Ljava/lang/String;)Ljava/io/File;
    .locals 3

    sget-object v0, Lcom/smrtbeat/f0$d;->b:[I

    sget-object v1, Lcom/smrtbeat/j;->Y:Lcom/smrtbeat/j$a;

    invoke-virtual {v1}, Ljava/lang/Enum;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    goto :goto_1

    :cond_0
    sget-object v0, Lcom/smrtbeat/j;->V:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_2

    sget-wide v0, Lcom/smrtbeat/j;->X:J

    const-string v2, ".jpg"

    invoke-static {p0, v0, v1, v2}, Lcom/smrtbeat/d0;->b(Ljava/lang/String;JLjava/lang/String;)Ljava/io/File;

    move-result-object p0

    sget-object v0, Lcom/smrtbeat/j;->V:Landroid/graphics/Bitmap;

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/smrtbeat/j;->W:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_2

    sget-wide v0, Lcom/smrtbeat/j;->X:J

    const-string v2, ".jpg"

    invoke-static {p0, v0, v1, v2}, Lcom/smrtbeat/d0;->b(Ljava/lang/String;JLjava/lang/String;)Ljava/io/File;

    move-result-object p0

    sget-object v0, Lcom/smrtbeat/j;->W:Landroid/graphics/Bitmap;

    :goto_0
    invoke-static {p0, v0}, Lcom/smrtbeat/d0;->a(Ljava/io/File;Landroid/graphics/Bitmap;)Z

    goto :goto_2

    :cond_2
    :goto_1
    const/4 p0, 0x0

    :goto_2
    return-object p0
.end method

.method static b()Ljava/lang/String;
    .locals 1

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static b(Landroid/app/Activity;)V
    .locals 1

    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/smrtbeat/f0;->a(Landroid/app/Activity;Z)V

    invoke-static {}, Lcom/smrtbeat/k;->k()V

    invoke-static {}, Lcom/smrtbeat/k;->p()V

    invoke-static {}, Lcom/smrtbeat/k;->e()V

    return-void
.end method

.method private static b(Landroid/content/Context;)V
    .locals 3

    const-string v0, "SmartBeat"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "idv2"

    const-string v2, ""

    invoke-interface {p0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p0

    if-lez p0, :cond_0

    const-string p0, "uuid"

    invoke-interface {v0, p0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    :cond_0
    const-string p0, "idv2"

    invoke-interface {v0, p0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences$Editor;)V

    return-void
.end method

.method static b(Landroid/content/SharedPreferences$Editor;)V
    .locals 3

    const-string v0, "com.smrtbeat.pref4"

    const-wide/32 v1, 0x5265c00

    invoke-interface {p0, v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    return-void
.end method

.method static b(Landroid/content/SharedPreferences$Editor;Z)V
    .locals 1

    const-string v0, "com.smrtbeat.pref1"

    invoke-interface {p0, v0, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    sput-boolean p1, Lcom/smrtbeat/j;->f0:Z

    return-void
.end method

.method static c(Landroid/content/SharedPreferences;)J
    .locals 5

    const-string v0, "com.smrtbeat.pref4"

    const-wide/32 v1, 0x5265c00

    invoke-static {p0, v0, v1, v2}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences;Ljava/lang/String;J)J

    move-result-wide v3

    cmp-long p0, v3, v1

    if-gez p0, :cond_0

    goto :goto_0

    :cond_0
    move-wide v1, v3

    :goto_0
    const-wide/32 v3, 0x2932e000

    cmp-long p0, v1, v3

    if-lez p0, :cond_1

    move-wide v1, v3

    :cond_1
    return-wide v1
.end method

.method static c()Ljava/lang/String;
    .locals 1

    sget-object v0, Landroid/os/Build;->BOARD:Ljava/lang/String;

    return-object v0
.end method

.method private static c(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    const-string v0, "SmartBeat"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    const-string v0, "idv2"

    const-string v1, ""

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_0

    const/4 p0, 0x0

    :cond_0
    return-object p0
.end method

.method static c(Landroid/app/Activity;)V
    .locals 1

    sget-object v0, Lcom/smrtbeat/j;->U:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    return-void

    :cond_0
    invoke-static {p0}, Lcom/smrtbeat/f0;->b(Landroid/app/Activity;)V

    return-void
.end method

.method static c(Landroid/content/SharedPreferences$Editor;)V
    .locals 3

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    const-string v2, "com.smrtbeat.pref6"

    invoke-interface {p0, v2, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    return-void
.end method

.method static d()Ljava/lang/String;
    .locals 2

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/util/Locale;->getDisplayLanguage(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static d(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-ge v0, v1, :cond_0

    invoke-static {p0}, Lcom/smrtbeat/z;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    invoke-static {p0}, Lcom/smrtbeat/x;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static d(Landroid/content/SharedPreferences$Editor;)V
    .locals 3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const-string v2, "com.smrtbeat.pref3"

    invoke-interface {p0, v2, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    return-void
.end method

.method static d(Landroid/content/SharedPreferences;)V
    .locals 5

    invoke-static {p0}, Lcom/smrtbeat/f0;->c(Landroid/content/SharedPreferences;)J

    move-result-wide v0

    const-wide/16 v2, 0x2

    mul-long v0, v0, v2

    const-wide/32 v2, 0x5265c00

    cmp-long v4, v0, v2

    if-gez v4, :cond_0

    move-wide v0, v2

    :cond_0
    const-wide/32 v2, 0x2932e000

    cmp-long v4, v0, v2

    if-lez v4, :cond_1

    move-wide v0, v2

    :cond_1
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    const-string v2, "com.smrtbeat.pref4"

    invoke-interface {p0, v2, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    invoke-static {p0}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences$Editor;)V

    return-void
.end method

.method static e()Ljava/lang/String;
    .locals 2

    invoke-static {}, Lcom/smrtbeat/j;->a()Landroid/content/Context;

    move-result-object v0

    const-string v1, "ro.board.platform"

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static e(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    const-string v0, "window"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/view/WindowManager;

    invoke-interface {p0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object p0

    invoke-virtual {p0}, Landroid/view/Display;->getRotation()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "unknown:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/view/Display;->getRotation()I

    move-result p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    :pswitch_0
    const-string p0, "ROTATION_270"

    goto :goto_0

    :pswitch_1
    const-string p0, "ROTATION_180"

    goto :goto_0

    :pswitch_2
    const-string p0, "ROTATION_90"

    goto :goto_0

    :pswitch_3
    const-string p0, "ROTATION_0"

    :goto_0
    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static e(Landroid/content/SharedPreferences;)V
    .locals 2

    const-string v0, "com.smrtbeat.pref1"

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences;Ljava/lang/String;Z)Z

    move-result v0

    sput-boolean v0, Lcom/smrtbeat/j;->f0:Z

    const-string v0, "com.smrtbeat.pref5"

    invoke-static {p0, v0, v1}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences;Ljava/lang/String;Z)Z

    move-result p0

    sput-boolean p0, Lcom/smrtbeat/j;->g0:Z

    return-void
.end method

.method static f(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 2

    const-string v0, "com.smrtbeat"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    return-object p0
.end method

.method static f()Ljava/lang/String;
    .locals 6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x15

    if-lt v1, v2, :cond_2

    invoke-static {}, Lcom/smrtbeat/w;->a()[Ljava/lang/String;

    move-result-object v1

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_3

    aget-object v4, v1, v3

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    if-gtz v5, :cond_0

    goto :goto_1

    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v5

    if-lez v5, :cond_1

    const-string v5, " / "

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_1
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/smrtbeat/a0;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lcom/smrtbeat/a0;->b()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_3

    const-string v2, " / "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_3
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static g(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    const-string v0, "SmartBeat"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object p0

    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static g()Z
    .locals 1

    invoke-static {}, Lcom/smrtbeat/f0;->i()Z

    move-result v0

    return v0
.end method

.method private static h(Landroid/content/Context;)Ljava/lang/String;
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    const-string v0, "SmartBeat"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    const-string v0, "uuid"

    const-string v1, ""

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-gtz v1, :cond_0

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    const-string v1, "uuid"

    invoke-interface {p0, v1, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-static {p0}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences$Editor;)V

    :cond_0
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "android:"

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ":"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v0, Lcom/smrtbeat/j;->s:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static h()Z
    .locals 1

    invoke-static {}, Lcom/smrtbeat/f0;->k()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/smrtbeat/j;->g0:Z

    if-nez v0, :cond_0

    sget-boolean v0, Lcom/smrtbeat/j;->Q:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method static i(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-ge v0, v1, :cond_0

    invoke-static {p0}, Lcom/smrtbeat/z;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    invoke-static {p0}, Lcom/smrtbeat/x;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static i()Z
    .locals 1

    invoke-static {}, Lcom/smrtbeat/f0;->k()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/smrtbeat/j;->g0:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private static j(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/smrtbeat/f0$a;

    invoke-direct {v1, p0}, Lcom/smrtbeat/f0$a;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method static j()Z
    .locals 1

    sget-boolean v0, Lcom/smrtbeat/j;->f0:Z

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method static k(Landroid/content/Context;)V
    .locals 3

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/j;->p:Ljava/lang/String;

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    sput-object v0, Lcom/smrtbeat/j;->s:Ljava/lang/String;

    sget-object v0, Landroid/os/Build;->BRAND:Ljava/lang/String;

    sput-object v0, Lcom/smrtbeat/j;->r:Ljava/lang/String;

    invoke-static {}, Lcom/smrtbeat/f0;->b()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/j;->D:Ljava/lang/String;

    const-string v0, "unknown"

    sput-object v0, Lcom/smrtbeat/j;->q:Ljava/lang/String;

    const-string v0, "unknown"

    sput-object v0, Lcom/smrtbeat/j;->v:Ljava/lang/String;

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    sget-object v1, Lcom/smrtbeat/j;->p:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    iget-object v1, v0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    sput-object v1, Lcom/smrtbeat/j;->q:Ljava/lang/String;

    iget v0, v0, Landroid/content/pm/PackageInfo;->versionCode:I

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/j;->v:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    sget-object v0, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    sput-object v0, Lcom/smrtbeat/j;->w:Ljava/lang/String;

    invoke-static {}, Lcom/smrtbeat/f0;->n()Z

    move-result v0

    sput-boolean v0, Lcom/smrtbeat/j;->x:Z

    invoke-static {p0}, Lcom/smrtbeat/f0;->h(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/j;->t:Ljava/lang/String;

    invoke-static {p0}, Lcom/smrtbeat/f0;->c(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/j;->u:Ljava/lang/String;

    invoke-static {p0}, Lcom/smrtbeat/f0;->j(Landroid/content/Context;)V

    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    const-string v1, "window"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager;

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    iget v1, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    sput v1, Lcom/smrtbeat/j;->y:I

    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    sput v1, Lcom/smrtbeat/j;->z:I

    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    sput v0, Lcom/smrtbeat/j;->A:I

    invoke-static {p0}, Lcom/smrtbeat/f0;->g(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/smrtbeat/j;->C:Ljava/lang/String;

    return-void
.end method

.method static k()Z
    .locals 1

    sget-boolean v0, Lcom/smrtbeat/j;->e0:Z

    if-nez v0, :cond_0

    sget-boolean v0, Lcom/smrtbeat/j;->f0:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method static l()Z
    .locals 1

    sget-object v0, Lcom/smrtbeat/j;->o:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method static m()Z
    .locals 3

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x0

    const/16 v2, 0x17

    if-lt v0, v2, :cond_0

    invoke-static {}, Lcom/smrtbeat/x;->a()I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-lez v0, :cond_1

    const/4 v1, 0x1

    :cond_1
    return v1
.end method

.method private static n()Z
    .locals 8

    const-string v0, "/sbin/"

    const-string v1, "/system/bin/"

    const-string v2, "/system/xbin/"

    const-string v3, "/data/local/xbin/"

    const-string v4, "/data/local/bin/"

    const-string v5, "/system/sd/xbin/"

    const-string v6, "/system/bin/failsafe/"

    const-string v7, "/data/local/"

    filled-new-array/range {v0 .. v7}, [Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    const/16 v3, 0x8

    if-ge v2, v3, :cond_1

    new-instance v3, Ljava/io/File;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    aget-object v5, v0, v2

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "su"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v1, 0x1

    goto :goto_1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    return v1
.end method

.method private static o()Ljava/util/List;
    .locals 19
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/LinkedList;

    const-string v1, "android.intent.action.ACTION_POWER_CONNECTED"

    const-string v2, "android.intent.action.ACTION_POWER_DISCONNECTED"

    const-string v3, "android.intent.action.ACTION_SHUTDOWN"

    const-string v4, "android.intent.action.AIRPLANE_MODE"

    const-string v5, "android.intent.action.BATTERY_LOW"

    const-string v6, "android.intent.action.BATTERY_OKAY"

    const-string v7, "android.intent.action.CAMERA_BUTTON"

    const-string v8, "android.intent.action.CLOSE_SYSTEM_DIALOGS"

    const-string v9, "android.intent.action.CONFIGURATION_CHANGED"

    const-string v10, "android.intent.action.DATE_CHANGED"

    const-string v11, "android.intent.action.DOCK_EVENT"

    const-string v12, "android.intent.action.INPUT_METHOD_CHANGED"

    const-string v13, "android.intent.action.LOCALE_CHANGED"

    const-string v14, "android.intent.action.REBOOT"

    const-string v15, "android.intent.action.SCREEN_OFF"

    const-string v16, "android.intent.action.SCREEN_ON"

    const-string v17, "android.intent.action.TIMEZONE_CHANGED"

    const-string v18, "android.intent.action.TIME_SET"

    filled-new-array/range {v1 .. v18}, [Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/LinkedList;-><init>(Ljava/util/Collection;)V

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x11

    if-lt v1, v2, :cond_0

    const-string v2, "android.intent.action.DREAMING_STARTED"

    const-string v3, "android.intent.action.DREAMING_STOPPED"

    filled-new-array {v2, v3}, [Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_0
    const/16 v2, 0x15

    if-lt v1, v2, :cond_1

    const-string v2, "android.os.action.POWER_SAVE_MODE_CHANGED"

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    const/16 v2, 0x17

    if-lt v1, v2, :cond_2

    const-string v1, "android.os.action.DEVICE_IDLE_MODE_CHANGED"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method static p()Ljava/lang/String;
    .locals 10

    sget-object v0, Lcom/smrtbeat/j;->L:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v4, 0x0

    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "logcat -t "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v7, 0x1f4

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v8, " "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_5
    .catchall {:try_start_0 .. :try_end_0} :catchall_5

    :try_start_1
    new-instance v5, Ljava/io/InputStreamReader;

    invoke-virtual {v0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    :try_start_2
    new-instance v6, Ljava/io/BufferedReader;

    const/16 v8, 0x2000

    invoke-direct {v6, v5, v8}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    :try_start_3
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    const/4 v8, 0x0

    :goto_0
    const/16 v9, 0x3e8

    if-ge v8, v9, :cond_0

    invoke-virtual {v6}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v9

    if-eqz v9, :cond_0

    invoke-interface {v3, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    :cond_0
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v8
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    if-nez v8, :cond_5

    const-string v1, "no permission (android.permission.READ_LOGS)"

    :try_start_4
    invoke-virtual {v6}, Ljava/io/BufferedReader;->close()V

    invoke-virtual {v5}, Ljava/io/InputStreamReader;->close()V

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {v0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    :cond_1
    invoke-virtual {v0}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {v0}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    :cond_2
    invoke-virtual {v0}, Ljava/lang/Process;->getErrorStream()Ljava/io/InputStream;

    move-result-object v2

    if-eqz v2, :cond_3

    invoke-virtual {v0}, Ljava/lang/Process;->getErrorStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    :cond_3
    invoke-virtual {v0}, Ljava/lang/Process;->destroy()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    sget-object v2, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "logcat stream close failed "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :catch_0
    :cond_4
    :goto_1
    return-object v1

    :cond_5
    :try_start_5
    invoke-virtual {v6}, Ljava/io/BufferedReader;->close()V

    invoke-virtual {v5}, Ljava/io/InputStreamReader;->close()V

    if-eqz v0, :cond_9

    invoke-virtual {v0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    if-eqz v5, :cond_6

    invoke-virtual {v0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    :cond_6
    invoke-virtual {v0}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v5

    if-eqz v5, :cond_7

    invoke-virtual {v0}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v5

    invoke-virtual {v5}, Ljava/io/OutputStream;->close()V

    :cond_7
    invoke-virtual {v0}, Ljava/lang/Process;->getErrorStream()Ljava/io/InputStream;

    move-result-object v5

    if-eqz v5, :cond_8

    invoke-virtual {v0}, Ljava/lang/Process;->getErrorStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    :cond_8
    invoke-virtual {v0}, Ljava/lang/Process;->destroy()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    goto :goto_2

    :catchall_1
    move-exception v0

    sget-object v5, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "logcat stream close failed "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v5, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :catch_1
    :cond_9
    :goto_2
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v0

    sub-int/2addr v0, v7

    if-gez v0, :cond_a

    const/4 v0, 0x0

    :cond_a
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v5

    sub-int/2addr v5, v2

    const/4 v2, 0x0

    :goto_3
    if-ltz v5, :cond_c

    if-lt v5, v0, :cond_c

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v3, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v7, "\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->getBytes()[B

    move-result-object v7

    array-length v7, v7

    add-int/2addr v2, v7

    const/high16 v7, 0x10000

    if-le v2, v7, :cond_b

    goto :goto_4

    :cond_b
    invoke-virtual {v1, v4, v6}, Ljava/lang/StringBuilder;->insert(ILjava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v5, v5, -0x1

    goto :goto_3

    :cond_c
    :goto_4
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :catchall_2
    move-exception v1

    goto/16 :goto_b

    :catch_2
    move-exception v1

    move-object v3, v6

    goto :goto_7

    :catchall_3
    move-exception v1

    goto/16 :goto_c

    :catch_3
    move-exception v1

    goto :goto_7

    :catchall_4
    move-exception v1

    goto :goto_5

    :catch_4
    move-exception v1

    goto :goto_6

    :catchall_5
    move-exception v0

    move-object v1, v0

    move-object v0, v3

    :goto_5
    move-object v5, v3

    goto/16 :goto_c

    :catch_5
    move-exception v0

    move-object v1, v0

    move-object v0, v3

    :goto_6
    move-object v5, v3

    :goto_7
    const-string v6, "error to read logcat(%s)"

    :try_start_6
    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v2, v4

    invoke-static {v6, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_7

    if-eqz v3, :cond_d

    :try_start_7
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V

    goto :goto_8

    :catchall_6
    move-exception v0

    goto :goto_9

    :cond_d
    :goto_8
    if-eqz v5, :cond_e

    invoke-virtual {v5}, Ljava/io/InputStreamReader;->close()V

    :cond_e
    if-eqz v0, :cond_12

    invoke-virtual {v0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    if-eqz v2, :cond_f

    invoke-virtual {v0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    :cond_f
    invoke-virtual {v0}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    if-eqz v2, :cond_10

    invoke-virtual {v0}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    :cond_10
    invoke-virtual {v0}, Ljava/lang/Process;->getErrorStream()Ljava/io/InputStream;

    move-result-object v2

    if-eqz v2, :cond_11

    invoke-virtual {v0}, Ljava/lang/Process;->getErrorStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    :cond_11
    invoke-virtual {v0}, Ljava/lang/Process;->destroy()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_6
    .catchall {:try_start_7 .. :try_end_7} :catchall_6

    goto :goto_a

    :goto_9
    sget-object v2, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "logcat stream close failed "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :catch_6
    :cond_12
    :goto_a
    return-object v1

    :catchall_7
    move-exception v1

    move-object v6, v3

    :goto_b
    move-object v3, v5

    move-object v5, v3

    move-object v3, v6

    :goto_c
    if-eqz v3, :cond_13

    :try_start_8
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V

    goto :goto_d

    :catchall_8
    move-exception v0

    goto :goto_e

    :cond_13
    :goto_d
    if-eqz v5, :cond_14

    invoke-virtual {v5}, Ljava/io/InputStreamReader;->close()V

    :cond_14
    if-eqz v0, :cond_18

    invoke-virtual {v0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    if-eqz v2, :cond_15

    invoke-virtual {v0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    :cond_15
    invoke-virtual {v0}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    if-eqz v2, :cond_16

    invoke-virtual {v0}, Ljava/lang/Process;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    :cond_16
    invoke-virtual {v0}, Ljava/lang/Process;->getErrorStream()Ljava/io/InputStream;

    move-result-object v2

    if-eqz v2, :cond_17

    invoke-virtual {v0}, Ljava/lang/Process;->getErrorStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    :cond_17
    invoke-virtual {v0}, Ljava/lang/Process;->destroy()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_7
    .catchall {:try_start_8 .. :try_end_8} :catchall_8

    goto :goto_f

    :goto_e
    sget-object v2, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "logcat stream close failed "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :catch_7
    :cond_18
    :goto_f
    throw v1
.end method

.method static q()Ljava/io/File;
    .locals 1

    sget-object v0, Lcom/smrtbeat/j;->D:Ljava/lang/String;

    invoke-static {v0}, Lcom/smrtbeat/f0;->b(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    return-object v0
.end method

.method private static r()V
    .locals 4

    sget-object v0, Lcom/smrtbeat/j;->U:Ljava/lang/String;

    sget-object v1, Lcom/smrtbeat/j;->S:Ljava/util/List;

    monitor-enter v1

    :try_start_0
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v0, 0x1

    sput-boolean v0, Lcom/smrtbeat/j;->Z:Z

    monitor-exit v1

    return-void

    :cond_1
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v0, 0x0

    sput-boolean v0, Lcom/smrtbeat/j;->Z:Z

    return-void

    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

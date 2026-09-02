.class Lcom/smrtbeat/j;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/smrtbeat/j$a;
    }
.end annotation


# static fields
.field static A:I = 0x0

.field static B:J = 0x0L

.field static C:Ljava/lang/String; = null

.field static D:Ljava/lang/String; = null

.field static E:Z = false

.field static F:Z = false

.field static G:I = 0x0

.field static final H:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/smrtbeat/d;",
            ">;"
        }
    .end annotation
.end field

.field static final I:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field static J:Ljava/lang/String; = null

.field static K:Z = false

.field static L:Ljava/lang/String; = null

.field static M:Ljava/lang/String; = null

.field static N:Z = false

.field static O:Lcom/smrtbeat/g; = null

.field static P:Ljava/lang/Thread; = null

.field static Q:Z = false

.field static R:Z = false

.field static final S:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field static T:I = 0x0

.field static U:Ljava/lang/String; = null

.field static V:Landroid/graphics/Bitmap; = null

.field static W:Landroid/graphics/Bitmap; = null

.field static X:J = 0x0L

.field static Y:Lcom/smrtbeat/j$a; = null

.field static Z:Z = false

.field static final a:Ljava/lang/String; = "https://api.smbeat.jp/api/errors"

.field static a0:Ljava/lang/String; = null

.field static final b:Ljava/lang/String; = "https://images.smbeat.jp/api/upload"

.field static b0:Ljava/lang/String; = null

.field static final c:Ljava/lang/String; = "https://minidumps.smbeat.jp/api/errors/multi"

.field static c0:Ljava/lang/String; = null

.field static final d:Ljava/lang/String; = "https://control.smbeat.jp/api/remote"

.field static d0:Z = false

.field static final e:Ljava/lang/String; = "https://abort-count.smbeat.jp/api/abort"

.field static e0:Z = false

.field static final f:J = 0x1499700L

.field static f0:Z = false

.field static final g:I = 0x8c

.field static g0:Z = false

.field static final h:I = 0x80

.field static h0:Ljava/lang/Thread; = null

.field static final i:I = 0x400

.field private static i0:Ljava/lang/ref/WeakReference; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/content/Context;",
            ">;"
        }
    .end annotation
.end field

.field static final j:J = 0x1388L

.field static final k:I = 0x3

.field static final l:I = 0x10000

.field static final m:I = 0x1f4

.field static final n:Ljava/lang/String; = "1.23.1"

.field static o:Ljava/lang/String; = ""

.field static p:Ljava/lang/String; = ""

.field static q:Ljava/lang/String; = ""

.field static r:Ljava/lang/String; = ""

.field static s:Ljava/lang/String; = ""

.field static t:Ljava/lang/String; = ""

.field static u:Ljava/lang/String; = null

.field static v:Ljava/lang/String; = ""

.field static w:Ljava/lang/String; = ""

.field static x:Z

.field static y:I

.field static z:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lcom/smrtbeat/j;->B:J

    const-string v0, ""

    sput-object v0, Lcom/smrtbeat/j;->C:Ljava/lang/String;

    const-string v0, ""

    sput-object v0, Lcom/smrtbeat/j;->D:Ljava/lang/String;

    const/4 v0, 0x0

    sput-boolean v0, Lcom/smrtbeat/j;->E:Z

    sput-boolean v0, Lcom/smrtbeat/j;->F:Z

    sput v0, Lcom/smrtbeat/j;->G:I

    new-instance v1, Ljava/util/ArrayList;

    const/16 v2, 0x80

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    invoke-static {v1}, Ljava/util/Collections;->synchronizedList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    sput-object v1, Lcom/smrtbeat/j;->H:Ljava/util/List;

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    invoke-static {v1}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v1

    sput-object v1, Lcom/smrtbeat/j;->I:Ljava/util/Map;

    const-string v1, ""

    sput-object v1, Lcom/smrtbeat/j;->J:Ljava/lang/String;

    sput-boolean v0, Lcom/smrtbeat/j;->K:Z

    const-string v1, ""

    sput-object v1, Lcom/smrtbeat/j;->L:Ljava/lang/String;

    const-string v1, ""

    sput-object v1, Lcom/smrtbeat/j;->M:Ljava/lang/String;

    sput-boolean v0, Lcom/smrtbeat/j;->N:Z

    const/4 v1, 0x0

    sput-object v1, Lcom/smrtbeat/j;->O:Lcom/smrtbeat/g;

    sput-object v1, Lcom/smrtbeat/j;->P:Ljava/lang/Thread;

    sput-boolean v0, Lcom/smrtbeat/j;->Q:Z

    const/4 v2, 0x1

    sput-boolean v2, Lcom/smrtbeat/j;->R:Z

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v2}, Ljava/util/Collections;->synchronizedList(Ljava/util/List;)Ljava/util/List;

    move-result-object v2

    sput-object v2, Lcom/smrtbeat/j;->S:Ljava/util/List;

    const/4 v2, 0x5

    sput v2, Lcom/smrtbeat/j;->T:I

    const-string v2, ""

    sput-object v2, Lcom/smrtbeat/j;->U:Ljava/lang/String;

    sput-object v1, Lcom/smrtbeat/j;->V:Landroid/graphics/Bitmap;

    sput-object v1, Lcom/smrtbeat/j;->W:Landroid/graphics/Bitmap;

    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/smrtbeat/j;->X:J

    sget-object v2, Lcom/smrtbeat/j$a;->a:Lcom/smrtbeat/j$a;

    sput-object v2, Lcom/smrtbeat/j;->Y:Lcom/smrtbeat/j$a;

    sput-boolean v0, Lcom/smrtbeat/j;->Z:Z

    sput-object v1, Lcom/smrtbeat/j;->a0:Ljava/lang/String;

    sput-object v1, Lcom/smrtbeat/j;->b0:Ljava/lang/String;

    sput-object v1, Lcom/smrtbeat/j;->c0:Ljava/lang/String;

    sput-boolean v0, Lcom/smrtbeat/j;->d0:Z

    sput-boolean v0, Lcom/smrtbeat/j;->e0:Z

    sput-boolean v0, Lcom/smrtbeat/j;->f0:Z

    sput-boolean v0, Lcom/smrtbeat/j;->g0:Z

    sput-object v1, Lcom/smrtbeat/j;->h0:Ljava/lang/Thread;

    sput-object v1, Lcom/smrtbeat/j;->i0:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static a()Landroid/content/Context;
    .locals 1

    sget-object v0, Lcom/smrtbeat/j;->i0:Ljava/lang/ref/WeakReference;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Context;

    :goto_0
    return-object v0
.end method

.method static a(Landroid/content/Context;)V
    .locals 1

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/smrtbeat/j;->i0:Ljava/lang/ref/WeakReference;

    return-void
.end method

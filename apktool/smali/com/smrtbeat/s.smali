.class Lcom/smrtbeat/s;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/smrtbeat/s$b;
    }
.end annotation


# static fields
.field private static final A:I = 0x4

.field private static final B:I = 0x8

.field private static C:Lcom/smrtbeat/s;


# instance fields
.field private a:I

.field private b:I

.field private c:I

.field private d:I

.field private e:Z

.field private f:I

.field private g:I

.field private h:I

.field private i:I

.field private j:I

.field private k:I

.field private l:I

.field private m:Ljava/nio/ByteBuffer;

.field private n:Landroid/graphics/Bitmap;

.field private o:Landroid/graphics/Bitmap;

.field private p:Landroid/graphics/Canvas;

.field private q:Ljava/lang/Thread;

.field private r:Z

.field private s:Z

.field private t:J

.field private u:Z

.field private v:Ljava/nio/FloatBuffer;

.field private w:Ljava/nio/FloatBuffer;

.field private final x:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final y:Ljava/lang/String;

.field private final z:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method constructor <init>()V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/smrtbeat/s;->d:I

    iput-boolean v0, p0, Lcom/smrtbeat/s;->e:Z

    const/4 v1, -0x1

    iput v1, p0, Lcom/smrtbeat/s;->f:I

    iput v0, p0, Lcom/smrtbeat/s;->g:I

    iput v0, p0, Lcom/smrtbeat/s;->h:I

    iput v0, p0, Lcom/smrtbeat/s;->i:I

    iput v0, p0, Lcom/smrtbeat/s;->j:I

    iput v0, p0, Lcom/smrtbeat/s;->k:I

    iput v0, p0, Lcom/smrtbeat/s;->l:I

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/smrtbeat/s;->m:Ljava/nio/ByteBuffer;

    iput-object v1, p0, Lcom/smrtbeat/s;->n:Landroid/graphics/Bitmap;

    iput-object v1, p0, Lcom/smrtbeat/s;->o:Landroid/graphics/Bitmap;

    iput-object v1, p0, Lcom/smrtbeat/s;->p:Landroid/graphics/Canvas;

    iput-object v1, p0, Lcom/smrtbeat/s;->q:Ljava/lang/Thread;

    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/smrtbeat/s;->r:Z

    iput-boolean v0, p0, Lcom/smrtbeat/s;->s:Z

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lcom/smrtbeat/s;->t:J

    iput-boolean v0, p0, Lcom/smrtbeat/s;->u:Z

    iput-object v1, p0, Lcom/smrtbeat/s;->v:Ljava/nio/FloatBuffer;

    iput-object v1, p0, Lcom/smrtbeat/s;->w:Ljava/nio/FloatBuffer;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/smrtbeat/s;->x:Ljava/util/List;

    const-string v0, "attribute vec2 aPosition;\nattribute vec2 aTextureCoord;\nvarying vec2 vTextureCoord;\nvoid main() {\n  gl_Position = vec4(aPosition, 0.0, 1.0);\n  vTextureCoord = aTextureCoord;\n}\n"

    iput-object v0, p0, Lcom/smrtbeat/s;->y:Ljava/lang/String;

    const-string v0, "precision mediump float;\nvarying vec2 vTextureCoord;\nuniform sampler2D sTexture;\nvoid main() {\n  gl_FragColor = texture2D(sTexture, vTextureCoord);\n}\n"

    iput-object v0, p0, Lcom/smrtbeat/s;->z:Ljava/lang/String;

    return-void
.end method

.method private static a()I
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "InlinedApi"
        }
    .end annotation

    const v0, 0x88f0

    return v0
.end method

.method private a(II)I
    .locals 2

    invoke-static {p1, p2}, Ljava/lang/Math;->max(II)I

    move-result v0

    mul-int p1, p1, p2

    const/16 p2, 0x80

    :goto_0
    if-ge p2, v0, :cond_0

    if-lez p2, :cond_0

    mul-int v1, p2, p2

    if-gt v1, p1, :cond_0

    shl-int/lit8 p2, p2, 0x1

    goto :goto_0

    :cond_0
    shr-int/lit8 p1, p2, 0x1

    const/16 p2, 0x200

    if-le p1, p2, :cond_1

    const/16 p1, 0x200

    :cond_1
    return p1
.end method

.method private a(ILjava/lang/String;)I
    .locals 2

    invoke-static {p1}, Landroid/opengl/GLES20;->glCreateShader(I)I

    move-result p1

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    invoke-static {p1, p2}, Landroid/opengl/GLES20;->glShaderSource(ILjava/lang/String;)V

    invoke-static {p1}, Landroid/opengl/GLES20;->glCompileShader(I)V

    const/4 p2, 0x1

    new-array p2, p2, [I

    const v1, 0x8b81

    invoke-static {p1, v1, p2, v0}, Landroid/opengl/GLES20;->glGetShaderiv(II[II)V

    aget p2, p2, v0

    if-nez p2, :cond_0

    invoke-static {p1}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    const/4 p1, 0x0

    :cond_0
    return p1
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;)I
    .locals 5

    const v0, 0x8b31

    invoke-direct {p0, v0, p1}, Lcom/smrtbeat/s;->a(ILjava/lang/String;)I

    move-result p1

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    :cond_0
    const v1, 0x8b30

    invoke-direct {p0, v1, p2}, Lcom/smrtbeat/s;->a(ILjava/lang/String;)I

    move-result p2

    if-nez p2, :cond_1

    return v0

    :cond_1
    invoke-static {}, Landroid/opengl/GLES20;->glCreateProgram()I

    move-result v1

    if-eqz v1, :cond_2

    invoke-static {v1, p1}, Landroid/opengl/GLES20;->glAttachShader(II)V

    const-string v2, "glAttachShader"

    invoke-static {v2}, Lcom/smrtbeat/s;->c(Ljava/lang/String;)V

    invoke-static {v1, p2}, Landroid/opengl/GLES20;->glAttachShader(II)V

    const-string v2, "glAttachShader"

    invoke-static {v2}, Lcom/smrtbeat/s;->c(Ljava/lang/String;)V

    invoke-static {v1}, Landroid/opengl/GLES20;->glLinkProgram(I)V

    const/4 v2, 0x1

    new-array v3, v2, [I

    const v4, 0x8b82

    invoke-static {v1, v4, v3, v0}, Landroid/opengl/GLES20;->glGetProgramiv(II[II)V

    aget v3, v3, v0

    if-eq v3, v2, :cond_2

    invoke-static {p1}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    invoke-static {p2}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    invoke-static {v1}, Landroid/opengl/GLES20;->glDeleteProgram(I)V

    goto :goto_0

    :cond_2
    move v0, v1

    :goto_0
    return v0
.end method

.method static synthetic a(Lcom/smrtbeat/s;)Landroid/graphics/Bitmap;
    .locals 0

    iget-object p0, p0, Lcom/smrtbeat/s;->n:Landroid/graphics/Bitmap;

    return-object p0
.end method

.method static synthetic a(Lcom/smrtbeat/s;Ljava/lang/Thread;)Ljava/lang/Thread;
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/s;->q:Ljava/lang/Thread;

    return-object p1
.end method

.method private a(IIIIIZFZ)V
    .locals 17

    move-object/from16 v0, p0

    const/16 v2, 0x8

    new-array v3, v2, [F

    fill-array-data v3, :array_0

    iget v4, v0, Lcom/smrtbeat/s;->a:I

    iget v5, v0, Lcom/smrtbeat/s;->b:I

    iget v6, v0, Lcom/smrtbeat/s;->c:I

    move/from16 v7, p4

    int-to-float v7, v7

    move/from16 v8, p3

    int-to-float v8, v8

    div-float/2addr v7, v8

    div-float v7, v7, p7

    move/from16 v9, p5

    int-to-float v9, v9

    div-float/2addr v9, v8

    div-float v9, v9, p7

    new-array v1, v2, [F

    const/4 v8, 0x6

    const/4 v10, 0x3

    const/4 v11, 0x2

    const/4 v12, 0x1

    const/4 v13, 0x5

    const/4 v14, 0x4

    const/4 v15, 0x0

    const/4 v2, 0x0

    if-eqz p8, :cond_0

    aput v15, v1, v2

    aput v9, v1, v12

    const/high16 v7, 0x3f800000    # 1.0f

    aput v7, v1, v11

    aput v9, v1, v10

    aput v15, v1, v14

    sub-float/2addr v9, v7

    aput v9, v1, v13

    aput v7, v1, v8

    const/16 v16, 0x7

    aput v9, v1, v16

    goto :goto_0

    :cond_0
    const/16 v16, 0x7

    aput v15, v1, v2

    aput v15, v1, v12

    aput v7, v1, v11

    aput v15, v1, v10

    aput v15, v1, v14

    aput v9, v1, v13

    aput v7, v1, v8

    aput v9, v1, v16

    :goto_0
    invoke-static/range {p2 .. p2}, Landroid/opengl/GLES20;->glUseProgram(I)V

    iget-object v7, v0, Lcom/smrtbeat/s;->v:Ljava/nio/FloatBuffer;

    invoke-virtual {v7, v2}, Ljava/nio/FloatBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v7, v0, Lcom/smrtbeat/s;->v:Ljava/nio/FloatBuffer;

    invoke-virtual {v7, v3}, Ljava/nio/FloatBuffer;->put([F)Ljava/nio/FloatBuffer;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/nio/FloatBuffer;->position(I)Ljava/nio/Buffer;

    invoke-static {v4}, Landroid/opengl/GLES20;->glEnableVertexAttribArray(I)V

    iget-object v3, v0, Lcom/smrtbeat/s;->v:Ljava/nio/FloatBuffer;

    const/4 v7, 0x2

    const/16 v8, 0x1406

    const/4 v9, 0x0

    const/4 v10, 0x0

    move/from16 p2, v4

    move/from16 p3, v7

    move/from16 p4, v8

    move/from16 p5, v9

    move/from16 p6, v10

    move-object/from16 p7, v3

    invoke-static/range {p2 .. p7}, Landroid/opengl/GLES20;->glVertexAttribPointer(IIIZILjava/nio/Buffer;)V

    iget-object v3, v0, Lcom/smrtbeat/s;->w:Ljava/nio/FloatBuffer;

    invoke-virtual {v3, v2}, Ljava/nio/FloatBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v3, v0, Lcom/smrtbeat/s;->w:Ljava/nio/FloatBuffer;

    invoke-virtual {v3, v1}, Ljava/nio/FloatBuffer;->put([F)Ljava/nio/FloatBuffer;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/nio/FloatBuffer;->position(I)Ljava/nio/Buffer;

    invoke-static {v5}, Landroid/opengl/GLES20;->glEnableVertexAttribArray(I)V

    iget-object v1, v0, Lcom/smrtbeat/s;->w:Ljava/nio/FloatBuffer;

    const/4 v3, 0x2

    const/16 v4, 0x1406

    const/4 v7, 0x0

    const/4 v8, 0x0

    move/from16 p2, v5

    move/from16 p3, v3

    move/from16 p4, v4

    move/from16 p5, v7

    move/from16 p6, v8

    move-object/from16 p7, v1

    invoke-static/range {p2 .. p7}, Landroid/opengl/GLES20;->glVertexAttribPointer(IIIZILjava/nio/Buffer;)V

    const v1, 0x84c0

    invoke-static {v1}, Landroid/opengl/GLES20;->glActiveTexture(I)V

    const/16 v1, 0xde1

    move/from16 v3, p1

    invoke-static {v1, v3}, Landroid/opengl/GLES20;->glBindTexture(II)V

    invoke-static {v6, v2}, Landroid/opengl/GLES20;->glUniform1i(II)V

    invoke-static {v13, v2, v14}, Landroid/opengl/GLES20;->glDrawArrays(III)V

    invoke-static {v1, v2}, Landroid/opengl/GLES20;->glBindTexture(II)V

    return-void

    :array_0
    .array-data 4
        -0x40800000    # -1.0f
        -0x40800000    # -1.0f
        0x3f800000    # 1.0f
        -0x40800000    # -1.0f
        -0x40800000    # -1.0f
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
    .end array-data
.end method

.method static synthetic a(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Lcom/smrtbeat/s;->c(Ljava/lang/String;)V

    return-void
.end method

.method static a(Z)V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/s;->g()Lcom/smrtbeat/s;

    move-result-object v0

    invoke-direct {v0}, Lcom/smrtbeat/s;->d()V

    invoke-static {}, Lcom/smrtbeat/s;->g()Lcom/smrtbeat/s;

    move-result-object v0

    iput-boolean p0, v0, Lcom/smrtbeat/s;->u:Z

    return-void
.end method

.method static synthetic b(Lcom/smrtbeat/s;)Landroid/graphics/Canvas;
    .locals 0

    iget-object p0, p0, Lcom/smrtbeat/s;->p:Landroid/graphics/Canvas;

    return-object p0
.end method

.method static b(Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/s;->g()Lcom/smrtbeat/s;

    move-result-object v0

    iget-object v0, v0, Lcom/smrtbeat/s;->x:Ljava/util/List;

    monitor-enter v0

    :try_start_0
    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method static b()Z
    .locals 1

    invoke-static {}, Lcom/smrtbeat/s;->g()Lcom/smrtbeat/s;

    move-result-object v0

    invoke-direct {v0}, Lcom/smrtbeat/s;->c()V

    const-string v0, "beginOnDrawFrame"

    invoke-static {v0}, Lcom/smrtbeat/s;->c(Ljava/lang/String;)V

    invoke-static {}, Lcom/smrtbeat/s;->g()Lcom/smrtbeat/s;

    move-result-object v0

    iget-boolean v0, v0, Lcom/smrtbeat/s;->r:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/smrtbeat/s;->g()Lcom/smrtbeat/s;

    move-result-object v0

    iget-boolean v0, v0, Lcom/smrtbeat/s;->s:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private b(II)Z
    .locals 19

    move-object/from16 v0, p0

    const/4 v1, 0x1

    new-array v2, v1, [I

    invoke-direct/range {p0 .. p2}, Lcom/smrtbeat/s;->c(II)I

    move-result v7

    const/4 v12, 0x0

    invoke-static {v1, v2, v12}, Landroid/opengl/GLES20;->glGenFramebuffers(I[II)V

    aget v3, v2, v12

    iput v3, v0, Lcom/smrtbeat/s;->g:I

    const v13, 0x8d40

    invoke-static {v13, v3}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x12

    if-lt v3, v4, :cond_0

    const/4 v5, 0x1

    goto :goto_0

    :cond_0
    const/4 v5, 0x0

    :goto_0
    iget v6, v0, Lcom/smrtbeat/s;->l:I

    move/from16 v8, p1

    move/from16 v9, p2

    invoke-static {v8, v9, v6, v5}, Lcom/smrtbeat/SmartBeatJni;->newImageTargetTexture(IIII)I

    move-result v5

    iput v5, v0, Lcom/smrtbeat/s;->i:I

    if-gtz v5, :cond_1

    invoke-static {v1, v2, v12}, Landroid/opengl/GLES20;->glDeleteFramebuffers(I[II)V

    iput v12, v0, Lcom/smrtbeat/s;->g:I

    return v12

    :cond_1
    const/16 v14, 0xde1

    invoke-static {v14, v5}, Landroid/opengl/GLES20;->glBindTexture(II)V

    const/16 v15, 0x2801

    const/16 v11, 0x2600

    invoke-static {v14, v15, v11}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    const/16 v10, 0x2800

    invoke-static {v14, v10, v11}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    iget v5, v0, Lcom/smrtbeat/s;->i:I

    const v9, 0x8ce0

    invoke-static {v13, v9, v14, v5, v12}, Landroid/opengl/GLES20;->glFramebufferTexture2D(IIIII)V

    invoke-static {v13}, Landroid/opengl/GLES20;->glCheckFramebufferStatus(I)I

    move-result v5

    const v8, 0x8cd5

    if-eq v5, v8, :cond_2

    sget-object v2, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v12

    const-string v3, "failed to init fbo1 : %d"

    invoke-static {v3, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return v12

    :cond_2
    invoke-static {v1, v2, v12}, Landroid/opengl/GLES20;->glGenFramebuffers(I[II)V

    aget v5, v2, v12

    iput v5, v0, Lcom/smrtbeat/s;->f:I

    invoke-static {v13, v5}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    invoke-static {v1, v2, v12}, Landroid/opengl/GLES20;->glGenRenderbuffers(I[II)V

    aget v5, v2, v12

    const v6, 0x8d41

    invoke-static {v6, v5}, Landroid/opengl/GLES20;->glBindRenderbuffer(II)V

    if-lt v3, v4, :cond_4

    invoke-static {}, Lcom/smrtbeat/s;->a()I

    move-result v3

    invoke-static {v6, v3, v7, v7}, Landroid/opengl/GLES20;->glRenderbufferStorage(IIII)V

    invoke-static {}, Landroid/opengl/GLES20;->glGetError()I

    move-result v3

    if-eqz v3, :cond_3

    invoke-static {v6, v12}, Landroid/opengl/GLES20;->glBindRenderbuffer(II)V

    invoke-static {v1, v2, v12}, Landroid/opengl/GLES20;->glDeleteRenderbuffers(I[II)V

    goto :goto_1

    :cond_3
    aget v3, v2, v12

    const v4, 0x8d20

    invoke-static {v13, v4, v6, v3}, Landroid/opengl/GLES20;->glFramebufferRenderbuffer(IIII)V

    :cond_4
    :goto_1
    invoke-static {v1, v2, v12}, Landroid/opengl/GLES20;->glGenTextures(I[II)V

    aget v2, v2, v12

    iput v2, v0, Lcom/smrtbeat/s;->h:I

    invoke-static {v14, v2}, Landroid/opengl/GLES20;->glBindTexture(II)V

    const/16 v3, 0xde1

    const/4 v4, 0x0

    const/16 v5, 0x1908

    const/4 v2, 0x0

    const/16 v16, 0x1908

    const/16 v17, 0x1401

    const/16 v18, 0x0

    move v6, v7

    const v1, 0x8cd5

    move v8, v2

    const v2, 0x8ce0

    move/from16 v9, v16

    const/16 v1, 0x2800

    move/from16 v10, v17

    const/16 v2, 0x2600

    move-object/from16 v11, v18

    invoke-static/range {v3 .. v11}, Landroid/opengl/GLES20;->glTexImage2D(IIIIIIIILjava/nio/Buffer;)V

    invoke-static {v14, v15, v2}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    invoke-static {v14, v1, v2}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    const/16 v1, 0x2802

    const v2, 0x812f

    invoke-static {v14, v1, v2}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    const/16 v1, 0x2803

    invoke-static {v14, v1, v2}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    iget v1, v0, Lcom/smrtbeat/s;->h:I

    const v2, 0x8ce0

    invoke-static {v13, v2, v14, v1, v12}, Landroid/opengl/GLES20;->glFramebufferTexture2D(IIIII)V

    invoke-static {v13}, Landroid/opengl/GLES20;->glCheckFramebufferStatus(I)I

    move-result v1

    const v2, 0x8cd5

    if-eq v1, v2, :cond_5

    sget-object v2, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v3, v12

    const-string v1, "failed to init fbo2 : %d"

    invoke-static {v1, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return v12

    :cond_5
    const/16 v1, 0x20

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->asFloatBuffer()Ljava/nio/FloatBuffer;

    move-result-object v2

    iput-object v2, v0, Lcom/smrtbeat/s;->v:Ljava/nio/FloatBuffer;

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->asFloatBuffer()Ljava/nio/FloatBuffer;

    move-result-object v1

    iput-object v1, v0, Lcom/smrtbeat/s;->w:Ljava/nio/FloatBuffer;

    const/4 v1, 0x1

    return v1
.end method

.method private c(II)I
    .locals 0

    invoke-static {p1, p2}, Ljava/lang/Math;->max(II)I

    move-result p1

    const/16 p2, 0x100

    :goto_0
    if-ge p2, p1, :cond_0

    if-lez p2, :cond_0

    shl-int/lit8 p2, p2, 0x1

    goto :goto_0

    :cond_0
    return p2
.end method

.method static synthetic c(Lcom/smrtbeat/s;)Landroid/graphics/Bitmap;
    .locals 0

    iget-object p0, p0, Lcom/smrtbeat/s;->o:Landroid/graphics/Bitmap;

    return-object p0
.end method

.method private c()V
    .locals 3

    invoke-direct {p0}, Lcom/smrtbeat/s;->i()V

    iget-boolean v0, p0, Lcom/smrtbeat/s;->r:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/smrtbeat/s;->s:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/smrtbeat/s;->f:I

    if-lez v0, :cond_1

    invoke-direct {p0}, Lcom/smrtbeat/s;->k()Z

    move-result v0

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/smrtbeat/s;->f:I

    const v2, 0x8d40

    invoke-static {v2, v0}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    const/16 v0, 0x4100

    invoke-static {v0}, Landroid/opengl/GLES20;->glClear(I)V

    iput-boolean v1, p0, Lcom/smrtbeat/s;->e:Z

    :cond_1
    :goto_0
    return-void
.end method

.method private static c(Ljava/lang/String;)V
    .locals 4

    :goto_0
    invoke-static {}, Landroid/opengl/GLES20;->glGetError()I

    move-result v0

    if-eqz v0, :cond_0

    sget-object v1, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p0, v2, v3

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const/4 v3, 0x1

    aput-object v0, v2, v3

    const-string v0, "%s:glErrro %d"

    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method private d()V
    .locals 3

    const-string v0, "cleanup"

    invoke-static {v0}, Lcom/smrtbeat/s;->c(Ljava/lang/String;)V

    const/4 v0, 0x0

    iput v0, p0, Lcom/smrtbeat/s;->d:I

    const/4 v1, -0x1

    iput v1, p0, Lcom/smrtbeat/s;->f:I

    iput v0, p0, Lcom/smrtbeat/s;->g:I

    iput v0, p0, Lcom/smrtbeat/s;->j:I

    iput v0, p0, Lcom/smrtbeat/s;->k:I

    iget-object v0, p0, Lcom/smrtbeat/s;->n:Landroid/graphics/Bitmap;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    iput-object v1, p0, Lcom/smrtbeat/s;->n:Landroid/graphics/Bitmap;

    :cond_0
    iget-object v0, p0, Lcom/smrtbeat/s;->o:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_1

    sget-object v2, Lcom/smrtbeat/j$a;->c:Lcom/smrtbeat/j$a;

    invoke-static {v2, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/j$a;Landroid/graphics/Bitmap;)V

    iput-object v1, p0, Lcom/smrtbeat/s;->o:Landroid/graphics/Bitmap;

    :cond_1
    iget-object v0, p0, Lcom/smrtbeat/s;->p:Landroid/graphics/Canvas;

    if-eqz v0, :cond_2

    iput-object v1, p0, Lcom/smrtbeat/s;->p:Landroid/graphics/Canvas;

    :cond_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/smrtbeat/s;->t:J

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/smrtbeat/s;->r:Z

    return-void
.end method

.method private d(Ljava/lang/String;)Z
    .locals 6

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    :cond_0
    iget-object v1, p0, Lcom/smrtbeat/s;->x:Ljava/util/List;

    monitor-enter v1

    :try_start_0
    iget-object v2, p0, Lcom/smrtbeat/s;->x:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    sget-object v2, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v3, "this model(%s) is allowd by custmer whitelist"

    const/4 v4, 0x1

    :try_start_1
    new-array v5, v4, [Ljava/lang/Object;

    aput-object p1, v5, v0

    invoke-static {v3, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {v2, p1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    monitor-exit v1

    return v4

    :cond_2
    monitor-exit v1

    return v0

    :catchall_0
    move-exception p1

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method static e()V
    .locals 1

    invoke-static {}, Lcom/smrtbeat/s;->g()Lcom/smrtbeat/s;

    move-result-object v0

    invoke-direct {v0}, Lcom/smrtbeat/s;->f()V

    const-string v0, "endOnDrawFrame"

    invoke-static {v0}, Lcom/smrtbeat/s;->c(Ljava/lang/String;)V

    return-void
.end method

.method static e(Ljava/lang/String;)Z
    .locals 1

    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-static {p0}, Lcom/smrtbeat/l;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 p0, 0x1

    return p0

    :cond_1
    invoke-static {}, Lcom/smrtbeat/s;->g()Lcom/smrtbeat/s;

    move-result-object v0

    invoke-direct {v0, p0}, Lcom/smrtbeat/s;->d(Ljava/lang/String;)Z

    move-result p0

    return p0

    :cond_2
    :goto_0
    const/4 p0, 0x0

    return p0
.end method

.method private f()V
    .locals 15

    iget-boolean v0, p0, Lcom/smrtbeat/s;->r:Z

    if-eqz v0, :cond_3

    iget-boolean v0, p0, Lcom/smrtbeat/s;->s:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto/16 :goto_0

    :cond_0
    iget-boolean v0, p0, Lcom/smrtbeat/s;->e:Z

    if-nez v0, :cond_1

    return-void

    :cond_1
    new-array v0, v1, [I

    const v2, 0x8ca6

    const/4 v3, 0x0

    invoke-static {v2, v0, v3}, Landroid/opengl/GLES20;->glGetIntegerv(I[II)V

    aget v0, v0, v3

    iget v2, p0, Lcom/smrtbeat/s;->f:I

    if-ne v0, v2, :cond_2

    iget v0, p0, Lcom/smrtbeat/s;->j:I

    iget v2, p0, Lcom/smrtbeat/s;->k:I

    invoke-direct {p0, v0, v2}, Lcom/smrtbeat/s;->c(II)I

    move-result v0

    new-instance v2, Lcom/smrtbeat/s$b;

    invoke-direct {v2, p0}, Lcom/smrtbeat/s$b;-><init>(Lcom/smrtbeat/s;)V

    iget v4, p0, Lcom/smrtbeat/s;->h:I

    invoke-virtual {v2, v4, v1}, Lcom/smrtbeat/s$b;->a(IZ)V

    iget v4, p0, Lcom/smrtbeat/s;->g:I

    const v13, 0x8d40

    invoke-static {v13, v4}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    const/16 v14, 0x4100

    invoke-static {v14}, Landroid/opengl/GLES20;->glClear(I)V

    iget v4, p0, Lcom/smrtbeat/s;->l:I

    invoke-static {v3, v3, v4, v4}, Landroid/opengl/GLES20;->glViewport(IIII)V

    iget v5, p0, Lcom/smrtbeat/s;->h:I

    iget v6, p0, Lcom/smrtbeat/s;->d:I

    iget v8, p0, Lcom/smrtbeat/s;->j:I

    iget v9, p0, Lcom/smrtbeat/s;->k:I

    const/4 v10, 0x0

    const/high16 v11, 0x3f800000    # 1.0f

    const/4 v12, 0x1

    move-object v4, p0

    move v7, v0

    invoke-direct/range {v4 .. v12}, Lcom/smrtbeat/s;->a(IIIIIZFZ)V

    invoke-virtual {v2, v1, v3}, Lcom/smrtbeat/s$b;->a(ZZ)V

    new-instance v2, Ljava/lang/Thread;

    new-instance v4, Lcom/smrtbeat/s$a;

    invoke-direct {v4, p0}, Lcom/smrtbeat/s$a;-><init>(Lcom/smrtbeat/s;)V

    iget-object v5, p0, Lcom/smrtbeat/s;->m:Ljava/nio/ByteBuffer;

    invoke-virtual {v4, v5}, Lcom/smrtbeat/s$a;->a(Ljava/nio/ByteBuffer;)Ljava/lang/Runnable;

    move-result-object v4

    invoke-direct {v2, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    iput-object v2, p0, Lcom/smrtbeat/s;->q:Ljava/lang/Thread;

    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    new-instance v2, Lcom/smrtbeat/s$b;

    invoke-direct {v2, p0}, Lcom/smrtbeat/s$b;-><init>(Lcom/smrtbeat/s;)V

    iget v4, p0, Lcom/smrtbeat/s;->h:I

    invoke-virtual {v2, v4, v1}, Lcom/smrtbeat/s$b;->a(IZ)V

    invoke-static {v13, v3}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    invoke-static {v14}, Landroid/opengl/GLES20;->glClear(I)V

    iget v4, p0, Lcom/smrtbeat/s;->j:I

    iget v5, p0, Lcom/smrtbeat/s;->k:I

    invoke-static {v3, v3, v4, v5}, Landroid/opengl/GLES20;->glViewport(IIII)V

    iget v5, p0, Lcom/smrtbeat/s;->h:I

    iget v6, p0, Lcom/smrtbeat/s;->d:I

    iget v8, p0, Lcom/smrtbeat/s;->j:I

    iget v9, p0, Lcom/smrtbeat/s;->k:I

    const/4 v12, 0x0

    move-object v4, p0

    invoke-direct/range {v4 .. v12}, Lcom/smrtbeat/s;->a(IIIIIZFZ)V

    invoke-virtual {v2, v1, v3}, Lcom/smrtbeat/s$b;->a(ZZ)V

    :cond_2
    iput-boolean v3, p0, Lcom/smrtbeat/s;->e:Z

    :cond_3
    :goto_0
    return-void
.end method

.method private static g()Lcom/smrtbeat/s;
    .locals 2

    sget-object v0, Lcom/smrtbeat/s;->C:Lcom/smrtbeat/s;

    if-nez v0, :cond_1

    const-class v0, Lcom/smrtbeat/s;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/smrtbeat/s;->C:Lcom/smrtbeat/s;

    if-nez v1, :cond_0

    new-instance v1, Lcom/smrtbeat/s;

    invoke-direct {v1}, Lcom/smrtbeat/s;-><init>()V

    sput-object v1, Lcom/smrtbeat/s;->C:Lcom/smrtbeat/s;

    :cond_0
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    :cond_1
    :goto_0
    sget-object v0, Lcom/smrtbeat/s;->C:Lcom/smrtbeat/s;

    return-object v0
.end method

.method private h()Z
    .locals 4

    const-string v0, "attribute vec2 aPosition;\nattribute vec2 aTextureCoord;\nvarying vec2 vTextureCoord;\nvoid main() {\n  gl_Position = vec4(aPosition, 0.0, 1.0);\n  vTextureCoord = aTextureCoord;\n}\n"

    const-string v1, "precision mediump float;\nvarying vec2 vTextureCoord;\nuniform sampler2D sTexture;\nvoid main() {\n  gl_FragColor = texture2D(sTexture, vTextureCoord);\n}\n"

    invoke-direct {p0, v0, v1}, Lcom/smrtbeat/s;->a(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/smrtbeat/s;->d:I

    const-string v1, "aPosition"

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/smrtbeat/s;->a:I

    const-string v0, "glGetAttribLocation aPosition"

    invoke-static {v0}, Lcom/smrtbeat/s;->c(Ljava/lang/String;)V

    iget v0, p0, Lcom/smrtbeat/s;->a:I

    const/4 v1, 0x0

    const/4 v2, -0x1

    if-ne v0, v2, :cond_0

    sget-object v0, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    const-string v2, "Could not get attrib location for aPosition"

    :goto_0
    invoke-static {v0, v2}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return v1

    :cond_0
    iget v0, p0, Lcom/smrtbeat/s;->d:I

    const-string v3, "aTextureCoord"

    invoke-static {v0, v3}, Landroid/opengl/GLES20;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/smrtbeat/s;->b:I

    const-string v0, "glGetAttribLocation aTextureCoord"

    invoke-static {v0}, Lcom/smrtbeat/s;->c(Ljava/lang/String;)V

    iget v0, p0, Lcom/smrtbeat/s;->b:I

    if-ne v0, v2, :cond_1

    sget-object v0, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    const-string v2, "Could not get attrib location for aTextureCoord"

    goto :goto_0

    :cond_1
    iget v0, p0, Lcom/smrtbeat/s;->d:I

    const-string v3, "sTexture"

    invoke-static {v0, v3}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/smrtbeat/s;->c:I

    const-string v0, "glGetAttribLocation sTexture"

    invoke-static {v0}, Lcom/smrtbeat/s;->c(Ljava/lang/String;)V

    iget v0, p0, Lcom/smrtbeat/s;->c:I

    if-ne v0, v2, :cond_2

    sget-object v0, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    const-string v2, "Could not get attrib location for sTexture"

    goto :goto_0

    :cond_2
    const/4 v0, 0x1

    return v0
.end method

.method private i()V
    .locals 8

    iget-boolean v0, p0, Lcom/smrtbeat/s;->r:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget v0, p0, Lcom/smrtbeat/s;->f:I

    if-lez v0, :cond_1

    return-void

    :cond_1
    invoke-static {}, Ljavax/microedition/khronos/egl/EGLContext;->getEGL()Ljavax/microedition/khronos/egl/EGL;

    move-result-object v0

    check-cast v0, Ljavax/microedition/khronos/egl/EGL10;

    invoke-static {}, Lcom/smrtbeat/f0;->g()Z

    move-result v1

    const/4 v2, 0x1

    xor-int/2addr v1, v2

    iput-boolean v1, p0, Lcom/smrtbeat/s;->s:Z

    if-ne v1, v2, :cond_2

    return-void

    :cond_2
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0xe

    const/4 v4, 0x0

    if-ge v1, v3, :cond_3

    sget-object v0, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;

    const-string v1, "Not support ScreenCapture(GLES) (supports from Android 4.0)"

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    iput-boolean v4, p0, Lcom/smrtbeat/s;->r:Z

    return-void

    :cond_3
    sget v3, Lcom/smrtbeat/j;->G:I

    const/4 v5, 0x2

    if-ge v3, v5, :cond_5

    if-nez v3, :cond_4

    sget-object v0, Lcom/smrtbeat/f0$e;->b:Lcom/smrtbeat/f0$e;

    const-string v1, "OpenGLES version may not be set. Please set version!"

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :cond_4
    sget-object v0, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;

    const-string v1, "Not support ScreenCapture(GLES) (supports from ES2.0)"

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    iput-boolean v4, p0, Lcom/smrtbeat/s;->r:Z

    return-void

    :cond_5
    invoke-direct {p0}, Lcom/smrtbeat/s;->j()Z

    move-result v3

    if-nez v3, :cond_6

    sget-object v0, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v4}, Lcom/smrtbeat/f0;->a(I)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v1, v4

    const-string v2, "Not supported ScreenCapture(GLES) (NDK load failed arch=%s)"

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    iput-boolean v4, p0, Lcom/smrtbeat/s;->r:Z

    return-void

    :cond_6
    sget-object v3, Landroid/os/Build;->MODEL:Ljava/lang/String;

    if-eqz v3, :cond_10

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v5

    if-gtz v5, :cond_7

    goto/16 :goto_1

    :cond_7
    invoke-static {v3}, Lcom/smrtbeat/l;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_8

    invoke-direct {p0, v3}, Lcom/smrtbeat/s;->d(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_8

    iput-boolean v4, p0, Lcom/smrtbeat/s;->r:Z

    sget-object v0, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;

    new-array v1, v2, [Ljava/lang/Object;

    aput-object v3, v1, v4

    const-string v2, "Not support ScreenCapture(GLES) (unsupport model:%s)"

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return-void

    :cond_8
    iget-boolean v3, p0, Lcom/smrtbeat/s;->u:Z

    if-eqz v3, :cond_9

    const/16 v3, 0x12

    if-ge v1, v3, :cond_9

    sget-object v0, Lcom/smrtbeat/f0$e;->c:Lcom/smrtbeat/f0$e;

    const-string v1, "Android version must be JBMR2 or more for screen capture with Stencil Buffer."

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    iput-boolean v4, p0, Lcom/smrtbeat/s;->r:Z

    return-void

    :cond_9
    invoke-interface {v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetCurrentDisplay()Ljavax/microedition/khronos/egl/EGLDisplay;

    move-result-object v3

    const/16 v5, 0x3059

    invoke-interface {v0, v5}, Ljavax/microedition/khronos/egl/EGL10;->eglGetCurrentSurface(I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v5

    new-array v6, v2, [I

    const/16 v7, 0x3057

    invoke-interface {v0, v3, v5, v7, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglQuerySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;I[I)Z

    aget v7, v6, v4

    iput v7, p0, Lcom/smrtbeat/s;->j:I

    const/16 v7, 0x3056

    invoke-interface {v0, v3, v5, v7, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglQuerySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;I[I)Z

    aget v0, v6, v4

    iput v0, p0, Lcom/smrtbeat/s;->k:I

    iget v3, p0, Lcom/smrtbeat/s;->j:I

    if-lez v3, :cond_a

    if-gtz v0, :cond_c

    :cond_a
    const/16 v0, 0x11

    if-lt v1, v0, :cond_b

    invoke-static {}, Lcom/smrtbeat/v;->a()Landroid/graphics/Point;

    move-result-object v0

    iget v1, v0, Landroid/graphics/Point;->x:I

    iput v1, p0, Lcom/smrtbeat/s;->j:I

    iget v0, v0, Landroid/graphics/Point;->y:I

    iput v0, p0, Lcom/smrtbeat/s;->k:I

    :cond_b
    iget v0, p0, Lcom/smrtbeat/s;->j:I

    if-lez v0, :cond_f

    iget v0, p0, Lcom/smrtbeat/s;->k:I

    if-gtz v0, :cond_c

    goto/16 :goto_0

    :cond_c
    iget v0, p0, Lcom/smrtbeat/s;->j:I

    iget v1, p0, Lcom/smrtbeat/s;->k:I

    invoke-direct {p0, v0, v1}, Lcom/smrtbeat/s;->a(II)I

    move-result v0

    iput v0, p0, Lcom/smrtbeat/s;->l:I

    const/16 v0, 0x1f00

    invoke-static {v0}, Landroid/opengl/GLES20;->glGetString(I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/j;->a0:Ljava/lang/String;

    const/16 v0, 0x1f01

    invoke-static {v0}, Landroid/opengl/GLES20;->glGetString(I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/j;->b0:Ljava/lang/String;

    const/16 v0, 0x1f02

    invoke-static {v0}, Landroid/opengl/GLES20;->glGetString(I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/j;->c0:Ljava/lang/String;

    new-instance v0, Lcom/smrtbeat/s$b;

    invoke-direct {v0, p0}, Lcom/smrtbeat/s$b;-><init>(Lcom/smrtbeat/s;)V

    invoke-virtual {v0, v4, v2}, Lcom/smrtbeat/s$b;->a(IZ)V

    iget v1, p0, Lcom/smrtbeat/s;->j:I

    iget v3, p0, Lcom/smrtbeat/s;->k:I

    invoke-direct {p0, v1, v3}, Lcom/smrtbeat/s;->b(II)Z

    move-result v1

    iput-boolean v1, p0, Lcom/smrtbeat/s;->r:Z

    invoke-virtual {v0, v2, v2}, Lcom/smrtbeat/s$b;->a(ZZ)V

    iget-boolean v0, p0, Lcom/smrtbeat/s;->r:Z

    if-nez v0, :cond_d

    sget-object v0, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;

    const-string v1, "Not support ScreenCapture(GLES) (failed to alloc memory)"

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/smrtbeat/s;->d()V

    iput-boolean v4, p0, Lcom/smrtbeat/s;->r:Z

    return-void

    :cond_d
    invoke-direct {p0}, Lcom/smrtbeat/s;->h()Z

    move-result v0

    if-nez v0, :cond_e

    sget-object v0, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    const-string v1, "failed to init"

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/smrtbeat/s;->d()V

    iput-boolean v4, p0, Lcom/smrtbeat/s;->r:Z

    return-void

    :cond_e
    invoke-static {}, Lcom/smrtbeat/SmartBeatJni;->getTextureLongerSideLength()I

    move-result v0

    mul-int v1, v0, v0

    mul-int/lit8 v1, v1, 0x4

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    iput-object v1, p0, Lcom/smrtbeat/s;->m:Ljava/nio/ByteBuffer;

    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v0, v1}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    iput-object v0, p0, Lcom/smrtbeat/s;->n:Landroid/graphics/Bitmap;

    iget v0, p0, Lcom/smrtbeat/s;->j:I

    iget v1, p0, Lcom/smrtbeat/s;->k:I

    invoke-direct {p0, v0, v1}, Lcom/smrtbeat/s;->c(II)I

    move-result v0

    iget v1, p0, Lcom/smrtbeat/s;->l:I

    div-int/2addr v0, v1

    iget v1, p0, Lcom/smrtbeat/s;->j:I

    div-int/2addr v1, v0

    iget v2, p0, Lcom/smrtbeat/s;->k:I

    div-int/2addr v2, v0

    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v1, v2, v0}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    iput-object v0, p0, Lcom/smrtbeat/s;->o:Landroid/graphics/Bitmap;

    new-instance v0, Landroid/graphics/Canvas;

    iget-object v1, p0, Lcom/smrtbeat/s;->o:Landroid/graphics/Bitmap;

    invoke-direct {v0, v1}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    iput-object v0, p0, Lcom/smrtbeat/s;->p:Landroid/graphics/Canvas;

    return-void

    :cond_f
    :goto_0
    iput-boolean v4, p0, Lcom/smrtbeat/s;->r:Z

    return-void

    :cond_10
    :goto_1
    sget-object v0, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;

    const-string v1, "Not supported ScreenCapture(GLES) (model name is missing)"

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    iput-boolean v4, p0, Lcom/smrtbeat/s;->r:Z

    return-void
.end method

.method private j()Z
    .locals 1

    sget-boolean v0, Lcom/smrtbeat/j;->F:Z

    return v0
.end method

.method private k()Z
    .locals 8

    iget-object v0, p0, Lcom/smrtbeat/s;->q:Ljava/lang/Thread;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    iget-boolean v0, p0, Lcom/smrtbeat/s;->e:Z

    if-eqz v0, :cond_1

    return v1

    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-wide v4, p0, Lcom/smrtbeat/s;->t:J

    sub-long v4, v2, v4

    const-wide/16 v6, 0x3e8

    cmp-long v0, v4, v6

    if-gez v0, :cond_2

    return v1

    :cond_2
    sget-boolean v0, Lcom/smrtbeat/j;->Z:Z

    if-eqz v0, :cond_3

    return v1

    :cond_3
    iput-wide v2, p0, Lcom/smrtbeat/s;->t:J

    const/4 v0, 0x1

    return v0
.end method

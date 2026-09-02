.class public abstract Lcom/android/vending/expansion/zipfile/APEZProvider;
.super Landroid/content/ContentProvider;
.source "APEZProvider.java"


# static fields
.field public static final ALL_FIELDS:[Ljava/lang/String;

.field public static final ALL_FIELDS_INT:[I

.field public static final COMPLEN_IDX:I = 0x5

.field public static final COMPRESSEDLEN:Ljava/lang/String; = "ZCOL"

.field public static final COMPRESSIONTYPE:Ljava/lang/String; = "ZTYP"

.field public static final COMPTYPE_IDX:I = 0x7

.field public static final CRC32:Ljava/lang/String; = "ZCRC"

.field public static final CRC_IDX:I = 0x4

.field public static final FILEID:Ljava/lang/String; = "_id"

.field public static final FILEID_IDX:I = 0x0

.field public static final FILENAME:Ljava/lang/String; = "ZPFN"

.field public static final FILENAME_IDX:I = 0x1

.field public static final MODIFICATION:Ljava/lang/String; = "ZMOD"

.field public static final MOD_IDX:I = 0x3

.field private static final NO_FILE:Ljava/lang/String; = "N"

.field public static final UNCOMPLEN_IDX:I = 0x6

.field public static final UNCOMPRESSEDLEN:Ljava/lang/String; = "ZUNL"

.field public static final ZIPFILE:Ljava/lang/String; = "ZFIL"

.field public static final ZIPFILE_IDX:I = 0x2


# instance fields
.field private mAPKExtensionFile:Lcom/android/vending/expansion/zipfile/ZipResourceFile;

.field private mInit:Z


# direct methods
.method static constructor <clinit>()V
    .locals 8

    const-string v0, "_id"

    const-string v1, "ZPFN"

    const-string v2, "ZFIL"

    const-string v3, "ZMOD"

    const-string v4, "ZCRC"

    const-string v5, "ZCOL"

    const-string v6, "ZUNL"

    const-string v7, "ZTYP"

    .line 68
    filled-new-array/range {v0 .. v7}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/android/vending/expansion/zipfile/APEZProvider;->ALL_FIELDS:[Ljava/lang/String;

    const/16 v0, 0x8

    .line 88
    new-array v0, v0, [I

    const/4 v1, 0x1

    aput v1, v0, v1

    const/4 v1, 0x2

    aput v1, v0, v1

    const/4 v1, 0x3

    aput v1, v0, v1

    const/4 v1, 0x4

    aput v1, v0, v1

    const/4 v1, 0x5

    aput v1, v0, v1

    const/4 v1, 0x6

    aput v1, v0, v1

    const/4 v1, 0x7

    aput v1, v0, v1

    sput-object v0, Lcom/android/vending/expansion/zipfile/APEZProvider;->ALL_FIELDS_INT:[I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 54
    invoke-direct {p0}, Landroid/content/ContentProvider;-><init>()V

    return-void
.end method

.method private initIfNecessary()Z
    .locals 10

    .line 124
    iget-boolean v0, p0, Lcom/android/vending/expansion/zipfile/APEZProvider;->mInit:Z

    const/4 v1, 0x0

    if-nez v0, :cond_4

    .line 125
    invoke-virtual {p0}, Lcom/android/vending/expansion/zipfile/APEZProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 126
    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    .line 127
    invoke-virtual {p0}, Lcom/android/vending/expansion/zipfile/APEZProvider;->getAuthority()Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x80

    invoke-virtual {v2, v3, v4}, Landroid/content/pm/PackageManager;->resolveContentProvider(Ljava/lang/String;I)Landroid/content/pm/ProviderInfo;

    move-result-object v3

    .line 130
    :try_start_0
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v2
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_1

    .line 137
    iget v2, v2, Landroid/content/pm/PackageInfo;->versionCode:I

    const/4 v4, 0x0

    .line 139
    iget-object v5, v3, Landroid/content/pm/ProviderInfo;->metaData:Landroid/os/Bundle;

    const/4 v6, 0x1

    if-eqz v5, :cond_1

    .line 140
    iget-object v5, v3, Landroid/content/pm/ProviderInfo;->metaData:Landroid/os/Bundle;

    const-string v7, "mainVersion"

    invoke-virtual {v5, v7, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v5

    .line 141
    iget-object v7, v3, Landroid/content/pm/ProviderInfo;->metaData:Landroid/os/Bundle;

    const-string v8, "patchVersion"

    invoke-virtual {v7, v8, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v2

    .line 142
    iget-object v7, v3, Landroid/content/pm/ProviderInfo;->metaData:Landroid/os/Bundle;

    const-string v8, "mainFilename"

    const-string v9, "N"

    invoke-virtual {v7, v8, v9}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "N"

    if-eq v8, v7, :cond_2

    .line 144
    iget-object v3, v3, Landroid/content/pm/ProviderInfo;->metaData:Landroid/os/Bundle;

    const-string v4, "patchFilename"

    const-string v8, "N"

    invoke-virtual {v3, v4, v8}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "N"

    if-eq v4, v3, :cond_0

    const/4 v4, 0x2

    .line 146
    new-array v4, v4, [Ljava/lang/String;

    aput-object v7, v4, v1

    aput-object v3, v4, v6

    goto :goto_0

    .line 148
    :cond_0
    new-array v4, v6, [Ljava/lang/String;

    aput-object v7, v4, v1

    goto :goto_0

    :cond_1
    move v5, v2

    :cond_2
    :goto_0
    if-nez v4, :cond_3

    .line 156
    :try_start_1
    invoke-static {v0, v5, v2}, Lcom/android/vending/expansion/zipfile/APKExpansionSupport;->getAPKExpansionZipFile(Landroid/content/Context;II)Lcom/android/vending/expansion/zipfile/ZipResourceFile;

    move-result-object v0

    iput-object v0, p0, Lcom/android/vending/expansion/zipfile/APEZProvider;->mAPKExtensionFile:Lcom/android/vending/expansion/zipfile/ZipResourceFile;

    goto :goto_1

    :catch_0
    move-exception v0

    goto :goto_2

    .line 158
    :cond_3
    invoke-static {v4}, Lcom/android/vending/expansion/zipfile/APKExpansionSupport;->getResourceZipFile([Ljava/lang/String;)Lcom/android/vending/expansion/zipfile/ZipResourceFile;

    move-result-object v0

    iput-object v0, p0, Lcom/android/vending/expansion/zipfile/APEZProvider;->mAPKExtensionFile:Lcom/android/vending/expansion/zipfile/ZipResourceFile;

    .line 160
    :goto_1
    iput-boolean v6, p0, Lcom/android/vending/expansion/zipfile/APEZProvider;->mInit:Z
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    return v6

    .line 163
    :goto_2
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    :catch_1
    move-exception v0

    .line 132
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    return v1

    :cond_4
    :goto_3
    return v1
.end method


# virtual methods
.method public applyBatch(Ljava/util/ArrayList;)[Landroid/content/ContentProviderResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Landroid/content/ContentProviderOperation;",
            ">;)[",
            "Landroid/content/ContentProviderResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/content/OperationApplicationException;
        }
    .end annotation

    .line 189
    invoke-direct {p0}, Lcom/android/vending/expansion/zipfile/APEZProvider;->initIfNecessary()Z

    .line 190
    invoke-super {p0, p1}, Landroid/content/ContentProvider;->applyBatch(Ljava/util/ArrayList;)[Landroid/content/ContentProviderResult;

    move-result-object p1

    return-object p1
.end method

.method public delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public abstract getAuthority()Ljava/lang/String;
.end method

.method public getType(Landroid/net/Uri;)Ljava/lang/String;
    .locals 0

    const-string p1, "vnd.android.cursor.item/asset"

    return-object p1
.end method

.method public insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public openAssetFile(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/FileNotFoundException;
        }
    .end annotation

    .line 177
    invoke-direct {p0}, Lcom/android/vending/expansion/zipfile/APEZProvider;->initIfNecessary()Z

    .line 178
    invoke-virtual {p1}, Landroid/net/Uri;->getEncodedPath()Ljava/lang/String;

    move-result-object p1

    const-string p2, "/"

    .line 179
    invoke-virtual {p1, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    const/4 p2, 0x1

    .line 180
    invoke-virtual {p1, p2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    .line 182
    :cond_0
    iget-object p2, p0, Lcom/android/vending/expansion/zipfile/APEZProvider;->mAPKExtensionFile:Lcom/android/vending/expansion/zipfile/ZipResourceFile;

    invoke-virtual {p2, p1}, Lcom/android/vending/expansion/zipfile/ZipResourceFile;->getAssetFileDescriptor(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;

    move-result-object p1

    return-object p1
.end method

.method public openFile(Landroid/net/Uri;Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/FileNotFoundException;
        }
    .end annotation

    .line 196
    invoke-direct {p0}, Lcom/android/vending/expansion/zipfile/APEZProvider;->initIfNecessary()Z

    .line 197
    invoke-virtual {p0, p1, p2}, Lcom/android/vending/expansion/zipfile/APEZProvider;->openAssetFile(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 199
    invoke-virtual {p1}, Landroid/content/res/AssetFileDescriptor;->getParcelFileDescriptor()Landroid/os/ParcelFileDescriptor;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    .locals 8

    .line 207
    invoke-direct {p0}, Lcom/android/vending/expansion/zipfile/APEZProvider;->initIfNecessary()Z

    .line 210
    iget-object p1, p0, Lcom/android/vending/expansion/zipfile/APEZProvider;->mAPKExtensionFile:Lcom/android/vending/expansion/zipfile/ZipResourceFile;

    const/4 p3, 0x0

    if-nez p1, :cond_0

    .line 211
    new-array p1, p3, [Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;

    goto :goto_0

    .line 213
    :cond_0
    iget-object p1, p0, Lcom/android/vending/expansion/zipfile/APEZProvider;->mAPKExtensionFile:Lcom/android/vending/expansion/zipfile/ZipResourceFile;

    invoke-virtual {p1}, Lcom/android/vending/expansion/zipfile/ZipResourceFile;->getAllEntries()[Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;

    move-result-object p1

    :goto_0
    if-nez p2, :cond_1

    .line 217
    sget-object p2, Lcom/android/vending/expansion/zipfile/APEZProvider;->ALL_FIELDS_INT:[I

    .line 218
    sget-object p4, Lcom/android/vending/expansion/zipfile/APEZProvider;->ALL_FIELDS:[Ljava/lang/String;

    move-object v1, p2

    move-object p2, p4

    goto :goto_2

    .line 220
    :cond_1
    array-length p4, p2

    .line 221
    new-array p5, p4, [I

    const/4 v0, 0x0

    :goto_1
    if-lt v0, p4, :cond_4

    move-object v1, p5

    .line 244
    :goto_2
    new-instance v2, Landroid/database/MatrixCursor;

    array-length p4, p1

    invoke-direct {v2, p2, p4}, Landroid/database/MatrixCursor;-><init>([Ljava/lang/String;I)V

    .line 245
    array-length v3, v1

    .line 246
    array-length v4, p1

    const/4 v5, 0x0

    :goto_3
    if-lt v5, v4, :cond_2

    return-object v2

    :cond_2
    aget-object v6, p1, v5

    .line 247
    invoke-virtual {v2}, Landroid/database/MatrixCursor;->newRow()Landroid/database/MatrixCursor$RowBuilder;

    move-result-object v7

    const/4 p2, 0x0

    :goto_4
    if-lt p2, v3, :cond_3

    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    .line 249
    :cond_3
    aget p4, v1, p2

    packed-switch p4, :pswitch_data_0

    goto :goto_5

    .line 272
    :pswitch_0
    iget p4, v6, Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;->mMethod:I

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p4

    invoke-virtual {v7, p4}, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;

    goto :goto_5

    .line 269
    :pswitch_1
    iget-wide p4, v6, Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;->mUncompressedLength:J

    invoke-static {p4, p5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    invoke-virtual {v7, p4}, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;

    goto :goto_5

    .line 266
    :pswitch_2
    iget-wide p4, v6, Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;->mCompressedLength:J

    invoke-static {p4, p5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    invoke-virtual {v7, p4}, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;

    goto :goto_5

    .line 263
    :pswitch_3
    iget-wide p4, v6, Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;->mCRC32:J

    invoke-static {p4, p5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    invoke-virtual {v7, p4}, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;

    goto :goto_5

    .line 260
    :pswitch_4
    iget-wide p4, v6, Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;->mWhenModified:J

    invoke-static {p4, p5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    invoke-virtual {v7, p4}, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;

    goto :goto_5

    .line 257
    :pswitch_5
    invoke-virtual {v6}, Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;->getZipFileName()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {v7, p4}, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;

    goto :goto_5

    .line 254
    :pswitch_6
    iget-object p4, v6, Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;->mFileName:Ljava/lang/String;

    invoke-virtual {v7, p4}, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;

    goto :goto_5

    .line 251
    :pswitch_7
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p4

    invoke-virtual {v7, p4}, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;

    :goto_5
    add-int/lit8 p2, p2, 0x1

    goto :goto_4

    .line 223
    :cond_4
    aget-object v1, p2, v0

    const-string v2, "_id"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 224
    aput p3, p5, v0

    goto :goto_6

    .line 225
    :cond_5
    aget-object v1, p2, v0

    const-string v2, "ZPFN"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6

    const/4 v1, 0x1

    .line 226
    aput v1, p5, v0

    goto :goto_6

    .line 227
    :cond_6
    aget-object v1, p2, v0

    const-string v2, "ZFIL"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    const/4 v1, 0x2

    .line 228
    aput v1, p5, v0

    goto :goto_6

    .line 229
    :cond_7
    aget-object v1, p2, v0

    const-string v2, "ZMOD"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    const/4 v1, 0x3

    .line 230
    aput v1, p5, v0

    goto :goto_6

    .line 231
    :cond_8
    aget-object v1, p2, v0

    const-string v2, "ZCRC"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_9

    const/4 v1, 0x4

    .line 232
    aput v1, p5, v0

    goto :goto_6

    .line 233
    :cond_9
    aget-object v1, p2, v0

    const-string v2, "ZCOL"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_a

    const/4 v1, 0x5

    .line 234
    aput v1, p5, v0

    goto :goto_6

    .line 235
    :cond_a
    aget-object v1, p2, v0

    const-string v2, "ZUNL"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_b

    const/4 v1, 0x6

    .line 236
    aput v1, p5, v0

    goto :goto_6

    .line 237
    :cond_b
    aget-object v1, p2, v0

    const-string v2, "ZTYP"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_c

    const/4 v1, 0x7

    .line 238
    aput v1, p5, v0

    :goto_6
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_1

    .line 240
    :cond_c
    new-instance p1, Ljava/lang/RuntimeException;

    invoke-direct {p1}, Ljava/lang/RuntimeException;-><init>()V

    throw p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

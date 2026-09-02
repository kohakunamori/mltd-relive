.class public Lorg/apache/commons/net/ftp/FTPFile;
.super Ljava/lang/Object;
.source "FTPFile.java"

# interfaces
.implements Ljava/io/Serializable;


# static fields
.field public static final DIRECTORY_TYPE:I = 0x1

.field public static final EXECUTE_PERMISSION:I = 0x2

.field public static final FILE_TYPE:I = 0x0

.field public static final GROUP_ACCESS:I = 0x1

.field public static final READ_PERMISSION:I = 0x0

.field public static final SYMBOLIC_LINK_TYPE:I = 0x2

.field public static final UNKNOWN_TYPE:I = 0x3

.field public static final USER_ACCESS:I = 0x0

.field public static final WORLD_ACCESS:I = 0x2

.field public static final WRITE_PERMISSION:I = 0x1

.field private static final serialVersionUID:J = 0x7d0cc2180c52bb3cL


# instance fields
.field private _date:Ljava/util/Calendar;

.field private _group:Ljava/lang/String;

.field private _hardLinkCount:I

.field private _link:Ljava/lang/String;

.field private _name:Ljava/lang/String;

.field private final _permissions:[[Z

.field private _rawListing:Ljava/lang/String;

.field private _size:J

.field private _type:I

.field private _user:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 4

    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x3

    .line 71
    filled-new-array {v0, v0}, [I

    move-result-object v1

    const-class v2, Z

    invoke-static {v2, v1}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [[Z

    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_permissions:[[Z

    const/4 v1, 0x0

    .line 72
    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_rawListing:Ljava/lang/String;

    .line 73
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_type:I

    const/4 v0, 0x0

    .line 76
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_hardLinkCount:I

    const-wide/16 v2, -0x1

    .line 77
    iput-wide v2, p0, Lorg/apache/commons/net/ftp/FTPFile;->_size:J

    const-string v0, ""

    .line 78
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_user:Ljava/lang/String;

    .line 79
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_group:Ljava/lang/String;

    .line 80
    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_date:Ljava/util/Calendar;

    .line 81
    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_name:Ljava/lang/String;

    return-void
.end method

.method private formatType()C
    .locals 2

    .line 413
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_type:I

    if-eqz v0, :cond_2

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    const/16 v0, 0x3f

    return v0

    :cond_0
    const/16 v0, 0x6c

    return v0

    :cond_1
    const/16 v0, 0x64

    return v0

    :cond_2
    const/16 v0, 0x2d

    return v0
.end method

.method private permissionToString(I)Ljava/lang/String;
    .locals 3

    .line 425
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    .line 426
    invoke-virtual {p0, p1, v1}, Lorg/apache/commons/net/ftp/FTPFile;->hasPermission(II)Z

    move-result v1

    const/16 v2, 0x2d

    if-eqz v1, :cond_0

    const/16 v1, 0x72

    .line 427
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 429
    :cond_0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :goto_0
    const/4 v1, 0x1

    .line 431
    invoke-virtual {p0, p1, v1}, Lorg/apache/commons/net/ftp/FTPFile;->hasPermission(II)Z

    move-result v1

    if-eqz v1, :cond_1

    const/16 v1, 0x77

    .line 432
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 434
    :cond_1
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :goto_1
    const/4 v1, 0x2

    .line 436
    invoke-virtual {p0, p1, v1}, Lorg/apache/commons/net/ftp/FTPFile;->hasPermission(II)Z

    move-result p1

    if-eqz p1, :cond_2

    const/16 p1, 0x78

    .line 437
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 439
    :cond_2
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 441
    :goto_2
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public getGroup()Ljava/lang/String;
    .locals 1

    .line 263
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_group:Ljava/lang/String;

    return-object v0
.end method

.method public getHardLinkCount()I
    .locals 1

    .line 239
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_hardLinkCount:I

    return v0
.end method

.method public getLink()Ljava/lang/String;
    .locals 1

    .line 311
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_link:Ljava/lang/String;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 194
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_name:Ljava/lang/String;

    return-object v0
.end method

.method public getRawListing()Ljava/lang/String;
    .locals 1

    .line 104
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_rawListing:Ljava/lang/String;

    return-object v0
.end method

.method public getSize()J
    .locals 2

    .line 215
    iget-wide v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_size:J

    return-wide v0
.end method

.method public getTimestamp()Ljava/util/Calendar;
    .locals 1

    .line 335
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_date:Ljava/util/Calendar;

    return-object v0
.end method

.method public getType()I
    .locals 1

    .line 173
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_type:I

    return v0
.end method

.method public getUser()Ljava/lang/String;
    .locals 1

    .line 286
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_user:Ljava/lang/String;

    return-object v0
.end method

.method public hasPermission(II)Z
    .locals 1

    .line 368
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_permissions:[[Z

    aget-object p1, v0, p1

    aget-boolean p1, p1, p2

    return p1
.end method

.method public isDirectory()Z
    .locals 2

    .line 116
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_type:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public isFile()Z
    .locals 1

    .line 127
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_type:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isSymbolicLink()Z
    .locals 2

    .line 138
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_type:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isUnknown()Z
    .locals 2

    .line 149
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_type:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public setGroup(Ljava/lang/String;)V
    .locals 0

    .line 251
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_group:Ljava/lang/String;

    return-void
.end method

.method public setHardLinkCount(I)V
    .locals 0

    .line 227
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_hardLinkCount:I

    return-void
.end method

.method public setLink(Ljava/lang/String;)V
    .locals 0

    .line 298
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_link:Ljava/lang/String;

    return-void
.end method

.method public setName(Ljava/lang/String;)V
    .locals 0

    .line 184
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_name:Ljava/lang/String;

    return-void
.end method

.method public setPermission(IIZ)V
    .locals 1

    .line 352
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPFile;->_permissions:[[Z

    aget-object p1, v0, p1

    aput-boolean p3, p1, p2

    return-void
.end method

.method public setRawListing(Ljava/lang/String;)V
    .locals 0

    .line 93
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_rawListing:Ljava/lang/String;

    return-void
.end method

.method public setSize(J)V
    .locals 0

    .line 204
    iput-wide p1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_size:J

    return-void
.end method

.method public setTimestamp(Ljava/util/Calendar;)V
    .locals 0

    .line 324
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_date:Ljava/util/Calendar;

    return-void
.end method

.method public setType(I)V
    .locals 0

    .line 161
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_type:I

    return-void
.end method

.method public setUser(Ljava/lang/String;)V
    .locals 0

    .line 275
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPFile;->_user:Ljava/lang/String;

    return-void
.end method

.method public toFormattedString()Ljava/lang/String;
    .locals 8

    .line 391
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 392
    new-instance v1, Ljava/util/Formatter;

    invoke-direct {v1, v0}, Ljava/util/Formatter;-><init>(Ljava/lang/Appendable;)V

    .line 393
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPFile;->formatType()C

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const/4 v2, 0x0

    .line 394
    invoke-direct {p0, v2}, Lorg/apache/commons/net/ftp/FTPFile;->permissionToString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v3, 0x1

    .line 395
    invoke-direct {p0, v3}, Lorg/apache/commons/net/ftp/FTPFile;->permissionToString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v4, 0x2

    .line 396
    invoke-direct {p0, v4}, Lorg/apache/commons/net/ftp/FTPFile;->permissionToString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 397
    new-array v5, v3, [Ljava/lang/Object;

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPFile;->getHardLinkCount()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v2

    const-string v6, " %4d"

    invoke-virtual {v1, v6, v5}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    .line 398
    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPFile;->getGroup()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v2

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPFile;->getUser()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v3

    const-string v5, " %-8s %-8s"

    invoke-virtual {v1, v5, v4}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    .line 399
    new-array v4, v3, [Ljava/lang/Object;

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPFile;->getSize()J

    move-result-wide v5

    invoke-static {v5, v6}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    aput-object v5, v4, v2

    const-string v5, " %8d"

    invoke-virtual {v1, v5, v4}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    .line 400
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPFile;->getTimestamp()Ljava/util/Calendar;

    move-result-object v4

    const/16 v5, 0x20

    if-eqz v4, :cond_0

    .line 402
    new-array v6, v3, [Ljava/lang/Object;

    aput-object v4, v6, v2

    const-string v7, " %1$tY-%1$tm-%1$td %1$tH:%1$tM:%1$tS"

    invoke-virtual {v1, v7, v6}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    .line 403
    new-array v3, v3, [Ljava/lang/Object;

    aput-object v4, v3, v2

    const-string v2, " %1$tZ"

    invoke-virtual {v1, v2, v3}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    .line 404
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 406
    :cond_0
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 407
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPFile;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 408
    invoke-virtual {v1}, Ljava/util/Formatter;->close()V

    .line 409
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 379
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPFile;->getRawListing()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

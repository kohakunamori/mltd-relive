.class public Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;
.super Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;
.source "MVSFTPEntryParser.java"


# static fields
.field static final DEFAULT_DATE_FORMAT:Ljava/lang/String; = "yyyy/MM/dd HH:mm"

.field static final FILE_LIST_REGEX:Ljava/lang/String; = "\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+[FV]\\S*\\s+\\S+\\s+\\S+\\s+(PS|PO|PO-E)\\s+(\\S+)\\s*"

.field static final FILE_LIST_TYPE:I = 0x0

.field static final JES_LEVEL_1_LIST_REGEX:Ljava/lang/String; = "(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+)\\s*"

.field static final JES_LEVEL_1_LIST_TYPE:I = 0x3

.field static final JES_LEVEL_2_LIST_REGEX:Ljava/lang/String; = "(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+).*"

.field static final JES_LEVEL_2_LIST_TYPE:I = 0x4

.field static final MEMBER_LIST_REGEX:Ljava/lang/String; = "(\\S+)\\s+\\S+\\s+\\S+\\s+(\\S+)\\s+(\\S+)\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s*"

.field static final MEMBER_LIST_TYPE:I = 0x1

.field static final UNIX_LIST_TYPE:I = 0x2

.field static final UNKNOWN_LIST_TYPE:I = -0x1


# instance fields
.field private isType:I

.field private unixFTPEntryParser:Lorg/apache/commons/net/ftp/parser/UnixFTPEntryParser;


# direct methods
.method public constructor <init>()V
    .locals 1

    const-string v0, ""

    .line 217
    invoke-direct {p0, v0}, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;-><init>(Ljava/lang/String;)V

    const/4 v0, -0x1

    .line 47
    iput v0, p0, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->isType:I

    const/4 v0, 0x0

    .line 218
    invoke-super {p0, v0}, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->configure(Lorg/apache/commons/net/ftp/FTPClientConfig;)V

    return-void
.end method

.method private parseFileList(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z
    .locals 3

    .line 285
    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->matches(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    .line 286
    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/FTPFile;->setRawListing(Ljava/lang/String;)V

    const/4 p2, 0x2

    .line 287
    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->group(I)Ljava/lang/String;

    move-result-object p2

    const/4 v0, 0x1

    .line 288
    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->group(I)Ljava/lang/String;

    move-result-object v2

    .line 289
    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/FTPFile;->setName(Ljava/lang/String;)V

    const-string p2, "PS"

    .line 292
    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_0

    .line 293
    invoke-virtual {p1, v1}, Lorg/apache/commons/net/ftp/FTPFile;->setType(I)V

    goto :goto_1

    :cond_0
    const-string p2, "PO"

    .line 295
    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_2

    const-string p2, "PO-E"

    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_1

    goto :goto_0

    :cond_1
    return v1

    .line 297
    :cond_2
    :goto_0
    invoke-virtual {p1, v0}, Lorg/apache/commons/net/ftp/FTPFile;->setType(I)V

    :goto_1
    return v0

    :cond_3
    return v1
.end method

.method private parseJeslevel1List(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z
    .locals 3

    .line 399
    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->matches(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v0, 0x3

    .line 400
    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->group(I)Ljava/lang/String;

    move-result-object v0

    const-string v2, "OUTPUT"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 401
    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/FTPFile;->setRawListing(Ljava/lang/String;)V

    const/4 p2, 0x2

    .line 402
    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->group(I)Ljava/lang/String;

    move-result-object p2

    .line 403
    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/FTPFile;->setName(Ljava/lang/String;)V

    .line 404
    invoke-virtual {p1, v1}, Lorg/apache/commons/net/ftp/FTPFile;->setType(I)V

    const/4 p1, 0x1

    return p1

    :cond_0
    return v1
.end method

.method private parseJeslevel2List(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z
    .locals 3

    .line 428
    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->matches(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v0, 0x4

    .line 429
    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->group(I)Ljava/lang/String;

    move-result-object v0

    const-string v2, "OUTPUT"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 430
    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/FTPFile;->setRawListing(Ljava/lang/String;)V

    const/4 p2, 0x2

    .line 431
    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->group(I)Ljava/lang/String;

    move-result-object p2

    .line 432
    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/FTPFile;->setName(Ljava/lang/String;)V

    .line 433
    invoke-virtual {p1, v1}, Lorg/apache/commons/net/ftp/FTPFile;->setType(I)V

    const/4 p1, 0x1

    return p1

    :cond_0
    return v1
.end method

.method private parseMemberList(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z
    .locals 4

    .line 329
    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->matches(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 330
    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/FTPFile;->setRawListing(Ljava/lang/String;)V

    const/4 p2, 0x1

    .line 331
    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->group(I)Ljava/lang/String;

    move-result-object v0

    .line 332
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v3, 0x2

    invoke-virtual {p0, v3}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->group(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v3, 0x3

    invoke-virtual {p0, v3}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->group(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 333
    invoke-virtual {p1, v0}, Lorg/apache/commons/net/ftp/FTPFile;->setName(Ljava/lang/String;)V

    .line 334
    invoke-virtual {p1, v1}, Lorg/apache/commons/net/ftp/FTPFile;->setType(I)V

    .line 336
    :try_start_0
    invoke-super {p0, v2}, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->parseTimestamp(Ljava/lang/String;)Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {p1, v0}, Lorg/apache/commons/net/ftp/FTPFile;->setTimestamp(Ljava/util/Calendar;)V
    :try_end_0
    .catch Ljava/text/ParseException; {:try_start_0 .. :try_end_0} :catch_0

    return p2

    :catch_0
    move-exception p1

    .line 338
    invoke-virtual {p1}, Ljava/text/ParseException;->printStackTrace()V

    :cond_0
    return v1
.end method

.method private parseSimpleEntry(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z
    .locals 2

    const/4 v0, 0x0

    if-eqz p2, :cond_0

    .line 359
    invoke-virtual {p2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 360
    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/FTPFile;->setRawListing(Ljava/lang/String;)V

    const-string v1, " "

    .line 361
    invoke-virtual {p2, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p2

    aget-object p2, p2, v0

    .line 362
    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/FTPFile;->setName(Ljava/lang/String;)V

    .line 363
    invoke-virtual {p1, v0}, Lorg/apache/commons/net/ftp/FTPFile;->setType(I)V

    const/4 p1, 0x1

    return p1

    :cond_0
    return v0
.end method

.method private parseUnixList(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z
    .locals 0

    .line 377
    iget-object p1, p0, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->unixFTPEntryParser:Lorg/apache/commons/net/ftp/parser/UnixFTPEntryParser;

    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/parser/UnixFTPEntryParser;->parseFTPEntry(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPFile;

    move-result-object p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    const/4 p1, 0x1

    return p1
.end method


# virtual methods
.method protected getDefaultConfiguration()Lorg/apache/commons/net/ftp/FTPClientConfig;
    .locals 8

    .line 495
    new-instance v7, Lorg/apache/commons/net/ftp/FTPClientConfig;

    const-string v1, "MVS"

    const-string v2, "yyyy/MM/dd HH:mm"

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Lorg/apache/commons/net/ftp/FTPClientConfig;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v7
.end method

.method public parseFTPEntry(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPFile;
    .locals 3

    .line 235
    new-instance v0, Lorg/apache/commons/net/ftp/FTPFile;

    invoke-direct {v0}, Lorg/apache/commons/net/ftp/FTPFile;-><init>()V

    .line 237
    iget v1, p0, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->isType:I

    if-nez v1, :cond_0

    .line 238
    invoke-direct {p0, v0, p1}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->parseFileList(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z

    move-result p1

    goto :goto_0

    :cond_0
    const/4 v2, 0x1

    if-ne v1, v2, :cond_2

    .line 240
    invoke-direct {p0, v0, p1}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->parseMemberList(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 242
    invoke-direct {p0, v0, p1}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->parseSimpleEntry(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z

    move-result p1

    goto :goto_0

    :cond_1
    move p1, v1

    goto :goto_0

    :cond_2
    const/4 v2, 0x2

    if-ne v1, v2, :cond_3

    .line 245
    invoke-direct {p0, v0, p1}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->parseUnixList(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z

    move-result p1

    goto :goto_0

    :cond_3
    const/4 v2, 0x3

    if-ne v1, v2, :cond_4

    .line 247
    invoke-direct {p0, v0, p1}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->parseJeslevel1List(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z

    move-result p1

    goto :goto_0

    :cond_4
    const/4 v2, 0x4

    if-ne v1, v2, :cond_5

    .line 249
    invoke-direct {p0, v0, p1}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->parseJeslevel2List(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)Z

    move-result p1

    goto :goto_0

    :cond_5
    const/4 p1, 0x0

    :goto_0
    if-nez p1, :cond_6

    const/4 v0, 0x0

    :cond_6
    return-object v0
.end method

.method public preParse(Ljava/util/List;)Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    if-eqz p1, :cond_5

    .line 452
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_5

    const/4 v0, 0x0

    .line 453
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    const-string v2, "Volume"

    .line 454
    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    const/4 v3, 0x3

    if-ltz v2, :cond_0

    const-string v2, "Dsname"

    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-ltz v2, :cond_0

    .line 455
    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->setType(I)V

    const-string v1, "\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+[FV]\\S*\\s+\\S+\\s+\\S+\\s+(PS|PO|PO-E)\\s+(\\S+)\\s*"

    .line 456
    invoke-super {p0, v1}, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->setRegex(Ljava/lang/String;)Z

    goto :goto_0

    :cond_0
    const-string v2, "Name"

    .line 457
    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-ltz v2, :cond_1

    const-string v2, "Id"

    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-ltz v2, :cond_1

    const/4 v1, 0x1

    .line 458
    invoke-virtual {p0, v1}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->setType(I)V

    const-string v1, "(\\S+)\\s+\\S+\\s+\\S+\\s+(\\S+)\\s+(\\S+)\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s*"

    .line 459
    invoke-super {p0, v1}, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->setRegex(Ljava/lang/String;)Z

    goto :goto_0

    :cond_1
    const-string v2, "total"

    .line 460
    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_2

    const/4 v1, 0x2

    .line 461
    invoke-virtual {p0, v1}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->setType(I)V

    .line 462
    new-instance v1, Lorg/apache/commons/net/ftp/parser/UnixFTPEntryParser;

    invoke-direct {v1}, Lorg/apache/commons/net/ftp/parser/UnixFTPEntryParser;-><init>()V

    iput-object v1, p0, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->unixFTPEntryParser:Lorg/apache/commons/net/ftp/parser/UnixFTPEntryParser;

    goto :goto_0

    :cond_2
    const-string v2, "Spool Files"

    .line 463
    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    const/16 v4, 0x1e

    if-lt v2, v4, :cond_3

    .line 464
    invoke-virtual {p0, v3}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->setType(I)V

    const-string v1, "(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+)\\s*"

    .line 465
    invoke-super {p0, v1}, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->setRegex(Ljava/lang/String;)Z

    goto :goto_0

    :cond_3
    const-string v2, "JOBNAME"

    .line 466
    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_4

    const-string v2, "JOBID"

    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    const/16 v2, 0x8

    if-le v1, v2, :cond_4

    const/4 v1, 0x4

    .line 468
    invoke-virtual {p0, v1}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->setType(I)V

    const-string v1, "(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+).*"

    .line 469
    invoke-super {p0, v1}, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->setRegex(Ljava/lang/String;)Z

    goto :goto_0

    :cond_4
    const/4 v1, -0x1

    .line 471
    invoke-virtual {p0, v1}, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->setType(I)V

    .line 474
    :goto_0
    iget v1, p0, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->isType:I

    if-eq v1, v3, :cond_5

    .line 475
    invoke-interface {p1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    :cond_5
    return-object p1
.end method

.method setType(I)V
    .locals 0

    .line 487
    iput p1, p0, Lorg/apache/commons/net/ftp/parser/MVSFTPEntryParser;->isType:I

    return-void
.end method

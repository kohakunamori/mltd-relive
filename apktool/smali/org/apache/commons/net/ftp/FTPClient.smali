.class public Lorg/apache/commons/net/ftp/FTPClient;
.super Lorg/apache/commons/net/ftp/FTP;
.source "FTPClient.java"

# interfaces
.implements Lorg/apache/commons/net/ftp/Configurable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/apache/commons/net/ftp/FTPClient$CSL;,
        Lorg/apache/commons/net/ftp/FTPClient$PropertiesSingleton;
    }
.end annotation


# static fields
.field public static final ACTIVE_LOCAL_DATA_CONNECTION_MODE:I = 0x0

.field public static final ACTIVE_REMOTE_DATA_CONNECTION_MODE:I = 0x1

.field public static final FTP_SYSTEM_TYPE:Ljava/lang/String; = "org.apache.commons.net.ftp.systemType"

.field public static final FTP_SYSTEM_TYPE_DEFAULT:Ljava/lang/String; = "org.apache.commons.net.ftp.systemType.default"

.field public static final PASSIVE_LOCAL_DATA_CONNECTION_MODE:I = 0x2

.field public static final PASSIVE_REMOTE_DATA_CONNECTION_MODE:I = 0x3

.field public static final SYSTEM_TYPE_PROPERTIES:Ljava/lang/String; = "/systemType.properties"

.field private static final __PARMS_PAT:Ljava/util/regex/Pattern;


# instance fields
.field private __activeExternalHost:Ljava/net/InetAddress;

.field private __activeMaxPort:I

.field private __activeMinPort:I

.field private __autodetectEncoding:Z

.field private __bufferSize:I

.field private __configuration:Lorg/apache/commons/net/ftp/FTPClientConfig;

.field private __controlKeepAliveReplyTimeout:I

.field private __controlKeepAliveTimeout:J

.field private __copyStreamListener:Lorg/apache/commons/net/io/CopyStreamListener;

.field private __dataConnectionMode:I

.field private __dataTimeout:I

.field private __entryParser:Lorg/apache/commons/net/ftp/FTPFileEntryParser;

.field private __entryParserKey:Ljava/lang/String;

.field private __featuresMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field private __fileFormat:I

.field private __fileStructure:I

.field private __fileTransferMode:I

.field private __fileType:I

.field private __listHiddenFiles:Z

.field private __parserFactory:Lorg/apache/commons/net/ftp/parser/FTPFileEntryParserFactory;

.field private __passiveHost:Ljava/lang/String;

.field private __passiveLocalHost:Ljava/net/InetAddress;

.field private __passiveNatWorkaround:Z

.field private __passivePort:I

.field private final __random:Ljava/util/Random;

.field private __receiveDataSocketBufferSize:I

.field private __remoteVerificationEnabled:Z

.field private __reportActiveExternalHost:Ljava/net/InetAddress;

.field private __restartOffset:J

.field private __sendDataSocketBufferSize:I

.field private __systemName:Ljava/lang/String;

.field private __useEPSVwithIPv4:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "(\\d{1,3},\\d{1,3},\\d{1,3},\\d{1,3}),(\\d{1,3}),(\\d{1,3})"

    .line 401
    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lorg/apache/commons/net/ftp/FTPClient;->__PARMS_PAT:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .line 458
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTP;-><init>()V

    const/16 v0, 0x3e8

    .line 391
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__controlKeepAliveReplyTimeout:I

    const/4 v0, 0x1

    .line 396
    iput-boolean v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveNatWorkaround:Z

    const/4 v1, 0x0

    .line 406
    iput-boolean v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__autodetectEncoding:Z

    .line 459
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->__initDefaults()V

    const/4 v2, -0x1

    .line 460
    iput v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataTimeout:I

    .line 461
    iput-boolean v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__remoteVerificationEnabled:Z

    .line 462
    new-instance v0, Lorg/apache/commons/net/ftp/parser/DefaultFTPFileEntryParserFactory;

    invoke-direct {v0}, Lorg/apache/commons/net/ftp/parser/DefaultFTPFileEntryParserFactory;-><init>()V

    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__parserFactory:Lorg/apache/commons/net/ftp/parser/FTPFileEntryParserFactory;

    const/4 v0, 0x0

    .line 463
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__configuration:Lorg/apache/commons/net/ftp/FTPClientConfig;

    .line 464
    iput-boolean v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__listHiddenFiles:Z

    .line 465
    iput-boolean v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__useEPSVwithIPv4:Z

    .line 466
    new-instance v1, Ljava/util/Random;

    invoke-direct {v1}, Ljava/util/Random;-><init>()V

    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__random:Ljava/util/Random;

    .line 467
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveLocalHost:Ljava/net/InetAddress;

    return-void
.end method

.method private __initDefaults()V
    .locals 4

    const/4 v0, 0x0

    .line 473
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    const/4 v1, 0x0

    .line 474
    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveHost:Ljava/lang/String;

    const/4 v2, -0x1

    .line 475
    iput v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passivePort:I

    .line 476
    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__activeExternalHost:Ljava/net/InetAddress;

    .line 477
    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__reportActiveExternalHost:Ljava/net/InetAddress;

    .line 478
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__activeMinPort:I

    .line 479
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__activeMaxPort:I

    .line 480
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileType:I

    const/4 v0, 0x7

    .line 481
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileStructure:I

    const/4 v0, 0x4

    .line 482
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileFormat:I

    const/16 v0, 0xa

    .line 483
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileTransferMode:I

    const-wide/16 v2, 0x0

    .line 484
    iput-wide v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__restartOffset:J

    .line 485
    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__systemName:Ljava/lang/String;

    .line 486
    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__entryParser:Lorg/apache/commons/net/ftp/FTPFileEntryParser;

    const-string v0, ""

    .line 487
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__entryParserKey:Ljava/lang/String;

    .line 488
    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__featuresMap:Ljava/util/HashMap;

    return-void
.end method

.method private __mergeListeners(Lorg/apache/commons/net/io/CopyStreamListener;)Lorg/apache/commons/net/io/CopyStreamListener;
    .locals 1

    if-nez p1, :cond_0

    .line 3715
    iget-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__copyStreamListener:Lorg/apache/commons/net/io/CopyStreamListener;

    return-object p1

    .line 3717
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__copyStreamListener:Lorg/apache/commons/net/io/CopyStreamListener;

    if-nez v0, :cond_1

    return-object p1

    .line 3721
    :cond_1
    new-instance v0, Lorg/apache/commons/net/io/CopyStreamAdapter;

    invoke-direct {v0}, Lorg/apache/commons/net/io/CopyStreamAdapter;-><init>()V

    .line 3722
    invoke-virtual {v0, p1}, Lorg/apache/commons/net/io/CopyStreamAdapter;->addCopyStreamListener(Lorg/apache/commons/net/io/CopyStreamListener;)V

    .line 3723
    iget-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__copyStreamListener:Lorg/apache/commons/net/io/CopyStreamListener;

    invoke-virtual {v0, p1}, Lorg/apache/commons/net/io/CopyStreamAdapter;->addCopyStreamListener(Lorg/apache/commons/net/io/CopyStreamListener;)V

    return-object v0
.end method

.method static __parsePathname(Ljava/lang/String;)Ljava/lang/String;
    .locals 7

    const/4 v0, 0x4

    .line 510
    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    const-string v0, "\""

    .line 511
    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 512
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 515
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v3, v5, :cond_3

    .line 516
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    const/16 v6, 0x22

    if-ne v5, v6, :cond_1

    if-eqz v4, :cond_0

    .line 519
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const/4 v4, 0x0

    goto :goto_1

    :cond_0
    const/4 v4, 0x1

    goto :goto_1

    :cond_1
    if-eqz v4, :cond_2

    .line 527
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 529
    :cond_2
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_3
    if-eqz v4, :cond_4

    .line 533
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_4
    return-object p0
.end method

.method private __storeFile(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;Ljava/io/InputStream;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 624
    invoke-virtual {p1}, Lorg/apache/commons/net/ftp/FTPCmd;->getCommand()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1, p2, p3}, Lorg/apache/commons/net/ftp/FTPClient;->_storeFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)Z

    move-result p1

    return p1
.end method

.method private __storeFileStream(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)Ljava/io/OutputStream;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 679
    invoke-virtual {p1}, Lorg/apache/commons/net/ftp/FTPCmd;->getCommand()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->_storeFileStream(Ljava/lang/String;Ljava/lang/String;)Ljava/io/OutputStream;

    move-result-object p1

    return-object p1
.end method

.method private getActivePort()I
    .locals 3

    .line 1366
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__activeMinPort:I

    if-lez v0, :cond_1

    iget v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__activeMaxPort:I

    if-lt v1, v0, :cond_1

    if-ne v1, v0, :cond_0

    return v1

    .line 1372
    :cond_0
    iget-object v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__random:Ljava/util/Random;

    sub-int/2addr v1, v0

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v2, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    iget v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__activeMinPort:I

    add-int/2addr v0, v1

    return v0

    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method private getBufferedInputStream(Ljava/io/InputStream;)Ljava/io/InputStream;
    .locals 2

    .line 3651
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__bufferSize:I

    if-lez v0, :cond_0

    .line 3652
    new-instance v1, Ljava/io/BufferedInputStream;

    invoke-direct {v1, p1, v0}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;I)V

    return-object v1

    .line 3654
    :cond_0
    new-instance v0, Ljava/io/BufferedInputStream;

    invoke-direct {v0, p1}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    return-object v0
.end method

.method private getBufferedOutputStream(Ljava/io/OutputStream;)Ljava/io/OutputStream;
    .locals 2

    .line 3644
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__bufferSize:I

    if-lez v0, :cond_0

    .line 3645
    new-instance v1, Ljava/io/BufferedOutputStream;

    invoke-direct {v1, p1, v0}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;I)V

    return-object v1

    .line 3647
    :cond_0
    new-instance v0, Ljava/io/BufferedOutputStream;

    invoke-direct {v0, p1}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    return-object v0
.end method

.method private getHostAddress()Ljava/net/InetAddress;
    .locals 1

    .line 1389
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__activeExternalHost:Ljava/net/InetAddress;

    if-eqz v0, :cond_0

    return-object v0

    .line 1396
    :cond_0
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getLocalAddress()Ljava/net/InetAddress;

    move-result-object v0

    return-object v0
.end method

.method private static getOverrideProperties()Ljava/util/Properties;
    .locals 1

    .line 436
    sget-object v0, Lorg/apache/commons/net/ftp/FTPClient$PropertiesSingleton;->PROPERTIES:Ljava/util/Properties;

    return-object v0
.end method

.method private getReportHostAddress()Ljava/net/InetAddress;
    .locals 1

    .line 1409
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__reportActiveExternalHost:Ljava/net/InetAddress;

    if-eqz v0, :cond_0

    return-object v0

    .line 1412
    :cond_0
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getHostAddress()Ljava/net/InetAddress;

    move-result-object v0

    return-object v0
.end method

.method private initFeatureMap()Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2323
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__featuresMap:Ljava/util/HashMap;

    const/4 v1, 0x1

    if-nez v0, :cond_4

    .line 2325
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->feat()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    .line 2327
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    iput-object v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__featuresMap:Ljava/util/HashMap;

    const/4 v2, 0x0

    if-nez v0, :cond_0

    return v2

    .line 2331
    :cond_0
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReplyStrings()[Ljava/lang/String;

    move-result-object v0

    array-length v3, v0

    :goto_0
    if-ge v2, v3, :cond_4

    aget-object v4, v0, v2

    const-string v5, " "

    .line 2332
    invoke-virtual {v4, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    const/16 v5, 0x20

    .line 2335
    invoke-virtual {v4, v5, v1}, Ljava/lang/String;->indexOf(II)I

    move-result v5

    if-lez v5, :cond_1

    .line 2337
    invoke-virtual {v4, v1, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    add-int/lit8 v5, v5, 0x1

    .line 2338
    invoke-virtual {v4, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    .line 2340
    :cond_1
    invoke-virtual {v4, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    const-string v4, ""

    .line 2342
    :goto_1
    sget-object v5, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v6, v5}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v5

    .line 2343
    iget-object v6, p0, Lorg/apache/commons/net/ftp/FTPClient;->__featuresMap:Ljava/util/HashMap;

    invoke-virtual {v6, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Set;

    if-nez v6, :cond_2

    .line 2345
    new-instance v6, Ljava/util/HashSet;

    invoke-direct {v6}, Ljava/util/HashSet;-><init>()V

    .line 2346
    iget-object v7, p0, Lorg/apache/commons/net/ftp/FTPClient;->__featuresMap:Ljava/util/HashMap;

    invoke-virtual {v7, v5, v6}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2348
    :cond_2
    invoke-interface {v6, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    :cond_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_4
    return v1
.end method

.method private initiateListParsing(Lorg/apache/commons/net/ftp/FTPFileEntryParser;Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPListParseEngine;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 3293
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->LIST:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/FTPClient;->getListArguments(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, v0, p2}, Lorg/apache/commons/net/ftp/FTPClient;->_openDataConnection_(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)Ljava/net/Socket;

    move-result-object p2

    .line 3295
    new-instance v0, Lorg/apache/commons/net/ftp/FTPListParseEngine;

    invoke-direct {v0, p1}, Lorg/apache/commons/net/ftp/FTPListParseEngine;-><init>(Lorg/apache/commons/net/ftp/FTPFileEntryParser;)V

    if-nez p2, :cond_0

    return-object v0

    .line 3302
    :cond_0
    :try_start_0
    invoke-virtual {p2}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object p1

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getControlEncoding()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lorg/apache/commons/net/ftp/FTPListParseEngine;->readServerList(Ljava/io/InputStream;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 3305
    invoke-static {p2}, Lorg/apache/commons/net/io/Util;->closeQuietly(Ljava/net/Socket;)V

    .line 3308
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->completePendingCommand()Z

    return-object v0

    :catchall_0
    move-exception p1

    .line 3305
    invoke-static {p2}, Lorg/apache/commons/net/io/Util;->closeQuietly(Ljava/net/Socket;)V

    throw p1
.end method

.method private initiateMListParsing(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPListParseEngine;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 3321
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->MLSD:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->_openDataConnection_(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)Ljava/net/Socket;

    move-result-object p1

    .line 3322
    new-instance v0, Lorg/apache/commons/net/ftp/FTPListParseEngine;

    invoke-static {}, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->getInstance()Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/apache/commons/net/ftp/FTPListParseEngine;-><init>(Lorg/apache/commons/net/ftp/FTPFileEntryParser;)V

    if-nez p1, :cond_0

    return-object v0

    .line 3329
    :cond_0
    :try_start_0
    invoke-virtual {p1}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getControlEncoding()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/apache/commons/net/ftp/FTPListParseEngine;->readServerList(Ljava/io/InputStream;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 3332
    invoke-static {p1}, Lorg/apache/commons/net/io/Util;->closeQuietly(Ljava/net/Socket;)V

    .line 3333
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->completePendingCommand()Z

    return-object v0

    :catchall_0
    move-exception v0

    .line 3332
    invoke-static {p1}, Lorg/apache/commons/net/io/Util;->closeQuietly(Ljava/net/Socket;)V

    .line 3333
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->completePendingCommand()Z

    throw v0
.end method


# virtual methods
.method protected _connectAction_()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 924
    invoke-super {p0}, Lorg/apache/commons/net/ftp/FTP;->_connectAction_()V

    .line 925
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->__initDefaults()V

    .line 928
    iget-boolean v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__autodetectEncoding:Z

    if-eqz v0, :cond_2

    .line 930
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 931
    iget v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyCode:I

    const-string v2, "UTF8"

    .line 932
    invoke-virtual {p0, v2}, Lorg/apache/commons/net/ftp/FTPClient;->hasFeature(Ljava/lang/String;)Z

    move-result v2

    const-string v3, "UTF-8"

    if-nez v2, :cond_0

    invoke-virtual {p0, v3}, Lorg/apache/commons/net/ftp/FTPClient;->hasFeature(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 934
    :cond_0
    invoke-virtual {p0, v3}, Lorg/apache/commons/net/ftp/FTPClient;->setControlEncoding(Ljava/lang/String;)V

    .line 935
    new-instance v2, Lorg/apache/commons/net/io/CRLFLineReader;

    new-instance v3, Ljava/io/InputStreamReader;

    iget-object v4, p0, Lorg/apache/commons/net/ftp/FTPClient;->_input_:Ljava/io/InputStream;

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getControlEncoding()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v4, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v2, v3}, Lorg/apache/commons/net/io/CRLFLineReader;-><init>(Ljava/io/Reader;)V

    iput-object v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->_controlInput_:Ljava/io/BufferedReader;

    .line 937
    new-instance v2, Ljava/io/BufferedWriter;

    new-instance v3, Ljava/io/OutputStreamWriter;

    iget-object v4, p0, Lorg/apache/commons/net/ftp/FTPClient;->_output_:Ljava/io/OutputStream;

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getControlEncoding()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v4, v5}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    iput-object v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->_controlOutput_:Ljava/io/BufferedWriter;

    .line 941
    :cond_1
    iget-object v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->clear()V

    .line 942
    iget-object v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 943
    iput v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyCode:I

    :cond_2
    return-void
.end method

.method protected _openDataConnection_(ILjava/lang/String;)Ljava/net/Socket;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 734
    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPCommand;->getCommand(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->_openDataConnection_(Ljava/lang/String;Ljava/lang/String;)Ljava/net/Socket;

    move-result-object p1

    return-object p1
.end method

.method protected _openDataConnection_(Ljava/lang/String;Ljava/lang/String;)Ljava/net/Socket;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 784
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v2, 0x2

    if-eq v0, v2, :cond_0

    return-object v1

    .line 789
    :cond_0
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getRemoteAddress()Ljava/net/InetAddress;

    move-result-object v0

    instance-of v0, v0, Ljava/net/Inet6Address;

    .line 793
    iget v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    const-wide/16 v3, 0x0

    const/4 v5, 0x1

    if-nez v2, :cond_9

    .line 797
    iget-object v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->_serverSocketFactory_:Ljavax/net/ServerSocketFactory;

    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getActivePort()I

    move-result v6

    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getHostAddress()Ljava/net/InetAddress;

    move-result-object v7

    invoke-virtual {v2, v6, v5, v7}, Ljavax/net/ServerSocketFactory;->createServerSocket(IILjava/net/InetAddress;)Ljava/net/ServerSocket;

    move-result-object v2

    if-eqz v0, :cond_1

    .line 808
    :try_start_0
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReportHostAddress()Ljava/net/InetAddress;

    move-result-object v0

    invoke-virtual {v2}, Ljava/net/ServerSocket;->getLocalPort()I

    move-result v5

    invoke-virtual {p0, v0, v5}, Lorg/apache/commons/net/ftp/FTPClient;->eprt(Ljava/net/InetAddress;I)I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_2

    .line 845
    invoke-virtual {v2}, Ljava/net/ServerSocket;->close()V

    return-object v1

    .line 812
    :cond_1
    :try_start_1
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReportHostAddress()Ljava/net/InetAddress;

    move-result-object v0

    invoke-virtual {v2}, Ljava/net/ServerSocket;->getLocalPort()I

    move-result v5

    invoke-virtual {p0, v0, v5}, Lorg/apache/commons/net/ftp/FTPClient;->port(Ljava/net/InetAddress;I)I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez v0, :cond_2

    .line 845
    invoke-virtual {v2}, Ljava/net/ServerSocket;->close()V

    return-object v1

    .line 817
    :cond_2
    :try_start_2
    iget-wide v5, p0, Lorg/apache/commons/net/ftp/FTPClient;->__restartOffset:J

    cmp-long v0, v5, v3

    if-lez v0, :cond_3

    iget-wide v3, p0, Lorg/apache/commons/net/ftp/FTPClient;->__restartOffset:J

    invoke-virtual {p0, v3, v4}, Lorg/apache/commons/net/ftp/FTPClient;->restart(J)Z

    move-result v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-nez v0, :cond_3

    .line 845
    invoke-virtual {v2}, Ljava/net/ServerSocket;->close()V

    return-object v1

    .line 821
    :cond_3
    :try_start_3
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->sendCommand(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositivePreliminary(I)Z

    move-result p1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-nez p1, :cond_4

    .line 845
    invoke-virtual {v2}, Ljava/net/ServerSocket;->close()V

    return-object v1

    .line 829
    :cond_4
    :try_start_4
    iget p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataTimeout:I

    if-ltz p1, :cond_5

    .line 830
    iget p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataTimeout:I

    invoke-virtual {v2, p1}, Ljava/net/ServerSocket;->setSoTimeout(I)V

    .line 832
    :cond_5
    invoke-virtual {v2}, Ljava/net/ServerSocket;->accept()Ljava/net/Socket;

    move-result-object p1

    .line 835
    iget p2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataTimeout:I

    if-ltz p2, :cond_6

    .line 836
    iget p2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataTimeout:I

    invoke-virtual {p1, p2}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 838
    :cond_6
    iget p2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__receiveDataSocketBufferSize:I

    if-lez p2, :cond_7

    .line 839
    iget p2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__receiveDataSocketBufferSize:I

    invoke-virtual {p1, p2}, Ljava/net/Socket;->setReceiveBufferSize(I)V

    .line 841
    :cond_7
    iget p2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__sendDataSocketBufferSize:I

    if-lez p2, :cond_8

    .line 842
    iget p2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__sendDataSocketBufferSize:I

    invoke-virtual {p1, p2}, Ljava/net/Socket;->setSendBufferSize(I)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 845
    :cond_8
    invoke-virtual {v2}, Ljava/net/ServerSocket;->close()V

    goto/16 :goto_2

    :catchall_0
    move-exception p1

    invoke-virtual {v2}, Ljava/net/ServerSocket;->close()V

    throw p1

    .line 858
    :cond_9
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->isUseEPSVwithIPv4()Z

    move-result v2

    const/4 v6, 0x0

    if-nez v2, :cond_b

    if-eqz v0, :cond_a

    goto :goto_0

    :cond_a
    const/4 v5, 0x0

    :cond_b
    :goto_0
    if-eqz v5, :cond_c

    .line 859
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->epsv()I

    move-result v2

    const/16 v5, 0xe5

    if-ne v2, v5, :cond_c

    .line 861
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v0, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTPClient;->_parseExtendedPassiveModeReply(Ljava/lang/String;)V

    goto :goto_1

    :cond_c
    if-eqz v0, :cond_d

    return-object v1

    .line 869
    :cond_d
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->pasv()I

    move-result v0

    const/16 v2, 0xe3

    if-eq v0, v2, :cond_e

    return-object v1

    .line 872
    :cond_e
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v0, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTPClient;->_parsePassiveModeReply(Ljava/lang/String;)V

    .line 875
    :goto_1
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->_socketFactory_:Ljavax/net/SocketFactory;

    invoke-virtual {v0}, Ljavax/net/SocketFactory;->createSocket()Ljava/net/Socket;

    move-result-object v0

    .line 876
    iget v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__receiveDataSocketBufferSize:I

    if-lez v2, :cond_f

    .line 877
    invoke-virtual {v0, v2}, Ljava/net/Socket;->setReceiveBufferSize(I)V

    .line 879
    :cond_f
    iget v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__sendDataSocketBufferSize:I

    if-lez v2, :cond_10

    .line 880
    invoke-virtual {v0, v2}, Ljava/net/Socket;->setSendBufferSize(I)V

    .line 882
    :cond_10
    iget-object v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveLocalHost:Ljava/net/InetAddress;

    if-eqz v2, :cond_11

    .line 883
    new-instance v5, Ljava/net/InetSocketAddress;

    invoke-direct {v5, v2, v6}, Ljava/net/InetSocketAddress;-><init>(Ljava/net/InetAddress;I)V

    invoke-virtual {v0, v5}, Ljava/net/Socket;->bind(Ljava/net/SocketAddress;)V

    .line 890
    :cond_11
    iget v2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataTimeout:I

    if-ltz v2, :cond_12

    .line 891
    invoke-virtual {v0, v2}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 894
    :cond_12
    new-instance v2, Ljava/net/InetSocketAddress;

    iget-object v5, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveHost:Ljava/lang/String;

    iget v6, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passivePort:I

    invoke-direct {v2, v5, v6}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    iget v5, p0, Lorg/apache/commons/net/ftp/FTPClient;->connectTimeout:I

    invoke-virtual {v0, v2, v5}, Ljava/net/Socket;->connect(Ljava/net/SocketAddress;I)V

    .line 895
    iget-wide v5, p0, Lorg/apache/commons/net/ftp/FTPClient;->__restartOffset:J

    cmp-long v2, v5, v3

    if-lez v2, :cond_13

    invoke-virtual {p0, v5, v6}, Lorg/apache/commons/net/ftp/FTPClient;->restart(J)Z

    move-result v2

    if-nez v2, :cond_13

    .line 897
    invoke-virtual {v0}, Ljava/net/Socket;->close()V

    return-object v1

    .line 901
    :cond_13
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->sendCommand(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositivePreliminary(I)Z

    move-result p1

    if-nez p1, :cond_14

    .line 903
    invoke-virtual {v0}, Ljava/net/Socket;->close()V

    return-object v1

    :cond_14
    move-object p1, v0

    .line 908
    :goto_2
    iget-boolean p2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__remoteVerificationEnabled:Z

    if-eqz p2, :cond_16

    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->verifyRemote(Ljava/net/Socket;)Z

    move-result p2

    if-eqz p2, :cond_15

    goto :goto_3

    .line 910
    :cond_15
    invoke-virtual {p1}, Ljava/net/Socket;->close()V

    .line 912
    new-instance p2, Ljava/io/IOException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Host attempting data connection "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/net/Socket;->getInetAddress()Ljava/net/InetAddress;

    move-result-object p1

    invoke-virtual {p1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " is not same as server "

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getRemoteAddress()Ljava/net/InetAddress;

    move-result-object p1

    invoke-virtual {p1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p2

    :cond_16
    :goto_3
    return-object p1
.end method

.method protected _openDataConnection_(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)Ljava/net/Socket;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 759
    invoke-virtual {p1}, Lorg/apache/commons/net/ftp/FTPCmd;->getCommand()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->_openDataConnection_(Ljava/lang/String;Ljava/lang/String;)Ljava/net/Socket;

    move-result-object p1

    return-object p1
.end method

.method protected _parseExtendedPassiveModeReply(Ljava/lang/String;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/net/MalformedServerReplyException;
        }
    .end annotation

    const/16 v0, 0x28

    .line 589
    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    const/4 v1, 0x1

    add-int/2addr v0, v1

    const/16 v2, 0x29

    invoke-virtual {p1, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    invoke-virtual {p1, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    .line 593
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 594
    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/4 v3, 0x2

    .line 595
    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 596
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v4

    sub-int/2addr v4, v1

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const-string v5, "Could not parse extended passive host information.\nServer Reply: "

    if-ne v0, v2, :cond_0

    if-ne v2, v3, :cond_0

    if-ne v3, v4, :cond_0

    const/4 v0, 0x3

    .line 607
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    sub-int/2addr v2, v1

    invoke-virtual {p1, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 617
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getRemoteAddress()Ljava/net/InetAddress;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveHost:Ljava/lang/String;

    .line 618
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passivePort:I

    return-void

    .line 611
    :catch_0
    new-instance v0, Lorg/apache/commons/net/MalformedServerReplyException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lorg/apache/commons/net/MalformedServerReplyException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 600
    :cond_0
    new-instance v0, Lorg/apache/commons/net/MalformedServerReplyException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lorg/apache/commons/net/MalformedServerReplyException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected _parsePassiveModeReply(Ljava/lang/String;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/net/MalformedServerReplyException;
        }
    .end annotation

    .line 546
    sget-object v0, Lorg/apache/commons/net/ftp/FTPClient;->__PARMS_PAT:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    .line 547
    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    const-string v2, "Could not parse passive host information.\nServer Reply: "

    if-eqz v1, :cond_1

    const/4 v1, 0x1

    .line 552
    invoke-virtual {v0, v1}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v1

    const/16 v3, 0x2c

    const/16 v4, 0x2e

    invoke-virtual {v1, v3, v4}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveHost:Ljava/lang/String;

    const/4 v1, 0x2

    .line 556
    :try_start_0
    invoke-virtual {v0, v1}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    const/4 v3, 0x3

    .line 557
    invoke-virtual {v0, v3}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    .line 558
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passivePort:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_1

    .line 566
    iget-boolean v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveNatWorkaround:Z

    if-eqz v0, :cond_0

    .line 568
    :try_start_1
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveHost:Ljava/lang/String;

    invoke-static {v0}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v0

    .line 570
    invoke-virtual {v0}, Ljava/net/InetAddress;->isSiteLocalAddress()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 571
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getRemoteAddress()Ljava/net/InetAddress;

    move-result-object v0

    .line 572
    invoke-virtual {v0}, Ljava/net/InetAddress;->isSiteLocalAddress()Z

    move-result v1

    if-nez v1, :cond_0

    .line 573
    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    .line 574
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[Replacing site local address "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveHost:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " with "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "]\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v1, v3}, Lorg/apache/commons/net/ftp/FTPClient;->fireReplyReceived(ILjava/lang/String;)V

    .line 576
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveHost:Ljava/lang/String;
    :try_end_1
    .catch Ljava/net/UnknownHostException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 580
    :catch_0
    new-instance v0, Lorg/apache/commons/net/MalformedServerReplyException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lorg/apache/commons/net/MalformedServerReplyException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    :goto_0
    return-void

    .line 562
    :catch_1
    new-instance v0, Lorg/apache/commons/net/MalformedServerReplyException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Could not parse passive port information.\nServer Reply: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lorg/apache/commons/net/MalformedServerReplyException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 548
    :cond_1
    new-instance v0, Lorg/apache/commons/net/MalformedServerReplyException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lorg/apache/commons/net/MalformedServerReplyException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected _retrieveFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/OutputStream;)Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1854
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->_openDataConnection_(Ljava/lang/String;Ljava/lang/String;)Ljava/net/Socket;

    move-result-object p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return p1

    .line 1860
    :cond_0
    invoke-virtual {p1}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object p2

    invoke-direct {p0, p2}, Lorg/apache/commons/net/ftp/FTPClient;->getBufferedInputStream(Ljava/io/InputStream;)Ljava/io/InputStream;

    move-result-object p2

    .line 1861
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileType:I

    if-nez v0, :cond_1

    .line 1862
    new-instance v0, Lorg/apache/commons/net/io/FromNetASCIIInputStream;

    invoke-direct {v0, p2}, Lorg/apache/commons/net/io/FromNetASCIIInputStream;-><init>(Ljava/io/InputStream;)V

    move-object p2, v0

    :cond_1
    const/4 v0, 0x0

    .line 1866
    iget-wide v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__controlKeepAliveTimeout:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-lez v5, :cond_2

    .line 1867
    new-instance v0, Lorg/apache/commons/net/ftp/FTPClient$CSL;

    iget v3, p0, Lorg/apache/commons/net/ftp/FTPClient;->__controlKeepAliveReplyTimeout:I

    invoke-direct {v0, p0, v1, v2, v3}, Lorg/apache/commons/net/ftp/FTPClient$CSL;-><init>(Lorg/apache/commons/net/ftp/FTPClient;JI)V

    .line 1873
    :cond_2
    :try_start_0
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getBufferSize()I

    move-result v3

    const-wide/16 v4, -0x1

    invoke-direct {p0, v0}, Lorg/apache/commons/net/ftp/FTPClient;->__mergeListeners(Lorg/apache/commons/net/io/CopyStreamListener;)Lorg/apache/commons/net/io/CopyStreamListener;

    move-result-object v6

    const/4 v7, 0x0

    move-object v1, p2

    move-object v2, p3

    invoke-static/range {v1 .. v7}, Lorg/apache/commons/net/io/Util;->copyStream(Ljava/io/InputStream;Ljava/io/OutputStream;IJLorg/apache/commons/net/io/CopyStreamListener;Z)J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1877
    invoke-static {p2}, Lorg/apache/commons/net/io/Util;->closeQuietly(Ljava/io/Closeable;)V

    .line 1878
    invoke-static {p1}, Lorg/apache/commons/net/io/Util;->closeQuietly(Ljava/net/Socket;)V

    if-eqz v0, :cond_3

    .line 1880
    invoke-virtual {v0}, Lorg/apache/commons/net/ftp/FTPClient$CSL;->cleanUp()V

    .line 1885
    :cond_3
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->completePendingCommand()Z

    move-result p1

    return p1

    :catchall_0
    move-exception p3

    .line 1877
    invoke-static {p2}, Lorg/apache/commons/net/io/Util;->closeQuietly(Ljava/io/Closeable;)V

    .line 1878
    invoke-static {p1}, Lorg/apache/commons/net/io/Util;->closeQuietly(Ljava/net/Socket;)V

    if-eqz v0, :cond_4

    .line 1880
    invoke-virtual {v0}, Lorg/apache/commons/net/ftp/FTPClient$CSL;->cleanUp()V

    :cond_4
    throw p3
.end method

.method protected _retrieveFileStream(Ljava/lang/String;Ljava/lang/String;)Ljava/io/InputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1927
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->_openDataConnection_(Ljava/lang/String;Ljava/lang/String;)Ljava/net/Socket;

    move-result-object p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 1933
    :cond_0
    invoke-virtual {p1}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object p2

    .line 1934
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileType:I

    if-nez v0, :cond_1

    .line 1942
    invoke-direct {p0, p2}, Lorg/apache/commons/net/ftp/FTPClient;->getBufferedInputStream(Ljava/io/InputStream;)Ljava/io/InputStream;

    move-result-object p2

    .line 1943
    new-instance v0, Lorg/apache/commons/net/io/FromNetASCIIInputStream;

    invoke-direct {v0, p2}, Lorg/apache/commons/net/io/FromNetASCIIInputStream;-><init>(Ljava/io/InputStream;)V

    move-object p2, v0

    .line 1945
    :cond_1
    new-instance v0, Lorg/apache/commons/net/io/SocketInputStream;

    invoke-direct {v0, p1, p2}, Lorg/apache/commons/net/io/SocketInputStream;-><init>(Ljava/net/Socket;Ljava/io/InputStream;)V

    return-object v0
.end method

.method protected _storeFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 633
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->_openDataConnection_(Ljava/lang/String;Ljava/lang/String;)Ljava/net/Socket;

    move-result-object p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return p1

    .line 639
    :cond_0
    invoke-virtual {p1}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object p2

    invoke-direct {p0, p2}, Lorg/apache/commons/net/ftp/FTPClient;->getBufferedOutputStream(Ljava/io/OutputStream;)Ljava/io/OutputStream;

    move-result-object p2

    .line 641
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileType:I

    if-nez v0, :cond_1

    .line 642
    new-instance v0, Lorg/apache/commons/net/io/ToNetASCIIOutputStream;

    invoke-direct {v0, p2}, Lorg/apache/commons/net/io/ToNetASCIIOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object p2, v0

    :cond_1
    const/4 v0, 0x0

    .line 646
    iget-wide v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__controlKeepAliveTimeout:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-lez v5, :cond_2

    .line 647
    new-instance v0, Lorg/apache/commons/net/ftp/FTPClient$CSL;

    iget v3, p0, Lorg/apache/commons/net/ftp/FTPClient;->__controlKeepAliveReplyTimeout:I

    invoke-direct {v0, p0, v1, v2, v3}, Lorg/apache/commons/net/ftp/FTPClient$CSL;-><init>(Lorg/apache/commons/net/ftp/FTPClient;JI)V

    .line 653
    :cond_2
    :try_start_0
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getBufferSize()I

    move-result v3

    const-wide/16 v4, -0x1

    invoke-direct {p0, v0}, Lorg/apache/commons/net/ftp/FTPClient;->__mergeListeners(Lorg/apache/commons/net/io/CopyStreamListener;)Lorg/apache/commons/net/io/CopyStreamListener;

    move-result-object v6

    const/4 v7, 0x0

    move-object v1, p3

    move-object v2, p2

    invoke-static/range {v1 .. v7}, Lorg/apache/commons/net/io/Util;->copyStream(Ljava/io/InputStream;Ljava/io/OutputStream;IJLorg/apache/commons/net/io/CopyStreamListener;Z)J
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 666
    invoke-virtual {p2}, Ljava/io/OutputStream;->close()V

    .line 667
    invoke-virtual {p1}, Ljava/net/Socket;->close()V

    if-eqz v0, :cond_3

    .line 669
    invoke-virtual {v0}, Lorg/apache/commons/net/ftp/FTPClient$CSL;->cleanUp()V

    .line 672
    :cond_3
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->completePendingCommand()Z

    move-result p1

    return p1

    :catch_0
    move-exception p2

    .line 659
    invoke-static {p1}, Lorg/apache/commons/net/io/Util;->closeQuietly(Ljava/net/Socket;)V

    if-eqz v0, :cond_4

    .line 661
    invoke-virtual {v0}, Lorg/apache/commons/net/ftp/FTPClient$CSL;->cleanUp()V

    .line 663
    :cond_4
    throw p2
.end method

.method protected _storeFileStream(Ljava/lang/String;Ljava/lang/String;)Ljava/io/OutputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 688
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->_openDataConnection_(Ljava/lang/String;Ljava/lang/String;)Ljava/net/Socket;

    move-result-object p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 694
    :cond_0
    invoke-virtual {p1}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object p2

    .line 695
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileType:I

    if-nez v0, :cond_1

    .line 703
    invoke-direct {p0, p2}, Lorg/apache/commons/net/ftp/FTPClient;->getBufferedOutputStream(Ljava/io/OutputStream;)Ljava/io/OutputStream;

    move-result-object p2

    .line 704
    new-instance v0, Lorg/apache/commons/net/io/ToNetASCIIOutputStream;

    invoke-direct {v0, p2}, Lorg/apache/commons/net/io/ToNetASCIIOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object p2, v0

    .line 707
    :cond_1
    new-instance v0, Lorg/apache/commons/net/io/SocketOutputStream;

    invoke-direct {v0, p1, p2}, Lorg/apache/commons/net/io/SocketOutputStream;-><init>(Ljava/net/Socket;Ljava/io/OutputStream;)V

    return-object v0
.end method

.method public abort()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2581
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->abor()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    return v0
.end method

.method public allocate(I)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2210
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->allo(I)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method public allocate(II)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2371
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->allo(II)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method public appendFile(Ljava/lang/String;Ljava/io/InputStream;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2038
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->APPE:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-direct {p0, v0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->__storeFile(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;Ljava/io/InputStream;)Z

    move-result p1

    return p1
.end method

.method public appendFileStream(Ljava/lang/String;)Ljava/io/OutputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2068
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->APPE:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-direct {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->__storeFileStream(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)Ljava/io/OutputStream;

    move-result-object p1

    return-object p1
.end method

.method public changeToParentDirectory()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1146
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->cdup()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    return v0
.end method

.method public changeWorkingDirectory(Ljava/lang/String;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1128
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->cwd(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method public completePendingCommand()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1813
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReply()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    return v0
.end method

.method public configure(Lorg/apache/commons/net/ftp/FTPClientConfig;)V
    .locals 0

    .line 3512
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__configuration:Lorg/apache/commons/net/ftp/FTPClientConfig;

    return-void
.end method

.method public deleteFile(Ljava/lang/String;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2599
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->dele(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method public disconnect()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 986
    invoke-super {p0}, Lorg/apache/commons/net/ftp/FTP;->disconnect()V

    .line 987
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->__initDefaults()V

    return-void
.end method

.method public doCommand(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2393
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->sendCommand(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method public doCommandAsStrings(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2414
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->sendCommand(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 2416
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReplyStrings()[Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public enterLocalActiveMode()V
    .locals 1

    const/4 v0, 0x0

    .line 1210
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    const/4 v0, 0x0

    .line 1211
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveHost:Ljava/lang/String;

    const/4 v0, -0x1

    .line 1212
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passivePort:I

    return-void
.end method

.method public enterLocalPassiveMode()V
    .locals 1

    const/4 v0, 0x2

    .line 1233
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    const/4 v0, 0x0

    .line 1236
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveHost:Ljava/lang/String;

    const/4 v0, -0x1

    .line 1237
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passivePort:I

    return-void
.end method

.method public enterRemoteActiveMode(Ljava/net/InetAddress;I)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1268
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->port(Ljava/net/InetAddress;I)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    .line 1270
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    const/4 p2, 0x0

    .line 1271
    iput-object p2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveHost:Ljava/lang/String;

    const/4 p2, -0x1

    .line 1272
    iput p2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passivePort:I

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public enterRemotePassiveMode()Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1302
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->pasv()I

    move-result v0

    const/4 v1, 0x0

    const/16 v2, 0xe3

    if-eq v0, v2, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x3

    .line 1306
    iput v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    .line 1307
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTPClient;->_parsePassiveModeReply(Ljava/lang/String;)V

    const/4 v0, 0x1

    return v0
.end method

.method public featureValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2267
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->featureValues(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    const/4 v0, 0x0

    .line 2269
    aget-object p1, p1, v0

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public featureValues(Ljava/lang/String;)[Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2245
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->initFeatureMap()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    .line 2248
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__featuresMap:Ljava/util/HashMap;

    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v2}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/Set;

    if-eqz p1, :cond_1

    .line 2250
    invoke-interface {p1}, Ljava/util/Set;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    invoke-interface {p1, v0}, Ljava/util/Set;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/String;

    return-object p1

    :cond_1
    return-object v1
.end method

.method public features()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2231
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->feat()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    return v0
.end method

.method public getAutodetectUTF8()Z
    .locals 1

    .line 3745
    iget-boolean v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__autodetectEncoding:Z

    return v0
.end method

.method public getBufferSize()I
    .locals 1

    .line 3459
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__bufferSize:I

    return v0
.end method

.method public getControlKeepAliveReplyTimeout()I
    .locals 1

    .line 3624
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__controlKeepAliveReplyTimeout:I

    return v0
.end method

.method public getControlKeepAliveTimeout()J
    .locals 4

    .line 3605
    iget-wide v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__controlKeepAliveTimeout:J

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    return-wide v0
.end method

.method public getCopyStreamListener()Lorg/apache/commons/net/io/CopyStreamListener;
    .locals 1

    .line 3584
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__copyStreamListener:Lorg/apache/commons/net/io/CopyStreamListener;

    return-object v0
.end method

.method public getDataConnectionMode()I
    .locals 1

    .line 1356
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    return v0
.end method

.method protected getListArguments(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 3342
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getListHiddenFiles()Z

    move-result v0

    if-eqz v0, :cond_1

    if-eqz p1, :cond_0

    .line 3346
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, 0x3

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v1, "-a "

    .line 3347
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 3348
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 3349
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const-string p1, "-a"

    :cond_1
    return-object p1
.end method

.method public getListHiddenFiles()Z
    .locals 1

    .line 3534
    iget-boolean v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__listHiddenFiles:Z

    return v0
.end method

.method public getModificationTime(Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 3416
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->mdtm(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 3417
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReplyString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public getPassiveHost()Ljava/lang/String;
    .locals 1

    .line 1326
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveHost:Ljava/lang/String;

    return-object v0
.end method

.method public getPassiveLocalIPAddress()Ljava/net/InetAddress;
    .locals 1

    .line 1473
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveLocalHost:Ljava/net/InetAddress;

    return-object v0
.end method

.method public getPassivePort()I
    .locals 1

    .line 1343
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passivePort:I

    return v0
.end method

.method public getReceiveDataSocketBufferSize()I
    .locals 1

    .line 3499
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__receiveDataSocketBufferSize:I

    return v0
.end method

.method public getRestartOffset()J
    .locals 2

    .line 2538
    iget-wide v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__restartOffset:J

    return-wide v0
.end method

.method public getSendDataSocketBufferSize()I
    .locals 1

    .line 3479
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__sendDataSocketBufferSize:I

    return v0
.end method

.method public getStatus()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 3375
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->stat()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 3376
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReplyString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getStatus(Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 3397
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->stat(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 3398
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReplyString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public getSystemName()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3756
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__systemName:Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->syst()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 3757
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    iget-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__systemName:Ljava/lang/String;

    .line 3759
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__systemName:Ljava/lang/String;

    return-object v0
.end method

.method public getSystemType()Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2711
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__systemName:Ljava/lang/String;

    if-nez v0, :cond_2

    .line 2712
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->syst()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 2714
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    iget-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__systemName:Ljava/lang/String;

    goto :goto_0

    :cond_0
    const-string v0, "org.apache.commons.net.ftp.systemType.default"

    .line 2717
    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 2719
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__systemName:Ljava/lang/String;

    goto :goto_0

    .line 2721
    :cond_1
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unable to determine system type - response: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReplyString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 2725
    :cond_2
    :goto_0
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__systemName:Ljava/lang/String;

    return-object v0
.end method

.method public hasFeature(Ljava/lang/String;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2287
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->initFeatureMap()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return p1

    .line 2290
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__featuresMap:Ljava/util/HashMap;

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public hasFeature(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2309
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->initFeatureMap()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 2312
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__featuresMap:Ljava/util/HashMap;

    sget-object v2, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v2}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/Set;

    if-eqz p1, :cond_1

    .line 2314
    invoke-interface {p1, p2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result p1

    return p1

    :cond_1
    return v1
.end method

.method public initiateListParsing()Lorg/apache/commons/net/ftp/FTPListParseEngine;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 3115
    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTPClient;->initiateListParsing(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPListParseEngine;

    move-result-object v0

    return-object v0
.end method

.method public initiateListParsing(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPListParseEngine;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 3171
    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->initiateListParsing(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPListParseEngine;

    move-result-object p1

    return-object p1
.end method

.method public initiateListParsing(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPListParseEngine;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 3234
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__entryParser:Lorg/apache/commons/net/ftp/FTPFileEntryParser;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__entryParserKey:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    :cond_0
    if-eqz p1, :cond_1

    .line 3238
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__parserFactory:Lorg/apache/commons/net/ftp/parser/FTPFileEntryParserFactory;

    invoke-interface {v0, p1}, Lorg/apache/commons/net/ftp/parser/FTPFileEntryParserFactory;->createFileEntryParser(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPFileEntryParser;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__entryParser:Lorg/apache/commons/net/ftp/FTPFileEntryParser;

    .line 3240
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__entryParserKey:Ljava/lang/String;

    goto :goto_0

    .line 3245
    :cond_1
    iget-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__configuration:Lorg/apache/commons/net/ftp/FTPClientConfig;

    if-eqz p1, :cond_2

    .line 3246
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__parserFactory:Lorg/apache/commons/net/ftp/parser/FTPFileEntryParserFactory;

    invoke-interface {v0, p1}, Lorg/apache/commons/net/ftp/parser/FTPFileEntryParserFactory;->createFileEntryParser(Lorg/apache/commons/net/ftp/FTPClientConfig;)Lorg/apache/commons/net/ftp/FTPFileEntryParser;

    move-result-object p1

    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__entryParser:Lorg/apache/commons/net/ftp/FTPFileEntryParser;

    .line 3248
    iget-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__configuration:Lorg/apache/commons/net/ftp/FTPClientConfig;

    invoke-virtual {p1}, Lorg/apache/commons/net/ftp/FTPClientConfig;->getServerSystemKey()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__entryParserKey:Ljava/lang/String;

    goto :goto_0

    :cond_2
    const-string p1, "org.apache.commons.net.ftp.systemType"

    .line 3254
    invoke-static {p1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_3

    .line 3256
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getSystemType()Ljava/lang/String;

    move-result-object p1

    .line 3257
    invoke-static {}, Lorg/apache/commons/net/ftp/FTPClient;->getOverrideProperties()Ljava/util/Properties;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 3259
    invoke-virtual {v0, p1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    move-object p1, v0

    .line 3265
    :cond_3
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__parserFactory:Lorg/apache/commons/net/ftp/parser/FTPFileEntryParserFactory;

    invoke-interface {v0, p1}, Lorg/apache/commons/net/ftp/parser/FTPFileEntryParserFactory;->createFileEntryParser(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPFileEntryParser;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__entryParser:Lorg/apache/commons/net/ftp/FTPFileEntryParser;

    .line 3266
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__entryParserKey:Ljava/lang/String;

    .line 3271
    :cond_4
    :goto_0
    iget-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__entryParser:Lorg/apache/commons/net/ftp/FTPFileEntryParser;

    invoke-direct {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->initiateListParsing(Lorg/apache/commons/net/ftp/FTPFileEntryParser;Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPListParseEngine;

    move-result-object p1

    return-object p1
.end method

.method public isRemoteVerificationEnabled()Z
    .locals 1

    .line 1014
    iget-boolean v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__remoteVerificationEnabled:Z

    return v0
.end method

.method public isUseEPSVwithIPv4()Z
    .locals 1

    .line 3544
    iget-boolean v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__useEPSVwithIPv4:Z

    return v0
.end method

.method public listDirectories()[Lorg/apache/commons/net/ftp/FTPFile;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 3035
    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTPClient;->listDirectories(Ljava/lang/String;)[Lorg/apache/commons/net/ftp/FTPFile;

    move-result-object v0

    return-object v0
.end method

.method public listDirectories(Ljava/lang/String;)[Lorg/apache/commons/net/ftp/FTPFile;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 3076
    sget-object v0, Lorg/apache/commons/net/ftp/FTPFileFilters;->DIRECTORIES:Lorg/apache/commons/net/ftp/FTPFileFilter;

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/net/ftp/FTPClient;->listFiles(Ljava/lang/String;Lorg/apache/commons/net/ftp/FTPFileFilter;)[Lorg/apache/commons/net/ftp/FTPFile;

    move-result-object p1

    return-object p1
.end method

.method public listFiles()[Lorg/apache/commons/net/ftp/FTPFile;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 2977
    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTPClient;->listFiles(Ljava/lang/String;)[Lorg/apache/commons/net/ftp/FTPFile;

    move-result-object v0

    return-object v0
.end method

.method public listFiles(Ljava/lang/String;)[Lorg/apache/commons/net/ftp/FTPFile;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 2930
    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->initiateListParsing(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPListParseEngine;

    move-result-object p1

    .line 2931
    invoke-virtual {p1}, Lorg/apache/commons/net/ftp/FTPListParseEngine;->getFiles()[Lorg/apache/commons/net/ftp/FTPFile;

    move-result-object p1

    return-object p1
.end method

.method public listFiles(Ljava/lang/String;Lorg/apache/commons/net/ftp/FTPFileFilter;)[Lorg/apache/commons/net/ftp/FTPFile;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 2992
    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->initiateListParsing(Ljava/lang/String;Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPListParseEngine;

    move-result-object p1

    .line 2993
    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/FTPListParseEngine;->getFiles(Lorg/apache/commons/net/ftp/FTPFileFilter;)[Lorg/apache/commons/net/ftp/FTPFile;

    move-result-object p1

    return-object p1
.end method

.method public listHelp()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2745
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->help()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 2746
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReplyString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public listHelp(Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2768
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->help(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 2769
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReplyString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public listNames()[Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 2876
    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTPClient;->listNames(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public listNames(Ljava/lang/String;)[Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2825
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->NLST:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->getListArguments(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->_openDataConnection_(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)Ljava/net/Socket;

    move-result-object p1

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    .line 2831
    :cond_0
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v2, Ljava/io/InputStreamReader;

    invoke-virtual {p1}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v3

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getControlEncoding()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 2834
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 2836
    :goto_0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 2837
    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 2840
    :cond_1
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    .line 2841
    invoke-virtual {p1}, Ljava/net/Socket;->close()V

    .line 2843
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->completePendingCommand()Z

    move-result p1

    if-eqz p1, :cond_2

    .line 2845
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result p1

    new-array p1, p1, [Ljava/lang/String;

    .line 2846
    invoke-virtual {v2, p1}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/String;

    return-object p1

    :cond_2
    return-object v0
.end method

.method public login(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1034
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->user(Ljava/lang/String;)I

    .line 1036
    iget p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyCode:I

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    .line 1042
    :cond_0
    iget p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyCode:I

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveIntermediate(I)Z

    move-result p1

    if-nez p1, :cond_1

    const/4 p1, 0x0

    return p1

    .line 1046
    :cond_1
    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/FTPClient;->pass(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method public login(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1070
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->user(Ljava/lang/String;)I

    .line 1072
    iget p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyCode:I

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    const/4 v0, 0x1

    if-eqz p1, :cond_0

    return v0

    .line 1078
    :cond_0
    iget p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyCode:I

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveIntermediate(I)Z

    move-result p1

    const/4 v1, 0x0

    if-nez p1, :cond_1

    return v1

    .line 1082
    :cond_1
    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/FTPClient;->pass(Ljava/lang/String;)I

    .line 1084
    iget p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyCode:I

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    if-eqz p1, :cond_2

    return v0

    .line 1088
    :cond_2
    iget p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyCode:I

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveIntermediate(I)Z

    move-result p1

    if-nez p1, :cond_3

    return v1

    .line 1092
    :cond_3
    invoke-virtual {p0, p3}, Lorg/apache/commons/net/ftp/FTPClient;->acct(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method public logout()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1109
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->quit()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    return v0
.end method

.method public makeDirectory(Ljava/lang/String;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2639
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->mkd(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method public mlistDir()[Lorg/apache/commons/net/ftp/FTPFile;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 2450
    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTPClient;->mlistDir(Ljava/lang/String;)[Lorg/apache/commons/net/ftp/FTPFile;

    move-result-object v0

    return-object v0
.end method

.method public mlistDir(Ljava/lang/String;)[Lorg/apache/commons/net/ftp/FTPFile;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2463
    invoke-direct {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->initiateMListParsing(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPListParseEngine;

    move-result-object p1

    .line 2464
    invoke-virtual {p1}, Lorg/apache/commons/net/ftp/FTPListParseEngine;->getFiles()[Lorg/apache/commons/net/ftp/FTPFile;

    move-result-object p1

    return-object p1
.end method

.method public mlistDir(Ljava/lang/String;Lorg/apache/commons/net/ftp/FTPFileFilter;)[Lorg/apache/commons/net/ftp/FTPFile;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2478
    invoke-direct {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->initiateMListParsing(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPListParseEngine;

    move-result-object p1

    .line 2479
    invoke-virtual {p1, p2}, Lorg/apache/commons/net/ftp/FTPListParseEngine;->getFiles(Lorg/apache/commons/net/ftp/FTPFileFilter;)[Lorg/apache/commons/net/ftp/FTPFile;

    move-result-object p1

    return-object p1
.end method

.method public mlistFile(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPFile;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2432
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->MLST:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 2434
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReplyStrings()[Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x1

    aget-object p1, p1, v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    .line 2435
    invoke-static {p1}, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->parseEntry(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPFile;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public printWorkingDirectory()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2658
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->pwd()I

    move-result v0

    const/16 v1, 0x101

    if-eq v0, v1, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 2662
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    iget-object v1, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPClient;->__parsePathname(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method reinitialize()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1183
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->rein()I

    .line 1185
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyCode:I

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    if-nez v0, :cond_1

    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->_replyCode:I

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositivePreliminary(I)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->getReply()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    return v0

    .line 1190
    :cond_1
    :goto_0
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPClient;->__initDefaults()V

    const/4 v0, 0x1

    return v0
.end method

.method public remoteAppend(Ljava/lang/String;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1760
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return p1

    .line 1762
    :cond_1
    :goto_0
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->appe(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositivePreliminary(I)Z

    move-result p1

    return p1
.end method

.method public remoteRetrieve(Ljava/lang/String;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1649
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return p1

    .line 1651
    :cond_1
    :goto_0
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->retr(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositivePreliminary(I)Z

    move-result p1

    return p1
.end method

.method public remoteStore(Ljava/lang/String;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1676
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return p1

    .line 1678
    :cond_1
    :goto_0
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->stor(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositivePreliminary(I)Z

    move-result p1

    return p1
.end method

.method public remoteStoreUnique()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1732
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    return v0

    .line 1734
    :cond_1
    :goto_0
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->stou()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositivePreliminary(I)Z

    move-result v0

    return v0
.end method

.method public remoteStoreUnique(Ljava/lang/String;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1704
    iget v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataConnectionMode:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return p1

    .line 1706
    :cond_1
    :goto_0
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->stou(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositivePreliminary(I)Z

    move-result p1

    return p1
.end method

.method public removeDirectory(Ljava/lang/String;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2618
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->rmd(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method public rename(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2559
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->rnfr(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveIntermediate(I)Z

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return p1

    .line 2563
    :cond_0
    invoke-virtual {p0, p2}, Lorg/apache/commons/net/ftp/FTPClient;->rnto(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method protected restart(J)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const-wide/16 v0, 0x0

    .line 2503
    iput-wide v0, p0, Lorg/apache/commons/net/ftp/FTPClient;->__restartOffset:J

    .line 2504
    invoke-static {p1, p2}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->rest(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveIntermediate(I)Z

    move-result p1

    return p1
.end method

.method public retrieveFile(Ljava/lang/String;Ljava/io/OutputStream;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1845
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->RETR:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {v0}, Lorg/apache/commons/net/ftp/FTPCmd;->getCommand()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->_retrieveFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/OutputStream;)Z

    move-result p1

    return p1
.end method

.method public retrieveFileStream(Ljava/lang/String;)Ljava/io/InputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1918
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->RETR:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {v0}, Lorg/apache/commons/net/ftp/FTPCmd;->getCommand()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->_retrieveFileStream(Ljava/lang/String;Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    return-object p1
.end method

.method public sendNoOp()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2790
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTPClient;->noop()I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    return v0
.end method

.method public sendSiteCommand(Ljava/lang/String;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2680
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->site(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method public setActiveExternalIPAddress(Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/UnknownHostException;
        }
    .end annotation

    .line 1439
    invoke-static {p1}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object p1

    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__activeExternalHost:Ljava/net/InetAddress;

    return-void
.end method

.method public setActivePortRange(II)V
    .locals 0

    .line 1425
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__activeMinPort:I

    .line 1426
    iput p2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__activeMaxPort:I

    return-void
.end method

.method public setAutodetectUTF8(Z)V
    .locals 0

    .line 3736
    iput-boolean p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__autodetectEncoding:Z

    return-void
.end method

.method public setBufferSize(I)V
    .locals 0

    .line 3451
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__bufferSize:I

    return-void
.end method

.method public setControlKeepAliveReplyTimeout(I)V
    .locals 0

    .line 3616
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__controlKeepAliveReplyTimeout:I

    return-void
.end method

.method public setControlKeepAliveTimeout(J)V
    .locals 2

    const-wide/16 v0, 0x3e8

    mul-long p1, p1, v0

    .line 3596
    iput-wide p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__controlKeepAliveTimeout:J

    return-void
.end method

.method public setCopyStreamListener(Lorg/apache/commons/net/io/CopyStreamListener;)V
    .locals 0

    .line 3574
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__copyStreamListener:Lorg/apache/commons/net/io/CopyStreamListener;

    return-void
.end method

.method public setDataTimeout(I)V
    .locals 0

    .line 960
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__dataTimeout:I

    return-void
.end method

.method public setFileStructure(I)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1596
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->stru(I)I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1598
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileStructure:I

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public setFileTransferMode(I)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1623
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->mode(I)I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1625
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileTransferMode:I

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public setFileType(I)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1519
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->type(I)I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1521
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileType:I

    const/4 p1, 0x4

    .line 1522
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileFormat:I

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public setFileType(II)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1568
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->type(II)I

    move-result v0

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1570
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileType:I

    .line 1571
    iput p2, p0, Lorg/apache/commons/net/ftp/FTPClient;->__fileFormat:I

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public setListHiddenFiles(Z)V
    .locals 0

    .line 3525
    iput-boolean p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__listHiddenFiles:Z

    return-void
.end method

.method public setModificationTime(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 3441
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->mfmt(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

.method public setParserFactory(Lorg/apache/commons/net/ftp/parser/FTPFileEntryParserFactory;)V
    .locals 0

    .line 973
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__parserFactory:Lorg/apache/commons/net/ftp/parser/FTPFileEntryParserFactory;

    return-void
.end method

.method public setPassiveLocalIPAddress(Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/UnknownHostException;
        }
    .end annotation

    .line 1451
    invoke-static {p1}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object p1

    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveLocalHost:Ljava/net/InetAddress;

    return-void
.end method

.method public setPassiveLocalIPAddress(Ljava/net/InetAddress;)V
    .locals 0

    .line 1462
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveLocalHost:Ljava/net/InetAddress;

    return-void
.end method

.method public setPassiveNatWorkaround(Z)V
    .locals 0

    .line 3640
    iput-boolean p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__passiveNatWorkaround:Z

    return-void
.end method

.method public setReceieveDataSocketBufferSize(I)V
    .locals 0

    .line 3490
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__receiveDataSocketBufferSize:I

    return-void
.end method

.method public setRemoteVerificationEnabled(Z)V
    .locals 0

    .line 1002
    iput-boolean p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__remoteVerificationEnabled:Z

    return-void
.end method

.method public setReportActiveExternalIPAddress(Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/UnknownHostException;
        }
    .end annotation

    .line 1487
    invoke-static {p1}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object p1

    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__reportActiveExternalHost:Ljava/net/InetAddress;

    return-void
.end method

.method public setRestartOffset(J)V
    .locals 3

    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    if-ltz v2, :cond_0

    .line 2526
    iput-wide p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__restartOffset:J

    :cond_0
    return-void
.end method

.method public setSendDataSocketBufferSize(I)V
    .locals 0

    .line 3470
    iput p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__sendDataSocketBufferSize:I

    return-void
.end method

.method public setUseEPSVwithIPv4(Z)V
    .locals 0

    .line 3563
    iput-boolean p1, p0, Lorg/apache/commons/net/ftp/FTPClient;->__useEPSVwithIPv4:Z

    return-void
.end method

.method public storeFile(Ljava/lang/String;Ljava/io/InputStream;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1976
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STOR:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-direct {p0, v0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->__storeFile(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;Ljava/io/InputStream;)Z

    move-result p1

    return p1
.end method

.method public storeFileStream(Ljava/lang/String;)Ljava/io/OutputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2007
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STOR:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-direct {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->__storeFileStream(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)Ljava/io/OutputStream;

    move-result-object p1

    return-object p1
.end method

.method public storeUniqueFile(Ljava/io/InputStream;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2162
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STOU:Lorg/apache/commons/net/ftp/FTPCmd;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1, p1}, Lorg/apache/commons/net/ftp/FTPClient;->__storeFile(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;Ljava/io/InputStream;)Z

    move-result p1

    return p1
.end method

.method public storeUniqueFile(Ljava/lang/String;Ljava/io/InputStream;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2100
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STOU:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-direct {p0, v0, p1, p2}, Lorg/apache/commons/net/ftp/FTPClient;->__storeFile(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;Ljava/io/InputStream;)Z

    move-result p1

    return p1
.end method

.method public storeUniqueFileStream()Ljava/io/OutputStream;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2192
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STOU:Lorg/apache/commons/net/ftp/FTPCmd;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lorg/apache/commons/net/ftp/FTPClient;->__storeFileStream(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)Ljava/io/OutputStream;

    move-result-object v0

    return-object v0
.end method

.method public storeUniqueFileStream(Ljava/lang/String;)Ljava/io/OutputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2133
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STOU:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-direct {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->__storeFileStream(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)Ljava/io/OutputStream;

    move-result-object p1

    return-object p1
.end method

.method public structureMount(Ljava/lang/String;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1165
    invoke-virtual {p0, p1}, Lorg/apache/commons/net/ftp/FTPClient;->smnt(Ljava/lang/String;)I

    move-result p1

    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositiveCompletion(I)Z

    move-result p1

    return p1
.end method

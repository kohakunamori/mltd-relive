.class public Lorg/apache/commons/net/ftp/FTP;
.super Lorg/apache/commons/net/SocketClient;
.source "FTP.java"


# static fields
.field public static final ASCII_FILE_TYPE:I = 0x0

.field public static final BINARY_FILE_TYPE:I = 0x2

.field public static final BLOCK_TRANSFER_MODE:I = 0xb

.field public static final CARRIAGE_CONTROL_TEXT_FORMAT:I = 0x6

.field public static final COMPRESSED_TRANSFER_MODE:I = 0xc

.field public static final DEFAULT_CONTROL_ENCODING:Ljava/lang/String; = "ISO-8859-1"

.field public static final DEFAULT_DATA_PORT:I = 0x14

.field public static final DEFAULT_PORT:I = 0x15

.field public static final EBCDIC_FILE_TYPE:I = 0x1

.field public static final FILE_STRUCTURE:I = 0x7

.field public static final LOCAL_FILE_TYPE:I = 0x3

.field public static final NON_PRINT_TEXT_FORMAT:I = 0x4

.field public static final PAGE_STRUCTURE:I = 0x9

.field public static final RECORD_STRUCTURE:I = 0x8

.field public static final REPLY_CODE_LEN:I = 0x3

.field public static final STREAM_TRANSFER_MODE:I = 0xa

.field public static final TELNET_TEXT_FORMAT:I = 0x5

.field private static final __modes:Ljava/lang/String; = "AEILNTCFRPSBC"


# instance fields
.field protected _commandSupport_:Lorg/apache/commons/net/ProtocolCommandSupport;

.field protected _controlEncoding:Ljava/lang/String;

.field protected _controlInput_:Ljava/io/BufferedReader;

.field protected _controlOutput_:Ljava/io/BufferedWriter;

.field protected _newReplyString:Z

.field protected _replyCode:I

.field protected _replyLines:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field protected _replyString:Ljava/lang/String;

.field protected strictMultilineParsing:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 265
    invoke-direct {p0}, Lorg/apache/commons/net/SocketClient;-><init>()V

    const/4 v0, 0x0

    .line 238
    iput-boolean v0, p0, Lorg/apache/commons/net/ftp/FTP;->strictMultilineParsing:Z

    const/16 v1, 0x15

    .line 266
    invoke-virtual {p0, v1}, Lorg/apache/commons/net/ftp/FTP;->setDefaultPort(I)V

    .line 267
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lorg/apache/commons/net/ftp/FTP;->_replyLines:Ljava/util/ArrayList;

    .line 268
    iput-boolean v0, p0, Lorg/apache/commons/net/ftp/FTP;->_newReplyString:Z

    const/4 v0, 0x0

    .line 269
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_replyString:Ljava/lang/String;

    const-string v0, "ISO-8859-1"

    .line 270
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_controlEncoding:Ljava/lang/String;

    .line 271
    new-instance v0, Lorg/apache/commons/net/ProtocolCommandSupport;

    invoke-direct {v0, p0}, Lorg/apache/commons/net/ProtocolCommandSupport;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_commandSupport_:Lorg/apache/commons/net/ProtocolCommandSupport;

    return-void
.end method

.method private __buildMessage(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 488
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 490
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-eqz p2, :cond_0

    const/16 p1, 0x20

    .line 494
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 495
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_0
    const-string p1, "\r\n"

    .line 497
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 498
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private __getReply()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x1

    .line 294
    invoke-direct {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->__getReply(Z)V

    return-void
.end method

.method private __getReply(Z)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 p1, 0x1

    .line 311
    iput-boolean p1, p0, Lorg/apache/commons/net/ftp/FTP;->_newReplyString:Z

    .line 312
    iget-object p1, p0, Lorg/apache/commons/net/ftp/FTP;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->clear()V

    .line 314
    iget-object p1, p0, Lorg/apache/commons/net/ftp/FTP;->_controlInput_:Ljava/io/BufferedReader;

    invoke-virtual {p1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Connection closed without indication."

    if-eqz p1, :cond_6

    .line 323
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x3

    if-lt v1, v2, :cond_5

    const/4 v3, 0x0

    .line 332
    :try_start_0
    invoke-virtual {p1, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    .line 333
    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    iput v4, p0, Lorg/apache/commons/net/ftp/FTP;->_replyCode:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 341
    iget-object v4, p0, Lorg/apache/commons/net/ftp/FTP;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v4, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    if-le v1, v2, :cond_3

    .line 344
    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result p1

    const/16 v1, 0x2d

    if-ne p1, v1, :cond_3

    .line 348
    :cond_0
    :goto_0
    iget-object p1, p0, Lorg/apache/commons/net/ftp/FTP;->_controlInput_:Ljava/io/BufferedReader;

    invoke-virtual {p1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_2

    .line 355
    iget-object v1, p0, Lorg/apache/commons/net/ftp/FTP;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 361
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTP;->isStrictMultilineParsing()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-direct {p0, p1, v3}, Lorg/apache/commons/net/ftp/FTP;->__strictCheck(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    goto :goto_0

    :cond_1
    invoke-direct {p0, p1}, Lorg/apache/commons/net/ftp/FTP;->__lenientCheck(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_1

    .line 351
    :cond_2
    new-instance p1, Lorg/apache/commons/net/ftp/FTPConnectionClosedException;

    invoke-direct {p1, v0}, Lorg/apache/commons/net/ftp/FTPConnectionClosedException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 364
    :cond_3
    :goto_1
    iget p1, p0, Lorg/apache/commons/net/ftp/FTP;->_replyCode:I

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTP;->getReplyString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/net/ftp/FTP;->fireReplyReceived(ILjava/lang/String;)V

    .line 366
    iget p1, p0, Lorg/apache/commons/net/ftp/FTP;->_replyCode:I

    const/16 v0, 0x1a5

    if-eq p1, v0, :cond_4

    return-void

    .line 367
    :cond_4
    new-instance p1, Lorg/apache/commons/net/ftp/FTPConnectionClosedException;

    const-string v0, "FTP response 421 received.  Server closed connection."

    invoke-direct {p1, v0}, Lorg/apache/commons/net/ftp/FTPConnectionClosedException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 337
    :catch_0
    new-instance v0, Lorg/apache/commons/net/MalformedServerReplyException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Could not parse response code.\nServer Reply: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lorg/apache/commons/net/MalformedServerReplyException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 325
    :cond_5
    new-instance v0, Lorg/apache/commons/net/MalformedServerReplyException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Truncated server reply: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lorg/apache/commons/net/MalformedServerReplyException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 317
    :cond_6
    new-instance p1, Lorg/apache/commons/net/ftp/FTPConnectionClosedException;

    invoke-direct {p1, v0}, Lorg/apache/commons/net/ftp/FTPConnectionClosedException;-><init>(Ljava/lang/String;)V

    goto :goto_3

    :goto_2
    throw p1

    :goto_3
    goto :goto_2
.end method

.method private __lenientCheck(Ljava/lang/String;)Z
    .locals 3

    .line 285
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x3

    if-le v0, v2, :cond_0

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v2, 0x2d

    if-eq v0, v2, :cond_0

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result p1

    invoke-static {p1}, Ljava/lang/Character;->isDigit(C)Z

    move-result p1

    if-nez p1, :cond_1

    :cond_0
    const/4 v1, 0x1

    :cond_1
    return v1
.end method

.method private __send(Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/net/ftp/FTPConnectionClosedException;,
            Ljava/net/SocketException;
        }
    .end annotation

    .line 504
    :try_start_0
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_controlOutput_:Ljava/io/BufferedWriter;

    invoke-virtual {v0, p1}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 505
    iget-object p1, p0, Lorg/apache/commons/net/ftp/FTP;->_controlOutput_:Ljava/io/BufferedWriter;

    invoke-virtual {p1}, Ljava/io/BufferedWriter;->flush()V
    :try_end_0
    .catch Ljava/net/SocketException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 509
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTP;->isConnected()Z

    move-result v0

    if-nez v0, :cond_0

    .line 511
    new-instance p1, Lorg/apache/commons/net/ftp/FTPConnectionClosedException;

    const-string v0, "Connection unexpectedly closed."

    invoke-direct {p1, v0}, Lorg/apache/commons/net/ftp/FTPConnectionClosedException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 515
    :cond_0
    throw p1
.end method

.method private __strictCheck(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 0

    .line 276
    invoke-virtual {p1, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    const/4 p2, 0x3

    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result p1

    const/16 p2, 0x20

    if-eq p1, p2, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    :goto_1
    return p1
.end method


# virtual methods
.method protected __getReplyNoReport()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 304
    invoke-direct {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->__getReply(Z)V

    return-void
.end method

.method protected __noop()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 528
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->NOOP:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {v0}, Lorg/apache/commons/net/ftp/FTPCmd;->getCommand()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lorg/apache/commons/net/ftp/FTP;->__buildMessage(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 529
    invoke-direct {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->__send(Ljava/lang/String;)V

    .line 530
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTP;->__getReplyNoReport()V

    return-void
.end method

.method protected _connectAction_()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 378
    invoke-super {p0}, Lorg/apache/commons/net/SocketClient;->_connectAction_()V

    .line 379
    new-instance v0, Lorg/apache/commons/net/io/CRLFLineReader;

    new-instance v1, Ljava/io/InputStreamReader;

    iget-object v2, p0, Lorg/apache/commons/net/ftp/FTP;->_input_:Ljava/io/InputStream;

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTP;->getControlEncoding()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Lorg/apache/commons/net/io/CRLFLineReader;-><init>(Ljava/io/Reader;)V

    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_controlInput_:Ljava/io/BufferedReader;

    .line 381
    new-instance v0, Ljava/io/BufferedWriter;

    new-instance v1, Ljava/io/OutputStreamWriter;

    iget-object v2, p0, Lorg/apache/commons/net/ftp/FTP;->_output_:Ljava/io/OutputStream;

    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/FTP;->getControlEncoding()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_controlOutput_:Ljava/io/BufferedWriter;

    .line 383
    iget v0, p0, Lorg/apache/commons/net/ftp/FTP;->connectTimeout:I

    if-lez v0, :cond_1

    .line 384
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_socket_:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->getSoTimeout()I

    move-result v0

    .line 385
    iget-object v1, p0, Lorg/apache/commons/net/ftp/FTP;->_socket_:Ljava/net/Socket;

    iget v2, p0, Lorg/apache/commons/net/ftp/FTP;->connectTimeout:I

    invoke-virtual {v1, v2}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 387
    :try_start_0
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTP;->__getReply()V

    .line 389
    iget v1, p0, Lorg/apache/commons/net/ftp/FTP;->_replyCode:I

    invoke-static {v1}, Lorg/apache/commons/net/ftp/FTPReply;->isPositivePreliminary(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 390
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTP;->__getReply()V
    :try_end_0
    .catch Ljava/net/SocketTimeoutException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 397
    :cond_0
    iget-object v1, p0, Lorg/apache/commons/net/ftp/FTP;->_socket_:Ljava/net/Socket;

    invoke-virtual {v1, v0}, Ljava/net/Socket;->setSoTimeout(I)V

    goto :goto_1

    :catchall_0
    move-exception v1

    goto :goto_0

    :catch_0
    move-exception v1

    .line 393
    :try_start_1
    new-instance v2, Ljava/io/IOException;

    const-string v3, "Timed out waiting for initial connect reply"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 394
    invoke-virtual {v2, v1}, Ljava/io/IOException;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 395
    throw v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 397
    :goto_0
    iget-object v2, p0, Lorg/apache/commons/net/ftp/FTP;->_socket_:Ljava/net/Socket;

    invoke-virtual {v2, v0}, Ljava/net/Socket;->setSoTimeout(I)V

    throw v1

    .line 400
    :cond_1
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTP;->__getReply()V

    .line 402
    iget v0, p0, Lorg/apache/commons/net/ftp/FTP;->_replyCode:I

    invoke-static {v0}, Lorg/apache/commons/net/ftp/FTPReply;->isPositivePreliminary(I)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 403
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTP;->__getReply()V

    :cond_2
    :goto_1
    return-void
.end method

.method public abor()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 809
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->ABOR:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public acct(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 790
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->ACCT:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public allo(I)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1255
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->ALLO:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public allo(II)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1288
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->ALLO:Lorg/apache/commons/net/ftp/FTPCmd;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " R "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public appe(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1236
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->APPE:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public cdup()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 846
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->CDUP:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public cwd(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 828
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->CWD:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public dele(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1398
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->DELE:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public disconnect()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 443
    invoke-super {p0}, Lorg/apache/commons/net/SocketClient;->disconnect()V

    const/4 v0, 0x0

    .line 444
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_controlInput_:Ljava/io/BufferedReader;

    .line 445
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_controlOutput_:Ljava/io/BufferedWriter;

    const/4 v1, 0x0

    .line 446
    iput-boolean v1, p0, Lorg/apache/commons/net/ftp/FTP;->_newReplyString:Z

    .line 447
    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_replyString:Ljava/lang/String;

    return-void
.end method

.method public eprt(Ljava/net/InetAddress;I)I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 964
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 968
    invoke-virtual {p1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    const-string v2, "%"

    .line 969
    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-lez v2, :cond_0

    const/4 v3, 0x0

    .line 971
    invoke-virtual {v1, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    :cond_0
    const-string v2, "|"

    .line 974
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 976
    instance-of v3, p1, Ljava/net/Inet4Address;

    if-eqz v3, :cond_1

    const-string p1, "1"

    .line 977
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 978
    :cond_1
    instance-of p1, p1, Ljava/net/Inet6Address;

    if-eqz p1, :cond_2

    const-string p1, "2"

    .line 979
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 981
    :cond_2
    :goto_0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 982
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 983
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 984
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 985
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 987
    sget-object p1, Lorg/apache/commons/net/ftp/FTPCmd;->EPRT:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public epsv()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1028
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->EPSV:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public feat()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1268
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->FEAT:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method protected getCommandSupport()Lorg/apache/commons/net/ProtocolCommandSupport;
    .locals 1

    .line 1789
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_commandSupport_:Lorg/apache/commons/net/ProtocolCommandSupport;

    return-object v0
.end method

.method public getControlEncoding()Ljava/lang/String;
    .locals 1

    .line 427
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_controlEncoding:Ljava/lang/String;

    return-object v0
.end method

.method public getReply()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 692
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTP;->__getReply()V

    .line 693
    iget v0, p0, Lorg/apache/commons/net/ftp/FTP;->_replyCode:I

    return v0
.end method

.method public getReplyCode()I
    .locals 1

    .line 670
    iget v0, p0, Lorg/apache/commons/net/ftp/FTP;->_replyCode:I

    return v0
.end method

.method public getReplyString()Ljava/lang/String;
    .locals 3

    .line 720
    iget-boolean v0, p0, Lorg/apache/commons/net/ftp/FTP;->_newReplyString:Z

    if-nez v0, :cond_0

    .line 721
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_replyString:Ljava/lang/String;

    return-object v0

    .line 724
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v1, 0x100

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 726
    iget-object v1, p0, Lorg/apache/commons/net/ftp/FTP;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 727
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\r\n"

    .line 728
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    .line 731
    iput-boolean v1, p0, Lorg/apache/commons/net/ftp/FTP;->_newReplyString:Z

    .line 733
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_replyString:Ljava/lang/String;

    return-object v0
.end method

.method public getReplyStrings()[Ljava/lang/String;
    .locals 2

    .line 706
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_replyLines:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    new-array v1, v1, [Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    return-object v0
.end method

.method public help()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1726
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->HELP:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public help(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1745
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->HELP:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public isStrictMultilineParsing()Z
    .locals 1

    .line 1772
    iget-boolean v0, p0, Lorg/apache/commons/net/ftp/FTP;->strictMultilineParsing:Z

    return v0
.end method

.method public list()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1475
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->LIST:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public list(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1498
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->LIST:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public mdtm(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1317
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->MDTM:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public mfmt(Ljava/lang/String;Ljava/lang/String;)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1340
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->MFMT:Lorg/apache/commons/net/ftp/FTPCmd;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, " "

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public mkd(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1436
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->MKD:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public mlsd()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1520
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->MLSD:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public mlsd(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1544
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->MLSD:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public mlst()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1566
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->MLST:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public mlst(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1590
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->MLST:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public mode(I)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1123
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->MODE:Lorg/apache/commons/net/ftp/FTPCmd;

    add-int/lit8 v1, p1, 0x1

    const-string v2, "AEILNTCFRPSBC"

    invoke-virtual {v2, p1, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public nlst()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1611
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->NLST:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public nlst(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1634
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->NLST:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public noop()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1763
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->NOOP:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public pass(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 771
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->PASS:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public pasv()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1007
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->PASV:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public port(Ljava/net/InetAddress;I)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 922
    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v1, 0x18

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 924
    invoke-virtual {p1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object p1

    const/16 v1, 0x2c

    const/16 v2, 0x2e

    invoke-virtual {p1, v2, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    ushr-int/lit8 p1, p2, 0x8

    .line 926
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 927
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 928
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    and-int/lit16 p1, p2, 0xff

    .line 930
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 932
    sget-object p1, Lorg/apache/commons/net/ftp/FTPCmd;->PORT:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public pwd()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1454
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->PWD:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public quit()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 864
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->QUIT:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public rein()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 882
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->REIN:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public rest(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1308
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->REST:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public retr(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1146
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->RETR:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public rmd(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1417
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->RMD:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public rnfr(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1360
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->RNFR:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public rnto(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1379
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->RNTO:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public sendCommand(I)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 656
    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(ILjava/lang/String;)I

    move-result p1

    return p1
.end method

.method public sendCommand(ILjava/lang/String;)I
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 558
    invoke-static {p1}, Lorg/apache/commons/net/ftp/FTPCommand;->getCommand(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public sendCommand(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 631
    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public sendCommand(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 473
    iget-object v0, p0, Lorg/apache/commons/net/ftp/FTP;->_controlOutput_:Ljava/io/BufferedWriter;

    if-eqz v0, :cond_0

    .line 477
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTP;->__buildMessage(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 479
    invoke-direct {p0, p2}, Lorg/apache/commons/net/ftp/FTP;->__send(Ljava/lang/String;)V

    .line 481
    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTP;->fireCommandSent(Ljava/lang/String;Ljava/lang/String;)V

    .line 483
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTP;->__getReply()V

    .line 484
    iget p1, p0, Lorg/apache/commons/net/ftp/FTP;->_replyCode:I

    return p1

    .line 474
    :cond_0
    new-instance p1, Ljava/io/IOException;

    const-string p2, "Connection is not open"

    invoke-direct {p1, p2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 582
    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 608
    invoke-virtual {p1}, Lorg/apache/commons/net/ftp/FTPCmd;->getCommand()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public setControlEncoding(Ljava/lang/String;)V
    .locals 0

    .line 418
    iput-object p1, p0, Lorg/apache/commons/net/ftp/FTP;->_controlEncoding:Ljava/lang/String;

    return-void
.end method

.method public setStrictMultilineParsing(Z)V
    .locals 0

    .line 1781
    iput-boolean p1, p0, Lorg/apache/commons/net/ftp/FTP;->strictMultilineParsing:Z

    return-void
.end method

.method public site(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1653
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->SITE:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public smnt(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 901
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->SMNT:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public stat()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1689
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STAT:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public stat(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1708
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STAT:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public stor(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1169
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STOR:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public stou()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1190
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STOU:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public stou(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1213
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STOU:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public stru(I)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1102
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->STRU:Lorg/apache/commons/net/ftp/FTPCmd;

    add-int/lit8 v1, p1, 0x1

    const-string v2, "AEILNTCFRPSBC"

    invoke-virtual {v2, p1, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public syst()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1671
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->SYST:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;)I

    move-result v0

    return v0
.end method

.method public type(I)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1081
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->TYPE:Lorg/apache/commons/net/ftp/FTPCmd;

    add-int/lit8 v1, p1, 0x1

    const-string v2, "AEILNTCFRPSBC"

    invoke-virtual {v2, p1, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public type(II)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1050
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "AEILNTCFRPSBC"

    .line 1052
    invoke-virtual {v1, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const/16 v2, 0x20

    .line 1053
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const/4 v2, 0x3

    if-ne p1, v2, :cond_0

    .line 1055
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 1057
    :cond_0
    invoke-virtual {v1, p2}, Ljava/lang/String;->charAt(I)C

    move-result p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1060
    :goto_0
    sget-object p1, Lorg/apache/commons/net/ftp/FTPCmd;->TYPE:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public user(Ljava/lang/String;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 753
    sget-object v0, Lorg/apache/commons/net/ftp/FTPCmd;->USER:Lorg/apache/commons/net/ftp/FTPCmd;

    invoke-virtual {p0, v0, p1}, Lorg/apache/commons/net/ftp/FTP;->sendCommand(Lorg/apache/commons/net/ftp/FTPCmd;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

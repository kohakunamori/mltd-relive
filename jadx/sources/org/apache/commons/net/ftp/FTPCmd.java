package org.apache.commons.net.ftp;

/* JADX INFO: loaded from: classes.dex */
public enum FTPCmd {
    ABOR,
    ACCT,
    ALLO,
    APPE,
    CDUP,
    CWD,
    DELE,
    EPRT,
    EPSV,
    FEAT,
    HELP,
    LIST,
    MDTM,
    MFMT,
    MKD,
    MLSD,
    MLST,
    MODE,
    NLST,
    NOOP,
    PASS,
    PASV,
    PORT,
    PWD,
    QUIT,
    REIN,
    REST,
    RETR,
    RMD,
    RNFR,
    RNTO,
    SITE,
    SMNT,
    STAT,
    STOR,
    STOU,
    STRU,
    SYST,
    TYPE,
    USER;

    public static final FTPCmd ABORT;
    public static final FTPCmd ACCOUNT;
    public static final FTPCmd ALLOCATE;
    public static final FTPCmd APPEND;
    public static final FTPCmd CHANGE_TO_PARENT_DIRECTORY;
    public static final FTPCmd CHANGE_WORKING_DIRECTORY;
    public static final FTPCmd DATA_PORT;
    public static final FTPCmd DELETE;
    public static final FTPCmd FEATURES;
    public static final FTPCmd FILE_STRUCTURE;
    public static final FTPCmd GET_MOD_TIME;
    public static final FTPCmd LOGOUT;
    public static final FTPCmd MAKE_DIRECTORY;
    public static final FTPCmd MOD_TIME;
    public static final FTPCmd NAME_LIST;
    public static final FTPCmd PASSIVE;
    public static final FTPCmd PASSWORD;
    public static final FTPCmd PRINT_WORKING_DIRECTORY;
    public static final FTPCmd REINITIALIZE;
    public static final FTPCmd REMOVE_DIRECTORY;
    public static final FTPCmd RENAME_FROM;
    public static final FTPCmd RENAME_TO;
    public static final FTPCmd REPRESENTATION_TYPE;
    public static final FTPCmd RESTART;
    public static final FTPCmd RETRIEVE;
    public static final FTPCmd SET_MOD_TIME;
    public static final FTPCmd SITE_PARAMETERS;
    public static final FTPCmd STATUS;
    public static final FTPCmd STORE;
    public static final FTPCmd STORE_UNIQUE;
    public static final FTPCmd STRUCTURE_MOUNT;
    public static final FTPCmd SYSTEM;
    public static final FTPCmd TRANSFER_MODE;
    public static final FTPCmd USERNAME;

    static {
        FTPCmd fTPCmd = ABOR;
        FTPCmd fTPCmd2 = ACCT;
        FTPCmd fTPCmd3 = ALLO;
        FTPCmd fTPCmd4 = APPE;
        FTPCmd fTPCmd5 = CDUP;
        FTPCmd fTPCmd6 = CWD;
        FTPCmd fTPCmd7 = DELE;
        FTPCmd fTPCmd8 = FEAT;
        FTPCmd fTPCmd9 = MDTM;
        FTPCmd fTPCmd10 = MFMT;
        FTPCmd fTPCmd11 = MKD;
        FTPCmd fTPCmd12 = MODE;
        FTPCmd fTPCmd13 = NLST;
        FTPCmd fTPCmd14 = PASS;
        FTPCmd fTPCmd15 = PASV;
        FTPCmd fTPCmd16 = PORT;
        FTPCmd fTPCmd17 = PWD;
        FTPCmd fTPCmd18 = QUIT;
        FTPCmd fTPCmd19 = REIN;
        FTPCmd fTPCmd20 = REST;
        FTPCmd fTPCmd21 = RETR;
        FTPCmd fTPCmd22 = RMD;
        FTPCmd fTPCmd23 = RNFR;
        FTPCmd fTPCmd24 = RNTO;
        FTPCmd fTPCmd25 = SITE;
        FTPCmd fTPCmd26 = SMNT;
        FTPCmd fTPCmd27 = STAT;
        FTPCmd fTPCmd28 = STOR;
        FTPCmd fTPCmd29 = STOU;
        FTPCmd fTPCmd30 = STRU;
        FTPCmd fTPCmd31 = SYST;
        FTPCmd fTPCmd32 = TYPE;
        FTPCmd fTPCmd33 = USER;
        ABORT = fTPCmd;
        ACCOUNT = fTPCmd2;
        ALLOCATE = fTPCmd3;
        APPEND = fTPCmd4;
        CHANGE_TO_PARENT_DIRECTORY = fTPCmd5;
        CHANGE_WORKING_DIRECTORY = fTPCmd6;
        DATA_PORT = fTPCmd16;
        DELETE = fTPCmd7;
        FEATURES = fTPCmd8;
        FILE_STRUCTURE = fTPCmd30;
        GET_MOD_TIME = fTPCmd9;
        LOGOUT = fTPCmd18;
        MAKE_DIRECTORY = fTPCmd11;
        MOD_TIME = fTPCmd9;
        NAME_LIST = fTPCmd13;
        PASSIVE = fTPCmd15;
        PASSWORD = fTPCmd14;
        PRINT_WORKING_DIRECTORY = fTPCmd17;
        REINITIALIZE = fTPCmd19;
        REMOVE_DIRECTORY = fTPCmd22;
        RENAME_FROM = fTPCmd23;
        RENAME_TO = fTPCmd24;
        REPRESENTATION_TYPE = fTPCmd32;
        RESTART = fTPCmd20;
        RETRIEVE = fTPCmd21;
        SET_MOD_TIME = fTPCmd10;
        SITE_PARAMETERS = fTPCmd25;
        STATUS = fTPCmd27;
        STORE = fTPCmd28;
        STORE_UNIQUE = fTPCmd29;
        STRUCTURE_MOUNT = fTPCmd26;
        SYSTEM = fTPCmd31;
        TRANSFER_MODE = fTPCmd12;
        USERNAME = fTPCmd33;
    }

    public final String getCommand() {
        return name();
    }
}

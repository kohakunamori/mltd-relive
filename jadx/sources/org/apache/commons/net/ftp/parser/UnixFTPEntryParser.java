package org.apache.commons.net.ftp.parser;

import com.google.android.gms.games.quest.Quests;
import java.text.ParseException;
import java.util.List;
import java.util.ListIterator;
import org.apache.commons.net.ftp.FTPClientConfig;
import org.apache.commons.net.ftp.FTPFile;

/* JADX INFO: loaded from: classes.dex */
public class UnixFTPEntryParser extends ConfigurableFTPFileEntryParserImpl {
    static final String DEFAULT_DATE_FORMAT = "MMM d yyyy";
    static final String DEFAULT_RECENT_DATE_FORMAT = "MMM d HH:mm";
    private static final String REGEX = "([bcdelfmpSs-])(((r|-)(w|-)([xsStTL-]))((r|-)(w|-)([xsStTL-]))((r|-)(w|-)([xsStTL-])))\\+?\\s*(\\d+)\\s+(?:(\\S+(?:\\s\\S+)*?)\\s+)?(?:(\\S+(?:\\s\\S+)*)\\s+)?(\\d+(?:,\\s*\\d+)?)\\s+((?:\\d+[-/]\\d+[-/]\\d+)|(?:\\S{3}\\s+\\d{1,2})|(?:\\d{1,2}\\s+\\S{3}))\\s+(\\d+(?::\\d+)?)\\s+(\\S*)(\\s*.*)";
    static final String NUMERIC_DATE_FORMAT = "yyyy-MM-dd HH:mm";
    public static final FTPClientConfig NUMERIC_DATE_CONFIG = new FTPClientConfig(FTPClientConfig.SYST_UNIX, NUMERIC_DATE_FORMAT, null, null, null, null);

    public UnixFTPEntryParser() {
        this(null);
    }

    public UnixFTPEntryParser(FTPClientConfig fTPClientConfig) {
        super(REGEX);
        configure(fTPClientConfig);
    }

    @Override // org.apache.commons.net.ftp.FTPFileEntryParserImpl, org.apache.commons.net.ftp.FTPFileEntryParser
    public List<String> preParse(List<String> list) {
        ListIterator<String> listIterator = list.listIterator();
        while (listIterator.hasNext()) {
            if (listIterator.next().matches("^total \\d+$")) {
                listIterator.remove();
            }
        }
        return list;
    }

    /* JADX WARN: Code duplicated, block: B:13:0x0076  */
    /* JADX WARN: Code duplicated, block: B:16:0x007d  */
    @Override // org.apache.commons.net.ftp.FTPFileEntryParser
    public FTPFile parseFTPEntry(String str) {
        int i;
        boolean z;
        int iIndexOf;
        FTPFile fTPFile = new FTPFile();
        fTPFile.setRawListing(str);
        if (!matches(str)) {
            return null;
        }
        String strGroup = group(1);
        String strGroup2 = group(15);
        String strGroup3 = group(16);
        String strGroup4 = group(17);
        String strGroup5 = group(18);
        String str2 = group(19) + " " + group(20);
        String strGroup6 = group(21);
        String strGroup7 = group(22);
        try {
            fTPFile.setTimestamp(super.parseTimestamp(str2));
        } catch (ParseException unused) {
        }
        char cCharAt = strGroup.charAt(0);
        if (cCharAt == '-') {
            i = 0;
            z = false;
        } else if (cCharAt != 'l') {
            switch (cCharAt) {
                case 'b':
                case 'c':
                    i = 0;
                    z = true;
                    break;
                case 'd':
                    i = 1;
                    z = false;
                    break;
                case Quests.SELECT_COMPLETED_UNCLAIMED /* 101 */:
                    i = 2;
                    z = false;
                    break;
                case Quests.SELECT_ENDING_SOON /* 102 */:
                    i = 0;
                    z = false;
                    break;
                default:
                    i = 3;
                    z = false;
                    break;
            }
        } else {
            i = 2;
            z = false;
        }
        fTPFile.setType(i);
        int i2 = 4;
        int i3 = 0;
        for (int i4 = 3; i3 < i4; i4 = 3) {
            fTPFile.setPermission(i3, 0, !group(i2).equals("-"));
            fTPFile.setPermission(i3, 1, !group(i2 + 1).equals("-"));
            String strGroup8 = group(i2 + 2);
            if (!strGroup8.equals("-") && !Character.isUpperCase(strGroup8.charAt(0))) {
                fTPFile.setPermission(i3, 2, true);
            } else {
                fTPFile.setPermission(i3, 2, false);
            }
            i3++;
            i2 += 4;
        }
        if (!z) {
            try {
                fTPFile.setHardLinkCount(Integer.parseInt(strGroup2));
            } catch (NumberFormatException unused2) {
            }
        }
        fTPFile.setUser(strGroup3);
        fTPFile.setGroup(strGroup4);
        try {
            fTPFile.setSize(Long.parseLong(strGroup5));
        } catch (NumberFormatException unused3) {
        }
        if (strGroup7 == null) {
            fTPFile.setName(strGroup6);
        } else {
            String str3 = strGroup6 + strGroup7;
            if (i != 2 || (iIndexOf = str3.indexOf(" -> ")) == -1) {
                fTPFile.setName(str3);
            } else {
                fTPFile.setName(str3.substring(0, iIndexOf));
                fTPFile.setLink(str3.substring(iIndexOf + 4));
            }
        }
        return fTPFile;
    }

    @Override // org.apache.commons.net.ftp.parser.ConfigurableFTPFileEntryParserImpl
    protected FTPClientConfig getDefaultConfiguration() {
        return new FTPClientConfig(FTPClientConfig.SYST_UNIX, "MMM d yyyy", "MMM d HH:mm", null, null, null);
    }
}

package org.apache.commons.net.ftp.parser;

import com.google.android.gms.games.quest.Quests;
import java.text.ParseException;
import org.apache.commons.net.ftp.FTPClientConfig;
import org.apache.commons.net.ftp.FTPFile;

/* JADX INFO: loaded from: classes.dex */
public class MacOsPeterFTPEntryParser extends ConfigurableFTPFileEntryParserImpl {
    static final String DEFAULT_DATE_FORMAT = "MMM d yyyy";
    static final String DEFAULT_RECENT_DATE_FORMAT = "MMM d HH:mm";
    private static final String REGEX = "([bcdelfmpSs-])(((r|-)(w|-)([xsStTL-]))((r|-)(w|-)([xsStTL-]))((r|-)(w|-)([xsStTL-])))\\+?\\s+((folder\\s+)|((\\d+)\\s+(\\d+)\\s+))(\\d+)\\s+((?:\\d+[-/]\\d+[-/]\\d+)|(?:\\S{3}\\s+\\d{1,2})|(?:\\d{1,2}\\s+\\S{3}))\\s+(\\d+(?::\\d+)?)\\s+(\\S*)(\\s*.*)";

    public MacOsPeterFTPEntryParser() {
        this(null);
    }

    public MacOsPeterFTPEntryParser(FTPClientConfig fTPClientConfig) {
        super(REGEX);
        configure(fTPClientConfig);
    }

    /* JADX WARN: Code duplicated, block: B:13:0x0068  */
    /* JADX WARN: Code duplicated, block: B:16:0x006f  */
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
        String strGroup2 = group(20);
        String str2 = group(21) + " " + group(22);
        String strGroup3 = group(23);
        String strGroup4 = group(24);
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
        int i2 = 0;
        int i3 = 4;
        for (int i4 = 3; i2 < i4; i4 = 3) {
            fTPFile.setPermission(i2, 0, !group(i3).equals("-"));
            fTPFile.setPermission(i2, 1, !group(i3 + 1).equals("-"));
            String strGroup5 = group(i3 + 2);
            if (!strGroup5.equals("-") && !Character.isUpperCase(strGroup5.charAt(0))) {
                fTPFile.setPermission(i2, 2, true);
            } else {
                fTPFile.setPermission(i2, 2, false);
            }
            i2++;
            i3 += 4;
        }
        if (!z) {
            try {
                fTPFile.setHardLinkCount(Integer.parseInt("0"));
            } catch (NumberFormatException unused2) {
            }
        }
        fTPFile.setUser(null);
        fTPFile.setGroup(null);
        try {
            fTPFile.setSize(Long.parseLong(strGroup2));
        } catch (NumberFormatException unused3) {
        }
        if (strGroup4 == null) {
            fTPFile.setName(strGroup3);
        } else {
            String str3 = strGroup3 + strGroup4;
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

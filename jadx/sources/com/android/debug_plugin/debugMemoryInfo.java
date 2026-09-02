package com.android.debug_plugin;

import android.app.ActivityManager;
import android.os.Debug;
import android.os.Process;
import com.unity3d.player.UnityPlayer;

/* JADX INFO: loaded from: classes.dex */
public class debugMemoryInfo {
    public static int AppUseHeapSw = 8;
    public static int DalvikHeapSw = 4;
    public static int DebugMemoryPssSw = 32;
    public static int LinuxHeapSw = 1;
    public static int MemoryClassSw = 16;
    public static int NativeHeapSw = 2;
    public static int SysteMemorySw = 64;

    private static float ToKB(float f) {
        return f / 1024.0f;
    }

    private static float ToMB(float f) {
        return f / 1048576.0f;
    }

    public void GetMemoryInfo(String str, String str2, int i) {
        UnityPlayer.UnitySendMessage(str, str2, GetMemoryInfo(i));
    }

    public static String GetMemoryInfo(int i) {
        ActivityManager activityManager = (ActivityManager) UnityPlayer.currentActivity.getApplication().getSystemService("activity");
        if (i == 0) {
            i = LinuxHeapSw | NativeHeapSw | DalvikHeapSw;
        }
        String linuxHeapInfo = (LinuxHeapSw & i) != 0 ? getLinuxHeapInfo(activityManager, "") : "";
        if ((NativeHeapSw & i) != 0) {
            linuxHeapInfo = getNativeHeapInfo(linuxHeapInfo);
        }
        if ((DalvikHeapSw & i) != 0) {
            linuxHeapInfo = getDalvikHeapInfo(linuxHeapInfo);
        }
        if ((AppUseHeapSw & i) != 0) {
            linuxHeapInfo = getAppUseHeapInfo(linuxHeapInfo);
        }
        if ((MemoryClassSw & i) != 0) {
            linuxHeapInfo = getMemoryClassInfo(activityManager, linuxHeapInfo);
        }
        if ((DebugMemoryPssSw & i) != 0) {
            linuxHeapInfo = getDebugMemoryInfo(linuxHeapInfo);
        }
        if ((i & SysteMemorySw) != 0) {
            linuxHeapInfo = getSystemMemoryInfo(activityManager, linuxHeapInfo);
        }
        return linuxHeapInfo + "End";
    }

    private static String getLinuxHeapInfo(ActivityManager activityManager, String str) {
        ActivityManager.MemoryInfo memoryInfo = new ActivityManager.MemoryInfo();
        activityManager.getMemoryInfo(memoryInfo);
        float f = memoryInfo.totalMem;
        float f2 = memoryInfo.availMem;
        return (((((str + "LinuxHeapAlloc=" + String.valueOf(ToMB(f - f2))) + ",") + "LinuxHeapFree=" + String.valueOf(ToMB(f2))) + ",") + "LinuxHeapSize=" + String.valueOf(ToMB(f))) + ",";
    }

    private static String getNativeHeapInfo(String str) {
        float nativeHeapSize = Debug.getNativeHeapSize();
        float nativeHeapAllocatedSize = Debug.getNativeHeapAllocatedSize();
        float nativeHeapFreeSize = Debug.getNativeHeapFreeSize();
        return (((((str + "NativeHeapAlloc=" + String.valueOf(ToMB(nativeHeapAllocatedSize))) + ",") + "NativeHeapFree=" + String.valueOf(ToMB(nativeHeapFreeSize))) + ",") + "NativeHeapSize=" + String.valueOf(ToMB(nativeHeapSize))) + ",";
    }

    private static String getDalvikHeapInfo(String str) {
        float f = Runtime.getRuntime().totalMemory();
        float fFreeMemory = Runtime.getRuntime().freeMemory();
        float fMaxMemory = Runtime.getRuntime().maxMemory();
        return (((((((str + "DalvikHeapAlloc=" + String.valueOf(ToMB(f - fFreeMemory))) + ",") + "DalvikHeapFree=" + String.valueOf(ToMB(fFreeMemory))) + ",") + "DalvikHeapSize=" + String.valueOf(ToMB(f))) + ",") + "DalvikHeapMax=" + String.valueOf(ToMB(fMaxMemory))) + ",";
    }

    private static String getAppUseHeapInfo(String str) {
        return (str + "AppUseHeap=" + String.valueOf(ToMB(Debug.getNativeHeapAllocatedSize() + (Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory())))) + ",";
    }

    private static String getMemoryClassInfo(ActivityManager activityManager, String str) {
        float memoryClass = activityManager.getMemoryClass();
        float largeMemoryClass = activityManager.getLargeMemoryClass();
        return (((str + "offLargeHeapSize=" + String.valueOf(ToMB(memoryClass))) + ",") + "onLargeHeapSize=" + String.valueOf(ToMB(largeMemoryClass))) + ",";
    }

    private static String getDebugMemoryInfo(String str) {
        Debug.MemoryInfo memoryInfo = new Debug.MemoryInfo();
        Debug.getMemoryInfo(memoryInfo);
        float totalPss = memoryInfo.getTotalPss();
        float f = memoryInfo.nativePss;
        float f2 = memoryInfo.otherPss;
        return (((((str + "DebugMemPss=" + String.valueOf(ToKB(totalPss))) + ",") + "DebugNativPss=" + String.valueOf(ToKB(f))) + ",") + "DebugOtherPss=" + String.valueOf(ToKB(f2))) + ",";
    }

    private static String getSystemMemoryInfo(ActivityManager activityManager, String str) {
        long totalPss = 0;
        for (Debug.MemoryInfo memoryInfo : activityManager.getProcessMemoryInfo(new int[]{Process.myPid()})) {
            totalPss += (long) memoryInfo.getTotalPss();
        }
        return (str + "UseSystemMemSize=" + String.valueOf(ToKB(totalPss))) + ",";
    }
}

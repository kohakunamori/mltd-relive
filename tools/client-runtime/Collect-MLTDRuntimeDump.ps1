param(
    [string]$Package = 'com.bandainamcoent.imas_millionlive_theaterdays_ch',
    [string]$OutputDir = '.\mltd-runtime-dump',
    [string]$TinyDumpPath = ''
)

$ErrorActionPreference = 'Stop'
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

function Adb([Parameter(ValueFromRemainingArguments=$true)][string[]]$Args) {
    & adb @Args
    if ($LASTEXITCODE -ne 0) { throw "adb failed: $($Args -join ' ')" }
}

Write-Host "[1/6] Checking device/root/ABI..."
Adb devices
Adb shell su -c id
$abi = (& adb shell getprop ro.product.cpu.abi).Trim()
if ($abi -notmatch 'arm64|aarch64') { throw "Expected ARM64 device, got: $abi" }

$pidText = (& adb shell su -c "pidof $Package").Trim()
if (-not $pidText) {
    throw "Target process is not running: $Package"
}
$pid = ($pidText -split '\s+')[0]
Write-Host "PID=$pid ABI=$abi"

Write-Host "[2/6] Capturing process maps before dump..."
& adb shell su -c "cat /proc/$pid/maps" | Out-File -Encoding ascii (Join-Path $OutputDir 'maps-before.txt')

Write-Host "[3/6] Pulling Zygisk/Frida outputs when present..."
$remoteDump = "/data/data/$Package/files/dump.cs"
& adb shell su -c "test -f $remoteDump && cp $remoteDump /data/local/tmp/mltd-dump.cs"
if ($LASTEXITCODE -eq 0) {
    & adb pull /data/local/tmp/mltd-dump.cs (Join-Path $OutputDir 'dump.cs')
}
& adb shell su -c "find /data/data/$Package/files -maxdepth 4 -type f 2>/dev/null | sort" |
    Out-File -Encoding utf8 (Join-Path $OutputDir 'app-files.txt')

if ($TinyDumpPath) {
    Write-Host "[4/6] Dumping mapped libil2cpp.so with TinyDump..."
    if (-not (Test-Path $TinyDumpPath)) { throw "TinyDump not found: $TinyDumpPath" }
    Adb push $TinyDumpPath /data/local/tmp/tinydump
    Adb shell su -c "chmod 755 /data/local/tmp/tinydump"
    & adb shell su -c "rm -rf /data/local/tmp/mltd-tinydump && mkdir -p /data/local/tmp/mltd-tinydump"
    & adb shell su -c "/data/local/tmp/tinydump --list-so -p $pid" |
        Out-File -Encoding utf8 (Join-Path $OutputDir 'loaded-so.txt')
    & adb shell su -c "/data/local/tmp/tinydump -t libil2cpp.so -p $pid -o /data/local/tmp/mltd-tinydump"
    if ($LASTEXITCODE -ne 0) { throw "TinyDump failed to dump libil2cpp.so" }
    & adb pull /data/local/tmp/mltd-tinydump (Join-Path $OutputDir 'native')
} else {
    Write-Host "[4/6] TinyDump not supplied; skipping native ELF dump."
}

Write-Host "[5/6] Capturing process maps after dump..."
& adb shell su -c "cat /proc/$pid/maps" | Out-File -Encoding ascii (Join-Path $OutputDir 'maps-after.txt')

Write-Host "[6/6] Capturing package/process metadata..."
& adb shell dumpsys package $Package | Out-File -Encoding utf8 (Join-Path $OutputDir 'package.txt')
& adb shell su -c "ls -l /proc/$pid/fd 2>/dev/null" | Out-File -Encoding utf8 (Join-Path $OutputDir 'fds.txt')
& adb shell su -c "cat /proc/$pid/status" | Out-File -Encoding ascii (Join-Path $OutputDir 'status.txt')

Write-Host "Collected runtime evidence into: $OutputDir"
Write-Host "Validate with tools/client-runtime/verify-mltd-runtime-dump.py against dump.cs / recovered libil2cpp.so / metadata."

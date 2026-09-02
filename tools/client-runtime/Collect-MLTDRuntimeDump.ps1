param(
    [string]$Package = 'com.bandainamcoent.imas_millionlive_theaterdays_ch',
    [string]$OutputDir = '.\mltd-runtime-dump',
    [string]$NativeDumperPath = ''
)

$ErrorActionPreference = 'Stop'
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

function Adb([Parameter(ValueFromRemainingArguments=$true)][string[]]$Args) {
    & adb @Args
    if ($LASTEXITCODE -ne 0) { throw "adb failed: $($Args -join ' ')" }
}

Write-Host "[1/5] Checking device/root..."
Adb devices
Adb shell su -c id

$pidText = (& adb shell su -c "pidof $Package").Trim()
if (-not $pidText) {
    throw "Target process is not running: $Package"
}
$pid = ($pidText -split '\s+')[0]
Write-Host "PID=$pid"

Write-Host "[2/5] Capturing process maps..."
& adb shell su -c "cat /proc/$pid/maps" | Out-File -Encoding ascii (Join-Path $OutputDir 'maps.txt')

Write-Host "[3/5] Pulling Zygisk/Frida dump outputs when present..."
$remoteDump = "/data/data/$Package/files/dump.cs"
& adb shell su -c "test -f $remoteDump && cp $remoteDump /data/local/tmp/mltd-dump.cs"
if ($LASTEXITCODE -eq 0) {
    & adb pull /data/local/tmp/mltd-dump.cs (Join-Path $OutputDir 'dump.cs')
}

& adb shell su -c "find /data/data/$Package/files -maxdepth 3 -type f 2>/dev/null | sort" |
    Out-File -Encoding utf8 (Join-Path $OutputDir 'app-files.txt')

if ($NativeDumperPath) {
    Write-Host "[4/5] Running native IL2CPP memory dumper..."
    if (-not (Test-Path $NativeDumperPath)) { throw "Native dumper not found: $NativeDumperPath" }
    Adb push $NativeDumperPath /data/local/tmp/mltd-il2cppdumper
    Adb shell su -c "chmod 755 /data/local/tmp/mltd-il2cppdumper"
    & adb shell su -c "/data/local/tmp/mltd-il2cppdumper -l -p $Package -o /data/local/tmp/mltd-native-dump"
    & adb pull /data/local/tmp/mltd-native-dump (Join-Path $OutputDir 'native')
} else {
    Write-Host "[4/5] Native dumper not supplied; skipping native ELF dump."
}

Write-Host "[5/5] Capturing package/process metadata..."
& adb shell dumpsys package $Package | Out-File -Encoding utf8 (Join-Path $OutputDir 'package.txt')
& adb shell su -c "ls -l /proc/$pid/fd 2>/dev/null" | Out-File -Encoding utf8 (Join-Path $OutputDir 'fds.txt')
& adb shell su -c "cat /proc/$pid/status" | Out-File -Encoding ascii (Join-Path $OutputDir 'status.txt')

Write-Host "Collected runtime evidence into: $OutputDir"
Write-Host "Next: run tools/client-runtime/verify-mltd-runtime-dump.py against dump.cs / recovered ELF / metadata."

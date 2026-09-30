#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <zh-fixed.apk> [output-dir]" >&2
  exit 2
fi

APK="$(realpath "$1")"
OUT="${2:-client-source-output}"
OUT="$(realpath -m "$OUT")"
TOOLS_DIR="${RUNNER_TEMP:-/tmp}/mltd-client-source-tools"
APKTOOL_VERSION="${APKTOOL_VERSION:-2.12.1}"
JADX_VERSION="${JADX_VERSION:-1.5.6}"

if [[ ! -f "$APK" ]]; then
  echo "APK not found: $APK" >&2
  exit 2
fi

rm -rf "$OUT"
mkdir -p "$OUT" "$TOOLS_DIR"
mkdir -p "$OUT/report" "$OUT/raw-critical"

APK_SHA256="$(sha256sum "$APK" | awk '{print $1}')"
printf '%s  %s\n' "$APK_SHA256" "$(basename "$APK")" > "$OUT/report/APK_SHA256.txt"

# Keep the exact binary inputs that matter for future patching without copying
# the whole APK into the decompilation bundle.
unzip -p "$APK" AndroidManifest.xml > "$OUT/raw-critical/AndroidManifest.xml.binary"
unzip -p "$APK" resources.arsc > "$OUT/raw-critical/resources.arsc" || true

unzip -Z1 "$APK" | sort > "$OUT/report/apk-entry-list.txt"
unzip -lv "$APK" > "$OUT/report/apk-zipinfo.txt"

python3 - "$APK" "$OUT/report/apk-structure.json" <<'PY'
import json
import sys
import zipfile
from pathlib import Path

apk = Path(sys.argv[1])
out = Path(sys.argv[2])
with zipfile.ZipFile(apk) as zf:
    names = zf.namelist()
    dex = sorted(n for n in names if n.startswith('classes') and n.endswith('.dex'))
    native = sorted(n for n in names if n.startswith('lib/') and n.endswith('.so'))
    abis = sorted({n.split('/')[1] for n in native if len(n.split('/')) >= 3})
    metadata = sorted(n for n in names if n.endswith('/global-metadata.dat') or n == 'global-metadata.dat')
    payload = {
        'apk': apk.name,
        'entries': len(names),
        'dex_files': dex,
        'native_abis': abis,
        'native_libraries': native,
        'il2cpp_global_metadata': metadata,
        'has_libil2cpp': any(n.endswith('/libil2cpp.so') for n in native),
    }
out.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
PY

# Apktool is pinned to the same version as the existing APK patcher. The full
# decode is a maintenance/source view; future byte-preserving patches should
# still follow tools/apk-patcher's -r strategy for untouched resources.
APKTOOL_JAR="$TOOLS_DIR/apktool_${APKTOOL_VERSION}.jar"
if [[ ! -f "$APKTOOL_JAR" ]]; then
  curl --fail --location --retry 3 \
    "https://github.com/iBotPeaches/Apktool/releases/download/v${APKTOOL_VERSION}/apktool_${APKTOOL_VERSION}.jar" \
    --output "$APKTOOL_JAR"
fi
java -jar "$APKTOOL_JAR" --version | tee "$OUT/report/apktool-version.txt"

APKTOOL_DIR="$OUT/apktool"
set +e
timeout 20m java -jar "$APKTOOL_JAR" d -f -o "$APKTOOL_DIR" "$APK" \
  > "$OUT/report/apktool-decode.log" 2>&1
APKTOOL_RC=$?
set -e
printf '%s\n' "$APKTOOL_RC" > "$OUT/report/apktool-decode.exit-code"
if [[ $APKTOOL_RC -ne 0 ]]; then
  echo "Full apktool decode failed (exit $APKTOOL_RC); retrying no-resource decode." >&2
  rm -rf "$APKTOOL_DIR"
  timeout 20m java -jar "$APKTOOL_JAR" d -f -r -o "$APKTOOL_DIR" "$APK" \
    >> "$OUT/report/apktool-decode.log" 2>&1
  printf '%s\n' "fallback-no-resources" > "$OUT/report/apktool-decode.mode"
else
  printf '%s\n' "full" > "$OUT/report/apktool-decode.mode"
fi

# JADX is a readability view only. It is intentionally allowed to return a
# non-zero code because malformed/unsupported methods should not discard the
# otherwise useful decompilation output.
JADX_ZIP="$TOOLS_DIR/jadx-${JADX_VERSION}.zip"
JADX_HOME="$TOOLS_DIR/jadx-${JADX_VERSION}"
if [[ ! -x "$JADX_HOME/bin/jadx" ]]; then
  rm -rf "$JADX_HOME"
  mkdir -p "$JADX_HOME"
  if [[ ! -f "$JADX_ZIP" ]]; then
    curl --fail --location --retry 3 \
      "https://github.com/skylot/jadx/releases/download/v${JADX_VERSION}/jadx-${JADX_VERSION}.zip" \
      --output "$JADX_ZIP"
  fi
  unzip -q "$JADX_ZIP" -d "$JADX_HOME"
fi
"$JADX_HOME/bin/jadx" --version | tee "$OUT/report/jadx-version.txt"

set +e
timeout 25m "$JADX_HOME/bin/jadx" \
  --show-bad-code \
  --deobf \
  -d "$OUT/jadx" \
  "$APK" \
  > "$OUT/report/jadx.log" 2>&1
JADX_RC=$?
set -e
printf '%s\n' "$JADX_RC" > "$OUT/report/jadx.exit-code"

# Native/IL2CPP reconnaissance. Keep reports small; the actual libil2cpp.so is
# already present inside the apktool tree.
IL2CPP="$(find "$APKTOOL_DIR" -path '*/lib/arm64-v8a/libil2cpp.so' -print -quit || true)"
if [[ -n "$IL2CPP" && -f "$IL2CPP" ]]; then
  sha256sum "$IL2CPP" > "$OUT/report/libil2cpp.sha256"
  file "$IL2CPP" > "$OUT/report/libil2cpp.file.txt"
  readelf -h "$IL2CPP" > "$OUT/report/libil2cpp.elf-header.txt" || true
  readelf -S "$IL2CPP" > "$OUT/report/libil2cpp.elf-sections.txt" || true
  readelf -l "$IL2CPP" > "$OUT/report/libil2cpp.elf-program-headers.txt" || true
  strings -a -n 8 "$IL2CPP" \
    | grep -Eai 'https?://|bandainamco|millionlive|theaterdays|cloudfront|rainbowunicorn|api\.' \
    | sort -u \
    > "$OUT/report/libil2cpp-network-strings.txt" || true
fi

METADATA="$(find "$APKTOOL_DIR" -name global-metadata.dat -print -quit || true)"
if [[ -n "$METADATA" && -f "$METADATA" ]]; then
  sha256sum "$METADATA" > "$OUT/report/global-metadata.sha256"
  file "$METADATA" > "$OUT/report/global-metadata.file.txt"
fi

# Find server/network constants in both exact smali and JADX views.
for tree in "$OUT/apktool" "$OUT/jadx"; do
  name="$(basename "$tree")"
  if [[ -d "$tree" ]]; then
    grep -RInaE --binary-files=without-match \
      'https?://|cloudfront|rainbowunicorn|millionlive|theaterdays|bandainamco' \
      "$tree" \
      > "$OUT/report/${name}-network-hits.txt" || true
  fi
done

# A rebuild check tells us whether the full apktool view can serve as a direct
# build baseline. Failure is recorded, not fatal: exact future patches can use
# the existing byte-preserving patcher strategy.
mkdir -p "$OUT/rebuild-check"
set +e
timeout 20m java -jar "$APKTOOL_JAR" b "$APKTOOL_DIR" \
  -o "$OUT/rebuild-check/unsigned-rebuilt.apk" \
  > "$OUT/report/apktool-rebuild.log" 2>&1
REBUILD_RC=$?
set -e
printf '%s\n' "$REBUILD_RC" > "$OUT/report/apktool-rebuild.exit-code"
if [[ $REBUILD_RC -eq 0 ]]; then
  sha256sum "$OUT/rebuild-check/unsigned-rebuilt.apk" \
    > "$OUT/report/unsigned-rebuilt.sha256"
else
  rm -f "$OUT/rebuild-check/unsigned-rebuilt.apk"
fi

python3 - "$OUT" <<'PY'
import json
import os
import sys
from pathlib import Path

root = Path(sys.argv[1])
def count_tree(path):
    if not path.exists():
        return {'files': 0, 'bytes': 0}
    files = 0
    size = 0
    for p in path.rglob('*'):
        if p.is_file():
            files += 1
            try:
                size += p.stat().st_size
            except OSError:
                pass
    return {'files': files, 'bytes': size}

report = {
    'apktool': count_tree(root / 'apktool'),
    'jadx': count_tree(root / 'jadx'),
    'report': count_tree(root / 'report'),
}
(root / 'report' / 'extraction-summary.json').write_text(
    json.dumps(report, indent=2) + '\n', encoding='utf-8'
)
PY

cat > "$OUT/README.txt" <<'EOF'
MLTD zh-fixed client extraction

apktool/  Exact Dalvik/smali-oriented maintenance view plus decoded resources.
          Treat this as the authoritative editable Android-layer representation.

jadx/     Java-like readability view. This is decompiler output, not a guaranteed
          compilable Gradle project and not authoritative for byte-level patches.

raw-critical/
          Exact binary AndroidManifest.xml/resources.arsc copied from the APK.

report/   Tool versions, APK structure, hashes, network-string hits, IL2CPP ELF
          metadata and rebuild/decompiler logs.

rebuild-check/
          Unsigned apktool rebuild when apktool can rebuild the decoded tree.

Important: MLTD is a Unity IL2CPP title. Most gameplay logic is native in
libil2cpp.so with global-metadata.dat; Java/JADX source alone is only the Android
shell. Future native modifications should be expressed as verified, named patch
points instead of treating JADX output as the game source of truth.
EOF

echo "Extraction complete: $OUT"

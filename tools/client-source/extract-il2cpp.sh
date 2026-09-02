#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <client-source-output>" >&2
  exit 2
fi

ROOT="$(realpath "$1")"
REPORT="$ROOT/report"
DUMP_OUT="$ROOT/il2cpp-dump"
TOOLS_DIR="${RUNNER_TEMP:-/tmp}/mltd-client-source-tools"
IL2CPP_DUMPER_VERSION="${IL2CPP_DUMPER_VERSION:-6.7.46}"

mkdir -p "$REPORT" "$DUMP_OUT" "$TOOLS_DIR"

IL2CPP="$(find "$ROOT/apktool" -path '*/lib/arm64-v8a/libil2cpp.so' -print -quit || true)"
METADATA="$(find "$ROOT/apktool" -name global-metadata.dat -print -quit || true)"

if [[ -z "$IL2CPP" || ! -f "$IL2CPP" ]]; then
  echo "libil2cpp.so not found under $ROOT/apktool" >&2
  exit 2
fi
if [[ -z "$METADATA" || ! -f "$METADATA" ]]; then
  echo "global-metadata.dat not found under $ROOT/apktool" >&2
  exit 2
fi

printf '%s\n' "$IL2CPP_DUMPER_VERSION" > "$REPORT/il2cppdumper-version.txt"

DUMPER_ZIP="$TOOLS_DIR/Il2CppDumper-net6-v${IL2CPP_DUMPER_VERSION}.zip"
DUMPER_HOME="$TOOLS_DIR/Il2CppDumper-net6-v${IL2CPP_DUMPER_VERSION}"
if [[ ! -f "$DUMPER_HOME/Il2CppDumper.dll" ]]; then
  rm -rf "$DUMPER_HOME"
  mkdir -p "$DUMPER_HOME"
  if [[ ! -f "$DUMPER_ZIP" ]]; then
    curl --fail --location --retry 3 \
      "https://github.com/Perfare/Il2CppDumper/releases/download/v${IL2CPP_DUMPER_VERSION}/Il2CppDumper-net6-v${IL2CPP_DUMPER_VERSION}.zip" \
      --output "$DUMPER_ZIP"
  fi
  unzip -q "$DUMPER_ZIP" -d "$DUMPER_HOME"
fi

DOTNET_INFO="$REPORT/dotnet-info.txt"
dotnet --info > "$DOTNET_INFO" 2>&1 || true

# Il2CppDumper reads config.json relative to its own directory, so execute from
# the extracted tool directory. A failure is recorded instead of discarding the
# Android/smali extraction: protected/custom IL2CPP layouts may need Cpp2IL or a
# manual registration recovery path.
set +e
(
  cd "$DUMPER_HOME"
  timeout 20m dotnet ./Il2CppDumper.dll \
    "$IL2CPP" \
    "$METADATA" \
    "$DUMP_OUT"
) > "$REPORT/il2cppdumper.log" 2>&1
DUMPER_RC=$?
set -e
printf '%s\n' "$DUMPER_RC" > "$REPORT/il2cppdumper.exit-code"

if [[ $DUMPER_RC -ne 0 ]]; then
  echo "Il2CppDumper exited with code $DUMPER_RC; see report/il2cppdumper.log" >&2
  exit 0
fi

# Sanity-check and index the metadata-derived pseudo-source. dump.cs contains
# type/method signatures and RVA/VA/offset annotations, not original C# method
# bodies. It is nevertheless the useful symbol map for future native patches.
if [[ -f "$DUMP_OUT/dump.cs" ]]; then
  sha256sum "$DUMP_OUT/dump.cs" > "$REPORT/il2cpp-dump.cs.sha256"
  grep -Ec '^// Namespace:' "$DUMP_OUT/dump.cs" \
    > "$REPORT/il2cpp-namespace-count.txt" || true
  grep -Ec '^public |^internal |^private |^protected ' "$DUMP_OUT/dump.cs" \
    > "$REPORT/il2cpp-declaration-count.txt" || true

  grep -InaE \
    'https?://|theaterdays|millionlive|bandainamco|Firebase|Api|API|Asset|Server|Network|Http|WebView' \
    "$DUMP_OUT/dump.cs" \
    > "$REPORT/il2cpp-dump-relevant-hits.txt" || true
fi

if [[ -f "$DUMP_OUT/script.json" ]]; then
  sha256sum "$DUMP_OUT/script.json" > "$REPORT/il2cpp-script.json.sha256"
fi
if [[ -f "$DUMP_OUT/il2cpp.h" ]]; then
  sha256sum "$DUMP_OUT/il2cpp.h" > "$REPORT/il2cpp-header.sha256"
fi

python3 - "$DUMP_OUT" "$REPORT/il2cpp-dump-summary.json" <<'PY'
import json
import sys
from pathlib import Path

root = Path(sys.argv[1])
out = Path(sys.argv[2])
files = []
for p in sorted(root.rglob('*')):
    if p.is_file():
        files.append({
            'path': str(p.relative_to(root)),
            'bytes': p.stat().st_size,
        })
out.write_text(json.dumps({'files': files}, indent=2) + '\n', encoding='utf-8')
PY

echo "IL2CPP metadata extraction complete: $DUMP_OUT"

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

dotnet --info > "$REPORT/dotnet-info.txt" 2>&1 || true

# Il2CppDumper reads config.json relative to its own directory, so execute from
# the extracted tool directory. Some releases call Console.ReadKey after all
# files have already been generated; in a redirected CI console this can cause
# a non-zero exit even though dump.cs/script.json/DummyDll are complete. We
# therefore record the process exit code, but use generated output as the
# semantic success criterion.
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

if [[ ! -s "$DUMP_OUT/dump.cs" ]]; then
  printf '%s\n' "failed-no-dump" > "$REPORT/il2cppdumper.result"
  echo "Il2CppDumper produced no dump.cs (exit $DUMPER_RC); see report/il2cppdumper.log" >&2
  exit 0
fi

if [[ $DUMPER_RC -eq 0 ]]; then
  printf '%s\n' "success" > "$REPORT/il2cppdumper.result"
else
  printf '%s\n' "success-output-generated-nonzero-exit-${DUMPER_RC}" \
    > "$REPORT/il2cppdumper.result"
  echo "Il2CppDumper generated output successfully but exited $DUMPER_RC after generation." >&2
fi

# Sanity-check and index the metadata-derived pseudo-source. dump.cs contains
# type/method signatures and RVA/VA/offset annotations, not original C# method
# bodies. It is nevertheless the useful symbol map for future native patches.
sha256sum "$DUMP_OUT/dump.cs" > "$REPORT/il2cpp-dump.cs.sha256"
grep -Ec '^// Namespace:' "$DUMP_OUT/dump.cs" \
  > "$REPORT/il2cpp-namespace-count.txt" || true
grep -Ec '^public |^internal |^private |^protected ' "$DUMP_OUT/dump.cs" \
  > "$REPORT/il2cpp-declaration-count.txt" || true

grep -InaE \
  'https?://|theaterdays|millionlive|bandainamco|Firebase|Api|API|Asset|Server|Network|Http|WebView' \
  "$DUMP_OUT/dump.cs" \
  > "$REPORT/il2cpp-dump-relevant-hits.txt" || true

# Extract the client RPC contract into stable, diff-friendly files. These
# constants are the most useful view when updating the relive server because
# additions/removals immediately show which Service.Method names changed.
python3 - "$DUMP_OUT/dump.cs" "$REPORT" <<'PY'
import collections
import json
import re
import sys
from pathlib import Path

source = Path(sys.argv[1]).read_text(encoding='utf-8', errors='replace')
report = Path(sys.argv[2])

rpc = sorted(set(re.findall(
    r'public const string\s+\w+\s*=\s*"([A-Za-z0-9_]+Service\.[A-Za-z0-9_]+)";',
    source,
)))
(report / 'client-rpc-methods.txt').write_text(
    ''.join(method + '\n' for method in rpc), encoding='utf-8'
)

services = collections.defaultdict(list)
for method in rpc:
    service, action = method.split('.', 1)
    services[service].append(action)
summary = {
    'service_count': len(services),
    'rpc_method_count': len(rpc),
    'services': {k: sorted(v) for k, v in sorted(services.items())},
}
(report / 'client-rpc-surface.json').write_text(
    json.dumps(summary, indent=2, ensure_ascii=False) + '\n', encoding='utf-8'
)

# Pull out the core Imas.Connection API symbols and their nearby RVA comments.
lines = source.splitlines()
needles = (
    'public class API //',
    'GetAuthURL()',
    'GetRpcURL()',
    'GetRootURL()',
    'SetGameServerUrl(',
    'GetResponseJson(',
    'public class ConnectionManager',
    'public class AssetBundleDownloader',
    'public class WebviewUrl',
)
selected = []
for i, line in enumerate(lines):
    if any(n in line for n in needles):
        start = max(0, i - 2)
        end = min(len(lines), i + 2)
        block = '\n'.join(lines[start:end])
        if block not in selected:
            selected.append(block)
(report / 'client-core-network-symbols.txt').write_text(
    '\n\n'.join(selected) + ('\n' if selected else ''), encoding='utf-8'
)
PY

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

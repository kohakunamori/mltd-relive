#!/usr/bin/env python3
"""Prepare the generated zh-fixed decompilation tree for regular Git publishing.

The output is intended for the orphan branch client-decompiled-zh-fixed-v1.
It preserves all decompiler/metadata outputs and removes only rebuild-check/, which
contains a derived unsigned APK rather than decompiled source.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
from pathlib import Path

GITHUB_REGULAR_GIT_LIMIT = 100 * 1024 * 1024
GITHUB_LARGE_FILE_WARNING = 50 * 1024 * 1024


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("source", type=Path)
    parser.add_argument("destination", type=Path)
    parser.add_argument("--release-tag", required=True)
    parser.add_argument("--source-commit", required=True)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    source = args.source.resolve()
    destination = args.destination.resolve()

    if not source.is_dir():
        raise SystemExit(f"Source extraction directory does not exist: {source}")

    if destination.exists():
        shutil.rmtree(destination)
    shutil.copytree(source, destination)

    # Rebuild validation remains recorded in report/, but the rebuilt unsigned
    # APK itself is a build product rather than a decompiler/source output.
    rebuild_check = destination / "rebuild-check"
    if rebuild_check.exists():
        shutil.rmtree(rebuild_check)

    apk_sha_file = destination / "report" / "APK_SHA256.txt"
    if not apk_sha_file.is_file():
        raise SystemExit("report/APK_SHA256.txt is missing")
    apk_hash = apk_sha_file.read_text(encoding="utf-8").split()[0]

    inventory: list[dict[str, object]] = []
    total_bytes = 0
    blocked: list[tuple[int, str]] = []
    warnings: list[tuple[int, str]] = []

    for path in sorted(destination.rglob("*")):
        if not path.is_file():
            continue
        rel = path.relative_to(destination).as_posix()
        size = path.stat().st_size
        total_bytes += size
        if size >= GITHUB_REGULAR_GIT_LIMIT:
            blocked.append((size, rel))
        elif size >= GITHUB_LARGE_FILE_WARNING:
            warnings.append((size, rel))
        inventory.append(
            {
                "path": rel,
                "bytes": size,
                "sha256": sha256(path),
            }
        )

    if blocked:
        detail = "\n".join(f"{size} {path}" for size, path in blocked)
        raise SystemExit(
            "Files at/above the regular Git 100 MiB safety limit:\n" + detail
        )

    largest = sorted(inventory, key=lambda row: int(row["bytes"]), reverse=True)[:20]
    provenance = {
        "baseline": "zh-fixed-v1",
        "release_tag": args.release_tag,
        "source_maintenance_commit": args.source_commit,
        "apk_sha256": apk_hash,
        "file_count_before_metadata": len(inventory),
        "total_bytes_before_metadata": total_bytes,
        "large_regular_git_files_50_mib_or_more": [
            {"path": path, "bytes": size} for size, path in sorted(warnings, reverse=True)
        ],
        "largest_files": largest,
        "generated_by": ".github/workflows/publish-zh-fixed-decompiled.yml",
        "excluded_generated_output": ["rebuild-check/unsigned-rebuilt.apk"],
        "source_truth_order": [
            "apktool/smali for Android byte-level edits",
            "jadx for Android readability only",
            "il2cpp-dump plus libil2cpp.so for gameplay/network logic",
        ],
    }
    (destination / "PROVENANCE.json").write_text(
        json.dumps(provenance, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )

    with (destination / "FILE_INDEX.tsv").open("w", encoding="utf-8", newline="\n") as fh:
        fh.write("sha256\tbytes\tpath\n")
        for row in inventory:
            fh.write(f"{row['sha256']}\t{row['bytes']}\t{row['path']}\n")

    readme = f"""# MLTD zh-fixed v1 — complete decompiled client tree

This orphan branch is generated from `mltd-relive-game-client-zh-fixed.apk` in `{args.release_tag}`.
It is force-regenerated so the repository does not accumulate hundreds of MiB of historical binary objects for every refresh.

## Baseline

- APK SHA-256: `{apk_hash}`
- Maintenance source commit: `{args.source_commit}`
- Generated files before branch metadata: `{len(inventory)}`
- Generated tree size before branch metadata: `{total_bytes / 1024 / 1024:.1f} MiB`

## Directory map

- `apktool/` — authoritative Android/Dalvik maintenance view: decoded manifest/resources, smali, assets and native payloads.
- `jadx/` — Java-like readability view; useful for shell analysis but not a guaranteed recompilable Gradle project.
- `il2cpp-dump/` — `dump.cs`, `script.json`, `il2cpp.h`, `DummyDll/`, string literals and metadata-derived symbol maps.
- `raw-critical/` — exact binary AndroidManifest/resources copied from the APK for round-trip comparison.
- `report/` — tool versions, hashes, ELF/APK structure, network hits, RPC contract, server coverage and extraction logs.
- `PROVENANCE.json` — machine-readable origin, size and largest-file inventory.
- `FILE_INDEX.tsv` — SHA-256 and size index for every decompiler/generated source file in this branch.

`rebuild-check/unsigned-rebuilt.apk` is deliberately omitted because it is a derived build product, not decompiled source. The report still records whether the Apktool rebuild validation succeeded.

## Source-of-truth hierarchy

1. Android/Dalvik byte-level edits: use `apktool/` and smali.
2. Android shell readability: use `jadx/`.
3. Gameplay/network logic: use `il2cpp-dump/dump.cs` with RVA/offset data plus `apktool/lib/arm64-v8a/libil2cpp.so`.
4. `dump.cs` restores declarations, signatures and addresses; it does not recreate the original C# method bodies.

The complete maintenance guide is `docs/CLIENT_DECOMPILATION_COMPLETE.md` on the `client-source-extraction` branch.
"""
    (destination / "README.md").write_text(readme, encoding="utf-8")

    print(f"Prepared {len(inventory)} source files, {total_bytes / 1024 / 1024:.1f} MiB")
    if warnings:
        print("Files >= 50 MiB (accepted by GitHub regular Git but warned):")
        for size, path in sorted(warnings, reverse=True):
            print(f"  {size / 1024 / 1024:.1f} MiB  {path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

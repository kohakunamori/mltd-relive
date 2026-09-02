#!/usr/bin/env python3
"""Recover semantic changes between the official zh-TW 2.1.000 split bundle and zh-fixed.

This deliberately avoids treating raw binary differences as source changes. It compares:
- decoded AndroidManifest/resources;
- normalized smali (debug/line metadata removed);
- critical APK payload hashes;
- IL2CPP ELF sections and selected fixed-baseline patch signatures;
- global-metadata.dat structure/entropy/XOR characteristics.

The output is a compact, reviewable reconstruction tree that can be committed to git.
"""
from __future__ import annotations

import argparse
import difflib
import hashlib
import json
import math
import os
import re
import shutil
import statistics
import zipfile
from collections import Counter
from pathlib import Path

try:
    import yaml
except Exception:  # pragma: no cover
    yaml = None

try:
    from elftools.elf.elffile import ELFFile
except Exception:  # pragma: no cover
    ELFFile = None


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def file_sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def entropy(data: bytes) -> float:
    if not data:
        return 0.0
    counts = Counter(data)
    n = len(data)
    return -sum((c / n) * math.log2(c / n) for c in counts.values())


def printable_ratio(data: bytes) -> float:
    if not data:
        return 0.0
    printable = sum(1 for b in data if b in (9, 10, 13) or 32 <= b < 127)
    return printable / len(data)


def hexdump_prefix(data: bytes, n: int = 64) -> str:
    return data[:n].hex()


def normalize_smali(text: str) -> str:
    out: list[str] = []
    skip_local_block = False
    for raw in text.splitlines():
        line = raw.rstrip()
        stripped = line.lstrip()
        # Debug/source metadata changes when a dex is rebuilt and is not runtime semantics.
        if stripped.startswith((".line ", ".source ", ".prologue", ".epilogue")):
            continue
        if stripped.startswith((".local ", ".end local", ".restart local")):
            continue
        out.append(line)
    # Normalize purely cosmetic blank-run differences.
    compact: list[str] = []
    blank = False
    for line in out:
        if line.strip():
            compact.append(line)
            blank = False
        elif not blank:
            compact.append("")
            blank = True
    return "\n".join(compact).strip() + "\n"


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")


def write_json(path: Path, obj) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def unified(a: str, b: str, fromfile: str, tofile: str) -> str:
    return "".join(
        difflib.unified_diff(
            a.splitlines(True), b.splitlines(True), fromfile=fromfile, tofile=tofile, n=4
        )
    )


def compare_smali(original: Path, fixed: Path, out: Path) -> dict:
    def collect(root: Path) -> dict[str, Path]:
        result = {}
        for p in root.rglob("*.smali"):
            result[str(p.relative_to(root)).replace(os.sep, "/")] = p
        return result

    a = collect(original)
    b = collect(fixed)
    only_a = sorted(set(a) - set(b))
    only_b = sorted(set(b) - set(a))
    changed = []
    identical = 0
    patch_dir = out / "android" / "smali-patches"
    fixed_dir = out / "android" / "fixed-smali"
    patch_dir.mkdir(parents=True, exist_ok=True)
    fixed_dir.mkdir(parents=True, exist_ok=True)

    for rel in sorted(set(a) & set(b)):
        at = normalize_smali(read_text(a[rel]))
        bt = normalize_smali(read_text(b[rel]))
        if at == bt:
            identical += 1
            continue
        d = unified(at, bt, f"original/{rel}", f"zh-fixed/{rel}")
        # Large generated classes can make a patch unwieldy; still record hashes and save
        # the fixed semantic source for reproducibility.
        changed.append(
            {
                "path": rel,
                "original_normalized_sha256": sha256(at.encode()),
                "fixed_normalized_sha256": sha256(bt.encode()),
                "patch_lines": d.count("\n"),
            }
        )
        safe = rel.replace("/", "__")
        (patch_dir / f"{safe}.patch").write_text(d, encoding="utf-8")
        dst = fixed_dir / rel
        dst.parent.mkdir(parents=True, exist_ok=True)
        dst.write_text(bt, encoding="utf-8")

    summary = {
        "original_smali_files": len(a),
        "fixed_smali_files": len(b),
        "semantic_identical_files": identical,
        "semantic_changed_files": len(changed),
        "original_only": only_a,
        "fixed_only": only_b,
        "changed": changed,
    }
    write_json(out / "android" / "smali-summary.json", summary)
    (out / "android" / "original-only-smali.txt").write_text("\n".join(only_a) + ("\n" if only_a else ""), encoding="utf-8")
    (out / "android" / "fixed-only-smali.txt").write_text("\n".join(only_b) + ("\n" if only_b else ""), encoding="utf-8")
    return summary


def compare_text_file(a: Path, b: Path, out: Path, name: str) -> dict:
    if not a.exists() or not b.exists():
        return {"name": name, "present_original": a.exists(), "present_fixed": b.exists()}
    at = read_text(a)
    bt = read_text(b)
    d = unified(at, bt, f"original/{name}", f"zh-fixed/{name}")
    (out / "android" / f"{name.replace('/', '__')}.patch").write_text(d, encoding="utf-8")
    return {
        "name": name,
        "identical": at == bt,
        "original_sha256": sha256(at.encode()),
        "fixed_sha256": sha256(bt.encode()),
        "patch_lines": d.count("\n"),
    }


def compare_resource_tree(a: Path, b: Path, out: Path) -> dict:
    text_ext = {".xml", ".txt", ".json", ".properties", ".yml", ".yaml"}
    def collect(root: Path):
        result = {}
        if not root.exists():
            return result
        for p in root.rglob("*"):
            if p.is_file():
                result[str(p.relative_to(root)).replace(os.sep, "/")] = p
        return result
    aa, bb = collect(a), collect(b)
    only_a = sorted(set(aa) - set(bb))
    only_b = sorted(set(bb) - set(aa))
    changed = []
    for rel in sorted(set(aa) & set(bb)):
        pa, pb = aa[rel], bb[rel]
        ba, bbv = pa.read_bytes(), pb.read_bytes()
        if ba == bbv:
            continue
        row = {"path": rel, "original_size": len(ba), "fixed_size": len(bbv), "original_sha256": sha256(ba), "fixed_sha256": sha256(bbv)}
        if pa.suffix.lower() in text_ext and pb.suffix.lower() in text_ext:
            d = unified(read_text(pa), read_text(pb), f"original/res/{rel}", f"zh-fixed/res/{rel}")
            row["text_patch_lines"] = d.count("\n")
            p = out / "android" / "resource-patches" / (rel.replace("/", "__") + ".patch")
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text(d, encoding="utf-8")
        changed.append(row)
    summary = {"original_files": len(aa), "fixed_files": len(bb), "original_only": only_a, "fixed_only": only_b, "changed": changed}
    write_json(out / "android" / "resources-summary.json", summary)
    return summary


def zip_read(apk: Path, name: str) -> bytes | None:
    with zipfile.ZipFile(apk) as z:
        try:
            return z.read(name)
        except KeyError:
            return None


def analyze_metadata(original: bytes, fixed: bytes, out: Path) -> dict:
    n = min(len(original), len(fixed))
    x = bytes(a ^ b for a, b in zip(original[:n], fixed[:n]))
    equal = sum(a == b for a, b in zip(original[:n], fixed[:n]))
    common_magic = bytes.fromhex("af1bb1fa")

    # Look for the smallest exact repeating XOR period, if one exists over a useful prefix.
    repeat_period = None
    sample = x[: min(len(x), 1 << 20)]
    for period in range(1, 513):
        if len(sample) < period * 4:
            break
        key = sample[:period]
        if all(sample[i] == key[i % period] for i in range(len(sample))):
            repeat_period = period
            break

    # Constant XOR and bytewise affine-like transforms are common quick obfuscators.
    xor_counts = Counter(x)
    most_common_xor = xor_counts.most_common(16)
    result = {
        "original_size": len(original),
        "fixed_size": len(fixed),
        "same_size": len(original) == len(fixed),
        "original_sha256": sha256(original),
        "fixed_sha256": sha256(fixed),
        "original_prefix_hex": hexdump_prefix(original),
        "fixed_prefix_hex": hexdump_prefix(fixed),
        "original_has_il2cpp_magic": original.startswith(common_magic),
        "fixed_has_il2cpp_magic": fixed.startswith(common_magic),
        "original_entropy": entropy(original),
        "fixed_entropy": entropy(fixed),
        "original_printable_ratio": printable_ratio(original),
        "fixed_printable_ratio": printable_ratio(fixed),
        "common_length": n,
        "equal_bytes": equal,
        "equal_ratio": (equal / n if n else 0),
        "xor_entropy": entropy(x),
        "xor_unique_values": len(xor_counts),
        "xor_most_common": [{"value": v, "count": c, "ratio": c / n if n else 0} for v, c in most_common_xor],
        "exact_repeating_xor_period_le_512": repeat_period,
    }
    if repeat_period:
        result["xor_key_hex"] = x[:repeat_period].hex()
    write_json(out / "metadata" / "analysis.json", result)
    return result


def extract_elf_from_apk(apk: Path, member: str, dest: Path) -> Path:
    dest.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(apk) as z:
        dest.write_bytes(z.read(member))
    return dest


def elf_sections(path: Path) -> list[dict]:
    if ELFFile is None:
        return []
    rows = []
    with path.open("rb") as f:
        elf = ELFFile(f)
        for sec in elf.iter_sections():
            try:
                data = sec.data()
            except Exception:
                data = b""
            rows.append({
                "name": sec.name,
                "type": str(sec["sh_type"]),
                "flags": int(sec["sh_flags"]),
                "address": int(sec["sh_addr"]),
                "offset": int(sec["sh_offset"]),
                "size": int(sec["sh_size"]),
                "sha256": sha256(data) if data else None,
                "entropy": entropy(data) if data else 0.0,
            })
    return rows


def compare_elf(original_path: Path, fixed_path: Path, out: Path, patch_points: Path | None) -> dict:
    osec, fsec = elf_sections(original_path), elf_sections(fixed_path)
    om = {x["name"]: x for x in osec}
    fm = {x["name"]: x for x in fsec}
    sections = []
    for name in sorted(set(om) | set(fm)):
        a, b = om.get(name), fm.get(name)
        sections.append({
            "name": name,
            "original": a,
            "fixed": b,
            "identical_size": bool(a and b and a["size"] == b["size"]),
            "identical_hash": bool(a and b and a["sha256"] == b["sha256"]),
        })

    mapping = []
    if patch_points and patch_points.exists() and yaml is not None:
        cfg = yaml.safe_load(patch_points.read_text(encoding="utf-8")) or {}
        ob = original_path.read_bytes()
        fb = fixed_path.read_bytes()
        for point in cfg.get("patch_points", []):
            off = point.get("file_offset")
            if isinstance(off, str):
                off = int(off, 0)
            if not isinstance(off, int) or off < 24 or off + 28 > len(fb):
                continue
            # Search a neighborhood that excludes the 4-byte instruction itself.
            before = fb[off - 24:off]
            after = fb[off + 4:off + 28]
            candidates = []
            start = 0
            while True:
                idx = ob.find(before, start)
                if idx < 0:
                    break
                candidate_off = idx + len(before)
                if ob[candidate_off + 4:candidate_off + 28] == after:
                    candidates.append(candidate_off)
                start = idx + 1
                if len(candidates) > 32:
                    break
            mapping.append({
                "id": point.get("id"),
                "fixed_offset": off,
                "fixed_bytes": fb[off:off+4].hex(),
                "original_context_matches": candidates,
                "original_bytes_at_matches": [ob[x:x+4].hex() for x in candidates],
            })

    result = {
        "original_file": {"size": original_path.stat().st_size, "sha256": file_sha256(original_path)},
        "fixed_file": {"size": fixed_path.stat().st_size, "sha256": file_sha256(fixed_path)},
        "sections": sections,
        "fixed_patch_point_context_mapping": mapping,
    }
    write_json(out / "il2cpp" / "elf-analysis.json", result)
    return result


def critical_payloads(base_apk: Path, arm64_apk: Path, fixed_apk: Path, out: Path) -> list[dict]:
    mapping = [
        ("AndroidManifest.xml", base_apk, "AndroidManifest.xml"),
        ("resources.arsc", base_apk, "resources.arsc"),
        ("classes.dex", base_apk, "classes.dex"),
        ("global-metadata.dat", base_apk, "assets/bin/Data/Managed/Metadata/global-metadata.dat"),
        ("data.unity3d", base_apk, "assets/bin/Data/data.unity3d"),
        ("libunity.so", arm64_apk, "lib/arm64-v8a/libunity.so"),
        ("libil2cpp.so", arm64_apk, "lib/arm64-v8a/libil2cpp.so"),
    ]
    rows = []
    for logical, source_apk, member in mapping:
        a = zip_read(source_apk, member)
        b = zip_read(fixed_apk, member)
        rows.append({
            "path": logical,
            "original_source": source_apk.name,
            "original_size": len(a) if a is not None else None,
            "fixed_size": len(b) if b is not None else None,
            "original_sha256": sha256(a) if a is not None else None,
            "fixed_sha256": sha256(b) if b is not None else None,
            "identical": a == b if a is not None and b is not None else False,
        })
    write_json(out / "critical-payloads.json", rows)
    return rows


def write_readme(out: Path, summary: dict) -> None:
    sm = summary["smali"]
    meta = summary["metadata"]
    elf = summary["elf"]
    changed_sections = [x for x in elf.get("sections", []) if x.get("original") and x.get("fixed") and not x.get("identical_hash")]
    text = f"""# zh-fixed reconstruction workspace

This directory is generated from the verified official Traditional Chinese 2.1.000 split bundle and the repository's current `zh-fixed` release. It records semantic changes instead of raw rebuild noise.

## Current findings

- Normalized smali: **{sm['semantic_changed_files']} changed**, **{sm['semantic_identical_files']} identical**, {len(sm['original_only'])} original-only, {len(sm['fixed_only'])} fixed-only.
- `global-metadata.dat`: original IL2CPP magic = **{meta['original_has_il2cpp_magic']}**, fixed IL2CPP magic = **{meta['fixed_has_il2cpp_magic']}**; equal-byte ratio = **{meta['equal_ratio']:.4%}**; repeating XOR period <=512 = **{meta['exact_repeating_xor_period_le_512']}**.
- `libil2cpp.so`: original {elf['original_file']['size']} bytes -> fixed {elf['fixed_file']['size']} bytes; changed same-name ELF sections: **{len(changed_sections)}**.

## Layout

- `PROVENANCE.json` — exact original/fixed inputs and hashes.
- `critical-payloads.json` — critical file-level comparison.
- `android/` — decoded Manifest/resource diffs and normalized smali patches.
- `metadata/analysis.json` — metadata header/entropy/XOR analysis.
- `il2cpp/elf-analysis.json` — ELF section-level comparison and attempts to relocate known fixed-baseline patch-point contexts into the official library.

`android/fixed-smali/` contains only the normalized fixed-side source for classes that are semantically different, so this branch preserves the actual reconstructed Android changes without committing the entire generated APKTool tree.
"""
    (out / "README.md").write_text(text, encoding="utf-8")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--original-base", required=True, type=Path)
    ap.add_argument("--original-arm64", required=True, type=Path)
    ap.add_argument("--fixed", required=True, type=Path)
    ap.add_argument("--original-apktool", required=True, type=Path)
    ap.add_argument("--fixed-apktool", required=True, type=Path)
    ap.add_argument("--patch-points", type=Path)
    ap.add_argument("--out", required=True, type=Path)
    args = ap.parse_args()

    out = args.out
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)

    prov = {
        "official_bundle": {
            "package": "com.bandainamcoent.imas_millionlive_theaterdays_ch",
            "version_code": 21000,
            "version_name": "2.1.000",
            "base_apk": {"file": args.original_base.name, "size": args.original_base.stat().st_size, "sha256": file_sha256(args.original_base)},
            "arm64_split": {"file": args.original_arm64.name, "size": args.original_arm64.stat().st_size, "sha256": file_sha256(args.original_arm64)},
        },
        "zh_fixed": {"file": args.fixed.name, "size": args.fixed.stat().st_size, "sha256": file_sha256(args.fixed)},
    }
    write_json(out / "PROVENANCE.json", prov)

    crit = critical_payloads(args.original_base, args.original_arm64, args.fixed, out)
    smali = compare_smali(args.original_apktool, args.fixed_apktool, out)
    manifest = compare_text_file(args.original_apktool / "AndroidManifest.xml", args.fixed_apktool / "AndroidManifest.xml", out, "AndroidManifest.xml")
    resources = compare_resource_tree(args.original_apktool / "res", args.fixed_apktool / "res", out)

    original_meta = zip_read(args.original_base, "assets/bin/Data/Managed/Metadata/global-metadata.dat")
    fixed_meta = zip_read(args.fixed, "assets/bin/Data/Managed/Metadata/global-metadata.dat")
    if original_meta is None or fixed_meta is None:
        raise SystemExit("global-metadata.dat missing")
    metadata = analyze_metadata(original_meta, fixed_meta, out)

    original_elf = extract_elf_from_apk(args.original_arm64, "lib/arm64-v8a/libil2cpp.so", out / ".work" / "original-libil2cpp.so")
    fixed_elf = extract_elf_from_apk(args.fixed, "lib/arm64-v8a/libil2cpp.so", out / ".work" / "fixed-libil2cpp.so")
    elf = compare_elf(original_elf, fixed_elf, out, args.patch_points)
    shutil.rmtree(out / ".work", ignore_errors=True)

    summary = {"smali": smali, "manifest": manifest, "resources": resources, "metadata": metadata, "elf": elf, "critical": crit}
    write_json(out / "SUMMARY.json", summary)
    write_readme(out, summary)
    print(json.dumps({
        "smali_changed": smali["semantic_changed_files"],
        "smali_original_only": len(smali["original_only"]),
        "smali_fixed_only": len(smali["fixed_only"]),
        "resource_changed": len(resources["changed"]),
        "metadata_original_magic": metadata["original_has_il2cpp_magic"],
        "metadata_fixed_magic": metadata["fixed_has_il2cpp_magic"],
        "metadata_repeat_xor_period": metadata["exact_repeating_xor_period_le_512"],
    }, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

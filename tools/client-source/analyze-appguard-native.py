#!/usr/bin/env python3
"""Static analyzer for the INCA/nProtect AppGuard footprint in MLTD 2.1.000.

The goal is not generic deobfuscation. It produces a stable, machine-readable map
of the exact official sample: ELF dependencies/imports/exports, PLT callsites for
security-relevant libc/loader APIs, notable strings, and Java<->JNI signatures
from the apktool smali tree.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
from collections import defaultdict
from pathlib import Path
from typing import Iterable

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM
from elftools.elf.elffile import ELFFile

INTERESTING_IMPORT_RE = re.compile(
    r"(?:ptrace|prctl|mmap|mprotect|munmap|open|openat|read|pread|lseek|close|"
    r"dlopen|dlsym|dladdr|android_dlopen_ext|pthread_create|fork|clone|kill|"
    r"tgkill|signal|sigaction|syscall|memcpy|memmove|memcmp|malloc|calloc|free|"
    r"AES_|EVP_|SHA|MD5|CRC|inflate|deflate)",
    re.I,
)

STRING_RULES = {
    "procfs": re.compile(r"/(?:proc|sys)/[^\x00\r\n ]+", re.I),
    "appguard": re.compile(r"(?:appguard|com/inca/security|com\.inca\.security)", re.I),
    "loader": re.compile(r"(?:lib(?:compatible|stub|engine|il2cpp)[^\s\x00]*|dlopen|dlsym|mmap|mprotect)", re.I),
    "anti_debug": re.compile(r"(?:ptrace|tracerpid|debugger|frida|xposed|magisk|substrate|zygisk)", re.I),
    "crypto": re.compile(r"(?:aes|rijndael|sha(?:1|2|256|512)?|md5|crc(?:32)?|decrypt|encrypt|cipher)", re.I),
    "metadata": re.compile(r"(?:global-metadata|metadata\.dat|il2cpp)", re.I),
}

SMALI_METHOD_RE = re.compile(r"^\.method\s+(?P<flags>.*?)\s*(?P<name>[^\s(]+)(?P<sig>\([^\n]+)$")
SMALI_NATIVE_RE = re.compile(r"\bnative\b")
SMALI_LOADLIB_RE = re.compile(r"System;->loadLibrary|System;->load")
SMALI_CONST_RE = re.compile(r'^\s*const-string(?:/jumbo)?\s+[^,]+,\s+"(.*)"\s*$')


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def strings_from_bytes(data: bytes, min_len: int = 5) -> list[tuple[int, str]]:
    out: list[tuple[int, str]] = []
    start = None
    buf = bytearray()
    for i, b in enumerate(data):
        if 0x20 <= b <= 0x7E or b in (0x09,):
            if start is None:
                start = i
            buf.append(b)
        else:
            if start is not None and len(buf) >= min_len:
                out.append((start, buf.decode("ascii", errors="replace")))
            start = None
            buf.clear()
    if start is not None and len(buf) >= min_len:
        out.append((start, buf.decode("ascii", errors="replace")))
    return out


def classify_strings(strings: list[tuple[int, str]]) -> dict[str, list[dict]]:
    result: dict[str, list[dict]] = {k: [] for k in STRING_RULES}
    seen: dict[str, set[str]] = {k: set() for k in STRING_RULES}
    for off, s in strings:
        # Avoid giant compiler/debug strings overwhelming reports.
        if len(s) > 300:
            continue
        for kind, rx in STRING_RULES.items():
            if rx.search(s) and s not in seen[kind]:
                seen[kind].add(s)
                result[kind].append({"file_offset": off, "text": s})
    return result


def dyn_symbols(elf: ELFFile) -> tuple[list[str], list[str]]:
    imports: list[str] = []
    exports: list[str] = []
    sec = elf.get_section_by_name(".dynsym")
    if sec is None:
        return imports, exports
    for sym in sec.iter_symbols():
        name = sym.name
        if not name:
            continue
        if sym["st_shndx"] == "SHN_UNDEF":
            imports.append(name)
        else:
            bind = sym["st_info"]["bind"]
            if bind in ("STB_GLOBAL", "STB_WEAK"):
                exports.append(name)
    return sorted(set(imports)), sorted(set(exports))


def needed_libraries(elf: ELFFile) -> list[str]:
    dyn = elf.get_section_by_name(".dynamic")
    out: list[str] = []
    if dyn is None:
        return out
    for tag in dyn.iter_tags():
        if tag.entry.d_tag == "DT_NEEDED":
            out.append(tag.needed)
    return out


def build_plt_map(elf: ELFFile) -> dict[int, str]:
    """Best-effort AArch64 PLT entry -> imported symbol map.

    Android/NDK AArch64 PLTs normally use a 32-byte PLT0 followed by 16-byte
    entries in .rela.plt order. The map is validated only as a navigation aid;
    raw relocation data remains in the JSON summary.
    """
    plt = elf.get_section_by_name(".plt")
    rela = elf.get_section_by_name(".rela.plt")
    dynsym = elf.get_section_by_name(".dynsym")
    if not plt or not rela or not dynsym:
        return {}
    base = int(plt["sh_addr"])
    size = int(plt["sh_size"])
    relocs = list(rela.iter_relocations())
    if size < 32 + 16 * len(relocs):
        return {}
    result: dict[int, str] = {}
    for i, rel in enumerate(relocs):
        sym_idx = rel.entry.r_info_sym
        if sym_idx == 0:
            continue
        sym = dynsym.get_symbol(sym_idx)
        if sym and sym.name:
            result[base + 32 + i * 16] = sym.name
    return result


def plt_calls(elf: ELFFile, plt_map: dict[int, str]) -> list[dict]:
    if not plt_map:
        return []
    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    md.detail = True
    calls: list[dict] = []
    for sec in elf.iter_sections():
        flags = int(sec["sh_flags"])
        # SHF_EXECINSTR = 0x4
        if not (flags & 0x4) or int(sec["sh_size"]) == 0:
            continue
        data = sec.data()
        start = int(sec["sh_addr"])
        for ins in md.disasm(data, start):
            if ins.mnemonic != "bl" or not ins.operands or ins.operands[0].type != ARM64_OP_IMM:
                continue
            target = int(ins.operands[0].imm)
            name = plt_map.get(target)
            if name and INTERESTING_IMPORT_RE.search(name):
                calls.append({
                    "section": sec.name,
                    "address": int(ins.address),
                    "file_offset": int(sec["sh_offset"]) + int(ins.address) - start,
                    "target": target,
                    "symbol": name,
                })
    return calls


def relocation_summary(elf: ELFFile) -> list[dict]:
    out = []
    for secname in (".rela.plt", ".rela.dyn"):
        sec = elf.get_section_by_name(secname)
        if sec is None:
            continue
        out.append({
            "section": secname,
            "offset": int(sec["sh_offset"]),
            "address": int(sec["sh_addr"]),
            "size": int(sec["sh_size"]),
            "count": sec.num_relocations(),
        })
    return out


def analyze_elf(path: Path) -> dict:
    raw = path.read_bytes()
    with path.open("rb") as f:
        elf = ELFFile(f)
        imports, exports = dyn_symbols(elf)
        plt_map = build_plt_map(elf)
        sections = [
            {
                "name": sec.name,
                "type": str(sec["sh_type"]),
                "offset": int(sec["sh_offset"]),
                "address": int(sec["sh_addr"]),
                "size": int(sec["sh_size"]),
                "flags": int(sec["sh_flags"]),
            }
            for sec in elf.iter_sections()
        ]
        segments = [
            {
                "type": str(seg["p_type"]),
                "offset": int(seg["p_offset"]),
                "vaddr": int(seg["p_vaddr"]),
                "filesz": int(seg["p_filesz"]),
                "memsz": int(seg["p_memsz"]),
                "flags": int(seg["p_flags"]),
            }
            for seg in elf.iter_segments()
        ]
        calls = plt_calls(elf, plt_map)
        relocs = relocation_summary(elf)
        needed = needed_libraries(elf)

    all_strings = strings_from_bytes(raw)
    classified = classify_strings(all_strings)
    import_hits = sorted(x for x in imports if INTERESTING_IMPORT_RE.search(x))
    calls_by_symbol: dict[str, list[dict]] = defaultdict(list)
    for row in calls:
        calls_by_symbol[row["symbol"]].append(row)

    return {
        "path": path.name,
        "sha256": sha256(path),
        "size": path.stat().st_size,
        "elf_class": elf.elfclass,
        "machine": str(elf["e_machine"]),
        "entry": int(elf["e_entry"]),
        "needed": needed,
        "imports": imports,
        "exports": exports,
        "interesting_imports": import_hits,
        "sections": sections,
        "segments": segments,
        "relocations": relocs,
        "plt_call_map_assumption": "AArch64 .plt: 32-byte PLT0 + 16-byte entries in .rela.plt order",
        "interesting_plt_calls": calls,
        "interesting_plt_calls_by_symbol": dict(sorted(calls_by_symbol.items())),
        "interesting_strings": classified,
    }


def parse_smali_tree(root: Path) -> dict:
    classes = []
    native_methods = []
    load_library_sites = []
    interesting_literals = []
    appguard_root = root / "smali" / "com" / "inca" / "security"
    candidates: Iterable[Path]
    if appguard_root.exists():
        candidates = sorted(appguard_root.rglob("*.smali"))
    else:
        candidates = []
    for path in candidates:
        rel = str(path.relative_to(root)).replace("\\", "/")
        text = path.read_text(encoding="utf-8", errors="replace")
        cls_match = re.search(r"^\.class\s+.*?\s+(L[^;]+;)", text, re.M)
        cls = cls_match.group(1) if cls_match else rel
        classes.append(cls)
        current_method = None
        for lineno, line in enumerate(text.splitlines(), 1):
            mm = SMALI_METHOD_RE.match(line)
            if mm:
                current_method = mm.group("name") + mm.group("sig")
                if SMALI_NATIVE_RE.search(mm.group("flags")):
                    native_methods.append({
                        "class": cls,
                        "method": current_method,
                        "flags": mm.group("flags").strip(),
                        "file": rel,
                        "line": lineno,
                    })
            if SMALI_LOADLIB_RE.search(line):
                load_library_sites.append({"class": cls, "method": current_method, "file": rel, "line": lineno})
            cm = SMALI_CONST_RE.match(line)
            if cm:
                lit = cm.group(1)
                if any(rx.search(lit) for rx in STRING_RULES.values()):
                    interesting_literals.append({
                        "class": cls,
                        "method": current_method,
                        "file": rel,
                        "line": lineno,
                        "literal": lit,
                    })
    return {
        "appguard_class_count": len(classes),
        "classes": classes,
        "native_methods": native_methods,
        "load_library_sites": load_library_sites,
        "interesting_literals": interesting_literals,
    }


def write_markdown(out: Path, libs: list[dict], smali: dict) -> None:
    lines = [
        "# AppGuard native/JNI static map",
        "",
        "Generated from the exact verified official Traditional Chinese MLTD 2.1.000 bundle.",
        "Offsets in this report are sample-specific; no offset is borrowed from another AppGuard version.",
        "",
        "## Native libraries",
        "",
        "| Library | Size | SHA-256 | DT_NEEDED | Interesting imports |",
        "|---|---:|---|---|---|",
    ]
    for lib in libs:
        lines.append(
            f"| `{lib['path']}` | {lib['size']} | `{lib['sha256']}` | "
            f"{', '.join('`'+x+'`' for x in lib['needed']) or '-'} | "
            f"{', '.join('`'+x+'`' for x in lib['interesting_imports']) or '-'} |"
        )
    lines += ["", "## Security-relevant PLT callsites", ""]
    for lib in libs:
        lines.append(f"### `{lib['path']}`")
        by = lib["interesting_plt_calls_by_symbol"]
        if not by:
            lines += ["", "No direct PLT callsites resolved by the static mapper.", ""]
            continue
        lines += ["", "| Import | Callsites (VA / file offset) |", "|---|---|"]
        for name, rows in by.items():
            locs = ", ".join(f"`0x{r['address']:x} / 0x{r['file_offset']:x}`" for r in rows[:24])
            if len(rows) > 24:
                locs += f" … (+{len(rows)-24})"
            lines.append(f"| `{name}` | {locs} |")
        lines.append("")

    lines += [
        "## Java/JNI bridge",
        "",
        f"AppGuard smali classes discovered: **{smali['appguard_class_count']}**",
        "",
        "### Native methods",
        "",
        "| Class | Native method |",
        "|---|---|",
    ]
    for row in smali["native_methods"]:
        lines.append(f"| `{row['class']}` | `{row['method']}` |")
    if not smali["native_methods"]:
        lines.append("| - | No `native` declarations found in decoded AppGuard smali |")

    lines += ["", "## Navigation priorities", ""]
    priority = ["ptrace", "mmap", "mprotect", "openat", "read", "pread", "lseek", "dlopen", "dlsym", "android_dlopen_ext"]
    for lib in libs:
        symbols = lib["interesting_plt_calls_by_symbol"]
        hits = [p for p in priority if p in symbols]
        if hits:
            lines.append(f"- `{lib['path']}`: " + ", ".join(f"`{h}`" for h in hits))
    lines += [
        "",
        "The next reverse-engineering pass should start from loader/file-mapping callsites, then walk backward to the buffer transform and forward to the executable mapping/JNI registration boundary.",
    ]
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--native-dir", required=True, type=Path)
    ap.add_argument("--apktool-tree", required=True, type=Path)
    ap.add_argument("--out", required=True, type=Path)
    args = ap.parse_args()

    names = ["libcompatible.so", "libcompatible_x86.so", "libengine-hlp.so", "libengine.so", "libstub.so"]
    libs = []
    for name in names:
        path = args.native_dir / name
        if path.exists():
            libs.append(analyze_elf(path))
    if not libs:
        raise SystemExit(f"no AppGuard native libraries found under {args.native_dir}")
    smali = parse_smali_tree(args.apktool_tree)
    args.out.mkdir(parents=True, exist_ok=True)
    (args.out / "native-static-map.json").write_text(
        json.dumps({"libraries": libs, "smali": smali}, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    write_markdown(args.out / "native-static-map.md", libs, smali)
    print(json.dumps({
        "libraries": [x["path"] for x in libs],
        "native_methods": len(smali["native_methods"]),
        "resolved_interesting_calls": sum(len(x["interesting_plt_calls"]) for x in libs),
    }, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

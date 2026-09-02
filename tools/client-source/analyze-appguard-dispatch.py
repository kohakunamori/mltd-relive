#!/usr/bin/env python3
"""Resolve AppGuard runtime dispatch-table pointers used by SoLibraryStart.

The protected MLTD 2.1.000 libcompatible.so has damaged/blank section names and
uses indirect calls through global pointer tables.  Section-oriented tools miss
most of the useful relationship.  This pass therefore:

* parses PT_DYNAMIC directly (DT_RELA/DT_JMPREL/DT_SYMTAB/DT_STRTAB),
* reconstructs AArch64 dynamic relocation targets without section names,
* extracts global slots referenced by the recovered SoLibraryStart CFG,
* follows static pointer relocations into data objects,
* inventories relocations/pointers in those objects (including +0xa0), and
* records indirect LDR/BLR chains such as global -> object -> function field.

All addresses are VAs relative to the libcompatible.so load base.
"""
from __future__ import annotations

import argparse
import bisect
import hashlib
import json
import re
import struct
from collections import defaultdict
from pathlib import Path

from elftools.elf.dynamic import DynamicSegment
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection

AARCH64_RELOC = {
    0: "R_AARCH64_NONE",
    257: "R_AARCH64_ABS64",
    258: "R_AARCH64_ABS32",
    259: "R_AARCH64_ABS16",
    1024: "R_AARCH64_COPY",
    1025: "R_AARCH64_GLOB_DAT",
    1026: "R_AARCH64_JUMP_SLOT",
    1027: "R_AARCH64_RELATIVE",
    1032: "R_AARCH64_IRELATIVE",
}

REG = re.compile(r"^[xw](\d+)$")
MEM = re.compile(r"\[(x\d+|sp)(?:,\s*#(-?0x[0-9a-f]+|-?\d+))?\]", re.I)


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def parse_int(text: str) -> int | None:
    text = text.strip().lstrip("#")
    try:
        return int(text, 0)
    except Exception:
        return None


def norm_reg(name: str) -> str:
    name = name.strip()
    m = REG.match(name)
    if not m:
        return name
    return "x" + m.group(1)


class Image:
    def __init__(self, segments: list[dict]):
        self.segments = segments

    def mapped(self, va: int) -> bool:
        return any(s["vaddr"] <= va < s["vaddr"] + s["memsz"] for s in self.segments)

    def file_backed(self, va: int, n: int = 1) -> bool:
        return any(s["vaddr"] <= va and va + n <= s["vaddr"] + s["filesz"] for s in self.segments)

    def read(self, va: int, n: int) -> bytes:
        for s in self.segments:
            if s["vaddr"] <= va and va + n <= s["vaddr"] + s["filesz"]:
                off = va - s["vaddr"]
                return s["data"][off:off+n]
        return b""

    def u64(self, va: int) -> int | None:
        raw = self.read(va, 8)
        return struct.unpack("<Q", raw)[0] if len(raw) == 8 else None

    def file_offset(self, va: int) -> int | None:
        for s in self.segments:
            if s["vaddr"] <= va < s["vaddr"] + s["filesz"]:
                return s["offset"] + va - s["vaddr"]
        return None


def load_elf(path: Path):
    with path.open("rb") as f:
        elf = ELFFile(f)
        segments = []
        dyn: dict[str, int] = {}
        symbols = []
        for seg in elf.iter_segments():
            if str(seg["p_type"]) == "PT_LOAD":
                segments.append({
                    "vaddr": int(seg["p_vaddr"]),
                    "offset": int(seg["p_offset"]),
                    "filesz": int(seg["p_filesz"]),
                    "memsz": int(seg["p_memsz"]),
                    "flags": int(seg["p_flags"]),
                    "data": seg.data(),
                })
            if isinstance(seg, DynamicSegment) or str(seg["p_type"]) == "PT_DYNAMIC":
                try:
                    for tag in seg.iter_tags():
                        key = str(tag.entry.d_tag)
                        value = getattr(tag.entry, "d_val", None)
                        if value is None:
                            value = getattr(tag.entry, "d_ptr", None)
                        if value is not None:
                            dyn[key] = int(value)
                except Exception:
                    pass
        for sec in elf.iter_sections():
            if isinstance(sec, SymbolTableSection):
                for idx, sym in enumerate(sec.iter_symbols()):
                    if not sym.name:
                        continue
                    symbols.append({
                        "index": idx,
                        "name": sym.name,
                        "address": int(sym["st_value"]),
                        "size": int(sym["st_size"]),
                        "undef": sym["st_shndx"] == "SHN_UNDEF",
                    })
    return Image(segments), dyn, symbols


def cstring(image: Image, va: int, limit: int = 512) -> str | None:
    raw = image.read(va, limit)
    if not raw:
        return None
    raw = raw.split(b"\0", 1)[0]
    try:
        return raw.decode("utf-8")
    except Exception:
        return None


def dynsym_name(image: Image, dyn: dict, symidx: int) -> tuple[str | None, int | None]:
    symtab = dyn.get("DT_SYMTAB")
    strtab = dyn.get("DT_STRTAB")
    syment = dyn.get("DT_SYMENT", 24) or 24
    if symtab is None or strtab is None:
        return None, None
    raw = image.read(symtab + symidx * syment, 24)
    if len(raw) < 24:
        return None, None
    st_name = struct.unpack_from("<I", raw, 0)[0]
    st_value = struct.unpack_from("<Q", raw, 8)[0]
    return cstring(image, strtab + st_name), st_value


def parse_rela_table(image: Image, dyn: dict, base_tag: str, size_tag: str, kind: str) -> list[dict]:
    base = dyn.get(base_tag)
    size = dyn.get(size_tag)
    ent = dyn.get("DT_RELAENT", 24) or 24
    if base is None or size is None:
        return []
    out = []
    for off in range(0, size, ent):
        raw = image.read(base + off, 24)
        if len(raw) != 24:
            break
        r_offset, r_info, r_addend = struct.unpack("<QQq", raw)
        symidx = r_info >> 32
        rtype = r_info & 0xffffffff
        name, st_value = dynsym_name(image, dyn, symidx)
        out.append({
            "table": kind,
            "rela_va": base + off,
            "offset": r_offset,
            "type": rtype,
            "type_name": AARCH64_RELOC.get(rtype, f"R_AARCH64_{rtype}"),
            "sym_index": symidx,
            "symbol": name,
            "symbol_value": st_value,
            "addend": r_addend,
        })
    return out


def parse_relocations(image: Image, dyn: dict) -> list[dict]:
    rows = parse_rela_table(image, dyn, "DT_RELA", "DT_RELASZ", "RELA")
    rows += parse_rela_table(image, dyn, "DT_JMPREL", "DT_PLTRELSZ", "JMPREL")
    # dedupe exact records because some protectors alias tables.
    dedup = {}
    for row in rows:
        key = (row["rela_va"], row["offset"], row["type"], row["sym_index"], row["addend"])
        dedup[key] = row
    return sorted(dedup.values(), key=lambda r: (r["offset"], r["rela_va"]))


def symbol_helpers(symbols: list[dict]):
    defs = [s for s in symbols if not s["undef"] and s["address"]]
    by = defaultdict(list)
    for s in defs:
        by[s["address"]].append(s)
    addrs = sorted(by)

    def exact(va: int) -> list[str]:
        return sorted(s["name"] for s in by.get(va, []))

    def nearest(va: int) -> dict | None:
        i = bisect.bisect_right(addrs, va) - 1
        if i < 0:
            return None
        start = addrs[i]
        row = max(by[start], key=lambda x: x["size"])
        return {"name": row["name"], "start": start, "offset": va - start, "size": row["size"]}

    return exact, nearest


def resolve_relocation_pointer(row: dict, image: Image) -> int | None:
    rtype = row["type"]
    if rtype in (1027, 1032):  # RELATIVE / IRELATIVE
        return int(row["addend"])
    if rtype in (257, 1025, 1026):
        sv = row.get("symbol_value")
        if sv is not None:
            return int(sv) + int(row.get("addend") or 0)
    return None


def split_ops(text: str) -> list[str]:
    # commas inside [] make a naive split inconvenient; keep the memory operand intact.
    out, buf, depth = [], [], 0
    for ch in text:
        if ch == "[": depth += 1
        elif ch == "]": depth -= 1
        if ch == "," and depth == 0:
            out.append("".join(buf).strip()); buf = []
        else:
            buf.append(ch)
    if buf:
        out.append("".join(buf).strip())
    return out


def extract_cfg_global_chains(cfg: dict) -> tuple[list[dict], list[dict]]:
    globals_seen = []
    indirect = []
    for block in cfg.get("blocks", []):
        regs: dict[str, int] = {}
        origins: dict[str, dict] = {}
        for ins in block.get("instructions", []):
            m = ins.get("mnemonic", "")
            ops = split_ops(ins.get("op_str", ""))
            addr = int(ins.get("address", 0))

            if m in ("adrp", "adr") and len(ops) >= 2:
                dst = norm_reg(ops[0]); imm = parse_int(ops[1])
                if imm is not None:
                    regs[dst] = imm; origins.pop(dst, None)
                continue

            if m in ("mov", "movz") and len(ops) >= 2:
                dst = norm_reg(ops[0]); src = norm_reg(ops[1])
                imm = parse_int(ops[1])
                if imm is not None:
                    regs[dst] = imm; origins.pop(dst, None)
                elif src in regs:
                    regs[dst] = regs[src]
                    if src in origins: origins[dst] = dict(origins[src])
                    else: origins.pop(dst, None)
                else:
                    regs.pop(dst, None); origins.pop(dst, None)
                continue

            if m == "add" and len(ops) >= 3:
                dst = norm_reg(ops[0]); src = norm_reg(ops[1]); imm = parse_int(ops[2])
                if src in regs and imm is not None:
                    regs[dst] = regs[src] + imm
                    if src in origins: origins[dst] = dict(origins[src])
                else:
                    regs.pop(dst, None); origins.pop(dst, None)
                continue

            if m.startswith("ldr") and len(ops) >= 2:
                dst = norm_reg(ops[0])
                mm = MEM.search(ops[1])
                if mm:
                    base = norm_reg(mm.group(1)); disp = parse_int(mm.group(2) or "0") or 0
                    if base in regs:
                        target = regs[base] + disp
                        ev = {
                            "instruction": addr,
                            "block": block.get("start"),
                            "depth": block.get("depth"),
                            "kind": "load",
                            "address": target,
                            "dst": dst,
                        }
                        globals_seen.append(ev)
                        origins[dst] = {"global_slot": target, "field_offset": 0, "loaded_at": addr}
                        regs.pop(dst, None)
                    elif base in origins:
                        src_origin = origins[base]
                        ev = {
                            "instruction": addr,
                            "block": block.get("start"),
                            "depth": block.get("depth"),
                            "base_reg": base,
                            "dst": dst,
                            "global_slot": src_origin.get("global_slot"),
                            "field_offset": int(src_origin.get("field_offset", 0)) + disp,
                        }
                        indirect.append(ev)
                        origins[dst] = {
                            "global_slot": src_origin.get("global_slot"),
                            "field_offset": int(src_origin.get("field_offset", 0)) + disp,
                            "loaded_at": addr,
                        }
                        regs.pop(dst, None)
                    else:
                        regs.pop(dst, None); origins.pop(dst, None)
                else:
                    regs.pop(dst, None); origins.pop(dst, None)
                continue

            if m.startswith("str") and len(ops) >= 2:
                mm = MEM.search(ops[-1])
                if mm:
                    base = norm_reg(mm.group(1)); disp = parse_int(mm.group(2) or "0") or 0
                    if base in regs:
                        globals_seen.append({
                            "instruction": addr,
                            "block": block.get("start"),
                            "depth": block.get("depth"),
                            "kind": "store",
                            "address": regs[base] + disp,
                            "src": norm_reg(ops[0]),
                        })
                continue

            if m == "blr" and ops:
                reg = norm_reg(ops[0])
                if reg in origins:
                    o = origins[reg]
                    indirect.append({
                        "instruction": addr,
                        "block": block.get("start"),
                        "depth": block.get("depth"),
                        "blr_reg": reg,
                        "global_slot": o.get("global_slot"),
                        "field_offset": o.get("field_offset", 0),
                        "is_call": True,
                    })
                continue

            # Conservative invalidation for common register-writing instructions.
            if ops and REG.match(ops[0]) and m not in (
                "cmp", "cmn", "tst", "b", "bl", "br", "ret", "cbz", "cbnz", "tbz", "tbnz"
            ) and not m.startswith(("b.", "st")):
                dst = norm_reg(ops[0]); regs.pop(dst, None); origins.pop(dst, None)

    # Only true lib globals are useful: filter to the writable/near-GOT range seen in this sample.
    gdedup = {}
    for e in globals_seen:
        if 0x1e0000 <= e["address"] < 0x220000:
            gdedup[(e["instruction"], e["kind"], e["address"])] = e
    idedup = {(e["instruction"], e.get("global_slot"), e.get("field_offset"), e.get("is_call", False)): e for e in indirect}
    return sorted(gdedup.values(), key=lambda e: e["instruction"]), sorted(idedup.values(), key=lambda e: e["instruction"])


def describe_pointer(va: int | None, image: Image, exact, nearest) -> dict | None:
    if va is None:
        return None
    return {
        "address": va,
        "mapped": image.mapped(va),
        "file_backed": image.file_backed(va, 1),
        "exact_symbols": exact(va),
        "nearest_symbol": nearest(va),
        "file_offset": image.file_offset(va),
    }


def inspect_slot(slot: int, rel_by_offset: dict[int, list[dict]], image: Image, exact, nearest) -> dict:
    rels = rel_by_offset.get(slot, [])
    static_u64 = image.u64(slot)
    candidates = []
    for r in rels:
        ptr = resolve_relocation_pointer(r, image)
        candidates.append({"relocation": r, "resolved_pointer": describe_pointer(ptr, image, exact, nearest)})
    if not rels and static_u64:
        candidates.append({"relocation": None, "resolved_pointer": describe_pointer(static_u64, image, exact, nearest)})
    return {
        "slot": slot,
        "file_offset": image.file_offset(slot),
        "raw_u64": static_u64,
        "relocations": rels,
        "candidates": candidates,
    }


def inspect_object(base: int, rel_by_offset: dict[int, list[dict]], image: Image, exact, nearest, span: int = 0x180) -> list[dict]:
    rows = []
    for off in range(0, span, 8):
        va = base + off
        raw = image.u64(va)
        rels = rel_by_offset.get(va, [])
        resolved = []
        for r in rels:
            ptr = resolve_relocation_pointer(r, image)
            resolved.append({"relocation": r, "pointer": describe_pointer(ptr, image, exact, nearest)})
        # Keep relocations plus plausible mapped pointers and the dispatch-hot +0xa0 neighborhood.
        plausible_raw = raw is not None and raw != 0 and image.mapped(raw)
        if rels or plausible_raw or 0x80 <= off <= 0xc0:
            rows.append({
                "offset": off,
                "address": va,
                "raw_u64": raw,
                "relocations": rels,
                "resolved": resolved,
                "raw_pointer": describe_pointer(raw, image, exact, nearest) if plausible_raw else None,
            })
    return rows


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--libcompatible", type=Path, required=True)
    ap.add_argument("--solibrary-cfg", type=Path, required=True)
    ap.add_argument("--out", type=Path, required=True)
    args = ap.parse_args()

    image, dyn, symbols = load_elf(args.libcompatible)
    exact, nearest = symbol_helpers(symbols)
    relocs = parse_relocations(image, dyn)
    rel_by_offset: dict[int, list[dict]] = defaultdict(list)
    for r in relocs:
        rel_by_offset[r["offset"]].append(r)

    cfg = json.loads(args.solibrary_cfg.read_text(encoding="utf-8"))
    global_accesses, indirect = extract_cfg_global_chains(cfg)
    slots = sorted(set(e["address"] for e in global_accesses) | set(e.get("global_slot") for e in indirect if e.get("global_slot") is not None))

    slot_reports = []
    object_reports = []
    seen_objects = set()
    for slot in slots:
        sr = inspect_slot(slot, rel_by_offset, image, exact, nearest)
        slot_reports.append(sr)
        for cand in sr["candidates"]:
            p = cand.get("resolved_pointer") or {}
            base = p.get("address")
            if base is None or base in seen_objects or not image.file_backed(base, 8):
                continue
            seen_objects.add(base)
            object_reports.append({
                "source_slot": slot,
                "base": base,
                "base_description": describe_pointer(base, image, exact, nearest),
                "fields": inspect_object(base, rel_by_offset, image, exact, nearest),
            })

    # Explicitly resolve every observed indirect field against the static object selected by its global slot.
    indirect_resolved = []
    slot_map = {r["slot"]: r for r in slot_reports}
    for ev in indirect:
        row = dict(ev)
        slot = ev.get("global_slot")
        field = int(ev.get("field_offset") or 0)
        objects = []
        sr = slot_map.get(slot)
        if sr:
            for cand in sr["candidates"]:
                p = cand.get("resolved_pointer") or {}
                base = p.get("address")
                if base is None or not image.mapped(base + field):
                    continue
                target_slot = base + field
                fs = inspect_slot(target_slot, rel_by_offset, image, exact, nearest)
                fs["object_base"] = base
                fs["field_offset"] = field
                objects.append(fs)
        row["resolved_fields"] = objects
        indirect_resolved.append(row)

    report = {
        "sample_sha256": sha256(args.libcompatible),
        "dynamic_tags": {k: dyn.get(k) for k in (
            "DT_RELA", "DT_RELASZ", "DT_RELAENT", "DT_JMPREL", "DT_PLTRELSZ",
            "DT_SYMTAB", "DT_STRTAB", "DT_SYMENT", "DT_PLTGOT"
        )},
        "relocation_count": len(relocs),
        "relocation_type_counts": dict(sorted({
            name: sum(1 for r in relocs if r["type_name"] == name)
            for name in set(r["type_name"] for r in relocs)
        }.items())),
        "global_accesses": global_accesses,
        "indirect_chains": indirect_resolved,
        "global_slots": slot_reports,
        "objects": object_reports,
    }

    args.out.mkdir(parents=True, exist_ok=True)
    (args.out / "dispatch-table.json").write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    lines = [
        "# AppGuard runtime dispatch-table resolution",
        "",
        f"- sample: `{report['sample_sha256']}`",
        f"- dynamic relocations recovered: **{len(relocs)}**",
        f"- SoLibraryStart global accesses: **{len(global_accesses)}**",
        f"- indirect load/call chains: **{len(indirect_resolved)}**",
        "",
        "## Relocation types",
        "",
        "| Type | Count |",
        "|---|---:|",
    ]
    for name, count in report["relocation_type_counts"].items():
        lines.append(f"| `{name}` | {count} |")

    lines += ["", "## Global slots used by `SoLibraryStart`", "", "| Slot | File off | Raw | Relocation | Resolved |", "|---:|---:|---:|---|---|"]
    for sr in slot_reports:
        reltxt = ", ".join(f"{r['type_name']}:{r.get('symbol') or '-'} add={r['addend']:#x}" for r in sr["relocations"]) or "-"
        resolved = []
        for c in sr["candidates"]:
            p = c.get("resolved_pointer") or {}
            if p.get("address") is not None:
                label = ",".join(p.get("exact_symbols") or [])
                if not label and p.get("nearest_symbol"):
                    n = p["nearest_symbol"]; label = f"{n['name']}+0x{n['offset']:x}"
                resolved.append(f"0x{p['address']:x} {label}".strip())
        lines.append(f"| `0x{sr['slot']:x}` | `{hex(sr['file_offset']) if sr['file_offset'] is not None else '-'}` | `{hex(sr['raw_u64']) if sr['raw_u64'] is not None else '-'}` | {reltxt} | {'; '.join(resolved) or '-'} |")

    lines += ["", "## Indirect chains", "", "| Insn | Global slot | Field | BLR | Static target(s) |", "|---:|---:|---:|---|---|"]
    for ev in indirect_resolved:
        targets = []
        for fs in ev.get("resolved_fields", []):
            for c in fs.get("candidates", []):
                p = c.get("resolved_pointer") or {}
                if p.get("address") is None:
                    continue
                label = ",".join(p.get("exact_symbols") or [])
                if not label and p.get("nearest_symbol"):
                    n = p["nearest_symbol"]; label = f"{n['name']}+0x{n['offset']:x}"
                targets.append(f"0x{p['address']:x} {label}".strip())
        lines.append(f"| `0x{ev['instruction']:x}` | `{hex(ev['global_slot']) if ev.get('global_slot') is not None else '-'}` | `+0x{int(ev.get('field_offset') or 0):x}` | {'yes' if ev.get('is_call') else 'no'} | {'; '.join(targets) or '-'} |")

    lines += ["", "## Recovered static objects", ""]
    for obj in object_reports:
        lines += [f"### global `0x{obj['source_slot']:x}` -> object `0x{obj['base']:x}`", "", "| Field | VA | Raw | Relocation | Resolved |", "|---:|---:|---:|---|---|"]
        for frow in obj["fields"]:
            reltxt = ", ".join(f"{r['type_name']}:{r.get('symbol') or '-'} add={r['addend']:#x}" for r in frow["relocations"]) or "-"
            res = []
            for rr in frow["resolved"]:
                p = rr.get("pointer") or {}
                if p.get("address") is None: continue
                label = ",".join(p.get("exact_symbols") or [])
                if not label and p.get("nearest_symbol"):
                    n=p["nearest_symbol"];label=f"{n['name']}+0x{n['offset']:x}"
                res.append(f"0x{p['address']:x} {label}".strip())
            if not res and frow.get("raw_pointer"):
                p=frow["raw_pointer"];label=",".join(p.get("exact_symbols") or [])
                if not label and p.get("nearest_symbol"):
                    n=p["nearest_symbol"];label=f"{n['name']}+0x{n['offset']:x}"
                res.append(f"0x{p['address']:x} {label}".strip())
            lines.append(f"| `+0x{frow['offset']:x}` | `0x{frow['address']:x}` | `{hex(frow['raw_u64']) if frow['raw_u64'] is not None else '-'}` | {reltxt} | {'; '.join(res) or '-'} |")
        lines.append("")

    (args.out / "dispatch-table.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(json.dumps({
        "relocations": len(relocs),
        "global_slots": len(slot_reports),
        "objects": len(object_reports),
        "indirect_chains": len(indirect_resolved),
    }, indent=2))


if __name__ == "__main__":
    main()

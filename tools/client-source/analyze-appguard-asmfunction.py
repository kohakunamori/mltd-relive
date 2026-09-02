#!/usr/bin/env python3
"""Trace runtime initialization of nProtect's asmFunction table.

For the exact MLTD 2.1.000 libcompatible.so, `asmFunction` is a 168-byte BSS
object (21 pointers).  SoLibraryStart resolves the GLOB_DAT slot for this object
and calls the last pointer (`asmFunction + 0xa0`) indirectly.  The object is zero
on disk, therefore DT_INIT must populate it at runtime.

This pass consumes the recovered DT_INIT CFG and dispatch relocation report and
finds code paths that load the asmFunction GOT entry, write fields of the table,
or pass the table to copy/memory helpers.  It uses relocation-aware pointer
loads so a GLOB_DAT load can be treated as a known address despite BSS being
zero in the file.
"""
from __future__ import annotations

import argparse
import bisect
import json
import re
from collections import defaultdict, deque
from pathlib import Path

from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection

REG_RE = re.compile(r"^[xw](\d+)$")
MEM_RE = re.compile(r"\[(x\d+|sp)(?:,\s*#(-?0x[0-9a-f]+|-?\d+))?\]", re.I)


def norm_reg(s: str) -> str:
    s = s.strip()
    m = REG_RE.match(s)
    return "x" + m.group(1) if m else s


def parse_int(s: str) -> int | None:
    s = s.strip().lstrip("#")
    try:
        return int(s, 0)
    except Exception:
        return None


def split_ops(text: str) -> list[str]:
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


def load_symbols(path: Path):
    symbols = []
    with path.open("rb") as f:
        elf = ELFFile(f)
        for sec in elf.iter_sections():
            if not isinstance(sec, SymbolTableSection):
                continue
            for sym in sec.iter_symbols():
                if not sym.name or sym["st_shndx"] == "SHN_UNDEF":
                    continue
                symbols.append({
                    "name": sym.name,
                    "address": int(sym["st_value"]),
                    "size": int(sym["st_size"]),
                })
    by = defaultdict(list)
    for s in symbols:
        by[s["address"]].append(s)
    addrs = sorted(by)
    def label(addr: int | None) -> str | None:
        if addr is None:
            return None
        exact = by.get(addr)
        if exact:
            return ",".join(sorted(s["name"] for s in exact))
        i = bisect.bisect_right(addrs, addr) - 1
        if i >= 0:
            st = addrs[i]
            row = max(by[st], key=lambda x: x["size"])
            return f"{row['name']}+0x{addr-st:x}"
        return None
    return symbols, label


def find_asmfunction(symbols: list[dict]) -> dict:
    rows = [s for s in symbols if s["name"] == "asmFunction"]
    if not rows:
        raise SystemExit("asmFunction symbol not found")
    return rows[0]


def get_dispatch_info(dispatch: dict, asm: dict):
    got_slots = []
    for slot in dispatch.get("global_slots", []):
        for r in slot.get("relocations", []):
            if r.get("symbol") == "asmFunction":
                got_slots.append(slot["slot"])
    if not got_slots:
        raise SystemExit("asmFunction GLOB_DAT slot not found in dispatch report")
    # Also keep statically-resolved global pointers from all slots; useful for constant loads.
    resolved_globals = {}
    for slot in dispatch.get("global_slots", []):
        for cand in slot.get("candidates", []):
            p = cand.get("resolved_pointer") or {}
            if p.get("address") is not None:
                resolved_globals[int(slot["slot"])] = int(p["address"])
                break
    for g in got_slots:
        resolved_globals[g] = int(asm["address"])
    return sorted(set(got_slots)), resolved_globals


def context(block: dict, idx: int, radius: int = 10) -> list[dict]:
    ins = block.get("instructions", [])
    lo, hi = max(0, idx-radius), min(len(ins), idx+radius+1)
    return ins[lo:hi]


def analyze_block(block: dict, asm_base: int, asm_size: int, got_slots: set[int], resolved_globals: dict[int, int], import_by_call: dict[int, str], label):
    regs: dict[str, dict] = {}
    writes = []
    refs = []
    calls = []
    insns = block.get("instructions", [])

    def setv(reg: str, value: int | None, origin: str | None = None):
        reg = norm_reg(reg)
        if value is None:
            regs.pop(reg, None)
        else:
            regs[reg] = {"value": int(value), "origin": origin}

    def getv(reg: str):
        return regs.get(norm_reg(reg))

    for idx, ins in enumerate(insns):
        m = ins.get("mnemonic", "")
        ops = split_ops(ins.get("op_str", ""))
        pc = int(ins.get("address", 0))

        if m in ("adr", "adrp") and len(ops) >= 2:
            setv(ops[0], parse_int(ops[1]), m)
            continue

        if m in ("mov", "movz") and len(ops) >= 2:
            imm = parse_int(ops[1])
            if imm is not None:
                setv(ops[0], imm, m)
            else:
                src = getv(ops[1])
                setv(ops[0], src["value"] if src else None, src.get("origin") if src else None)
            continue

        if m == "movk" and len(ops) >= 2:
            dst = norm_reg(ops[0]); cur = regs.get(dst); imm = parse_int(ops[1])
            if cur is None or imm is None:
                setv(dst, None); continue
            shift = 0
            text = ins.get("op_str", "")
            mm = re.search(r"lsl\s+#(\d+)", text)
            if mm: shift = int(mm.group(1))
            value = (cur["value"] & ~(0xffff << shift)) | ((imm & 0xffff) << shift)
            setv(dst, value, cur.get("origin"))
            continue

        if m in ("add", "sub") and len(ops) >= 3:
            src = getv(ops[1]); imm = parse_int(ops[2])
            if src and imm is not None:
                setv(ops[0], src["value"] + (imm if m == "add" else -imm), src.get("origin"))
            else:
                setv(ops[0], None)
            continue

        if m in ("and", "orr", "eor") and len(ops) >= 3:
            src = getv(ops[1]); imm = parse_int(ops[2])
            if src and imm is not None:
                if m == "and": v = src["value"] & imm
                elif m == "orr": v = src["value"] | imm
                else: v = src["value"] ^ imm
                setv(ops[0], v, src.get("origin"))
            else:
                setv(ops[0], None)
            continue

        if m.startswith("ldr") and len(ops) >= 2:
            dst = norm_reg(ops[0]); mm = MEM_RE.search(ops[1])
            if mm:
                base = getv(mm.group(1)); disp = parse_int(mm.group(2) or "0") or 0
                if base:
                    addr = base["value"] + disp
                    if addr in got_slots:
                        setv(dst, asm_base, f"GLOB_DAT asmFunction @0x{addr:x}")
                        refs.append({"instruction": pc, "kind": "asmFunction_got_load", "address": addr, "context": context(block, idx)})
                    elif addr in resolved_globals:
                        setv(dst, resolved_globals[addr], f"resolved global @0x{addr:x}")
                    elif asm_base <= addr < asm_base + asm_size:
                        # Runtime table entry: value itself is unknown, but preserve semantic origin.
                        setv(dst, None)
                        refs.append({"instruction": pc, "kind": "asmFunction_field_load", "address": addr, "field": addr-asm_base, "context": context(block, idx)})
                    else:
                        setv(dst, None)
                else:
                    setv(dst, None)
            else:
                setv(dst, None)
            continue

        if m.startswith("str") and len(ops) >= 2:
            mm = MEM_RE.search(ops[-1])
            if mm:
                base = getv(mm.group(1)); disp = parse_int(mm.group(2) or "0") or 0
                if base:
                    addr = base["value"] + disp
                    if asm_base <= addr < asm_base + asm_size:
                        src = getv(ops[0])
                        row = {
                            "instruction": pc,
                            "field": addr - asm_base,
                            "address": addr,
                            "source_reg": norm_reg(ops[0]),
                            "source_value": src["value"] if src else None,
                            "source_origin": src.get("origin") if src else None,
                            "source_label": label(src["value"]) if src else None,
                            "context": context(block, idx, 14),
                        }
                        writes.append(row)
            continue

        if m.startswith("stp") and len(ops) >= 3:
            mm = MEM_RE.search(ops[-1])
            if mm:
                base = getv(mm.group(1)); disp = parse_int(mm.group(2) or "0") or 0
                if base:
                    for j, srcop in enumerate(ops[:2]):
                        addr = base["value"] + disp + j*8
                        if asm_base <= addr < asm_base + asm_size:
                            src = getv(srcop)
                            writes.append({
                                "instruction": pc,
                                "field": addr-asm_base,
                                "address": addr,
                                "source_reg": norm_reg(srcop),
                                "source_value": src["value"] if src else None,
                                "source_origin": src.get("origin") if src else None,
                                "source_label": label(src["value"]) if src else None,
                                "context": context(block, idx, 14),
                            })
            continue

        if m == "bl":
            imp = import_by_call.get(pc)
            if imp:
                args = {f"x{i}": regs.get(f"x{i}") for i in range(8)}
                if any(v and asm_base <= v["value"] < asm_base + asm_size for v in args.values()):
                    calls.append({"instruction": pc, "import": imp, "args": args, "context": context(block, idx, 14)})
            # AAPCS64 caller-saved registers are clobbered after a call.
            for i in range(19): regs.pop(f"x{i}", None)
            continue

        if m == "blr":
            # Same conservative clobbering after an indirect call.
            for i in range(19): regs.pop(f"x{i}", None)
            continue

        # Conservative destination clobber.
        if ops and REG_RE.match(ops[0]) and not m.startswith(("b", "cb", "tb", "st")) and m not in ("cmp", "cmn", "tst", "ret"):
            setv(ops[0], None)

    return writes, refs, calls


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--libcompatible", type=Path, required=True)
    ap.add_argument("--bootstrap", type=Path, required=True)
    ap.add_argument("--dispatch", type=Path, required=True)
    ap.add_argument("--loader-slice", type=Path, required=True)
    ap.add_argument("--out", type=Path, required=True)
    args = ap.parse_args()

    symbols, label = load_symbols(args.libcompatible)
    asm = find_asmfunction(symbols)
    asm_base, asm_size = int(asm["address"]), int(asm["size"])
    dispatch = json.loads(args.dispatch.read_text(encoding="utf-8"))
    got_slots, resolved_globals = get_dispatch_info(dispatch, asm)
    bootstrap = json.loads(args.bootstrap.read_text(encoding="utf-8"))
    loader = json.loads(args.loader_slice.read_text(encoding="utf-8"))

    # loader-slice relevant_calls already carries exact callsite -> PLT import labels.
    import_by_call = {}
    for c in loader.get("relevant_calls", []):
        if c.get("plt_import"):
            import_by_call[int(c["address"])] = c["plt_import"]

    writes, refs, calls = [], [], []
    dt_blocks = [b for b in bootstrap.get("blocks", []) if b.get("root_provenance") == "DT_INIT"]
    for block in dt_blocks:
        w, r, c = analyze_block(block, asm_base, asm_size, set(got_slots), resolved_globals, import_by_call, label)
        writes.extend(w); refs.extend(r); calls.extend(c)

    # Dedupe repeated contexts reached from duplicated paths.
    wd = {(x["instruction"], x["field"], x.get("source_value")): x for x in writes}
    rd = {(x["instruction"], x["kind"], x["address"]): x for x in refs}
    cd = {(x["instruction"], x["import"]): x for x in calls}
    writes = sorted(wd.values(), key=lambda x: (x["field"], x["instruction"]))
    refs = sorted(rd.values(), key=lambda x: x["instruction"])
    calls = sorted(cd.values(), key=lambda x: x["instruction"])

    report = {
        "asmFunction": asm,
        "slot_count": asm_size // 8,
        "got_slots": got_slots,
        "dt_init_blocks": len(dt_blocks),
        "references": refs,
        "writes": writes,
        "helper_calls_with_table_argument": calls,
    }
    args.out.mkdir(parents=True, exist_ok=True)
    (args.out / "asmfunction-init.json").write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    lines = [
        "# `asmFunction` runtime table initialization",
        "",
        f"- symbol: `0x{asm_base:x}`",
        f"- size: **{asm_size} bytes** = **{asm_size//8} pointer slots**",
        f"- GLOB_DAT slot(s): {', '.join(f'`0x{x:x}`' for x in got_slots)}",
        f"- DT_INIT blocks inspected: **{len(dt_blocks)}**",
        f"- direct table writes recovered: **{len(writes)}**",
        "",
        "## Recovered writes",
        "",
        "| Field | Write PC | Source | Label/origin |",
        "|---:|---:|---:|---|",
    ]
    for w in writes:
        src = hex(w["source_value"]) if w.get("source_value") is not None else "-"
        labeltxt = w.get("source_label") or w.get("source_origin") or "-"
        lines.append(f"| `+0x{w['field']:x}` | `0x{w['instruction']:x}` | `{src}` | `{labeltxt}` |")

    lines += ["", "## References to table/GOT", "", "| PC | Kind | Target | Field |", "|---:|---|---:|---:|"]
    for r in refs:
        field = f"+0x{r['field']:x}" if r.get("field") is not None else "-"
        lines.append(f"| `0x{r['instruction']:x}` | `{r['kind']}` | `0x{r['address']:x}` | `{field}` |")

    if calls:
        lines += ["", "## Imported helper calls with an asmFunction pointer argument", ""]
        for c in calls:
            lines.append(f"- `0x{c['instruction']:x}` -> `{c['import']}`")

    lines += ["", "## Write contexts", ""]
    for w in writes:
        lines += [f"### `asmFunction+0x{w['field']:x}` at `0x{w['instruction']:x}`", "", "```asm"]
        for i in w["context"]:
            mark = "  ; <-- write" if int(i["address"]) == w["instruction"] else ""
            lines.append(f"0x{int(i['address']):x}: {i['mnemonic']} {i['op_str']}{mark}")
        lines += ["```", ""]

    # Always include contexts around references to the hot +0xa0 field even if a direct write is not resolved.
    hot = [r for r in refs if r.get("field") == 0xa0]
    for r in hot[:12]:
        lines += [f"### hot field reference at `0x{r['instruction']:x}`", "", "```asm"]
        for i in r["context"]:
            mark = "  ; <-- asmFunction+0xa0" if int(i["address"]) == r["instruction"] else ""
            lines.append(f"0x{int(i['address']):x}: {i['mnemonic']} {i['op_str']}{mark}")
        lines += ["```", ""]

    (args.out / "asmfunction-init.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(json.dumps({
        "asmFunction": hex(asm_base),
        "size": asm_size,
        "slots": asm_size//8,
        "got_slots": [hex(x) for x in got_slots],
        "writes": len(writes),
        "references": len(refs),
        "helper_calls": len(calls),
    }, indent=2))


if __name__ == "__main__":
    main()

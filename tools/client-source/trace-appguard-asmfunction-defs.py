#!/usr/bin/env python3
"""Backward-slice definitions of registers written into asmFunction.

Forward constant propagation is intentionally defeated by AppGuard's opaque
state machine.  This pass instead walks the recovered DT_INIT interprocedural
CFG backwards from each of the 21 table writes and reports the nearest
instructions that define the source register (x27 for slots 0..0x90, x19 for
0x98/0xa0), together with the predecessor path and local disassembly context.
"""
from __future__ import annotations

import argparse
import json
import re
from collections import defaultdict, deque
from pathlib import Path

REG_RE = re.compile(r"^[xw](\d+)$")


def norm(s: str) -> str:
    s = s.strip()
    m = REG_RE.match(s)
    return 'x' + m.group(1) if m else s


def split_ops(text: str) -> list[str]:
    out, buf, depth = [], [], 0
    for ch in text:
        if ch == '[': depth += 1
        elif ch == ']': depth -= 1
        if ch == ',' and depth == 0:
            out.append(''.join(buf).strip()); buf = []
        else: buf.append(ch)
    if buf: out.append(''.join(buf).strip())
    return out


def writes_reg(ins: dict, reg: str) -> bool:
    m = ins.get('mnemonic', '')
    ops = split_ops(ins.get('op_str', ''))
    if not ops:
        return False
    # Stores/branches/comparisons don't define their first register operand.
    if m.startswith(('st', 'b', 'cb', 'tb')) or m in ('cmp', 'cmn', 'tst', 'ret'):
        return False
    # ldp defines first two operands.
    if m.startswith('ldp'):
        return any(REG_RE.match(x) and norm(x) == reg for x in ops[:2])
    return bool(REG_RE.match(ops[0]) and norm(ops[0]) == reg)


def context(insns: list[dict], idx: int, radius: int = 7) -> list[dict]:
    return insns[max(0, idx-radius):min(len(insns), idx+radius+1)]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--bootstrap', type=Path, required=True)
    ap.add_argument('--asm-init', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    a = ap.parse_args()

    boot = json.loads(a.bootstrap.read_text(encoding='utf-8'))
    ai = json.loads(a.asm_init.read_text(encoding='utf-8'))
    blocks = {int(b['start']): b for b in boot.get('blocks', []) if b.get('root_provenance') == 'DT_INIT'}

    # Map every instruction to containing block/index.
    loc = {}
    for st, b in blocks.items():
        for idx, ins in enumerate(b.get('instructions', [])):
            loc[int(ins['address'])] = (st, idx)

    # Predecessors from normal CFG edges.
    preds = defaultdict(list)
    for st, b in blocks.items():
        for dst in b.get('successors', []):
            dst = int(dst)
            if dst in blocks:
                preds[dst].append({'block': st, 'kind': 'cfg', 'at': None})

    # Add interprocedural BL-entry edges. The bootstrap report has exact direct targets.
    for c in boot.get('calls', []):
        if c.get('root_provenance') != 'DT_INIT' or c.get('target') is None:
            continue
        pc, dst = int(c['address']), int(c['target'])
        if dst not in blocks or pc not in loc:
            continue
        src_block, _ = loc[pc]
        preds[dst].append({'block': src_block, 'kind': 'call', 'at': pc})

    results = []
    for w in ai.get('writes', []):
        pc = int(w['instruction'])
        field = int(w['field'])
        reg = norm(w['source_reg'])
        if pc not in loc:
            results.append({'field': field, 'write_pc': pc, 'source_reg': reg, 'definitions': [], 'error': 'write not in DT_INIT block map'})
            continue
        start_block, write_idx = loc[pc]
        found = []

        # First inspect earlier instructions in the same block.
        insns = blocks[start_block].get('instructions', [])
        for idx in range(write_idx - 1, -1, -1):
            if writes_reg(insns[idx], reg):
                found.append({
                    'definition_pc': int(insns[idx]['address']),
                    'instruction': insns[idx],
                    'block': start_block,
                    'distance_edges': 0,
                    'path': [],
                    'context': context(insns, idx),
                })
                break

        # Reverse BFS to predecessor blocks, searching the last definition in each.
        if not found:
            q = deque([(start_block, [])])
            seen = {start_block}
            best_depth = None
            while q:
                block, path = q.popleft()
                depth = len(path)
                if best_depth is not None and depth > best_depth + 2:
                    break
                if depth >= 32:
                    continue
                for edge in preds.get(block, []):
                    pb = int(edge['block'])
                    if pb in seen:
                        continue
                    seen.add(pb)
                    ppath = path + [{'from': pb, 'to': block, 'kind': edge['kind'], 'callsite': edge['at']}]
                    pins = blocks[pb].get('instructions', [])
                    hit = None
                    # If this is a call predecessor, only instructions before the BL contribute to callee entry.
                    limit = len(pins)
                    if edge['kind'] == 'call' and edge['at'] is not None:
                        for j, ii in enumerate(pins):
                            if int(ii['address']) == int(edge['at']):
                                limit = j
                                break
                    for idx in range(limit - 1, -1, -1):
                        if writes_reg(pins[idx], reg):
                            hit = (idx, pins[idx])
                            break
                    if hit:
                        idx, ins = hit
                        d = len(ppath)
                        if best_depth is None:
                            best_depth = d
                        found.append({
                            'definition_pc': int(ins['address']),
                            'instruction': ins,
                            'block': pb,
                            'distance_edges': d,
                            'path': ppath,
                            'context': context(pins, idx),
                        })
                    else:
                        q.append((pb, ppath))

        # Dedupe and cap, preferring shortest paths then lowest pc.
        dd = {}
        for f in found:
            key = (f['definition_pc'], f['distance_edges'])
            dd[key] = f
        defs = sorted(dd.values(), key=lambda x: (x['distance_edges'], x['definition_pc']))[:20]
        results.append({
            'field': field,
            'write_pc': pc,
            'source_reg': reg,
            'write_block': start_block,
            'definitions': defs,
        })

    report = {'dt_init_blocks': len(blocks), 'writes': results}
    a.out.mkdir(parents=True, exist_ok=True)
    (a.out / 'asmfunction-defs.json').write_text(json.dumps(report, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')

    lines = [
        '# `asmFunction` backward definition slices', '',
        f'- DT_INIT blocks: **{len(blocks)}**', '',
        '| Field | Write | Reg | Nearest definition(s) | Edge distance |',
        '|---:|---:|---|---|---:|',
    ]
    for r in results:
        defs = r.get('definitions', [])
        dtxt = '<br>'.join(f"`0x{d['definition_pc']:x}: {d['instruction']['mnemonic']} {d['instruction']['op_str']}`" for d in defs[:6]) or '-'
        dist = ','.join(str(d['distance_edges']) for d in defs[:6]) if defs else '-'
        lines.append(f"| `+0x{r['field']:x}` | `0x{r['write_pc']:x}` | `{r['source_reg']}` | {dtxt} | {dist} |")

    for r in results:
        if not r.get('definitions'):
            continue
        lines += ['', f"## `asmFunction+0x{r['field']:x}`", '']
        for d in r['definitions'][:8]:
            path = ' <- '.join(
                f"0x{e['from']:x}({e['kind']}{'@0x%x'%e['callsite'] if e.get('callsite') is not None else ''})"
                for e in reversed(d['path'])
            )
            lines.append(f"### definition `0x{d['definition_pc']:x}`; reverse path: {path or 'same block'}")
            lines.append('')
            lines.append('```asm')
            for ii in d['context']:
                mark = '  ; <-- definition' if int(ii['address']) == d['definition_pc'] else ''
                lines.append(f"0x{int(ii['address']):x}: {ii['mnemonic']} {ii['op_str']}{mark}")
            lines += ['```', '']

    (a.out / 'asmfunction-defs.md').write_text('\n'.join(lines) + '\n', encoding='utf-8')
    print(json.dumps({
        'writes': len(results),
        'with_definition': sum(bool(r.get('definitions')) for r in results),
        'unique_definition_pcs': sorted({hex(d['definition_pc']) for r in results for d in r.get('definitions', [])}),
    }, indent=2))


if __name__ == '__main__':
    main()

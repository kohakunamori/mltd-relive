#!/usr/bin/env python3
"""Interprocedural abstract dataflow for asmFunction source registers.

The first pass recovered all 21 writes, but their source registers are inherited
through DT_INIT call edges.  This pass propagates symbolic register states across
both ordinary CFG edges and direct BL edges.  The state passed into a callee is
the pre-call state; the caller continuation still applies AAPCS64 caller-saved
clobbering.  This is sufficient to recover x19-x28 values used by AppGuard's
runtime asmFunction table initialization without pretending to model full
function returns.
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
MAX_VALUES = 12
TOP = "<?>"


def norm(s: str) -> str:
    s = s.strip()
    m = REG_RE.match(s)
    return "x" + m.group(1) if m else s


def p_int(s: str) -> int | None:
    try:
        return int(s.strip().lstrip('#'), 0)
    except Exception:
        return None


def split_ops(text: str) -> list[str]:
    out, buf, depth = [], [], 0
    for ch in text:
        if ch == '[':
            depth += 1
        elif ch == ']':
            depth -= 1
        if ch == ',' and depth == 0:
            out.append(''.join(buf).strip())
            buf = []
        else:
            buf.append(ch)
    if buf:
        out.append(''.join(buf).strip())
    return out


def symbol_labeler(path: Path):
    rows = []
    with path.open('rb') as f:
        e = ELFFile(f)
        for sec in e.iter_sections():
            if isinstance(sec, SymbolTableSection):
                for s in sec.iter_symbols():
                    if s.name and s['st_shndx'] != 'SHN_UNDEF' and int(s['st_value']):
                        rows.append((int(s['st_value']), int(s['st_size']), s.name))
    by = defaultdict(list)
    for a, z, n in rows:
        by[a].append((z, n))
    addrs = sorted(by)

    def lab(a: int | None):
        if a is None:
            return None
        if a in by:
            return ','.join(sorted(n for _, n in by[a]))
        i = bisect.bisect_right(addrs, a) - 1
        if i < 0:
            return None
        st = addrs[i]
        z, n = max(by[st])
        return f'{n}+0x{a-st:x}'
    return lab


def fmt_const(v: int, label) -> str:
    l = label(v)
    return f'0x{v:x}' + (f'[{l}]' if l else '')


def union_values(*sets):
    vals = set()
    for s in sets:
        if s:
            vals.update(s)
    if TOP in vals or len(vals) > MAX_VALUES:
        return frozenset({TOP})
    return frozenset(sorted(vals))


def map_unary(vals, op):
    if not vals:
        return frozenset()
    if TOP in vals:
        return frozenset({TOP})
    return union_values({op(v) for v in vals})


def get(state, reg):
    return state.get(norm(reg), frozenset())


def setv(state, reg, vals):
    r = norm(reg)
    vals = frozenset(vals)
    if vals:
        state[r] = vals
    else:
        state.pop(r, None)


def merge_state(old: dict, new: dict):
    if not old:
        return {k: frozenset(v) for k, v in new.items()}
    keys = set(old) | set(new)
    merged = {}
    for k in keys:
        # Missing on one incoming edge means unknown on that edge.  Mark TOP so
        # later output does not accidentally claim path-universal certainty.
        if k not in old or k not in new:
            merged[k] = frozenset({TOP})
        else:
            v = union_values(old.get(k), new.get(k))
            if v:
                merged[k] = v
    return merged


def state_sig(s):
    return tuple(sorted((k, tuple(sorted(v))) for k, v in s.items()))


def call_info(bootstrap, loader):
    labels = {}
    targets = {}
    imp = {int(c['address']): c.get('plt_import') for c in loader.get('relevant_calls', []) if c.get('plt_import')}
    for c in bootstrap.get('calls', []):
        pc = int(c['address'])
        if c.get('target') is not None:
            targets[pc] = int(c['target'])
        name = imp.get(pc)
        if not name:
            xs = c.get('target_symbols') or []
            if xs:
                name = ','.join(xs)
            else:
                n = c.get('target_nearest') or {}
                if n.get('name'):
                    name = f"{n['name']}+0x{int(n.get('offset', 0)):x}"
        if not name and c.get('target') is not None:
            name = hex(int(c['target']))
        labels[pc] = name or '?'
    return labels, targets


def process_block(block, state_in, write_map, call_labels, call_targets, label):
    s = {k: frozenset(v) for k, v in state_in.items()}
    captures = []
    call_edges = []
    for ins in block.get('instructions', []):
        pc = int(ins['address'])
        m = ins['mnemonic']
        ops = split_ops(ins.get('op_str', ''))

        if pc in write_map:
            for w in write_map[pc]:
                captures.append({**w, 'values': sorted(get(s, w['source_reg']))})

        if m in ('adr', 'adrp') and len(ops) >= 2:
            v = p_int(ops[1])
            setv(s, ops[0], {fmt_const(v, label)} if v is not None else set())
            continue
        if m in ('mov', 'movz') and len(ops) >= 2:
            v = p_int(ops[1])
            setv(s, ops[0], {fmt_const(v, label)} if v is not None else get(s, ops[1]))
            continue
        if m == 'movk' and len(ops) >= 2:
            cur = get(s, ops[0])
            imm = p_int(ops[1])
            shift = 0
            mm = re.search(r'lsl\s+#(\d+)', ins.get('op_str', ''))
            if mm:
                shift = int(mm.group(1))
            if cur and imm is not None:
                setv(s, ops[0], map_unary(cur, lambda x: f'movk({x},0x{imm:x}<<{shift})'))
            else:
                setv(s, ops[0], set())
            continue
        if m in ('add', 'sub', 'and', 'orr', 'eor', 'lsl', 'lsr') and len(ops) >= 3:
            a = get(s, ops[1])
            imm = p_int(ops[2])
            b = get(s, ops[2])
            rhs = (f'0x{imm:x}' if imm is not None and imm >= 0 else str(imm)) if imm is not None else None
            op = {'add': '+', 'sub': '-', 'and': '&', 'orr': '|', 'eor': '^', 'lsl': '<<', 'lsr': '>>'}[m]
            if a and rhs is not None:
                setv(s, ops[0], map_unary(a, lambda x: f'({x}{op}{rhs})'))
            elif a and b and TOP not in a and TOP not in b:
                setv(s, ops[0], union_values({f'({x}{op}{y})' for x in a for y in b}))
            else:
                setv(s, ops[0], set())
            continue
        if m in ('neg', 'mvn') and len(ops) >= 2:
            src = get(s, ops[1])
            sym = '-' if m == 'neg' else '~'
            setv(s, ops[0], map_unary(src, lambda x: f'{sym}({x})'))
            continue
        if m.startswith('ldp') and len(ops) >= 3:
            mm = MEM_RE.search(ops[-1])
            base = get(s, mm.group(1)) if mm else frozenset()
            disp = p_int(mm.group(2) or '0') if mm else 0
            disp = disp or 0
            setv(s, ops[0], map_unary(base, lambda x: f'mem64[{x}{disp:+#x}]') if base else {f'load@0x{pc:x}:0'})
            setv(s, ops[1], map_unary(base, lambda x: f'mem64[{x}{disp+8:+#x}]') if base else {f'load@0x{pc:x}:1'})
            continue
        if m.startswith('ldr') and len(ops) >= 2:
            mm = MEM_RE.search(ops[1])
            expr = None
            if mm:
                base = get(s, mm.group(1))
                disp = p_int(mm.group(2) or '0') or 0
                if base:
                    expr = map_unary(base, lambda x: f'mem64[{x}{disp:+#x}]')
            setv(s, ops[0], expr or {f'load@0x{pc:x}'})
            continue
        if m.startswith('csel') and len(ops) >= 3:
            setv(s, ops[0], union_values(get(s, ops[1]), get(s, ops[2])))
            continue
        if m == 'bl':
            # Propagate the *pre-call* state to the direct callee. This is the
            # missing edge needed for x19-x28 inherited by nested init helpers.
            target = call_targets.get(pc)
            if target is not None:
                call_edges.append({'target': target, 'state': {k: frozenset(v) for k, v in s.items()}, 'callsite': pc})
            name = call_labels.get(pc, '?')
            for i in range(19):
                s.pop(f'x{i}', None)
            s['x0'] = frozenset({f'ret@0x{pc:x}[{name}]'})
            continue
        if m == 'blr':
            target = get(s, ops[0]) if ops else frozenset({TOP})
            for i in range(19):
                s.pop(f'x{i}', None)
            t = '|'.join(sorted(target)) if target else '?'
            s['x0'] = frozenset({f'ret_indirect@0x{pc:x}[{t}]'})
            continue
        if m == 'cset' and ops:
            setv(s, ops[0], {'bool{0,1}'})
            continue
        if ops and REG_RE.match(ops[0]) and not m.startswith(('b', 'cb', 'tb', 'st')) and m not in ('cmp', 'cmn', 'tst', 'ret'):
            setv(s, ops[0], set())
    return s, captures, call_edges


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libcompatible', type=Path, required=True)
    ap.add_argument('--bootstrap', type=Path, required=True)
    ap.add_argument('--asm-init', type=Path, required=True)
    ap.add_argument('--loader-slice', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    a = ap.parse_args()

    boot = json.loads(a.bootstrap.read_text())
    ai = json.loads(a.asm_init.read_text())
    loader = json.loads(a.loader_slice.read_text())
    label = symbol_labeler(a.libcompatible)
    labels, targets = call_info(boot, loader)
    blocks = {int(b['start']): b for b in boot.get('blocks', []) if b.get('root_provenance') == 'DT_INIT'}
    writes = defaultdict(list)
    for w in ai.get('writes', []):
        writes[int(w['instruction'])].append({
            'instruction': int(w['instruction']),
            'field': int(w['field']),
            'source_reg': w['source_reg'],
        })

    entry = 0x6a70
    in_states = {entry: {}}
    out_states = {}
    q = deque([entry])
    queued = {entry}
    captures = {}
    call_provenance = defaultdict(set)
    steps = 0

    def push(dst: int, state: dict, reason: str):
        if dst not in blocks:
            return
        old = in_states.get(dst)
        merged = {k: frozenset(v) for k, v in state.items()} if old is None else merge_state(old, state)
        if old is None or state_sig(merged) != state_sig(old):
            in_states[dst] = merged
            if dst not in queued:
                q.append(dst)
                queued.add(dst)
        call_provenance[dst].add(reason)

    while q and steps < 400000:
        steps += 1
        start = q.popleft()
        queued.discard(start)
        b = blocks.get(start)
        if not b:
            continue
        out, caps, call_edges = process_block(b, in_states.get(start, {}), writes, labels, targets, label)
        old_out = out_states.get(start)
        changed = old_out is None or state_sig(old_out) != state_sig(out)
        if changed:
            out_states[start] = out
        for c in caps:
            key = (c['instruction'], c['field'])
            prev = captures.get(key)
            if prev is None:
                captures[key] = c
            else:
                prev['values'] = sorted(union_values(prev.get('values', []), c.get('values', [])))
        # Branch/fallthrough edges use the post-block state.
        if changed:
            for succ in b.get('successors', []):
                push(int(succ), out, f'cfg:0x{start:x}')
        # Direct-call entry edges use pre-call state captured at each BL.
        for edge in call_edges:
            push(int(edge['target']), edge['state'], f"call:0x{edge['callsite']:x}")

    rows = sorted(captures.values(), key=lambda x: (x['field'], x['instruction']))
    report = {
        'entry': entry,
        'blocks': len(blocks),
        'iterations': steps,
        'states_reached': len(in_states),
        'resolved_writes': rows,
        'call_provenance': {hex(k): sorted(v) for k, v in call_provenance.items() if v},
    }
    a.out.mkdir(parents=True, exist_ok=True)
    (a.out / 'asmfunction-flow.json').write_text(json.dumps(report, indent=2) + '\n')

    L = [
        '# `asmFunction` interprocedural source flow', '',
        f'- DT_INIT blocks in graph: **{len(blocks)}**',
        f'- blocks reached with abstract state: **{len(in_states)}**',
        f'- dataflow iterations: **{steps}**', '',
        '| Field | Write PC | Source register | Possible source expression(s) |',
        '|---:|---:|---|---|',
    ]
    for r in rows:
        vals = r.get('values', [])
        L.append(f"| `+0x{r['field']:x}` | `0x{r['instruction']:x}` | `{r['source_reg']}` | {'<br>'.join('`'+v+'`' for v in vals) or '-'} |")
    (a.out / 'asmfunction-flow.md').write_text('\n'.join(L) + '\n')
    print(json.dumps({
        'writes': len(rows),
        'iterations': steps,
        'states_reached': len(in_states),
        'resolved_nonempty': sum(bool(r.get('values')) for r in rows),
    }, indent=2))


if __name__ == '__main__':
    main()

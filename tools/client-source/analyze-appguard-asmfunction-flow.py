#!/usr/bin/env python3
"""Cross-basic-block abstract dataflow for asmFunction source registers.

The first asmFunction pass recovers all 21 writes but many source registers are
inherited from predecessor blocks (x27 for the first 19 slots, x19 for the final
pair).  This pass propagates compact symbolic register values through the DT_INIT
CFG so those inherited values can be tied to constants, load expressions, or
specific call return sites.
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
MAX_VALUES = 10
TOP = "<?>"


def norm(s: str) -> str:
    s=s.strip(); m=REG_RE.match(s)
    return "x"+m.group(1) if m else s


def p_int(s: str) -> int | None:
    try:return int(s.strip().lstrip('#'),0)
    except:return None


def split_ops(text: str) -> list[str]:
    out=[];buf=[];depth=0
    for ch in text:
        if ch=='[':depth+=1
        elif ch==']':depth-=1
        if ch==',' and depth==0:
            out.append(''.join(buf).strip());buf=[]
        else:buf.append(ch)
    if buf:out.append(''.join(buf).strip())
    return out


def symbol_labeler(path: Path):
    rows=[]
    with path.open('rb') as f:
        e=ELFFile(f)
        for sec in e.iter_sections():
            if isinstance(sec,SymbolTableSection):
                for s in sec.iter_symbols():
                    if s.name and s['st_shndx']!='SHN_UNDEF' and int(s['st_value']):
                        rows.append((int(s['st_value']),int(s['st_size']),s.name))
    by=defaultdict(list)
    for a,z,n in rows:by[a].append((z,n))
    addrs=sorted(by)
    def lab(a:int|None):
        if a is None:return None
        if a in by:return ','.join(sorted(n for _,n in by[a]))
        i=bisect.bisect_right(addrs,a)-1
        if i<0:return None
        st=addrs[i];z,n=max(by[st])
        return f'{n}+0x{a-st:x}'
    return lab


def fmt_const(v:int,label) -> str:
    l=label(v)
    return f'0x{v:x}' + (f'[{l}]' if l else '')


def union_values(*sets):
    vals=set()
    for s in sets:
        if not s:continue
        vals.update(s)
    if TOP in vals or len(vals)>MAX_VALUES:return frozenset({TOP})
    return frozenset(sorted(vals))


def map_unary(vals,op):
    if not vals:return frozenset()
    if TOP in vals:return frozenset({TOP})
    out={op(v) for v in vals}
    return union_values(out)


def get(state,reg):return state.get(norm(reg),frozenset())
def setv(state,reg,vals):
    r=norm(reg)
    vals=frozenset(vals)
    if vals:state[r]=vals
    else:state.pop(r,None)


def merge_state(old:dict,new:dict):
    keys=set(old)|set(new);merged={}
    for k in keys:
        v=union_values(old.get(k),new.get(k))
        if v:merged[k]=v
    return merged


def state_sig(s):return tuple(sorted((k,tuple(sorted(v))) for k,v in s.items()))


def call_labels(bootstrap,loader):
    by={}
    imp={int(c['address']):c.get('plt_import') for c in loader.get('relevant_calls',[]) if c.get('plt_import')}
    for c in bootstrap.get('calls',[]):
        pc=int(c['address']); name=imp.get(pc)
        if not name:
            xs=c.get('target_symbols') or []
            if xs:name=','.join(xs)
            else:
                n=c.get('target_nearest') or {}
                if n.get('name'):name=f"{n['name']}+0x{int(n.get('offset',0)):x}"
        if not name and c.get('target') is not None:name=hex(int(c['target']))
        by[pc]=name or '?'
    return by


def process_block(block,state_in,write_map,callmap,label):
    s={k:frozenset(v) for k,v in state_in.items()}
    captures=[]
    for ins in block.get('instructions',[]):
        pc=int(ins['address']);m=ins['mnemonic'];ops=split_ops(ins.get('op_str',''))

        if pc in write_map:
            for w in write_map[pc]:
                captures.append({**w,'values':sorted(get(s,w['source_reg']))})

        if m in ('adr','adrp') and len(ops)>=2:
            v=p_int(ops[1]);setv(s,ops[0],{fmt_const(v,label)} if v is not None else set());continue
        if m in ('mov','movz') and len(ops)>=2:
            v=p_int(ops[1])
            setv(s,ops[0],{fmt_const(v,label)} if v is not None else get(s,ops[1]));continue
        if m=='movk' and len(ops)>=2:
            # Preserve a readable symbolic expression; exact constant folding is not essential here.
            cur=get(s,ops[0]);imm=p_int(ops[1]);shift=0
            mm=re.search(r'lsl\s+#(\d+)',ins.get('op_str',''))
            if mm:shift=int(mm.group(1))
            if cur and imm is not None:
                setv(s,ops[0],map_unary(cur,lambda x:f'movk({x},0x{imm:x}<<{shift})'))
            else:setv(s,ops[0],set())
            continue
        if m in ('add','sub','and','orr','eor','lsl','lsr') and len(ops)>=3:
            a=get(s,ops[1]);imm=p_int(ops[2]);b=get(s,ops[2])
            rhs=(f'0x{imm:x}' if imm is not None and imm>=0 else str(imm)) if imm is not None else None
            op={'add':'+','sub':'-','and':'&','orr':'|','eor':'^','lsl':'<<','lsr':'>>'}[m]
            if a and rhs is not None:setv(s,ops[0],map_unary(a,lambda x:f'({x}{op}{rhs})'))
            elif a and b and TOP not in a and TOP not in b:
                vals={f'({x}{op}{y})' for x in a for y in b};setv(s,ops[0],union_values(vals))
            else:setv(s,ops[0],set())
            continue
        if m in ('neg','mvn') and len(ops)>=2:
            src=get(s,ops[1]);sym='-' if m=='neg' else '~';setv(s,ops[0],map_unary(src,lambda x:f'{sym}({x})'));continue
        if m.startswith('ldr') and len(ops)>=2:
            mm=MEM_RE.search(ops[1]);expr=None
            if mm:
                base=get(s,mm.group(1));disp=p_int(mm.group(2) or '0') or 0
                if base:
                    expr=map_unary(base,lambda x:f'mem64[{x}{disp:+#x}]')
            setv(s,ops[0],expr or {f'load@0x{pc:x}'})
            continue
        if m.startswith('ldp') and len(ops)>=3:
            mm=MEM_RE.search(ops[-1]);base=get(s,mm.group(1)) if mm else frozenset();disp=p_int(mm.group(2) or '0') if mm else 0;disp=disp or 0
            setv(s,ops[0],map_unary(base,lambda x:f'mem64[{x}{disp:+#x}]') if base else {f'load@0x{pc:x}:0'})
            setv(s,ops[1],map_unary(base,lambda x:f'mem64[{x}{disp+8:+#x}]') if base else {f'load@0x{pc:x}:1'})
            continue
        if m.startswith('csel') and len(ops)>=3:
            setv(s,ops[0],union_values(get(s,ops[1]),get(s,ops[2])));continue
        if m=='bl':
            name=callmap.get(pc,'?')
            for i in range(19):s.pop(f'x{i}',None)
            s['x0']=frozenset({f'ret@0x{pc:x}[{name}]'})
            continue
        if m=='blr':
            target=get(s,ops[0]) if ops else frozenset({TOP})
            for i in range(19):s.pop(f'x{i}',None)
            t='|'.join(sorted(target)) if target else '?';s['x0']=frozenset({f'ret_indirect@0x{pc:x}[{t}]'})
            continue
        # cset writes a small bool; keep it symbolic but bounded.
        if m=='cset' and ops:
            setv(s,ops[0],{'bool{0,1}'});continue
        if ops and REG_RE.match(ops[0]) and not m.startswith(('b','cb','tb','st')) and m not in ('cmp','cmn','tst','ret'):
            setv(s,ops[0],set())
    return s,captures


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--bootstrap',type=Path,required=True);ap.add_argument('--asm-init',type=Path,required=True);ap.add_argument('--loader-slice',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    boot=json.loads(a.bootstrap.read_text());ai=json.loads(a.asm_init.read_text());loader=json.loads(a.loader_slice.read_text());label=symbol_labeler(a.libcompatible);calls=call_labels(boot,loader)
    blocks={int(b['start']):b for b in boot.get('blocks',[]) if b.get('root_provenance')=='DT_INIT'}
    writes=defaultdict(list)
    for w in ai.get('writes',[]):writes[int(w['instruction'])].append({'instruction':int(w['instruction']),'field':int(w['field']),'source_reg':w['source_reg']})
    entry=0x6a70
    in_states={entry:{}};out_states={};q=deque([entry]);queued={entry};captures={};steps=0
    while q and steps<200000:
        steps+=1;start=q.popleft();queued.discard(start);b=blocks.get(start)
        if not b:continue
        out,caps=process_block(b,in_states.get(start,{}),writes,calls,label);old=out_states.get(start)
        if old is not None and state_sig(old)==state_sig(out):
            for c in caps:captures[(c['instruction'],c['field'])]=c
            continue
        out_states[start]=out
        for c in caps:captures[(c['instruction'],c['field'])]=c
        for succ in b.get('successors',[]):
            succ=int(succ)
            if succ not in blocks:continue
            merged=merge_state(in_states.get(succ,{}),out)
            if state_sig(merged)!=state_sig(in_states.get(succ,{})):
                in_states[succ]=merged
                if succ not in queued:q.append(succ);queued.add(succ)
    rows=sorted(captures.values(),key=lambda x:(x['field'],x['instruction']))
    report={'entry':entry,'blocks':len(blocks),'iterations':steps,'resolved_writes':rows}
    a.out.mkdir(parents=True,exist_ok=True);(a.out/'asmfunction-flow.json').write_text(json.dumps(report,indent=2)+'\n')
    L=['# `asmFunction` cross-block source flow','',f'- DT_INIT blocks in graph: **{len(blocks)}**',f'- dataflow iterations: **{steps}**','', '| Field | Write PC | Source register | Possible source expression(s) |','|---:|---:|---|---|']
    for r in rows:L.append(f"| `+0x{r['field']:x}` | `0x{r['instruction']:x}` | `{r['source_reg']}` | {'<br>'.join('`'+v+'`' for v in r.get('values',[])) or '-'} |")
    (a.out/'asmfunction-flow.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'writes':len(rows),'iterations':steps,'fields':[hex(r['field']) for r in rows]},indent=2))
if __name__=='__main__':main()

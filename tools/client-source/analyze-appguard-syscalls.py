#!/usr/bin/env python3
"""Recover direct AArch64 syscall usage and loader candidates from AppGuard ELFs.

AppGuard deliberately damages/obfuscates section metadata and may bypass libc via
exported asm_* syscall wrappers. This analyzer therefore disassembles executable
PT_LOAD segments, resolves defined symbols from any symbol-table section (even
unnamed ones), finds direct BL calls to asm_* wrappers, and ranks functions that
look like file->buffer->mapping loaders.
"""
from __future__ import annotations

import argparse
import bisect
import hashlib
import json
from collections import defaultdict, deque
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM, ARM64_OP_REG
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection

SYSCALLS_AARCH64 = {
    56: "openat",
    57: "close",
    61: "getdents64",
    62: "lseek",
    63: "read",
    64: "write",
    67: "pread64",
    68: "pwrite64",
    78: "readlinkat",
    79: "newfstatat",
    93: "exit",
    94: "exit_group",
    96: "set_tid_address",
    98: "futex",
    99: "set_robust_list",
    101: "nanosleep",
    117: "ptrace",
    129: "kill",
    131: "tgkill",
    134: "rt_sigaction",
    135: "rt_sigprocmask",
    167: "prctl",
    172: "getpid",
    173: "getppid",
    178: "gettid",
    198: "socket",
    203: "connect",
    214: "brk",
    215: "munmap",
    220: "clone",
    221: "execve",
    222: "mmap",
    226: "mprotect",
    261: "prlimit64",
    278: "getrandom",
    281: "execveat",
}

LOADER_WEIGHTS = {
    "asm_openat": 4,
    "asm_open": 4,
    "asm_read": 4,
    "asm_pread64": 4,
    "asm_lseek": 3,
    "asm_mmap": 5,
    "asm_mprotect": 5,
    "asm_munmap": 2,
    "asm_close": 1,
}


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b''):
            h.update(chunk)
    return h.hexdigest()


def function_symbols(elf: ELFFile) -> list[dict]:
    best: dict[tuple[int, str], dict] = {}
    for sec in elf.iter_sections():
        if not isinstance(sec, SymbolTableSection):
            continue
        for sym in sec.iter_symbols():
            name = sym.name
            if not name or sym['st_shndx'] == 'SHN_UNDEF':
                continue
            if sym['st_info']['type'] not in ('STT_FUNC', 'STT_NOTYPE'):
                continue
            addr = int(sym['st_value'])
            if addr == 0:
                continue
            row = {
                'name': name,
                'address': addr,
                'size': int(sym['st_size']),
                'bind': str(sym['st_info']['bind']),
                'type': str(sym['st_info']['type']),
            }
            best[(addr, name)] = row
    return sorted(best.values(), key=lambda x: (x['address'], x['name']))


def executable_segments(elf: ELFFile) -> list[dict]:
    rows=[]
    for seg in elf.iter_segments():
        if str(seg['p_type']) != 'PT_LOAD' or not (int(seg['p_flags']) & 1):
            continue
        rows.append({
            'vaddr': int(seg['p_vaddr']),
            'offset': int(seg['p_offset']),
            'filesz': int(seg['p_filesz']),
            'data': seg.data(),
        })
    return rows


def owner_lookup(functions: list[dict]):
    by_addr=[]
    # When multiple symbols share an address, prefer a non-asm and larger symbol as owner.
    grouped=defaultdict(list)
    for f in functions:
        grouped[f['address']].append(f)
    for addr, rows in grouped.items():
        rows.sort(key=lambda r: (r['name'].startswith('asm_'), -r['size'], r['name']))
        by_addr.append((addr, rows[0]))
    by_addr.sort()
    addrs=[x[0] for x in by_addr]
    def lookup(addr:int):
        i=bisect.bisect_right(addrs, addr)-1
        if i < 0:
            return None
        start, row=by_addr[i]
        if row['size'] and addr >= start + row['size']:
            # Still useful as a nearest-symbol label, but mark that it is outside declared size.
            return {**row, 'within_declared_size': False}
        return {**row, 'within_declared_size': True}
    return lookup


def insn_text(ins) -> str:
    return f"0x{ins.address:x}: {ins.mnemonic} {ins.op_str}".rstrip()


def x8_immediate(ins) -> int | None:
    if ins.mnemonic not in ('mov', 'movz', 'movn') or len(ins.operands) < 2:
        return None
    a,b=ins.operands[0],ins.operands[1]
    if a.type != ARM64_OP_REG or b.type != ARM64_OP_IMM:
        return None
    if ins.reg_name(a.reg) not in ('x8','w8'):
        return None
    value=int(b.imm)
    if ins.mnemonic == 'movn':
        value=(~value) & 0xffffffffffffffff
    return value


def analyze(path: Path) -> dict:
    with path.open('rb') as f:
        elf=ELFFile(f)
        machine=str(elf['e_machine'])
        if machine != 'EM_AARCH64':
            return {'name':path.name,'sha256':sha256(path),'size':path.stat().st_size,'machine':machine,'skipped':'not AArch64'}
        funcs=function_symbols(elf)
        segments=executable_segments(elf)

    asm_targets={f['address']:f['name'] for f in funcs if f['name'].startswith('asm_')}
    asm_symbols=sorted((f for f in funcs if f['name'].startswith('asm_')), key=lambda r:r['name'])
    owner=owner_lookup(funcs)
    md=Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    md.detail=True

    direct_calls=[]
    svc_sites=[]
    function_calls=defaultdict(lambda: defaultdict(list))
    wrapper_disassembly={}

    all_ins=[]
    for seg in segments:
        ins=list(md.disasm(seg['data'],seg['vaddr']))
        all_ins.extend(ins)
        recent_x8=deque(maxlen=12)
        for idx, cur in enumerate(ins):
            imm=x8_immediate(cur)
            if imm is not None:
                recent_x8.append((idx,imm,cur.address))
            if cur.mnemonic == 'svc':
                nr=None; setter=None
                for j,val,addr in reversed(recent_x8):
                    if idx-j <= 10:
                        nr=val; setter=addr; break
                own=owner(cur.address)
                svc_sites.append({
                    'address':int(cur.address),
                    'file_offset':seg['offset'] + int(cur.address) - seg['vaddr'],
                    'syscall_number':nr,
                    'syscall_name':SYSCALLS_AARCH64.get(nr) if nr is not None else None,
                    'x8_setter_address':setter,
                    'owner':own,
                    'context':[insn_text(x) for x in ins[max(0,idx-6):min(len(ins),idx+4)]],
                })
            if cur.mnemonic == 'bl' and cur.operands and cur.operands[0].type == ARM64_OP_IMM:
                target=int(cur.operands[0].imm)
                name=asm_targets.get(target)
                if name:
                    own=owner(cur.address)
                    row={
                        'address':int(cur.address),
                        'file_offset':seg['offset'] + int(cur.address) - seg['vaddr'],
                        'target_address':target,
                        'target_symbol':name,
                        'owner':own,
                        'context':[insn_text(x) for x in ins[max(0,idx-8):min(len(ins),idx+5)]],
                    }
                    direct_calls.append(row)
                    owner_name=own['name'] if own else f"sub_{cur.address:x}"
                    function_calls[owner_name][name].append(int(cur.address))

    # Wrapper snippets by exported asm_* symbol address.
    by_addr={int(i.address):i for i in all_ins}
    ordered_addrs=sorted(by_addr)
    for sym in asm_symbols:
        addr=sym['address']
        i=bisect.bisect_left(ordered_addrs,addr)
        snippet=[]
        for a in ordered_addrs[i:i+12]:
            if a < addr:
                continue
            snippet.append(insn_text(by_addr[a]))
            if by_addr[a].mnemonic in ('ret','br'):
                break
        wrapper_disassembly[sym['name']]={
            'address':addr,
            'size':sym['size'],
            'instructions':snippet,
        }

    candidates=[]
    for func_name,calls in function_calls.items():
        names=set(calls)
        score=sum(LOADER_WEIGHTS.get(n,0) for n in names)
        if score:
            candidates.append({
                'function':func_name,
                'score':score,
                'syscall_wrappers':sorted(names),
                'callsites':{k:v for k,v in sorted(calls.items())},
            })
    candidates.sort(key=lambda x:(-x['score'],-len(x['syscall_wrappers']),x['function']))

    return {
        'name':path.name,
        'sha256':sha256(path),
        'size':path.stat().st_size,
        'machine':machine,
        'entry':int(elf['e_entry']),
        'executable_segments':[{k:v for k,v in s.items() if k!='data'} for s in segments],
        'asm_symbols':asm_symbols,
        'asm_wrapper_disassembly':wrapper_disassembly,
        'direct_asm_calls':direct_calls,
        'svc_sites':svc_sites,
        'loader_candidates':candidates[:100],
    }


def write_md(path: Path, reports:list[dict]):
    lines=['# AppGuard direct-syscall / loader map','',
           'This report disassembles executable PT_LOAD segments directly, so it remains useful when AppGuard has damaged section names/metadata.','']
    for rep in reports:
        lines += [f"## `{rep['name']}`",'']
        if rep.get('skipped'):
            lines += [f"Skipped: {rep['skipped']}",'']
            continue
        lines += [f"- AArch64 `asm_*` wrapper symbols: **{len(rep['asm_symbols'])}**",
                  f"- direct calls resolved to those wrappers: **{len(rep['direct_asm_calls'])}**",
                  f"- raw `svc` instructions: **{len(rep['svc_sites'])}**",'']
        lines += ['### Exported syscall/helper wrappers','', '| Symbol | Address | First instructions |','|---|---:|---|']
        for name,row in sorted(rep['asm_wrapper_disassembly'].items()):
            ins='; '.join(row['instructions'][:5]).replace('|','\\|')
            lines.append(f"| `{name}` | `0x{row['address']:x}` | `{ins}` |")
        lines += ['','### Highest-scoring loader candidates','', '| Score | Function | Wrapper set |','|---:|---|---|']
        for c in rep['loader_candidates'][:30]:
            lines.append(f"| {c['score']} | `{c['function']}` | {', '.join('`'+x+'`' for x in c['syscall_wrappers'])} |")
        lines += ['','### Decoded raw SVC syscalls','', '| Address | Owner | x8 | Syscall |','|---:|---|---:|---|']
        for s in rep['svc_sites'][:100]:
            owner=s['owner']['name'] if s['owner'] else '-'
            nr=s['syscall_number'] if s['syscall_number'] is not None else '-'
            name=s['syscall_name'] or '-'
            lines.append(f"| `0x{s['address']:x}` | `{owner}` | {nr} | `{name}` |")
        lines.append('')
    path.write_text('\n'.join(lines)+'\n',encoding='utf-8')


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--native-dir',required=True,type=Path)
    ap.add_argument('--out',required=True,type=Path)
    args=ap.parse_args()
    names=['libcompatible.so','libstub.so','libcompatible_x86.so','libengine-hlp.so']
    reports=[]
    for name in names:
        p=args.native_dir/name
        if p.exists() and p.read_bytes()[:4] == b'\x7fELF':
            reports.append(analyze(p))
    args.out.mkdir(parents=True,exist_ok=True)
    (args.out/'syscall-map.json').write_text(json.dumps(reports,indent=2,ensure_ascii=False)+'\n',encoding='utf-8')
    write_md(args.out/'syscall-map.md',reports)
    print(json.dumps({r['name']:{'asm_symbols':len(r.get('asm_symbols',[])),'direct_calls':len(r.get('direct_asm_calls',[])),'svc_sites':len(r.get('svc_sites',[])),'loader_candidates':len(r.get('loader_candidates',[]))} for r in reports},indent=2))

if __name__=='__main__':
    main()

#!/usr/bin/env python3
"""Recover the AppGuard callback cluster around libcompatible+0x1eb800.

The JNI wrapper and SoLibraryStart independently dereference BSS slots at
+0x1eb838 and +0x1eb858 through RELATIVE pointer cells.  This pass treats the
whole +/-0x100 region as one runtime table, correlating ELF relocations, static
code xrefs, and writes observed during the real DT_INIT + JNI harness.
"""
from __future__ import annotations
import argparse, importlib.util, json, re, struct
from pathlib import Path
from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from unicorn import UC_HOOK_MEM_WRITE

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-jni-init.py'
spec=importlib.util.spec_from_file_location('jni_init',P)
mod=importlib.util.module_from_spec(spec); assert spec and spec.loader; spec.loader.exec_module(mod)
base=mod.base
LO=0x1EB800; HI=0x1EB900

class Trace(mod.JniInitEmulator):
    def __init__(self,image,out):super().__init__(image,out);self.cluster_writes=[]
    def cluster_write(self,uc,access,address,size,value,user):
        self.cluster_writes.append({'stage':self.stage,'stage_instruction':self.stage_insns,'pc':uc.reg_read(base.UC_ARM64_REG_PC)-base.BIAS,
                                    'address':address-base.BIAS,'size':size,'value':value})
    def snapshot_cluster(self,label):
        vals=[]
        for rva in range(LO,HI,8):
            try:v=struct.unpack('<Q',bytes(self.uc.mem_read(base.BIAS+rva,8)))[0]
            except Exception:v=None
            vals.append({'rva':rva,'value':v})
        return {'label':label,'values':vals}

def static_xrefs(emu,pointer_cells):
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM); pages={}; out=[]
    # First PT_LOAD is executable in this exact sample. Read the loaded image so
    # the two proven XOR transforms are reflected in the scan.
    seg=max(emu.image.loads,key=lambda s:s['filesz']) if False else emu.image.loads[0]
    start=seg['vaddr']; end=start+seg['filesz']
    raw=bytes(emu.uc.mem_read(base.BIAS+start,seg['filesz']))
    for off in range(0,len(raw)-3,4):
        ins=next(iter(md.disasm(raw[off:off+4],start+off)),None)
        if not ins:continue
        if ins.mnemonic=='adrp':
            m=re.fullmatch(r'(x\d+), #0x([0-9a-fA-F]+)',ins.op_str.strip())
            if m:pages[m.group(1)]=(int(m.group(2),16),ins.address)
            continue
        m=re.search(r'\[(x\d+)(?:, #0x([0-9a-fA-F]+))?\]',ins.op_str)
        if not m:continue
        reg=m.group(1); disp=int(m.group(2),16) if m.group(2) else 0
        p=pages.get(reg)
        if not p or ins.address-p[1]>0x40:continue
        addr=p[0]+disp
        if addr in pointer_cells or LO<=addr<HI:
            out.append({'pc':ins.address,'mnemonic':ins.mnemonic,'op_str':ins.op_str,'resolved_address':addr,'adrp_pc':p[1]})
    return out

def render(rep):
    L=['# AppGuard callback BSS cluster','',f'- cluster: `+0x{LO:x}..+0x{HI:x}`',
       f"- RELATIVE pointer cells into cluster: **{len(rep['pointer_cells'])}**",f"- runtime writes observed: **{len(rep['runtime_writes'])}**",'',
       '## Pointer cells -> cluster slots','', '| pointer cell | slot | relocation type |','|---:|---:|---:|']
    for x in rep['pointer_cells']:L.append(f"| `+0x{x['offset']:x}` | `+0x{x['addend']:x}` | {x['type']} |")
    L += ['', '## Static xrefs after proven decryption','', '| PC | instruction | resolved address |','|---:|---|---:|']
    for x in rep['static_xrefs']:L.append(f"| `+0x{x['pc']:x}` | `{x['mnemonic']} {x['op_str']}` | `+0x{x['resolved_address']:x}` |")
    L += ['', '## Runtime writes','', '| stage | insn | PC | address | value | size |','|---|---:|---:|---:|---:|---:|']
    for w in rep['runtime_writes']:L.append(f"| `{w['stage']}` | {w['stage_instruction']} | `+0x{w['pc']:x}` | `+0x{w['address']:x}` | `0x{w['value']:x}` | {w['size']} |")
    for snap in rep['snapshots']:
        L += ['',f"## Snapshot: {snap['label']}",'', '| slot | value |','|---:|---:|']
        for x in snap['values']:
            if x['value'] not in (0,None):L.append(f"| `+0x{x['rva']:x}` | `0x{x['value']:x}` |")
        if all(x['value'] in (0,None) for x in snap['values']):L.append('| - | all zero |')
    return '\n'.join(L)+'\n'

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    image=base.Image(a.libcompatible);e=Trace(image,a.out)
    e.uc.hook_add(UC_HOOK_MEM_WRITE,e.cluster_write,begin=base.BIAS+LO,end=base.BIAS+HI-1)
    boot=e.run_bootstrap();snap_boot=e.snapshot_cluster('after-bootstrap')
    pre=[mod.decrypt_range(e,r) for r in mod.RANGES];jni=e.run_jni();snap_jni=e.snapshot_cluster('after-jni-stop')
    cells=[]
    for r in image.relas():
        if LO<=r['addend']<HI:
            cells.append({'offset':r['offset'],'type':r['type'],'addend':r['addend'],'symbol':r['symbol']})
    cell_set={x['offset'] for x in cells};xrefs=static_xrefs(e,cell_set)
    rep={'cluster':[LO,HI],'pointer_cells':cells,'static_xrefs':xrefs,'runtime_writes':e.cluster_writes,
         'snapshots':[snap_boot,snap_jni],'bootstrap_stop':boot.get('stop'),'jni_stop':jni.get('stop'),'predecrypted_ranges':pre}
    (a.out/'callback-cluster.json').write_text(json.dumps(rep,indent=2)+'\n');(a.out/'callback-cluster.md').write_text(render(rep))
    print(json.dumps({'pointer_cells':[(hex(x['offset']),hex(x['addend'])) for x in cells],
      'xrefs':[(hex(x['pc']),x['mnemonic'],x['op_str'],hex(x['resolved_address'])) for x in xrefs],
      'writes':e.cluster_writes,'nonzero_bootstrap':[(hex(x['rva']),hex(x['value'])) for x in snap_boot['values'] if x['value']],
      'nonzero_jni':[(hex(x['rva']),hex(x['value'])) for x in snap_jni['values'] if x['value']]},indent=2))
if __name__=='__main__':main()

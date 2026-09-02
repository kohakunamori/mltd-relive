#!/usr/bin/env python3
"""Test whether AppGuard descriptor-adjacent code ranges act as repeating XOR keys.

Ground truth from runtime tracing: target 0x4d1d0..0x521fc uses the first 16 bytes
at 0x1712a8 as a repeating XOR key.  This tool verifies that static-file bytes at
0x1712a8 reproduce the full runtime-decrypted target exactly, then tests the
analogous preceding descriptor relationship for 0x1b660..0x4d1d0 using key
source 0x7080c and scores the recovered AArch64, especially +0x1cd84.
"""
from __future__ import annotations

import argparse,hashlib,importlib.util,json
from pathlib import Path
from capstone import Cs,CS_ARCH_ARM64,CS_MODE_ARM

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-dt-init-bionic.py'
spec=importlib.util.spec_from_file_location('bionic_emu',P)
bionic=importlib.util.module_from_spec(spec);assert spec and spec.loader;spec.loader.exec_module(bionic)
base=bionic.base
RUN_LIMIT=9_000_000;base.MAX_INSNS=RUN_LIMIT
KNOWN_KEY_SRC=0x1712A8;KNOWN_START=0x4D1D0;KNOWN_END=0x521FC
TEST_KEY_SRC=0x7080C;TEST_START=0x1B660;TEST_END=0x4D1D0
FAULT=0x1CD84


def xor_repeat(data,key):return bytes(b^key[i%len(key)] for i,b in enumerate(data))

def score(data,start):
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);valid=0;common=0;bad=0;branches=0;rows=[]
    good_prefix=('stp','ldp','ldr','str','ldur','stur','add','sub','mov','movk','movz','adr','adrp','cmp','cmn','and','orr','eor','bic','bl','b','cbz','cbnz','tbz','tbnz','ret','mrs','msr','cset','mul','sxtw','ubfx','lsl','lsr')
    for off in range(0,len(data)-3,4):
        ds=list(md.disasm(data[off:off+4],start+off,count=1))
        if not ds:
            if len(rows)<128:rows.append({'address':start+off,'mnemonic':'.word','op_str':f'0x{int.from_bytes(data[off:off+4],"little"):08x}'})
            continue
        i=ds[0];valid+=1
        if i.mnemonic.startswith(good_prefix):common+=1
        if i.mnemonic in ('udf','svc','hvc','smc','brk','hlt'):bad+=1
        if i.mnemonic.startswith('b') or i.mnemonic in ('cbz','cbnz','tbz','tbnz'):branches+=1
        if len(rows)<128:rows.append({'address':start+off,'mnemonic':i.mnemonic,'op_str':i.op_str})
    words=max(1,len(data)//4)
    return {'words':words,'valid':valid,'valid_ratio':valid/words,'common':common,'common_ratio':common/words,'bad':bad,'branches':branches,'head_instructions':rows}

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    img=base.Image(a.libcompatible)
    raw_known=img.read_file_va(KNOWN_START,KNOWN_END-KNOWN_START);key_known=img.read_file_va(KNOWN_KEY_SRC,16);offline_known=xor_repeat(raw_known,key_known)
    raw_test=img.read_file_va(TEST_START,TEST_END-TEST_START);key_test=img.read_file_va(TEST_KEY_SRC,16);offline_test=xor_repeat(raw_test,key_test)
    em=bionic.BionicEmulator(img,a.out);runtime=em.run_bionic();runtime_known=bytes(em.uc.mem_read(base.BIAS+KNOWN_START,KNOWN_END-KNOWN_START))
    fault_off=FAULT-TEST_START;fault_block=offline_test[max(0,fault_off-0x80):fault_off+0x180];fault_start=TEST_START+max(0,fault_off-0x80)
    rep={
      'runtime_stop':runtime['stop'],'runtime_instructions':runtime['instructions'],
      'known':{'key_source':KNOWN_KEY_SRC,'target_start':KNOWN_START,'target_end':KNOWN_END,'key16':key_known.hex(),'raw_sha256':hashlib.sha256(raw_known).hexdigest(),'offline_sha256':hashlib.sha256(offline_known).hexdigest(),'runtime_sha256':hashlib.sha256(runtime_known).hexdigest(),'offline_matches_runtime':offline_known==runtime_known,'score':score(offline_known[:0x4000],KNOWN_START)},
      'test':{'key_source':TEST_KEY_SRC,'target_start':TEST_START,'target_end':TEST_END,'key16':key_test.hex(),'raw_sha256':hashlib.sha256(raw_test).hexdigest(),'decrypted_sha256':hashlib.sha256(offline_test).hexdigest(),'score_first_0x4000':score(offline_test[:0x4000],TEST_START),'fault_offset':FAULT,'fault_window':score(fault_block,fault_start),'fault_head16':offline_test[fault_off:fault_off+16].hex()},
    }
    (a.out/'range-key-linkage.json').write_text(json.dumps(rep,indent=2)+'\n')
    L=['# AppGuard range-key linkage test','',f"- known static key: `+0x{KNOWN_KEY_SRC:x}` = `{key_known.hex()}`",f"- known offline XOR == runtime decrypted range: **{rep['known']['offline_matches_runtime']}**",f"- known offline SHA: `{rep['known']['offline_sha256']}`",f"- known runtime SHA: `{rep['known']['runtime_sha256']}`",'',f"## Candidate for protected `0x{TEST_START:x}..0x{TEST_END:x}`",'',f"- candidate key source: `+0x{TEST_KEY_SRC:x}`",f"- key16: `{key_test.hex()}`",f"- first 0x4000 valid ratio: **{rep['test']['score_first_0x4000']['valid_ratio']:.4f}**",f"- first 0x4000 common-instruction ratio: **{rep['test']['score_first_0x4000']['common_ratio']:.4f}**",f"- fault `+0x{FAULT:x}` decrypted head: `{rep['test']['fault_head16']}`",f"- fault-window valid ratio: **{rep['test']['fault_window']['valid_ratio']:.4f}**",'',f"### Decrypted window around `+0x{FAULT:x}`",'', '```asm']
    for i in rep['test']['fault_window']['head_instructions']:L.append(f"0x{i['address']:x}: {i['mnemonic']} {i['op_str']}")
    L += ['```','',f"### Decrypted start of `+0x{TEST_START:x}`",'', '```asm']
    for i in rep['test']['score_first_0x4000']['head_instructions'][:96]:L.append(f"0x{i['address']:x}: {i['mnemonic']} {i['op_str']}")
    L += ['```','']
    (a.out/'range-key-linkage.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'known_matches':rep['known']['offline_matches_runtime'],'known_key':key_known.hex(),'test_key':key_test.hex(),'test_score':rep['test']['score_first_0x4000'],'fault_head':rep['test']['fault_head16'],'fault_score':rep['test']['fault_window']},indent=2))
if __name__=='__main__':main()

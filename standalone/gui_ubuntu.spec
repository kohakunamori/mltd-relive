# -*- mode: python ; coding: utf-8 -*-

import shutil
import subprocess


block_cipher = None


def find_runtime_library(soname):
    """Resolve a system shared library so PyInstaller is forced to bundle it."""
    ldconfig = shutil.which('ldconfig') or '/sbin/ldconfig'
    output = subprocess.check_output([ldconfig, '-p'], text=True)
    for line in output.splitlines():
        fields = line.strip().split(' => ', 1)
        if len(fields) != 2:
            continue
        library_name = fields[0].split(' ', 1)[0]
        if library_name == soname:
            return fields[1]
    raise RuntimeError(f'Unable to locate required Ubuntu runtime library: {soname}')


# The GitHub Actions Python distribution exposes _tkinter, but PyInstaller
# 5.x does not reliably collect the system Tcl/Tk shared libraries that
# _tkinter links against.  The resulting one-file executable then crashes on
# clean WSL/Ubuntu installations with "libtk8.6.so: cannot open shared object
# file".  Force these two SONAMEs into the bundle so the Ubuntu artifact is
# actually self-contained with respect to Tk.
tk_runtime_binaries = [
    (find_runtime_library('libtk8.6.so'), '.'),
    (find_runtime_library('libtcl8.6.so'), '.'),
]


a = Analysis(
    ['gui.pyw'],
    pathex=[],
    binaries=tk_runtime_binaries,
    datas=[],
    hiddenimports=[],
    hookspath=['.'],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)
a.datas += Tree('../key', prefix='key', excludes=['*.cmd'])
a.datas += Tree('mltd/locales', prefix='locales', excludes=['*.cmd'])
a.datas += Tree('mltd/models/mst_data', prefix='mst_data')
a.datas += Tree('mltd/models/mst_data/zh', prefix='zh')
a.datas += Tree('mltd/models/mst_data/ko', prefix='ko')
pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='mltd-relive-standalone',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)

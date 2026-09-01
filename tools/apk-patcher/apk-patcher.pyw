import hashlib
import os
import re
import shutil
import struct
import subprocess
import sys
import traceback
import zipfile
from tkinter.filedialog import askopenfilename

import glfw
import imgui
import OpenGL.GL as gl
from imgui.integrations.glfw import GlfwRenderer

apktool_path = ''
zipalign_path = ''
apksigner_path = ''

apk_path = ''
apk_name = ''
ascii_apk_name = ''
original_apk_path = ''
game_language = ''
original_signer_sha256 = ''
original_payload = {}

resolution = 720
frame_rate = 60

EXPECTED_APKTOOL_VERSION = (2, 12, 1)
EXPECTED_CHANGED_ENTRIES = {
    'classes.dex',
    'lib/arm64-v8a/libil2cpp.so',
}


def fonts_path():
    base_path = getattr(sys, '_MEIPASS', os.path.abspath('..'))
    return os.path.join(base_path, 'fonts')


def current_path():
    return getattr(sys, '_MEIPASS', os.path.abspath('.'))


def patched_apk_path():
    return os.path.join(
        ascii_apk_name,
        'dist',
        f'{ascii_apk_name}_{resolution}p_{frame_rate}fps.apk'
    )


def unsigned_apk_path():
    return os.path.join(ascii_apk_name, 'dist', f'{ascii_apk_name}.apk')


def run_command(command, name):
    result = subprocess.run(
        command,
        stdin=subprocess.DEVNULL,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        errors='replace'
    )
    if result.returncode != 0:
        output = (result.stdout or '').strip()
        if len(output) > 12000:
            output = output[-12000:]
        message = f'{name} failed with exit code {result.returncode}'
        if output:
            message += f'\n\n{output}'
        raise RuntimeError(message)
    return result


def parse_apktool_version():
    result = run_command([apktool_path, '--version'], 'apktool version check')
    match = re.search(r'(\d+)\.(\d+)\.(\d+)', result.stdout or '')
    if not match:
        raise RuntimeError(
            'Unable to detect Apktool version.\n'
            'This patcher requires Apktool 2.12.1.'
        )
    return tuple(int(part) for part in match.groups())


def validate_input():
    if not os.path.isfile(apktool_path):
        return 'Invalid apktool Path'
    if not apktool_path.endswith('apktool.bat') and not apktool_path.endswith('apktool'):
        return 'Invalid apktool.bat Path'
    if not os.path.isfile(zipalign_path):
        return 'Invalid zipalign Path'
    if not zipalign_path.endswith('zipalign.exe') and not zipalign_path.endswith('zipalign'):
        return 'Invalid zipalign.exe Path'
    if not os.path.isfile(apksigner_path):
        return 'Invalid apksigner Path'
    if not apksigner_path.endswith('apksigner.bat') and not apksigner_path.endswith('apksigner'):
        return 'Invalid apksigner.bat Path'
    if not os.path.isfile(apk_path) or not apk_path.lower().endswith('.apk'):
        return 'Invalid Game APK Path'
    if not os.path.isfile(os.path.join(current_path(), 'mltd.jks')):
        return 'Bundled signing keystore mltd.jks was not found'

    try:
        version = parse_apktool_version()
    except Exception as exc:
        return str(exc)

    if version != EXPECTED_APKTOOL_VERSION:
        return (
            f'Unsupported Apktool version: {version[0]}.{version[1]}.{version[2]}\n\n'
            'This patcher is pinned to Apktool 2.12.1 to avoid unintended '
            'AndroidManifest/resources.arsc/resource rewrites. Apktool 3.x is '
            'a breaking major release and is not accepted for this legacy APK.'
        )
    return ''


def detect_game_language(apk_filename):
    with zipfile.ZipFile(apk_filename, 'r') as apk:
        manifest = apk.read('AndroidManifest.xml')

    package_prefixes = {
        'ch': 'com.bandainamcoent.imas_millionlive_theaterdays_ch.',
        'kr': 'com.bandainamcoent.imas_millionlive_theaterdays_kr.',
    }
    for lang, prefix in package_prefixes.items():
        if prefix.encode('utf-8') in manifest or prefix.encode('utf-16le') in manifest:
            return lang
    raise RuntimeError('Unrecognized game APK package')


APK_SIG_BLOCK_MAGIC = b'APK Sig Block 42'
APK_SIGNATURE_SCHEME_V2_ID = 0x7109871A


def _read_length_prefixed(data, offset):
    if offset + 4 > len(data):
        raise RuntimeError('Malformed APK v2 signing structure (missing length).')
    length = struct.unpack_from('<I', data, offset)[0]
    start = offset + 4
    end = start + length
    if end > len(data):
        raise RuntimeError('Malformed APK v2 signing structure (length out of range).')
    return data[start:end], end


def _extract_apk_v2_block(apk_filename):
    with open(apk_filename, 'rb') as apk_file:
        apk_file.seek(0, os.SEEK_END)
        file_size = apk_file.tell()
        tail_size = min(file_size, 22 + 65535)
        apk_file.seek(file_size - tail_size)
        tail = apk_file.read(tail_size)

        eocd_offset = tail.rfind(bytes((0x50, 0x4B, 0x05, 0x06)))
        if eocd_offset < 0:
            raise RuntimeError('APK ZIP End of Central Directory was not found.')

        if eocd_offset + 20 > len(tail):
            raise RuntimeError('Malformed APK ZIP End of Central Directory.')

        central_dir_offset = struct.unpack_from(
            '<I', tail, eocd_offset + 16
        )[0]
        if central_dir_offset == 0xFFFFFFFF:
            raise RuntimeError('ZIP64 APKs are not supported by this patcher.')
        if central_dir_offset < 24:
            raise RuntimeError('APK does not contain an APK Signing Block.')

        apk_file.seek(central_dir_offset - 24)
        trailer = apk_file.read(24)
        if len(trailer) != 24 or trailer[8:] != APK_SIG_BLOCK_MAGIC:
            raise RuntimeError(
                'APK Signature Scheme v2 block was not found. '
                'Use the corrected MLTD client from this repository release.'
            )

        block_size = struct.unpack_from('<Q', trailer, 0)[0]
        block_start = central_dir_offset - (block_size + 8)
        if block_start < 0 or block_size < 24:
            raise RuntimeError('Malformed APK Signing Block size.')

        apk_file.seek(block_start)
        first_size_raw = apk_file.read(8)
        if len(first_size_raw) != 8:
            raise RuntimeError('Malformed APK Signing Block header.')
        first_size = struct.unpack('<Q', first_size_raw)[0]
        if first_size != block_size:
            raise RuntimeError('APK Signing Block size fields do not match.')

        pairs = apk_file.read(block_size - 24)

    offset = 0
    while offset < len(pairs):
        if offset + 8 > len(pairs):
            raise RuntimeError('Malformed APK Signing Block entry length.')
        pair_size = struct.unpack_from('<Q', pairs, offset)[0]
        offset += 8
        if pair_size < 4 or offset + pair_size > len(pairs):
            raise RuntimeError('Malformed APK Signing Block entry.')

        pair_id = struct.unpack_from('<I', pairs, offset)[0]
        offset += 4
        value_size = pair_size - 4
        value = pairs[offset:offset + value_size]
        offset += value_size

        if pair_id == APK_SIGNATURE_SCHEME_V2_ID:
            return value

    raise RuntimeError('APK Signature Scheme v2 entry was not found.')


def _extract_v2_signer_certificate_sha256(apk_filename):
    v2_block = _extract_apk_v2_block(apk_filename)

    signers, signers_end = _read_length_prefixed(v2_block, 0)
    if signers_end != len(v2_block):
        raise RuntimeError('Malformed APK v2 signers sequence.')

    signer, _ = _read_length_prefixed(signers, 0)
    signed_data, signer_offset = _read_length_prefixed(signer, 0)
    _, signer_offset = _read_length_prefixed(signer, signer_offset)
    _, signer_offset = _read_length_prefixed(signer, signer_offset)
    if signer_offset != len(signer):
        raise RuntimeError('Malformed APK v2 signer record.')

    # apksigner already performs the full cryptographic/structural verify.
    # For signer identity comparison we only need the certificate sequence,
    # which is the second length-prefixed field in v2 SignedData. Some legacy
    # APKs append reserved/extension bytes after the normal v2 fields.
    _, signed_offset = _read_length_prefixed(signed_data, 0)
    certificates, _ = _read_length_prefixed(signed_data, signed_offset)

    certificate, _ = _read_length_prefixed(certificates, 0)
    if not certificate:
        raise RuntimeError('APK v2 signer certificate is empty.')

    return hashlib.sha256(certificate).hexdigest()


def _has_v1_signature(apk_filename):
    with zipfile.ZipFile(apk_filename, 'r') as apk:
        names = [name.upper() for name in apk.namelist()]

    has_sf = any(
        name.startswith('META-INF/') and name.endswith('.SF')
        for name in names
    )
    has_signature_block = any(
        name.startswith('META-INF/')
        and name.endswith(('.RSA', '.DSA', '.EC'))
        for name in names
    )
    return has_sf and has_signature_block


def extract_signer_sha256(apk_filename, verify=True):
    if verify:
        # Some old Build Tools versions (notably 29.0.3 on Windows)
        # return success here but emit no --print-certs/--verbose text.
        # Treat apksigner's exit code as the cryptographic verdict and
        # read the actual signer certificate from the APK v2 block.
        run_command([
            apksigner_path, 'verify',
            '--min-sdk-version', '19',
            apk_filename
        ], 'apksigner certificate verification')

    return _extract_v2_signer_certificate_sha256(apk_filename)


def payload_snapshot(apk_filename):
    snapshot = {}
    with zipfile.ZipFile(apk_filename, 'r') as apk:
        for info in apk.infolist():
            if info.is_dir() or info.filename.startswith('META-INF/'):
                continue
            data = apk.read(info.filename)
            snapshot[info.filename] = {
                'sha256': hashlib.sha256(data).hexdigest(),
                'compress_type': info.compress_type,
                'size': info.file_size,
            }
    return snapshot


def initialize():
    global apk_path, apk_name, ascii_apk_name, original_apk_path
    global game_language, original_signer_sha256, original_payload

    original_apk_path = apk_path
    game_language = detect_game_language(original_apk_path)
    original_signer_sha256 = extract_signer_sha256(original_apk_path)
    original_payload = payload_snapshot(original_apk_path)

    apk_name = os.path.basename(apk_path).removesuffix('.apk')
    ascii_apk_name = apk_name.replace('劇場時光', '~~MLTD_CH~~')
    ascii_apk_name = ascii_apk_name.replace('밀리언 라이브!', '~~MLTD_KR~~')

    if apk_name != ascii_apk_name:
        ascii_source = os.path.abspath(f'{ascii_apk_name}.apk')
        shutil.copyfile(apk_path, ascii_source)
        apk_path = ascii_source


def apktool_decode():
    # The patch only needs smali + libil2cpp.so. Do not decode resources.
    # This keeps AndroidManifest.xml/resources.arsc/res payloads intact instead
    # of round-tripping them through aapt/aapt2.
    run_command([
        apktool_path, 'd',
        '-f',
        '-r',
        '-o', ascii_apk_name,
        apk_path
    ], 'apktool decode (no resources)')


def apply_patch():
    lang = game_language
    if lang not in ('ch', 'kr'):
        raise RuntimeError('Unrecognized game APK')

    il2cpp_path = os.path.join(
        ascii_apk_name, 'lib', 'arm64-v8a', 'libil2cpp.so'
    )
    with open(il2cpp_path, 'rb') as f:
        il2cpp = bytearray(f.read())

    resolution_addr = 0x01950494 if lang == 'ch' else 0x01947404
    resolution_inst = 0x52800009 | (resolution << 5)
    il2cpp[resolution_addr:resolution_addr+4] = struct.pack('<I', resolution_inst)

    frame_rate_addrs = [
        0x01e35c94,     # OnBeginScene
        0x01e3676c,     # SetupLiveMVSpecialLevel
        0x01e3617c,     # SetupLiveSpecialLevel
        0x01e359ac,     # SetupTheaterSpecialLevel
        0x01e35de4,     # SetupCommuSpecialPlusLevel
        0x01e35f8c      # SetupGashaSpecialPlusLevel
    ]
    if lang == 'kr':
        frame_rate_addrs = [
            0x01e2bbfc,     # OnBeginScene
            0x01e2c6d4,     # SetupLiveMVSpecialLevel
            0x01e2c0e4,     # SetupLiveSpecialLevel
            0x01e2b914,     # SetupTheaterSpecialLevel
            0x01e2bd4c,     # SetupCommuSpecialPlusLevel
            0x01e2bef4      # SetupGashaSpecialPlusLevel
        ]

    frame_rate_inst = 0x52800000 | (frame_rate << 5)
    for frame_rate_addr in frame_rate_addrs:
        il2cpp[frame_rate_addr:frame_rate_addr+4] = struct.pack(
            '<I', frame_rate_inst
        )

    with open(il2cpp_path, 'wb') as f:
        f.write(il2cpp)

    target_smali = os.path.join(
        ascii_apk_name,
        'smali',
        'com',
        'bandainamcoent',
        'imas_millionlive_theaterdays',
        'player',
        'OverrideActivity.smali'
    )
    if not os.path.isfile(target_smali):
        raise RuntimeError(
            'OverrideActivity.smali was not found in the decoded APK. '
            'The APK layout does not match the supported MLTD client.'
        )

    shutil.copyfile(
        os.path.join(
            current_path(),
            'OverrideActivity_device_max_refresh_rate.smali'
        ),
        target_smali
    )


def apktool_build():
    run_command([
        apktool_path, 'b',
        ascii_apk_name
    ], 'apktool build (preserved resources)')


def validate_payload_changes(apk_filename):
    rebuilt = payload_snapshot(apk_filename)

    original_names = set(original_payload)
    rebuilt_names = set(rebuilt)
    if original_names != rebuilt_names:
        missing = sorted(original_names - rebuilt_names)
        added = sorted(rebuilt_names - original_names)
        raise RuntimeError(
            'APK payload entry set changed unexpectedly.\n'
            f'Missing: {missing[:20]}\n'
            f'Added: {added[:20]}'
        )

    changed = set()
    metadata_changed = set()

    for name in original_names:
        before = original_payload[name]
        after = rebuilt[name]

        if before['sha256'] != after['sha256']:
            changed.add(name)

        if before['compress_type'] != after['compress_type']:
            metadata_changed.add(name)

    unexpected = changed - EXPECTED_CHANGED_ENTRIES
    missing_expected = EXPECTED_CHANGED_ENTRIES - changed

    if unexpected:
        raise RuntimeError(
            'Apktool changed files that this patcher must preserve.\n\n'
            'Unexpected content changes:\n' +
            '\n'.join(sorted(unexpected)[:100])
        )

    if missing_expected:
        raise RuntimeError(
            'Expected patch payload did not change:\n' +
            '\n'.join(sorted(missing_expected))
        )

    unexpected_metadata = metadata_changed - EXPECTED_CHANGED_ENTRIES
    if unexpected_metadata:
        raise RuntimeError(
            'Compression metadata changed for preserved APK entries:\n' +
            '\n'.join(sorted(unexpected_metadata)[:100])
        )

    # The patched native library must keep the original compression mode.
    lib_name = 'lib/arm64-v8a/libil2cpp.so'
    if (
        original_payload[lib_name]['compress_type']
        != rebuilt[lib_name]['compress_type']
    ):
        raise RuntimeError(
            'libil2cpp.so compression mode changed unexpectedly.'
        )


def zipalign():
    validate_payload_changes(unsigned_apk_path())

    run_command([
        zipalign_path, '-f', '-v', '4',
        unsigned_apk_path(),
        patched_apk_path()
    ], 'zipalign')

    run_command([
        zipalign_path, '-c', '-v', '4',
        patched_apk_path()
    ], 'zipalign verification')

    # zipalign must not alter uncompressed file contents.
    validate_payload_changes(patched_apk_path())


def apksigner():
    output_apk = patched_apk_path()

    run_command([
        apksigner_path, 'sign',
        '--ks', os.path.join(current_path(), 'mltd.jks'),
        '--ks-type', 'PKCS12',
        '--ks-key-alias', 'bndltool',
        '--ks-pass', 'pass:changeit',
        '--key-pass', 'pass:changeit',
        '--min-sdk-version', '19',
        '--v1-signing-enabled', 'true',
        '--v2-signing-enabled', 'true',
        output_apk
    ], 'apksigner sign')

    run_command([
        apksigner_path, 'verify',
        '--min-sdk-version', '19',
        output_apk
    ], 'apksigner verify')

    if not _has_v1_signature(output_apk):
        raise RuntimeError(
            'Final APK does not contain a v1/JAR signature.'
        )

    # Parsing this block proves that the APK has a structurally valid v2
    # signer record without depending on apksigner's human-readable output.
    final_signer_sha256 = extract_signer_sha256(
        output_apk, verify=False
    )
    if final_signer_sha256 != original_signer_sha256:
        raise RuntimeError(
            'Final APK signer does not match the input APK signer.\n\n'
            f'Input signer SHA-256: {original_signer_sha256}\n'
            f'Output signer SHA-256: {final_signer_sha256}'
        )

    validate_payload_changes(output_apk)


def collect_output():
    output_apk = patched_apk_path()
    if not os.path.isfile(output_apk):
        raise RuntimeError('Patched APK was not produced')

    destination = os.path.abspath(
        f'{apk_name}_{resolution}p_{frame_rate}fps.apk'
    )
    os.replace(output_apk, destination)


def cleanup():
    global apk_path

    if ascii_apk_name and os.path.isdir(os.path.abspath(ascii_apk_name)):
        shutil.rmtree(os.path.abspath(ascii_apk_name))

    if apk_name and apk_name != ascii_apk_name:
        ascii_source = os.path.abspath(f'{ascii_apk_name}.apk')
        if os.path.isfile(ascii_source):
            os.remove(ascii_source)

    if original_apk_path:
        apk_path = original_apk_path


def main():
    global apktool_path, zipalign_path, apksigner_path
    global apk_path
    global resolution, frame_rate

    resolutions = [720, 1080, 1440, 2160]
    selected_resolution = 0
    custom_resolution_flag = False
    custom_resolution_text = '720'
    frame_rates = [60, 90, 120, 144, 165, 240]
    selected_frame_rate = 0
    custom_frame_rate_flag = False
    custom_frame_rate_text = '60'

    is_patching = False
    skip_frames = 0
    error_message = ''

    apktool_search_paths = ['C:\\Windows', '/usr/local/bin']
    for p in apktool_search_paths:
        if os.path.isfile(os.path.join(p, 'apktool.bat')):
            apktool_path = os.path.abspath(os.path.join(p, 'apktool.bat'))
        elif os.path.isfile(os.path.join(p, 'apktool')):
            apktool_path = os.path.abspath(os.path.join(p, 'apktool'))

    imgui.create_context()
    window = impl_glfw_init()
    impl = GlfwRenderer(window)

    io = impl.io
    io.fonts.clear()
    io.fonts.add_font_from_file_ttf(
        os.path.join(fonts_path(), 'Roboto-Medium.ttf'), 24,
        io.fonts.get_glyph_ranges_latin()
    )
    tc_font = io.fonts.add_font_from_file_ttf(
        os.path.join(fonts_path(), 'NotoSansTC-Medium.otf'), 24,
        io.fonts.get_glyph_ranges_chinese_full()
    )
    kr_font = io.fonts.add_font_from_file_ttf(
        os.path.join(fonts_path(), 'NotoSansKR-Medium.ttf'), 24,
        io.fonts.get_glyph_ranges_korean()
    )
    impl.refresh_font_texture()

    while not glfw.window_should_close(window):
        glfw.poll_events()
        impl.process_inputs()

        imgui.new_frame()

        imgui.set_next_window_position(0, 0)
        imgui.set_next_window_size(io.display_size.x, io.display_size.y)
        imgui.begin(
            '',
            flags=imgui.WINDOW_NO_TITLE_BAR | imgui.WINDOW_NO_RESIZE
        )

        imgui.text('apktool.bat Path (requires Apktool 2.12.1):')
        if not apktool_path.endswith('apktool.bat') and not apktool_path.endswith('apktool'):
            imgui.push_style_color(
                imgui.COLOR_FRAME_BACKGROUND, 0.5, 0.0, 0.0
            )
        _, apktool_path = imgui.input_text(
            '##apktool', apktool_path, 1024,
            flags=imgui.INPUT_TEXT_READ_ONLY
        )
        if not apktool_path.endswith('apktool.bat') and not apktool_path.endswith('apktool'):
            imgui.pop_style_color(1)
        imgui.same_line()
        if imgui.button('Browse apktool.bat...'):
            new_path = askopenfilename(
                filetypes=[('apktool', 'apktool.bat apktool')]
            )
            if new_path:
                apktool_path = os.path.abspath(new_path)

        imgui.text('zipalign.exe Path:')
        if not zipalign_path.endswith('zipalign.exe') and not zipalign_path.endswith('zipalign'):
            imgui.push_style_color(
                imgui.COLOR_FRAME_BACKGROUND, 0.5, 0.0, 0.0
            )
        _, zipalign_path = imgui.input_text(
            '##zipalign', zipalign_path, 1024,
            flags=imgui.INPUT_TEXT_READ_ONLY
        )
        if not zipalign_path.endswith('zipalign.exe') and not zipalign_path.endswith('zipalign'):
            imgui.pop_style_color(1)
        imgui.same_line()
        if imgui.button('Browse zipalign.exe...'):
            new_path = askopenfilename(
                filetypes=[('zipalign', 'zipalign.exe zipalign')]
            )
            if new_path:
                zipalign_path = os.path.abspath(new_path)
                if (
                    not apksigner_path.endswith('apksigner.bat')
                    and not apksigner_path.endswith('apksigner')
                ):
                    zipalign_dir = os.path.dirname(zipalign_path)
                    if os.path.isfile(
                        os.path.join(zipalign_dir, 'apksigner.bat')
                    ):
                        apksigner_path = os.path.abspath(
                            os.path.join(zipalign_dir, 'apksigner.bat')
                        )
                    elif os.path.isfile(
                        os.path.join(zipalign_dir, 'apksigner')
                    ):
                        apksigner_path = os.path.abspath(
                            os.path.join(zipalign_dir, 'apksigner')
                        )

        imgui.text('apksigner.bat Path:')
        if not apksigner_path.endswith('apksigner.bat') and not apksigner_path.endswith('apksigner'):
            imgui.push_style_color(
                imgui.COLOR_FRAME_BACKGROUND, 0.5, 0.0, 0.0
            )
        _, apksigner_path = imgui.input_text(
            '##apksigner', apksigner_path, 1024,
            flags=imgui.INPUT_TEXT_READ_ONLY
        )
        if not apksigner_path.endswith('apksigner.bat') and not apksigner_path.endswith('apksigner'):
            imgui.pop_style_color(1)
        imgui.same_line()
        if imgui.button('Browse apksigner.bat...'):
            new_path = askopenfilename(
                filetypes=[('apksigner', 'apksigner.bat apksigner')]
            )
            if new_path:
                apksigner_path = os.path.abspath(new_path)
                if (
                    not zipalign_path.endswith('zipalign.exe')
                    and not zipalign_path.endswith('zipalign')
                ):
                    apksigner_dir = os.path.dirname(apksigner_path)
                    if os.path.isfile(
                        os.path.join(apksigner_dir, 'zipalign.exe')
                    ):
                        zipalign_path = os.path.abspath(
                            os.path.join(apksigner_dir, 'zipalign.exe')
                        )
                    elif os.path.isfile(
                        os.path.join(apksigner_dir, 'zipalign')
                    ):
                        zipalign_path = os.path.abspath(
                            os.path.join(apksigner_dir, 'zipalign')
                        )

        imgui.text('Game APK Path:')
        if not apk_path.endswith('.apk'):
            imgui.push_style_color(
                imgui.COLOR_FRAME_BACKGROUND, 0.5, 0.0, 0.0
            )
        if '劇場時光' in apk_path:
            imgui.push_font(tc_font)
        elif '밀리언 라이브!' in apk_path:
            imgui.push_font(kr_font)
        _, apk_path = imgui.input_text(
            '##apk', apk_path, 1024,
            flags=imgui.INPUT_TEXT_READ_ONLY
        )
        if '劇場時光' in apk_path or '밀리언 라이브!' in apk_path:
            imgui.pop_font()
        if not apk_path.endswith('.apk'):
            imgui.pop_style_color(1)
        imgui.same_line()
        if imgui.button('Browse .apk...'):
            new_path = askopenfilename(
                filetypes=[('Android Package', '*.apk')]
            )
            if new_path:
                apk_path = os.path.abspath(new_path)

        imgui.text('Resolution:')
        imgui.columns(2, border=False)
        if not custom_resolution_flag:
            _, selected_resolution = imgui.slider_int(
                '##resolution', selected_resolution,
                min_value=0, max_value=len(resolutions)-1,
                format=''
            )
            resolution = resolutions[selected_resolution]
        else:
            _, custom_resolution_text = imgui.input_text(
                '##custom_res', custom_resolution_text, 5,
                flags=imgui.INPUT_TEXT_CHARS_DECIMAL
            )
            try:
                resolution = int(custom_resolution_text)
            except ValueError:
                resolution = 720
            if resolution < 240:
                resolution = 240
        imgui.same_line()
        imgui.text(f'{resolution}p')
        imgui.next_column()
        _, custom_resolution_flag = imgui.checkbox(
            'Custom Resolution', custom_resolution_flag
        )
        imgui.columns(1)

        imgui.text('Frame Rate:')
        imgui.columns(2, border=False)
        if not custom_frame_rate_flag:
            _, selected_frame_rate = imgui.slider_int(
                '##frame_rate', selected_frame_rate,
                min_value=0, max_value=len(frame_rates)-1,
                format=''
            )
            frame_rate = frame_rates[selected_frame_rate]
        else:
            _, custom_frame_rate_text = imgui.input_text(
                '##custom_fps', custom_frame_rate_text, 4,
                flags=imgui.INPUT_TEXT_CHARS_DECIMAL
            )
            try:
                frame_rate = int(custom_frame_rate_text)
            except ValueError:
                frame_rate = 60
            if frame_rate < 24:
                frame_rate = 24
        imgui.same_line()
        imgui.text(f'{frame_rate}fps')
        imgui.next_column()
        _, custom_frame_rate_flag = imgui.checkbox(
            'Custom Frame Rate', custom_frame_rate_flag
        )
        imgui.columns(1)

        imgui.text('')

        if imgui.button('Patch', width=imgui.get_window_size()[0]):
            error_message = validate_input()
            if not error_message:
                is_patching = True
                skip_frames = 2

        if is_patching:
            imgui.open_popup('Patching')
        if imgui.begin_popup_modal(
            'Patching',
            flags=imgui.WINDOW_NO_RESIZE
        )[0]:
            imgui.text('Please wait...')
            if not is_patching:
                imgui.close_current_popup()
            imgui.end_popup()

        if error_message:
            imgui.open_popup('Error')
            imgui.set_next_window_size(
                io.display_size.x-10,
                io.display_size.y*2/3
            )
        if imgui.begin_popup_modal(
            'Error',
            flags=imgui.WINDOW_NO_RESIZE
        )[0]:
            imgui.text(error_message)
            if imgui.button('Close'):
                error_message = ''
                imgui.close_current_popup()
            imgui.end_popup()

        imgui.end()

        gl.glClearColor(1., 1., 1., 1)
        gl.glClear(gl.GL_COLOR_BUFFER_BIT)

        imgui.render()
        impl.render(imgui.get_draw_data())
        glfw.swap_buffers(window)

        if is_patching:
            if skip_frames > 0:
                # Skip some frames to show popup first before patching
                skip_frames -= 1
            else:
                try:
                    initialize()
                    apktool_decode()
                    apply_patch()
                    apktool_build()
                    zipalign()
                    apksigner()
                    collect_output()
                except Exception:
                    error_message = traceback.format_exc()
                finally:
                    cleanup()
                    is_patching = False

    impl.shutdown()
    glfw.terminate()


def impl_glfw_init():
    width, height = 800, 450
    window_name = "APK Patcher for MLTD"

    if not glfw.init():
        print("Could not initialize OpenGL context")
        exit(1)

    # OS X supports only forward-compatible core profiles from 3.2
    glfw.window_hint(glfw.CONTEXT_VERSION_MAJOR, 3)
    glfw.window_hint(glfw.CONTEXT_VERSION_MINOR, 3)
    glfw.window_hint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

    glfw.window_hint(glfw.OPENGL_FORWARD_COMPAT, gl.GL_TRUE)

    # Create a windowed mode window and its OpenGL context
    window = glfw.create_window(
        int(width), int(height), window_name, None, None
    )
    glfw.make_context_current(window)

    if not window:
        glfw.terminate()
        print("Could not initialize Window")
        exit(1)

    return window


if __name__ == "__main__":
    main()

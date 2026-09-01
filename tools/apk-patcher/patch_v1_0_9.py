from pathlib import Path

path = Path("tools/apk-patcher/apk-patcher.pyw")
text = path.read_text(encoding="utf-8")

marker = "def parse_apktool_version():\n"
helper = '''def apksigner_base_command():
    # Android Build Tools 29.0.3's Windows apksigner.bat can silently exit
    # without signing when the SDK's tools/lib/find_java.bat is missing.
    # Bypass the wrapper and invoke its real apksigner.jar directly.
    if apksigner_path.lower().endswith('.bat'):
        apksigner_jar = os.path.join(
            os.path.dirname(apksigner_path), 'lib', 'apksigner.jar'
        )
        if not os.path.isfile(apksigner_jar):
            raise RuntimeError(
                'apksigner.jar was not found next to apksigner.bat.\\n\\n'
                'Expected: ' + apksigner_jar + '\\n\\n'
                'Repair/reinstall Android SDK Build Tools or select a complete '
                'Build Tools installation.'
            )
        java_path = shutil.which('java.exe') or shutil.which('java')
        if not java_path:
            raise RuntimeError(
                'Java was not found in PATH. Java is required to execute '
                'apksigner.jar directly.'
            )
        return [java_path, '-jar', apksigner_jar]
    return [apksigner_path]


def run_apksigner(arguments, name):
    return run_command(apksigner_base_command() + list(arguments), name)


def validate_apksigner_verification_output(output):
    text = (output or '').strip()
    if not text:
        raise RuntimeError(
            'apksigner verification produced no output. Refusing to emit an APK '
            'because the signing tool may not have executed.'
        )

    v1 = re.search(
        r'Verified using v1 scheme \\(JAR signing\\):\\s*(true|false)',
        text, re.IGNORECASE
    )
    v2 = re.search(
        r'Verified using v2 scheme \\(APK Signature Scheme v2\\):\\s*(true|false)',
        text, re.IGNORECASE
    )
    signers = re.search(r'Number of signers:\\s*(\\d+)', text, re.IGNORECASE)

    if not v1 or v1.group(1).lower() != 'true':
        raise RuntimeError(
            'Final APK did not verify with the v1/JAR signature scheme.\\n\\n' + text
        )
    if not v2 or v2.group(1).lower() != 'true':
        raise RuntimeError(
            'Final APK did not verify with APK Signature Scheme v2.\\n\\n' + text
        )
    if not signers or int(signers.group(1)) < 1:
        raise RuntimeError(
            'apksigner reported no APK signers.\\n\\n' + text
        )


'''
if "def apksigner_base_command():" not in text:
    text = text.replace(marker, helper + marker, 1)

old_validate = (
    "    if not os.path.isfile(apksigner_path):\n"
    "        return 'Invalid apksigner Path'\n"
    "    if not apksigner_path.endswith('apksigner.bat') and not apksigner_path.endswith('apksigner'):\n"
    "        return 'Invalid apksigner.bat Path'\n"
    "    if not os.path.isfile(apk_path) or not apk_path.lower().endswith('.apk'):\n"
)
new_validate = (
    "    if not os.path.isfile(apksigner_path):\n"
    "        return 'Invalid apksigner Path'\n"
    "    if not apksigner_path.endswith('apksigner.bat') and not apksigner_path.endswith('apksigner'):\n"
    "        return 'Invalid apksigner.bat Path'\n"
    "    try:\n"
    "        signer_probe = run_command(\n"
    "            apksigner_base_command() + ['version'],\n"
    "            'apksigner direct backend check'\n"
    "        )\n"
    "        if not (signer_probe.stdout or '').strip():\n"
    "            return 'apksigner direct backend produced no output'\n"
    "    except Exception as exc:\n"
    "        return str(exc)\n"
    "    if not os.path.isfile(apk_path) or not apk_path.lower().endswith('.apk'):\n"
)
if old_validate not in text:
    raise SystemExit("validate_input apksigner block not found")
text = text.replace(old_validate, new_validate, 1)

old_extract = (
    "def extract_signer_sha256(apk_filename, verify=True):\n"
    "    if verify:\n"
    "        # Some old Build Tools versions (notably 29.0.3 on Windows)\n"
    "        # return success here but emit no --print-certs/--verbose text.\n"
    "        # Treat apksigner's exit code as the cryptographic verdict and\n"
    "        # read the actual signer certificate from the APK v2 block.\n"
    "        run_command([\n"
    "            apksigner_path, 'verify',\n"
    "            '--min-sdk-version', '19',\n"
    "            apk_filename\n"
    "        ], 'apksigner certificate verification')\n"
    "\n"
    "    return _extract_v2_signer_certificate_sha256(apk_filename)\n"
)
new_extract = (
    "def extract_signer_sha256(apk_filename, verify=True):\n"
    "    if verify:\n"
    "        result = run_apksigner([\n"
    "            'verify',\n"
    "            '--verbose',\n"
    "            '--print-certs',\n"
    "            '--min-sdk-version', '19',\n"
    "            apk_filename\n"
    "        ], 'apksigner certificate verification')\n"
    "        validate_apksigner_verification_output(result.stdout)\n"
    "\n"
    "    return _extract_v2_signer_certificate_sha256(apk_filename)\n"
)
if old_extract not in text:
    raise SystemExit("extract_signer_sha256 block not found")
text = text.replace(old_extract, new_extract, 1)

start = text.index("def apksigner():\n")
end = text.index("\n\ndef collect_output():", start)
new_signer = '''def apksigner():
    output_apk = patched_apk_path()

    run_apksigner([
        'sign',
        '--ks', os.path.join(current_path(), 'mltd.jks'),
        '--ks-type', 'PKCS12',
        '--ks-key-alias', 'bndltool',
        '--ks-pass', 'pass:changeit',
        '--key-pass', 'pass:changeit',
        '--min-sdk-version', '19',
        '--v1-signing-enabled', 'true',
        '--v2-signing-enabled', 'true',
        output_apk
    ], 'apksigner sign (direct JAR backend)')

    verify_result = run_apksigner([
        'verify',
        '--verbose',
        '--print-certs',
        '--min-sdk-version', '19',
        output_apk
    ], 'apksigner verify (direct JAR backend)')
    validate_apksigner_verification_output(verify_result.stdout)

    # v2 is mandatory. Compare the actual certificate embedded in the
    # generated APK against the original corrected client's signer.
    final_signer_sha256 = extract_signer_sha256(output_apk, verify=False)
    if final_signer_sha256 != original_signer_sha256:
        raise RuntimeError(
            'Final APK signer does not match the input APK signer.\\n\\n'
            f'Input signer SHA-256: {original_signer_sha256}\\n'
            f'Output signer SHA-256: {final_signer_sha256}'
        )

    validate_payload_changes(output_apk)
'''
text = text[:start] + new_signer + text[end:]

path.write_text(text, encoding="utf-8")
Path("tools/apk-patcher/VERSION").write_text("1.0.9\n", encoding="utf-8")

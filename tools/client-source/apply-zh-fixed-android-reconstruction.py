#!/usr/bin/env python3
"""Apply the recovered Android-layer zh-fixed transformation to an apktool tree.

This reconstructs the Android shell only. It intentionally does NOT pretend to
rederive AppGuard's native/metadata deprotection. The caller must separately
supply a deprotected libil2cpp.so and global-metadata.dat matching the hashes in
client/reconstruction/reconstruction-spec.yml before a final zh-fixed-equivalent
APK can be produced.
"""
from __future__ import annotations

import argparse
import shutil
import xml.etree.ElementTree as ET
from pathlib import Path

import yaml

ANDROID = "http://schemas.android.com/apk/res/android"
A = f"{{{ANDROID}}}"
ET.register_namespace("android", ANDROID)


def fail(msg: str) -> None:
    raise SystemExit(msg)


def find_child_with_android_name(parent: ET.Element, tag: str, name: str):
    for elem in parent.findall(tag):
        if elem.get(A + "name") == name:
            return elem
    return None


def remove_named(parent: ET.Element, tag: str, names: set[str]) -> int:
    count = 0
    for elem in list(parent.findall(tag)):
        if elem.get(A + "name") in names:
            parent.remove(elem)
            count += 1
    return count


def set_metadata(application: ET.Element, name: str, value: str) -> None:
    elem = find_child_with_android_name(application, "meta-data", name)
    if elem is None:
        elem = ET.SubElement(application, "meta-data")
        elem.set(A + "name", name)
    elem.attrib.pop(A + "resource", None)
    elem.set(A + "value", value)


def rewrite_manifest(tree_root: Path, spec: dict) -> dict:
    path = tree_root / "AndroidManifest.xml"
    if not path.exists():
        fail(f"missing apktool manifest: {path}")
    doc = ET.parse(path)
    root = doc.getroot()
    app = root.find("application")
    if app is None:
        fail("manifest has no <application>")

    old_pkg = spec["package_rename"]["from"]
    new_pkg = spec["package_rename"]["to"]
    if root.get("package") not in (old_pkg, new_pkg):
        fail(f"unexpected manifest package: {root.get('package')}")
    root.set("package", new_pkg)

    # AppGuard front application and split-only flags disappear in the fixed standalone APK.
    if app.get(A + "name") == spec.get("remove_application_name"):
        app.attrib.pop(A + "name", None)
    app.attrib.pop(A + "isSplitRequired", None)
    app.attrib.pop(A + "extractNativeLibs", None)

    remove_permissions = set(spec.get("remove_permissions", []))
    removed_permission_defs = remove_named(root, "permission", remove_permissions)
    removed_permission_uses = remove_named(root, "uses-permission", remove_permissions)

    authority_map = {
        row["from"]: row["to"] for row in spec.get("provider_authority_renames", [])
    }
    authority_updates = 0
    for provider in app.findall("provider"):
        value = provider.get(A + "authorities")
        if value in authority_map:
            provider.set(A + "authorities", authority_map[value])
            authority_updates += 1

    components = spec.get("remove_components", {})
    removed_activities = remove_named(app, "activity", set(components.get("activities", [])))
    removed_services = remove_named(app, "service", set(components.get("services", [])))
    removed_meta = remove_named(app, "meta-data", set(spec.get("remove_metadata", [])))

    # A standalone fused APK no longer requires Play split installation.
    vending_required = find_child_with_android_name(app, "meta-data", "com.android.vending.splits.required")
    if vending_required is not None:
        app.remove(vending_required)
    set_metadata(app, "com.android.dynamic.apk.fused.modules", spec["standalone_metadata"]["com.android.dynamic.apk.fused.modules"])
    set_metadata(app, "com.android.stamp.type", spec["standalone_metadata"]["com.android.stamp.type"])
    set_metadata(app, "com.android.vending.derived.apk.id", spec["standalone_metadata"]["com.android.vending.derived.apk.id"])

    doc.write(path, encoding="utf-8", xml_declaration=True)
    return {
        "package": new_pkg,
        "removed_permission_defs": removed_permission_defs,
        "removed_permission_uses": removed_permission_uses,
        "provider_authority_updates": authority_updates,
        "removed_activities": removed_activities,
        "removed_services": removed_services,
        "removed_appguard_metadata": removed_meta,
    }


def rewrite_strings(tree_root: Path, spec: dict) -> bool:
    path = tree_root / "res" / "values" / "strings.xml"
    if not path.exists():
        fail(f"missing strings.xml: {path}")
    doc = ET.parse(path)
    root = doc.getroot()
    old = spec["app_name"]["from"]
    new = spec["app_name"]["to"]
    for elem in root.findall("string"):
        if elem.get("name") == "app_name":
            if elem.text not in (old, new):
                fail(f"unexpected app_name: {elem.text!r}")
            elem.text = new
            doc.write(path, encoding="utf-8", xml_declaration=True)
            return True
    fail("app_name string not found")


def rewrite_smali(tree_root: Path, reconstruction_root: Path, spec: dict) -> dict:
    removed = []
    missing = []
    for rel in spec.get("remove_smali", []):
        p = tree_root / rel
        if p.exists():
            p.unlink()
            removed.append(rel)
        else:
            missing.append(rel)

    replaced = []
    for target_rel, source_rel in spec.get("replace_smali", {}).items():
        src = reconstruction_root / source_rel
        dst = tree_root / target_rel
        if not src.exists():
            fail(f"missing reconstructed smali source: {src}")
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(src, dst)
        replaced.append(target_rel)
    return {"removed": removed, "already_missing": missing, "replaced": replaced}


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("apktool_tree", type=Path)
    ap.add_argument(
        "--reconstruction-root",
        type=Path,
        default=Path("client/reconstruction"),
        help="directory containing reconstruction-spec.yml and fixed-smali/",
    )
    args = ap.parse_args()

    tree = args.apktool_tree.resolve()
    recon = args.reconstruction_root.resolve()
    spec_path = recon / "reconstruction-spec.yml"
    if not spec_path.exists():
        fail(f"missing spec: {spec_path}")
    doc = yaml.safe_load(spec_path.read_text(encoding="utf-8"))
    android = doc["android"]

    manifest = rewrite_manifest(tree, android)
    strings = rewrite_strings(tree, android)
    smali = rewrite_smali(tree, recon, android)

    print("Android zh-fixed reconstruction applied")
    print(f"  package: {manifest['package']}")
    print(f"  provider authorities rewritten: {manifest['provider_authority_updates']}")
    print(f"  AppGuard metadata removed: {manifest['removed_appguard_metadata']}")
    print(f"  smali removed: {len(smali['removed'])} (already absent: {len(smali['already_missing'])})")
    print(f"  smali replaced: {len(smali['replaced'])}")
    print("  app_name changed: yes" if strings else "  app_name changed: no")
    print("Native deprotection is a separate unresolved stage; see reconstruction-spec.yml.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

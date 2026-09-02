MLTD zh-fixed client extraction

apktool/  Exact Dalvik/smali-oriented maintenance view plus decoded resources.
          Treat this as the authoritative editable Android-layer representation.

jadx/     Java-like readability view. This is decompiler output, not a guaranteed
          compilable Gradle project and not authoritative for byte-level patches.

raw-critical/
          Exact binary AndroidManifest.xml/resources.arsc copied from the APK.

report/   Tool versions, APK structure, hashes, network-string hits, IL2CPP ELF
          metadata and rebuild/decompiler logs.

rebuild-check/
          Unsigned apktool rebuild when apktool can rebuild the decoded tree.

Important: MLTD is a Unity IL2CPP title. Most gameplay logic is native in
libil2cpp.so with global-metadata.dat; Java/JADX source alone is only the Android
shell. Future native modifications should be expressed as verified, named patch
points instead of treating JADX output as the game source of truth.

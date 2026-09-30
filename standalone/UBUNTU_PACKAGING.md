# Ubuntu standalone Tk runtime

Build with Python 3.11 and the pinned root `requirements.txt`, from this
`standalone` directory: `pyinstaller gui_ubuntu.spec`.
The build host must have Ubuntu packages `libtk8.6` and `libtcl8.6`, including
`/usr/share/doc/<package>/copyright`. Missing libraries or missing/empty
copyright files fail the build.

The spec preserves the existing GUI and CI build metadata. It explicitly
bundles `libtk8.6.so` and `libtcl8.6.so`, and generates a complete Tcl/Tk notice
from the installed packages' copyright files without altering their bytes.
This retains the applicable notices for the versions actually being bundled,
including the packages' additional copyright and licensing sections.
The project's own `LICENSE` is unchanged.

Both outputs must be retained when distributing a build:

- `dist/mltd-relive-standalone`
- `dist/mltd-relive-standalone-ubuntu-NOTICES.txt`

The identical notice is also embedded in the executable under
`licenses/mltd-relive-standalone-ubuntu-NOTICES.txt`. The rolling release
workflow uploads the readable notice alongside the Ubuntu executable.

Pull requests that change Ubuntu packaging, GUI code or dependencies run the
Ubuntu packaging check automatically. The `ubuntu_gui` input also enables it
for manual validation. Main-branch publishing verifies the actual release
artifact instead of building it twice. It verifies the bundled libraries, compares the
embedded notice with the sidecar and both original package notices, and runs
the executable under Xvfb from a fresh temporary directory. It does not load a
user database or start a configured server. Only timeout status 124 is accepted;
early exit (including status 0) and Python/Tk startup errors fail the check.
The shell policy fixtures are separate from that real executable smoke test.

Run focused tests from the repository root:

```sh
python -m unittest discover -s tests -p 'test_ubuntu_standalone_packaging.py' -v
bash tools/smoke-test-ubuntu-gui.sh standalone/dist/mltd-relive-standalone
```

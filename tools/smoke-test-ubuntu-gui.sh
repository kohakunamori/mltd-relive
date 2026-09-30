#!/usr/bin/env bash
# Run from a fresh directory so an existing database cannot start servers.
set -euo pipefail

executable="$(realpath "${1:?Usage: smoke-test-ubuntu-gui.sh EXECUTABLE}")"
smoke_dir="$(mktemp -d)"
trap 'rm -rf -- "$smoke_dir"' EXIT
cd "$smoke_dir"

status=0
timeout --kill-after=5s 8s xvfb-run -a "$executable" > gui.log 2>&1 || status=$?
cat gui.log

# Nothing closes the window in this test. Even an early successful exit is
# a regression; only a GUI that stays alive until timeout is acceptable.
if [[ "$status" -ne 124 ]]; then
    echo "GUI exited before the smoke-test deadline (status $status)." >&2
    exit 1
fi

if grep -Eq 'Traceback \(most recent call last\)|ImportError:|ModuleNotFoundError:|_tkinter.TclError:' gui.log; then
    echo 'Ubuntu standalone reported a startup error.' >&2
    exit 1
fi

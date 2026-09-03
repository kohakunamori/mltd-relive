"""Build metadata injected by CI for packaged Standalone releases."""

# Source checkouts intentionally leave this unset. The rolling Release build
# rewrites this file immediately before PyInstaller runs.
BUILD_COMMIT = None

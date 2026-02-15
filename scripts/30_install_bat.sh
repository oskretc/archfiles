#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

pkg_install bat

# On Debian, the binary is installed as 'batcat' due to a name conflict.
# Create a symlink so 'bat' works everywhere.
if [ "$DISTRO" = "debian" ]; then
    ensure_symlink "batcat" "bat"
fi

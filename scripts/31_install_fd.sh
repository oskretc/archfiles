#!/bin/sh
. "${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/lib/distro.sh"

pkg_install fd

# On Debian, the binary is installed as 'fdfind' due to a name conflict.
# Create a symlink so 'fd' works everywhere.
if [ "$DISTRO" = "debian" ]; then
    ensure_symlink "fdfind" "fd"
fi

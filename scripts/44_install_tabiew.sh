#!/bin/sh
GITHUB_REPO=https://github.com/shshemi/tabiew/
if command -v pacman >/dev/null 2>&1; then
  echo "pacman detected"
  dra download -a -i -o ~/.local/bin/tw ${GITHUB_REPO}
elif command -v apt >/dev/null 2>&1; then
  echo "apt detected"
  dra download --select 'tabiew-x86_64*.deb' --install ${GITHUB_REPO}
else
  echo "package manager not detected"
fi

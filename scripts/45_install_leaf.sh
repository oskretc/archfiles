#!/bin/sh
GITHUB_REPO=https://github.com/RivoLink/leaf
if command -v pacman >/dev/null 2>&1; then
  echo "pacman detected"
  dra download -a -i -o ~/.local/bin/leaf ${GITHUB_REPO}
elif command -v apt >/dev/null 2>&1; then
  echo "apt detected"
  dra download -a -i -o ~/.local/bin/leaf ${GITHUB_REPO}
else
  echo "package manager not detected"
fi

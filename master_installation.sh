#!/bin/sh

# Source the distro detection library
. "$(cd "$(dirname "$0")" && pwd)/lib/distro.sh"

# Refresh package database once before running all scripts
pkg_update

# Run all installation scripts
./execute_scripts.sh ./scripts

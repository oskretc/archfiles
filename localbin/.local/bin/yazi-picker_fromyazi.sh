#!/usr/bin/env bash

paths=("$@")
# Ensure paths with special chars (like spaces) are properly escaped
escaped_paths=()
for path in "${paths[@]}"; do
  escaped_paths+=("$(printf "%q" "$path")")
done
path=${escaped_paths[0]}

# Focus editor pane, must be the next pane after yazi
zellij action focus-next-pane

# If we're trying to open a single path and it's a directory, change the working dir to it in our
# editor. This ensures any other commands in our editor (such as :open, :mv, etc) have the correct
# cwd set.
if [ ! -f "${path}" ] && [ ${#escaped_paths[@]} -eq 1 ]; then
  cdCommand="cd"
	zellij action write 27 # send <Escape> key to enter NORMAL mode
	zellij action write-chars ":${cdCommand} ${path}"
	zellij action write 13 # send <Enter> key

	# The longer the path string, the longer we need to wait so that zellij has time to write out
	# the path before moving on. Through some trial and error, I found that dividing the length by
	# 150 gives it sufficient time to get through it. Calculating this based on string length vs
	# a static value makes sure we don't end up with a long wait time for short paths that don't
	# need to wait as long.
	sleep $(echo "${#path} / 150" | bc -l)
fi

# Open paths in the editor
if [[ -n "${escaped_paths}" ]]; then
	zellij action write 27 # send <Escape> key to enter NORMAL mode
	zellij action write-chars ":o ${escaped_paths[*]}"
	zellij action write 13 # send <Enter> key
fi

#!/usr/bin/env bash
  zellij action focus-next-pane
	zellij action send-keys "Ctrl L" # send <Escape> key to enter NORMAL mode
	zellij action write-chars "$1"
	zellij action send-keys "Enter" # send <Enter> key
  zellij action focus-previous-pane

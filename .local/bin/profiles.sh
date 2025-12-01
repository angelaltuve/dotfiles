#!/bin/bash

CATEGORIES=(
  "Normal"
  "Study without YouTube"
  "Study with YouTube"
)

selected=$(printf "%s\n" "${CATEGORIES[@]}" | dmenu -p "Select category:")
[ -z "$selected" ] && exit 0

case "$selected" in
"Normal")
  sudo hblock
  ;;
"Study without YouTube")
  hblock -D "$HOME/.config/hblock/deny_intensive_study.list"
  ;;
"Study with YouTube")
  hblock -D "$HOME/.config/hblock/deny_intensive.list"
  ;;
esac

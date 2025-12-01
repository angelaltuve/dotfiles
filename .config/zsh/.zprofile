#!/usr/bin/env zsh

: "${XDG_DATA_HOME:=$HOME/.local/share}"
local xorg_dir="${XDG_DATA_HOME}/xorg"
local xorg_log="${xorg_dir}/xorg.log"

[[ ! -d "$xorg_dir" ]] && mkdir -p "$xorg_dir"

if [ -z "${DISPLAY}" ] && [ -n "$XDG_VTNR" ] && (( $XDG_VTNR <= 1 )); then
  # exec startx "${XINITRC:-$HOME/.xinitrc}" -- -keeptty >! "$xorg_log" 2>&1
  exec xinit -- vt$XDG_VTNR -keeptty > "$xorg_log" 2>&1
fi

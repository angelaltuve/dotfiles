#!/usr/bin/env bash
cd "$(tmux run "echo #{pane_start_path}")" || exit
url=$(git remote get-url origin)

open "$url" || echo "No remote found"

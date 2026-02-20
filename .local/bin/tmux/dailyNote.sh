#!/usr/bin/env bash

# Specify below the directory in which you want to create your daily note
main_note_dir="$HOME/docs/personal/Daily_Note"

# Get current date components
current_year=$(date +"%Y")
current_month_num=$(date +"%m")
current_month_abbr=$(date +"%b")
current_day=$(date +"%d")
current_weekday=$(date +"%A")

# Construct the directory structure and filename
note_dir=${main_note_dir}/${current_year}/${current_month_num}-${current_month_abbr}
note_name=${current_year}-${current_month_num}-${current_day}-${current_weekday}
note_tags=${current_year}-${current_month_num}-${current_day}
full_path=${note_dir}/${note_name}.md

# Check if the directory exists, if not, create it
if [ ! -d "$note_dir" ]; then
  mkdir -p "$note_dir"
fi

# Create the daily note if it does not already exist
if [ ! -f "$full_path" ]; then
  cat <<EOF >"$full_path"
---
id: ${note_tags}
aliases:
  - ${note_name}
tags:
  - daily-notes
---

Tags: [[+Daily Notes]]

# ${note_name}

## Contents

<!-- toc -->

- [Daily Note](#daily-note)

<!-- tocstop -->

## Daily Note

EOF
fi

###############################################################################
#                      Daily note with Tmux Sessions
###############################################################################

# Use note name as the session name
tmux_session_name=${note_name}

# Check if a tmux session with the note name already exists
if ! tmux has-session -t="$tmux_session_name" 2>/dev/null; then
  # Create a new tmux session with the note name in detached mode and start
  # neovim with the daily note, cursor at the last line
  # + tells neovim to execute a command after opening and G goes to last line
  # Opened neovim with export NVIM_APPNAME='neobean' && nvim lamw25wmal
  # Otherwise the instance that was opened always had plugin updates, even though it was neobean
  # tmux new-session -d -s "$tmux_session_name" -c "$note_dir" "NVIM_APPNAME=neobean nvim +norm\ Go +startinsert $full_path"
  tmux new-session -d -s "$tmux_session_name" -c "$note_dir" "nvim +norm\ G $full_path"
  # tmux new-session -d -s "$tmux_session_name" "nvim +norm\ G $full_path"
  # Create a new tmux session with the note name in detached mode and start neovim with the daily note
  # tmux new-session -d -s "$tmux_session_name" "nvim $full_path"
fi

# Check if neovim is running, if not open it
if ! tmux list-panes -t "$tmux_session_name" -F "#{pane_current_command}" | grep -q "nvim"; then
  tmux send-keys -t "$tmux_session_name" "nvim" C-m
  tmux send-keys -t "$tmux_session_name" "s"
fi

# Switch to the tmux session with the note name
tmux switch-client -t "$tmux_session_name"

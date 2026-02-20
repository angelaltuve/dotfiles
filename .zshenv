#!/usr/bin/env zsh

# --- PATH Configuration ---
# Append all directories inside ~/.local/bin to PATH
export PATH="$PATH:$(find $HOME/.local/bin/ -type d | paste -sd ':')"

if [ -d "$HOME/.local/share/npm/bin" ]; then
  PATH="$PATH:$HOME/.local/share/npm"
fi

if [ -d "$HOME/Applications" ]; then
  PATH="$PATH:$HOME/Applications"
fi


# --- Default Applications ---
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="librewolf"
export OPENER="xdg-open"
export PAGER="less"

# --- XDG Base Directory Specification ---
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# --- X11 Configuration Files ---
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export XPROFILE="$XDG_CONFIG_HOME/x11/xprofile"
export XRESOURCES="$XDG_CONFIG_HOME/x11/xresources"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# --- Application Configurations ---
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/default/config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export HISTFILE="$XDG_DATA_HOME/history"
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export MBSYNCRC="$XDG_CONFIG_HOME/mbsync/config"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export LYNX_CFG="$XDG_CONFIG_HOME/lynx/lynx.cfg"
export LYNX_LSS="$XDG_CONFIG_HOME/lynx/lynx.lss"
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"
export FFMPEG_DATADIR="$XDG_CONFIG_HOME/ffmpeg"
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export UNISON="$XDG_DATA_HOME/unison"
export LEIN_HOME="$XDG_DATA_HOME/lein"

# --- Java Configuration ---
export AWT_TOOLKIT="MToolkit wmname LG3D"
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

# --- Man Pager Settings ---
export MANPAGER="nvim +Man!"

# --- UI/UX Settings ---
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export QT_QPA_PLATFORMTHEME="gtk3"

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30%"
export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort"
export NOTMUCH_PROFILE="01"

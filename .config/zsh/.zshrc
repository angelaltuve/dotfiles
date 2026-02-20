#!/usr/bin/env zsh

[[ $- != *i* ]] && return

# --- Prompt ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Alias ---
alias_files="$HOME/.config/shell/aliasrc"
[ -f "$alias_files" ] && source "$alias_files"

# --- Zinit ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

## git
zinit snippet OMZP::git
zinit snippet OMZP::git-extras
zinit light k4rthik/git-cal

# linux
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux

# others
zinit snippet OMZP::history
zinit snippet OMZP::fancy-ctrl-z
zinit snippet OMZP::common-aliases
zinit snippet OMZP::encode64


zinit ice lucid wait
zinit snippet OMZP::fzf
zinit snippet OMZP::gpg-agent
zinit snippet OMZP::zoxide


zinit light TunaCuma/zsh-vi-man
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-history-substring-search
zinit light Tarrasch/zsh-autoenv

zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true
  ZVM_OPEN_CMD='xdg-open'
}

zinit light jeffreytse/zsh-vi-mode

# Load completions
autoload -Uz compinit && compinit
zmodload zsh/complist

zinit cdreplay -q

zle_highlight+=(paste:none)

# History
HISTSIZE=5000
HISTFILE="$HOME/.cache/zsh_history"
SAVEHIST="$HISTSIZE"
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt extended_history
setopt incappendhistory
setopt histreduceblanks
setopt histignorespace
setopt histignorealldups
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_verify

# Other
setopt interactive_comments
setopt noflowcontrol
setopt prompt_subst
setopt nolisttypes
setopt extendedglob
setopt nobeep
setopt notify
setopt longlistjobs
setopt multios

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# --- yazi ---
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

bindkey -s '^o' '^uy\n'

# --- Keys ---
bindkey '^ ' autosuggest-accept
bindkey ' ' magic-space
bindkey -s '^b' '^ucommand bc -lq\n'
bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

# HOME and END Keys
bindkey '^[[H' beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

# Page Up and Page Down and sudo command
bindkey -M vicmd '^S' sudo-command-line
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

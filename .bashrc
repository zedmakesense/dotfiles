#!/usr/bin/env bash
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export PATH="$HOME/.local/bin:$PATH"

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CARGO_TARGET_DIR="$XDG_CACHE_HOME/cargo-target"
export PATH="$HOME/.cargo/bin:$PATH"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME"/go
# export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export W3M_DIR="$XDG_STATE_HOME/w3m"
export PYTHON_HISTORY=$XDG_STATE_HOME/python_history
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
export PYTHONUSERBASE=$XDG_DATA_HOME/python
export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
# export MOZ_LEGACY_HOME=1
export PATH="$PATH:$GOPATH/bin"

export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
# export PATH="$HOME/.local/share/pnpm:$PATH"

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=kvantum

# export MOZ_ENABLE_WAYLAND=1
# export SDL_VIDEODRIVER=wayland
# export _JAVA_AWT_WM_NONREPARENTING=1
# export GTK_IM_MODULE=wayland
# export QT_IM_MODULE=wayland
# export XMODIFIERS="@im=wayland"

export TERMINAL=foot
export COLORTERM=truecolor

export EDITOR=nvim
export VISUAL=nvim
export SYSTEMD_EDITOR=nvim
export MANPAGER="nvim +Man!"

[[ $- != *i* ]] && return

PROMPT_COMMAND='history -a'

# History configuration
shopt -s histverify
shopt -s histappend
shopt -s cmdhist
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE="&:[ ]*:exit:x:t:ls:l:ll:c:bg:fg:history:clear"
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'
# HISTTIMEFORMAT='%F %T '

export HISTFILE="$XDG_STATE_HOME"/bash/history
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion

set -o vi
# bind stuff
bind 'set meta-flag on'
bind 'set input-meta on'
bind 'set output-meta on'
bind 'set convert-meta off'
bind 'set mark-symlinked-directories on'
bind 'set skip-completed-text on'
bind 'set colored-stats on'
# Prevent file overwrite on stdout redirection, Use `>|` to force redirection to an existing file
set -o noclobber
# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2>/dev/null
shopt -s checkwinsize
shopt -s dirspell 2>/dev/null
shopt -s cdspell 2>/dev/null
bind "set completion-ignore-case on"
bind "set show-all-if-unmodified on"
bind "set show-all-if-ambiguous on"
bind "set completion-prefix-display-length 2"
bind "set completion-map-case on"
bind "set page-completions off"
bind "set mark-symlinked-directories on"

alias l="eza -l -o --no-permissions --icons=always --group-directories-first"
alias ll="eza -la -o --no-permissions --icons=always --group-directories-first"
alias ltree="l --tree"
alias lltree="ll --tree"

# alias ls='ls --color=auto'
# alias ip='ip -color=auto'
# alias grep='grep --color=auto'
# alias df="df -h"

alias mute="wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1"
alias unmute="wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0"

alias cp='cp -iv'
alias mv='mv -iv'
alias trash="trash -v"
alias cd="zd"
zd() {
  if [ $# -eq 0 ]; then
    builtin cd ~ || return
  elif [ -d "$1" ]; then
    builtin cd "$1" || return
  else
    z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
  fi
}

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c="clear"
alias x="exit"

alias vim="nvim"
alias vi="nvim"
alias v="nvim ."

alias t="tmux"
alias tns="tmux new-session -s"
alias tks="tmux kill-session -t"
alias tas="tmux attach-session -t"
alias tls="tmux ls"

alias diffs='export DELTA_FEATURES=+side-by-side; git diff'
alias diffl='export DELTA_FEATURES=+; git diff'

alias img="swayimg"
alias open="xdg-open"

alias jrctl="journalctl -p 3 -xb"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias grub-mkconfig="sudo grub-mkconfig -o /boot/grub/grub.cfg"

__fzf_history__() {
  local selected
  selected=$(history | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]*//' | tac |
    fzf --height=40% --reverse --no-sort --bind=ctrl-r:toggle-sort)

  if [[ -n $selected ]]; then
    READLINE_LINE=$selected
    READLINE_POINT=${#READLINE_LINE}
  fi
}
bind -x '"\C-r":__fzf_history__'

source /usr/share/bash-completion/bash_completion
eval "$(starship init bash)"
eval "$(zoxide init bash)"
# eval "$(thefuck --alias)"

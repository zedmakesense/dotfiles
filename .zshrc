export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export PATH="$HOME/.local/bin:$GOPATH/bin:$PATH"

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CARGO_TARGET_DIR="$XDG_CACHE_HOME/cargo-target"
export GOPATH="$XDG_DATA_HOME"/go

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=kvantum

# export MOZ_ENABLE_WAYLAND=1
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
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

# Tab-completion
autoload -Uz compinit
compinit

# vi mode
bindkey -v

# Show different cursor shapes in vi modes
function zle-keymap-select {
  case $KEYMAP in
    vicmd)      echo -ne '\e[2 q' ;;  # block cursor
    viins|main) echo -ne '\e[6 q' ;;  # beam cursor
  esac
}
zle -N zle-keymap-select

# Ensure correct cursor on startup
echo -ne '\e[6 q'

# Better history search (up/down like in vim)
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# History
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=500000
SAVEHIST=100000
setopt hist_ignore_dups share_history append_history extended_history

# Aliases
alias l="eza -l -o --no-permissions --icons=always --group-directories-first"
alias ll="eza -la -o --no-permissions --icons=always --group-directories-first"

alias ls='ls --color=auto'
alias ip='ip -color=auto'
alias grep='grep --color=auto'
alias df="df -h"

alias mute="wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1"
alias unmute="wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0"

alias cp='cp -iv'
alias mv='mv -iv'
alias trash="trash -v"
alias cd="z"

alias c="clear"
alias x="exit"

alias vim="nvim"
alias vi="nvim"
alias v="nvim +Ex"

alias t="tmux"
alias tns="tmux new-session -s"
alias tks="tmux kill-session -t"
alias tas="tmux attach-session -t"
alias tls="tmux ls"

alias diffs='export DELTA_FEATURES=+side-by-side; git diff'
alias diffl='export DELTA_FEATURES=+; git diff'

alias img="swayimg"

alias jrctl="journalctl -p 3 -xb"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias grub-mkconfig="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# External tools
source /usr/share/wikiman/widgets/widget.zsh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

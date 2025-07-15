# If not running interactively, do nothing
[[ $- != *i* ]] && return

# Tab-completion
autoload -Uz compinit
compinit

# Syntax highlighting (must be last after compinit)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Inline autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Git branch and status in prompt
parse_git_branch() {
    git rev-parse --is-inside-work-tree &>/dev/null || return

    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)

    local dirty=""
    local staged=""
    local untracked=""
    git diff --quiet || dirty="*"
    git diff --cached --quiet || staged="+"
    [ -n "$(git ls-files --others --exclude-standard)" ] && untracked="?"

    local ahead_behind=""
    if git rev-parse @{u} &>/dev/null; then
        local upstream=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)
        local ahead=$(git rev-list --count HEAD.."$upstream" 2>/dev/null)
        local behind=$(git rev-list --count "$upstream"..HEAD 2>/dev/null)
        [[ $behind -gt 0 ]] && ahead_behind="↑$behind"
        [[ $ahead -gt 0 ]] && ahead_behind="${ahead_behind}↓$ahead"
    fi

    echo -e " \033[1;33m(${ahead_behind} $branch$staged$dirty$untracked)\033[0m"
}

# Prompt definition
autoload -Uz colors && colors
setopt PROMPT_SUBST
PS1=$'\n%F{cyan}[ %n@%m | %F{green}%~ %f%F{cyan}]$(parse_git_branch)%f\n%F{81}>%f '

# History
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=500000
SAVEHIST=100000
setopt hist_ignore_dups share_history append_history extended_history

# Environment
export EDITOR=nvim
export VISUAL=nvim
export PAGER='nvim -R'
export MANPAGER='nvim +Man!'
export TERMINAL=foot

export PATH="$HOME/.local/bin:$HOME/.scripts/bin:$PATH"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=kvantum

# Aliases
alias l="eza -l --icons=always --group-directories-first"
alias ll="eza -la --icons=always --group-directories-first"

alias ls='ls --color=auto'
alias ip='ip -color=auto'
alias grep='grep --color=auto'
alias df='df -h'

alias mute="wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1"
alias unmute="wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0"

alias cp="cp -i"
alias mv="mv -i"
alias cd="z"

alias c="clear"
alias x="exit"

alias vim="nvim"
alias vi="nvim"
alias v="nvim +Ex"
alias vimdiff="nvim -d"
alias nvimdiff="nvim -d"

alias img="swayimg"
alias jrctl="journalctl -p 3 -xb"
alias grub-mkconfig="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# External tools
eval "$(zoxide init zsh)"
source /usr/share/wikiman/widgets/widget.zsh

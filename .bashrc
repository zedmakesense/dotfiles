# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Function to get git status
parse_git_branch() {
    git rev-parse --is-inside-work-tree &>/dev/null || return

    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)

    local status=""
    local dirty=""
    local staged=""
    local untracked=""

    # Status indicators
    git diff --quiet || dirty="*"
    git diff --cached --quiet || staged="+"
    [ -n "$(git ls-files --others --exclude-standard)" ] && untracked="?"

    # Ahead/behind info
    local ahead_behind=""
    if git rev-parse @{u} &>/dev/null; then
        local upstream=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)
        local ahead=$(git rev-list --count HEAD.."$upstream" 2>/dev/null)
        local behind=$(git rev-list --count "$upstream"..HEAD 2>/dev/null)
        [[ $behind -gt 0 ]] && ahead_behind="↑ $behind"
        [[ $ahead -gt 0 ]] && ahead_behind="${ahead_behind}↓ $ahead"
    fi

    status="$ahead_behind $branch$staged$dirty$untracked "
    echo -e " \033[1;33m(${status})\033[0m"
}

# PS1 prompt with Git info
PS1='\n\033[1;36m[ \u@\h |\033[m \033[1;32m\w \033[m\033[1;36m]$(parse_git_branch)\033[m \n\[\e[38;5;51m\]>\[\e[0m\] '
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# set -o vi

shopt -s histverify

## GENERAL OPTIONS ##

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
# PROMPT_DIRTRIM=2

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2>/dev/null

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

#This turns off the use of the internal pager when returning long completion lists.
bind "set page-completions off"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2>/dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2>/dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2>/dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export HISTFILE="$XDG_STATE_HOME"/bash/history
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion

export PATH="$PATH:$HOME/.local/bin:$HOME/.scripts/bin"

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=kvantum
export TERMINAL=foot

export EDITOR=nvim
export VISUAL=nvim
export SYSTEMD_EDITOR=nvim
export MANPAGER="nvim +Man!"
export PAGER="nvim -R"

alias l="eza -l --icons=always --group-directories-first"
alias ll="eza -la --icons=always --group-directories-first"

alias ls='ls --color=auto'
alias ip='ip -color=auto'
alias grep='grep --color=auto'
alias fzf="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias df="df -h"

alias mute="wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1"
alias unmute="wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0"

alias cp="cp -i"
alias mv="mv -i"
alias trash="trash -v"
alias cd="z"

alias c="clear"
alias x="exit"

alias vim="nvim"
alias vi="nvim"
alias v="vifm"
alias vimdiff="nvim -d"
alias nvimdiff="nvim -d"

alias img="swayimg"

alias jrctl="journalctl -p 3 -xb"
alias grub-mkconfig="sudo grub-mkconfig -o /boot/grub/grub.cfg"

source /usr/share/wikiman/widgets/widget.bash
eval "$(zoxide init bash)"

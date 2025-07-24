[[ $- != *i* ]] && return

# Function to get git status
parse_git_branch() {
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || echo "DETACHED")

  local dirty=""
  local staged=""
  local untracked=""
  local ahead_behind=""

  ! git diff --quiet && dirty="*"
  ! git diff --cached --quiet && staged="+"
  [ -n "$(git ls-files --others --exclude-standard)" ] && untracked="?"

  if git rev-parse --abbrev-ref --symbolic-full-name @{u} &>/dev/null; then
    local upstream=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)
    local counts
    counts=$(git rev-list --left-right --count HEAD...@{u} 2>/dev/null)
    local ahead=$(echo "$counts" | awk '{print $1}')
    local behind=$(echo "$counts" | awk '{print $2}')

    [[ $ahead -gt 0 ]] && ahead_behind+="↑$ahead"
    [[ $behind -gt 0 ]] && ahead_behind+="↓$behind"
  fi

  status="${ahead_behind:+$ahead_behind }$branch$staged$dirty$untracked"
  echo -e "\[\e[1;33m\](${status})\[\e[0m\]"
}

__prompt_command() {
  local git_info=$(parse_git_branch)
  PS1="\n\[\e[1;36m\][ \u@\h | \[\e[1;32m\]\w \[\e[1;36m\]] $git_info\[\e[0m\]\n\[\e[38;5;51m\]>\[\e[0m\] "
}
# [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# set -o vi

# Prevent file overwrite on stdout redirection, Use `>|` to force redirection to an existing file
set -o noclobber
shopt -s checkwinsize

# Enable history expansion with space, typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2>/dev/null

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

#This turns off the use of the internal pager when returning long completion lists.
bind "set page-completions off"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

# expands the command, but places it in the prompt for confirmation
shopt -s histverify
# Append to the history file, don't overwrite it
shopt -s histappend
# Save multi-line commands as one command
shopt -s cmdhist

# Single PROMPT_COMMAND for prompt + history append
PROMPT_COMMAND='__prompt_command; history -a'

# History configuration
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE="&:[ ]*:exit:ls:l:ll:c:bg:fg:history:clear"
HISTTIMEFORMAT='%F %T '

# Prepend cd to directory names automatically
# shopt -s autocd 2>/dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2>/dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2>/dev/null

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export HISTFILE="$XDG_STATE_HOME"/bash/history
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion

export PATH="$PATH:$HOME/.local/bin:$HOME/Documents/scripts/bin"

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go

prefix=${XDG_DATA_HOME}/npm
cache=${XDG_CACHE_HOME}/npm
init_module="${XDG_CONFIG_HOME}/npm/config/npm-init.js"
logs_dir="${XDG_STATE_HOME}/npm/logs"
export init_module
export logs_dir
export prefix
export cache

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=kvantum

export TERMINAL=foot
export COLORTERM=truecolor

export EDITOR=nvim
export VISUAL=nvim
export SYSTEMD_EDITOR=nvim
export MANPAGER="nvim +Man!"
# export PAGER="nvim -R"

# alias l="eza -l -o --no-permissions --icons=always --group-directories-first"
# alias ll="eza -la -o --no-permissions --icons=always --group-directories-first"
alias l="eza -l -o --no-permissions --group-directories-first"
alias ll="eza -la -o --no-permissions --group-directories-first"

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

alias vim="nvim"
alias vi="nvim"
alias v="nvim +Ex"
alias vimdiff="nvim -d"
alias diffs='export DELTA_FEATURES=+side-by-side; git diff'
alias diffl='export DELTA_FEATURES=+; git diff'

alias img="swayimg"

alias jrctl="journalctl -p 3 -xb"
alias grub-mkconfig="sudo grub-mkconfig -o /boot/grub/grub.cfg"

source /usr/share/wikiman/widgets/widget.bash
eval "$(zoxide init bash)"

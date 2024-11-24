#!/usr/bin/env bash

# ~/.bashrc
# -----------------------------------------------------------------------------
# interactive non-login
# /etc/profile
# ~/.bash_profile
# ~/.bash_login
# ~/.profile
# /etc/bashrc
# ~/.bashrc
# 
# https://wiki.archlinux.org/title/bash
# https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html
# -----------------------------------------------------------------------------

# shellcheck shell=bash
# shellcheck source=/dev/null

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
# for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
#   [ -r "$file" ] && [ -f "$file" ] && source "$file";
# done;
# unset file;

# Abort if not running interactively
if [[ $- != *i* ]] || [ -z "$PS1" ]; then
  return 0
fi

# Stop the macOS Terminal warning message when Zsh is not the default shell
# https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

# avoid having .shellcheckrc in ~ (https://github.com/koalaman/shellcheck/wiki)
# export SHELLCHECK_OPTS='--exclude=SC1003,SC1071,SC1087,SC1090,SC1091,SC2001,SC2015,SC2034,SC2038,SC2059,SC2068,SC2086,SC2115,SC2128,SC2139,SC2145,SC2153,SC2155,SC2164'

# Owner / Group / Others
# 0 rwx / 1 rw- / 2 r-x / 3 r-- / 4 -wx / 5 -w- / 6 --x / 7 ---
# 
# umask 077 - only you
# Permissions when creating files
# default directory permissions are 755 and default file permissions are 644
umask 022

## XDG Base Directory
# https://specifications.freedesktop.org/basedir-spec/latest/
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
## (( ${+*} )) = if variable is set don't set it anymore. or use [[ -z ${*} ]]

# Set XDG base dirs
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_RUNTIME_HOME="${HOME}/.tmp"

export XDG_DESKTOP_DIR="${HOME}/Desktop"
export XDG_DOCUMENTS_DIR="${HOME}/Documents"
export XDG_DOWNLOAD_DIR="${HOME}/Downloads"
export XDG_MUSIC_DIR="${HOME}/Music"
export XDG_PICTURES_DIR="${HOME}/Pictures"
# export XDG_PUBLICSHARE_DIR="${HOME}/Public"
# export XDG_TEMPLATES_DIR="${HOME}/GitHub/Templates"
export XDG_VIDEOS_DIR="${HOME}/Movies"

export BASH_COMPLETION_USER_DIR="$XDG_DATA_HOME/bash/bash_completion"
# export GVIMINIT='let $MYGVIMRC="$XDG_CONFIG_HOME/vim/gvimrc" | source $MYGVIMRC'
# export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
# export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
# export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.vim" | so $MYVIMRC'
# export VIMINIT="source ~/.config/vim/vimrc"
# export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

# Package managers etc.
export FRUM_DIR="$XDG_DATA_HOME/frum"
export FNM_DIR="$XDG_DATA_HOME/fnm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export VOLTA_HOME="$XDG_CONFIG_HOME/volta"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GEMRC="${XDG_CONFIG_HOME}/gem/gemrc"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export BUNDLE_USER_HOME="$XDG_DATA_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle/cache"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle/plugin"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export MACHINE_STORAGE_PATH="${XDG_DATA_HOME}/docker/machine"
# python
export PYLINTHOME=${XDG_DATA_HOME:-$HOME/.local/share}/pylint
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
# This will work once https://github.com/python/cpython/pull/13208 gets merged...
export PYTHONHISTORY="${XDG_CACHE_HOME:-$HOME/.cache}/python/history" 

# CLI utils, etc.
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export TEALDEER_CONFIG_DIR="/Users/miked/.config/tealdeer"
export UMCONFIG_HOME="$XDG_CONFIG_HOME/um/umconfig"
export CHEAT_CONFIG_PATH="$XDG_CONFIG_HOME/cheat/conf.yml"
export CHTSH=${XDG_CONFIG_HOME:-$HOME/cht.sh}
export CHTSH_CONF="$XDG_CONFIG_HOME/cht.sh/cht.sh.conf"
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
export _Z_DATA="$XDG_DATA_HOME/z/z-history"
# export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"
export SYNC_DIR="${HOME}/Library/CloudStorage/Dropbox"
export ICLOUD_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
export ICLOUD_DOCUMENTS_DIR="${ICLOUD_DIR}/Documents"
export DOCUMENTS_DIR="${ICLOUD_DOCUMENTS_DIR}"
export OBSIDIAN_VAULT_DIR="${ICLOUD_DIR}/Documents/_notes/vault"

# Force gpg-agent to use the current tty
tty_path=$(tty)
export GPG_TTY=$tty_path

# Browser
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

# if [[ $(uname -s) = Darwin ]]; then
#   # Override insanely low open file limits on macOS.
#   ulimit -n 65536
#   ulimit -u 1064
# fi

if [ "$(arch)" = arm64 ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi
# runs - 
    # export HOMEBREW_PREFIX="/usr/local"
    # export HOMEBREW_CELLAR="/usr/local/Cellar"
    # export HOMEBREW_REPOSITORY="/usr/local/Homebrew"
    # export PATH="/usr/local/bin:/usr/local/sbin${PATH+:$PATH}"
    # export MANPATH="/usr/local/share/man${MANPATH+:$MANPATH}:"
    # export INFOPATH="/usr/local/share/info:${INFOPATH:-}"
export HOMEBREW_NO_ANALYTICS=1  # disables statistics that brew collects
############### Telemetry
export DO_NOT_TRACK=1 # Future proof? https://consoledonottrack.com/

source "$XDG_DATA_HOME/bash/bash_completion/*"

if [[ -f "$XDG_CONFIG_HOME/bash/completion" ]]; then
    source "$XDG_CONFIG_HOME/bash/completion"
fi
if [[ -f "$XDG_CONFIG_HOME/bash/aliases" ]]; then
    source "$XDG_CONFIG_HOME/bash/aliases"
fi

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export PATH="$HOME/.local/bin:$PATH"
export PATH=$GOPATH/bin:$PATH
# Ensure Homebrew-provided packages are used instead of system's.
# export PATH="$BREW_PREFIX/bin:$PATH"
# export PATH="$BREW_PREFIX/sbin:$PATH"
# export PATH="$XDG_CONFIG_HOME/nvm/current/bin/:$PATH"

# Larger bash history (allow 32³ entries; default is 500)
export HISTFILE="$XDG_DATA_HOME/bash/bash_history"
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
# Avoid duplicate entries
export HISTCONTROL="erasedups:ignoreboth"
# Use standard ISO 8601 timestamp - %Y-%m-%d %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '
# Don't record some commands
export HISTIGNORE="history:pwd:exit:df:ls:ll:ls *:cd:cd -:date:* --help"
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export EDITOR=vim
export VISUAL='subl -w'

# Use Neovim as "preferred editor"
# export EDITOR="nvim"

# Use Neovim as man pager
# export MANPAGER="nvim +Man!"
# export MANWIDTH=999

# https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export CLICOLOR=1

# Pagers:
# This affects every invocation of `less`
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x4  tabs are 4 instead of 8

# -F or --quit-if-one-screen
# -i or --ignore-case
# -J or --status-column
# -M or --LONG-PROMPT
# -R or --RAW-CONTROL-CHARS
# -S or --chop-long-lines
# -xn,... or --tabs=n

export LESS="-FiJMRSx4"
export PAGER=less
export MANPAGER='less'
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export LESS="-FiQMXRwJ --incsearch --status-col-width 1"
export LESSCHARSET="UTF-8"
export LESSHISTFILE=-
# Disable `less` connectors because of security risks.
# See http://seclists.org/fulldisclosure/2014/Nov/74
# shellcheck disable=SC2034
LESSOPEN=
# shellcheck disable=SC2034
LESSCLOSE=

# export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
# export LESSKEY="$XDG_CONFIG_HOME/lesskey/output"

# Make less more friendly for non-text input files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && export LESSOPEN="|lesspipe %s"

# DELTA_PAGER 
# DELTA_FEATURES
# BAT_PAGER
# BAT_STYLE 
# BAT_THEME

# Set default blocksize for ls, df, du
export BLOCKSIZE=1k

# sane moving between words on the prompt
export WORDCHARS='~!#$%^&*(){}[]<>?.+;'
# Remove the forward slash and hyphen characters from what is considered part
# of a word so meta+f and meta+b will stop at directory boundaries.
export WORDCHARS=${WORDCHARS//[\/]}

# -----------------------------------------------------------------------------
# configure colors for less (man pages, searching, etc.)
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)    # red
export LESS_TERMCAP_md=$(tput bold; tput setaf 4)    # blue
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; setaf 7; tput setab 5) # bold white on magenta
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)    # bold white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)


# Extras ----------------------------------------------------------------------
# Silently load SSH keys from the keychain if needed
ssh-add -l > /dev/null || ssh-add -A 2> /dev/null

# print a message on SSH connection:
if [[ -n "$SSH_CLIENT" ]]; then
    # ssh connection, print hostname and os version
    echo "Welcome to $(scutil --get ComputerName) ($(sw_vers -productVersion))"
fi

if type navi >/dev/null 2>&1; then
  eval "$(navi widget zsh)"
fi

# if command -v thefuck >/dev/null 2>&1; then
#     eval "$(thefuck --alias)"
# fi

# Append Cargo to path, if it's installed
if [[ -d "$XDG_DATA_HOME/cargo/bin" ]]; then
  export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"
fi

if type gdircolors >/dev/null 2>&1; then 
  eval $(dircolors "$XDG_CONFIG_HOME/dircolors/dircolors.ansi-universal")
fi

if type asdf &>/dev/null; then
  . "/opt/homebrew/opt/asdf/libexec/asdf.sh"
fi

if type fnm &>/dev/null; then
  eval "$(fnm env)"
fi

if type frum &>/dev/null; then
  eval "$(frum init)"
fi

# use starship prompt
if type starship &>/dev/null; then
  eval "$(starship init bash)"
fi

# zoxide
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi
_ZO_RESOLVE_SYMLINKS=1

# Setup fzf
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi
# fzf Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.bash" 2> /dev/null
# fzf Key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.bash"

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview="bat --color=always --style=header {} 2>/dev/null" --preview-window=right:60%:wrap'
export FZF_ALT_C_COMMAND="fd --type f --hidden --follow"
export FZF_ALT_C_OPTS='--preview="exa -1 --icons --git --git-ignore {}" --preview-window=right:60%:wrap'
# bindkey '^F' fzf-file-widget

# FZF custom tokyo-night theme
# "--color=fg:#a9b1d6,bg:#1a1b26,preview-fg:#c8d3f5,preview-bg:#222436,hl:#6d91de,fg+:#c0caf5,bg+:#161720,gutter:#161720,hl+:#e0af68,info:#646e9c,border:#565f89,prompt:#0db9d7,pointer:#dbc08a,marker:#9d7cd8,spinner:#9d599d,header:#61bdf2"
export FZF_DEFAULT_OPTS="--ansi"


# export PS1=$'\n'"%F{green} %*%F %3~ %F{white}"$'\n'"$ "

[[ -r "/opt/homebrew/etc/bash_completion.d/git-prompt.sh" ]] && . "/opt/homebrew/etc/bash_completion.d/git-prompt.sh"

# GIT_PS1_SHOWCOLORHINTS=true
# GIT_PS1_SHOWDIRTYSTATE=true
# GIT_PS1_SHOWSTASHSTATE=true
# GIT_PS1_DESCRIBE_STYLE="branch"
# GIT_PS1_SHOWUPSTREAM="auto git"
# PROMPT_COMMAND='__git_ps1 "\[\e[1;35m\]\w\[\e[m\]" " \[\e[1;33m\]❯\[\e[m\] "'
# trim long paths in the prompt (requires Bash 4.x)
# PROMPT_DIRTRIM=2

# Bash 4.2+ Completion via homebrew
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

source <(op completion bash)

# Options #####################################################################
# 
# 
###############################################################################

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

shopt -s cdable_vars            # cd into dirs defined as vars
# Examples:
# export projects="$HOME/Dev"
# export documents="$HOME/Documents"
# export downloads="$HOME/Downloads"
# export dotfiles="$HOME/.config"

# Enable `vi` editing mode.
# https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Readline-vi-Mode
set -o vi

# Remove the ^S ^Q mappings. See all mappings: stty -a
stty stop undef
stty start undef
# dot not print meta chars, e.g. `ˆC` when <C-c> is pressed to escape a command
stty -echoctl
# Allow <C-s> to pass through to shell and programs
stty -ixon -ixoff

## BETTER DIRECTORY NAVIGATION ##
# Automatically prepend `cd` to directory names
shopt -s autocd 2> /dev/null
# Correct small errors in directory names during completion
shopt -s dirspell 2> /dev/null
# Correct small errors in directory names given to the `cd` builtin
shopt -s cdspell 2> /dev/null

# Expand aliases
shopt -s expand_aliases
# Update LINES and COLUMNS after each command if necessary
shopt -s checkwinsize
# Check that hashed commands still exist before running them
shopt -s checkhash
# Warn me about stopped jobs when exiting
shopt -s checkjobs           
# Allow double-star globs to match files and recursive paths
shopt -s globstar 2> /dev/null
# case insensitive globbing
shopt -s nocaseglob
# Include filenames with leading dots in pattern matching
shopt -s dotglob
# Enable extended globbing: !(foo), ?(bar|baz)...
shopt -s extglob
# Don't complete a Tab press on an empty line with every possible command
shopt -s no_empty_cmd_completion
# Don't assume a word with a @ in it is a hostname
shopt -u hostcomplete
# Use programmable completion, if available
shopt -s progcomp
# Warn me if I try to shift nonexistent values off an array
shopt -s shift_verbose
# Don't search $PATH to find files for the `source` builtin
shopt -u sourcepath
# Expand variables in directory completion
shopt -s direxpand
# Don't try to tell me when my mail is read
shopt -u mailwarn

## SANE HISTORY DEFAULTS ##
# Append history to $HISTFILE rather than overwriting it
shopt -s histappend
# Load history expansion result as the next command, don't run them directly
shopt -s histverify
# Put multi-line commands into one history entry
shopt -s cmdhist
# If history expansion fails, reload the command to try again
shopt -s histreedit
# Don't change newlines to semicolons in history
shopt -s lithist

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# make tab cycle through commands after listing, from
# https://unix.stackexchange.com/a/527944
bind '"\t":menu-complete'
bind "set menu-complete-display-prefix on"
## SMARTER TAB-COMPLETION (Readline bindings) ##
# case insensitive file completion
bind "set completion-ignore-case on"
# hyphens and underscores the same
bind "set completion-map-case on"
# show matches if ambiguous on tab
bind "set show-all-if-ambiguous on"
# auto add slash to dir symlinks
bind "set mark-symlinked-directories on"

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
# set -o noclobber

export ITERM2_SQUELCH_MARK=1
test -e "$XDG_CONFIG_HOME/iterm2/.iterm2_shell_integration.bash" && source "$XDG_CONFIG_HOME/iterm2/.iterm2_shell_integration.bash"

# Intelligent command completion
complete -d cd pushd;
complete -u finger mail;
complete -v set unset;

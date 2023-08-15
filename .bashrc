#!/bin/bash

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

# shellcheck shell=bash
# shellcheck source=/dev/null

# set -x

# Abort if not running interactively
if [[ $- != *i* ]] || [ -z "$PS1" ]; then
  return 0
fi

# Abort if not running interactively
[[ $- == *i* ]] || return 0

# Stop the macOS Terminal warning message when Zsh is not the default shell
# https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export INPUTRC="$XDG_CONFIG_HOME/.config/readline/inputrc"
export BASH_COMPLETION_USER_DIR="$XDG_DATA_HOME/bash-completion"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export TEALDEER_CONFIG_DIR="/Users/miked/.config/tealdeer"
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
export _Z_DATA="$XDG_DATA_HOME/z/z-history"
export FRUM_DIR="$XDG_DATA_HOME/frum"
export FNM_DIR="$XDG_DATA_HOME/fnm"
export BUNDLE_USER_HOME="$XDG_DATA_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle/cache"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle/plugin"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# Homebrew
if [[ -e /opt/homebrew/bin/brew ]]; then
    export BREW_PREFIX=/opt/homebrew
else
    export BREW_PREFIX=/usr/local
fi

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

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export PATH="$HOME/.local/bin:$PATH"
export EDITOR=vim
export VISUAL='subl -w'
export GPG_TTY=$(tty)

# export PS1=$'\n'"%F{green} %*%F %3~ %F{white}"$'\n'"$ "

# Pagers:
# This affects every invocation of `less`
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -S   truncate long lines
#   -x4  tabs are 4 instead of 8
export LESS="-FiJMRSx4"
export PAGER='less'
export MANPAGER='less'
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESSCHARSET="UTF-8"
export LESSHISTFILE=-
# export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
# export LESSKEY="$XDG_CONFIG_HOME/lesskey/output"

# Disable `less` connectors because of security risks.
# See http://seclists.org/fulldisclosure/2014/Nov/74
LESSOPEN=
LESSCLOSE=

# Make less more friendly for non-text input files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && export LESSOPEN="|lesspipe %s"

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# DELTA_PAGER 
# DELTA_FEATURES
# BAT_PAGER
# BAT_STYLE 
# BAT_THEME

export WORDCHARS='~!#$%^&*(){}[]<>?.+;'  # sane moving between words on the prompt
export WORDCHARS=${WORDCHARS//[\/]}       # Remove / from WORDCHARS

# Larger bash history (allow 32³ entries; default is 500)
export HISTFILE="$XDG_DATA_HOME/bash/bash_history"
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
# Avoid duplicate entries
export HISTCONTROL=ignoreboth
# Use standard ISO 8601 timestamp - %Y-%m-%d %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '
# Don't record some commands
export HISTIGNORE="history:pwd:exit:df:ls:ll:ls *:cd:cd -:date:* --help"
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Bash 4.2+ Completion via homebrew
[[ -r "$BREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && . "$BREW_PREFIX/etc/profile.d/bash_completion.sh"
# [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

if [[ -f "$XDG_CONFIG_HOME/bash/completion" ]]; then
    source "$XDG_CONFIG_HOME/bash/completion"
fi
if [[ -f "$XDG_CONFIG_HOME/bash/aliases" ]]; then
    source "$XDG_CONFIG_HOME/bash/aliases"
fi

source <(op completion bash)

eval "$(fnm env)"
eval "$(frum init)"

eval "$(starship init bash)"

eval "$(zoxide init bash)"
_ZO_RESOLVE_SYMLINKS=1

# Setup fzf
if [[ ! "$PATH" == */$BREW_PREFIX/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/$BREW_PREFIX/opt/fzf/bin"
fi
# fzf Auto-completion
source "$BREW_PREFIX/opt/fzf/shell/completion.bash"
# fzf Key bindings
source "$BREW_PREFIX/opt/fzf/shell/key-bindings.bash"

# Setup fzf
# ---------
# if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
#   PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
# fi

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
# source "/opt/homebrew/opt/fzf/shell/key-bindings.bash"

# brew z
# source $BREW_PREFIX/etc/profile.d/z.sh

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow"
export FZF_CTRL_T_COMMAND="fd --hidden --follow"
export FZF_ALT_C_COMMAND='fd -t d -d 1'
export FZF_ALT_C_OPTS='--preview="exa -1 --icons --git --git-ignore {}" --preview-window=right:60%:wrap'
# FZF custom tokyo-night theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--height=90%
--reverse
--border
--preview "cat {}"
--tabstop=4
--ansi
--no-separator
--color=fg:#a9b1d6,bg:#1a1b26,preview-fg:#c8d3f5,preview-bg:#222436,hl:#6d91de,fg+:#c0caf5,bg+:#161720,gutter:#161720,hl+:#e0af68,info:#646e9c,border:#565f89,prompt:#0db9d7,pointer:#dbc08a,marker:#9d7cd8,spinner:#9d599d,header:#61bdf2'
# FZF options for zoxide prompt (zi)
export _ZO_FZF_OPTS=$FZF_DEFAULT_OPTS'
--height=7'

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."


# https://www.gnu.org/software/bash/manual/bashref.html#The-Shopt-Builtin

shopt -s cdable_vars            # cd into dirs defined as vars
# Examples:
# export projects="$HOME/Dev"
# export documents="$HOME/Documents"
# export downloads="$HOME/Downloads"
# export dotfiles="$HOME/.config"

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
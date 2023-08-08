#!/usr/bin/env bash
# bashrc

# Abort if not running interactively
[[ $- == *i* ]] || return 0

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export INPUTRC="$XDG_CONFIG_HOME/.config/readline/inputrc"
export BASH_COMPLETION_USER_DIR="$XDG_DATA_HOME/bash-completion"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"
# export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"
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
eval "$($BREW_PREFIX/bin/brew shellenv)"
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

# Pagers:
# This affects every invocation of `less`
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x4  tabs are 4 instead of 8
export LESS="-FiJMRSx4"
export PAGER='less'
export MANPAGER='less'
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESSCHARSET="UTF-8"
export LESSHISTFILE=-
# Disable `less` connectors because of security risks.
# See http://seclists.org/fulldisclosure/2014/Nov/74
LESSOPEN=
LESSCLOSE=
# export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
# export LESSKEY="$XDG_CONFIG_HOME/lesskey/output"
# DELTA_PAGER DELTA FEATURES BAT_PAGER BAT_STYLE BAT_THEME
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

# Bash 4.2+ Completion via homebrew
[[ -r "$BREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && . "$BREW_PREFIX/etc/profile.d/bash_completion.sh"
# [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

eval "$(fnm env)"
eval "$(frum init)"

eval "$(starship init bash)"

eval "$(zoxide init bash)"
_ZO_RESOLVE_SYMLINKS=1
_ZO_FZF_OPTS="-xi --algo=v2"

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

# brew z
# source $BREW_PREFIX/etc/profile.d/z.sh

# brew git-completion
# if [ -f $BREW_PREFIX/etc/bash_completion.d/git-completion.bash ]; then
#   source "$BREW_PREFIX/etc/bash_completion.d/git-completion.bash"
# fi

# brew git-prompt
# if [ -f $BREW_PREFIX/etc/bash_completion.d/git-prompt.sh ]; then
#   source "$BREW_PREFIX/etc/bash_completion.d/git-prompt.sh"
# fi

# GIT_PS1_SHOWCOLORHINTS=true
# GIT_PS1_SHOWDIRTYSTATE=true
# GIT_PS1_SHOWSTASHSTATE=true
# GIT_PS1_DESCRIBE_STYLE="branch"
# GIT_PS1_SHOWUPSTREAM="auto git"
# PROMPT_COMMAND='__git_ps1 "\[\e[1;35m\]\w\[\e[m\]" " \[\e[1;33m\]❯\[\e[m\] "'
# trim long paths in the prompt (requires Bash 4.x)
# PROMPT_DIRTRIM=2

# Remove the ^S ^Q mappings. See all mappings: stty -a
stty stop undef
stty start undef

## BETTER DIRECTORY NAVIGATION ##
shopt -s autocd 2> /dev/null        # auto prepend cd to dir names 
shopt -s dirspell 2> /dev/null      # correct spelling for tab-complete
shopt -s cdspell 2> /dev/null       # correct spelling errors when cd

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

shopt -s expand_aliases             # Expand aliases
shopt -s checkwinsize               # Update window size after every command

bind Space:magic-space              # history expansion on space
shopt -s globstar 2> /dev/null      # recursive globbing (enables **)
shopt -s nocaseglob;                # case insensitive globbing
shopt -s dotglob                    # Include dotfiles in path expansion
shopt -s extglob                    # extend pattern-matching features
shopt -s no_empty_cmd_completion    # No empty command completion.
## SMARTER TAB-COMPLETION (Readline bindings) ##
bind "set completion-ignore-case on"    # case insensitive file completion
bind "set completion-map-case on"       # hyphens and underscores the same
bind "set show-all-if-ambiguous on"     # show matches if ambiguous on tab
bind "set mark-symlinked-directories on"    # auto add slash to dir symlinks

# SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
  # complete -o default -W "$(cat ~/.ssh/known_hosts | sed 's/[, ].*//' | sort | uniq | grep -v '[0-9]')" ssh scp sftp
  complete -o default -W \
      "echo $(cat ~/.ssh/config | grep 'Host ' | sort | uniq | cut -d' ' -f2) \
      $(cat ~/.ssh/known_hosts  | cut -d ' ' -f1 | grep ',' | cut -d ',' -f1)" \
      ssh scp sftp
fi

# Better completion for killall.
_killall()
{
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    #  Get a list of processes
    #+ (the first sed evaluation
    #+ takes care of swapped out processes, the second
    #+ takes care of getting the basename of the process).
    COMPREPLY=( $( ps -u $USER -o comm  | \
        sed -e '1,1d' -e 's#[]\[]##g' -e 's#^.*/##'| \
        awk '{if ($0 ~ /^'$cur'/) print $0}' ))

    return 0
}
complete -F _killall killall

# When completing cd and rmdir, only dirs should be possible option (default is
# all files on Mac).
complete -d cd rmdir

## SANE HISTORY DEFAULTS ##
shopt -s histappend     # Append to the history file, don't overwrite it
shopt -s histverify     # Edit a recalled history line before executing
shopt -s cmdhist        # Save multi-line commands as one command

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

if [[ -f "$XDG_CONFIG_HOME/bash/completion" ]]; then
    source "$XDG_CONFIG_HOME/bash/completion"
fi
if [[ -f "$XDG_CONFIG_HOME/bash/aliases" ]]; then
    source "$XDG_CONFIG_HOME/bash/aliases"
fi

export ITERM2_SQUELCH_MARK=1
test -e "$XDG_CONFIG_HOME/iterm2/.iterm2_shell_integration.bash" && source "$XDG_CONFIG_HOME/iterm2/.iterm2_shell_integration.bash"
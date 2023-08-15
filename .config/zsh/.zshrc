#!/bin/zsh
# .zshrc
#   zshenv -> zprofile -> zshrc (current)
#
# | zshenv   : always
# | zprofile : if login shell
# | zshrc    : if interactive shell
# | zlogin   : if login shell, after zshrc
# | zlogout  : if login shell, after logout
#
# https://zsh.sourceforge.io/Doc/Release/Files.html#Files
#

# Zsh options.

# zmodload zsh/zprof

export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh-history"
# export HISTFILE="${XDG_STATE_HOME:-${HOME}/.local/state}/zsh/history"
HISTSIZE=15000
SAVEHIST=10000
HIST_STAMPS="yyyy-mm-dd"
HISTCONTROL=ignoredups

. ${ZDOTDIR:-$HOME}/aliases.zsh

#  brew initialize all completions
# if type brew &>/dev/null; then
#   FPATH=$BREW_PREFIX/share/zsh/site-functions:$FPATH
#   FPATH=$BREW_PREFIX/share/zsh-completions:$FPATH
# fi

fpath+=("$BREW_PREFIX/share/zsh-completions")
fpath+=("$BREW_PREFIX/share/zsh/site-functions")
fpath+=("$ZDOTDIR/zsh-completions")

# export EDITOR="${EDITOR:-vim}"
# export VISUAL="${VISUAL:-vim}"
# export PAGER="${PAGER:-less}"
export EDITOR='vim'
export VISUAL='subl -w'
# https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=1
export COLORTERM="truecolor"
export GPG_TTY=$(tty)

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

# Make less more friendly for non-text input files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && export LESSOPEN="|lesspipe %s"

# sane moving between words on the prompt
export WORDCHARS='~!#$%^&*(){}[]<>?.+;'
# Remove the forward slash and hyphen characters from what is considered part
# of a word so meta+f and meta+b will stop at directory boundaries.
export WORDCHARS=${WORDCHARS//[\/]}

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# configure colors for less (man pages, searching, etc.)
# export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)    # red
# export LESS_TERMCAP_md=$(tput bold; tput setaf 4)    # blue
# export LESS_TERMCAP_me=$(tput sgr0)
# export LESS_TERMCAP_so=$(tput setaf 7; tput setab 5) # white on magenta
# export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# export LESS_TERMCAP_us=$(tput smul; tput setaf 7)    # white
# export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
# export LESS_TERMCAP_mr=$(tput rev)
# export LESS_TERMCAP_mh=$(tput dim)
# export LESS_TERMCAP_ZN=$(tput ssubm)
# export LESS_TERMCAP_ZV=$(tput rsubm)
# export LESS_TERMCAP_ZO=$(tput ssupm)
# export LESS_TERMCAP_ZW=$(tput rsupm)

# Silently load SSH keys from the keychain if needed
ssh-add -l > /dev/null || ssh-add -A 2> /dev/null

# iterm shell integration
export ITERM2_SQUELCH_MARK=1
test -e "$XDG_CONFIG_HOME/iterm2/.iterm2_shell_integration.zsh" && source "$XDG_CONFIG_HOME/iterm2/.iterm2_shell_integration.zsh" || true
# source "$XDG_CONFIG_HOME/iterm2/.iterm2_shell_integration.zsh"

# if which bat >/dev/null; then
#   export BAT_THEME="Forest%20Night%20Italic"
#   export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat"
# fi

# if type dircolors >/dev/null 2>&1; then eval "$(dircolors ~/.dircolors)"; fi
# if type thefuck >/dev/null 2>&1; then eval "$(thefuck --alias)"; fi
# if type navi >/dev/null 2>&1; then eval "$(navi widget zsh)"; fi

# if command -v thefuck >/dev/null 2>&1; then
#     eval "$(thefuck --alias)"
# fi

if type asdf &>/dev/null; then
  . "$BREW_PREFIX/opt/asdf/libexec/asdf.sh"
fi

if type fnm  &>/dev/null; then
  eval "$(fnm env)"
fi
if type frum  &>/dev/null; then
  eval "$(frum init)"
fi

# use starship prompt
if type starship  &>/dev/null; then
  eval "$(starship init zsh)"
fi

# zoxide
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi
_ZO_RESOLVE_SYMLINKS=1


# Setup fzf
if [[ ! "$PATH" == *$BREW_PREFIX/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$BREW_PREFIX/opt/fzf/bin"
fi
# if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
#   PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
# fi
# fzf Auto-completion
[[ $- == *i* ]] && source "$BREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
# [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
# fzf Key bindings
source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
# source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow"
export FZF_CTRL_T_COMMAND="fd --hidden --follow"
export FZF_ALT_C_COMMAND='fd -t d -d 1'
export FZF_ALT_C_OPTS='--preview="exa -1 --icons --git --git-ignore {}" --preview-window=right:60%:wrap'
bindkey '^F' fzf-file-widget
# # FZF custom tokyo-night theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--height=90%
--reverse
--border
--preview "cat {}"
--tabstop=4
--ansi
--no-separator
--color=fg:#a9b1d6,bg:#1a1b26,preview-fg:#c8d3f5,preview-bg:#222436,hl:#6d91de,fg+:#c0caf5,bg+:#161720,gutter:#161720,hl+:#e0af68,info:#646e9c,border:#565f89,prompt:#0db9d7,pointer:#dbc08a,marker:#9d7cd8,spinner:#9d599d,header:#61bdf2'
# # FZF options for zoxide prompt (zi)
export _ZO_FZF_OPTS=$FZF_DEFAULT_OPTS'
--height=7'

# source $BREW_PREFIX/etc/profile.d/z.sh
# noexpand_aliases+=(z)

# source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh
# source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source $BREW_PREFIX/share/zsh-abbr/zsh-abbr.zsh
# source $BREW_PREFIX/share/zsh-autopair/autopair.zsh
# source $BREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $BREW_PREFIX/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
# source ~/.config/base16-shell/base16-shell.plugin.zsh
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'
ZSH_AUTOSUGGEST_USE_ASYNC=1


# Options
# https://scriptingosx.com/2019/06/moving-to-zsh-part-3-shell-options/
# https://zsh.sourceforge.io/Doc/Release/Options.html

unsetopt flowcontrol            # disable ^S and ^Q terminal freezing

setopt auto_cd                  # cd to `dirname` w/o the cd
setopt auto_pushd               # cd push old dir onto directory stack 
setopt pushd_ignore_dups        # don't push dupes onto directory stack

setopt auto_list                # auto list choices on ambiguous completion.
setopt auto_menu                # show completion menu on successive tab
setopt glob_complete            # Show autocompletion menu with globs
setopt noshwordsplit            # use zsh style word splitting
setopt hash_list_all            # hash the entire completion command path first
setopt auto_param_slash         # add trailing `/` if completion is directory
setopt auto_param_keys          # auto remove inserted space if necessary
setopt auto_remove_slash        # auto remove `/` from dirname if necessary
setopt mark_dirs                # Append trailing `/` to expansion if dirs
setopt always_to_end            # move cursor to end after completion
setopt complete_in_word         # completion is done from both ends. 
setopt list_packed              # variable column widths
setopt list_types               # file type in completion list (ls -F)
unsetopt list_beep              # don't beep on an ambiguous completion.

setopt extended_glob            # ‘# ~ ^’ chars treated as part of patterns 
setopt nomatch                  # print error if pattern has no matches
setopt no_case_glob             # case insensitive globbing

unsetopt bang_hist              # don't do textual history expansion `!`
setopt extended_history         # save start time and duration of commands
setopt share_history            # imports new commands from and appends to hist
# setopt append_history         # covered by `share_history`
# setopt inc_append_history     # covered by `share_history`
setopt hist_expire_dups_first   # clear dupes from HISTFILE first
# setopt hist_ignore_all_dups   # don't add dupes in the first place
setopt hist_find_no_dups        # don't show dupes when searching history
setopt hist_reduce_blanks       # remove extra blanks when added to history
setopt hist_verify              # do hist expansion and reload line into buffer

setopt correct                  # try to correct the spelling of commands
setopt interactive_comments     # allow comments even in interactive shells
setopt prompt_subst             # allow variables in prompt

setopt notify                   # report status of background jobs immediately
setopt long_list_jobs           # display PID when suspending processes as well
unsetopt bg_nice                # don't run bg jobs at lower priority
setopt no_beep                  # don't beep on error in zle


autoload -Uz colors && colors              # Enable colors
# Use zmv, which is amazing
autoload -U zmv
# autoload -U promptinit && promptinit         # prompt
# autoload -Uz add-zsh-hook                  # hooks used for prompt too
# autoload -Uz vcs_info                        # hook for git prompt info

# Prompt for Corrections
# export SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
# Better spell checking & auto correction prompt
export SPROMPT="zsh: correct %F{red}'%R'%f to %F{blue}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]?"


# See http://zsh.sourceforge.net/Doc/Release/Completion-System.html.
# Should be called before compinit
zmodload -i zsh/complist
# autoload -Uz bashcompinit && bashcoompinit
autoload -Uz compinit
_comp_options+=(globdots)   # Include hidden files.
COMPLETION_WAITING_DOTS="true"

# zstyle <pattern> <style> <values>
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# completion    String acting as a namespace, to avoid pattern collisions with 
#               other scripts also using zstyle.
# <function>    Apply the style to the completion of an external function or 
#               widget.
# <completer>   Apply the style to a specific completer. We need to drop the 
#               underscore from the completer’s name here.
# <command>     Apply the style to a specific command, like cd, rm, or sed 
#               for example.
# <argument>    Apply the style to the nth option or the nth argument. 
#               It’s not available for many styles.
# <tag>         Apply the style to a specific tag.

# see http://zsh.sourceforge.net/Doc/Release/Completion-System.html

# Set the completion method. Execute in the specified order.
# _oldlist: Reuse previous completion results.
# _complete: normal completion function
# _ignored: Specify that the command is not a candidate for completion.
# _match: Completion of commands with globs such as *.
# _prefix: Ignore everything after the cursor and complete up to the cursor position.
# _approximate: Similar completion candidates are also completion candidates.
# _expand: Expand globs and variables. It allows finer control than the original expansion.
# _history: Completion from history. Used from _history_complete_word.
# _correct: Correct misspellings before completion.
# zstyle ':completion:*' completer _oldlist _complete _ignored

# Show explanation part with optional completion
zstyle ':completion:*' extra-verbose yes
# Menu selection will be started unconditionally.
zstyle ':completion:*' menu select
# Use cache for commands using cache
zstyle ':completion:*' use-cache on
# mkdir -p "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompcache" \
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompcache"
# smart-case > case-insensitive > partial-word > substring
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' completer _expand _complete _approximate _ignored _correct 
# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true
# show descriptions when autocompleting
zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' format 'Completing %d'
# set format and display of completers
# man zshmodules - Search “Colored completion listings”
# %d - description, %F{<color>} %f - fg, %K{<color>} %k - bg, %B %b - bold, %U %u - ul
zstyle ':completion:*:*:*:*:descriptions' format '%F{magenta}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
# zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:messages' format '%F{blue}%d'
# zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:warnings' format '%B%F{red}No matches for:''%F{white}%d%b'
# zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
# zstyle ':completion:*' insert-unambiguous true
# format file and folder matches
# zstyle ':completion:*' file-list all
# colorize everything - env var ZLS_COLORS to furthur customize
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' match-original both
zstyle ':completion:*' old-menu false
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

compinit -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump-${ZSH_VERSION}"
eval "$(op completion zsh)"; compdef _op op


# Initialize editing command line
autoload -U edit-command-line && zle -N edit-command-line

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# don't worry about zle. We'll go over it later in the zle section.
globalias() {
   zle _expand_alias
   zle expand-word
   zle self-insert
}
zle -N globalias

# vi mode
bindkey -v
# Time to wait for additional characters in a sequence
KEYTIMEOUT=1 # corresponds to 10ms

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^xi' vi-insert
bindkey -v '^?' backward-delete-char

# Binds shift-tab to traverse auto-completion in reverse
bindkey '^[[Z' reverse-menu-complete

zle_highlight=('paste:none')

# [[ -v ZSH_TIME_STARTUP ]] && echo $[EPOCHREALTIME-t0]
# zprof
# . "$HOME/.config/zsh/profiler.stop"

# zprof


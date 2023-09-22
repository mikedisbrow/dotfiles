#!/bin/zsh
#
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

# zmodload zsh/zprof

export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history"
HISTSIZE=15000
SAVEHIST=10000
HIST_STAMPS="yyyy-mm-dd"
HISTCONTROL=ignoredups


. ${ZDOTDIR:-$HOME}/aliases.zsh
fpath+=("$BREW_PREFIX/share/zsh-completions")
fpath+=("$BREW_PREFIX/share/zsh/site-functions")
fpath+=("$ZDOTDIR/zsh-completions")
fpath+=("$ZDOTDIR/zsh-functions")

export EDITOR="vim"
export VISUAL="subl -w"

# https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=1
# export COLORTERM="truecolor"
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
# export LESSHISTFILE="$XDG_CACHE_HOME/less/less_history"
# export LESSKEY="$XDG_CACHE_HOME/less/lesskey"
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# sane moving between words on the prompt
export WORDCHARS='~!#$%^&*(){}[]<>?.+;'
# Remove the forward slash and hyphen characters from what is considered part
# of a word so meta+f and meta+b will stop at directory boundaries.
export WORDCHARS=${WORDCHARS//[\/]}

# configure colors for less (man pages, searching, etc.)
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)    # red
export LESS_TERMCAP_md=$(tput bold; tput setaf 4)    # blue
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 7; tput setab 5)    # bold white on magenta
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)    # bold white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)


# Extras ######################################################################

# Silently load SSH keys from the keychain if needed
ssh-add -l > /dev/null || ssh-add -A 2> /dev/null

# print a message on SSH connection:
if [[ -n "$SSH_CLIENT" ]]; then
  # ssh connection, print hostname and os version
  echo "Welcome to $(scutil --get ComputerName) ($(sw_vers -productVersion))"
fi

# iterm shell integration
export ITERM2_SQUELCH_MARK=1
test -e "$XDG_CONFIG_HOME/iterm2/.iterm2_shell_integration.zsh" && source "$XDG_CONFIG_HOME/iterm2/.iterm2_shell_integration.zsh" || true
# source "$XDG_CONFIG_HOME/iterm2/.iterm2_shell_integration.zsh"


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
  eval $(gdircolors "$XDG_CONFIG_HOME"/dircolors/dircolors.ansi-universal)
fi

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
# fzf Auto-completion
[[ $- == *i* ]] && source "$BREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
# fzf Key bindings
source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude .git --color=always"
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview="bat --color=always --style=header {} 2>/dev/null" --preview-window=right:60%:wrap'
export FZF_ALT_C_COMMAND='fd -t d -d 1'
export FZF_ALT_C_OPTS='--preview="exa -1 --icons --git --git-ignore {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_OPTS="--ansi"
bindkey '^F' fzf-file-widget
# FZF custom tokyo-night theme
# --color=fg:#a9b1d6,bg:#1a1b26,preview-fg:#c8d3f5,preview-bg:#222436,hl:#6d91de,fg+:#c0caf5,bg+:#161720,gutter:#161720,hl+:#e0af68,info:#646e9c,border:#565f89,prompt:#0db9d7,pointer:#dbc08a,marker:#9d7cd8,spinner:#9d599d,header:#61bdf2



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


# Options #####################################################################
# https://scriptingosx.com/2019/06/moving-to-zsh-part-3-shell-options/
# https://zsh.sourceforge.io/Doc/Release/Options.html
###############################################################################

unsetopt flowcontrol            # disable ctrl+S and ctrl+Q terminal freezing

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
# Enable zmv http://onethingwell.org/post/24608988305/zmv
autoload -U zmv
# autoload -U promptinit && promptinit         # prompt
# autoload -Uz add-zsh-hook                  # hooks used for prompt too
# autoload -Uz vcs_info                        # hook for git prompt info

# Prompt for Corrections
# export SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
# Better spell checking & auto correction prompt
export SPROMPT="zsh: correct %F{red}'%R'%f to %F{blue}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]?"


# Completion ##################################################################

# See http://zsh.sourceforge.net/Doc/Release/Completion-System.html.
# Should be called before compinit
zmodload -i zsh/complist
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

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
# mkdir -p "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompcache" \
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompcache"

# smart-case > case-insensitive > partial-word > substring
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' completer _expand _complete _match _approximate
# Increase the number of errors based on the length of the typed word
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) numeric )'
# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true
# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true
# Menu selection will be started unconditionally.
zstyle ':completion:*' menu select
# Make completion stops at the first ambiguous component
zstyle ':completion:*' ambiguous true
zstyle ':completion:*' insert-unambiguous true
# In a dir with 'foo' and 'foo-bar' directories, makes 'foo' match both, and 'foo/' match only 'foo'
# Does _not_ block partial path completions like '/u/b/foo'
zstyle ':completion:*' accept-exact-dirs true
# Directories first when completing files
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' match-original both
zstyle ':completion:*' old-menu false
# When corrections are needed/triggered, always give ability to select the original text
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'

# Separate matches into groups of their tag name
zstyle ':completion:*' group true
# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

# Describe options in full
zstyle ':completion:*:options' description true
zstyle ':completion:*:options' auto-description "specify: %d"

zstyle ':completion:*' verbose yes
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
# zstyle ':completion:*' list-separator '→'
# show descriptions when autocompleting
zstyle ':completion:*' auto-description '%d'
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes


# set format and display of completers
# man zshmodules - Search “Colored completion listings”
# %d - description, %F{<color>} %f - fg, %K{<color>} %k - bg, %B %b - bold, %U %u - ul
zstyle ':completion:*:descriptions' format "%F{yellow}%B>>> %d %b%f"
zstyle ':completion:*:corrections' format ' %F{8}correction:%f %B%F{green}%d (errors: %f%F{red}%e%f%F{green})%f%b'
zstyle ':completion:*:messages' format ' %F{8}message:%f %B%F{magenta}%d%f%b'
zstyle ':completion:*:warnings' format "%F{red}!! No matches for:%f %d"
zstyle ':completion:*' format ' %F{8}completion:%f %B%F{yellow}%d%f%b'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*:default' select-prompt '%B%S%M%b matches, current selection at %p%s'
zstyle ':completion:*:options' auto-description ' %F{8}specify:%f %B%F{cyan}%d%f%b'


# colorize everything - env var ZLS_COLORS to furthur customize
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''

# Complete man page sections
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Don't complete unavailable commands
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Array completion element sorting
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

zstyle ':completion:*' squeeze-slashes true
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# command completion: highlight matching part of command, and
zstyle -e ':completion:*:-command-:*:commands' list-colors 'reply=( '\''=(#b)('\''$words[CURRENT]'\''|)*-- #(*)=0=38;5;45=38;5;136'\'' '\''=(#b)('\''$words[CURRENT]'\''|)*=0=38;5;45'\'' )'

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# Show explanation part with optional completion
zstyle ':completion:*' extra-verbose yes
# make them a little less short, after all (mostly adds -l option to the whatis calll)
zstyle ':completion:*:command-descriptions' command '_call_whatis -l -s 1 -r .\*; _call_whatis -l -s 6 -r .\* 2>/dev/null'

# Environmental Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Populate hostname completion
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//,/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# SSH/SCP/RSYNC
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*.*' loopback localhost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^*.*' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^<->.<->.<->.<->' '127.0.0.<->'

compinit -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump-${ZSH_VERSION}"

# 1password completions
eval "$(op completion zsh)"; compdef _op op
# enable bash completions too
autoload -Uz bashcompinit && bashcompinit
# autoload -Uz +X bashcompinit
# bashcompinit -D


# Keys ########################################################################
#     ^ - Represent the CTRL key. For example: ^c for CTRL+c.
#     \e - Represent the ALT key. For example: \ec for ALT+c.
#     bindkey <keystroke> <widget>

# vi mode
bindkey -v
# faster keytimeout 10ms
export KEYTIMEOUT=1

# Initialize editing command line
autoload -Uz edit-command-line
zle -N edit-command-line
# bindkey "^X^E" edit-command-line

# Use default provided history search widgets
autoload -Uz up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N down-line-or-beginning-search

# # Change cursor shape for different vi modes.
# function zle-keymap-select () {
#     case $KEYMAP in
#         vicmd) echo -ne '\e[1 q';;      # block
#         viins|main) echo -ne '\e[5 q';; # beam
#     esac
# }
# zle -N zle-keymap-select
# # Start in insert mode
# zle-line-init() {
#   # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     zle -K viins
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# # Use beam shape cursor on startup
# echo -ne '\e[5 q'
# # Use beam shape cursor for each new prompt
# preexec() { echo -ne '\e[5 q' ;}

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^xi' vi-insert
bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xh' accept-and-hold
bindkey -M menuselect '^xn' accept-and-infer-next-history
bindkey -M menuselect '^xu' undo
bindkey -M menuselect '^[[Z' reverse-menu-complete

# [[ -v ZSH_TIME_STARTUP ]] && echo $[EPOCHREALTIME-t0]
# zprof
# . "$HOME/.config/zsh/profiler.stop"

# zprof

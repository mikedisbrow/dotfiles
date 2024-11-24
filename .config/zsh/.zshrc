#!/usr/bin/env zsh
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
# -----------------------------------------------------------------------------

# zmodload zsh/zprof

export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history"
HISTSIZE=15000
SAVEHIST=10000
HIST_STAMPS="yyyy-mm-dd"
HISTCONTROL=ignoredups


. ${ZDOTDIR:-$HOME}/aliases.zsh
fpath+=("/opt/homebrew/share/zsh-completions")
fpath+=("/opt/homebrew/share/zsh/site-functions")
fpath+=("$ZDOTDIR/zsh-completions")
fpath+=("$ZDOTDIR/zsh-functions")
path+=("$HOME/.local/bin")

## MANPATH
# Linux
test -d '/usr/local/man' &&
  MANPATH='/usr/local/man'"${MANPATH:+:${MANPATH-}}"
# macOS
test -d '/usr/share/man' &&
  MANPATH='/usr/share/man'"${MANPATH:+:${MANPATH-}}"
# if `man -w` does not fail, then add it to `$MANPATH`
command man -w >/dev/null 2>&1 &&
  MANPATH="${MANPATH:+${MANPATH-}:}$(command man -w)"

## EDITOR
EDITOR="$(
  command -v -- nvim ||
    command -v -- vim ||
    command -v -- vi
)"
if test -n "${EDITOR-}"; then
  export EDITOR
  alias e='command "${EDITOR-}"'
  export VISUAL="${VISUAL:-${EDITOR-}}"
fi

# export EDITOR="${EDITOR:-vim}"
# export VISUAL="${VISUAL:-vim}"
# export PAGER="${PAGER:-less}"
export VISUAL="subl -w"

# Use Neovim as "preferred editor"
# export EDITOR="nvim"

# Use Neovim as man pager
# export MANPAGER="nvim +Man!"
# export MANWIDTH=999

# https://geoff.greer.fm/lscolors/
export LSCOLORS="ExFxCxdxBxegedabagacad"
export LS_COLORS="di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30"
# export ZLS_COLORS=$LS_COLORS
export CLICOLOR=1
# export LS_COLORS=$(vivid generate ayu)
# export COLORTERM="truecolor"

## GPG
# sign with macOS-compatible Linux
# https://docs.github.com/en/github/authenticating-to-github/telling-git-about-your-signing-key#telling-git-about-your-gpg-key
# https://reddit.com/comments/dk53ow#t1_f50146x
# https://github.com/romkatv/powerlevel10k/commit/faddef4
export GPG_TTY="${TTY-}"

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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# sane moving between words on the prompt
export WORDCHARS='~!#$%^&*(){}[]<>?.+;'
# Remove the forward slash and hyphen characters from what is considered part
# of a word so meta+f and meta+b will stop at directory boundaries.
export WORDCHARS=${WORDCHARS//[\/]}

# highlighting inside manpages and elsewhere
# export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
# export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
# export LESS_TERMCAP_me=$'\E[0m'           # end mode
# export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
# export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
# export LESS_TERMCAP_ue=$'\E[0m'           # end underline
# export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

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

if command -v thefuck >/dev/null 2>&1; then
    eval "$(thefuck --alias)"
fi

# Append Cargo to path, if it's installed
if [[ -d "${XDG_DATA_HOME%/}"'/cargo/bin' ]]; then
  export PATH="${XDG_DATA_HOME%/}"'/cargo/bin'"${PATH:+:${PATH-}}"
fi

if type dircolors >/dev/null 2>&1; then 
  eval $(dircolors "$XDG_CONFIG_HOME"/dircolors/dircolors.ansi-universal)
elif type dircolors >/dev/null 2>&1; then 
  eval $(gdircolors "$XDG_CONFIG_HOME"/dircolors/dircolors.ansi-universal)
fi

if type asdf &>/dev/null; then
  . "/opt/homebrew/opt/asdf/libexec/asdf.sh"
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
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi
# fzf Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
# fzf Key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"


if command -v "fd" > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
elif command -v "rg" > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,target}/*" 2> /dev/null'
elif command -v "ag" > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview="bat --color=always --style=header {} 2>/dev/null" --preview-window=right:60%:wrap'
bindkey '^F' fzf-file-widget

# FZF custom tokyo-night theme
# --color=fg:#a9b1d6,bg:#1a1b26,preview-fg:#c8d3f5,preview-bg:#222436,hl:#6d91de,fg+:#c0caf5,bg+:#161720,gutter:#161720,hl+:#e0af68,info:#646e9c,border:#565f89,prompt:#0db9d7,pointer:#dbc08a,marker:#9d7cd8,spinner:#9d599d,header:#61bdf2
export FZF_DEFAULT_OPTS="--ansi --layout=reverse"
export FZF_COMPLETION_TRIGGER=".."
# source /opt/homebrew/etc/profile.d/z.sh
# noexpand_aliases+=(z)

# source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /opt/homebrew/share/zsh-abbr/zsh-abbr.zsh
# source /opt/homebrew/share/zsh-autopair/autopair.zsh
# source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
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

stty stop undef                 # Disable ctrl-s to freeze terminal.
# Allow <C-s> to pass through to shell and programs
stty -ixon -ixoff
# dot not print meta chars, e.g. `ˆC` when <C-c> is pressed to escape a command
stty -echoctl

autoload -Uz colors && colors              # Enable colors
# Enable zmv http://onethingwell.org/post/24608988305/zmv
autoload -U zmv
autoload -Uz run-help
autoload -Uz is-at-least
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
zstyle ':completion:*' completer _complete _match _approximate _expand _prefix
# Increase the number of errors based on the length of the typed word. But make
# sure to cap (at 7) the max-errors to avoid hanging.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'
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
zstyle ':completion:*' word true
zstyle ':completion:*' add-space true
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
# format file and folder matches
zstyle ':completion:*' file-list all
zstyle ':completion:*' list-separator '→'
# show descriptions when autocompleting
zstyle ':completion:*' auto-description '%d'
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes


# set format and display of completers
# man zshmodules - Search “Colored completion listings”
# %d - description, %F{<color>} %f - fg, %K{<color>} %k - bg, %B %b - bold, %U %u - ul
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{magenta}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{blue} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# zstyle ':completion:*' select-prompt '%K{236} :: %F{33}match %B%m%b%f%K{236} (scroll at %p) :: %k'
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*:default' select-prompt '%B%S%M%b matches, current selection at %p%s'
zstyle ':completion:*:options' auto-description ' %F{8}specify:%f %B%F{cyan}%d%f%b'


# colorize everything - env var ZLS_COLORS to furthur customize
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''

# highlight prefix
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")'

# # -- colorful completions! \o/

# # Import color helpers for the special syntax of 'list-colors' style
# autoload -U colors && colors
# # my magenta is actually orange!
# color[orange]="${color[magenta]}"
# color[bg-orange]="${color[bg-magenta]}"
# # TODO: have a 'color2' helper for the 256 color palette, like `${color2[166]}` `${color2[bg-166]}`
# #   In 256 color palette: '48;5;XYZ' sets color XYZ as bg color, '38;5;XYZ' for fg.

# zstyle ':completion:*' list-colors true

# # Color the options but not their description
# # (from: https://github.com/nakal/shell-setup/blob/89913cc2befb22e/shell/zsh/.zsh/completion.zsh#L23)
# # note: first spec is for options with description, second spec is for options without description
# zstyle ':completion:*:options'        list-colors \
#   "=(#b)(-*) -- *=0=${color[green]}" \
#   "=^(-- )*=${color[green]}"

# zstyle ':completion:*:commands'       list-colors "=*=${color[green]}"
# zstyle ':completion:*:functions'      list-colors "=*=${color[cyan]}"
# zstyle ':completion:*:parameters'     list-colors "=*=${color[red]}"
# zstyle ':completion:*:aliases'        list-colors "=*=${color[cyan]};${color[bold]}"
# zstyle ':completion:*:builtins'       list-colors "=*=${color[orange]}"
# zstyle ':completion:*:reserved-words' list-colors "=*=${color[black]};${color[bold]}"
# zstyle ':completion:*:original'       list-colors "=*=${color[red]};${color[bold]}"

# # For the default LS_COLORS, it is defined a bit later instead, where we also add elements
# # to customize the colors of the completion menu.
# # zstyle ':completion:*:default'        list-colors ${(s.:.)LS_COLORS}

# # This example 'tries' to highlight the currently matching text for commands
# # (taken from https://github.com/stevenspasbo/dotfiles/blob/6401cff4cd3/dotfiles/zsh-custom/config/completion.zsh#L81)
# # BUT it's not perfect: (TODO (feature req?))
# # - doesn't work when Backspace-ing in interactive menu mode..
# # - or in isearch menu mode..
# # - or with matcher-list matches (which are not necessarily at the beginning of the entry)
# # NOTE: we need 'zstyle -e' with a 'reply=(..)' to have access to '$words' special completion var.
# # zstyle -e ':completion:*:commands' list-colors 'reply=( "=(#b)($words[CURRENT]|)*='"${color[green]}=${color[green]};${color[underline]}"'" )'


# # for kill program (example, to show capability)
# zstyle ':completion:*:*:kill:*' list-colors '=(#b) #([0-9]#)*( *[a-z])*='"${color[red]}=${color[blue]}=${color[yellow]}"

# zstyle ':completion:*:*:git*:*:commits*' list-colors "=(#b)(*) -- *=0=${color[cyan]}"

# # for just's receipe (color args & description)
# # format is `the-receipe -- Args: FOO # Receipe description`
# zstyle ':completion:*:*:just:*:argument-1'  list-colors "=(#b)* (-- *) (\#*)=0=${color[blue]}=${color[green]}"


# # Custom color for the menu completion (let's try!)
# #
# # --- From man zshmodules, in the `Colored completion listings` section (of zsh/complist module):
# # > When printing a match, the code prints the value of `lc`, the value for the file-type or the
# # > last matching specification with a `*', the value of `rc`, the string to display for the
# # > match itself, and then the value of `ec` if that is defined or the values of `lc`, `no`,
# # > and `rc` if `ec` is not defined.
# # --- And a bit lower, in the `Menu selection` section:
# # > In the list one match is highlighted using the value for `ma`. (The default value for this
# # > is `7' which forces the selected match to be highlighted using standout mode)
# #
# # Interesting capabilities for menu entries (with their default value + description)
# #    no 0     for normal text (i.e. when displaying something other than a matched file)
# #    lc \e[   for the left code
# #    rc m     for the right code
# #    tc 0     for the character indicating the file type  printed after filenames if the LIST_TYPES option is set
# #    sp 0     for the spaces printed after matches to align the next column
# #    ec none  for the end code
# #    ma 7     for the highlighted match   (<- we change this!)
# #
# zstyle ':completion:*' list-colors \
#   ${(s.:.)LS_COLORS} \
#   "ma=${color[bg-orange]};${color[white]};${color[bold]}"
#   # TODO? use a slightly less bright white fg?
#   # Alternative with a less bright bg orange, 130 (in 256 color palette):
#   # "ma=48;5;130;${color[white]};${color[bold]}"

zstyle ':completion:*:*:cp:*' file-sort modification reverse

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
# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# SSH/SCP/RSYNC
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# auto rehash
zstyle ':completion:*' rehash true

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

# Initialize editing command line
autoload -Uz edit-command-line
zle -N edit-command-line
# bindkey "^X^E" edit-command-line

# Ctrl+W stops on path delimiters
autoload -Uz select-word-style
select-word-style bash

# Enable run-help module
(( $+aliases[run-help] )) && unalias run-help
autoload -Uz run-help
alias help=run-help

# enable bracketed paste
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# TODO: Breaks ZSH highlighting ???
# enable url-quote-magic
# autoload -Uz url-quote-magic
# zle -N self-insert url-quote-magic

# Use default provided history search widgets
autoload -Uz up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N down-line-or-beginning-search

# don't worry about zle. We'll go over it later in the zle section.
globalias() {
   zle _expand_alias
   zle expand-word
   zle self-insert
}
zle -N globalias

# vi mode
bindkey -v
zmodload zsh/terminfo
# Time to wait for additional characters in a sequence
export KEYTIMEOUT=1 # corresponds to 10ms



typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
key[Backspace]=${terminfo[kbs]}
key[ShiftTab]=${terminfo[kcbt]}
# man 5 user_caps
key[CtrlLeft]=${terminfo[kLFT5]}
key[CtrlRight]=${terminfo[kRIT5]}

[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search
[[ -n "${key[Left]}" ]] && bindkey -- "${key[Left]}" backward-char
[[ -n "${key[Right]}" ]] && bindkey -- "${key[Right]}" forward-char
[[ -n "${key[PageUp]}" ]] && bindkey -- "${key[PageUp]}" beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]] && bindkey -- "${key[PageDown]}" end-of-buffer-or-history
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[ShiftTab]}" ]] && bindkey -- "${key[ShiftTab]}" reverse-menu-complete
[[ -n "${key[CtrlLeft]}" ]] && bindkey -- "${key[CtrlLeft]}" backward-word
[[ -n "${key[CtrlRight]}" ]] && bindkey -- "${key[CtrlRight]}" forward-word
[[ -n "${key[Home]}" ]] && bindkey -- "${key[Home]}" beginning-of-line
[[ -n "${key[End]}" ]] && bindkey -- "${key[End]}" end-of-line
[[ -n "${key[Insert]}" ]] && bindkey -- "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]] && bindkey -- "${key[Delete]}" delete-char
unset key



# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
# Start in insert mode
zle-line-init() {
  # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    zle -K viins 
    echo -ne "\e[5 q"
}
zle -N zle-line-init
# Use beam shape cursor on startup
echo -ne '\e[5 q' 
# Use beam shape cursor for each new prompt
preexec() { echo -ne '\e[5 q' ;} 


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

# Mimic Tim Pope’s Vim surround plugin
# When in normal mode, use:
# - cs (change surrounding)
# - ds (delete surrounding)
# - ys (add surrounding)

autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# make terminal command navigation sane again

# [Ctrl-right] - forward one word
bindkey "^[[1;5C" forward-word                      
# [Ctrl-left] - backward one word
bindkey "^[[1;5D" backward-word                     
# [Ctrl-right] - forward one word
bindkey '^[^[[C' forward-word                       
# [Ctrl-left] - backward one word
bindkey '^[^[[D' backward-word                      
# [Alt-left] - beginning of line
bindkey '^[[1;3D' beginning-of-line                 
# [Alt-right] - end of line
bindkey '^[[1;3C' end-of-line                       
# [Alt-left] - beginning of line
bindkey '^[[5D' beginning-of-line                   
# [Alt-right] - end of line
bindkey '^[[5C' end-of-line                         
# [Backspace] - delete backward
bindkey '^?' backward-delete-char

if [[ "${terminfo[kdch1]}" != "" ]]; then
    # [Delete] - delete forward
    bindkey "${terminfo[kdch1]}" delete-char        
else
    # [Delete] - delete forward
    bindkey "^[[3~" delete-char                     
    bindkey "^[3;5~" delete-char
    bindkey "\e[3~" delete-char
fi

bindkey "^A" vi-beginning-of-line
# [Ctrl-f] - move to next word
bindkey -M viins "^F" vi-forward-word               
# [Ctrl-e] - move to end of line
bindkey -M viins "^E" vi-add-eol

# [Ctrl-backspace] - delete word
bindkey '^H' backward-kill-word
# [Ctrl-delete] - delete word
bindkey "^[3;5~" kill-word
bindkey "^[3;3~" kill-word

# [Ctrl - Shift - Delete]
bindkey "^[3;6~" kill-line
                    
bindkey "^J" history-beginning-search-forward
bindkey "^K" history-beginning-search-backward

# Binds shift-tab to traverse auto-completion in reverse
bindkey '^[[Z' reverse-menu-complete

# Allow alt/option . to insert the argument from the previous command
bindkey '\e.' insert-last-word

# allow ctrl+a and ctrl+e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# alt+q to push current line and fetch again on next line
bindkey '\eq' push-line

# show man page of current command with alt+h
bindkey '\eh' run-help

# Stop highlighting text when it's pasted. zle_bracketed_paste is a feature to
# not allow multiline pastes while executing each line. I do this all the time
# when I accidentally paste an entire file into my zsh buffer. When this feature
# was added in zsh 5.1, I'm not sure if I didn't notice it, or the highlighting
# options didn't exist, but originally I disabled it all together with:
# unset zle_bracketed_paste
# But now we can just disable the highlighting that adds a lot of visual churn,
# but keep the feature for our own sanity.
zle_highlight=('paste:none')


# This inserts a tab after completing a redirect. You want this.
# (Source: http://www.zsh.org/mla/users/2006/msg00690.html)
self-insert-redir() {
integer l=$#LBUFFER
zle self-insert
(( $l >= $#LBUFFER )) && LBUFFER[-1]=" $LBUFFER[-1]"
}
zle -N self-insert-redir
for op in \| \< \> \& ; do
  bindkey "$op" self-insert-redir
done


# Create login shortcuts from SSH config file, which has 'Host' directives.
# (If you set up an ssh host in .ssh/config, it become an alias, unless an alias
# with that name already exists.)
if [ -e "$HOME/.ssh/config" -a ! -e "$HOME/.ssh/skip-host-aliases" ]; then
  for host in $(grep -E '^Host +\w+$' $HOME/.ssh/config | awk '{print $2}'); do
    if ! _try which $host; then
      alias $host="ssh $host"
    fi
  done
fi




# [[ -v ZSH_TIME_STARTUP ]] && echo $[EPOCHREALTIME-t0]
# zprof
# . "$HOME/.config/zsh/profiler.stop"

# zprof


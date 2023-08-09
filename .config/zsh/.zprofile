#!/bin/zsh
# .zprofile
#   zshenv -> zprofile (current) -> zshrc
#
# | zshenv   : always
# | zprofile : if login shell
# | zshrc    : if interactive shell
# | zlogin   : if login shell, after zshrc
# | zlogout  : if login shell, after logout
#
# https://zsh.sourceforge.io/Doc/Release/Files.html#Files
#

if [ "$(arch)" = arm64 ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# eval "$(/opt/homebrew/bin/brew shellenv)"
# eval "$(/usr/local/bin/brew shellenv)"
# eval "$(/opt/homebrew/bin/brew shellenv)"
# output is -
# export HOMEBREW_PREFIX="/usr/local"
# export HOMEBREW_CELLAR="/usr/local/Cellar"
# export HOMEBREW_REPOSITORY="/usr/local/Homebrew"
# export PATH="/usr/local/bin:/usr/local/sbin${PATH+:$PATH}"
# export MANPATH="/usr/local/share/man${MANPATH+:$MANPATH}:"
# export INFOPATH="/usr/local/share/info:${INFOPATH:-}"
export HOMEBREW_NO_ANALYTICS=1  # disables statistics that brew collects

# Correctly display UTF-8 with combining characters.
# This code seems to come from the default OSX OhMyZsh.
if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
  setopt combiningchars
fi
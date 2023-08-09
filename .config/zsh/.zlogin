#!/bin/zsh
# .zlogin
#   zshenv -> zprofile -> zshrc -> zlogin (current) 
#
# | zshenv   : always
# | zprofile : if login shell
# | zshrc    : if interactive shell
# | zlogin   : if login shell, after zshrc
# | zlogout  : if login shell, after logout
#
# https://zsh.sourceforge.io/Doc/Release/Files.html#Files
#

# Data directory should be created manually since zsh doesn't conform to
# XDG Base Directory specification.
if (! [[ -d "$HOME/.local/share/zsh" ]]) {
  command mkdir -p "$HOME/.local/share/zsh"
}

# Asynchronously zcompile .zcompdump file.
# Compile zcompdump, if modified, to increase startup speed.
{
  typeset -g zcompdump="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump-${ZSH_VERSION}"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!


# nvm -- sourcing is very slow, use lazy load
# if [[ -f "$HOME/.nvm/nvm.sh" ]]; then
#   function nvm() {
#     unfunction nvm
#     source "$HOME/.nvm/nvm.sh"
#     nvm "$@"
#   }
# fi
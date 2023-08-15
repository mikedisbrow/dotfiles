#!/bin/zsh
# /etc/zsh/zshenv: system-wide .zshenv file for zsh(1).
#
# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# Note: The shebang #!/bin/zsh is strictly necessary for executable scripts
# only, but without it, you might not always get correct syntax highlighting
# when viewing the code.

# zmodload zsh/datetime
# [[ -v ZSH_TIME_STARTUP ]] && t0=$EPOCHREALTIME
# . "$HOME/.config/zsh/profiler.start"

## XDG  Base Directory
# https://specifications.freedesktop.org/basedir-spec/latest/
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
## (( ${+*} )) = if variable is set don't set it anymore. or use [[ -z ${*} ]]

# Set XDG base dirs
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_RUNTIME_HOME=${XDG_RUNTIME_HOME:-$HOME/.tmp}

export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
# export XDG_PUBLICSHARE_DIR="$HOME/Public"
# export XDG_TEMPLATES_DIR="$HOME/GitHub/Templates"
export XDG_VIDEOS_DIR="$HOME/Movies"

# Set ZDOTDIR if you want to re-home Zsh.
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
# export ZHOMEDIR=$HOME/.config/zsh
# export ZRCDIR=$ZHOMEDIR/rc
# export ZDATADIR=$XDG_DATA_HOME/zsh
# export ZCACHEDIR=$XDG_CACHE_HOME/zsh
export ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
export ZPLUGINDIR=${ZPLUGINDIR:-$ZDOTDIR/plugins}
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"

# Package managers etc.
export FRUM_DIR="$XDG_DATA_HOME/frum"
export FNM_DIR="$XDG_DATA_HOME/fnm"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export UMCONFIG_HOME="$XDG_CONFIG_HOME/um/umconfig"
# export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
# export VOLTA_HOME=${VOLTA_HOME:-$XDG_CONFIG_HOME/volta}
# export NVM_DIR="$XDG_CONFIG_HOME"/nvm
# export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
# export CARGO_HOME="$XDG_DATA_HOME/cargo"
# export GOPATH="$XDG_DATA_HOME/go"
# export GEM_HOME="$XDG_DATA_HOME/gem"
# export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
# export BUNDLE_USER_HOME="$XDG_DATA_HOME/bundle"
# export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle/cache"
# export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
# export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle/plugin"
# export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
# export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
# export PYTHONHISTORY="${XDG_CACHE_HOME:-$HOME/.cache}/python/history" # This will work once https://github.com/python/cpython/pull/13208 gets merged...

# CLI utils, etc.
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/ripgrep/ripgreprc"
export BAT_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/bat"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/readline/inputrc"
export TEALDEER_CONFIG_DIR="/Users/miked/.config/tealdeer"
# export CHEAT_CONFIG_PATH="$XDG_CONFIG_HOME/cheat/conf.yml"
# export CHTSH=${XDG_CONFIG_HOME:-$HOME/cht.sh}
# export CHTSH_CONF="$XDG_CONFIG_HOME/cht.sh/cht.sh.conf"
export _Z_DATA="$XDG_DATA_HOME/z/z-history"
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship/cache"

export SYNC_DIR="${HOME}/Dropbox"
export ICLOUD_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
export ICLOUD_DOCUMENTS_DIR="${ICLOUD_DIR}/Documents"
export DOCUMENTS_DIR="${ICLOUD_DOCUMENTS_DIR}"
export OBSIDIAN_VAULT_DIR="${ICLOUD_DIR}/Documents/_notes/vault"

# shellcheck opts to avoid having .shellcheckrc in ~ (https://github.com/koalaman/shellcheck/wiki)
# export SHELLCHECK_OPTS='--exclude=SC1003,SC1071,SC1087,SC1090,SC1091,SC2001,SC2015,SC2034,SC2038,SC2059,SC2068,SC2086,SC2115,SC2128,SC2139,SC2145,SC2153,SC2155,SC2164'

# Owner / Group / Others
# 0 rwx / 1 rw- / 2 r-x / 3 r-- / 4 -wx / 5 -w- / 6 --x / 7 ---
# 
# umask 077 - only you
# Permissions when creating files
# default directory permissions are 755 and default file permissions are 644
umask 022

export skip_global_compinit=1
export KEYTIMEOUT=1
export SHELL_SESSIONS_DISABLE=1 # Make Apple Terminal behave.
# your default editor
export EDITOR='vim'
export VEDITOR='subl -w'
export SYSTEM=$(uname -s)

# Force gpg-agent to use the current tty
tty_path=$(tty)
export GPG_TTY=$tty_path

# Browser
# if [[ "$OSTYPE" == darwin* ]]; then
#   export BROWSER="${BROWSER:-open}"
# fi

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# set locale
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
# export LC_ALL="${LC_ALL:-en_US.UTF-8}"
# export LANG="${LANG:-en_US.UTF-8}"

# Homebrew
if [[ -e /opt/homebrew/bin/brew ]]; then
  export BREW_PREFIX=/opt/homebrew
else
  export BREW_PREFIX=/usr/local
fi

# Correctly display UTF-8 with combining characters.
# This code seems to come from the default OSX OhMyZsh.
if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
  setopt combiningchars
fi

if [[ $(uname -s) = Darwin ]]; then
  # Override insanely low open file limits on macOS.
  ulimit -n 65536
  ulimit -u 1064
fi

##############################################################
# PATH.
# (N-/): do not register if the directory does not exists
# (Nn[-1]-/)
#
#  N   : NULL_GLOB option (ignore path if the path does not match the glob)
#  n   : Sort the output
#  [-1]: Select the last item in the array
#  -   : follow the symbol links
#  /   : ignore files
#  t   : tail of the path
##############################################################

# path=(
#   ${ZDOTDIR}/bin
#   ${HOME}/.local/bin(N-/)
#   # ${CARGO_HOME}/bin(N-/)
#   ${GOBIN}(N-/)
#   $path
#   /opt/homebrew/bin(N-/) # For M1/2 machines
#   /usr/local/{bin,sbin}
# )

# fpath=(
#   ${ZDOTDIR}/functions
#   $fpath
# )

# autoload -Uz ${ZDOTDIR}/functions/**/*(N:t)

## Eliminates duplicates in *paths
typeset -gU path cdpath fpath manpath
# path=("$path[@]")
## Adds `~/.local/bin` and all subdirs to $PATH
# export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

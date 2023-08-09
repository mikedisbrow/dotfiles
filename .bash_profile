#!/bin/bash

# ~/.bash_profile
# -----------------------------------------------------------------------------
# interactive login
# /etc/profile
# ~/.bash_profile
# ~/.bash_login
# ~/.profile
#
# https://wiki.archlinux.org/title/bash
# https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html

# shellcheck shell=bash
# shellcheck source=/dev/null

# set -x

# make bash load .bashrc 
# [[ -f ~/.bashrc ]] && . ~/.bashrc
if [[ -r "${HOME}/.bashrc" ]]; then
    source "${HOME}/.bashrc"
fi

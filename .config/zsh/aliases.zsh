#!/bin/bash

# ~/.aliases

# https://ss64.com/osx/alias-zsh.html
# https://ss64.com/osx/alias.html

# -----------------------------------------------------------------------------

# Use neovim for vim if present.
# [ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"

# ls options
# https://ss64.com/osx/ls.html
# 
# -l  List in long format
# -L  If argument is a symbolic link, list the file or directory the link 
#     references rather than the link itself cancels the -P option.
# -a  List all entries including those starting with a dot .
# -A  List all with dotfiles. No . ..
# -F  / for dirs, * executable, @ symbolic link, = socket, % whiteout, | FIFO.
# -h  used with the -l option, use unit suffixes

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

# all files inc dotfiles, in long format
# shellcheck disable=SC2139
alias ll="ls -lhAFL ${colorflag}"
# shellcheck disable=SC2139
alias ls="ls -AFL ${colorflag}"
# all files, in long format
# shellcheck disable=SC2139
alias l="ls -lhF ${colorflag}"
alias ldot='ls -ld .* --group-directories-first'
# List only directories
# shellcheck disable=SC2139
alias lsd="ls -lhF ${colorflag} | grep '^d'"

alias ~="cd ~"
alias -- -="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

alias h='history'
alias hig="history | grep"

# Always show disk usage in a human readable format
alias df="df --human-readable"
alias du="du --human-readable"
alias free="free -human "
alias dud='du -d 1 -h' # List sizes of files within directory
alias duf='du -sh *' # List total size of current directory

# Find directories by their name
alias fdir='find . -type d -name'
# Find files by their name
alias ffile='find . -type f -name'

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Fuzzy find stuff
alias hf="history | fzf"
alias af="alias | fzf"

# mimic vim functions
alias :q='exit'

# clear screen and ls
alias cls='clear;ls'

# source zshrc from any location
# shellcheck disable=SC2139
alias src="source $ZDOTDIR/.zhrc"

# Fuck - rerun previous prepend sudo
alias fuck='sudo $(history -p \!\!)'

# trash: https://github.com/sindresorhus/macos-trash
command -v trash >/dev/null 2>&1 && alias rm="trash"

# Enable aliases to be sudo’ed
alias sudo="sudo "
alias please="sudo "

# Make watch work with aliases
alias watch="watch " 

# Reload the shell (i.e. invoke as a login shell)
# shellcheck disable=SC2139
alias reload="exec $SHELL -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

alias mv="mv -iv"
alias cp="cp -iv"
alias ln="ln -iv"
alias mkdir="mkdir -pv"
# create a dir with date from today
alias mkdd='mkdir $(date +%Y%m%d)'

alias perm='stat --printf "%a %n \n "' # Show permission of target in number
alias 000='chmod 000'                  # ---------- (usr grp oth)
alias 640='chmod 640'                  # -rw-r-----
alias 644='chmod 644'                  # -rw-r--r--
alias 755='chmod 755'                  # -rwxr-xr-x
alias 775='chmod 775'                  # -rwxrwxr-x
alias mx='chmod a+x'                   # ---x--x--x
alias ux='chmod u+x'                   # ---x------


# become root #
alias root='sudo -i'
alias su='sudo -i'

alias sha1="openssl sha1"

# colorize diff output - install colordiff package
alias diff="colordiff"

# Make mount command output pretty and human readable format
alias mount="mount |column -t"

# Resume wget by default
## this one saved by butt so many times ##
alias wget="wget -c"

# Download file and save it with filename of remote file
alias get="curl -O -L"

# bat - https://github.com/sharkdp/bat
alias bat="bat --style=numbers,changes "

# Always colorize output by default
alias fd='fd --color always '

alias exall="exa --long --all --header --git --icons --classify --group-directories-first --time-style=long-iso --group --color=always --binary --links --accessed --created --modified"
alias exalx="exa --long --all --header --git --icons --classify --group-directories-first --time-style=long-iso --group --color=always --binary --links --created --extended"
alias exat="exa --tree --all --classify --icons"

alias ag="ag \
    --hidden \
    --follow \
    --smart-case \
    --numbers \
    --color-match '1;31' \
    --color-path '0;37' \
    --color-line-number '1;33'"


# Git Shit ####################################################################

alias glone="git clone --depth 1 "

# Changed your .gitignore _after_ you have added / committed some files?
# run `gri` to untrack anything in your updated .gitignore
# Put this in your .zshrc file
alias gri="git ls-files --ignored --exclude-standard | xargs -0 git rm -r"

alias dotgit='git --git-dir=/Users/miked/.dotfiles --work-tree=/Users/miked'

alias diff="git diff --color"
alias amend="git commit --amend"
alias clean="git reset --hard HEAD && git clean -df"
# Undo a `git push`
alias undopush="git push -f origin HEAD^:master"
# git root
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'


# Misc Network Shit ###########################################################

# add ssh-key to ssh-agent when key exist
if [ "$SSH_AUTH_SOCK" != "" ] && [ -f ~/.ssh/id_rsa ] && [ -x /usr/bin/ssh-add  ]; then
  ssh-add -l >/dev/null || alias ssh='(ssh-add -l >/dev/null || ssh-add) && unalias ssh; ssh'
fi

# IP addresses
alias myip='ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
# alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Control output of ping
# Stop after sending count ECHO_REQUEST packets #
alias ping="ping -c 5"
# Do not wait interval 1 second, go fast #
alias fastping="ping -c 100 -s.2"

# Use netstat command to quickly list all TCP/UDP port on the server
alias ports="netstat -tulanp"

# Misc Mac Shit ###############################################################

# How do I get a copy-and-pasteable version of my Macbook's serial number?
alias mbpserial="ioreg -l | grep IOPlatformSerialNumber"

# Pipe my public key to my clipboard.
alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

if [[ $os = Darwin ]]; then
    alias chrome='open -a Google\ Chrome\ Dev'
    alias firefox='open -a Firefox\ Developer\ Edition'
    alias safari='open -a Safari'
    alias preview='open -a Preview'
    alias foobar='open -a foobar2000'
    alias iina='open -a iina'
    alias xcode='open -a Xcode'
fi

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update --system; sudo gem update'

# Show/hide hidden files in Finder
alias showdots="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidedots="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Disable Spotlight
alias spotlightoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spotlighton="sudo mdutil -a -i on"

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Edit hosts file in Sublime
alias hosts='sudo $EDITOR /etc/hosts'

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

alias eject="diskutil eject"
alias ql='qlmanage -p'
alias spotlighter='mdfind -onlyin `pwd`'

# Repair File Permissions
alias repair="sudo diskutil repairPermissions /"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"


# My Misc Shit ################################################################

# add Sublime Text terminal command
# alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir

# decimal to hexadecimal value
alias dec2hex='printf "%x\n" $1'

# ZSH Shit ####################################################################
# Use zmv, which is amazing
alias zmv="noglob zmv -W"
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'
alias zdot='cd ${ZDOTDIR:-~}'


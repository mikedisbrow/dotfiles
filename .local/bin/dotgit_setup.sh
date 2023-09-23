#!/usr/bin/env bash

set -euo pipefail

# https://www.atlassian.com/git/tutorials/dotfiles
# https://news.ycombinator.com/item?id=11070797
# https://news.ycombinator.com/item?id=11071754

# git init --bare $HOME/.dotfiles

# make sure the --git-dir is the same as the
# directory where you created the repo above.
# alias dotgit="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# dotgit config --local status.showUntrackedFiles no

# dotgit add ~/.bashrc
# dotgit add ~/.zshrc
# dotgit add ~/.config/fish/config.fish
# dotgit commit -m "Add .bashrc/.zshrc/config.fish file"
# dotgit push

# curl https://raw.githubusercontent.com/mikedisbrow/dotfiles/master/scripts/dotgit-init | bash

git clone --bare git@github.com:mikedisbrow/dotfiles.git $HOME/.dotfiles
# define dotgit alias locally since the dotfiles
# aren't installed on the system yet
function dotgit {
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
# create a directory to backup existing dotfiles to
mkdir -p .dotfiles-backup
dotgit checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles from git@github.com:mikedisbrow/dotfiles.git";
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    dotgit checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi
# checkout dotfiles from repo
dotgit checkout
dotgit config status.showUntrackedFiles no
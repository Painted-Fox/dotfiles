#!/bin/zsh
# This script links the configurations in the dotfiles to their appropriate
# locations on posix operating systems.

# Abort the script if a command fails.
set -e

# Script dir.
dir=$( cd -P "$( dirname $0 )" && pwd )
# dotfiles dir.
dot=$( cd -P ${dir}/.. && pwd )

echo "dir: ${dir}"
echo "dot: ${dot}"
echo "HOME: ${HOME}"

function dot_link {
  ln -sfn "$dot/$1" "$HOME/$2"
}

dot_link "vim"               ".vim"
dot_link "vim/vimrc"         ".vimrc"
dot_link "vim/vimrc.bundles" ".vimrc.bundles"

if [ $( ls -1 "$dot/vim/bundle/" | wc -l ) -le 1 ]; then
  echo "Installing: Vim Bundles"
  vim +BundleInstall! +BundleClean +qall
fi

#!/bin/bash
# This script links the configurations in the dotfiles to their appropriate
# locations on posix operating systems.

# Abort the script if a command fails.
set -e

# dotfiles dir = Script dir.
dot=$( cd -P "$( dirname $0 )" && pwd )

echo "Dotfiles: ${dot}"
echo "HOME: ${HOME}"

function dot_link {
  ln -sfn "$dot/$1" "$HOME/$2"
}

# Install Vim dotfiles.
dot_link "vim"               ".vim"
dot_link "vim/vimrc"         ".vimrc"
dot_link "vim/gvimrc"        ".gvimrc"

# Install shell dotfiles.
dot_link "shell/pam_environment"    ".pam_environment"
dot_link "shell/profile"            ".profile"
dot_link "shell/bashrc"             ".bashrc"
dot_link "shell/bash_aliases"       ".bash_aliases"

# Install dircolors-solarized
dot_link "dircolors-solarized/dircolors.256dark" ".dircolors"

dot_link "gemrc"             ".gemrc"
dot_link "gitconfig"         ".gitconfig"
dot_link "hgrc"              ".hgrc"
dot_link "kdiff3rc"          ".kdiff3rc"
dot_link "tmux.conf"         ".tmux.conf"
dot_link "i3"                ".i3"

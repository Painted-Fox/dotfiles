# Turn off the fish greeting.
set -g -x fish_greeting ''

# Shortcuts to edit config files
function dot; pushd ~/lib/dotfiles; end
function ef; dot; vim fish/config.fish; popd; end
function eg; dot; vim git/gitconfig; popd; end
function eh; dot; vim mercurial/hgrc; popd; end
function et; dot; vim tmux.conf; popd; end
function ev; dot; vim vim/vimrc; popd; end

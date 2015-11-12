# Aliases / Shortcuts --------------------------------------------------------

# Shortcuts to edit config files
function dot; pushd ~/lib/dotfiles; end
function eb;  dot; vim bin/bootstrap;           popd; end
function ef;  dot; vim fish/config.fish;        popd; end
function eg;  dot; vim git/gitconfig;           popd; end
function eh;  dot; vim mercurial/hgrc;          popd; end
function et;  dot; vim tmux.conf;               popd; end
function ev;  dot; vim vim/vimrc;               popd; end
function evs; dot; vim vim/vsvimrc;             popd; end
function evp; dot; vim vim/plugins.vim;         popd; end
function evc; dot; vim vim/plugins.config.vim;  popd; end

# Don't autoconnect on start
alias tf "tf -n"


# Environment Variables ------------------------------------------------------

# Install oh-my-fish under ~/lib/omf
set -x OMF_PATH $HOME/lib/omf

# Set vim as my default editor
set -x EDITOR vim

# If polipo is running, use it.
# This speeds up w3m, since it has not cache of its own.
if pgrep polipo > /dev/null
    set -x HTTP_PROXY http://127.0.0.1:8123/
end


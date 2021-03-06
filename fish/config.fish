# Turn off the fish greeting.
set -g -x fish_greeting ''

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


# Load Dircolors -------------------------------------------------------------
#
# This loads dircolors specified in ~/.dircolors
#
# You can create a ~/.dircolors file with the command:
#   dircolors --print-database > ~/.dircolors
#
# This code is inspired by https://github.com/fish-shell/fish-shell
#   fish-shell/share/functions/ls.fish

if type -q -f dircolors
    set -l colorfile ~/.dircolors
    if test -f $colorfile
        eval (dircolors -c $colorfile | sed 's/>&\/dev\/null$//')
    end
end


# Environment Variables ------------------------------------------------------

# Set vim as my default editor
set -x EDITOR vim

# If polipo is running, use it.
# This speeds up w3m, since it has not cache of its own.
if pgrep polipo > /dev/null
    set -x HTTP_PROXY http://127.0.0.1:8123/
end


# Load Scripts ---------------------------------------------------------------

# Add completion for pass (passwordstore.org)
# http://git.zx2c4.com/password-store/plain/src/completion/pass.fish-completion
source $HOME/lib/dotfiles/fish/pass.fish-completion

# Commands for quick navigation of the filesystem.
# Idea from: http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
source ~/lib/dotfiles/fish/mark.fish

# Commands for quick navigation of the filesystem.
# Idea from: http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html

set -g -x MARKPATH "$HOME/.marks"

function jump -d "Jumps to a marked directory."
    set -l jump_to $argv[1]
    cd "$MARKPATH/$jump_to" 2> /dev/null; or echo "No such mark: $jump_to"
end

# Add tab completion to the jump command.
complete -x -c jump -a "(find $MARKPATH -type l -printf '%f\n')"

function mark -d "Mark a directory to be able to jump to it later."
    set -l mark_name $argv[1]
    mkdir -p "$MARKPATH"; ln -s (pwd) "$MARKPATH/$mark_name"
end

function unmark -d "Remove a mark."
    set -l to_unmark $argv[1]
    rm -i "$MARKPATH/$to_unmark"
end

# Add tab completion to the unmark command.
complete -x -c unmark -a "(find $MARKPATH -type l -printf '%f\n')"

function marks -d "List marks."
    set -l light_blue '\033[1;34m'
    set -l light_cyan '\033[1;36m'
    set -l reset '\033[0m'
    set -l printf "$light_cyan%f$reset -> $light_blue%l$reset\n"
    find "$MARKPATH" -maxdepth 1 -type l -printf $printf
end

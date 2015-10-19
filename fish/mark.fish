# Commands for quick navigation of the filesystem.
# Idea from: http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html

set -g -x MARKPATH "$HOME/.marks"

function jump -d "Jumps to a marked directory."
    set -l jump_to $argv[1]
    cd "$MARKPATH/$jump_to" 2> /dev/null; or echo "No such mark: $jump_to"
end

# Add tab completion to the jump command.
complete --command jump --exclusive --arguments (find $MARKPATH -type l -printf "%f ")

function mark -d "Mark a directory to be able to jump to it later."
    set -l mark_name $argv[1]
    mkdir -p "$MARKPATH"; ln -s (pwd) "$MARKPATH/$mark_name"
end

function unmark -d "Remove a mark."
    set -l to_unmark $argv[1]
    rm -i "$MARKPATH/$to_unmark"
end

function marks -d "List marks."
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g'; and echo
end

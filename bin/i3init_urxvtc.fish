#!/usr/bin/env fish

# Starts urxvtc in i3, but waits on urxvtd to be ready
set -l hostname (hostname)
for i in (seq 5)
    if test -S ~/.urxvt/urxvtd-$hostname
        # The socket exists.
        i3-msg 'exec urxvtc -e sh -c \'tmux attach || tmux\''
        break
    else
        # Wait 1 second.
        sleep 1s
    end
end

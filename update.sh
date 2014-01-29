#!/bin/bash
#
# Updates external repositories.
#
# Borrowed from the article "Vim After 11 years" by Ian Langworth
# https://github.com/statico/dotfiles/blob/master/.vim/update.sh

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GIT="$( which git )"

# Run mercurial with the extensions we will install disabled.
HG="$( which hg ) $(sed -n '/^hgext/s/^hgext\/\(\w*\).*$/--config extensions.\1=!/p' packages.config | tr '\n' ' ')"

clean() {
    # $1 = dest
    rm -rf $1
}

clone() {
    # $1 = dest
    # $2 = vcs
    # $3 = url
    case "$2" in
        git)
            $GIT clone $3 $1
            ;;
        hg)
            $HG clone $3 $1
            ;;
        *)
            echo "Unknown version control system: $2"
            exit 1
    esac
}

while read package; do
    dest=$DIR/$(echo $package | tr -s ' ' | cut -d ' ' -f 1)
    vcs=$(echo $package | tr -s ' ' | cut -d ' ' -f 2)
    url=$(echo $package | tr -s ' ' | cut -d ' ' -f 3)

    clean $dest
    clone $dest $vcs $url
done < $DIR/packages.config

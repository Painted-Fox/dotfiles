#!/bin/bash
#
# Updates external repositories.

set -e

# Run mercurial with the extensions we will install disabled.
HG="$(sed -n '/^hgext/s/^hgext\/\(\w*\).*$/--config extensions.\1=!/p' packages.config | tr '\n' ' ')"

clean() {
    local dest=$1
    rm -rf $dest
}

clone() {
  local dest=$1
  local vcs=$2
  local url=$3
  case "$vcs" in
    git)
      git clone $url $dest
      ;;
    hg)
      hg $HG clone $url $dest
      ;;
    *)
      echo "Unknown version control system: $vcs"
      exit 1
  esac
}

main() {
  local dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  while read package; do
    dest=$dir/$(echo $package | tr -s ' ' | cut -d ' ' -f 1)
    vcs=$(echo $package | tr -s ' ' | cut -d ' ' -f 2)
    url=$(echo $package | tr -s ' ' | cut -d ' ' -f 3)

    clean $dest
    clone $dest $vcs $url
  done < $dir/packages.config
}
main

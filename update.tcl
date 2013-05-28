#!/usr/bin/tclsh
#
# Updates external repositories.
# This replaces using subrepos.
#
# Borrowed from the article "Vim After 11 years" by Ian Langworth
# https://github.com/statico/dotfiles/blob/master/.vim/update.sh

set dotdir [file normalize [file dirname $argv0]]

array set vim {
    vim/bundle/closetag.vim  {git git://github.com/vim-scripts/closetag.vim.git}
    vim/bundle/ctrlp.vim     {hg  https://bitbucket.org/kien/ctrlp.vim}
    vim/bundle/molokai       {git git://github.com/tomasr/molokai.git}
    vim/bundle/nerdtree      {git git://github.com/scrooloose/nerdtree.git}
    vim/bundle/powerline     {git git://github.com/Lokaltog/powerline.git}
    vim/bundle/rename.vim    {git git://github.com/danro/rename.vim.git}
    vim/bundle/syntastic     {git git://github.com/scrooloose/syntastic.git}
    vim/bundle/vim-pathogen  {git git://github.com/tpope/vim-pathogen.git}
    vim/bundle/zenburn       {git git://github.com/jnurmine/Zenburn.git}
}

array set hgext {
    hgext/hg-git    {hg https://bitbucket.org/durin42/hg-git}
    hgext/hg-review {hg http://bitbucket.org/sjl/hg-review}
    hgext/machina   {hg https://bitbucket.org/MrWerewolf/mercurial-machina}
    hgext/rsync     {hg https://bitbucket.org/MrWerewolf/hg-rsync}
    hgext/rupdate   {hg https://bitbucket.org/MrWerewolf/rupdate}
}

array set misc {
    dircolors-solarized {git git://github.com/seebi/dircolors-solarized.git}
}

# Pulls and updates to the latest change.
proc pull {vcs dir} {
    if {[string equal $vcs git]} {
        puts [exec -ignorestderr -- $vcs "--git-dir=$dir/.git" "--work-tree=$dir" pull origin master]
    } elseif {[string equal $vcs hg]} {
        puts [exec -ignorestderr -- $vcs -R "$dir" pull -u]
    }
}

# Clones the repository.
proc clone {vcs url dest} {
    puts [exec -ignorestderr -- $vcs clone $url $dest]
}

proc updategroup {group} {
    global vim hgext misc dotdir
    foreach {dir remote} [array get $group] {
        set vcs [lindex $remote 0]
        set url [lindex $remote 1]
        set dest "$dotdir/$dir"

        if {[file exists "$dest/.$vcs"]} {
            pull $vcs $dest
        } else {
            clone $vcs $url $dest
        }
    }
}

updategroup vim
updategroup hgext
updategroup misc
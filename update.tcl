#!/usr/bin/tclsh
#
# Updates external repositories.
# This replaces using subrepos.
#
# Borrowed from the article "Vim After 11 years" by Ian Langworth
# https://github.com/statico/dotfiles/blob/master/.vim/update.sh

set dotdir [file normalize [file dirname $argv0]]
set cwd [pwd]

array set vim {
    vim/bundle/closetag.vim  {git git://github.com/vim-scripts/closetag.vim.git}
    vim/bundle/ctrlp.vim     {hg  https://bitbucket.org/kien/ctrlp.vim}
    vim/bundle/dart-vim-plugin \
        {git git://github.com/dart-lang/dart-vim-plugin.git}
    vim/bundle/molokai       {git git://github.com/tomasr/molokai.git}
    vim/bundle/nerdtree      {git git://github.com/scrooloose/nerdtree.git}
    vim/bundle/powerline     {git git://github.com/Lokaltog/powerline.git}
    vim/bundle/rename.vim    {git git://github.com/danro/rename.vim.git}
    vim/bundle/riv.vim       {git git://github.com/Rykka/riv.vim.git}
    vim/bundle/scratch.vim   {git git://github.com/vim-scripts/scratch.vim.git}
    vim/bundle/syntastic     {git git://github.com/scrooloose/syntastic.git}
    vim/bundle/vim-golang    {git git://github.com/jnwhiteh/vim-golang.git}
    vim/bundle/vim-json      {git git://github.com/elzr/vim-json.git}
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
proc pull {vcs dir submod} {
    cd $dir

    if {[string equal $vcs git]} {
        echorun "exec -ignorestderr -- $vcs pull origin master"

        if {$submod} {
            echorun "exec -ignorestderr -- $vcs submodule update"
        }
    } elseif {[string equal $vcs hg]} {
        echorun "exec -ignorestderr -- $vcs pull -u"
    }
}

# Clones the repository.
proc clone {vcs url dest submod} {
    echorun "exec -ignorestderr -- $vcs clone $url $dest"

    if {[string equal $vcs git] && $submod} {
        cd $dest
        echorun "exec -ignorestderr -- $vcs submodule update --init"
    }
}

proc updategroup {group} {
    global vim hgext misc dotdir
    foreach {dir remote} [array get $group] {
        set vcs [lindex $remote 0]
        set url [lindex $remote 1]
        set dest "$dotdir/$dir"

        # Do I have submodules?
        set submod [expr {[llength $remote] > 2 && [lindex $remote 2]}]

        if {[file exists "$dest/.$vcs"]} {
            pull $vcs $dest $submod
        } else {
            clone $vcs $url $dest $submod
        }
    }
}

proc echorun {cmd} {
    puts [pwd]
    puts $cmd
    puts [eval $cmd]
}

try {
    updategroup vim
    updategroup hgext
    updategroup misc
} finally {
    cd $cwd
}

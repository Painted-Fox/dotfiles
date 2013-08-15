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
    vim/bundle/ack           {git https://github.com/mileszs/ack.vim}
    vim/bundle/airline       {git https://github.com/bling/vim-airline}
    vim/bundle/closetag      {git https://github.com/vim-scripts/closetag.vim}
    vim/bundle/ctrlp         {hg  https://bitbucket.org/kien/ctrlp.vim}
    vim/bundle/dart          \
        {git https://github.com/dart-lang/dart-vim-plugin}
    vim/bundle/dosbatch-indent \
        {git https://github.com/vim-scripts/dosbatch-indent}
    vim/bundle/fugitive      {git https://github.com/tpope/vim-fugitive}
    vim/bundle/golang        {git https://github.com/jnwhiteh/vim-golang}
    vim/bundle/json          {git https://github.com/elzr/vim-json}
    vim/bundle/molokai       {git https://github.com/tomasr/molokai}
    vim/bundle/nerdtree      {git https://github.com/scrooloose/nerdtree}
    vim/bundle/pathogen      {git https://github.com/tpope/vim-pathogen}
    vim/bundle/rename        {git https://github.com/danro/rename.vim}
    vim/bundle/scratch       {git https://github.com/vim-scripts/scratch.vim}
    vim/bundle/syntastic     {git https://github.com/scrooloose/syntastic}
    vim/bundle/zenburn       {git https://github.com/jnurmine/Zenburn}
}

array set hgext {
    hgext/hg-git    {hg https://bitbucket.org/durin42/hg-git}
    hgext/hg-review {hg https://bitbucket.org/sjl/hg-review}
    hgext/machina   {hg https://bitbucket.org/Sly-Fox/mercurial-machina}
    hgext/rsync     {hg https://bitbucket.org/Sly-Fox/hg-rsync}
    hgext/rupdate   {hg https://bitbucket.org/Sly-Fox/rupdate}
}

array set misc {
    dircolors-solarized {git https://github.com/seebi/dircolors-solarized}
}

# Pulls and updates to the latest change.
proc pull {vcs dir submod} {
    cd $dir

    if {[string equal $vcs git]} {
        run "$vcs pull origin master"

        if {$submod} {
            run "$vcs submodule update"
        }
    } elseif {[string equal $vcs hg]} {
        run "$vcs pull -u"
    }
}

# Clones the repository.
proc clone {vcs url dest submod} {
    run "$vcs clone $url $dest"

    if {[string equal $vcs git] && $submod} {
        cd $dest
        run "$vcs submodule update --init"
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

proc run {cmd} {
    if {[catch {exec {*}[split $cmd " "]} results options]} {
        set details [dict get $options -errorcode]
        if {$details != {NONE}} {
            puts "Dir: [pwd]"
            puts "Cmd: $cmd"
            puts "Err: $details"
            puts $results
            exit
        }
    }
}

updategroup vim
updategroup hgext
updategroup misc

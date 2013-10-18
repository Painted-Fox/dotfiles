#!/usr/bin/tclsh
#
# Updates external repositories.
# This replaces using subrepos.
#
# Borrowed from the article "Vim After 11 years" by Ian Langworth
# https://github.com/statico/dotfiles/blob/master/.vim/update.sh

set dotdir [file normalize [file dirname $argv0]]
set cwd [pwd]

# List of directories to clean.
set clean_dirs {
    vim/bundle
    dircolors-solarized
    hgext
}

array set vim {
    vim/bundle/airline       {git https://github.com/bling/vim-airline}
    vim/bundle/dosbatch-indent \
        {git https://github.com/vim-scripts/dosbatch-indent}
    vim/bundle/golang        {git https://github.com/jnwhiteh/vim-golang}
    vim/bundle/nerdtree      {git https://github.com/scrooloose/nerdtree}
    vim/bundle/pathogen      {git https://github.com/tpope/vim-pathogen}
    vim/bundle/scratch       {git https://github.com/vim-scripts/scratch.vim}
    vim/bundle/zenburn       {git https://github.com/jnurmine/Zenburn}
}

array set hgext {
    hgext/machina   {hg https://bitbucket.org/Painted-Fox/mercurial-machina}
    hgext/rsync     {hg https://bitbucket.org/Painted-Fox/hg-rsync}
    hgext/rupdate   {hg https://bitbucket.org/Painted-Fox/rupdate}
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

# Cleans the directories
proc clean {} {
    global dotdir clean_dirs
    foreach {dir} $clean_dirs {
        file delete -force "$dotdir/$dir"
    }
}

# Clones the repository.
proc clone {vcs url dest submod} {
    global hgext

    if {[string equal $vcs hg]} {
        # Disable mods that we don't have yet.
        set config {}
        foreach {dir remote} [array get hgext] {
            set extension [lindex [split $dir /] 1]
            lappend config --config "extensions.$extension=!"
        }

        run "$vcs clone $config $url $dest"
    } else {
        run "$vcs clone $url $dest"
    }

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

clean
updategroup vim
updategroup hgext
updategroup misc

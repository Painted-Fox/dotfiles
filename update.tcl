#!/usr/bin/tclsh
#
# Updates external repositories.
# This replaces using subrepos.
#
# Borrowed from the article "Vim After 11 years" by Ian Langworth
# https://github.com/statico/dotfiles/blob/master/.vim/update.sh

set dot_dir [file normalize [file dirname $argv0]]
set packages_config "$dot_dir/packages.config"

set git "git"
set hg "hg"
# TODO
# Disable mods that we don't have yet.
#set config {}
#foreach {dir remote} [array get hgext] {
#    set extension [lindex [split $dir /] 1]
#    lappend config --config "extensions.$extension=!"
#}

# Cleans a directory
proc clean {dest} {
    file delete -force "$dest"
}

# Clones the repository.
proc clone {dest vcs url} {
    global hg git

    switch $vcs {
        git {
            run "$git clone $url $dest"
        }
        hg {
            run "$hg clone $url $dest"
        }
        default {
            puts "Unkown version control system: $vcs"
            exit 1
        }
    }
}

# Runs a command.
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

set packages_file [open $packages_config r]
set packages [read $packages_file]
close $packages_file
foreach pkg [split $packages "\n"] {
    if {[llength $pkg] == 0} { continue }
    set dest "$dot_dir/[lindex $pkg 0]"
    set vcs [lindex $pkg 1]
    set url [lindex $pkg 2]

    clean $dest
    clone $dest $vcs $url
}

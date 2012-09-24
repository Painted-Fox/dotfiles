# This script will install Sublime Text 2 packages.

# http://blogs.msdn.com/b/powershell/archive/2007/06/19/get-scriptdirectory.aspx
Function Get-ScriptDirectory
{
  $Invocation = (Get-Variable MyInvocation -Scope 1).Value
  Split-Path $Invocation.MyCommand.Path
}

# Script dir.
$dir = Get-ScriptDirectory

# Sublime packages dir.
$packages = Resolve-Path "$env:UserProfile\AppData\Roaming\Sublime Text 2\Packages"

# Import Lib
. "$dir\..\lib\PowerShell\SymLink.ps1"
. "$dir\..\lib\PowerShell\VersionControl.ps1"

# VintageEx - An implementation of Vim's command-line mode for Sublime Text 2
# https://github.com/SublimeText/VintageEx
$projName = "VintageEx"
GitClone "git://github.com/SublimeText/$projName.git" "$packages\$projName"

# Sass syntax highlighting
# https://github.com/n00ge/sublime-text-haml-sass
$projName = "sublime-text-haml-sass"
GitClone "git://github.com/n00ge/$projName.git" "$packages\$projName"
SymDirLink "$packages\SASS" "$packages\$projName\SASS"
SymDirLink "$packages\Ruby Haml" "$packages\$projName\Ruby Haml"

# Adds TextMate-like autocompletion to Sublime Text 2
# https://github.com/alexstaubo/sublime_text_alternative_autocompletion
$projName = "sublime_text_alternative_autocompletion"
GitClone "git://github.com/alexstaubo/$projName.git" "$packages\$projName"

# Sublime Text 2 plugin for running ruby tests! (Unit, RSpec, Cucumber)
# https://github.com/maltize/sublime-text-2-ruby-tests
$projName = "sublime-text-2-ruby-tests"
GitClone "git://github.com/maltize/$projName.git" "$packages\RubyTest"

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

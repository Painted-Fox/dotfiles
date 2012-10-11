# This script will install Sublime Text 2 packages.

# http://blogs.msdn.com/b/powershell/archive/2007/06/19/get-scriptdirectory.aspx
Function Get-ScriptDirectory
{
  $Invocation = (Get-Variable MyInvocation -Scope 1).Value
  Split-Path $Invocation.MyCommand.Path
}

# Script dir.
$dir = Get-ScriptDirectory
# dotfiles dir
$dot = Resolve-Path "$dir\.."

# Import Libraries
. "$dot\lib\PowerShell\SymLink.ps1"
. "$dot\lib\PowerShell\VersionControl.ps1"

# Sublime packages dir.
$packages = "$env:UserProfile\AppData\Roaming\Sublime Text 2\Packages"

if (Test-Path $packages) {
  echo "Installing VintageEx, an implementation of Vim's command-line mode."
  # https://github.com/SublimeText/VintageEx
  $projName = "VintageEx"
  GitClone "git://github.com/SublimeText/$projName.git" "$packages\$projName"

  echo "Linking: Sublime Text 2 User Config"
  SymLink -dir "$dot\Sublime Text 2\Packages\User" "$packages\User"
} else {
  echo "WARNING: Sublime Text 2 is not installed."
  echo "         No dotfiles were setup for Sublime Text 2."
}





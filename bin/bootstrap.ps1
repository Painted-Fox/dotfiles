# This script links the configurations in the dotfiles to their appropriate
# locations on Windows.
# Run this script with Administrator privileges.
# You may also need to run the following to enable running PowerShell scripts:
#     Set-ExecutionPolicy RemoteSigned

# http://blogs.msdn.com/b/powershell/archive/2007/06/19/get-scriptdirectory.aspx
Function Get-ScriptDirectory
{
  $Invocation = (Get-Variable MyInvocation -Scope 1).Value
  Split-Path $Invocation.MyCommand.Path
}

$dir = Get-ScriptDirectory
$root = Resolve-Path "$dir\.."

# Import SymLink library
. "$root\lib\PowerShell\SymLink.ps1"

echo "Linking: PowerShell Profile"
SymLink $profile $dir\Microsoft.PowerShell_profile.ps1

echo "Linking: Vim Config"
SymLink $env:userprofile\.vimrc $root\.vimrc
SymDirLink $env:userprofile\vimfiles $root\.vim

echo "Linking: Mercurial Config"
SymLink $env:UserProfile\mercurial.ini $root\hgrc

echo "Linking: Ruby Gems Config"
SymLink $env:UserProfile\.gemrc $root\.gemrc

echo "Linking: Sublime Text 2 Config"
MultiSymLink `
  "$env:UserProfile\AppData\Roaming\Sublime Text 2\Packages\User" `
  "$root\Sublime Text 2"

echo "Linking: ConEmu Config"
SymLink "C:\Program Files\ConEmu\ConEmu.xml" $root\ConEmu.xml

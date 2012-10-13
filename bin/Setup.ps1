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

# Script dir.
$dir = Get-ScriptDirectory
# dotfiles dir
$dot = Resolve-Path "$dir\.."
# Shortcut to the User's home folder
$userHome = $env:UserProfile

# Import Libraries
. "$dot\lib\PowerShell\SymLink.ps1"

# Setup Curl.  Depends on msysgit being installed.
# http://vim.spf13.com/#install
$gitCmdDirs = Join-Path $env:ProgramFiles,${Env:ProgramFiles(x86)} "Git\cmd"
foreach ($gitCmdDir in $gitCmdDirs) {
  if (Test-Path $gitCmdDir) {
    echo "Setup: Curl command"
    Copy-Item "$dot\tools\curl.cmd" "$gitCmdDir"
  }
}

# Setup PowerShell
. "$dir\PowerShell.ps1"

echo "Linking: Vim Config"
SymLink      $dot\vim\vimrc  $userHome\.vimrc
SymLink -dir $dot\vim        $userHome\vimfiles

echo "Linking: Mercurial Config"
SymLink      $dot\hgrc       $userHome\mercurial.ini

echo "Linking: Ruby Gems Config"
SymLink      $dot\gemrc      $userHome\.gemrc

# Setup SublimeText configuration.
. "$dir\SublimeText.ps1"

echo "Linking: ConEmu Config"
SymLink      $dot\ConEmu.xml "C:\Program Files\ConEmu\ConEmu.xml"

echo "Linking: Mercurial Extensions"
SymLink -dir $dot\hgext      $userHome\.hgext

echo "Linking: kdiff3 Config"
SymLink      $dot\kdiff3rc   $userHome\.kdiff3rc

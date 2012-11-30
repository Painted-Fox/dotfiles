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
$gitCmdDirs = @(Join-Path $env:ProgramFiles "Git\cmd")
if (${Env:ProgramFiles(x86)}) {
  $gitCmdDirs += Join-Path ${Env:ProgramFiles(x86)} "Git\cmd"
}

foreach ($gitCmdDir in $gitCmdDirs) {
  if (Test-Path $gitCmdDir) {
    echo "Setup: Curl command"
    Copy-Item "$dot\tools\curl.cmd" "$gitCmdDir"
  }
}

# Setup PowerShell
. "$dir\PowerShell.ps1"

# Install fonts
. "$dir\Font.ps1"

echo "Installing: Vim Configuration"
SymLink      $dot\vim\vimrc          $userHome\.vimrc
SymLink      $dot\vim\vimrc.bundles  $userHome\.vimrc.bundles
SymLink -dir $dot\vim                $userHome\.vim

if ((Get-CHildItem "$dot\vim\bundle").Count -le 2)
{
  Write-Host "Installing: Vim Bundles"
  vim -u "$dot/vim/vimrc.bundles" - +BundleInstall! +BundleClean +qall
}

# Setup SublimeText configuration.
. "$dir\SublimeText.ps1"

echo "Linking: Ruby Gems Config"
SymLink      $dot\gemrc      $userHome\.gemrc

echo "Linking: ConEmu Config"
SymLink      $dot\ConEmu.xml "C:\Program Files\ConEmu\ConEmu.xml"

echo "Linking: Mercurial Config"
SymLink      $dot\hgrc       $userHome\mercurial.ini

echo "Linking: Mercurial Extensions"
SymLink -dir $dot\hgext      $userHome\.hgext

echo "Linking: kdiff3 Config"
SymLink      $dot\kdiff3rc   $userHome\.kdiff3rc

Write-Host "Linking: PuTTY Tray Config"
SymLink -dir $dot\PuTTY\sessions  $userHome\tools\PuTTY\AMD64\sessions
SymLink -dir $dot\PuTTY\sessions  $userHome\tools\PuTTY\x86\sessions

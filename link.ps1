# This script links the configurations in the dotfiles to their appropriate
# locations on Windows.
# Run this script with Administrator privileges.
# You may also need to run the following to enable running PowerShell scripts:
#     Set-ExecutionPolicy RemoteSigned

$dir = Resolve-Path "$MyInvocation.MyCommand.Path\.."

# Don't run if we're not running with Administrator privileges.
If (-NOT ([Security.Principal.WindowsPrincipal] `
  [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
  Write-Warning ("You do not have Administrator rights to run this script!" + `
    "`nPlease re-run this script as an Administrator!")
  Break
}

# Creates a symbolic link
Function SymLink($link, $target, [bool] $directory=$False)
{
  $linkDir = Split-Path $link -parent
  if (!(Test-Path $linkDir)) {
    echo "Making directory: $linkDir"
    md -Path $linkDir
  }

  if (Test-Path $link) { rm $link -Recurse }

  if ($directory) { cmd /c mklink /D $link $target }
  else { cmd /c mklink $link $target }
}

# Creates a directory symbolic link
Function SymDirLink($link, $target)
{
  SymLink $link $target $True
}

# Links multiple files in a directory.
Function MultiSymLink($linkDir, $targetDir)
{
  $targets = Get-ChildItem $targetDir
  ForEach ($target in $targets)
  {
    $link = "$linkDir\$target"
    echo $link
    echo $target.FullName
    SymLink $link $target.FullName
  }
}

echo "Linking: PowerShell Profile"
SymLink $profile $dir\Microsoft.PowerShell_profile.ps1

echo "Linking: Vim Config"
SymLink $env:userprofile\.vimrc $dir\.vimrc
SymDirLink $env:userprofile\vimfiles $dir\.vim

echo "Linking: Mercurial Config"
SymLink $env:UserProfile\mercurial.ini $dir\hgrc

echo "Linking: Ruby Gems Config"
SymLink $env:UserProfile\.gemrc $dir\.gemrc

echo "Linking: Sublime Text 2 Config"
MultiSymLink `
  "$env:UserProfile\AppData\Roaming\Sublime Text 2\Packages\User" `
  "$dir\Sublime Text 2"

echo "Linking: ConEmu Config"
SymLink "C:\Program Files\ConEmu\ConEmu.xml" $dir\ConEmu.xml

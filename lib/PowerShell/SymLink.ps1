# Provides functions for creating symlinks with PowerShell

# We can't run if we're not running with Administrator privileges.
If (-NOT ([Security.Principal.WindowsPrincipal] `
  [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
  Write-Warning ("You do not have Administrator rights to run this script!" + `
    "`nPlease re-run this script as an Administrator!")
  Break
}

# Creates a symbolic link
Function SymLink
{
  param (
    [switch] $dir,
    [Parameter(Mandatory = $True)]
    [string] $target,
    [Parameter(Mandatory = $True)]
    [string] $link
  )

  $linkDir = Split-Path $link -parent
  if (!(Test-Path $linkDir)) {
    echo "Making directory: $linkDir"
    md -Path $linkDir
  }

  if ($dir) {
    Remove-SymDirLink($link)
    cmd /c mklink /D $link $target
  }
  else {
    if (Test-Path $link) { rm $link }
    cmd /c mklink $link $target
  }
}

# Links multiple files in a directory.
Function MultiSymLink
{
  param (
    [Parameter(Mandatory = $True)]
    [string] $targetDir,
    [Parameter(Mandatory = $True)]
    [string] $linkDir
  )

  $targets = Get-ChildItem $targetDir
  ForEach ($target in $targets)
  {
    $link = "$linkDir\$target"
    echo $link
    echo $target.FullName
    SymLink $link $target.FullName
  }
}

# Removes a Symbolic Directory Link
# http://serverfault.com/questions/67770
Function Remove-SymDirLink
{
  param (
    [Parameter(Mandatory = $True)]
    [string] $linkDir
  )

  if (Test-Path -Path $linkDir -PathType Container) {
    cmd /c rmdir $linkDir
  }
}


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
Function SymLink($link, $target, [bool] $directory=$False)
{
  $linkDir = Split-Path $link -parent
  if (!(Test-Path $linkDir)) {
    echo "Making directory: $linkDir"
    md -Path $linkDir
  }

  if (Test-Path $link) { rm $link }

  if ($directory) { cmd /c mklink /D $link $target }
  else { cmd /c mklink $link $target }
}

# Creates a directory symbolic link
Function SymDirLink($link, $target)
{
  Remove-SymDirLink($link)
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

# Removes a Symbolic Directory Link
# http://serverfault.com/questions/67770
Function Remove-SymDirLink($directoryLink)
{
  if (Test-Path -Path $directoryLink -PathType Container) {
    cmd /c rmdir $directoryLink
  }
}


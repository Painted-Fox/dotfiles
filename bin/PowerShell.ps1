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

echo "Linking: PowerShell Profile"
SymLink $dot\Microsoft.PowerShell_profile.ps1 $profile

if ($psVersionTable.PsVersion.Major -lt 3)
{
  Write-Warning ("You are using PowerShell " +
    "$($psVersionTable.PsVersion.Major).$($psVersionTable.PsVersion.Minor)")
  echo "         It's recommended you upgrade to PowerShell 3.0 from here:"
  echo "         http://www.microsoft.com/en-us/download/details.aspx?id=34595"
}

if (!(Get-Module -ListAvailable | where { $_.Name -eq "Pscx" }))
{
  Write-Warning "You do not have PowerShell Community Extensions (Pscx)."
  echo "         It's recommended that you download and install Pscx from here:"
  echo "         http://pscx.codeplex.com/"
}

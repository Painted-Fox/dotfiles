$dejaVuFiles = @(
  "DejaVuSans-Bold.ttf",
  "DejaVuSans-BoldOblique.ttf",
  "DejaVuSans-ExtraLight.ttf",
  "DejaVuSans-Oblique.ttf",
  "DejaVuSans.ttf",
  "DejaVuSansCondensed-Bold.ttf",
  "DejaVuSansCondensed-BoldOblique.ttf",
  "DejaVuSansCondensed-Oblique.ttf",
  "DejaVuSansCondensed.ttf",
  "DejaVuSansMono-Bold.ttf",
  "DejaVuSansMono-BoldOblique.ttf",
  "DejaVuSansMono-Oblique.ttf",
  "DejaVuSansMono.ttf",
  "DejaVuSerif-Bold.ttf",
  "DejaVuSerif-BoldItalic.ttf",
  "DejaVuSerif-Italic.ttf",
  "DejaVuSerif.ttf",
  "DejaVuSerifCondensed-Bold.ttf",
  "DejaVuSerifCondensed-BoldItalic.ttf",
  "DejaVuSerifCondensed-Italic.ttf",
  "DejaVuSerifCondensed.ttf")

$dejaVuSansMonoPowerlineFiles = @(
  "DejaVuSansMono-Bold-Powerline.ttf",
  "DejaVuSansMono-BoldOblique-Powerline.ttf",
  "DejaVuSansMono-Oblique-Powerline.ttf",
  "DejaVuSansMono-Powerline.ttf")

$consolasPowerlineFiles = @(
  "CONSOLA-Powerline.ttf",
  "CONSOLAB-Powerline.ttf",
  "CONSOLAI-Powerline.ttf",
  "CONSOLAZ-Powerline.ttf")

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
. "$dot\lib\PowerShell\7zip.ps1"

Function Has-Font
{
  Param (
    [Parameter(Mandatory = $True)]
    [string[]] $fontFiles
  )

  foreach ($fontFile in $fontFiles)
  {
    $fontFolder = Join-Path $Env:windir "Fonts"
    $fontFilePath = Join-Path $fontFolder $fontFile
    if (!(Test-Path $fontFilePath))
    {
      Write-Host "Could not find $fontFilePath"
      return $False
    }
  }

  return $True
}

Function Create-Temp
{
  New-Item -Force -ItemType directory -Path $dot -Name "tmp" | Out-Null
}

Function Remove-Temp
{
  Remove-Item -Recurse -Path "$dot\tmp"
}

if (!(Has-Font $dejaVuFiles))
{
  Write-Host "No DejaVu Fonts"
  Create-Temp
}

if (!(Has-Font $dejaVuSansMonoPowerlineFiles))
{
  Write-Host "Installing DejaVu Sans Mono for Powerline Fonts"
  Create-Temp
  $fontName = "dejaVuSansMonoPowerline"
  curl -o "$dot\tmp\$fontName.tar.gz" "https://gist.github.com/gists/1630581/download"
  Extract-Archive "$dot\tmp\$fontName.tar.gz" "$dot\tmp"
  Extract-Archive "$dot\tmp\$fontName.tar" "$dot\tmp\$fontName"
  Remove-Item "$dot\tmp\$fontName\*" -exclude *.ttf
  & "$dot\lib\PowerShell\Add-Font.ps1" -path "$dot\tmp\$fontName"
  Remove-Temp
}

if (!(Has-Font $consolasPowerlineFiles))
{
  Write-Host "No consolas powerline"
  Create-Temp
}

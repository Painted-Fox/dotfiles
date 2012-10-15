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
  Write-Host "Installing DejaVu Fonts"
  Create-Temp
  $fontName = "dejavu-fonts-ttf-2.33"
  curl -L -o "$dot\tmp\$fontName.tar.bz2" `
    "http://sourceforge.net/projects/dejavu/files/dejavu/2.33/dejavu-fonts-ttf-2.33.tar.bz2"
  Extract-Archive "$dot\tmp\$fontName.tar.bz2" "$dot\tmp"
  Extract-Archive "$dot\tmp\$fontName.tar" "$dot\tmp\$fontName"
  Remove-Item "$dot\tmp\$fontName\*" -exclude *.ttf
  . "$dot\lib\PowerShell\Add-Font.ps1" -path "$dot\tmp\$fontName"
  Remove-Temp

  if (!(Has-Font $dejaVuFiles))
  {
    Write-Warning "Failed to install DejaVu Fonts"
    Break
  }
}

if (!(Has-Font $dejaVuSansMonoPowerlineFiles))
{
  Write-Host "Installing DejaVu Sans Mono for Powerline Fonts"
  Create-Temp
  $fontName = "dejaVuSansMonoPowerline"
  curl -o "$dot\tmp\$fontName.tar.gz" `
    "https://gist.github.com/gists/1630581/download"
  Extract-Archive "$dot\tmp\$fontName.tar.gz" "$dot\tmp"
  Extract-Archive "$dot\tmp\$fontName.tar" "$dot\tmp\$fontName"
  Remove-Item "$dot\tmp\$fontName\*" -exclude *.ttf
  . "$dot\lib\PowerShell\Add-Font.ps1" -path "$dot\tmp\$fontName"
  Remove-Temp

  if (!(Has-Font $dejaVuSansMonoPowerlineFiles))
  {
    Write-Warning "Failed to install DejaVu Sans Mono for Powerline Fonts"
    Break
  }
}

if (!(Has-Font $consolasPowerlineFiles))
{
  Write-Host "Installing Consolas for Powerline"
  Create-Temp
  $fontName = "consolasPowerline"
  curl -L -o "$dot\tmp\$fontName.zip" `
    "https://github.com/eugeneching/consolasPowerlineVim/zipball/master"
  Extract-Archive "$dot\tmp\$fontName.zip" "$dot\tmp\$fontName"
  Remove-Item "$dot\tmp\$fontName\*" -exclude *.ttf
  . "$dot\lib\PowerShell\Add-Font.ps1" -path "$dot\tmp\$fontName"
  Remove-Temp

  if (!(Has-Font $consolasPowerlineFiles))
  {
    Write-Warning "Failed to install Consolas for Powerline"
    Break
  }
}

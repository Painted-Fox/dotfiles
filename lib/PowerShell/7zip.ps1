# Provides functions for using 7zip.

# Find the command line version of 7zip
$7z = @(Join-Path $env:ProgramFiles "7-Zip\7z.exe")
if (${Env:ProgramFiles(x86)}) {
  $gitCmdDirs += Join-Path ${Env:ProgramFiles(x86)} "7-Zip\7z.exe"
}

foreach ($cmd in $7z) {
  if (Test-Path $cmd)
  {
    $7z = $cmd
    Break
  }
}

if (!(Test-Path $7z))
{
  Write-Warning "Could not find 7-zip.  Please install it from www.7-zip.org."
}

Function Extract-Archive
{
  Param (
    [Parameter(Mandatory = $True)]
    [string] $archive,
    [string] $outputDirectory
  )

  if ($outputDirectory) {
    cmd /c "$7z" e $archive -y "-o$outputDirectory"
  } else {
    cmd /c "$7z" e $archive -y
  }
}
